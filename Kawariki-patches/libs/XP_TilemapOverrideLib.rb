# ======================================================================
# MKXP-Z Custom tilemap workaround tools
#
# Authors: Roza, Taeyeon Mori
#
# Contains library code only, must be added to custom
# tilemap classes using a preload patch or similar.
# ======================================================================
# SUPER TILEMAP VERTICAL WRAPPER THING
#
# This is a little fix for Pokemon Essentials' custom tilemap code
# that works around MKXP's GPU texture size limit that would normally
# stop you from playing a lot of games.
#
# The concept is simple enough: If your tileset is too big, a new
# bitmap will be constructed with all the excess pixels sent to the
# image's right side. This basically means that you now have a limit
# far higher than you should ever actually need.
#
# 1024  -> 4096
# 2048  -> 16384   (enough to get the normal limit)
# 4096  -> 65536   (enough to load pretty much any tileset)
# 8192  -> 262144
# 16384 -> 1048576 (what most people have at this point)
#
# Because of the extra math the game will have to do to find the right
# pixels, this will probably cause a slight performance hit while on these
# maps which would normally be megasurfaces.
#
# This script was written for games based on 17.1. This workaround is
# already implemented in 19.
#
#                             ~Roza/Zoroark
#=======================================================================

module TileWrap

  MAX_TEX_SIZE         = Bitmap.max_size
  TILESET_WIDTH        = 0x100
  MAX_TEX_SIZE_BOOSTED = MAX_TEX_SIZE**2/TILESET_WIDTH

  def self.clamp(val, min, max)
    val = max if val > max
    val = min if val < min
    return val
  end

  def self.wrapTileset(originalbmp)
    width = originalbmp.width
    height = originalbmp.height
    if width == TILESET_WIDTH && originalbmp.mega?
      columns = (height / MAX_TEX_SIZE.to_f).ceil
      
      if columns * TILESET_WIDTH > MAX_TEX_SIZE
        raise "Tilemap is too long!\n\nSIZE: #{originalbmp.height}px\nHARDWARE LIMIT: #{MAX_TEX_SIZE}px\nBOOSTED LIMIT: #{MAX_TEX_SIZE_BOOSTED}px"
      end
      bmp = Bitmap.new(TILESET_WIDTH*columns, MAX_TEX_SIZE)
      remainder = height % MAX_TEX_SIZE
      
      columns.times{|col|
        srcrect = Rect.new(0, col * MAX_TEX_SIZE, width, (col + 1 == columns) ? remainder : MAX_TEX_SIZE)
        bmp.blt(col*TILESET_WIDTH, 0, originalbmp, srcrect)
      }
      return bmp
    end

    return originalbmp
  end

  def self.wrapRect(srcrect)
    column, y = srcrect.y.divmod MAX_TEX_SIZE
    raise "Rect split across column wrap!" if y + srcrect.height > MAX_TEX_SIZE
    return srcrect if column == 0
    Rect.new(column * MAX_TEX_SIZE + srcrect.x, y, srcrect.width, srcrect.height)
  end

  def self.wrapRect!(rect)
    column, y = rect.y.divmod MAX_TEX_SIZE
    raise "Rect split across column wrap!" if y + rect.height > MAX_TEX_SIZE
    return if column == 0
    rect.x = column * MAX_TEX_SIZE + rect.x
    rect.y = y
  end

  def self.blitWrappedPixels(destX, destY, dest, src, srcrect)
    if (srcrect.y + srcrect.width < MAX_TEX_SIZE)
      # Save the processing power
      return dest.blt(destX, destY, src, srcrect)
    end
    merge = (srcrect.y % MAX_TEX_SIZE) > ((srcrect.y + srcrect.height) % MAX_TEX_SIZE)

    srcrect.x = clamp(srcrect.x, 0,TILESET_WIDTH)
    srcrect.width = clamp(srcrect.width, 0, TILESET_WIDTH - srcrect.x)
    col = (srcrect.y / MAX_TEX_SIZE.to_f).floor
    srcX = col * TILESET_WIDTH + srcrect.x
    srcY = srcrect.y % MAX_TEX_SIZE

    if !merge
      dest.blt(destX, destY, src, Rect.new(srcX, srcY, srcrect.width, srcrect.height))
    else
      #FIXME won't work on heights longer than two columns, but nobody should need
      # more than 32k pixels high at once anyway
      side = {:a => MAX_TEX_SIZE - srcY, :b => srcrect.height - (MAX_TEX_SIZE - srcY)}
      dest.blt(destX, destY, src, Rect.new(srcX, srcY, srcrect.width, side[:a]))
      dest.blt(destX, destY + side[:a], src, Rect.new(srcX + TILESET_WIDTH, 0, srcrect.width, side[:b]))
    end
  end

  # May be applied using Module#prepend
  # it's probably better to integrate custom tilemap code manually
  # XXX: is it OK to dispose of the original bitmaps?
  module TilemapPatch
    def tileset=(value)
      if value.mega?
        super TileWrap::wrapTileset value
        value.dispose
      else
        super value
      end
    end
  end

  module SpritePatch
    def bitmap=(bmp)
      if bmp.mega?
        super TileWrap.wrapTileset bmp
        bmp.dispose
      else
        super bmp
      end
    end
    def src_rect=(rect)
      super TileWrap.wrapRect rect
    end
  end
end
