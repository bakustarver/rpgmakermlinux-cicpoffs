# CRDJ_Input.rb Kawariki MKXP-Z port
# Date: 2023-06-01
# TODO: - handle modified configuration
#       - Properly deal with the layout stuff?
#==============================================================================
# ** Input
#-------------------------------------------------------------------------------
# Created By Cidiomar R. Dias Junior
# Originally posted at 
#
# Terms of Use: Credit "Cidiomar R. Dias Junior"
#
# Maintained on Hime Works
#-------------------------------------------------------------------------------
# ** Description
#
# A module that handles input data from a gamepad or keyboard.
# Managed by symbols rather than button numbers in RGSS3.
#-------------------------------------------------------------------------------
# ** Usage
# 
# Scroll down to the configuration section. It is around line 185.
# You can set up your key mappings there. Use the reference to get the names
# of the keys.
#
#===============================================================================

module CRDJ_Input
    #--------------------------------------------------------------------------
    # * Keymap in symbols
    # To get a key from the keymap, you can use Input.key(sym) or Input:KEYMAP[sym]
    # Or if you want to use a symbol in a input function, just pass the symbol
    # as argument.
    #--------------------------------------------------------------------------
    KEYMAP = {
        LBUTTON:             0x01,  RBUTTON:           0x02,
        CANCEL:              0x03,  MBUTTON:           0x04,
        XBUTTON1:            0x05,  XBUTTON2:          0x06,
        BACK:                0x08,  TAB:               0x09,
        CLEAR:               0x0c,  RETURN:            0x0d,
        SHIFT:               0x10,  CONTROL:           0x11,
        MENU:                0x12,  PAUSE:             0x13,
        CAPITAL:             0x14,  KANA:              0x15,
        JUNJA:               0x17,  FINAL:             0x18,
        HANJA:               0x19,
        ESCAPE:              0x1b,  CONVERT:           0x1c,
        NONCONVERT:          0x1d,  ACCEPT:            0x1e,
        MODECHANGE:          0x1f,  SPACE:             0x20,
        PRIOR:               0x21,  NEXT:              0x22,
        END:                 0x23,  HOME:              0x24,
        LEFT:                0x25,  UP:                0x26,
        RIGHT:               0x27,  DOWN:              0x28,
        SELECT:              0x29,  PRINT:             0x2a,
        EXECUTE:             0x2b,  SNAPSHOT:          0x2c,
        INSERT:              0x2d,  DELETE:            0x2e,
        HELP:                0x2f,  N0:                0x30,
        KEY_1:               0x31,  KEY_2:             0x32,
        KEY_3:               0x33,  KEY_4:             0x34,
        KEY_5:               0x35,  KEY_6:             0x36,
        KEY_7:               0x37,  KEY_8:             0x38,
        KEY_9:               0x39,  colon:             0x3a,
        semicolon:           0x3b,  less:              0x3c,
        equal:               0x3d,  greater:           0x3e,
        question:            0x3f,  at:                0x40,
        LETTER_A:            0x41,  LETTER_B:          0x42,
        LETTER_C:            0x43,  LETTER_D:          0x44,
        LETTER_E:            0x45,  LETTER_F:          0x46,
        LETTER_G:            0x47,  LETTER_H:          0x48,
        LETTER_I:            0x49,  LETTER_J:          0x4a,
        LETTER_K:            0x4b,  LETTER_L:          0x4c,
        LETTER_M:            0x4d,  LETTER_N:          0x4e,
        LETTER_O:            0x4f,  LETTER_P:          0x50,
        LETTER_Q:            0x51,  LETTER_R:          0x52,
        LETTER_S:            0x53,  LETTER_T:          0x54,
        LETTER_U:            0x55,  LETTER_V:          0x56,
        LETTER_W:            0x57,  LETTER_X:          0x58,
        LETTER_Y:            0x59,  LETTER_Z:          0x5a,
        LWIN:                0x5b,  RWIN:              0x5c,
        APPS:                0x5d,  asciicircum:       0x5e,
        SLEEP:               0x5f,  NUMPAD0:           0x60,
        NUMPAD1:             0x61,  NUMPAD2:           0x62,
        NUMPAD3:             0x63,  NUMPAD4:           0x64,
        NUMPAD5:             0x65,  NUMPAD6:           0x66,
        NUMPAD7:             0x67,  NUMPAD8:           0x68,
        NUMPAD9:             0x69,  MULTIPLY:          0x6a,
        ADD:                 0x6b,  SEPARATOR:         0x6c,
        SUBTRACT:            0x6d,  DECIMAL:           0x6e,
        DIVIDE:              0x6f,  F1:                0x70,
        F2:                  0x71,  F3:                0x72,
        F4:                  0x73,  F5:                0x74,
        F6:                  0x75,  F7:                0x76,
        F8:                  0x77,  F9:                0x78,
        F10:                 0x79,  F11:               0x7a,
        F12:                 0x7b,  F13:               0x7c,
        F14:                 0x7d,  F15:               0x7e,
        F16:                 0x7f,  F17:               0x80,
        F18:                 0x81,  F19:               0x82,
        F20:                 0x83,  F21:               0x84,
        F22:                 0x85,  F23:               0x86,
        F24:                 0x87,  NUMLOCK:           0x90,
        SCROLL:              0x91,  LSHIFT:            0xa0,
        RSHIFT:              0xa1,  LCONTROL:          0xa2,
        RCONTROL:            0xa3,  LMENU:             0xa4,
        RMENU:               0xa5,  BROWSER_BACK:      0xa6,
        BROWSER_FORWARD:     0xa7,  BROWSER_REFRESH:   0xa8,
        BROWSER_STOP:        0xa9,  BROWSER_SEARCH:    0xaa,
        BROWSER_FAVORITES:   0xab,  BROWSER_HOME:      0xac,
        VOLUME_MUTE:         0xad,  VOLUME_DOWN:       0xae,
        VOLUME_UP:           0xaf,  MEDIA_NEXT_TRACK:  0xb0,
        MEDIA_PREV_TRACK:    0xb1,  MEDIA_STOP:        0xb2,
        MEDIA_PLAY_PAUSE:    0xb3,  LAUNCH_MAIL:       0xb4,
        LAUNCH_MEDIA_SELECT: 0xb5,  LAUNCH_APP1:       0xb6,
        LAUNCH_APP2:         0xb7,  cedilla:           0xb8,
        onesuperior:         0xb9,  masculine:         0xba,
        guillemotright:      0xbb,  onequarter:        0xbc,
        onehalf:             0xbd,  threequarters:     0xbe,
        questiondown:        0xbf,  Agrave:            0xc0,
        Aacute:              0xc1,  Acircumflex:       0xc2,
        Atilde:              0xc3,  Adiaeresis:        0xc4,
        Aring:               0xc5,  AE:                0xc6,
        Ccedilla:            0xc7,  Egrave:            0xc8,
        Eacute:              0xc9,  Ecircumflex:       0xca,
        Ediaeresis:          0xcb,  Igrave:            0xcc,
        Iacute:              0xcd,  Icircumflex:       0xce,
        Idiaeresis:          0xcf,  ETH:               0xd0,
        Ntilde:              0xd1,  Ograve:            0xd2,
        Oacute:              0xd3,  Ocircumflex:       0xd4,
        Otilde:              0xd5,  Odiaeresis:        0xd6,
        multiply:            0xd7,  Oslash:            0xd8,
        Ugrave:              0xd9,  Uacute:            0xda,
        Ucircumflex:         0xdb,  Udiaeresis:        0xdc,
        Yacute:              0xdd,  THORN:             0xde,
        ssharp:              0xdf,  agrave:            0xe0,
        aacute:              0xe1,  acircumflex:       0xe2,
        atilde:              0xe3,  adiaeresis:        0xe4,
        PROCESSKEY:          0xe5,  ae:                0xe6,
        PACKET:              0xe7,  egrave:            0xe8,
        eacute:              0xe9,  ecircumflex:       0xea,
        ediaeresis:          0xeb,  igrave:            0xec,
        iacute:              0xed,  icircumflex:       0xee,
        idiaeresis:          0xef,  eth:               0xf0,
        ntilde:              0xf1,  ograve:            0xf2,
        oacute:              0xf3,  ocircumflex:       0xf4,
        otilde:              0xf5,  ATTN:              0xf6,
        CRSEL:               0xf7,  EXSEL:             0xf8,
        EREOF:               0xf9,  PLAY:              0xfa,
        ZOOM:                0xfb,  NONAME:            0xfc,
        PA1:                 0xfd,  thorn:             0xfe,
        ydiaeresis:          0xff
    }

    KEYMAP[:WIN]  = [KEYMAP[:LWIN], KEYMAP[:RWIN]]

    #===============================================================================
    # Configuration
    #===============================================================================
    #--------------------------------------------------------------------------
    # * Default Keys, you can configure here instead of by pressing F1.
    #--------------------------------------------------------------------------
    UP    = [KEYMAP[:UP]]
    DOWN  = [KEYMAP[:DOWN]]
    LEFT  = [KEYMAP[:LEFT]]
    RIGHT = [KEYMAP[:RIGHT]]
    A     = [KEYMAP[:SHIFT]]
    B     = [KEYMAP[:ESCAPE], KEYMAP[:LETTER_X]]
    C     = [KEYMAP[:RETURN], KEYMAP[:LETTER_Z]]
    X     = []
    Y     = []
    Z     = []
    L     = [KEYMAP[:PRIOR]]
    R     = [KEYMAP[:NEXT]]
    F5    = [KEYMAP[:F5]]
    F6    = [KEYMAP[:F6]]
    F7    = [KEYMAP[:F7]]
    F8    = [KEYMAP[:F8]]
    F9    = [KEYMAP[:F9]]
    SHIFT = [KEYMAP[:SHIFT]]
    CTRL  = [KEYMAP[:CONTROL]]
    ALT   = [KEYMAP[:MENU]]

    #===============================================================================
    # Rest of script
    #===============================================================================
    #--------------------------------------------------------------------------
    # * Symbol version of default keys.
    #--------------------------------------------------------------------------
    SYM_KEYS = {
        :UP       => UP,
        :LEFT     => LEFT,
        :DOWN     => DOWN,
        :RIGHT    => RIGHT,
        :A        => A,
        :B        => B,
        :C        => C,
        :X        => X,
        :Y        => Y,
        :Z        => Z,
        :L        => L,
        :R        => R,
        :F5       => F5,
        :F6       => F6,
        :F7       => F7,
        :F8       => F8,
        :F9       => F9,
        :SHIFT    => SHIFT,
        :CTRL     => CTRL,
        :ALT      => ALT
    }

    # Letters that can have accent
    PssbLetters   = "AEIOUCNYaeioucny"
    # Accents, in ASCII, configured at runtime to avoid encoding troubles
    Accents = [96.chr, 180.chr, 94.chr, 126.chr, 168.chr].join
    NonCompatChars = [180, 168]

    module InputExtension
        #--------------------------------------------------------------------------
        # * Determines whether the button corresponding to the symbol sym is
        # currently being pressed.
        #
        # If the button is being pressed, returns TRUE. If not, returns FALSE.
        #
        #   if Input.press?(:C)
        #      do_something
        #   end
        #--------------------------------------------------------------------------
        def press?(keys)
            if keys.is_a?(Numeric)
                k = keys.to_i
                return (self.pressex? k)
            elsif keys.is_a?(Array)
                return keys.any? {|key| self.pressex?(key) }
            elsif keys.is_a?(Symbol)
                if SYM_KEYS.key?(keys)
                    return super(keys)
                    return SYM_KEYS[keys].any? {|key| self.pressex?(key) }
                elsif KEYMAP.key?(keys)
                    k = KEYMAP[keys]
                    return self.pressex?(k)
                else
                    return false
                end
            end
        end

        #--------------------------------------------------------------------------
        # * Determines whether the button corresponding to the symbol sym is
        # currently being pressed again.
        # "Pressed again" is seen as time having passed between the button being
        # not pressed and being pressed.
        #
        # If the button is being pressed, returns TRUE. If not, returns FALSE.
        #--------------------------------------------------------------------------
        def trigger?(keys)
            if keys.is_a?(Numeric)
                return Input.triggerex?(keys.to_i)
            elsif keys.is_a?(Array)
                return keys.any? {|key| self.triggerex?(key)}
            elsif keys.is_a?(Symbol)
                if SYM_KEYS.key?(keys)
                    return super(keys)
                    Preload.print "Trigger #{keys} #{SYM_KEYS[keys]} #{x}"
                    return SYM_KEYS[keys].any? {|key| self.triggerex?(key)}
                elsif KEYMAP.key?(keys)
                    return self.triggerex?(KEYMAP[keys])
                else
                    return false
                end
            end
        end

        #--------------------------------------------------------------------------
        # * Determines whether the button corresponding to the symbol sym is
        # currently being pressed again.
        # Unlike trigger?, takes into account the repeated input of a button being
        # held down continuously.
        #
        # If the button is being pressed, returns TRUE. If not, returns FALSE.
        #--------------------------------------------------------------------------
        def repeat?(keys)
            if keys.is_a?(Numeric)
                key = keys.to_i
                return self.repeatex?(key)
            elsif keys.is_a?(Array)
                return keys.any? {|key| self.repeatex?(key)}
            elsif keys.is_a?(Symbol)
                if SYM_KEYS.key?(keys)
                    return super(keys)
                    return SYM_KEYS[keys].any? {|key| self.repeatex?(key)}
                elsif KEYMAP.key?(keys)
                    return self.repeatex?(KEYMAP[keys])
                else
                    return false
                end
            end
        end

        #--------------------------------------------------------------------------
        # * Determines whether the button corresponding to the symbol sym
        # was released.
        #
        # If the button was released, returns TRUE. If not, returns FALSE.
        #--------------------------------------------------------------------------
        def release?(keys)
            if keys.is_a?(Numeric)
                return self.releaseex? keys.to_i
            elsif keys.is_a?(Array)
                return keys.any? {|key| self.release?(key)}
            elsif keys.is_a?(Symbol)
                if SYM_KEYS.key?(keys)
                    return super(keys)
                    return SYM_KEYS[keys].any? {|key| self.releaseex?(key)}
                elsif KEYMAP.key?(keys)
                    return self.releaseex?(KEYMAP[keys])
                else
                    return false
                end
            end
        end

        #--------------------------------------------------------------------------
        # * Checks the status of the directional buttons, translates the data into
        # a specialized 4-direction input format, and returns the number pad
        # equivalent (2, 4, 6, 8).
        #
        # If no directional buttons are being pressed (or the equivalent), returns 0.
        #--------------------------------------------------------------------------
        # def dir4
        #     return 2 if self.press?(DOWN)
        #     return 4 if self.press?(LEFT)
        #     return 6 if self.press?(RIGHT)
        #     return 8 if self.press?(UP)
        #     return 0
        # end

        #--------------------------------------------------------------------------
        # * Checks the status of the directional buttons, translates the data into
        # a specialized 8-direction input format, and returns the number pad
        # equivalent (1, 2, 3, 4, 6, 7, 8, 9).
        #
        #If no directional buttons are being pressed (or the equivalent), returns 0.
        #--------------------------------------------------------------------------
        # def dir8
        #     down = self.press?(DOWN)
        #     left = self.press?(LEFT)
        #     return 1 if down and left
        #     right = self.press?(RIGHT)
        #     return 3 if down and right
        #     up = self.press?(UP)
        #     return 7 if up and left
        #     return 9 if up and right
        #     return 2 if down
        #     return 4 if left
        #     return 6 if right
        #     return 8 if up
        #     return 0
        # end

        #--------------------------------------------------------------------------
        # * Gets the character that correspond to vk using the keyboard layout
        #--------------------------------------------------------------------------
        def get_character(vk)
            # FIXME: do something smarter
            return vk
        end

        #--------------------------------------------------------------------------
        # * Accents Table, to bo used in conversion from ASCII to UTF8
        #--------------------------------------------------------------------------
        AccentsCharsConv = {
            "A" =>  ["A", "A", "A", "A", "A"],
            "E" =>  ["E", "E", "E",  0,  "E"],
            "I" =>  ["I", "I", "I",  0,  "I"],
            "O" =>  ["O", "O", "O", "O", "O"],
            "U" =>  ["U", "U", "U",  0,  "U"],
            "C" =>  [ 0 , "C",  0 ,  0,  0 ],
            "N" =>  [ 0 ,  0,  0 , "N",  0 ],
            "Y" =>  [ 0 , "Y",  0 ,  0,  "?"],
            "a" =>  ["a", "a", "a", "a", "a"],
            "e" =>  ["e", "e", "e",  0 , "e"],
            "i" =>  ["i", "i", "i",  0 , "i"],
            "o" =>  ["o", "o", "o", "o", "o"],
            "u" =>  ["u", "u", "u",  0 , "u"],
            "c" =>  [ 0 , "c",  0 ,  0 ,  0 ],
            "n" =>  [ 0 ,  0 ,  0 , "n",  0 ],
            "y" =>  [ 0 , "y",  0 ,  0 , "y"],
        }

        @last_accent = nil

        #--------------------------------------------------------------------------
        # * Get inputed string transcoded to UTF8
        #--------------------------------------------------------------------------
        def UTF8String
            result = ""
            31.upto(255) {|key|
                if self.repeat?(key)
                    c = self.get_character(key)
                    if (cc = c.unpack("C")[0]) and NonCompatChars.include?(cc)
                        result += cc.chr
                    else
                        result += UNICODE_TO_UTF8.convertc if c != ""
                    end
                end
            }
            return "" if result == ""
            if @last_accent
                result = @last_accent + result
                @last_accent = nil
            end
            f_result = ""
            jump    = false
            for i in 0 ... result.length
                c = result[i]
                if jump
                    jump = false
                    next
                end
                if Accents.include?c
                    if (nc = result[i+1]) != nil
                        if PssbLetters.include?(nc)
                            if (ac = AccentsCharsConv[nc][Accents.indexc]) != 0
                                f_result << ac
                                jump = true
                            else
                                f_result << c
                                f_result << nc
                                jump = true
                            end
                        elsif Accents.include?(nc)
                            f_result << c
                            f_result << nc
                            jump = true
                        else
                            f_result << c
                            f_result << nc
                            jump = true
                        end
                    else
                        @last_accent = c
                    end
                else
                    f_result << c
                end
            end
            return f_result
        end
    end

    Input.singleton_class.prepend InputExtension
    Input.const_set :KEYMAP, KEYMAP
end
