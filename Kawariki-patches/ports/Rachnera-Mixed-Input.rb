#==============================================================================
# Lone Wolf Gamepad Extender / Sixth Control Configuration System Compatibility Layer
# by Rachnera
#------------------------------------------------------------------------------
# Duct-tapping together Cidiomar, Lone Wolf and Sixth's hard work
# To support in-game configuration for both keyboard an gamepad
#==============================================================================

module GamepadKeyboardGlue
  # Use VX Ace standard default values as default
  # Ref: https://forums.rpgmakerweb.com/index.php?threads/rpg-maker-pc-game-controls-mv-vx-ace-vx-xp-2003-2000.140758/
  Defaults = {
    :confirm => :X,
    :cancel => :B,
    :mmode => :A,
    :m_pgup => :L1,
    :m_pgdown => :R1,
  }

  Scopes = {
    :mmode => :field_only,
    :m_pgup => :menu_only,
    :m_pgdown => :menu_only,
  }

  File = 'Gamepad.rvdata2'

  def self.bindings
    $gamepad_bindings
  end

  def self.gamepad(method, key)
    return false unless WolfPad.plugged_in?

    Array(GamepadKeyboardGlue.convert(key)).any? { |k| WolfPad.send(method, k) }
  end

  def self.convert(key)
    return [:UP, :L_UP] if self.is_any(key, [:f_up, :m_up])
    return [:DOWN, :L_DOWN] if self.is_any(key, [:f_down, :m_down])
    return [:LEFT, :L_LEFT] if self.is_any(key, [:f_left, :m_left])
    return [:RIGHT, :L_RIGHT] if self.is_any(key, [:f_right, :m_right])

    return self.bindings[:confirm] if self.is_any(key, [:f_confirm, :m_confirm])
    return self.bindings[:cancel] if self.is_any(key, [:f_cancel, :m_cancel, :m_menu])

    self.bindings.reject{ |k| [:confirm, :cancel].include?(k) }.each do |binding, button|
      return button if self.is_any(key, [binding]) and self.relevant_scope(binding)
    end

    nil
  end

  def self.is_any(key, options)
    options.any? { |option| $system[:p1][option].compact.include?(key) }
  end

  def self.relevant_scope(feature)
    return SceneManager.scene_is?(Scene_Map) if Scopes[feature] == :field_only
    return !SceneManager.scene_is?(Scene_Map) if Scopes[feature] == :menu_only

    true
  end
end

module Input
  def self.update
    WolfPad.update

    # ensure @state is a 256-byte buffer
    @state = "\x00" * 256 if @state.nil? || @state.bytesize != 256

    # ensure internal key state arrays exist
    @pressed   ||= Array.new(256, false)
    @triggered ||= Array.new(256, false)
    @repeated  ||= Array.new(256, 0)
    @released  ||= Array.new(256, false)

    # safe mask: prefer top-level constant, otherwise default to 0x80
    mask = if defined?(::DOWN_STATE_MASK) then ::DOWN_STATE_MASK else 0x80 end

    # safe keyboard getter (top-level if available)
    keyboard_getter =
        if defined?(::GetKeyboardState) && ::GetKeyboardState.respond_to?(:call)
    ::GetKeyboardState
  else
    ->(buf) { 0.upto(255) { |i| buf.setbyte(i, 0) }; 1 }
  end

  begin
    keyboard_getter.call(@state)
  rescue
    @state.replace("\x00" * 256)
  end

  0.upto(255) do |key|
    if (@state.getbyte(key) & mask) == mask
      @released[key] = false
      if !@pressed[key]
        @triggered[key] = true
        @pressed[key]  = true
      else
        @triggered[key] = false
      end
      @repeated[key] = @repeated[key] < 17 ? @repeated[key] + 1 : 15
    elsif !@released[key] && @pressed[key]
      @triggered[key] = false
      @pressed[key]   = false
      @repeated[key]  = 0
      @released[key]  = true
    else
      @released[key]  = false
    end
  end

  update_dir
