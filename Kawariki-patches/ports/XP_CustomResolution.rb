#===============================================================================
# Custom Resolution
# Authors: ForeverZer0, KK20
# Version: 0.96b
# Date: 11.15.2013
#===============================================================================
# MKXP Port
# Authors: Taeyeon Mori
# Date: 01/30/2022
#
# Includes tilemap texture size workaround
Preload.require 'XP_TilemapOverrideLib.rb'
#===============================================================================
# KK20's Notes
#===============================================================================
# Introduction:
#
#   This script is intended to create screen resolutions other than 640 x 480.
#   The script comes with its own Tilemap rewrite in order to combat larger
#   screen resolutions (because anything beyond 640 x 480 is not drawn).
#
# Instructions:
#
#   Place script above 'Main'. Probably best to put it below all your other
#   custom scripts.
#   You will also need 'screenshot.dll' included in your project. You can find
#   that in Fantasist's Transitions Pack linked below.
#
# Things to Consider:
#
#  - Fullscreen will change the resolution back to 640 x 480. A solution is in
#    the works.
#  - Transitions do not work properly on larger resolutions. You can use a
#    Transitions Add-Ons script if you want better transitions (otherwise, all
#    you will get is the default fade in/out). Links listed below.
#  - Custom scripts that draw windows to the screen will most likely need edits.
#  - Larger resolutions = more processing power = more lag
#
#  ***************************************************************************  
#  * THIS IS STILL A WORK IN PROGRESS; IF YOU FIND ANYTHING PLEASE REPORT IT *
#  ***************************************************************************  
#
#  Links:
#  - Fantasist's Transitions Pack (w/ screenshot.dll)
#    http://forum.chaos-project.com/index.php/topic,1390.0.html
#  - ForeverZer0's Add-ons
#    http://forum.chaos-project.com/index.php/topic,7862.0.html
#  - ThallionDarkshine's Add-ons
#    http://forum.chaos-project.com/index.php/topic,12655.0.html
#  - Drago Transition Pack
#    http://forum.chaos-project.com/index.php/topic,13488.0.html
#
#===============================================================================
# ForeverZer0's Notes from v0.93                   (outdated information)
#===============================================================================
# Introduction:
#
#   My goal in creating this script was to create a system that allowed the user
#   to set the screen size to something other than 640 x 480, but not have make
#   huge sacrifices in compatibility and performance. Although the script is
#   not simply Plug-and-Play, it is about as close as one can achieve with a
#   script of this nature.
#
# Instructions:
#
#  - Place the "screenshot.dll" from Fantasist's Transition Pack script, which
#    can be found here: http://www.sendspace.com/file/yjd54h in your game folder
#  - Place this script above main, below default scripts.
#  - In my experience, unchecking "Reduce Screen Flickering" actually helps the
#    screen not to flicker. Open menu with F1 while playing and set this to what
#    you get the best results with.
#
# Features:
#  
#  - Totally re-written Tilemap and Plane class. Both classes were written to
#    display the map across any screen size automatically. The Tilemap class
#    is probably even more efficient than the original, which will help offset
#    any increased lag due to using a larger screen size with more sprites
#    being displayed.
#  - Every possible autotile graphic (48 per autotile) will be cached for the
#    next time that tile is used.
#  - Autotile animation has been made as efficient as possible, with a system
#    that stores their coodinates, but only if they change. This greatly reduces
#    the number of iterations at each update.
#  - System creates an external file to save pre-cached data priorities and
#    autotiles. This will decrease any loading times even more, and only takes a
#    second, depending on the number of maps you have.
#  - User defined autotile animation speed. Can change with script calls.
#  - Automatic re-sizing of Bitmaps and Viewports that are 640 x 480 to the
#    defined resolution, unless explicitely over-ridden in the method call.
#    The graphics themselves will not be resized, but any existing scripts that
#    use the normal screen size will already be configured to display different
#    sizes of graphics for transitions, battlebacks, pictures, fogs, etc.
#  - Option to have a log file ouput each time the game is ran, which can alert
#    you to possible errors with map sizes, etc.
#
# Issues/Bugs/Possible Bugs:
#
#   - Graphic related scripts and your graphics will need to be customized to
#     fit the new screen size, so this script is not for everyone.
#   - The Z-axis for the Plane class, which is used for Fogs and Panoramas has
#     been altered. It is now multiplied by 1000. This will likely be a minor
#     issue for most, since this class is very rarely used except for Fogs and
#     Panoramas, which are already far above and below respectfully.
#   - Normal transitions using graphics cannot be used. With the exception of
#     a standard fade, like that used when no graphic is defined will be used.
#     Aside from that, only special transitions from Transition Pack can be
#     used.
#===============================================================================
#  Credits/Thanks:
#    - ForeverZer0, for script.
#    - Creators of the Transition Pack and Screenshot.dll
#    - Selwyn, for base resolution script
#    - KK20, for Version 0.94 and above and the Tilemap class
#===============================================================================
#                             CONFIGURATION
#===============================================================================
# FIXME: need to exfiltrate this in the preload patch process

