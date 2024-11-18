#============================================================================
# SUPER SIMPLE MOUSE SCRIPT
# v1.10 by Shaz, mkxp port by Taeyeon Mori
#----------------------------------------------------------------------------
# This is a conversion of the XP Mouse script by Near Fantastica and
# SephirothSpawn modified by Amaranth Games, to run under VX Ace.
#----------------------------------------------------------------------------
# To Install:
# Copy and paste into a new slot in materials, below all other scripts
#----------------------------------------------------------------------------
# To Customize:
# Add keyword icon index pairs to the ICON hash (below this documentation).  
# Each of the keywords can be used in an event comment to make the mouse
# cursor change into that icon when hovering over the event.
#----------------------------------------------------------------------------
# To Use:
# Add the following comment to an event page:
#   <mouse icon [x y] [name]>
#   where icon is the keyword from the ICON hash below
#   x and y are the offsets to override player movement (optional)
#   name is the text to display next to the icon when hovering over the event (optional)
#
# Examples:
# <mouse fight>
#   will change the cursor into the 'fight' icon when over the event
# <mouse touch 0 1>
#   will change the cursor into the 'touch' icon when over the event, and
#   make the player walk to the tile below the event when the mouse button is
#   clicked
# <mouse talk Gloria>
#   will change the cursor into the 'talk' icon and display the name Gloria
# <mouse talk 0 2 Henry Smith>
#   will change the cursor into the 'talk' icon and display the name Henry Smith,
#   and when the mouse button is clicked, the player will walk to the tile
#   two below the event (good to use for shops where there's a counter in between)
#
# To force pathfinding on the player or an event, simply add a move route with
# the player or event as the subject, with a Script command, and call
# find_path(x, y) where x and y are the coordinates of the tile you want to move to
# Examples:
# Set Move Route (Player): Script: find_path(5, 8)
#   will make the player find a path to tile 5, 8
# Set Move Route (This Event): Script: find_path(10, 5)
#   will make the event find a path to tile 10, 5
#
# NOTE: The path will be ATTEMPTED.  If there is no path TO that exact tile,
# a path to an adjacent tile will be attempted.  If no path is found there
# either, no movement will occur.
# If a route is found, the player or event will begin moving towards it.  But
# if their path is blocked while they are moving, movement will be cancelled.
#----------------------------------------------------------------------------
# Author's Notes:
# This script should work with any RTP script.
# I do not guarantee that it will work with ANY other script (especially anything
# that overrides player or event movement, such as pixel movement scripts, or
# custom window scripts).
#
# Script OVERWRITES the following methods:
# Game_Map.setup_starting_map_event
# Game_Map.setup_autorun_common_event
#
# If you have other scripts that ALIAS these methods, this mouse script should 
# be placed above them.
#----------------------------------------------------------------------------
# Terms:
# Use in free and commercial games
# Credit: Near Fantastica, SephirothSpawn, Amaranth Games, Shaz
#----------------------------------------------------------------------------
# Versions:
# 1.0  -  6 Sept 2013 - initial release
# 1.02 -  7 Sept 2013 - fixed crash when loading games saved prior to adding script
#                     - fixed player gets stuck on impassable area on world map
#                       when clicking while leaving air ship
# 1.03 -  8 Sept 2013 - fixed actor moving to diagonal tile instead of adjacent
# 1.04 - 10 Sept 2013 - fixed vehicle pathfinding on world map
#                     - fixed event trigger when no path found
# 1.05 - 14 Sept 2013 - tweaked accessing of tilemap offset
# 1.06 -  3 Nov  2013 - disabled mouse movement when waiting for NPC move route
#                     - fixed events not triggering after player finishes walking
# 1.07 -  6 Nov  2013 - slow down mouse scrolling, and don't loop save files
# 1.08 - 24 Nov  2013 - cater for YEA Core large resolution with too-small maps
#                     - fixed early event activation bug introduced in 1.06
#                     - replaced calc of Windows_Selectable boundaries with item_rect
#                     - added ability to completely disable mouse
# 1.09 - 21 Dec  2013 - fixed mouse re-enable when calling common events
# 1.10 -  6 Apr  2014 - add interaction for top part of > 32pixel high event
#                     - activate an event without walking up to it
#                       (add <autoactivate> comment at top of event page)
#                     - arrow keys override mouse movement when pathfinding
#                     - ignore mouse in menus when using keyboard
#                     - make player walk to counter opposite shopkeepers
# kk1  -  5 Jan  2022 - port to mkxp-z
#============================================================================