end



  def self.press?(keys)
    return true if GamepadKeyboardGlue.gamepad(:press?, keys)

    if keys.is_a?(Numeric)
      k = keys.to_i
      return (@pressed[k] and !@triggered[k])
    elsif keys.is_a?(Array)
      return keys.any? {|key| self.press?(key) }
    elsif keys.is_a?(Symbol)
      if SYM_KEYS.key?(keys)
        return SYM_KEYS[keys].any? {|key| (@pressed[key]  and !@triggered[key]) }
      elsif (KEYMAP.key?(keys))
        k = KEYMAP[keys]
        return (@pressed[k] and !@triggered[k])
      else
        return false
      end
    end
  end

  def self.trigger?(keys)
    return true if GamepadKeyboardGlue.gamepad(:trigger?, keys)

    if keys.is_a?(Numeric)
      return @triggered[keys.to_i]
    elsif keys.is_a?(Array)
      return keys.any? {|key| @triggered[key]}
    elsif keys.is_a?(Symbol)
      if SYM_KEYS.key?(keys)
        return SYM_KEYS[keys].any? {|key| @triggered[key]}
      elsif KEYMAP.key?(keys)
        return @triggered[KEYMAP[keys]]
      else
        return false
      end
    end
  end

  def self.repeat?(keys)
    return true if GamepadKeyboardGlue.gamepad(:repeat?, keys)

    if keys.is_a?(Numeric)
      key = keys.to_i
      return @repeated[key] == 1 || @repeated[key] == 16
    elsif keys.is_a?(Array)
      return keys.any? {|key| @repeated[key] == 1 || @repeated[key] == 16}
    elsif keys.is_a?(Symbol)
      if SYM_KEYS.key?(keys)
        return SYM_KEYS[keys].any? {|key| @repeated[key] == 1 || @repeated[key] == 16}
      elsif KEYMAP.key?(keys)
        return @repeated[KEYMAP[keys]] == 1 || @repeated[KEYMAP[keys]] == 16
      else
        return false
      end
    end
  end

  def self.dir4
    return WolfPad.dir4 if WolfPad.plugged_in? and WolfPad.dir4 > 0

    @dir4 = 0 if @dir4.nil?
    return @dir4
  end

  def self.dir8
    return WolfPad.dir8 if WolfPad.plugged_in? and WolfPad.dir8 > 0

    @dir8 = 0 if @dir8.nil?
    return @dir8
  end
end

class Scene_GamepadConfig < Scene_Base
  def start
    super
    @msgs = []
    init_main_win
  end

  def init_main_win
    @window = Window_GamepadConfig.new
    @window.set_handler(:ok, method(:on_ok))
    @window.set_handler(:cancel, method(:on_cancel))
  end

  def on_cancel
    System.save_gamepad_bindings
    @window.clean_up
    return_scene
  end

  def on_ok
    add_pop(:wait_for_key)
  end

  def add_pop(type)
    @window.deactivate
    @msgs << [type]
  end

  def update
    super
    @msg_win = nil if @msg_win && @msg_win.disposed?
    if @msgs != [] && @msg_win.nil?
      @msg_win = Window_GamepadConfigPop.new(@window,*@msgs.shift)
    end
  end
end