SCREEN = [1024, 576]
# Define the resolution of the game screen. These values can be anything
# within reason. Centering, viewports, etc. will all be taken care of, but it
# is recommended that you use values divisible by 32 for best results.

UPDATE_COUNT = 8
# Define the number of frames between autotile updates. The lower the number,
# the faster the animations cycle. This can be changed in-game with the
# following script call: $game_map.autotile_speed = SPEED

RESOLUTION_LOG = true
# This will create a log in the Game directory each time the game is ran in
# DEBUG mode, which will list possible errors with map sizes, etc.

#===============================================================================
# ** Resolution
#===============================================================================

class Resolution
  
  attr_reader :version
  
  def initialize
    # Define version.
    @version = 0.96
    # Resize screen
    Graphics.resize_screen(SCREEN[0], SCREEN[1])
  end
  #--------------------------------------------------------------------------
  def size
    # Returns the screen size of the machine.
    # FIXME: available in MKXP?
    return [1920, 1080]
  end
  #--------------------------------------------------------------------------
  def snapshot(filename = 'Data/snap', quality = 0)
    # FILENAME =   Filename that the picture will be saved as.
    # FILETYPE =   0 = High Quality   1 = Low Quality (ignored)
    Graphics.screenshot(filename)
  end
  #--------------------------------------------------------------------------
end

#===============================================================================
# ** RPG::Cache
#===============================================================================

module RPG::Cache
  
  AUTO_INDEX = [
    [27,28,33,34],  [5,28,33,34],  [27,6,33,34],  [5,6,33,34],
    [27,28,33,12],  [5,28,33,12],  [27,6,33,12],  [5,6,33,12],
    [27,28,11,34],  [5,28,11,34],  [27,6,11,34],  [5,6,11,34],
    [27,28,11,12],  [5,28,11,12],  [27,6,11,12],  [5,6,11,12],
    [25,26,31,32],  [25,6,31,32],  [25,26,31,12], [25,6,31,12],
    [15,16,21,22],  [15,16,21,12], [15,16,11,22], [15,16,11,12],
    [29,30,35,36],  [29,30,11,36], [5,30,35,36],  [5,30,11,36],
    [39,40,45,46],  [5,40,45,46],  [39,6,45,46],  [5,6,45,46],
    [25,30,31,36],  [15,16,45,46], [13,14,19,20], [13,14,19,12],
    [17,18,23,24],  [17,18,11,24], [41,42,47,48], [5,42,47,48],
    [37,38,43,44],  [37,6,43,44],  [13,18,19,24], [13,14,43,44],
    [37,42,43,48],  [17,18,47,48], [13,18,43,48], [1,2,7,8]
  ]

  def self.autotile(filename)
    key = "Graphics/Autotiles/#{filename}"
    if !@cache.include?(key) || @cache[key].disposed?
      # Cache the autotile graphic.
      @cache[key] = (filename == '') ? Bitmap.new(128, 96) : Bitmap.new(key)
      # Cache each configuration of this autotile.
      new_bm = self.format_autotiles(@cache[key], filename)
      @cache[key].dispose
      @cache[key] = new_bm
    end
    return @cache[key]
  end

  def self.format_autotiles(bitmap, filename)
    if bitmap.height > 32
      frames = bitmap.width / 96
      template = Bitmap.new(256*frames,192)
      # Create a bitmap to use as a template for creation.
      (0..frames-1).each{|frame|
      (0...6).each {|i| (0...8).each {|j| AUTO_INDEX[8*i+j].each {|number|
      number -= 1
      x, y = 16 * (number % 6), 16 * (number / 6)
      rect = Rect.new(x + (frame * 96), y, 16, 16)
      template.blt((32 * j + x % 32) + (frame * 256), 32 * i + y % 32, bitmap, rect)
      }}}}
      return template
    else
      return bitmap
    end
  end
