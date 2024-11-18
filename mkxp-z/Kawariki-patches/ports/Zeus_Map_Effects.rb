# Map Effects v1.4.1 for VX and VXace by Zeus81
# €30 for commercial use
# Licence : http://creativecommons.org/licenses/by-nc-nd/4.0/
# Contact : zeusex81@gmail.com
# (fr) Manuel d'utilisation : https://www.dropbox.com/s/lb1d3q9jmx53taf/Map%20Effects%20Doc%20Fr.txt
# (en) User Guide           : https://www.dropbox.com/s/sk3uwq2bleoxr7s/Map%20Effects%20Doc%20En.txt
#      Demo : https://www.dropbox.com/s/2ex6906dyehl7an/Map%20Effects.zip

$imported ||= {}
$imported[:Zeus_Map_Effects] = __FILE__

def xp?() false end ; def vx?() false end ; def vxace?() false end
  RUBY_VERSION == '1.8.1' ? defined?(Hangup) ?
  def xp?() true  end : def vx?() true  end : def vxace?() true  end

    class << Graphics
      def snap_elements_to_bitmap(*elements)
        if !@snap_elements_back or @snap_elements_back.disposed?
          @snap_elements_back = Sprite.new
          @snap_elements_back.bitmap = Bitmap.new(1, 1)
          @snap_elements_back.bitmap.set_pixel(0, 0, Color.new(0, 0, 0))
          @snap_elements_back.z = 0x0FFF_FFFF
        end
        @snap_elements_back.zoom_x = width
        @snap_elements_back.zoom_y = height
        @snap_elements_back.visible = true
        elements.each {|element| element.z += 0x1FFF_FFFF}
        bmp = snap_to_bitmap rescue retry
        @snap_elements_back.visible = false
        elements.each {|element| element.z -= 0x1FFF_FFFF}
        return bmp
      end
    end

    module Math
      module_function
      def min(x, y) x < y ? x : y end
        def max(x, y) x < y ? y : x end
          def middle(min, x, max) x < max ? x < min ? min : x : max end
          end

          module Zeus
            module Animation
              def animate(variable, target_value, duration=0, ext=nil)
                @za_animations ||= {}
                base_value = Marshal.load(Marshal.dump(instance_variable_get(variable)))
                if duration < 1
                  update_animation_value(variable, base_value, target_value, 1, 1, ext)
                  @za_animations.delete(variable)
                else
                  @za_animations[variable] = [base_value, target_value, 0, duration.to_i, ext]
                end
              end
              def animating?
                @za_animations and !@za_animations.empty?
              end
              def clear_animations
                @za_animations and @za_animations.clear
              end
              def memorize_animations(variables = instance_variables)
                data = {}
                variables.each {|var| data[var.to_sym] = instance_variable_get(var)}
                data.delete(:@za_memorize)
                @za_memorize = Marshal.dump(data)
              end
              def restore_animations
                return unless @za_memorize
                Marshal.load(@za_memorize).each {|var,value| instance_variable_set(var,value)}
              end
              def update_animations
                return unless @za_animations
                @za_animations.delete_if do |variable, data|
                  data[2] += 1
                  update_animation_value(variable, *data)
                  data[2] == data[3]
                end
              end
              private
              def calculate_next_value(base_value, target_value, duration, duration_total)
                base_value + (target_value - base_value) * duration / duration_total
              end
              def update_animation_value(variable, base_value, target_value, duration, duration_total, ext)
                method_name = "update_animation_variable_#{variable.to_s[1..-1]}"
                method_name = "update_animation_#{base_value.class}" unless respond_to?(method_name)
                send(method_name, variable, base_value, target_value, duration, duration_total, ext)
              end
              def update_animation_Color(variable, base_value, target_value, duration, duration_total, ext)
                value = instance_variable_get(variable)
                value.red   = calculate_next_value(base_value.red  , target_value.red  , duration, duration_total)
                value.green = calculate_next_value(base_value.green, target_value.green, duration, duration_total)
                value.blue  = calculate_next_value(base_value.blue , target_value.blue , duration, duration_total)
                value.alpha = calculate_next_value(base_value.alpha, target_value.alpha, duration, duration_total)
              end
              def update_animation_Tone(variable, base_value, target_value, duration, duration_total, ext)
                value = instance_variable_get(variable)
                value.red   = calculate_next_value(base_value.red  , target_value.red  , duration, duration_total)
                value.green = calculate_next_value(base_value.green, target_value.green, duration, duration_total)
                value.blue  = calculate_next_value(base_value.blue , target_value.blue , duration, duration_total)
                value.gray  = calculate_next_value(base_value.gray , target_value.gray , duration, duration_total)
              end
              def update_animation_Float(variable, base_value, target_value, duration, duration_total, ext)
                value = calculate_next_value(base_value, target_value, duration, duration_total)
                instance_variable_set(variable, value)
              end
              alias update_animation_Fixnum update_animation_Float
              alias update_animation_Bignum update_animation_Float
            end
          end

          class Game_Map_Effects
            include Zeus::Animation
            attr_accessor :active, :refresh_rate, :back, :x, :y, :ox, :oy, :angle,
                :zoom_x, :zoom_y, :mirror, :opacity, :blend_type, :color, :tone,
                :hue, :wave_amp, :wave_length, :wave_speed, :wave_phase,
                :pixelize, :blur_division, :blur_fade, :blur_animation,
                :gaussian_blur_length, :linear_blur_angle, :linear_blur_length,
                :radial_blur_angle, :zoom_blur_length, :motion_blur_rate
            def initialize
              @active = true
              @refresh_rate = 30.0
              clear
            end
            def clear
              @back = false
              @x = @ox = Graphics.width  / 2
              @y = @oy = Graphics.height / 2
              @zoom_x = 1.0
              @zoom_y = 1.0
              @zoom2 = Math.sqrt(100.0)
              @angle = 0.0
              @wave_amp = 0.0
              @wave_length = 180
              @wave_speed = 360
              @wave_phase = 0.0
              @mirror = false
              @opacity = 255
              @blend_type = 0
              @color ||= Color.new(0, 0, 0, 0)
              @color.set(0, 0, 0, 0)
              @tone ||= Tone.new(0, 0, 0, 0)
              @tone.set(0, 0, 0, 0)
              @hue = 0
              @pixelize = 1.0
              @pixelize2 = Math.sqrt(100.0)
              @blur_division = 4.0
              @blur_fade = 1.0
              @blur_animation = 0.0
              @gaussian_blur_length = 0.0
              @linear_blur_angle = 0.0
              @linear_blur_length = 0.0
              @radial_blur_angle = 0.0
              @zoom_blur_length = 0.0
              @motion_blur_rate = 0.0
              clear_animations
            end
            alias memorize memorize_animations
            alias restore  restore_animations
            alias update   update_animations
            def active?
              return false unless @active
              animating? or blur? or @mirror or @blend_type != 0 or
                  @zoom_x != 1 or @zoom_y != 1 or @pixelize > 1 or
                  @angle % 360 != 0 or @hue.to_i % 360 != 0 or @color.alpha != 0 or
                  @tone.red != 0 or @tone.green != 0 or @tone.blue != 0 or @tone.gray != 0 or
                  (@wave_amp * @zoom_x >= 1 and @wave_length * @zoom_y >= 1)
            end
            def blur?
              return false if @blur_division < 1
              @gaussian_blur_length != 0 or @linear_blur_length != 0 or
                  @radial_blur_angle != 0 or @zoom_blur_length != 0 or @motion_blur_rate != 0
            end
            def refresh_bitmap?
              @refresh_rate > 0 and
                  Graphics.frame_count % (Graphics.frame_rate / @refresh_rate.to_f) < 1
            end
            def tilemap_wave_sync(tilemap_oy)
              return 0 if @wave_length == 0
              tilemap_oy * @wave_speed / @wave_length.to_f
            end
            def blur_animation_offset
              return 0 if @blur_animation == 0
              1 - @blur_animation * Graphics.frame_count / Graphics.frame_rate.to_f % 1
            end
            def refresh_motion_blur?
              @blur_division >= 1 and @motion_blur_rate > 0 and
                  Graphics.frame_count % @motion_blur_rate < 1
            end
            def set_origin(x, y, duration=0)
              x = x * Graphics.width  / 100
              y = y * Graphics.height / 100
              animate(:@x , x, duration)
              animate(:@y , y, duration)
              animate(:@ox, x, duration)
              animate(:@oy, y, duration)
            end
            def set_zoom(zoom, duration=0, center_on_player=true)
              zoom = Math.sqrt(Math.max(1, zoom))
              animate(:@zoom2, zoom, duration, center_on_player)
            end
            def update_animation_variable_zoom2(variable, base_value, target_value, duration, duration_total, center_on_player)
              update_animation_Float(variable, base_value, target_value, duration, duration_total, nil)
              @zoom_y = @zoom_x = @zoom2 ** 2 / 100.0
              display_ratio = Game_Map::DisplayRatio.to_f
              if center_on_player
                x = $game_player.real_x / display_ratio
                y = $game_player.real_y / display_ratio
              else
                x = $game_map.display_x / display_ratio + $game_map.screen_tile_x / 2
                y = $game_map.display_y / display_ratio + $game_map.screen_tile_y / 2
              end
              $game_player.center(x, y)
            end
            def set_angle(angle, duration=0)
              animate(:@angle, angle, duration)
            end
            def set_opacity(opacity, duration=0)
              opacity = opacity * 255 / 100
              animate(:@opacity, opacity, duration)
            end
            def set_color(red, green, blue, alpha, duration=0)
              animate(:@color, Color.new(red, green, blue, alpha), duration)
            end
            def set_tone(red, green, blue, gray, duration=0)
              animate(:@tone, Tone.new(red, green, blue, gray), duration)
            end
            def set_hue(hue, duration=0)
              animate(:@hue, hue, duration)
            end
            def set_wave(amp, length, speed, duration=0)
              animate(:@wave_amp   , amp   , duration)
              animate(:@wave_length, length, duration)
              animate(:@wave_speed , speed , duration)
            end
            def set_pixelize(pixelize, duration=0)
              pixelize = Math.sqrt(Math.max(100, pixelize))
              animate(:@pixelize2, pixelize, duration)
            end
            def update_animation_variable_pixelize2(variable, base_value, target_value, duration, duration_total, ext)
              update_animation_Float(variable, base_value, target_value, duration, duration_total, ext)
              @pixelize  = @pixelize2 ** 2 / 100.0
            end
            def setup_blur(division, fade, animation, duration=0)
              division = Math.middle(0, division, 16)
              animate(:@blur_division , division , duration)
              animate(:@blur_fade     , fade     , duration)
              animate(:@blur_animation, animation, duration)
            end
            def set_gaussian_blur(length, duration=0)
              animate(:@gaussian_blur_length, length, duration)
            end
            def set_linear_blur(angle, length, duration=0)
              animate(:@linear_blur_angle , angle , duration)
              animate(:@linear_blur_length, length, duration)
            end
            def set_radial_blur(angle, duration=0)
              animate(:@radial_blur_angle, angle, duration)
            end
            def set_zoom_blur(zoom, duration=0)
              length = Math.max(1, zoom) / 100.0 - 1
              animate(:@zoom_blur_length, length, duration)
            end
            def set_motion_blur(rate, duration=0)
              animate(:@motion_blur_rate, rate, duration)
            end
          end

          class Spriteset_Map_Effects
            Blur_Offset = [[0.7,0.7], [-0.7,-0.7], [-0.7,0.7], [0.7,-0.7],
                           [0,1], [0,-1], [1,0], [-1,0]]
            def initialize(*viewports)
              @map_viewports    = viewports
              @viewport         = Viewport.new(viewports[0].rect)
              @viewport.z       = viewports[0].z
              @viewport.visible = false
              @effects_sprites  = []
              @effects_bitmaps  = []
              @data             = $game_map.effects
            end
            def dispose(dispose_viewport=true)
              @effects_sprites.each {|sprite| sprite.dispose}
              @effects_sprites.clear
              @effects_bitmaps.each {|bitmap| bitmap.dispose if bitmap}
              @effects_bitmaps.clear
              @pixelize_bitmap.dispose if @pixelize_bitmap
              @pixelize_bitmap = nil
              @back_sprite.dispose if @back_sprite
              @back_sprite = nil
              if dispose_viewport
                @viewport.dispose
              else
                @viewport.visible = false
                @map_viewports.each {|viewport| viewport.visible = true}
              end
            end
            def update(tilemap_oy = 0)
              unless @data.active?
                dispose(false) if @viewport.visible
                return
              end
              @viewport.visible = true
              @motion_blur_refresh ||= @data.refresh_motion_blur?
              refresh_sprites
              if !@effects_bitmaps[0] or @data.refresh_bitmap?
                refresh_bitmaps
                refresh_pixelize
              end
              refresh_back
              wave_sync   = @data.tilemap_wave_sync(tilemap_oy)
              blur_offset = @data.blur_animation_offset
              @effects_sprites.each_with_index do |sprite, id|
                update_effects(sprite, id, wave_sync)
                update_pixelize(sprite) if @pixelize_bitmap
                update_blur(sprite, id, blur_offset) if id > 0
              end
              @data.wave_phase = @effects_sprites[0].wave_phase - wave_sync
            end
            def refresh_sprites
              n = (@data.blur? ? @data.blur_division.to_i+1 : 1) - @effects_sprites.size
              n.times {@effects_sprites << Sprite.new(@viewport)}
              (-n).times {@effects_sprites.pop.dispose}
            end
            def refresh_bitmaps
              n = (@data.motion_blur_rate == 0 ? 1 : @effects_sprites.size) - @effects_bitmaps.size
              n.times {@effects_bitmaps << nil}
              (-n).times {bmp = @effects_bitmaps.pop and bmp.dispose}
              @map_viewports.each {|viewport| viewport.visible = true}
              @effects_bitmaps.unshift(@effects_bitmaps.pop) if @motion_blur_refresh
              @effects_bitmaps[0].dispose if @effects_bitmaps[0]
              @effects_bitmaps[0] = Graphics.snap_elements_to_bitmap(*@map_viewports)
              @effects_bitmaps[0].hue_change(@data.hue % 360) if @data.hue.to_i % 360 != 0
              @map_viewports.each {|viewport| viewport.visible = false}
              @motion_blur_refresh = false
            end
            def refresh_pixelize
              if @data.pixelize > 1
                bmp = @effects_bitmaps[0]
                @pixelize_rect ||= Rect.new(0, 0, 0, 0)
                @pixelize_rect.width  = Math.max(1, bmp.width  / @data.pixelize)
                @pixelize_rect.height = Math.max(1, bmp.height / @data.pixelize)
                @pixelize_bitmap ||= Bitmap.new(bmp.width, bmp.height)
                @pixelize_bitmap.clear
                @pixelize_bitmap.stretch_blt(@pixelize_rect, bmp, bmp.rect)
              elsif @pixelize_bitmap
                @pixelize_bitmap.dispose
                @pixelize_bitmap = nil
              end
            end
            def refresh_back
              if @data.back
                @back_sprite ||= Sprite.new(@viewport)
                @back_sprite.bitmap = @effects_bitmaps[0]
              elsif @back_sprite
                @back_sprite.dispose
                @back_sprite = nil
              end
            end
            def update_effects(sprite, id, wave_sync)
              sprite.bitmap      = @effects_bitmaps[id] || @effects_bitmaps[0]
              sprite.x           = @data.x
              sprite.y           = @data.y
              sprite.z           = id + 1
              sprite.ox          = @data.ox
              sprite.oy          = @data.oy
              sprite.zoom_x      = @data.zoom_x
              sprite.zoom_y      = @data.zoom_y
              sprite.angle       = @data.angle % 360
              sprite.wave_amp    = @data.wave_amp    * @data.zoom_x
              sprite.wave_length = @data.wave_length * @data.zoom_y
              sprite.wave_speed  = @data.wave_speed  * @data.zoom_y
              sprite.wave_phase  = @data.wave_phase + wave_sync
              sprite.mirror      = @data.mirror
              sprite.opacity     = @data.opacity
              sprite.blend_type  = @data.blend_type
              sprite.color       = @data.color
              sprite.tone        = @data.tone
              sprite.update
            end
            def update_pixelize(sprite)
              pzx             = @pixelize_bitmap.width  / @pixelize_rect.width.to_f
              pzy             = @pixelize_bitmap.height / @pixelize_rect.height.to_f
              sprite.bitmap   = @pixelize_bitmap
              sprite.src_rect = @pixelize_rect
              sprite.x       -= sprite.ox - (sprite.ox /= pzx).to_i * pzx
              sprite.y       -= sprite.oy - (sprite.oy /= pzy).to_i * pzy
              sprite.zoom_x  *= pzx
              sprite.zoom_y  *= pzy
            end
            def update_blur(sprite, id, blur_offset)
              update_blur_opacity(sprite, id-blur_offset)
              update_gaussian_blur(sprite, id) if @data.gaussian_blur_length != 0
              update_linear_blur(sprite, id-blur_offset) if @data.linear_blur_length != 0
              update_radial_blur(sprite, id-blur_offset) if @data.radial_blur_angle != 0
              update_zoom_blur(sprite, id-blur_offset) if @data.zoom_blur_length != 0
            end
            def update_blur_opacity(sprite, id)
              sprite.opacity /= (id < 1 ? 2 : id+1) **
                      (1 + @data.blur_fade / (@data.blur_division*20.0))
            end
            def update_gaussian_blur(sprite, id)
              box, boy  = *Blur_Offset[(id-1)%8]
              offset    = ((id+3)/4) / ((@data.blur_division.to_i+3)/4).to_f *
                @data.gaussian_blur_length
              sprite.x += (offset.ceil * box).round
              sprite.y += (offset.ceil * boy).round
            end
            def update_linear_blur(sprite, id)
              radian    = @data.linear_blur_angle * Math::PI / 180
              offset    = id * @data.linear_blur_length / @data.blur_division.to_f
              sprite.x += offset * Math.cos( radian)
              sprite.y += offset * Math.sin(-radian)
            end
            def update_zoom_blur(sprite, id)
              zoom           = 1 + id * @data.zoom_blur_length / @data.blur_division.to_f
              sprite.zoom_x *= zoom
              sprite.zoom_y *= zoom
            end
            def update_radial_blur(sprite, id)
              sprite.angle += id * @data.radial_blur_angle / @data.blur_division.to_f
              sprite.angle %= 360
            end
          end

          class Game_Map
            if vx?
              def screen_tile_x() Graphics.width  / 32 end
                def screen_tile_y() Graphics.height / 32 end
                  DisplayRatio = 256
                else
                  DisplayRatio = 1
                end
                def zoom_ox
                  return 0 unless effects.active and effects.zoom_x > 1
                  (1 - 1 / effects.zoom_x) * screen_tile_x / 2
                end
                def zoom_oy
                  return 0 unless effects.active and effects.zoom_y > 1
                  (1 - 1 / effects.zoom_y) * screen_tile_y / 2
                end
                def limit_x(x)
                  ox  = zoom_ox
                  min = DisplayRatio * -ox
                  max = DisplayRatio * (width - screen_tile_x + ox)
                  x < max ? x < min ? min : x : max
                end
                def limit_y(y)
                  oy  = zoom_oy
                  min = DisplayRatio * -oy
                  max = DisplayRatio * (height - screen_tile_y + oy)
                  y < max ? y < min ? min : y : max
                end
                def set_display_x(x)
                  x = loop_horizontal? ? x % (width * DisplayRatio) : limit_x(x)
                  @parallax_x += x - @display_x if @parallax_loop_x or !loop_horizontal?
                  @display_x   = x
                end
                def set_display_y(y)
                  y = loop_vertical? ? y % (height * DisplayRatio) : limit_y(y)
                  @parallax_y += y - @display_y if @parallax_loop_y or !loop_vertical?
                  @display_y   = y
                end
                def set_display_pos(x, y)  set_display_x(x); set_display_y(y)   end
                  def scroll_down(distance)  set_display_y(@display_y + distance) end
                    def scroll_left(distance)  set_display_x(@display_x - distance) end
                      def scroll_right(distance) set_display_x(@display_x + distance) end
                        def scroll_up(distance)    set_display_y(@display_y - distance) end
                          def effects()              @effects ||= Game_Map_Effects.new    end
                            alias zeus_map_effects_update update
                            def update(*args)
                              zeus_map_effects_update(*args)
                              effects.update
                            end
                          end

                          class Game_Interpreter
                            def map_effects
                              $game_map.effects
                            end
                          end

                          class Game_Player
                            def center(x, y)
                              $game_map.set_display_pos(x*256-CENTER_X, y*256-CENTER_Y)
                            end
                          end if vx?

                          class Spriteset_Map
                            alias zeus_map_effects_update update
                            def update
                              zeus_map_effects_update
                              @map_effects ||= Spriteset_Map_Effects.new(@viewport1)
                              @map_effects.update(@tilemap.oy)
                            end
                            alias zeus_map_effects_dispose dispose
                            def dispose
                              zeus_map_effects_dispose
                              @map_effects.dispose
                            end
                          end

                          $imported[:Zeus_Weather_Viewport] ||= __FILE__
                          if $imported[:Zeus_Weather_Viewport] == __FILE__

                            class Spriteset_Map
                              alias zeus_weather_viewport_create_weather create_weather
                              def create_weather
                                zeus_weather_viewport_create_weather
                                @weather.weather_viewport = @viewport1
                              end
                            end

                            class Spriteset_Weather
                              if vx?
                                def weather_viewport=(viewport)
                                  for sprite in @sprites
                                    sprite.viewport = viewport
                                    sprite.z = 0x8000
                                  end
                                end
                              else
                                attr_accessor :weather_viewport
                                alias zeus_weather_viewport_add_sprite add_sprite
                                def add_sprite
                                  zeus_weather_viewport_add_sprite
                                  @sprites[-1].viewport = @weather_viewport
                                  @sprites[-1].z = 0x8000
                                end
                              end
                            end

                          end
