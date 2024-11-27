#==============================================================================
#    ATS: Special Message Codes [VXA]
#    Version: 1.0.6
#    Author: modern algebra (rmrk.net)
#    Date: 18 October 2012
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  Description:
#
#    This script allows you to use a number of additional special codes in the
#   message system, which will function similar to the default codes like
#   \v[n], \c[n], etc. Please see the list of special message codes starting at
#   line 54 for a full idea of what is added. Basically, it gives you greater
#   control over the delivery of a message, allows you to make use of font
#   effects like bolding and italicizing, and allows you to retrieve and
#   display useful data like the names of weapons and armors.
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  ATS Series:
#
#    This script is part of the Advanced Text System series of scripts. These
#   scripts are based off the Advanced Text System for RMVX, but since RMVX Ace
#   has a much more sensibly designed message system, it is no longer necessary
#   that it be one large script. For that reason, and responding to feedback on
#   the ATS, I have split the ATS into multiple different scripts so that you
#   only need to pick up the components for the features that you want. It is
#   therefore easier to customize and configure.
#
#    To find more scripts in the ATS Series, please visit:
#      http://rmrk.net/index.php/topic,44525.0.html
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  Instructions:
#
#    This script is not difficult to use or configure. There are only ten
#   configuration options for this script. These are:
#
#      :message_speed               :font_italic
#      :show_fast_speed             :font_outline
#      :font_name                   :font_shadow
#      :font_size                   :font_underline
#      :font_bold                   :font_highlight
#
#   :message_speed allows you to set the default number of frames to wait
#   between drawing each letter in the message window. :show_fast_speed allows
#   you to control the amount it speeds up when the player presses enter. You
#   can gain instructions on setting the default value for both at line 180.
#
#   All of the :font_ settings simply let you set the initial values for the
#   font when used.
#
#    As with other ATS scripts, you can change the value of these options in
#   game with the following codes in a script call:
#
#      ats_next(:message_option, x)
#      ats_all(:message_option, x)
#
#   Where :message_option is the symbol you want (:message_speed or
#   :show_fast_speed) and x is the value you want to change it to. ats_next
#   will only change it for the very next message, while ats_all will change it
#   for every message to follow.
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  List of Special Message Codes:
#
#    The default message codes are retained, and this script adds a number of
#   other desirable features. The following is a complete list of the message
#   codes at your disposal. Simply insert them into a Display Message command,
#   Choice Branches, or any other message related system.
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#  Font Effects:
#
# \fn[fontname] - Change the font to fontname. If you put multiple fontnames
#     separated by commas, then it will take the first one the user has installed
# \fs[n] - Change the font size to n.
# \{ - Increase the font size by 8.
# \} - Decrease the font size by 8.
# \c[n] - Set the colour of the text being drawn to the nth colour of the
#     Windowskin palette. 0 is the normal color and 16 is the system color.
# \hc[RRGGBB] or \c[#RRGGBB] - Set the colour of the text being drawn to any
#     colour, using hexadecimal values. You can set each colour (red, green,
#     blue) to anything from 0-255 (00-FF). You must use hexadecimal values. If
#     so desired, you can add an additional hex value from 00-FF to change the
#     alpha.
# \b     - Turn bold on. Text drawn after this code will be bolded.
# /b     - Turn bold off.
# \i     - Turn italic on. Text drawn after this code will be italicized.
# /i     - Turn italic off.
# \o     - Turn outline on.
# /o     - Turn outline off.
# \s     - Turn shadow on. Text drawn after this code will have a shadow.
# /s     - Turn shadow off.
# \u     - Turn underline on. Text drawn after this code will be underlined.
# /u     - Turn underline off.
# \hl[n] - Turn highlight on. Text drawn after this code will be highlighted
#     with colour n + 1 from the windowskin palette
# /hl OR \hl[0] - Turn highlight off.
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#  Message Control:
#
# \s[n] - Sets the message speed to wait n frames between drawing every letter.
#     0 is instant.
# \s[+n] - Sets the message speed to wait an additional n frames between drawing
#     every letter.
# \s[-n] - Sets the message speed to wait n less frames between drawing every
#     letter.
# \. - Wait 15 frames before drawing the next character
# \| - Wait 60 frames before drawing the next character
# \w[n] - Wait n frames before drawing the next character
# \! - Pause text and wait for player to press Enter
# \^ - Skip Pause; allows you to close a message window without requiring player
#     input.
# \> - Show line fast.
# \< - Stop showing line fast.
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#  Replacement Codes:
#
# \p[n] - Draw the name of the actor in the xth position in the party. 1 is
#     the party leader, 2 is the second member, etc.
# \n[n] - Draw the name of the actor with ID n
# \nn[n] - Draw the nickname of the actor with ID n.
# \pid[n] - Draw the ID of the actor in the nth position in the party.
# \ac[n] - Draw the class name of the actor with ID n.
# \al[n] - Draw the level of the actor with ID n.
# \ni[n] - Draw the name of the item with ID n.
# \nw[n] - Draw the name of the weapon with ID n.
# \na[n] - Draw the name of the armor with ID n.
# \ns[n] - Draw the name of the skill with ID n.
# \nt[n] - Draw the name of the state with ID n.
# \nc[n] - Draw the name of the class with ID n.
# \ne[n] - Draw the name of the event with ID n on the current map.
# \nm[n] - Draw the name of the enemy with ID n.
# \nv[n] - Draw the name of the variable with ID n.
# \nsw[n] - Draw the name of the switch with ID n.
# \nl[n] - Draw the name of the element with ID n.
# \nwt[n] - Draw the name of the weapon type with ID n.
# \nat[n] - Draw the name of the armor type with ID n.
# \nst[n] - Draw the name of the skill type with ID n.
# \np[n] - Draw the name of the actor in the nth position in the party.
# \map   - Draw the name of the map the player is currently on.
# \map[n] - Draw the name of the map with ID n.
# \pg - Draws the amount of money the party has.
# \g - Draws the unit of currency.
# \vocab[method] - Will draw whatever Vocab.method returns, if it is a valid
#     method call. Suitable values for method are: level, level_a, hp, hp_a,
#     mp, mp_a, tp, tp_a, fight, escape, attack, guard, item, skill, equip,
#     status, formation, save, game_end, weapon, armor, key_item, equip2,
#     optimize, clear, new_game, continue, shutdown, to_title, cancel,
#     currency_unit
# \vocab[param, n] - Will draw the label for parameter with ID n. 0 => Max HP;
#     1 => Max MP; 2 => Attack; 3 => Defence; 4 => Magic; 5 => Magic Defence;
#     6 => Agility; 7 => Luck
# \vocab[etype, n] - Will draw the label for equipment type with ID n.
#     0 => Weapon; 1 => Shield; 2 => Head; 3 => Body; 4 => Accessory
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#  Other Effects:
#
# \$ - Opens a window which shows the party's gold.
# \n - line break
# \i[n] - Draw icon with index n.
# \ii[n] - Draw icon of the item with ID n.
# \iw[n] - Draw icon of the weapon with ID n.
# \ia[n] - Draw icon of the armor with ID n.
# \is[n] - Draw icon of the skill with ID n.
# \it[n] - Draw icon of the state with ID n.
# \x[n] - Draw next character at pixel n of the window contents.
# \s{n,text} - Will only draw text if the switch with ID n is ON.
# \s!{n,text} - Will only draw text if the switch with ID n is OFF.
# \#{code} - This will evaluate code. So, if you know scipting, you can place
#     any code there and it will draw whatever is returned by it. For instance:
#     \#{$game_system.save_count} would draw the number of times the player has
#     saved the current game.
#==============================================================================