end

#===============================================================================
# ** Tilemap_DataTable
#===============================================================================
class Tilemap_DataTable
  attr_accessor :updates
  attr_accessor :table
  def initialize(table)
    @table = table
    @updates = []
  end
  
  def updated
    return @updates.size >= 1
  end
  
  def [](x,y=nil,z=nil)
    return @table[x,y,z] unless z.nil?
    return @table[x,y] unless y.nil?
    return @table[x]
  end
  
  def []=(x,y,z=nil,t_id=nil)
    @updates.push([x,y,z,t_id]) unless t_id.nil?
    t_id.nil? ? (z.nil? ? @table[x] = y : @table[x,y] = z) : @table[x,y,z] = t_id
  end
  
  def xsize; return @table.xsize; end
  def ysize; return @table.ysize; end
  def zsize; return @table.zsize; end
  
  def resize(x,y=nil,z=nil); @table.resize(x,y,z); end
end

#===============================================================================
# ** Tilemap
#===============================================================================

class Tilemap
  
  attr_reader   :tileset, :map_data, :ox, :oy, :viewport
  attr_accessor :autotiles, :priorities

  # +++ MKXP +++
  def tileset=(value)
    # Need to wrap tilesets that don't fit into texture
    if value.mega?
      @tileset = TileWrap::wrapTileset(value)
      value.dispose
    else
      @tileset = value
    end
  end
  
  def initialize(viewport)
    # Initialize instance variables to store required data.
    @viewport, @autotiles, @tile_sprites, @ox, @oy = viewport, [], [], 0, 0
    @current_frame, @total_frames = [], []
    @tilemap_drawn = false
    @ox_oy_set = [false, false]
    # Get priority data for this tileset from instance of Game_Map.
    @priorities = $game_map.priorities
    # Holds all the Sprite instances of animating tiles (keys based on tile's ID)
    @animating_tiles = {}
    # Game map's x/y location of the top left corner tile
    @corner_tile_loc = [-1,-1]
  end

  #-----------------------------------------------------------------------------
  # Initialize all tile sprites. Draws three sprites per (x,y).
  #-----------------------------------------------------------------------------
  def init_tiles
    # Determine how many frames of animation this autotile has
    for i in 0..6
      bm = @autotiles[i]
      if bm.nil?
        @total_frames = 1
      elsif bm.height > 32
        @total_frames[i] = bm.width / 256
      else
        @total_frames[i] = bm.width / 32
      end
      @current_frame[i] = 0
    end
    # Turn on flag that the tilemap sprites have been initialized
    @tilemap_drawn = true
    
    @animating_tiles.clear
    # Create a sprite and viewport to use for each priority level.
    (0...((SCREEN[0]/32+2) * (SCREEN[1]/32+2))*3).each{|i|
      @tile_sprites[i/3] = [] if @tile_sprites[i/3].nil?
      @tile_sprites[i/3][i%3] = Sprite.new(@viewport) unless @tile_sprites[i/3][i%3].is_a?(Sprite)
      # Rename to something shorter and easier to work with for below
      tile = @tile_sprites[i/3][i%3]
      # Assign tile's respective ID value
      tile.tile_sprite_id = i
      # Draw sprite at index location (ex. ID 0 should always be the top-left sprite)
      tile.x = (i % ((SCREEN[0]/32+2)*3) / 3 * 32) - 32 + (@ox % 32)
      tile.y = (i / ((SCREEN[0]/32+2)*3) * 32) - 32 + (@oy % 32)
      
      map_x, map_y = (tile.x+@ox)/32, (tile.y+@oy)/32
      @corner_tile_loc = [map_x, map_y] if i == 0
      # If the tile happens to be drawn along the outside borders of the map
      if map_x < 0 || map_x >= $game_map.width || map_y < 0 || map_y >= $game_map.height
        update_tile_id tile, 0
      else # Tile is actually on the map
        update_tile_id tile, @map_data[map_x, map_y, i%3]
      end
    }
    # Sprite ID located at top left corner (ranges from 0..map_width * map_height
    @corner_index = 0
  end

  # Common code for setting the tile by id
  def update_tile_id(tile, tile_id)
    if tile_id == 0 # empty tile
      tile.z = 0
      tile.bitmap = RPG::Cache.picture('')#@tileset
      tile.src_rect.set(0,0,0,0)
      return
    end
    if @priorities[tile_id] == 0
      tile.z = 0
    else
      tile.z = tile.y + @priorities[tile_id] * 32 + 32
    end
    if tile_id >= 384 # non-autotile
      tile.bitmap = @tileset
      tile.src_rect.set(((tile_id - 384) % 8) * 32,
                        ((tile_id - 384) / 8) * 32,
                        32, 32)
      # Fix rect for possibly wrapped tileset
      TileWrap.wrapRect! tile.src_rect
    else # autotile
      auto_id = tile_id/48-1
      tile.bitmap = @autotiles[auto_id]
      tile.src_rect.set(((tile_id % 48) % 8) * 32 + @current_frame[auto_id] * 256,
                        ((tile_id % 48) / 8) * 32,
                        32, 32)
      @animating_tiles[tile.tile_sprite_id] = tile if @total_frames[auto_id] > 1
    end
  end

  #-----------------------------------------------------------------------------
  # Makes update to ox and oy. Sprites out of range will be moved based on these
  # two values.
  #-----------------------------------------------------------------------------
  def ox=(ox)
    #
    unless @tilemap_drawn
      @ox = ox
      @ox_oy_set[0] = true
      return
    end
    
    return if @ox == ox
    # Shift all tiles left or right by the difference
    shift = @ox - ox
    
    @tile_sprites.each {|set| set.each{|tile| tile.x += shift }}
    @ox = ox
    # Determine if columns need to be shifted
    col_num = @corner_index
    #return unless @tile_sprites[col_num][0].x <= -49 || @tile_sprites[col_num][0].x >= -17
    while @tile_sprites[col_num][0].x <= -49 || @tile_sprites[col_num][0].x >= -17
      
      @corner_tile_loc[0] += (shift < 0 ? 1 : -1)
      modTileId = ((SCREEN[0]+64)*(SCREEN[1]+64))/1024    
      # If new ox is greater than old ox
      if shift < 0
        # Move all sprites in left column to the right side and change bitmaps
        # and z-values
        (0...(SCREEN[1]/32+2)).each{|n|
          j = ((SCREEN[0]/32+2) * n + col_num) % modTileId
          @tile_sprites[j].each_index{|i|
            tile = @tile_sprites[j][i]
            @animating_tiles.delete(tile.tile_sprite_id)
            tile.x += 64 + SCREEN[0]
            
            map_x, map_y = (tile.x+@ox)/32, (tile.y+@oy)/32
            tile_id = @map_data[map_x,map_y,i]
            
            if tile_id.nil?
              tile.z = [map_y * 32, 0].max
              tile.bitmap = RPG::Cache.picture('')
              tile.src_rect.set(0,0,0,0)
              next
            end

            update_tile_id tile, tile_id
          }
        }
        # New corner should be the tile immediately right of the previous tile
        col_num /= SCREEN[0]/32+2
        col_num *= SCREEN[0]/32+2
        @corner_index = (@corner_index + 1) % (SCREEN[0]/32+2) + col_num
      else
        # Shift right column to the left
        # Gets the right column
        row_index = col_num / (SCREEN[0]/32+2)
        row_index *= (SCREEN[0]/32+2)
        col_num = (@corner_index - 1) % (SCREEN[0]/32+2) + row_index
        
        (0...(SCREEN[1]/32+2)).each{|n|
          j = ((SCREEN[0]/32+2) * n + col_num) % modTileId
          @tile_sprites[j].each_index{|i|
            tile = @tile_sprites[j][i]
            @animating_tiles.delete(tile.tile_sprite_id)
            tile.x -= 64 + SCREEN[0]
            
            map_x, map_y = (tile.x+@ox)/32, (tile.y+@oy)/32
            tile_id = @map_data[map_x,map_y,i]
            if tile_id.nil?
              tile.z = [map_y * 32, 0].max
              tile.bitmap = @tileset
              tile.src_rect.set(0,0,0,0)
              next
            end

            update_tile_id tile, tile_id
          }
        }
        col_num /= SCREEN[0]/32+2
        col_num *= SCREEN[0]/32+2
        @corner_index = (@corner_index - 1) % (SCREEN[0]/32+2) + col_num
      end
      col_num = @corner_index
    end #end of while
  end