#============================================================================
# SUPER SIMPLE MOUSE SCRIPT
# Mouse Sprite
#============================================================================


# Add/remove/change icon names here.  The icon name is what will be used in the
# event <mouse ...> command to show a different mouse icon when hovering over
# the event.  These MUST be in lower case here!
ICON = {'arrow' => 528, 'talk' => 4, 'look' => 3, 'fight' => 116,
        'touch' => 491, 'exit' => 121, 'work' => 560, 'workshowel' => 576}
DEFAULT_ICON = 'arrow'

class Sprite_Mouse < Sprite
  #--------------------------------------------------------------------------
  # * Initialization
  #--------------------------------------------------------------------------
  def initialize
    super
    self.z = 10100
    self.ox = 4
    update
    @dummy = Bitmap.new(32, 32)
    self.bitmap = Bitmap.new(32, 32)
    @enabled = true
    @ignored = false
  end
  #--------------------------------------------------------------------------
  # * Frame Update
  #--------------------------------------------------------------------------
  def update
    return if !@enabled
    super
    if !SceneManager.scene.nil?
      if !Mouse.position.nil?
        mx, my = *Mouse.position
        if @cursor == DEFAULT_ICON
          self.x = mx unless mx.nil?
        else
          self.x = [mx, Graphics.width - self.bitmap.width].min unless mx.nil?
        end
        self.y = my unless my.nil?
      end
      if @scene != SceneManager.scene.class || Mouse.trigger?
        @scene = SceneManager.scene.class
        set_bitmap
      end
    end
  end
  #--------------------------------------------------------------------------
  # * Set Bitmap
  #--------------------------------------------------------------------------
  def set_bitmap(cursor = DEFAULT_ICON, text = nil)
    if @ignored
      cursor = DEFAULT_ICON
      text = nil
    end
      
    if @cursor != cursor || @text != text
      @cursor = cursor
      @text = text
      item_cursor = ICON[cursor]
      rect = Rect.new(item_cursor % 16 * 24, item_cursor / 16 * 24, 24, 24)
      if @text.nil?
        self.bitmap = Bitmap.new(24, 32)
        self.bitmap.blt(0, 0, Cache.system('Iconset'), rect) 
      else
        w = @dummy.text_size(@text).width
        h = @dummy.font.size
        bitmap = Bitmap.new(26 + w, [32, h+2].max)
        bitmap.font.size = @dummy.font.size
        bitmap.font.shadow = true
        if self.x + 26 + w > Graphics.width
          bitmap.draw_text(0, 0, w, h, @text)
          bitmap.blt(w, 0, Cache.system('Iconset'), rect)
        else
          bitmap.blt(0, 0, Cache.system('Iconset'), rect) 
          bitmap.draw_text(26, 0, w, h, @text)
        end
        self.bitmap = bitmap
      end
    end
  end
  #--------------------------------------------------------------------------
  # * Update Event Cursors
  #--------------------------------------------------------------------------
  def update_event_cursors
    # Remove mouse icon and text if we're off the grid
    if Mouse.grid.nil?
      set_bitmap
      return
    end
    # Set cursor and text according to event
    x, y = *Mouse.grid
    event = $game_map.lowest_mouse_event_xy(x, y)
    unless event.nil? && y < 410
      if !event.mouse_icon.nil? || !event.mouse_text.nil?
        set_bitmap(event.mouse_icon, event.mouse_text)
        return
      end
    end
    # default bitmap if not over an event
    set_bitmap 
  end
  #--------------------------------------------------------------------------
  # * Enable Mouse
  #--------------------------------------------------------------------------
  def enabled=(value)
    @enabled = value
    self.visible = value
  end
  #--------------------------------------------------------------------------
  # * Mouse Enabled?
  #--------------------------------------------------------------------------
  def enabled?
    @enabled
  end
  #--------------------------------------------------------------------------
  # * Ignore Mouse
  #--------------------------------------------------------------------------
  def ignored=(value)
    @ignored = value
  end
  #--------------------------------------------------------------------------
  # * Mouse Ignored?
  #--------------------------------------------------------------------------
  def ignored?
    @ignored
  end