$imported = {} unless $imported
$imported[:ATS_SpecialMessageCodes] = true

#==============================================================================
# ** Game_ATS
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  Summary of Changes:
#    new public instance variables - message_speed; special_message_codes
#==============================================================================

class Game_ATS
  CONFIG = {} unless $imported[:AdvancedTextSystem]
  CONFIG[:special_message_codes] = {
    special_message_codes: true,
    #\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
    #  EDITABLE REGION
    #||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    #   :message_speed => x,
    #      Changing the value of x determines the default number of frames to
    #     wait between drawing letters in a message window. 0 is instant.
    :message_speed =>   1,
    #   :show_fast_speed => x
    #      Changing the value of x determines the number of frames to wait
    #     between drawing letters when the player is holding enter. 0 is
    #     instant
      :show_fast_speed => 0,
    # Font Settings - Set the default settings for the font you are using here.
    :font_name => Font.default_name,       # String or Array of Strings
    :font_size => Font.default_size,       # Integer
    :font_bold => Font.default_bold,       # true or false
    :font_italic => Font.default_italic,   # true or false
    :font_outline => Font.default_outline, # true or false
    :font_shadow => Font.default_shadow,   # true or false
    :font_underline => false,              # true or false
    :font_highlight => -1,                 # Integer for colour of highlight
    #||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    #  END EDITABLE REGION
    #////////////////////////////////////////////////////////////////////////
  }
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Public Instance Variables
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  CONFIG[:special_message_codes].keys.each { |key| attr_accessor key }
end