#-----------------------------------------------------------------------------

  def oy=(oy)
    #
    unless @tilemap_drawn
      @oy = oy
      @ox_oy_set[1] = true
      return
    end
    
    return if @oy == oy
    # Shift all tiles up or down by the difference, and change z-value
    shift = @oy - oy
    
    @tile_sprites.each {|set| set.each{|tile| tile.y += shift; tile.z += shift unless tile.z == 0 }}
    @oy = oy
    # Determine if rows need to be shifted
    row_num = @corner_index
    #return unless @tile_sprites[row_num][0].y <= -49 || @tile_sprites[row_num][0].y >= -17
    while @tile_sprites[row_num][0].y <= -49 || @tile_sprites[row_num][0].y >= -17
      
      
      # Needed for resetting the new corner index much later.
      modTileId = ((SCREEN[0]+64)*(SCREEN[1]+64))/1024
      @corner_tile_loc[1] += (shift < 0 ? 1 : -1)
      # If new oy is greater than old oy
      if shift < 0
        row_num /= SCREEN[0]/32+2
        row_num *= SCREEN[0]/32+2
        # Move all sprites in top row to the bottom side and change bitmaps
        # and z-values
        (0...(SCREEN[0]/32+2)).each{|n|
          # Run through each triad of sprites from left to right
          j = n + row_num
          @tile_sprites[j].each_index{|i|
            # Get each individual tile on each layer
            tile = @tile_sprites[j][i]
            @animating_tiles.delete(tile.tile_sprite_id)
            tile.y += 64 + SCREEN[1]
            # Determine what map coordinate this tile now resides at...
            map_x, map_y = (tile.x+@ox)/32, (tile.y+@oy)/32
            # ...and get its tile_id
            tile_id = @map_data[map_x,map_y,i]
            # If no tile exists here (effectively out of array bounds)
            if tile_id.nil?
              tile.z = [map_y * 32, 0].max
              tile.bitmap = RPG::Cache.picture('')
              tile.src_rect.set(0,0,0,0)
              next
            end

            update_tile_id tile, tile_id
          }
        }
      
        @corner_index = (@corner_index + (SCREEN[0]/32+2)) % modTileId
      else
        row_num = (@corner_index - (SCREEN[0]/32+2)) % modTileId
        row_num /= SCREEN[0]/32+2
        row_num *= SCREEN[0]/32+2
        (0...(SCREEN[0]/32+2)).each{|n|
          # Run through each triad of sprites from left to right
          j = n + row_num
          @tile_sprites[j].each_index{|i|
            # Get each individual tile on each layer
            tile = @tile_sprites[j][i]
            @animating_tiles.delete(tile.tile_sprite_id)
            tile.y -= 64 + SCREEN[1]
            # Determine what map coordinate this tile now resides at...
            map_x, map_y = (tile.x+@ox)/32, (tile.y+@oy)/32
            # ...and get its tile_id
            tile_id = @map_data[map_x,map_y,i]
            # If no tile exists here (effectively out of array bounds)
            if tile_id.nil?
              tile.z = [map_y * 32, 0].max
              tile.bitmap = RPG::Cache.picture('')
              tile.src_rect.set(0,0,0,0)
              next
            end

            update_tile_id tile, tile_id
          }
        }
        @corner_index = (@corner_index - (SCREEN[0]/32+2)) % modTileId
      end
      row_num = @corner_index
    end # end of while
  end
  #-----------------------------------------------------------------------------
  # Dispose all the tile sprites
  #-----------------------------------------------------------------------------
  def dispose
    # Dispose all of the sprites
    @tile_sprites.each {|set| set.each{|tile| tile.dispose }}
    @tile_sprites.clear
    @animating_tiles.clear
  end
  #-----------------------------------------------------------------------------
  # Set map data
  #-----------------------------------------------------------------------------
  def map_data=(data)
    # Set the map data to new class
    if data.is_a?(Tilemap_DataTable)
      @map_data = data
    else
      @map_data = Tilemap_DataTable.new(data)
    end
    @map_data.table = @map_data.table.clone
    @map_data.updates = []
    
    @animating_tiles.clear
    @tilemap_drawn = false
  end
  #-----------------------------------------------------------------------------
  # Update the tile sprites; make changes to the map_data and update autotiles
  #-----------------------------------------------------------------------------
  def update
    # Can't update anything if the ox and oy have not yet been set
    return if @ox_oy_set != [true, true]
    # If the tilemap sprites have not been initialized, GO DO IT
    if !@tilemap_drawn
      init_tiles
    end
    
    # If made any changes to $game_map.data, the proper graphics will be drawn
    if @map_data.updated
      @map_data.updates.each{|item|
        x,y,z,tile_id = item
        # If this changed tile is visible on screen
        if x.between?(@corner_tile_loc[0], @corner_tile_loc[0]+(SCREEN[0]/32 + 1)) and
          y.between?(@corner_tile_loc[1], @corner_tile_loc[1]+(SCREEN[1]/32 + 1))
          
          x_dif = x - @corner_tile_loc[0]
          y_dif = y - @corner_tile_loc[1]
          
          id = @corner_index + x_dif
          id -= SCREEN[0]/32+2 if id/(SCREEN[0]/32+2) > @corner_index/(SCREEN[0]/32+2)
          
          id += y_dif * (SCREEN[0]/32+2)
          id -= (SCREEN[0]/32+2)*(SCREEN[1]/32+2) if id >= (SCREEN[0]/32+2)*(SCREEN[1]/32+2)
          
          tile = @tile_sprites[id][z]
          @animating_tiles.delete(tile.tile_sprite_id)

          update_tile_id tile, tile_id
        end
      }
      @map_data.updates = []
    end

    # Update the sprites.
    if Graphics.frame_count % $game_map.autotile_speed == 0
      # Increase current frame of tile by one, looping by width.
      for i in 0..6
        @current_frame[i] = (@current_frame[i] + 1) % @total_frames[i]
      end
      @animating_tiles.each_value{|tile|
        frames = tile.bitmap.width
        tile.src_rect.set((tile.src_rect.x + 256) % frames, tile.src_rect.y, 32, 32)
      }
    end
  end