end

$mouse = Sprite_Mouse.new






#============================================================================
# SUPER SIMPLE MOUSE SCRIPT
# Mouse Module
#============================================================================


#==============================================================================
# ** Mouse Module
#------------------------------------------------------------------------------
#  by Near Fantastica and SephirothSpawn
#  adapted and converted to VX Ace by Shaz
#==============================================================================
module Mouse
  #--------------------------------------------------------------------------
  # * Mouse to Input Triggers
  #   key => Input::KeyCONSTANT (key: 0 - left, 1 - middle, 2 - right)
  #--------------------------------------------------------------------------
  Mouse_to_Input_Triggers = {0 => Input::C, 1 => Input::B, 2 => Input::A}
  #--------------------------------------------------------------------------
  # * Module Variables
  #--------------------------------------------------------------------------
  @old_pos = 0
  @sys_cursor_visible = true
  #--------------------------------------------------------------------------
  # * Mouse Grid Position
  #--------------------------------------------------------------------------
  def self.grid
    return nil if @pos.nil?
    return nil if !SceneManager.scene_is?(Scene_Map)
    mx, my = SceneManager.scene.instance_variable_get(:@spriteset).tilemap_offset
    x = (@pos[0] + mx) / 32
    y = (@pos[1] + my) / 32
    return [x, y]
  end
  #--------------------------------------------------------------------------
  # * Mouse Position
  #--------------------------------------------------------------------------
  def self.position
    return @pos.nil? ? [0, 0] : @pos
  end
  #--------------------------------------------------------------------------
  # * Mouse Position
  #--------------------------------------------------------------------------
  def self.pos
    return Input.mouse_x, Input.mouse_y
  end
  #--------------------------------------------------------------------------
  # * Update Mouse Position
  #--------------------------------------------------------------------------
  def self.update
    old_pos = @pos
    @pos = self.pos
    
    # Has mouse been moved?
    if old_pos != @pos
      Input.method = :mouse
    end
    
    # Which mouse to show - custom, or system?
    if $mouse.enabled? == @sys_cursor_visible
      @sys_cursor_visible = !@sys_cursor_visible
      Graphics.show_cursor = @sys_cursor_visible
    end
  end
  #--------------------------------------------------------------------------
  # * Trigger?
  #   id : 0:Left, 1:Right, 2:Center
  #--------------------------------------------------------------------------
  def self.trigger?(id = 0)
    return Input.trigger? [:MOUSELEFT, :MOUSERIGHT, :MOUSEMIDDLE][id]
  end
  #--------------------------------------------------------------------------
  # * Repeat?
  #   id : 0:Left, 1:Right, 2:Center
  #--------------------------------------------------------------------------
  def self.repeat?(id = 0)
    return Input.repeat? [:MOUSELEFT, :MOUSERIGHT, :MOUSEMIDDLE][id]
  end
  #--------------------------------------------------------------------------
  # * Client Size
  #--------------------------------------------------------------------------
  def self.client_size
    return Graphics.width, Graphics.height
  end
end






#============================================================================
# SUPER SIMPLE MOUSE SCRIPT
# Input
#============================================================================


class << Input
  #--------------------------------------------------------------------------
  # * Public Instance Variables
  #--------------------------------------------------------------------------
  attr_accessor :method
  #--------------------------------------------------------------------------
  # * Alias Listings
  #--------------------------------------------------------------------------
  alias :seph_mouse_input_update :update
  alias :seph_mouse_input_trigger? :trigger?
  alias :seph_mouse_input_repeat? :repeat?
  #--------------------------------------------------------------------------
  # * Frame Update
  #--------------------------------------------------------------------------
  def update
    $mouse.update
    Mouse.update
    seph_mouse_input_update
    # Are we using the mouse or the keyboard?
    @method = :keyboard if dir4 != 0 || dir8 != 0
  end
  #--------------------------------------------------------------------------
  # * Trigger? Test
  #--------------------------------------------------------------------------
  def trigger?(constant)
    return true if seph_mouse_input_trigger?(constant)
    if $mouse.enabled? && !Mouse.pos.nil?
      if Mouse::Mouse_to_Input_Triggers.has_value?(constant)
        return true if Mouse.trigger?(Mouse::Mouse_to_Input_Triggers.key(constant))
      end
    end
    return false
  end
  #--------------------------------------------------------------------------
  # * Repeat? Test
  #--------------------------------------------------------------------------
  def repeat?(constant)
    return true if seph_mouse_input_repeat?(constant)
    if $mouse.enabled? && !Mouse.pos.nil?
      if Mouse::Mouse_to_Input_Triggers.has_value?(constant)
        return true if Mouse.repeat?(Mouse::Mouse_to_Input_Triggers.key(constant))
      end
    end
    return false
  end
