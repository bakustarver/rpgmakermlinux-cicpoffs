=begin
  HN_Light version 1.0.1.2 for VX Ace
　　　　　　　　by 半生
http://www.tktkgame.com

  要HN_RG_BITMAP(ver 0.1.2.1以降)

2012/01/02 ver 1.0.1.2
　バグ修正
2012/01/02 ver 1.0.1.0
　隊列歩行の仲間に対応

=end

# ----- ▽ 設定ここから ▽ -----
module HN_Light
  # 簡略化 0:(メタボ)～2:(荒めだけど軽い)
  SIMPLIFY = 1
  
  # プレイヤーの灯りタイプに使う変数番号
  PLAYER_LIGHT_TYPE = 48

  # 仲間の灯りタイプに使う変数番号
  FOLLOWER_LIGHT_TYPE = 48
  
  # 暗闇判定に使うスイッチ
  DARK_SWITCH = 9
  
  # 灯りイベント識別用の正規表現
  REGEX_LIGHT = /＠灯り(\d+)/
  
  # 灯り画像のディレクトリ
  LIGHT_IMG_DIR = "Graphics/Pictures/"
  
  # 灯りBitmap設定
  LIGHTS = [ 
  # [FILENAME, CELLS, ZOOM, OFFSET_Y, HUE]
    ["light5",     1,  5.5,        0,   0],
    ["light5",     1,  15.0,        0,   0],
    ["light3",     1,  0.8,        0,   0],
    ["light4",     1,  1.0,      -16,   0],
    ["light5",     1,  2.0,        0,   0],
    ["light6",     1,  10.0,        0,   0],
    ["light7",     1,  5.0,      -16,   0],
    ["light8",     1,  5.0,      -16,   0],
    ["light9",     1,  2.0,      -16,   0],
    ["light4",     1,  3.0,      -16,   0],
  ]
end
# ----- △ 設定ここまで △ -----

module HN_Light
  # イベントへのmix-in用
  module LightEvent
    attr_reader :light_type
    def initialize
      super()
      @light_type = 0
    end
    
    def check_light
      @light_type = 0
      return if @list.nil?
      @list.each do |command|
        break if @light_type > 0
        if command.code == 108 or command.code == 408
          command.parameters.each do |line|
            if line =~ REGEX_LIGHT
              @light_type = $1.to_i
              break
            end
          end
        end
      end # END @list.each
    end
    
  end # END module LightEvent
  
  
  class Light
    attr_reader :bitmap
    attr_reader :cells
    attr_reader :width
    attr_reader :height
    attr_reader :ox
    attr_reader :oy
    def initialize(light_type, s_zoom = 1)
      light = LIGHTS[light_type - 1]
      if light.nil?
        # 本来ならここには来ないはず
        @bitmap = Bitmap.new(32, 32)
        @cels = 1
        @zoom = 1.0
        @oy = 16
        @ox = 16
        @width  = 32
        @height = 32
      else
        @bitmap = Bitmap.new(LIGHT_IMG_DIR + light[0])
        @bitmap.invert()
        @cells = light[1].to_i
        @cells = 1 if (@cells < 1 or @cells > @bitmap.width)
        @zoom = light[2].to_f
        @zoom = 1.0 if @zoom <= 0.0
        @zoom /= s_zoom
        @width  = @bitmap.width / @cells
        @height = @bitmap.height

        # 拡大縮小処理
        if @zoom != 1.0
          new_width  = (@width * @zoom).round
          new_height = (@height * @zoom).round
          if new_width * new_height < 1
            @zoom = 1.0
          else
            @width = new_width
            @height = new_height
            new_bitmap = Bitmap.new(@width * @cells, @height)
            new_bitmap.stretch_blt(new_bitmap.rect,@bitmap, @bitmap.rect)
            @bitmap.dispose
            @bitmap = new_bitmap
          end
        end
        @ox = @width / 2
        @oy = @height / 2 - light[3].to_i / s_zoom

        # 色相変換
        if ( (hue = light[4].to_i) != 0)
          @bitmap.hue_change(hue)
        end
      end
    end # End def initialize

    # 終了処理
    def dispose
      @bitmap.dispose
      @bitmap = nil
    end
  end

end

class Game_Event
  include HN_Light::LightEvent
  alias :_hn_light__setup :setup_page unless method_defined?(:_hn_light__setup)
  def setup_page(new_page)
    _hn_light__setup(new_page)
    check_light()
  end
end

class Game_Player
  def light_type
    return $game_variables[HN_Light::PLAYER_LIGHT_TYPE]
  end
end

class Game_Follower
  def light_type
    return 0 if !self.visible?
    return $game_variables[HN_Light::FOLLOWER_LIGHT_TYPE]
  end
