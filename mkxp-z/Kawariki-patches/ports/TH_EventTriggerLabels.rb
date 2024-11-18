=begin
#==============================================================================
 Title: Event Trigger Labels
 Author: Hime
 Date: Dec 22, 2014
------------------------------------------------------------------------------
 ** Change log
 Sep 09, 2022
  - Add mkxp-z 2.4 support
 Feb 13, 2022
  - MKXP(-Z) port by Taeyeon Mori
  - Replace any_key_pressed? implementation based on Win32API with
    one using System.raw_key_states
 Dec 22, 2014
  - fixed bug where page list is not properly reset after execution
  - added a flag for post-event processing for whether an event was triggered
 Nov 6, 2014
  - completely refactored code
  - implemented "any key pressed?" check
  - moved key item triggers and touch triggers into separate scripts
 Jan 30, 2014
  -refactored code
  -added compatibility with instance items
 Dec 27, 2013
  -optimized performance by not clearing out the key item variable on update
 Nov 19, 2013
  -fixed bug where stepping on event with no active page crashed the game
 Sep 26, 2013
  -added support for "player touch" trigger label
 Sep 6, 2013
  -fixed bug where trigger labels as the first command doesn't register properly
 Mar 22, 2013
  -fixed bug where you can still trigger events after they have been erased
 Dec 5, 2012
  -fixed issue where event was checked before page was setup
 Oct 20, 2012
  -fixed issue where using key item in succession crashes game
  -added support for key item triggers
 Aug 22, 2012
  -Support input names greater than one character (eg: F5 vs C)
 Aug 18, 2012
  -fixed label parsing to store all buttons
 Jun 13, 2012
  -initial release
------------------------------------------------------------------------------   
 ** Terms of Use
 * Free to use in non-commercial projects
 * Contact me for commercial use
 * No real support. The script is provided as-is
 * Will do bug fixes, but no compatibility patches
 * Features may be requested but no guarantees, especially if it is non-trivial
 * Credits to Hime Works in your project
 * Preserve this header
------------------------------------------------------------------------------
 ** Description:
 
 This script allows you to assign multiple action triggers to an event.
 Every page can have its own set of action triggers.
 
 The action button, by default, is the C button (on keyboards, it is by default
 the Z key, Enter, or Space). So when you press the action button when you're
 standing beside an event, you will execute its action trigger and the event
 will begin running.
 
 Multiple action triggers allow you to set up your event to run different
 sets of commands depending on which button you pressed. For example, you can
 press the C button to interact with the event normally, or you can press the
 X button (default A key) to initiate a mini-game.
 
------------------------------------------------------------------------------
 ** Installation

 Place this script below Materials and above Main
 
------------------------------------------------------------------------------
 ** Usage
 
 Instead of treating your page as one list of commands, you should instead
 treat it as different sections of commands. Each section will have its own
 label, specified in a specific format.
 
 To create a section, add a Label command and then write
 
   button?(:C)
   
 This means that any commands under this label will be executed when you press
 the C button (remember that the C button is the Z key on your keyboard).
 
 You can create as many sections as you want, each with their own buttons.
 Press F1 in-game and then go to the keyboard tab to see which buttons are
 available.
 
#==============================================================================
=end
$imported = {} if $imported.nil?
$imported[:TH_EventTriggerLabels] = true
#==============================================================================
# ** Configuration
#==============================================================================
module TH
  module Event_Trigger_Labels
    
    # this is what you need to type for all your labels if you want to use
    # the input branching
    Button_Format = "button?"    
        
#==============================================================================
# ** Rest of the script
#==============================================================================    
    Button_Regex = /#{Regexp.escape(Button_Format)}\(\:(.*)\)/
  end
end

module Input
  class << self
    alias :th_any_key_pressed_check_update :update
  end
  
  # Not every key should be checked
  Keys_To_Check = 4.upto(99) # SDL scancodes, most standard keys, no modifiers
  
  if Input.respond_to?(:raw_key_states) then # MKXP-Z 2.4 +
    def self.update
      th_any_key_pressed_check_update
      state = Input.raw_key_states
      @any_key_pressed = Keys_To_Check.any?{|key| state[key]}
    end
  else
    def self.update
      th_any_key_pressed_check_update
      state = System.raw_key_states
      @any_key_pressed = Keys_To_Check.any?{|key| state[key] != 0}
    end
  end
  
  def self.any_key_pressed?
    @any_key_pressed
  end
end