end






#============================================================================
# SUPER SIMPLE MOUSE SCRIPT
# Map
#============================================================================


class Spriteset_Map
  #--------------------------------------------------------------------------
  # * Tilemap Offset
  #--------------------------------------------------------------------------
  def tilemap_offset
    if $imported && $imported["YEA-CoreEngine"]
      [@tilemap.ox - @viewport1.rect.x, @tilemap.oy - @viewport1.rect.y]
    else
      [@tilemap.ox, @tilemap.oy]
    end
  end
end

class Game_Map
  #--------------------------------------------------------------------------
  # * Detect/Set Up Starting Map Event
  #--------------------------------------------------------------------------
  def setup_starting_map_event
    event = @events.values.find {|event| event.starting }
    event.clear_starting_flag if event
    @interpreter.setup(event.list, event.id, event.trigger_in?([0,1,2,3])) if event
    event
  end
  #--------------------------------------------------------------------------
  # * Detect/Set Up Autorun Common Event
  #--------------------------------------------------------------------------
  def setup_autorun_common_event
    event = $data_common_events.find do |event|
      event && event.autorun? && $game_switches[event.switch_id]
    end
    @interpreter.setup(event.list, 0, true) if event
    event
  end
  #--------------------------------------------------------------------------
  # * Get ID of Lowest Mouse-enabled Event at Designated Coordinates
  #--------------------------------------------------------------------------
  def lowest_mouse_event_xy(x, y)
    list = events_xy(x, y) + events_xy(x, y+1)
    list.sort! {|a, b| b.y - a.y}
    evt = nil
    list.each do |event|
      if (event.pos?(x, y) || (event.pos?(x, y+1) && event.height > 32)) &&
        (evt.nil? || event.y > evt.y)
        evt = event
        break
      end
    end
    return evt
  end
end

class Scene_Map
  #--------------------------------------------------------------------------
  # * Frame Update
  #--------------------------------------------------------------------------
  alias shaz_mouse_scene_map_update update
  def update
    $mouse.update_event_cursors
    shaz_mouse_scene_map_update
  end
end






#============================================================================
# SUPER SIMPLE MOUSE SCRIPT
# Event
#============================================================================


module RPG
  class Event
    class Page
      #--------------------------------------------------------------------
      # * Public Instance Variables
      #--------------------------------------------------------------------
      attr_reader :mouse_icon
      attr_reader :mouse_text
      attr_reader :mouse_position
      attr_reader :mouse_autoactivate
      #--------------------------------------------------------------------
      # * Build Stats
      #--------------------------------------------------------------------
      def build_stats
        # Mouse icons (icon mandatory, others optional)
        # <mouse icon destx desty name>
        @mouse_icon = nil
        @mouse_text = nil
        @mouse_position = [0, 0]
        @mouse_autoactivate = false
        # look for mouse instructions
        list.each do |command|
          if [108, 408].include?(command.code)
            comment = command.parameters[0]
              case comment
              when /<mouse/i
                params = /<mouse (.*)>/i.match(comment)[1].split(' ')
                @mouse_icon = params.shift
                if params.size > 1 && params[0] =~ /\d+/ && params[1] =~ /\d+/
                  @mouse_position = [params.shift.to_i, params.shift.to_i]
                end
                if params.size > 0
                  @mouse_text = params.join(' ')
                end
              when /<autoactivate>/
                @mouse_autoactivate = true
              end
          end #if
        end #do
      end #def
    end
  end
end