# Heavily copy-pasted from Sixth's code, some lines might be dead branches I forgot to prune
class Window_GamepadConfig < Window_Command
    attr_accessor :data

  def initialize()
    @data = $gamepad_bindings
    @grps_data = ConfigScene::Windows[:list]
    @grps_data[:width] = 240
    xx = (Graphics.width - @grps_data[:width]) / 2
    yy = GrPS.get(@grps_data[:pos][1])
    super(xx,yy)
    activate
    select(0)
    self.opacity = ConfigScene::Windows[:list][:opa]
    self.z = ConfigScene::Windows[:list][:z]
    self.windowskin = Cache.system(ConfigScene::Windows[:list][:skin])

    @help_window = Window_ConfigHelp.new
    update_help
  end

  def window_width
    @grps_data[:width]
  end

  def alignment
    1
  end

  def spacing
    4
  end

  def mod
    120
  end

  def item_width
    full = width - standard_padding * 2 + spacing
    return full - mod - spacing * 2
  end

  def item_rect(index)
    rect = Rect.new
    rect.width = item_width
    rect.height = item_height
    rect.x = mod + spacing
    rect.y = index * item_height
    rect
  end

  def make_command_list
    @data.each do |key, btn|
      add_command(btn.to_s, ('feature_' + key.to_s).to_sym, true, { :feature => key, :button => btn })
    end
  end

  def draw_item(index)
    rct = item_rect(index)
    draw_key_buttons(index,rct)
  end

  def draw_key_buttons(index, rect)
    color = ConfigScene::ListVisual[:boxes][:keys]
    draw_back_box(rect.x, rect.y+1, rect.width, rect.height-2, color)
    set_font_opts(ConfigScene::ListVisual[:font][:keys])
    draw_text(item_rect_for_text(index), command_name(index), alignment)
  end

  def refresh
    super
    draw_button_names
  end

  def draw_button_names
    set_font_opts(ConfigScene::ListVisual[:font][:names])
    @data.each_with_index do |(key, btn), i|
      yy = i * item_height
      color = ConfigScene::ListVisual[:boxes][:names]
      draw_back_box(0,yy+1,mod,item_height-2,color)
      txt = ConfigScene::Buttons[key]
      draw_text(4,yy,mod-8,item_height,txt)
    end
  end

  def update_help
    txt = ConfigScene::ButtonHelps[current_ext[:feature]]
    @help_window.refresh(txt)
  end

  def set_data(data)
    @data = data
    refresh
  end

  def clean_up
    @help_window.dispose
  end
end

