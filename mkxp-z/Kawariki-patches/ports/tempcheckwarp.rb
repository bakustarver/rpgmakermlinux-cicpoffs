#==============================================================================
# ■ NWConst::Warp
#==============================================================================
module NWConst::Warp
  AREA_SELECT_TEXT  = "Please select a region."
  PLACE_SELECT_TEXT = "Please select a location."
  CONFIRM_TEXT      = "Warping to %s. Is that okay?"
  MOVE_SE           = RPG::SE.new("Wind1")
  GROUND = :Surface
  HEAVEN = :Heaven
  HELL = :Hell
end

# 重複防止用ネームスペース
module Foo; module Warp; end; end

#==============================================================================
# ■ WarpManager
#==============================================================================
module WarpManager
  #--------------------------------------------------------------------------
  # ● 全ての場所情報配列の取得
  #--------------------------------------------------------------------------
  def self.all_places
    NWConst::Warp::Places
  end

  #--------------------------------------------------------------------------
  # ● 開放中の場所情報配列の取得
  #--------------------------------------------------------------------------
  def self.opend_places
    all_places.select do |place|
      $game_switches[NWConst::Sw::WARP_OPEN_BASE + place[:index]]
    end
  end

  #--------------------------------------------------------------------------
  # ● 開放中の場所情報配列の取得（カテゴリー集約）
  #--------------------------------------------------------------------------
  def self.opend_places_sort(category)
    opend_places.select { |place| place[:category] == category }
  end

  #--------------------------------------------------------------------------
  # ● ワープ使用可能？
  #--------------------------------------------------------------------------
  def self.usable?
    !($game_switches[NWConst::Sw::WARP_BAN] || opend_places.empty?)
  end

  #--------------------------------------------------------------------------
  # ● 地上だけしか開放されていない？
  #--------------------------------------------------------------------------
  def self.ground_only?
    open_area.size == 1
  end

  def self.open_area
    result = opend_places.map { |place| place[:category] }
    result.uniq
  end
end

#==============================================================================
# ■ Foo::Warp::Window_Help
#==============================================================================
class Foo::Warp::Window_Help < Window_Base
  #--------------------------------------------------------------------------
  # ● オブジェクト初期化
  #--------------------------------------------------------------------------
  def initialize
    super(0, 0, 320, fitting_height(1))
    @text = nil
  end

  #--------------------------------------------------------------------------
  # ● テキスト設定
  #--------------------------------------------------------------------------
  def set_text(text)
    if text != @text
      @text = text
      refresh
    end
  end

  #--------------------------------------------------------------------------
  # ● クリア
  #--------------------------------------------------------------------------
  def clear
    set_text("")
  end

  #--------------------------------------------------------------------------
  # ● リフレッシュ
  #--------------------------------------------------------------------------
  def refresh
    contents.clear
    draw_text_ex(4, 0, @text)
  end

  def update_help
    @help_window.set_text(NWConst::Warp::PLACE_SELECT_TEXT)
  end
end

#==============================================================================
# ■ Foo::Warp::Window_SelectArea
#==============================================================================
class Foo::Warp::Window_SelectArea < Window_HorzCommand
  def ok_enabled?
    false
  end

  #--------------------------------------------------------------------------
  # ● ウィンドウ幅の取得
  #--------------------------------------------------------------------------
  def window_width
    480
  end

  #--------------------------------------------------------------------------
  # ● 桁数の取得
  #--------------------------------------------------------------------------
  def col_max
    @list.size
  end

  #--------------------------------------------------------------------------
  # ● アライメントの取得
  #--------------------------------------------------------------------------
  def alignment
    1
  end

  #--------------------------------------------------------------------------
  # ● コマンドリストの作成
  #--------------------------------------------------------------------------
  def make_command_list
    WarpManager.open_area.each do |area|
      add_command(area.to_s, :ok, true, area)
    end
  end

  def update_help
    @help_window.set_text(NWConst::Warp::AREA_SELECT_TEXT) if @help_window
    @place_window.category = current_ext if @place_window
  end

  def place_window=(other)
    @place_window = other
    update_help
  end

  def category=(category)
    return if current_ext == category

    select_ext(category)
  end

  def cursor_up(wrap = false)
    return unless wrap

    call_handler(:cursor_up)
  end

  def cursor_down(wrap = false)
    return unless wrap

    call_handler(:cursor_down)
  end