class Game_Event < Game_Character
  #--------------------------------------------------------------------------
  # * Public Instance Variables
  #--------------------------------------------------------------------------
  attr_reader   :mouse_icon
  attr_reader   :mouse_text
  attr_reader   :mouse_position
  attr_reader   :mouse_autoactivate
  #--------------------------------------------------------------------------
  # * Start Event
  #--------------------------------------------------------------------------
  alias shaz_mouse_game_event_start start
  def start
    $game_player.start_event(@id) if !empty?
    shaz_mouse_game_event_start
  end
  #--------------------------------------------------------------------------
  # * Clear Event Page Settings
  #--------------------------------------------------------------------------
  alias shaz_mouse_game_event_clear_page_settings clear_page_settings
  def clear_page_settings
    shaz_mouse_game_event_clear_page_settings
    @mouse_icon = nil
    @mouse_text = nil
    @mouse_position = [0, 0]
    @mouse_autoactivate = false
    @height = 0
  end
  #--------------------------------------------------------------------------
  # * Set Up Event Page Settings
  #--------------------------------------------------------------------------
  alias shaz_mouse_game_event_setup_page_settings setup_page_settings
  def setup_page_settings
    shaz_mouse_game_event_setup_page_settings
    @page.build_stats
    @mouse_icon         = @page.mouse_icon
    @mouse_text         = @page.mouse_text
    @mouse_position     = @page.mouse_position
    @mouse_autoactivate = @page.mouse_autoactivate
    set_size
  end
end






#============================================================================
# SUPER SIMPLE MOUSE SCRIPT
# Character
#============================================================================