#==============================================================================
#  Initialize Common ATS Data if no other ATS script interpreted first
#==============================================================================

if !$imported[:AdvancedTextSystem]
  #============================================================================
  # *** DataManager
  #++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  #  Summary of Changes:
  #    aliased method - create_game_objects; make_save_contents;
  #      extract_save_contents
  #============================================================================
  module DataManager
    class << self
      #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      # * Create Game Objects
      #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      alias modb_ats_crtgmobj_6yh7 create_game_objects
      def create_game_objects(*args, &block)
        modb_ats_crtgmobj_6yh7(*args, &block)
        $game_ats = Game_ATS.new
        $game_ats.init_new_installs
      end
      #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      # * Make Save Contents
      #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      alias mlba_ats_mksave_5tg9 make_save_contents
      def make_save_contents(*args, &block)
        contents = mlba_ats_mksave_5tg9(*args, &block)
        contents[:ats] = $game_ats
        contents
      end
      #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      # * Extract Save Contents
      #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      alias ma_ats_extrcsvcon_8uj2 extract_save_contents
      def extract_save_contents(contents, *args, &block)
        ma_ats_extrcsvcon_8uj2(contents, *args, &block)
        $game_ats = contents[:ats] ? contents[:ats] : Game_ATS.new
        $game_ats.init_new_installs
      end
    end
  end
 
  #============================================================================
  # ** Game_ATS
  #++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  #  This class holds the default data for all scripts in the ATS series
  #============================================================================
 
  class Game_ATS
    def initialize; reset; end
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    # * Reset any or all installed ATS scripts
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    def reset(script_name = nil)
      if script_name.is_a? (Symbol) # If script to reset specified
        CONFIG[script_name].each_pair { |key, value|
          self.send("#{key}=".to_sym, value)
          $game_message.send("#{key}=".to_sym, value)
        }
      else                          # Reset all ATS scripts
        CONFIG.keys.each { |script| reset(script) }
      end
    end
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    # * Initialize any newly installed ATS scripts
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    def init_new_installs
      CONFIG.keys.each { |script| reset(script) unless self.send(script) }
    end
  end
 
  #============================================================================
  # ** Game_Message
  #++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  #  Summary of Changes:
  #    aliased method - clear
  #============================================================================
 
  class Game_Message
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    # * Clear
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    alias mlb_ats_clrats_5tv1 clear
    def clear(*args, &block)
      mlb_ats_clrats_5tv1(*args, &block) # Run Original Method
      return if !$game_ats
      Game_ATS::CONFIG.values.each { |installed|
        installed.keys.each { |key| self.send("#{key}=".to_sym, $game_ats.send(key)) }
      }
    end
  end
 
  #============================================================================
  # ** Game_Interpreter
  #++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  #  Summary of Changes:
  #    new methods - ats_all; ats_next
  #============================================================================
 
  class Game_Interpreter
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    # * ATS All
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    def ats_all(sym, *args, &block)
      $game_ats.send("#{sym}=".to_sym, *args, &block)
      ats_next(sym, *args, &block)
    end
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    # * ATS Next
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    def ats_next(sym, *args, &block)
      $game_message.send("#{sym}=".to_sym, *args, &block)
    end
  end
end

$imported[:AdvancedTextSystem] = true

class Game_Message
  Game_ATS::CONFIG[:special_message_codes].keys.each { |key| attr_accessor key }
end

#==============================================================================
# ** Game_Event
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  Summary of Changes:
#    new method - name
#==============================================================================

class Game_Event
  def name
    return @event ? @event.name : ""
  end
end

#==============================================================================
# ** Window_Base
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  Summary of Changes:
#    aliased methods - initialize; convert_escape_characters; calc_line_height;
#      process_escape_character; process_normal_character
#==============================================================================