end

class Foo::Warp::SelectHistory
  attr_reader :index

  def setup(place)
    @index = place[:index]
  end

  def category
    return NWConst::Warp::GROUND unless place

    place[:category]
  end

  def place
    return nil unless @index

    WarpManager.all_places[@index]
  end
end

#==============================================================================
# ■ Foo::Warp::Window_SelectPlace
#==============================================================================
class Foo::Warp::Window_SelectPlace < Window_Command
  def select_warp_history
    update_help
    hindex = $game_system.warp_history.index
    return unless hindex

    @list.each_index { |i| select(i) if @list[i][:ext] && @list[i][:ext][:index] == hindex }
  end

  #--------------------------------------------------------------------------
  # ● ウィンドウ幅の取得
  #--------------------------------------------------------------------------
  def window_width
    480
  end

  #--------------------------------------------------------------------------
  # ● 桁数の取得
  #--------------------------------------------------------------------------
  def col_max
    2
  end

  #--------------------------------------------------------------------------
  # ● 横に項目が並ぶときの空白の幅を取得
  #--------------------------------------------------------------------------
  def spacing
    8
  end

  #--------------------------------------------------------------------------
  # ● 表示行数の取得
  #--------------------------------------------------------------------------
  def visible_line_number
    [15, (item_max + 1) / 2].min
  end

  def category=(category)
    return if @category == category

    self.oy = 0
    @category = category
    refresh
  end

  #--------------------------------------------------------------------------
  # ● コマンドリストの作成
  #--------------------------------------------------------------------------
  def make_command_list
    WarpManager.opend_places_sort(@category).each do |place|
      add_command(place[:name], :ok, true, place)
    end
  end

  def cursor_up(wrap = false)
    if wrap && active && cursor_up_over?
      call_handler(:cursor_up)
    else
      super
    end
  end

  def cursor_down(wrap = false)
    if wrap && active && cursor_down_over?
      call_handler(:cursor_down)
    else
      super
    end
  end

  def cursor_right(wrap = false)
    if handle?(:cursor_right) && cursor_right_over?
      call_handler(:cursor_right) if wrap && active
    else
      super
    end
  end

  def cursor_left(wrap = false)
    if handle?(:cursor_left) && cursor_left_over?
      call_handler(:cursor_left) if wrap && active
    else
      super
    end
  end

  #--------------------------------------------------------------------------
  # ● リフレッシュ
  #--------------------------------------------------------------------------
  def refresh
    clear_command_list
    make_command_list
    self.height = window_height
    create_contents
    contents.clear
    draw_all_items
  end

  def update_help
    @help_window.set_text(NWConst::Warp::PLACE_SELECT_TEXT)
  end
end

