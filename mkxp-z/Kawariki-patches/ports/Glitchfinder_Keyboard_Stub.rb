# Glitchfinder's Key Input MKXP stub
# Only press? trigger? release? repeat? implemented
# Direct forwarding to respective MKXP Input.*ex? methods
# Key constants copied from 1.30 source
# ANYKEY is not implemented by MKXP
#
# Authors: Glitchfinder, Taeyeon Mori
# Date: 2022-01-31

module Keys
    # ****************************** Key names ********************************
    #--------------------------------------------------------------------------
    # * Miscellaneous Keys
    #--------------------------------------------------------------------------
    CANCEL              = 0x03 # Control-Break Processing
    BACKSPACE           = 0x08 # Backspace Key
    TAB                 = 0x09 # Tab Key
    CLEAR               = 0x0C # Clear Key
    RETURN              = 0x0D # Enter Key
    SHIFT               = 0x10 # Shift Key
    CONTROL             = 0x11 # Ctrl Key
    MENU                = 0x12 # Alt Key
    PAUSE               = 0x13 # Pause Key
    ESCAPE              = 0x1B # Esc Key
    CONVERT             = 0x1C # IME Convert Key
    NONCONVERT          = 0x1D # IME Nonconvert Key
    ACCEPT              = 0x1E # IME Accept Key
    SPACE               = 0x20 # Space Bar Key (Space, usually blank)
    PRIOR               = 0x21 # Page Up Key
    NEXT                = 0x22 # Page Down Key
    ENDS                = 0x23 # End Key
    HOME                = 0x24 # Home Key
    LEFT                = 0x25 # Left Arrow Key
    UP                  = 0x26 # Up Arrow Key
    RIGHT               = 0x27 # Right Arrow Key
    DOWN                = 0x28 # Down Arrow Key
    SELECT              = 0x29 # Select Key
    PRINT               = 0x2A # Print Key
    EXECUTE             = 0x2B # Execute Key
    SNAPSHOT            = 0x2C # Print Screen Key
    DELETE              = 0x2E # Delete Key
    HELP                = 0x2F # Help Key
    LSHIFT              = 0xA0 # Left Shift Key
    RSHIFT              = 0xA1 # Right Shift Key
    LCONTROL            = 0xA2 # Left Control Key (Ctrl)
    RCONTROL            = 0xA3 # Right Control Key (Ctrl)
    LMENU               = 0xA4 # Left Menu Key (Alt)
    RMENU               = 0xA5 # Right Menu Key (Alt)
    PACKET              = 0xE7 # Used to Pass Unicode Characters as Keystrokes
    #--------------------------------------------------------------------------
    # * Number Keys
    #--------------------------------------------------------------------------
    N0                  = 0x30 # 0 Key
    N1                  = 0x31 # 1 Key
    N2                  = 0x32 # 2 Key
    N3                  = 0x33 # 3 Key
    N4                  = 0x34 # 4 Key
    N5                  = 0x35 # 5 Key
    N6                  = 0x36 # 6 Key
    N7                  = 0x37 # 7 Key
    N8                  = 0x38 # 8 Key
    N9                  = 0x39 # 9 Key
    #--------------------------------------------------------------------------
    # * Letter Keys
    #--------------------------------------------------------------------------
    A                   = 0x41 # A Key
    B                   = 0x42 # B Key
    C                   = 0x43 # C Key
    D                   = 0x44 # D Key
    E                   = 0x45 # E Key
    F                   = 0x46 # F Key
    G                   = 0x47 # G Key
    H                   = 0x48 # H Key
    I                   = 0x49 # I Key
    J                   = 0x4A # J Key
    K                   = 0x4B # K Key
    L                   = 0x4C # L Key
    M                   = 0x4D # M Key
    N                   = 0x4E # N Key
    O                   = 0x4F # O Key
    P                   = 0x50 # P Key
    Q                   = 0x51 # Q Key
    R                   = 0x52 # R Key
    S                   = 0x53 # S Key
    T                   = 0x54 # T Key
    U                   = 0x55 # U Key
    V                   = 0x56 # V Key
    W                   = 0x57 # W Key
    X                   = 0x58 # X Key
    Y                   = 0x59 # Y Key
    Z                   = 0x5A # Z Key
    #--------------------------------------------------------------------------
    # * Windows Keys
    #--------------------------------------------------------------------------
    LWIN                = 0x5B # Left Windows Key (Natural keyboard)
    RWIN                = 0x5C # Right Windows Key (Natural Keyboard)
    APPS                = 0x5D # Applications Key (Natural keyboard)
    SLEEP               = 0x5F # Computer Sleep Key
    BROWSER_BACK        = 0xA6 # Browser Back Key
    BROWSER_FORWARD     = 0xA7 # Browser Forward Key
    BROWSER_REFRESH     = 0xA8 # Browser Refresh Key
    BROWSER_STOP        = 0xA9 # Browser Stop Key
    BROWSER_SEARCH      = 0xAA # Browser Search Key
    BROWSER_FAVORITES   = 0xAB # Browser Favorites Key
    BROWSER_HOME        = 0xAC # Browser Start and Home Key
    VOLUME_MUTE         = 0xAD # Volume Mute Key
    VOLUME_DOWN         = 0xAE # Volume Down Key
    VOLUME_UP           = 0xAF # Volume Up Key
    MEDIA_NEXT_TRACK    = 0xB0 # Next Track Key
    MEDIA_PREV_TRACK    = 0xB1 # Previous Track Key
    MEDIA_STOP          = 0xB2 # Stop Media Key
    MEDIA_PLAY_PAUSE    = 0xB3 # Play/Pause Media Key
    LAUNCH_MAIL         = 0xB4 # Start Mail Key
    LAUNCH_MEDIA_SELECT = 0xB5 # Select Media Key
    LAUNCH_APP1         = 0xB6 # Start Application 1 Key
    LAUNCH_APP2         = 0xB7 # Start Application 2 Key
    PROCESSKEY          = 0xE5 # IME Process Key
    ATTN                = 0xF6 # Attn Key
    CRSEL               = 0xF7 # CrSel Key
    EXSEL               = 0xF8 # ExSel Key
    EREOF               = 0xF9 # Erase EOF Key
    PLAY                = 0xFA # Play Key
    ZOOM                = 0xFB # Zoom Key
    PA1                 = 0xFD # PA1 Key
    #--------------------------------------------------------------------------
    # * Number Pad Keys
    #--------------------------------------------------------------------------
    NUMPAD0             = 0x60 # Numeric Keypad 0 Key
    NUMPAD1             = 0x61 # Numeric Keypad 1 Key
    NUMPAD2             = 0x62 # Numeric Keypad 2 Key
    NUMPAD3             = 0x63 # Numeric Keypad 3 Key
    NUMPAD4             = 0x64 # Numeric Keypad 4 Key
    NUMPAD5             = 0x65 # Numeric Keypad 5 Key
    NUMPAD6             = 0x66 # Numeric Keypad 6 Key
    NUMPAD7             = 0x67 # Numeric Keypad 7 Key
    NUMPAD8             = 0x68 # Numeric Keypad 8 Key
    NUMPAD9             = 0x69 # Numeric Keypad 9 Key
    MULTIPLY            = 0x6A # Multiply Key (*)
    ADD                 = 0x6B # Add Key (+)
    SEPARATOR           = 0x6C # Separator Key
    SUBTRACT            = 0x6D # Subtract Key (-)
    DECIMAL             = 0x6E # Decimal Key (.)
    DIVIDE              = 0x6F # Divide Key (/)
    #--------------------------------------------------------------------------
    # * Function Keys
    #--------------------------------------------------------------------------
    F1                  = 0x70 # F1 Key
    F2                  = 0x71 # F2 Key
    F3                  = 0x72 # F3 Key
    F4                  = 0x73 # F4 Key
    F5                  = 0x74 # F5 Key
    F6                  = 0x75 # F6 Key
    F7                  = 0x76 # F7 Key
    F8                  = 0x77 # F8 Key
    F9                  = 0x78 # F9 Key
    F10                 = 0x79 # F10 Key
    F11                 = 0x7A # F11 Key
    F12                 = 0x7B # F12 Key
    F13                 = 0x7C # F13 Key
    F14                 = 0x7D # F14 Key
    F15                 = 0x7E # F15 Key
    F16                 = 0x7F # F16 Key
    F17                 = 0x80 # F17 Key
    F18                 = 0x81 # F18 Key
    F19                 = 0x82 # F19 Key
    F20                 = 0x83 # F20 Key
    F21                 = 0x84 # F21 Key
    F22                 = 0x85 # F22 Key
    F23                 = 0x86 # F23 Key
    F24                 = 0x87 # F24 Key
    #--------------------------------------------------------------------------
    # * Toggle Keys
    #--------------------------------------------------------------------------
    CAPITAL             = 0x14 # Caps Lock Key
    KANA                = 0x15 # IME Kana Mode Key
    HANGUL              = 0x15 # IME Hangul Mode Key
    JUNJA               = 0x17 # IME Junja Mode Key
    FINAL               = 0x18 # IME Final Mode Key
    HANJA               = 0x19 # IME Hanja Mode Key
    KANJI               = 0x19 # IME Kanji Mode Key
    MODECHANGE          = 0x1F # IME Mode Change Request Key
    INSERT              = 0x2D # Insert Key
    NUMLOCK             = 0x90 # Num Lock Key
    SCROLL              = 0x91 # Scroll Lock Key
    #--------------------------------------------------------------------------
    # * OEM Keys (Vary by keyboard)
    #--------------------------------------------------------------------------
    OEM_1               = 0xBA # Misc Characters (; : in USA 101/102 Keyboards)
    OEM_SEMICOLON       = 0xBA
    OEM_PLUS            = 0xBB # + = Key
    OEM_COMMA           = 0xBC # , < Key
    OEM_MINUS           = 0xBD # - _ Key
    OEM_PERIOD          = 0xBE # . > Key
    OEM_2               = 0xBF # Misc Characters (/ ? in USA 101/102 Keyboards)
    OEM_SLASH           = 0xBF
    OEM_3               = 0xC0 # Misc Characters (` ~ in USA 101/102 Keyboards)
    OEM_GRAVE           = 0xC0
    OEM_4               = 0xDB # Misc Characters ([ { in USA 101/102 Keyboards)
    OEM_OPENBRACKET     = 0xDB
    OEM_5               = 0xDC # Misc Characters (\ | in USA 101/102 Keyboards)
    OEM_BACKSLASH       = 0xDC
    OEM_6               = 0xDD # Misc Characters (] } in USA 101/102 Keyboards)
    OEM_CLOSEBRACKET    = 0xDD
    OEM_7               = 0xDE # Misc Characters (' " in USA 101/102 Keyboards)
    OEM_APOSTROPHE      = 0xDE
    OEM_8               = 0xDF # Misc Characters (Varies by Keyboard)
    OEM_9               = 0xE1 # OEM Specific
    OEM_10              = 0x92 # OEM Specific
    OEM_11              = 0x93 # OEM Specific
    OEM_12              = 0x94 # OEM Specific
    OEM_13              = 0x95 # OEM Specific
    OEM_14              = 0x96 # OEM Specific
    OEM_15              = 0xE3 # OEM Specific
    OEM_16              = 0xE4 # OEM Specific
    OEM_17              = 0xE6 # OEM Specific
    OEM_18              = 0xE9 # OEM Specific
    OEM_19              = 0xEA # OEM Specific
    OEM_20              = 0xEB # OEM Specific
    OEM_21              = 0xEC # OEM Specific
    OEM_22              = 0xED # OEM Specific
    OEM_23              = 0xEE # OEM Specific
    OEM_24              = 0xEF # OEM Specific
    OEM_25              = 0xF1 # OEM Specific
    OEM_26              = 0xF2 # OEM Specific
    OEM_27              = 0xF3 # OEM Specific
    OEM_28              = 0xF4 # OEM Specific
    OEM_29              = 0xF5 # OEM Specific
    OEM_102             = 0xE2 # Angle Bracket or Backslash on RT-102 Keyboards
    OEM_CLEAR           = 0xFE # Clear Key
    #--------------------------------------------------------------------------
    # * Special Keys
    #--------------------------------------------------------------------------
    #ANYKEY              = 0x100 # Any Key

    # ********************************* Stub **********************************
    def self.update
    end

    def self.press?(key)
        return Input.pressex? key
    end

    def self.trigger?(key)
        return Input.triggerex? key
    end

    def self.repeat?(key)
        return Input.repeatex? key
    end

    def self.release?(key)
        return Input.releaseex? key
    end
end