class Game_CharacterBase
  attr_reader :height                            # Height of character bitmap
  #--------------------------------------------------------------------------
  # * Initialize Public Member Variables
  #--------------------------------------------------------------------------
  alias shaz_mouse_game_characterbase_init_public_members init_public_members
  def init_public_members
    shaz_mouse_game_characterbase_init_public_members
    @height = 0
  end
  #--------------------------------------------------------------------------
  # * Change Graphics
  #     character_name  : new character graphic filename
  #     character_index : new character graphic index
  #--------------------------------------------------------------------------
  alias shaz_mouse_game_characterbase_set_graphic set_graphic
  def set_graphic(character_name, character_index)
    shaz_mouse_game_characterbase_set_graphic(character_name, character_index)
    set_size
  end
  #--------------------------------------------------------------------------
  # * Set character width/height size
  #--------------------------------------------------------------------------
  def set_size
    bw = Cache.character(@character_name).width
    bh = Cache.character(@character_name).height
    sign = @character_name[/^[\!\$]./]
    if sign && sign.include?('$')
      @width = bw / 3
      @height = bh / 4
    else
      @width = bw / 12
      @height = bh / 8
    end
  end
  #--------------------------------------------------------------------------
  # * Detect Collision with Event
  #--------------------------------------------------------------------------
  def collide_with_events?(x, y)
    $game_map.events_xy_nt(x, y).any? do |event|
      self != event && (event.normal_priority? || self.is_a?(Game_Event))
    end
  end
  #--------------------------------------------------------------------------
  # * Detect Collision with Vehicle
  #--------------------------------------------------------------------------
  def collide_with_vehicles?(x, y)
    !self.is_a?(Game_Player) && ($game_map.boat.pos_nt?(x, y) || $game_map.ship.pos_nt?(x, y))
  end
  #--------------------------------------------------------------------------
  # * Frame Update
  #--------------------------------------------------------------------------
  alias shaz_mouse_game_characterbase_update update
  def update
    run_path if @runpath
    shaz_mouse_game_characterbase_update
  end
  #--------------------------------------------------------------------------
  # * Run Path
  #--------------------------------------------------------------------------
  def run_path
    return if moving?
    @step = @map.nil? || @map[@x, @y].nil? ? 0 : @map[@x, @y] - 1
    if @step < 1
      clear_path
    else
      x, y = @x, @y
      dirs = []
      dirs.push(6) if @map[@x+1, @y] == @step && passable?(@x, @y, 6)
      dirs.push(2) if @map[@x, @y+1] == @step && passable?(@x, @y, 2)
      dirs.push(4) if @map[@x-1, @y] == @step && passable?(@x, @y, 4)
      dirs.push(8) if @map[@x, @y-1] == @step && passable?(@x, @y, 8)
      while dirs.size > 0
        dir = dirs.delete_at(rand(dirs.size))
        move_straight(dir)
        break if x != @x || y != @y
      end
      # clear the path if we couldn't move
      clear_path if x == @x && y == @y
    end
  end
  #--------------------------------------------------------------------------
  # * Find Path
  #--------------------------------------------------------------------------
  def find_path(x, y)
    sx, sy = @x, @y
    @tx, @ty = x, y
    result = setup_map(sx, sy)
    @runpath = result[0]
    @map = result[1]
    @map[sx, sy] = result[2] if result[2] != nil
  end
  #--------------------------------------------------------------------------
  # * Clear Path
  #--------------------------------------------------------------------------
  def clear_path
    @map = nil
    @runpath = false
  end
  #--------------------------------------------------------------------------
  # * Setup Map
  #--------------------------------------------------------------------------
  def setup_map(sx, sy)
    map = Table.new($game_map.width, $game_map.height)
    update_counter = 0
    map[@tx, @ty] = 1
    old_positions = [[@tx, @ty]]
    new_positions = []
    
    # if tile is impassable, but CAN move to adjacent tiles, use the adjacent tiles instead
    if (!passable?(@tx, @ty, 2) && !passable?(@tx, @ty, 4) &&
      !passable?(@tx, @ty, 6) && !passable?(@tx, @ty, 8)) ||
      $game_map.events_xy_nt(@tx, @ty).any? { |evt| evt.normal_priority? && evt != self }
      old_positions = []
      
      # Can we move from the destination tile in any direction?
      if map_passable?(@tx, @ty, 2)
        map[@tx, @ty+1] = 1
        old_positions.push([@tx, @ty+1])
      end
      if map_passable?(@tx, @ty, 8)
        map[@tx, @ty-1] = 1
        old_positions.push([@tx, @ty-1])
      end
      if map_passable?(@tx, @ty, 4)
        map[@tx-1, @ty] = 1
        old_positions.push([@tx-1, @ty])
      end
      if map_passable?(@tx, @ty, 6)
        map[@tx+1, @ty] = 1
        old_positions.push([@tx+1, @ty])
      end
      
      # If not, can we at least move up to the destination tile?
      if old_positions.size == 0
        if map_passable?(@tx-1,@ty,6)
          map[@tx-1,@ty] = 1
          old_positions.push([@tx-1,@ty])
        end
        if map_passable?(@tx+1,@ty,4) 
          map[@tx+1,@ty] = 1
          old_positions.push([@tx+1,@ty])
        end
        if map_passable?(@tx,@ty-1,2)
          map[@tx,@ty-1] = 1
          old_positions.push([@tx,@ty-1])
        end
        if map_passable?(@tx,@ty+1,8)
          map[@tx,@ty+1] = 1
          old_positions.push([@tx,@ty+1])
        end
      end
    end
    
    # If there are any counters, can we move to the tile on the other side?
    if map_passable?(@tx-2,@ty,6) && $game_map.counter?(@tx-1,@ty)
      map[@tx-2,@ty] = 1
      old_positions.push([@tx-2,@ty])
    end
    if map_passable?(@tx+2,@ty,4) && $game_map.counter?(@tx+1,@ty)
      map[@tx+2,@ty] = 1
      old_positions.push([@tx+2,@ty])
    end
    if map_passable?(@tx,@ty-2,2) && $game_map.counter?(@tx,@ty-1)
      map[@tx,@ty-2] = 1
      old_positions.push([@tx,@ty-2])
    end
    if map_passable?(@tx,@ty+2,2) && $game_map.counter?(@tx,@ty+1)
      map[@tx,@ty+2] = 1
      old_positions.push([@tx,@ty+2])
    end
    
    
    depth = 2
    depth.upto(100) { |step|
      break if old_positions[0].nil?
      @step = step
      loop do
        break if old_positions[0].nil?
        x, y = old_positions.shift
        return [true, map, @step-1] if x == sx && y == sy
        if map[x, y + 1] == 0 && passable?(x, y, 2)
          map[x, y + 1] = @step
          new_positions.push([x, y + 1])
        end
        if map[x - 1, y] == 0 && passable?(x, y, 4)
          map[x - 1, y] = @step
          new_positions.push([x - 1, y])
        end
        if map[x + 1, y] == 0 && passable?(x, y, 6)
          map[x + 1, y] = @step
          new_positions.push([x + 1, y])
        end
        if map[x, y - 1] == 0 && passable?(x, y, 8)
          map[x, y - 1] = @step
          new_positions.push([x, y - 1])
        end
        # Update graphics? (to reduce lag)
        update_counter += 1
        if update_counter > 50
          Graphics.update
          update_counter = 0
        end
      end
      old_positions = new_positions
      new_positions = []
    }
    return [false, nil, nil]
  end
