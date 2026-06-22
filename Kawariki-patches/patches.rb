# Kawariki MKXP patch/port collection
# See preload.rb for Patch implementation

module Preload
    Patches = [
        # Ports
        Patch.new("Zeus Fullscreen: Use mkxp builtin fullscreen instead (Alt+Enter)")
            .imported?(:Zeus_Fullscreen)
            .replace!("Zeus_Fullscreen++.rb"),
        Patch.new("Zeus_Lights_Shadows fix")
            .imported?(:Zeus_Lights_Shadows)
            .sub!(/^RPG_VERSION =.*/, "RPG_VERSION ="+ ENV["vcode"])
            .sub!(" def update_animation_value", "def update_animation_Integer(str,str2,str3,str4,str5) @wave_amp = 0.0; end\ndef update_animation_value"),
        Patch.new("cyanic-SteamUserStatsLite fix")
            .include?('Win32API.new(self.steam_dll_name')
            # .remove!,
            .replace!("achievements.rb"),
        Patch.new("TH AnyKeyPressedCheck: replace DL buffer with Ruby String buffer")
            .include?('Any Key Pressed Check')
            .sub!(/@state\s*=.*/, '@state = "\x00" * 256')
            .sub!('GetKeyboardState.call(@state.to_i)', 'GetKeyboardState.call(@state)')
            .sub!('@state[key]', '@state.getbyte(key)'),
        Patch.new("WF-RGSS Scripts ")
            .include?('共通スクリプト(XP/VX/VXAce両対応版)')
        #     .include?('http://www.whiteflute.org/wfrgss/')
             # .remove!,
            .replace!("0.rb"),
        Patch.new("WF-RGSS Scripts ")
            .include?('共通実行スクリプト(XP/VX/VXAce両対応版)')
        #     .include?('http://www.whiteflute.org/wfrgss/')
             # .remove!,
            .replace!("144.rb"),
        # Patch.new("Advanced Text System fix")
        #     .include?('Advanced Text System')
        #     .include?('modern algebra (rmrk.net)')
        #     .include?('Version: 3.0c')
        # #     # .remove!,
        #     .replace!("tem.rb"),
        Patch.new("rpgmaker vx window crash")
            .include?('class Window_Command < Window_Selectable')
            .include?('def initialize(width, commands, column_max = 1, row_max = 0, spacing = 32)')
                     .sub!("if row_max == 0", "  if commands.is_a?(Hash)\ncommands = commands.values\nend\nif row_max == 0"),
        Patch.new("Monster girl quest paradox remove selectable")
            .include?('module NWFeature')
            .sub!('module NWFeature', "module Kernel\n  remove_method :select\nend\nmodule NWFeature"),
        Patch.new("AudioUtilities plugin fix")
            .include?('waveOutOpen=Win32API.new("winmm.dll","waveOutOpen","plplll","l")')
            .include?('def pbPlaySoundData(samples,volume,async=false,sampleFreq=11025)')
            # .remove!,
            # .replace!("dummyAudioUtilities.rb")
             .sub!(/when (\d+):/, 'when \1'),
        Patch.new("XIV's Simple Reputation System (SRS) for RGSS3 fix") #XIV's Simple Reputation System (SRS) for RGSS3 Romance Level Version: 1.1
            .include?("Simple Reputation System (SRS)")
            .sub!("$scene1 = Scene_Menu.new(0)", "$scene1 = Scene_Menu.new"),
        Patch.new("Nergal's Item Finding patch fix") #Nergal's Item Finding
            .include?("SEARCH_TYPES = [ ITEMS_TO_FIND_PERSON, ITEMS_TO_FIND_SCHOOL,")
            .include?("$scene1 = Scene_Menu.new(0)")
            .sub!("$scene1 = Scene_Menu.new(0)", "$scene1 = Scene_Menu.new"),
        Patch.new("Nergal's XP Gain") #Nergal's XP Gain
            .include?("CustomGab.display_message(stat + XpLevel::MAX_LVL_MESSAGE)")
            .include?("$scene4 = Scene_Menu.new(0)")
            .sub!("$scene4 = Scene_Menu.new(0)", "$scene4 = Scene_Menu.new"),
        Patch.new("Audio_EX2 WF-RGSS patch") #【WF-RGSS】共通rev29 base
            .include?("module WFRGSS_AudioEX")
            # .sub!("return true if @audio__init", "return true"),
            # .include?("self.to_widechar(")
            .replace!("dummy_Audio_EX2.rb"),

        Patch.new("window check content height fix (mgq paradox)") #Window_Base
             .if? {|script| script.name == "Window_Base"}
             # .replace!("basewt.rb"),
            .sub!("if contents_width > 0 && contents_height > 0", "if contents_height > 10000\nself.contents = Bitmap.new(1, 1)\nelsif contents_width > 0 && contents_height > 0")
            .sub!("result = text.to_s.clone","result = text.to_s.clone\nresult = result.dup if result.frozen?"),
        Patch.new("temp bitmap load crash fix monster girl paradox disable preview") #ベース/Module
        #     #maybe the memory buffer is filled up too much??
        #      # .if? {|script| script.name == "Window_Base"}
        .include?('thumnail_file = "Save/Save#{Regexp')
        # .sub!("@thumbnails[Regexp.last_match(1).to_i - 1] = Bitmap.new(thumnail_file)", "@thumbnails[Regexp.last_match(1).to_i - 1] = @dummy_thumbnail #Bitmap.new(thumnail_file)")
        .sub!("@thumbnails[Regexp.last_match(1).to_i - 1] = Bitmap.new(thumnail_file)", "@thumbnails[Regexp.last_match(1).to_i - 1] = @dummy_thumbnail #Bitmap.new(thumnail_file)"),
        # .replace!("base_Module.rb"),
             # .replace!("savebitmanwin32api.rb"),
        Patch.new("WF-RGSS Exit-EX patch test") #▼ メイン【WF-RGSS】Exit-EX 終了処理
              .include?("Win32API.new('System/WFExit','hookExit','v','l')")
              # .remove!,
              .replace!("wxexittest.rb"),
        Patch.new("HimeWorks' Event Trigger Labels: Fix any_key_pressed? implementation")
            .imported?(:TH_EventTriggerLabels)
            .replace!("TH_EventTriggerLabels.rb"),
        Patch.new("HimeWorks' Simple Audio Encryption: Re-Implement with direct path detection")
            .imported?(:TH_SimpleAudioEncryption)
            .replace!("TH_SimpleAudioEncryption.rb"),
        Patch.new("MOG_Anti_Lag: Fix visible type error")
            .imported?(:mog_anti_lag)
            .sub!("self.visible = @character.can_update", "self.visible = !!@character.can_update"),
        Patch.new("KGC_BitmapExtension ? XP/VX ? error")
            .imported?(:BitmapExtension)
            # .sub!("class Win32API", "module Win32API"),
             .remove!,
        Patch.new("Galv's Event Pop-Ups: Fix bitmap constructor call")
            .imported?("Galv_Map_Popups")
            .match?(/\.font\.shadow\s*=\s*\d+/)
            .sub!(/\.font\.shadow\s*=\s*\d+/, ".font.shadow = true"),
        Patch.new("Basic Mouse Plugin test disable for now")
            .imported?(nil)
            .if? {|script| script.name == "BasicMouse"}
            .include?("include IBasicMouse")
            .sub!("def VZ; return @curr.lZ / 120; end", "def VZ; return 0 if @curr.nil? || @curr.lZ.nil?;  return @curr.lZ / 120.0 end"),
        # Patch.new("Screenshot plugin")
        #     .imported?(nil)
        #     .include?('SAVE_NAME = "ScreenShot/%Y%m%d%H%M%S.png"')
        #     # .sub!("def VZ; return @curr.lZ / 120; end", "def VZ; return 0 if @curr.nil? || @curr.lZ.nil?;  return @curr.lZ / 120.0 end"),
        #     # .replace!("BasicMouse.rb"),
        #     .remove!,
        Patch.new("Super simple mouse script: Use mkxp mouse API")
            .imported?(nil)
            .include?("SUPER SIMPLE MOUSE SCRIPT")
            .replace!("Mouse.rb"),
        Patch.new("RMXP CustomResolution plugin")
            .imported?(nil)
            .include?("def snapshot(filename = 'Data/snap', quality = 0)")
            .replace!("XP_CustomResolution.rb"),
        Patch.new("Glitchfinder's Key Input: Shim with MKXP builtins")
            .imported?(nil)
            .include?("unless method_defined?(:keyinputmodule_input_update)")
            .replace!("Glitchfinder_Keyboard_Stub.rb"),
        Patch.new("Auto Font Install: Already included in MKXP")
            .imported?(nil)
            .include?("# ** Auto Font Install")
            .remove!,
        Patch.new("Extended Music Script: MKXP already supports .mod. other formats aren't available.")
            .imported?(nil)
            .include?("# Extended Music Script Version 3.5")
            .then!{|script|
                return if script.context.flag? :incompatible_bgm_checked
                unsupp = "wma,psf,minipsf,psf2,minipsf2,gsf,minigsf,usf,miniusf,hps,dsp,spc,gym,cym".split(",")
                # TODO: Find unsupported files in Audio/BGM. Then show msgbox if no converted versions available
                # Official MKXP-Z also doesn't support mp3
                script.context.mark :incompatible_bgm_checked
            }
            .remove!,
        Patch.new("CRDJ Input script: Use MKXP-Z input extensions")
            .imported?(nil)
            .include?("# A module that handles input data from a gamepad or keyboard.\r\n# Managed by symbols rather than button numbers in RGSS3.")
            .replace!("CRDJ_Input.rb"),
        # Specific Inline Patches
        Patch.new("Try to fix superclass mismatches from MP Scene_Base")
        .imported?(nil)
        .include?("======\nMoonpearl's Scene_Base\n-----")
        .flag!(:redefinitions_overwrite_class),
        # Generic Inline Patches
        Patch.new("Disable all font effects")
            .flag?(:no_font_effects) # KAWARIKI_MKXP_NO_FONT_EFFECTS
            .match?(/(\.f|F)ont\.(default_)?(italic|outline|shadow|bold)/)
            # Font is a built-in API, so it's already available in preload
            .then!{Font.default_italic = Font.default_outline = Font.default_shadow = Font.default_bold = false}
            .sub!(/Font\.default_(italic|outline|shadow|bold)\s*=/, "Font.default_\\1 = false &&")
            .sub!(/\.font\.(italic|outline|shadow|bold)\s*\=/, ".font.\\1 = false &&"),
        Patch.new("Improve Ruby 1.8 Compatibility")
            .if?{|script| script.context[:rgss_version] < 3} # Never on VX Ace, which shipped 1.9
            .match?("self.type", /\Wtype\.to_s\W/, /\Winstance_methods\.include\?\(['"%]/)
            .then!{require "ruby18.rb"},
        Patch.new("Game_Player fix")
            .imported?(nil)
            .if? {|script| script.name == "Game_Player"}
            .if? {|script| script.source.include? "else return true"}
            .sub!("else return true", "true"),
        Patch.new("KGC Bitmap Extension fix")
            .imported?(nil)
            .if? {|script| script.source.include? "@@reel_stop = RPG::SE.new(CAO::PSLOT::SOUND_REEL_STOP"}
            .sub!("@@reel_stop =", "@reel_stop ="),
        Patch.new("Response improvement remove")
            .imported?(nil)
            .match?(/#.*_wdtk_resinp_update/)
             .remove!,
        Patch.new("Response improvement patch")
            .imported?(nil)
            # .if? {|script| script.name == "Response improvement script"}
            #.include?('@@press_count.each do')
            .if? {|script| script.source.include? "_wdtk_resinp_update" }
            .sub!('@@press_count', "@press_count")
            .sub!(/\b_wdtk_resinp_update\b(?!\s*update)/, "_wdtk_resinp_update;\n@press_count ||= {}"),
            # .sub!(/^(?!#.*)\b_wdtk_resinp_update\b(?!\s*update)/, "_wdtk_resinp_update;\n@press_count ||= {}"),
            # .sub!(/^(?!#.*)\b_wdtk_resinp_update\b(?!\s*update)/) { "_wdtk_resinp_update;\n@press_count ||= {}" },
        Patch.new("Item Script")
            .imported?(nil)
            # .if? {|script| script.name == "Response improvement script"}
            #.include?('@@press_count.each do')
            .include?("CATEGORIZE ITEM SCENE v1.0 ")
            # .if? {|script| script.source.include? "_wdtk_resinp_update"}
            .sub!("CATEGORY_IDENTIFIER.index(ITEM_DEFAULT_CATEGORY)", "CATEGORY_IDENTIFIER.keys.index(ITEM_DEFAULT_CATEGORY)")
            .sub!("CATEGORY_IDENTIFIER.index(:", "CATEGORY_IDENTIFIER.key(:"),
        Patch.new("Vitaminpl fix")
            .imported?(nil)
            .if? {|script| script.name == "Police"}
            .if? {|script| script.source.include? "Lucida Sans Unicode"}
            .if? {|script| script.source = "Font.default_size = 16"},
        Patch.new("Vitaminpl 2 fix")
            .imported?(nil)
            .include?("module Wora_NSS")
            .sub!("SCREENSHOT_IMAGE = true", "SCREENSHOT_IMAGE = false")
            .sub!("PREMADE_IMAGE = true", "PREMADE_IMAGE = false"),
        Patch.new("Dark Hero Party")
            .imported?(nil)
            .include?('text.push(self.to_s.scan(/#<(\S+):/)[0][0].to_s)')
            .remove!,
        Patch.new("Diesel_ADV")
            .imported?(nil)
            .include?('Diesel_ADV')
            .sub!("b.visible = now", "b.visible = !!now"),
        # Patch.new("tktk_bitmap dll test debug")
        #     .imported?(nil)
        #     .include?("DLL_NAME = 'tktk_bitmap'")
        #     # .remove!,
        #     .replace!("bitmap_tktk.rb"),
        Patch.new("HN_Light tktk dll disable ")
            .imported?(nil)
            .include?("HN_Light version")
            .include?("tktkgame")
            .sub!("@dark_sprite.update", "@dark_sprite.dispose"),
            # .replace!("lamp.rb"),
        Patch.new("message_npi fix")
            .imported?(nil)
            .include?("module MessageTextDataBase")
            .include?("BlueRedZone")
        #     #.sub!("@dark_sprite.update", "@dark_sprite.dispose"),
            .replace!("message_npi.rb"),
        Patch.new("test subscribe")
             .imported?(nil)
             .include?("exit if steam.is_subscribed != true")
             .remove!,
        Patch.new("module ScreenShot")
             .imported?(nil)
             .include?("module ScreenShot")
             .include?("http://d.hatena.ne.jp/ku-ma-me/20091003/p1")
             .remove!,
        Patch.new("winmm joystick disable")
             .include?("Input 入力拡張スクリプト")
             .remove!,
        Patch.new("wfcrypt")
             .include?('Win32API.new("wfcrypt"')
             .remove!,
        Patch.new("disable draw_text_FONT")
             .include?("alias draw_text_ORG draw_text unless")
             .remove!,
        Patch.new("add input raw keys pokemon")
             .include?("def pbSameThread")
             .include?("module Input")
             .sub!("def pbSameThread(", "module Input; class << self; alias_method :_spork_old_update, :update; alias_method :_spork_old_raw_key_states, :raw_key_states; def raw_key_states; _spork_old_update; _spork_old_raw_key_states; end; end; end\ndef pbSameThread("),
        Patch.new("Trgssx win32") #TRGSSX.dll
             # .imported?("BitmapExtension")
             .include?("ビットマップ拡張 - KGC_BitmapExtension ◆ XP/VX")
             # .include?("http://d.hatena.ne.jp/ku-ma-me/20091003/p1")
             .remove!,
        Patch.new("Fix frozen String in Window_Base#convert_escape_characters")
            .include?('CAO_SP (cacao service pack) 2012.10.04')
            .include?('def convert_escape_characters(text)')
            .sub!("result = text.to_s.clone", "result = text.to_s.dup"),
    ]
end