class Window_Base
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Object Initialization
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  alias mlgb_atssmc_init_3do9 initialize
  def initialize(*args, &block)
    mlgb_atssmc_init_3do9(*args, &block) # Run Original Method
    @underline = false
    @highlight = -1
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Convert Escape Characters
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  alias ma_atssmc_convesc_4rc1 convert_escape_characters
  def convert_escape_characters(text, *args, &block)
    result = ma_atssmc_convesc_4rc1(text, *args, &block) # Run Original Method
    # Party
    result.gsub!(/\ePID\[(\d+)\]/i) { $1.to_i >= 1 ? $game_party.members[$1.to_i - 1].id.to_s : "1" }
    result.gsub!(/\ePG/i) { $game_party.gold }
    # Message Speed
    result.gsub!(/\eS\[([\+-]?\d+)\]/i) { "\eMS\[#{$1}\]" }
    result.gsub!(/\e%/)             { "\eDS%"}
    # Hex Colour
    result.gsub!(/\eC\[#/i)         { "\eHC[" }
    # Icons
    result.gsub!(/\eII\[(\d+)\]/i)  { "\eI\[#{$data_items[$1.to_i].icon_index}\]" rescue "" }
    result.gsub!(/\eIW\[(\d+)\]/i)  { "\eI\[#{$data_weapons[$1.to_i].icon_index}\]" rescue "" }
    result.gsub!(/\eIA\[(\d+)\]/i)  { "\eI\[#{$data_armors[$1.to_i].icon_index}\]" rescue "" }
    result.gsub!(/\eIS\[(\d+)\]/i)  { "\eI\[#{$data_skills[$1.to_i].icon_index}\]" rescue "" }
    result.gsub!(/\eIT\[(\d+)\]/i)  { "\eI\[#{$data_states[$1.to_i].icon_index}\]" rescue "" }
    # Actor Stats
    result.gsub!(/\eAC\[(\d+)\]/i)  { $data_classes[$game_actors[$1.to_i].class_id].name }
    result.gsub!(/\eAL\[(\d+)\]/i)  { $game_actors[$1.to_i].level.to_s }
    # Names
    result.gsub!(/\eMAP\[(\d+)\]/i) { load_data(sprintf("Data/Map%03d.rvdata2", $1.to_i)).display_name rescue "" }
    result.gsub!(/\eMAP/i)          { $game_map.display_name rescue "" }
    result.gsub!(/\eNP\[(\d+)\]/i)  { $game_party.members[$1.to_i].name rescue "" }
    result.gsub!(/\eNE\[(\d+)\]/i)  { $game_map.events[$1.to_i].name rescue "" }
    result.gsub!(/\eNN\[(\d+)\]/i)  { $game_actors[$1.to_i].nickname rescue "" }
    result.gsub!(/\eNI\[(\d+)\]/i)  { $data_items[$1.to_i].name rescue "" }
    result.gsub!(/\eNW\[(\d+)\]/i)  { $data_weapons[$1.to_i].name rescue "" }
    result.gsub!(/\eNA\[(\d+)\]/i)  { $data_armors[$1.to_i].name rescue "" }
    result.gsub!(/\eNS\[(\d+)\]/i)  { $data_skills[$1.to_i].name rescue "" }
    result.gsub!(/\eNT\[(\d+)\]/i)  { $data_states[$1.to_i].name rescue "" }
    result.gsub!(/\eNM\[(\d+)\]/i)  { $data_enemies[$1.to_i].name rescue "" }
    result.gsub!(/\eNC\[(\d+)\]/i)  { $data_classes[$1.to_i].name rescue "" }
    result.gsub!(/\eNV\[(\d+)\]/i)  { $data_system.variables[$1.to_i] }
    result.gsub!(/\eNSW\[(\d+)\]/i) { $data_system.switches[$1.to_i] }
    result.gsub!(/\eNWT\[(\d+)\]/i) { $data_system.weapon_types[$1.to_i] }
    result.gsub!(/\eNAT\[(\d+)\]/i) { $data_system.armor_types[$1.to_i] }
    result.gsub!(/\eNST\[(\d+)\]/i) { $data_system.skill_types[$1.to_i] }
    result.gsub!(/\eNL\[(\d+)\]/i)  { $data_system.elements[$1.to_i] }
    # Vocab
    result.gsub!(/\eVOCAB\[(\w+),\s*(\d+)\s*\]/i) { Vocab.send($1.downcase, $2.to_i) rescue "" }
    result.gsub!(/\eVOCAB\[(\w+)\]/i) { Vocab.send($1.downcase) rescue "" }
    # Font Settings
    result.gsub!(/\eB/i)            { "\eFE[0]" } # Bold On
    result.gsub!(/\/B/i)            { "\eFE[1]" } # Bold Off
    result.gsub!(/\eI([^\[])/i)     { "\eFE[2]#{$1}" } # Italics On
    result.gsub!(/\/I/i)            { "\eFE[3]" } # Italics Off
    result.gsub!(/\eO/i)            { "\eFE[4]" } # Outline On
    result.gsub!(/\/O/i)            { "\eFE[5]" } # Outline Off
    result.gsub!(/\eS([^\[!])/i)    { "\eFE[6]#{$1}" } # Shadow On
    result.gsub!(/\/S/i)            { "\eFE[7]" } # Shadow Off
    result.gsub!(/\eU/i)            { "\eFE[8]" } # Underline On
    result.gsub!(/\/U/i)            { "\e\FE[9]" } # Underline Off
    result.gsub!(/\eHL\[(\d+)\]/i)  { "\eHL[#{$1.to_i}]" } # Highlight On: custom colour
    result.gsub!(/\eHL([^\[])/i)    { "\eHL[17]#{$1}" }# Highlight On: system colour
    result.gsub!(/\/HL/i)           { "\eHL[0]" } # Hightlight Off
    result.gsub!(/\/FN/i)           { "\eFN[]" }  # Default Font
    result.gsub!(/\/FS/i)           { "\eFS[#{Font.default_size}]" } # Default Font
    # Conditional Text
    result.gsub!(/\eS\[(\d+)[,;:](.+?)\]/mi) { $game_switches[$1.to_i] ? $2 : "" }
    result.gsub!(/\eS!\[(\d+)[,;:](.+?)\]/mi) { $game_switches[$1.to_i] ? "" : $2 }
    result.gsub!(/\eS\{(\d+)[,;:](.+?)\}/mi) { $game_switches[$1.to_i] ? $2 : "" }
    result.gsub!(/\eS!\{(\d+)[,;:](.+?)\}/mi) { $game_switches[$1.to_i] ? "" : $2 }
    # Evaluation
    result.gsub!(/\e#\{(.+?)\}/im)  { (eval($1)).to_s rescue "" }
    # Do resubstitutions if requested
    if result.sub!(/\eRESUB/i, "") != nil
      result = convert_escape_characters(result, *args, &block)
    end
    result.gsub!(/\e(N|LB)/i, "\n") # Line Break
    result # Return result
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Calculate Line Height
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  alias ma_atssmc_clclnhght_3ek9 calc_line_height
  def calc_line_height(text, *args, &block)
    res = ma_atssmc_clclnhght_3ek9(text, *args, &block) # Run Original Method
    text.slice(/^.*$/).scan(/\eFS\[(\d+)\]/i) { |num| res = [res, num[0].to_i].max }
    res
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Process Normal Character
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  alias mlra_atssmc_procnorm_5fg2 process_normal_character
  def process_normal_character(c, pos, *args, &block)
    draw_highlight_underline(c, pos) if @underline || @highlight
    mlra_atssmc_procnorm_5fg2(c, pos, *args, &block) # Run Original Method
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Process Escape Character
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  alias ma_atssmc_procesc_7gv1 process_escape_character
  def process_escape_character(code, text, pos, *args, &block)
    case code.upcase
    when 'X' then pos[:x] = obtain_escape_param(text)
    when 'HC' # Hex Colour
      hex = text.slice!(/^\[([ABCDEF\d]+)\]/i)
      rgb = $1.scan(/../).map { |hex| hex.to_i(16) }
      change_color(Color.new(*rgb)) if rgb.size.between?(3,4)
    when 'FE' # Font Settings
      param = obtain_escape_param(text)
      case param / 2
      when 0 then contents.font.bold = ((param % 2) == 0)     # Bold
      when 1 then contents.font.italic = ((param % 2) == 0)   # Italic
      when 2 then contents.font.outline = ((param % 2) == 0)  # Outline
      when 3 then contents.font.shadow = ((param % 2) == 0)   # Shadow
      when 4 then @underline = ((param % 2) == 0)             # Underline
      end
    when 'HL' then @highlight = obtain_escape_param(text) - 1 # Highlight
    when 'FN' # Font Name
      text.slice!(/^\[(.*?\])/)
      param = $1
      if param.nil? || param == ']'
        contents.font.name = Font.default_name
      else
        ary = []
        while param.slice!(/\s*(.+?)\s*[,;:\]]/) != nil do ary.push($1) end
        contents.font.name = ary
      end
    when 'FS' # Font Size
      text.slice!(/^\[(\d+)\]/)
      contents.font.size = [[$1.to_i, 16].max, 64].min
    else
      ma_atssmc_procesc_7gv1(code, text, pos, *args, &block) # Run Original Method
    end
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Draw Highlighting and Underlining
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def draw_highlight_underline(c, pos)
    text_width = text_size(c).width
    y_space = (pos[:height] - contents.font.size) / 2
    if @underline      # Underlining
      y = pos[:y] + pos[:height]
      y -= [2, y_space].max
      contents.fill_rect(pos[:x], y, text_width, 2, contents.font.color)
    end
    if @highlight >= 0 # Highlighting
      y = pos[:y]
      y += y_space - 1 if y_space > 0
      text_height = [contents.font.size + 2, pos[:height]].min
      colour = text_color(@highlight)
      colour.alpha = 128 if colour.alpha > 128
      contents.fill_rect(pos[:x], y, text_width, text_height, colour)
    end
  end
end

#===============================================================================
# ** Window_Message
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  Summary of Changes:
#    aliased method - clear_instance_variables; process_escape_character;
#      update_show_fast; wait_for_one_character
#    overwritten super method - reset_font_settings
#===============================================================================

class Window_Message
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Clear Instance Variables
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  alias ma_atssmc_clrinsvar_3dq9 clear_instance_variables
  def clear_instance_variables(*args, &block)
    ma_atssmc_clrinsvar_3dq9(*args, &block) # Run Original Method
    @skip_disabled = false
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Reset Font Settings
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def reset_font_settings(*args, &block)
    change_color(normal_color)
    contents.font.name = $game_message.font_name
    contents.font.size = $game_message.font_size
    contents.font.bold = $game_message.font_bold
    contents.font.italic = $game_message.font_italic
    contents.font.outline = $game_message.font_outline
    contents.font.shadow = $game_message.font_shadow
    @underline = $game_message.font_underline
    @highlight = $game_message.font_highlight
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Process Escape Character
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  alias mnaa_atssmc_escchar_3dr9 process_escape_character
  def process_escape_character(code, text, pos, *args, &block)
    case code.upcase
    when 'MS' # Set Message Speed
      if !text[/^\[([+-])/].nil?
        text.sub!(/^\[([\+-])/, '[' )
        sign = $1
      else
        sign = ""
      end
      param = obtain_escape_param(text)
      sign.empty? ? $game_message.message_speed = param : $game_message.message_speed += "#{sign}#{param}".to_i
      when 'DS'
        text.slice!(/^%/) # Delete buffer to ensure code isn't overextended
        @skip_disabled = !@skip_disabled
      when 'W' then wait(obtain_escape_param(text))
    else
      mnaa_atssmc_escchar_3dr9(code, text, pos, *args, &block) # Run Original Method
    end
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Update Show Fast
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  alias mlg_atssmc_updshwfast_7yb1 update_show_fast
  def update_show_fast(*args, &block)
    mlg_atssmc_updshwfast_7yb1(*args, &block)
    if $game_message.message_speed < 1
      @show_fast = true
    elsif @skip_disabled
      @show_fast = false
    elsif $game_message.show_fast_speed > 0
      @show_fast = Input.press?(:C)
    end
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Wait for One Character
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  alias mdrnl_smcats_waitonechar_5rf1 wait_for_one_character
  def wait_for_one_character(*args, &block)
    mdrnl_smcats_waitonechar_5rf1(*args, &block) # Run Original Method
    if (@show_fast || @line_show_fast) && $game_message.show_fast_speed > 0
      wait($game_message.show_fast_speed)
    elsif $game_message.message_speed > 1
      wait($game_message.message_speed - 1)
    end
  end
end