module RPG
  class Event::Page
    
    attr_accessor :button_labels
    
    def button_labels
      return @button_labels ||= []
    end
    
    alias :th_event_trigger_labels_list :list
    def list
      setup_trigger_labels unless @trigger_labels_set
      th_event_trigger_labels_list
    end
    
    def setup_trigger_labels
      @trigger_labels_set = true
      nulls = []
      if @trigger < 3
        @list.each_with_index do |cmd, index|
          if cmd.code == 118
            label = cmd.parameters[0]
            # Check for extra buttons
            if trigger_label?(label)
              nulls << index
            end
          end
        end
      end
      
      # insert "exit event processing" before each "event branch"
      nulls.reverse.each {|index|
        @list.insert(index, RPG::EventCommand.new(115))
      }
    end
    
    def trigger_label?(label)
      if label =~ TH::Event_Trigger_Labels::Button_Regex
        self.button_labels << $1.to_sym        
        return true
      end
      return false
    end
  end
end

class Game_Player < Game_Character
  
  #-----------------------------------------------------------------------------
  # Alias. Try to avoid hardcoding it
  #-----------------------------------------------------------------------------
  alias :th_trigger_labels_nonmoving :update_nonmoving
  def update_nonmoving(last_moving)
    return if $game_map.interpreter.running?
    if trigger_conditions_met?
      pre_trigger_event_processing
      triggered = check_event_label_trigger
      post_trigger_event_processing(triggered)
    end
    th_trigger_labels_nonmoving(last_moving)
  end
  
  def trigger_conditions_met?
    movable? && Input.any_key_pressed?
  end
  
  #-----------------------------------------------------------------------------
  # 
  #-----------------------------------------------------------------------------
  def pre_trigger_event_processing
  end
  
  #-----------------------------------------------------------------------------
  # New. Clean up.
  #-----------------------------------------------------------------------------
  def post_trigger_event_processing(triggered)
  end
  
  #-----------------------------------------------------------------------------
  # New. Check for any valid events in the area
  #-----------------------------------------------------------------------------
  def check_event_label_trigger
    positions_to_check_for_event.each do |x, y|
      $game_map.events_xy(x, y).each do |event|
        label = event.check_trigger_label
        
        # If no label was found, check next event
        next unless label
        
        # If the event can run, insert a jump to label command at
        # the beginning before running it
        if check_action_event
          text = [label]
          command = RPG::EventCommand.new(119, 0, text)
          event.list.insert(0, command)
          return true
        end
      end
    end
    return false
  end
  
  #-----------------------------------------------------------------------------
  # New. Positions to check events
  #-----------------------------------------------------------------------------
  def positions_to_check_for_event
    positions = [[@x, @y]]
    x2 = $game_map.round_x_with_direction(@x, @direction)
    y2 = $game_map.round_y_with_direction(@y, @direction)
    positions << [x2, y2]
    return positions unless $game_map.counter?(x2, y2)
    x3 = $game_map.round_x_with_direction(x2, @direction)
    y3 = $game_map.round_y_with_direction(y2, @direction)
    positions << [x3, y3]
    return positions
  end
end

class Game_Event

  attr_reader   :page
  attr_reader   :erased
  attr_accessor :list

  alias :th_event_trigger_labels_setup_page_settings :setup_page_settings
  def setup_page_settings(*args)
    th_event_trigger_labels_setup_page_settings
    @list = Marshal.load(Marshal.dump(@page.list.clone))
  end
  
  def check_trigger_label
    return nil if @erased
    label = get_trigger_label
    if label
      # Reset the commands (Since we maybe have inserted a jump command before)
      @needs_reset = true
    end
    return label
  end
  
  def get_trigger_label
    label = check_button_trigger
    return label if label
  end
  
  #-----------------------------------------------------------------------------
  # New. Check whether the button triggers the event
  #-----------------------------------------------------------------------------
  def check_button_trigger
    return unless button_trigger_met?
    @page.button_labels.each do |button|
      if Input.trigger?(button)
        return "#{TH::Event_Trigger_Labels::Button_Format}(:#{button})"
      end
    end
    return nil
  end
  
  def button_trigger_met?
    return false unless @page
    return false if @page.button_labels.empty?    
    return true
  end
  
  alias :th_event_trigger_labels_update :update
  def update
    th_event_trigger_labels_update
    reset_page if @needs_reset
  end
  
  def reset_page
    @needs_reset = false
    @list = Marshal.load(Marshal.dump(@page.list.clone))
  end
end