end

#===============================================================================
# Game_Map
#===============================================================================

class Game_Map
  
  attr_reader :tile_size, :autotile_speed, :autotile_data, :priority_data
  
  alias zer0_load_autotile_data_init initialize
  def initialize
    # Call original method.
    zer0_load_autotile_data_init
    # Store the screen dimensions in tiles to save on calculations later.
    @tile_size = [SCREEN[0], SCREEN[1]].collect {|n| (n / 32.0).ceil }
    @autotile_speed = UPDATE_COUNT
  end
  
  alias zer0_map_edge_setup setup
  def setup(map_id)
    # Call original method.
    zer0_map_edge_setup(map_id)
    # Change Map's data into a special Table class
    @map.data = Tilemap_DataTable.new(@map.data)
    # Find the displayed area of the map in tiles. No calcualting every step.
    @map_edge = [self.width - @tile_size[0], self.height - @tile_size[1]]
    @map_edge.collect! {|size| size * 128 }
  end
  
  def scroll_down(distance)
    # Find point that the map edge meets the screen edge, using custom size.
    @display_y = [@display_y + distance, @map_edge[1]].min
  end
  
  def scroll_right(distance)
    # Find point that the map edge meets the screen edge, using custom size.
    @display_x = [@display_x + distance, @map_edge[0]].min
  end
  
  def autotile_speed=(speed)
    # Keep the speed above 0 to prevent the ZeroDivision Error.
    @autotile_speed = speed
    @autotile_speed = 1 if @autotile_speed < 1
  end
  