class Window_GamepadConfigPop < Window_Base
  MSGS = {
    :wait_for_key => "Press the button you wish to bind to the \eC[1]\eFNCTN\eC[0] function!",
    :error_message => "Could not bind button \eC[1]%new_button%\eC[0] to the \eC[1]\eFNCTN\eC[0] function.\n Try changing another binding first.",
  }

  def initialize(list_win, type)
    @grps_data = ConfigScene::Windows[:pop]
    @list_win = list_win
    @type = type
    @list_data = @list_win.data
    @funct = @list_win.current_ext

    xx = GrPS.get(@grps_data[:pos][0])
    yy = GrPS.get(@grps_data[:pos][1])
    ww = GrPS.get(@grps_data[:size][0])
    hh = GrPS.get(@grps_data[:size][1])
    super(xx,yy,ww,hh)
    set_font_opts(ConfigScene::PopVisual[:font])
    self.opacity = ConfigScene::Windows[:pop][:opa]
    self.z = ConfigScene::Windows[:pop][:z]
    self.windowskin = Cache.system(ConfigScene::Windows[:pop][:skin])
    close
    self.openness = 0
    refresh
    open
    until self.openness >= 255
      update
      SceneManager.scene.update
    end
  end

  def get_text
    kfunct = ConfigScene::Buttons[@funct[:feature]] # interact/cancel/etc
    txt = Window_GamepadConfigPop::MSGS[@type].clone
    txt.gsub!(/\eFNCTN/i) { kfunct }
    if @error_data
      @error_data.each do |key, value|
        txt.gsub!(/%#{key.to_s}%/, value.to_s)
      end
    end
    return txt
  end

  def set_win_size_and_pos(ww,hh)
    ww = Graphics.width if ww > Graphics.width
    hh = Graphics.height if hh > Graphics.height
    self.width = ww
    self.height = hh
    self.x = (Graphics.width-self.width) / 2
    self.y = (Graphics.height-self.height) / 2
    create_contents
    set_font_opts(ConfigScene::PopVisual[:font])
  end

  def draw_information(txt)
    texts = {}
    lnum = 0
    hh = standard_padding * 2
    ww = standard_padding * 2
    txt = txt.clone
    txt.each_line do |line|
      line.sub!("\n","")
      line.sub!("\r\n","")
      data = draw_text_ex(0,0,line)
      hh += line_height
      yy = lnum * line_height
      tw = data[:x]
      mw = tw + standard_padding * 2 + ConfigScene::PopVisual[:add_w]
      ww = mw if mw > ww
      texts[lnum] = {:txt => line, :y => yy, :w => tw}
      lnum += 1
    end
    set_win_size_and_pos(ww,hh)
    texts.each do |lnum,info|
      xx = (contents_width-info[:w])/2
      yy = info[:y]
      draw_text_ex(xx,yy,info[:txt])
    end
  end

  def refresh
    txt = get_text
    return if txt.nil?
    draw_information(txt)
  end

  def reset_font_settings
    # Removed!
  end

  def pop_over
    close
    until self.openness <= 0
      SceneManager.scene.update
    end
    @list_win.activate
    dispose
  end

  def update
    super
    return if self.disposed? || self.openness < 255
    if @type == :wait_for_key
      waiting_for_key_press
    else
      error_message
    end
  end

  # Starting the wait for the input:
  def waiting_for_key_press
    [:A, :B, :X, :Y, :L1, :R1, :START, :SELECT, :L2, :R2].any? do |key|
      if WolfPad.trigger?(key)
        feature = @funct[:feature]
        old_button = @funct[:button]
        new_button = key
        new_bindings = $gamepad_bindings.clone
        new_bindings[feature] = new_button

        return set_new_bindings(new_bindings) if valid_bindings?(new_bindings)

        # Bind others features currently bound to the new button to the old button
        new_bindings.each do |other_feature, button|
          next if feature == other_feature
          next if button != new_button
          new_bindings[other_feature] = old_button
        end

        return set_new_bindings(new_bindings) if valid_bindings?(new_bindings)

        Sound.play_buzzer
        @type = :error_message
        @error_data = { :new_button => new_button }
        refresh
      end
    end
  end

  def valid_bindings?(bindings)
    bindings.each do |feature, button|
      bindings.each do |other_feature, other_button|
        next if feature == other_feature
        next if button != other_button
        next if GamepadKeyboardGlue::Scopes[feature] == :field_only and GamepadKeyboardGlue::Scopes[other_feature] == :menu_only
        next if GamepadKeyboardGlue::Scopes[feature] == :menu_only and GamepadKeyboardGlue::Scopes[other_feature] == :field_only

        return false
      end
    end

    return true
  end

  def set_new_bindings(new_bindings)
    $gamepad_bindings = new_bindings.clone
    @list_win.set_data($gamepad_bindings)
    Sound.play_ok
    pop_over
  end

  def error_message
    if Input.trigger_ex?($system[:p1][:m_confirm]) or Input.trigger_ex?($system[:p1][:m_cancel])
      @error_data = nil
      pop_over
      @list_win.activate
    end
  end
end

module System
  class << self
    alias_method :original_init, :init
  end

  def self.init
    original_init

    $gamepad_bindings = GamepadKeyboardGlue::Defaults.clone
    file = GamepadKeyboardGlue::File
    if File.exist?(file)
      $gamepad_bindings.merge!(load_data(file))
    end
  end

  def self.save_gamepad_bindings
    save_data($gamepad_bindings, GamepadKeyboardGlue::File)
  end

  def self.reset_gamepad_bindings
    $gamepad_bindings = GamepadKeyboardGlue::Defaults.clone
    save_gamepad_bindings
  end
end

module MultiKeyBind
  FusedKeys = {
    :up => { :name => "Up", :description => "Move character/cursor upward.", :supersede => [:f_up, :m_up] },
    :down => { :name => "Down", :description => "Move character/cursor downward.", :supersede => [:f_down, :m_down] },
    :left => { :name => "Left", :description => "Move character/cursor leftward.", :supersede => [:f_left, :m_left] },
    :right => { :name => "Right", :description => "Move character/cursor rightward.", :supersede => [:f_right, :m_right] },
    :confirm => { :name => "Interact/Select", :description => "The key used for basically anything as a default.", :supersede => [:f_confirm, :m_confirm] },
    :cancel => { :name => "Cancel/Menu", :description => "Cancel, go back, exit.\nAlso open the menu.", :supersede => [:f_cancel, :m_cancel, :m_menu] },
  }

  FusedKeys.each do |key, cf|
    ConfigScene::Buttons[key] = cf[:name]
    ConfigScene::ButtonHelps[key] = cf[:description]
  end
end