end

class Game_Map
  attr_reader :light_events
  
  # 灯りイベントリストの更新
  def refresh_lights
    @light_events = []
    @events.values.each do |event|
      if (event.light_type > 0)
        @light_events.push(event)
      end
    end
  end

  alias :_hn_light__setup_events :setup_events unless method_defined?(:_hn_light__setup_events)
  def setup_events
    _hn_light__setup_events()
    refresh_lights()
  end
  
  alias :_hn_light__refresh :refresh unless method_defined?(:_hn_light__refresh)
  def refresh
    _hn_light__refresh()
    refresh_lights()
  end
end

class Sprite_Dark < Sprite
  @@base_color = Color.new(255,255,255)

  def initialize(viewport = nil)
    super(viewport)
    @width = Graphics.width
    @height = Graphics.height
    
    case HN_Light::SIMPLIFY
    when 1
      @zoom = 2
    when 2
      @zoom = 4
    else
      @zoom = 1
    end
    @width /= @zoom
    @height /= @zoom
    self.zoom_x = @zoom.to_f
    self.zoom_y = @zoom.to_f
    
    self.bitmap = Bitmap.new(@width, @height)
    self.bitmap.fill_rect(self.bitmap.rect, @@base_color)
    self.blend_type = 2 # ブレンドタイプ（減算）
    self.z = 500
    self.visible = false
    @light_cache = {}
  end

  # 灯りを追加する
  def add_light(charactor)
    return if charactor.nil?
    light_type = charactor.light_type
    return if (light_type < 1 or light_type > HN_Light::LIGHTS.size)
    unless @light_cache.key?(light_type)
      @light_cache[light_type] = HN_Light::Light.new(light_type, @zoom)
    end
    light = @light_cache[light_type]

    # 画面外の場合は何もしない
    if @zoom == 1
      return if (charactor.screen_x < 0  - light.width + light.ox)
      return if (charactor.screen_x > @width + light.ox)
      return if (charactor.screen_y < 0 - light.height + light.oy)
      return if (charactor.screen_y > @height + light.oy)
    else
      return if (charactor.screen_x < 0  - (light.width + light.ox) * @zoom)
      return if (charactor.screen_x > (@width + light.ox)  * @zoom)
      return if (charactor.screen_y < 0 - (light.height + light.oy) * @zoom)
      return if (charactor.screen_y > (@height + light.oy) * @zoom)
    end

    # アニメーション判定
    if light.cells > 1
      index = (Graphics.frame_count / 4) % light.cells
      rect = Rect.new(index * light.width , 0, light.width, light.height)
    else
      rect = light.bitmap.rect
    end
    if @zoom != 1
      p_x = charactor.screen_x / @zoom - light.ox
      p_y = (charactor.screen_y - 16) / @zoom - light.oy
    else
      p_x = charactor.screen_x - light.ox
      p_y = charactor.screen_y - 16 - light.oy
    end
    
    # 乗算合成(3)
    self.bitmap.blend_blt(p_x, p_y, light.bitmap, rect, 3)
  end

  
  def refresh
    self.bitmap.fill_rect(self.bitmap.rect, @@base_color)
    $game_map.light_events.each do |event|
      next if HN_Light::LIGHTS[event.light_type - 1].nil?
      add_light(event)
    end
    add_light($game_player)
    $game_player.followers.each{|f| add_light(f)}
  end
  
  # 更新
  def update
    super
    refresh()
  end
  
  #--------------------------------------------------------------------------
  # ● 解放
  #--------------------------------------------------------------------------
  def dispose
    self.bitmap.dispose
    @light_cache.values.each do |light|
      light.dispose
    end
    super
  end
end


class Spriteset_Map  
  # 暗闇スプライトの作成
  def create_dark
    @dark_sprite = Sprite_Dark.new(@viewport1)
  end

  # 暗闇スプライトの更新
  def update_dark
    if (@dark_sprite.visible = $game_switches[HN_Light::DARK_SWITCH])
      # @dark_sprite.update
      @dark_sprite.dispose
    end
  end

  # 暗闇スプライトの破棄
  def dispose_dark
    @dark_sprite.dispose
  end
  
  # 初期化
  alias :_dark__initialize :initialize unless private_method_defined?(:_dark__initialize)
  def initialize
    _dark__initialize()
    create_dark()
    update_dark()
  end
  
  # 更新
  alias :_dark__update :update unless method_defined?(:_dark__update)
  def update
    _dark__update()
    update_dark() if !@dark_sprite.nil? and !@dark_sprite.disposed?
  end
  
  # 終了処理
  alias :_dark__dispose :dispose unless method_defined?(:_dark__dispose)
  def dispose
    dispose_dark()
    _dark__dispose()
  end
end