end

#===============================================================================
# ** Game_Player
#===============================================================================

class Game_Player
  
  CENTER_X = ((SCREEN[0] / 2) - 16) * 4    # Center screen x-coordinate * 4
  CENTER_Y = ((SCREEN[1] / 2) - 16) * 4    # Center screen y-coordinate * 4
  
  def center(x, y)
    # Recalculate the screen center based on the new resolution.
    max_x = ($game_map.width - $game_map.tile_size[0]) * 128
    max_y = ($game_map.height - $game_map.tile_size[1]) * 128
    $game_map.display_x = [0, [x * 128 - CENTER_X, max_x].min].max
    $game_map.display_y = [0, [y * 128 - CENTER_Y, max_y].min].max
  end  
end

#===============================================================================
# ** Sprite
#===============================================================================
class Sprite
  attr_accessor :tile_sprite_id
  alias tile_sprite_id_init initialize
  def initialize(view = nil)
    # No defined ID
    @tile_sprite_id = nil
    # Call original method.
    tile_sprite_id_init(view)
  end
end

#===============================================================================
# ** Viewport
#===============================================================================
class Viewport
  
  alias zer0_viewport_resize_init initialize
  def initialize(x=0, y=0, width=SCREEN[0], height=SCREEN[1], override=false)
    if x.is_a?(Rect)
      # If first argument is a Rectangle, just use it as the argument.
      zer0_viewport_resize_init(x)
    elsif [x, y, width, height] == [0, 0, 640, 480] && !override
      # Resize fullscreen viewport, unless explicitly overridden.
      zer0_viewport_resize_init(Rect.new(0, 0, SCREEN[0], SCREEN[1]))
    else
      # Call method normally.
      zer0_viewport_resize_init(Rect.new(x, y, width, height))
    end
  end
  
  def resize(*args)
    # Resize the viewport. Can call with (X, Y, WIDTH, HEIGHT) or (RECT).
    self.rect = args[0].is_a?(Rect) ? args[0] : Rect.new(*args)
  end