end  

class Game_Character < Game_CharacterBase
  #--------------------------------------------------------------------------
  # * Force Move Route
  #--------------------------------------------------------------------------
  alias shaz_mouse_game_character_force_move_route force_move_route
  def force_move_route(move_route)
    clear_path
    shaz_mouse_game_character_force_move_route(move_route)
  end
end






#============================================================================
# SUPER SIMPLE MOUSE SCRIPT
# Player
#============================================================================


class Game_Player < Game_Character
  #--------------------------------------------------------------------------
  # * Trigger Map Event
  #     triggers : Trigger array
  #     normal   : Is priority set to [Same as Characters] ?
  #--------------------------------------------------------------------------
  alias shaz_mouse_game_player_start_map_event start_map_event
  def start_map_event(x, y, triggers, normal)
    @started_events = []
    shaz_mouse_game_player_start_map_event(x, y, triggers, normal)
  end
  #--------------------------------------------------------------------------
  # * Start Event
  #--------------------------------------------------------------------------
  def start_event(event_id)
    @started_events = [] if @started_events.nil?
    @started_events.push(event_id)
  end
  #--------------------------------------------------------------------------
  # * Processing of Movement via Input from Directional Buttons
  #--------------------------------------------------------------------------
  alias shaz_mouse_game_player_move_by_input move_by_input
  def move_by_input
    if Input.dir4 > 0
      clear_path
      shaz_mouse_game_player_move_by_input
    else
      # Move by mouse input
      if !$game_message.busy? && !$game_message.visible && !@move_route_forcing &&
        !@vehicle_getting_on && !@vehicle_getting_off && 
        Mouse.trigger?(0) && !Mouse.grid.nil? && !$mouse.ignored?
        mx, my = *Mouse.grid
        # turn in direction
        if (@x - mx).abs >= (@y - my).abs
          set_direction(@x > mx ? 4 : 6)
        else
          set_direction(@y > my ? 8 : 2)
        end
        # find path
        @event = $game_map.lowest_mouse_event_xy(mx, my)
        if @event.nil?
          find_path(mx, my)
        elsif @event.mouse_autoactivate
          @event.start
          @started_events = []
          clear_path
        else
          find_path(@event.x + @event.mouse_position[0], 
            @event.y + @event.mouse_position[1])
        end
      end
    end
  end
  #--------------------------------------------------------------------------
  # * Frame Update
  #--------------------------------------------------------------------------
  alias shaz_mouse_game_player_update update
  def update
    shaz_mouse_game_player_update
    update_pathfinding if !@event.nil? && !moving?
  end
  #--------------------------------------------------------------------------
  # * Check event after pathfinding
  #--------------------------------------------------------------------------
  def update_pathfinding
    if @map.nil? || @map[@x, @y] <= 1
      dir = @x < @event.x ? 6 : @x > @event.x ? 4 : @y < @event.y ? 2 : @y > @event.y ? 8 : 0
      # Face event and trigger it (only if not triggered by start_map_event)
      turn_toward_character(@event) if !@event.pos?(@x, @y)
      if !@started_events.include?(@event.id) && !@map.nil? && !in_airship?
        @event.start 
        @started_events = []
      end
      clear_path
    end
  end
  #--------------------------------------------------------------------------
  # * Clear Path
  #--------------------------------------------------------------------------
  def clear_path
    @event = nil
    super
  end
end






#============================================================================
# SUPER SIMPLE MOUSE SCRIPT
# Interpreter
#============================================================================


class Game_Interpreter
  #--------------------------------------------------------------------------
  # * Event Setup
  #--------------------------------------------------------------------------
  alias shaz_mouse_game_interpreter_setup setup
  def setup(list, event_id = 0, lock_player = false)
    shaz_mouse_game_interpreter_setup(list, event_id)
    @lock_player = lock_player
  end
  #--------------------------------------------------------------------------
  # * Execute
  #--------------------------------------------------------------------------
  alias shaz_mouse_game_interpreter_run run
  def run
    $mouse.ignored = true if @lock_player
    shaz_mouse_game_interpreter_run
    $mouse.ignored = false if @lock_player
  end