#==============================================================================
# ■ Scene_Warp
#==============================================================================
class Scene_Warp < Scene_MenuBase
  #--------------------------------------------------------------------------
  # ● 準備
  #--------------------------------------------------------------------------
  def prepare(cost_item)
    @cost_item = cost_item
  end

  #--------------------------------------------------------------------------
  # ● 開始処理
  #--------------------------------------------------------------------------
  def start
    super
    create_help_window
    create_select_place_window
    create_select_area_window
    create_popup_confirm_window
    @select_place_window.y += @select_area_window.height unless WarpManager.ground_only?
    @select_area_window.select_ext($game_system.warp_history.category)
    @select_area_window.update_help
    @select_place_window.select_warp_history
  end

  #--------------------------------------------------------------------------
  # ● 背景の作成
  #--------------------------------------------------------------------------
  def create_background
    @background_sprite = Sprite.new
    @background_sprite.bitmap = SceneManager.background_bitmap
    @background_sprite.viewport = @viewport
  end

  #--------------------------------------------------------------------------
  # ● ヘルプウィンドウの作成
  #--------------------------------------------------------------------------
  def create_help_window
    @help_window = Foo::Warp::Window_Help.new
    @help_window.viewport = @viewport
  end

  #--------------------------------------------------------------------------
  # ● エリア選択ウィンドウの作成
  #--------------------------------------------------------------------------
  def create_select_area_window
    @select_area_window = Foo::Warp::Window_SelectArea.new(0, @help_window.height)
    @select_area_window.help_window = @help_window
    @select_area_window.place_window = @select_place_window
    @select_area_window.viewport = @viewport
    @select_area_window.set_handler(:cursor_down, proc { select_area_cursor(:cursor_down) })
    @select_area_window.set_handler(:cursor_up, proc { select_area_cursor(:cursor_up) })
    @select_area_window.set_handler(:cancel, method(:goto_map))
    @select_area_window.deactivate
    @select_area_window.hide if WarpManager.ground_only?
  end

  def select_area_cursor(meth)
    Input.update
    Sound.play_cursor
    @select_place_window.index = 0
    if meth == :cursor_up
      @select_place_window.send(meth, true)
      @select_place_window.ensure_cursor_visible
    end
    @select_place_window.activate
    @select_area_window.deactivate
  end

  #--------------------------------------------------------------------------
  # ● 場所選択ウィンドウの作成
  #--------------------------------------------------------------------------
  def create_select_place_window
    @select_place_window = Foo::Warp::Window_SelectPlace.new(0, @help_window.height)
    @select_place_window.help_window = @help_window
    @select_place_window.viewport = @viewport
    @select_place_window.set_handler(:cursor_up, proc { select_place_cursor(:cursor_up) })
    @select_place_window.set_handler(:cursor_down, proc { select_place_cursor(:cursor_down) })
    @select_place_window.set_handler(:ok, method(:select_place_ok))
    @select_place_window.set_handler(:cancel, method(:goto_map))

    return if WarpManager.ground_only?
    @select_place_window.set_handler(:cursor_left, proc { change_place_cursor(:cursor_left) })
    @select_place_window.set_handler(:cursor_right, proc { change_place_cursor(:cursor_right) })
  end

  def change_place_cursor(meth)
    @select_area_window.activate
    @select_area_window.send(meth, true)
    Sound.play_cursor
    @select_area_window.deactivate
    i = @select_place_window.index
    i -= i % @select_place_window.col_max
    i += 1 if meth == :cursor_left
    @select_place_window.select(i.clamp(0,@select_place_window.item_max - 1))
  end

  def select_place_cursor(meth)
    Input.update
    @select_place_window.deactivate
    if @select_area_window.visible
      @select_place_window.unselect
      @select_area_window.activate
    else
      @select_place_window.send(meth, true)
      @select_place_window.activate
    end
  end

  #--------------------------------------------------------------------------
  # ● 場所選択の決定
  #--------------------------------------------------------------------------
  def select_place_ok
    @select_place_window.deactivate
    @popup_confirm_window.refresh
    @popup_confirm_window.show.activate
    @popup_confirm_window.set_name(@select_place_window.current_ext[:name])

    # Get the items from the popup window
    # items = @popup_confirm_window.items
    items = @popup_confirm_window.instance_variable_get(:@list)

    # Debugging output to inspect the items
    puts "Items in popup_confirm_window: #{items.inspect}"

    # Check if items is an array and has at least one element
    if items.is_a?(Array) && !items.empty?
      # Debugging output before calling select
      puts "Selecting the first item (index 0)."

      # Call select with the appropriate arguments
      begin
        # Assuming select requires at least one argument
        @popup_confirm_window.select(0)  # Adjust this if more arguments are needed
      rescue ArgumentError => e
        puts "Error calling select: #{e.message}"
        puts "Expected arguments: #{e.backtrace.inspect}"
      end
    else
      puts "No items to select in popup_confirm_window."
    end
  end

  #--------------------------------------------------------------------------
  # ● 確認ポップアップウィンドウの作成
  #--------------------------------------------------------------------------
  def create_popup_confirm_window
    @popup_confirm_window = Window_PopupConfirm.new
    @popup_confirm_window.set_title(NWConst::Warp::CONFIRM_TEXT)
    @popup_confirm_window.viewport = @viewport
    @popup_confirm_window.hide
    @popup_confirm_window.set_handler(:ok, method(:confirm_ok))
    @popup_confirm_window.set_handler(:cancel, method(:confirm_cancel))
  end

  def get_location(location_data)
    return location_data unless location_data[0].is_a?(Array)
    s = $game_switches
    v = $game_variables
    use_location = nil
    location_data.each do |location|
      if eval(location[3])
        use_location = location
        break
      end
    end
    use_location ||= location_data[-1]
    use_location[0..2]
  end
  #--------------------------------------------------------------------------
  # ● 確認：決定
  #--------------------------------------------------------------------------
  def confirm_ok
    (31..39).each do |id|
      $game_switches[id] = false
    end
    if @cost_item.is_a?(RPG::Item)
      $game_party.consume_item(@cost_item)
    else
      @actor.pay_skill_cost(@cost_item)
    end
    NWConst::Warp::MOVE_SE.play
    RPG::BGM.fade(500)
    RPG::BGS.fade(500)
    fadeout(30)
    RPG::BGM.stop
    RPG::BGS.stop
    place = @select_place_window.current_ext
    $game_system.warp_history.setup(place)
    $game_player.forced_get_off_vehicle
    $game_player.reserve_transfer(place[:map_id], place[:x], place[:y])
    $game_player.perform_transfer
    $game_map.autoplay
    $game_player.followers.visible = true
    $game_player.refresh
    $game_map.screen.clear
    # 乗り物の移動
    if $game_map.ship.exist? && place.key?(:v2location)
      map_id, x, y = get_location(place[:v2location])
      $game_map.ship.set_location(map_id, x, y)
    end
    if $game_map.airship.exist? && place.key?(:v3location)
      map_id, x, y = get_location(place[:v3location])
      $game_map.airship.set_location(map_id, x, y)
    end
    # ポケット魔王城の出口修正
    if place[:map_id] == 126
      $game_variables[21] = 2
      $game_variables[22] = 295
      $game_variables[23] = 356
    end
    goto_map
  end

  #--------------------------------------------------------------------------
  # ● 確認：キャンセル
  #--------------------------------------------------------------------------
  def confirm_cancel
    @popup_confirm_window.hide
    @select_place_window.activate
  end

  #--------------------------------------------------------------------------
  # ● マップに遷移
  #--------------------------------------------------------------------------
  def goto_map
    SceneManager.clear
    SceneManager.goto(Scene_Map)
  end

  #--------------------------------------------------------------------------
  # ● フレーム更新（フェード用）
  #--------------------------------------------------------------------------
  def update_for_fade
    update_basic
    $game_map.update(false)
  end

  #--------------------------------------------------------------------------
  # ● 汎用フェード処理
  #--------------------------------------------------------------------------
  def fade_loop(duration)
    duration.times do |i|
      yield 255 * (i + 1) / duration
      update_for_fade
    end
  end

  #--------------------------------------------------------------------------
  # ● 画面のフェードアウト
  #--------------------------------------------------------------------------
  def fadeout(duration)
    fade_loop(duration) { |v| Graphics.brightness = 255 - v }
  end
end