end

#===============================================================================
# ** Plane
#===============================================================================

# class Plane < Sprite
  
#   def z=(z)
#     # Change the Z value of the viewport, not the sprite.
#     super(z * 1000)
#   end
  
#   def ox=(ox)
#     return if @bitmap == nil
#     # Have viewport stay in loop on X-axis.
#     super(ox % @bitmap.width)
#   end
  
#   def oy=(oy)
#     return if @bitmap == nil
#     # Have viewport stay in loop on Y-axis.
#     super(oy % @bitmap.height)
#   end
  
#   def bitmap
#     # Return the single bitmap, before it was tiled.
#     return @bitmap
#   end
  
#   def bitmap=(tile)
#     @bitmap = tile
#     # Calculate the number of tiles it takes to span screen in both directions.
#     xx = 1 + (SCREEN[0].to_f / tile.width).ceil
#     yy = 1 + (SCREEN[1].to_f / tile.height).ceil
#     # Create appropriately sized bitmap, then tile across it with source image.
#     plane = Bitmap.new(@bitmap.width * xx, @bitmap.height * yy)
#     (0..xx).each {|x| (0..yy).each {|y|
#       plane.blt(x * @bitmap.width, y * @bitmap.height, @bitmap, @bitmap.rect)
#     }}
#     # Set the bitmap to the sprite through its super class (Sprite).
#     super(plane)
#   end
  