end






#============================================================================
# SUPER SIMPLE MOUSE SCRIPT
# Windows
#============================================================================


class Window_Selectable < Window_Base
  #--------------------------------------------------------------------------
  # * Frame Update
  #--------------------------------------------------------------------------
  alias shaz_mouse_window_selectable_update update
  def update
    shaz_mouse_window_selectable_update
    process_mouse_handling if Input.method == :mouse
  end
  #--------------------------------------------------------------------------
  # * Mouse Movement Processing
  #--------------------------------------------------------------------------
  def process_mouse_handling
    return unless $mouse.enabled? && cursor_movable?
    # Add a delay to prevent too-fast scrolling
    @delay = @delay ? @delay + 1 : 0
    return if @delay % 3 > 0
    
    mx, my = *Mouse.position
    vx = self.viewport ? self.x - self.viewport.ox + self.viewport.rect.x : self.x
    vy = self.viewport ? self.y - self.viewport.oy + self.viewport.rect.y : self.y
    if mx.between?(vx, vx + self.width) &&
      my.between?(vy, vy + self.height)
      mx -= vx 
      mx -= padding
      my -= vy 
      my -= padding
      my += oy 
      for i in 0 ... item_max
        rect = item_rect(i)
        if mx.between?(rect.x, rect.x + rect.width) &&
          my.between?(rect.y, rect.y + rect.height)
          last_index = @index
          select(i)
          if @index != last_index
            Sound.play_cursor 
          end
          break
        end
      end
    end
  end
end  

class Window_NameInput < Window_Selectable
  #--------------------------------------------------------------------------
  # * Mouse Movement Processing
  #--------------------------------------------------------------------------
  def process_mouse_handling
    return unless $mouse.enabled?
    # Add a delay to prevent too-fast scrolling
    @delay = @delay ? @delay + 1 : 0
    return if @delay % 3 > 0
    
    mx, my = *Mouse.position
    vx = (self.viewport ? self.x - self.viewport.ox + self.viewport.rect.x : self.x) + padding
    vy = (self.viewport ? self.y - self.viewport.oy + self.viewport.rect.y : self.y) + padding
    if mx.between?(vx, vx + self.width - padding * 2) &&
      my.between?(vy, vy + self.height - padding * 2)
      mx -= vx 
      my -= vy 
      x = (mx > 5*32+16 ? mx-16 : mx) / 32 
      y = my / line_height
      last_index = @index
      @index = y * 10 + x
      Sound.play_cursor if @index != last_index
    end
  end
end

class Scene_File < Scene_MenuBase
  #--------------------------------------------------------------------------
  # * Update Cursor
  #--------------------------------------------------------------------------
  alias shaz_mouse_scene_file_update_cursor update_cursor
  def update_cursor
    shaz_mouse_scene_file_update_cursor
    process_mouse_handling if Input.method == :mouse
  end
  #--------------------------------------------------------------------------
  # * Mouse Movement Processing
  #--------------------------------------------------------------------------
  def process_mouse_handling
    return unless $mouse.enabled?
    # Add a delay to prevent too-fast scrolling
    @delay = @delay ? @delay + 1 : 0
    return if @delay % 3 > 0
    
    mx, my = *Mouse.position
    vx = @savefile_viewport.ox + mx
    vy = @savefile_viewport.oy + my
    last_index = @index
    new_index = vy / savefile_height
    if @index != new_index
      if new_index > @index
        cursor_down(false)
      else
        cursor_up(false)
      end
      Sound.play_cursor
      @savefile_windows[last_index].selected = false
      @savefile_windows[@index].selected = true
    end
  end
end

#==============================================================================
# ** Game_Player
#------------------------------------------------------------------------------
#  This class handles the player. It includes event starting determinants and
# map scrolling functions. The instance of this class is referenced by
# $game_player.
#==============================================================================

class Game_Player < Game_Character
  #--------------------------------------------------------------------------
  # * Frame Update
  #--------------------------------------------------------------------------
  alias amn_shazmouse_gameplayer_mousesupport_update  update
  def update
    amn_shazmouse_gameplayer_mousesupport_update
    stop_movement_if_message
  end
 
  def stop_movement_if_message
    clear_path if $game_message.busy? || $game_message.visible
  end
 
end