#   # Redefine methods dealing with coordinates (defined in super) to do nothing.
#   def x; end
#   def y; end
#   def x=(x); end
#   def y=(y); end
# end
#===============================================================================
# ** Integer
#===============================================================================

class Integer
  
  def gcd(num)
    # Returns the greatest common denominator of self and num.
    min, max = self.abs, num.abs
    while min > 0
      tmp = min
      min = max % min
      max = tmp
    end
    return max
  end
  
  def lcm(num)
    # Returns the lowest common multiple of self and num.
    return [self, num].include?(0) ? 0 : (self / self.gcd(num) * num).abs
  end
end

#===============================================================================
# ** Resolution Log
#===============================================================================
if RESOLUTION_LOG
  undersize, mapinfo = [], load_data('Data/MapInfos.rxdata')
  # Create a text file and write the header.
  file = File.open('Resolution Log.txt', 'wb')
  file.write("[RESOLUTION LOG]\r\n\r\n")
  time = Time.now.strftime("%x at %I:%M:%S %p")
  file.write("  Logged on #{time}\r\n\r\n")
  lcm = SCREEN[0].lcm(SCREEN[1]).to_f
  aspect = [(lcm / SCREEN[1]), (lcm / SCREEN[0])].collect {|num| num.round }
  file.write("RESOLUTION:\r\n  #{SCREEN[0].to_i} x #{SCREEN[1].to_i}\r\n")
  file.write("ASPECT RATIO:\r\n  #{aspect[0]}:#{aspect[1]}\r\n")
  file.write("MINIMUM MAP SIZE:\r\n  #{(SCREEN[0] / 32).ceil} x #{(SCREEN[1] / 32).ceil}\r\n\r\n")
  file.write("UNDERSIZED MAPS:\r\n")
  mapinfo.keys.each {|key|
    map = load_data(sprintf("Data/Map%03d.rxdata", key))
    next if map.width*32 >= SCREEN[0] && map.height*32 >= SCREEN[1]
    undersize.push(key)
  }
  unless undersize.empty?
    file.write("The following maps are too small for the defined resolution. They should be adjusted to prevent graphical errors.\r\n\r\n")
    undersize.sort.each {|id| file.write("    MAP[#{id}]:  #{mapinfo[id].name}\r\n") }
    file.write("\r\n")
  else
    file.write('    All maps are sized correctly.')
  end
  file.close
end

# Call the resolution, setting it to a global variable for plug-ins.
$resolution = Resolution.new