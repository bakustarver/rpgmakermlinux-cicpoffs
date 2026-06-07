=begin
Win32API emulation

MKXP-Z exposes an implementation of the Win32API module (called MiniFFI) by default.
However, this alias is only actually useful on Windows. Therefore, we replace it
with a pure-ruby version specifically implementing the most common imports.
Real native libraries can still be accessed through MiniFII.new (e.g. in ports)

Lambdas are used for implementations as they replicate Win32API's #call interface.
=end

ENV['TEMP'] = '/tmp' unless System.is_windows?

class Thread
    class << self
        attr_accessor :critical
    end
end
Thread.critical = false
# Check if the method exists
# if defined?(pbSameThread) == 'method'
#     # patch code here
#
# module Input
#     class << self
#         alias_method :_spork_old_update, :update
#         alias_method :_spork_old_raw_key_states, :raw_key_states
#         def raw_key_states
#             _spork_old_update
#             _spork_old_raw_key_states
#         end
#     end
# end
# end

module Scancodes
    SDL = { :UNKNOWN => 0x00,
            :A => 0x04, :B => 0x05, :C => 0x06, :D => 0x07,
            :E => 0x08, :F => 0x09, :G => 0x0A, :H => 0x0B,
            :I => 0x0C, :J => 0x0D, :K => 0x0E, :L => 0x0F,
            :M => 0x10, :N => 0x11, :O => 0x12, :P => 0x13,
            :Q => 0x14, :R => 0x15, :S => 0x16, :T => 0x17,
            :U => 0x18, :V => 0x19, :W => 0x1A, :X => 0x1B,
            :Y => 0x1C, :Z => 0x1D, :N1 => 0x1E, :N2 => 0x1F,
            :N3 => 0x20, :N4 => 0x21, :N5 => 0x22, :N6 => 0x23,
            :N7 => 0x24, :N8 => 0x25, :N9 => 0x26, :N0 => 0x27,
            :RETURN => 0x28, :ESCAPE => 0x29, :BACKSPACE => 0x2A, :TAB => 0x2B,
            :SPACE => 0x2C, :MINUS => 0x2D, :EQUALS => 0x2E, :LEFTBRACKET => 0x2F,
            :RIGHTBRACKET => 0x30, :BACKSLASH => 0x31, :NONUSHASH => 0x32, :SEMICOLON => 0x33,
            :APOSTROPHE => 0x34, :GRAVE => 0x35, :COMMA => 0x36, :PERIOD => 0x37,
            :SLASH => 0x38, :CAPSLOCK => 0x39, :F1 => 0x3A, :F2 => 0x3B,
            :F3 => 0x3C, :F4 => 0x3D, :F5 => 0x3E, :F6 => 0x3F,
            :F7 => 0x40, :F8 => 0x41, :F9 => 0x42, :F10 => 0x43,
            :F11 => 0x44, :F12 => 0x45, :PRINTSCREEN => 0x46, :SCROLLLOCK => 0x47,
            :PAUSE => 0x48, :INSERT => 0x49, :HOME => 0x4A, :PAGEUP => 0x4B,
            :DELETE => 0x4C, :END => 0x4D, :PAGEDOWN => 0x4E, :RIGHT => 0x4F,
            :LEFT => 0x50, :DOWN => 0x51, :UP => 0x52, :NUMLOCKCLEAR => 0x53,
            :KP_DIVIDE => 0x54, :KP_MULTIPLY => 0x55, :KP_MINUS => 0x56, :KP_PLUS => 0x57,
            :KP_ENTER => 0x58, :KP_1 => 0x59, :KP_2 => 0x5A, :KP_3 => 0x5B,
            :KP_4 => 0x5C, :KP_5 => 0x5D, :KP_6 => 0x5E, :KP_7 => 0x5F,
            :KP_8 => 0x60, :KP_9 => 0x61, :KP_0 => 0x62, :KP_PERIOD => 0x63,
            :NONUSBACKSLASH => 0x64, :APPLICATION => 0x65, :POWER => 0x66, :KP_EQUALS => 0x67,
            :F13 => 0x68, :F14 => 0x69, :F15 => 0x6A, :F16 => 0x6B,
            :F17 => 0x6C, :F18 => 0x6D, :F19 => 0x6E, :F20 => 0x6F,
            :F21 => 0x70, :F22 => 0x71, :F23 => 0x72, :F24 => 0x73,
            :EXECUTE => 0x74, :HELP => 0x75, :MENU => 0x76, :SELECT => 0x77,
            :STOP => 0x78, :AGAIN => 0x79, :UNDO => 0x7A, :CUT => 0x7B,
            :COPY => 0x7C, :PASTE => 0x7D, :FIND => 0x7E, :MUTE => 0x7F,
            :VOLUMEUP => 0x80, :VOLUMEDOWN => 0x81, :LOCKINGCAPSLOCK => 0x82, :LOCKINGNUMLOCK => 0x83,
            :LOCKINGSCROLLLOCK => 0x84, :KP_COMMA => 0x85, :KP_EQUALSAS400 => 0x86, :INTERNATIONAL1 => 0x87,
            :INTERNATIONAL2 => 0x88, :INTERNATIONAL3 => 0x89, :INTERNATIONAL4 => 0x8A, :INTERNATIONAL5 => 0x8B,
            :INTERNATIONAL6 => 0x8C, :INTERNATIONAL7 => 0x8D, :INTERNATIONAL8 => 0x8E, :INTERNATIONAL9 => 0x8F,
            :LANG1 => 0x90, :LANG2 => 0x91, :LANG3 => 0x92, :LANG4 => 0x93,
            :LANG5 => 0x94, :LANG6 => 0x95, :LANG7 => 0x96, :LANG8 => 0x97,
            :LANG9 => 0x98, :ALTERASE => 0x99, :SYSREQ => 0x9A, :CANCEL => 0x9B,
            :CLEAR => 0x9C, :PRIOR => 0x9D, :RETURN2 => 0x9E, :SEPARATOR => 0x9F,
            :OUT => 0xA0, :OPER => 0xA1, :CLEARAGAIN => 0xA2, :CRSEL => 0xA3,
            :EXSEL => 0xA4, :KP_00 => 0xB0, :KP_000 => 0xB1, :THOUSANDSSEPARATOR => 0xB2,
            :DECIMALSEPARATOR => 0xB3, :CURRENCYUNIT => 0xB4, :CURRENCYSUBUNIT => 0xB5, :KP_LEFTPAREN => 0xB6,
            :KP_RIGHTPAREN => 0xB7, :KP_LEFTBRACE => 0xB8, :KP_RIGHTBRACE => 0xB9, :KP_TAB => 0xBA,
            :KP_BACKSPACE => 0xBB, :KP_A => 0xBC, :KP_B => 0xBD, :KP_C => 0xBE,
            :KP_D => 0xBF, :KP_E => 0xC0, :KP_F => 0xC1, :KP_XOR => 0xC2,
            :KP_POWER => 0xC3, :KP_PERCENT => 0xC4, :KP_LESS => 0xC5, :KP_GREATER => 0xC6,
            :KP_AMPERSAND => 0xC7, :KP_DBLAMPERSAND => 0xC8, :KP_VERTICALBAR => 0xC9, :KP_DBLVERTICALBAR => 0xCA,
            :KP_COLON => 0xCB, :KP_HASH => 0xCC, :KP_SPACE => 0xCD, :KP_AT => 0xCE,
            :KP_EXCLAM => 0xCF, :KP_MEMSTORE => 0xD0, :KP_MEMRECALL => 0xD1, :KP_MEMCLEAR => 0xD2,
            :KP_MEMADD => 0xD3, :KP_MEMSUBTRACT => 0xD4, :KP_MEMMULTIPLY => 0xD5, :KP_MEMDIVIDE => 0xD6,
            :KP_PLUSMINUS => 0xD7, :KP_CLEAR => 0xD8, :KP_CLEARENTRY => 0xD9, :KP_BINARY => 0xDA,
            :KP_OCTAL => 0xDB, :KP_DECIMAL => 0xDC, :KP_HEXADECIMAL => 0xDD, :LCTRL => 0xE0,
            :LSHIFT => 0xE1, :LALT => 0xE2, :LGUI => 0xE3, :RCTRL => 0xE4,
            :RSHIFT => 0xE5, :RALT => 0xE6, :RGUI => 0xE7, :MODE => 0x101,
            :AUDIONEXT => 0x102, :AUDIOPREV => 0x103, :AUDIOSTOP => 0x104, :AUDIOPLAY => 0x105,
            :AUDIOMUTE => 0x106, :MEDIASELECT => 0x107, :WWW => 0x108, :MAIL => 0x109,
            :CALCULATOR => 0x10A, :COMPUTER => 0x10B, :AC_SEARCH => 0x10C, :AC_HOME => 0x10D,
            :AC_BACK => 0x10E, :AC_FORWARD => 0x10F, :AC_STOP => 0x110, :AC_REFRESH => 0x111,
            :AC_BOOKMARKS => 0x112, :BRIGHTNESSDOWN => 0x113, :BRIGHTNESSUP => 0x114, :DISPLAYSWITCH => 0x115,
            :KBDILLUMTOGGLE => 0x116, :KBDILLUMDOWN => 0x117, :KBDILLUMUP => 0x118, :EJECT => 0x119,
            :SLEEP => 0x11A, :APP1 => 0x11B, :APP2 => 0x11C
          }

    SDL.default = SDL[:UNKNOWN]

    WIN32 = {
        :LBUTTON => 0x01, :RBUTTON => 0x02, :MBUTTON => 0x04,

        :BACK => 0x08, :TAB => 0x09, :RETURN => 0x0D, :SHIFT => 0x10,
        :CONTROL => 0x11, :MENU => 0x12, :PAUSE => 0x13, :CAPITAL => 0x14,
        :ESCAPE => 0x1B, :SPACE => 0x20, :PRIOR => 0x21, :NEXT => 0x22,
        :END => 0x23, :HOME => 0x24, :LEFT => 0x25, :UP => 0x26,
        :RIGHT => 0x27, :DOWN => 0x28, :PRINT => 0x2A, :INSERT => 0x2D,
        :DELETE => 0x2E,

        :N0 => 0x30, :N1 => 0x31, :N2 => 0x32, :N3 => 0x33,
        :N4 => 0x34, :N5 => 0x35, :N6 => 0x36, :N7 => 0x37, :N8 => 0x38,
        :N9 => 0x39,

        :A => 0x41, :B => 0x42, :C => 0x43, :D => 0x44, :E => 0x45, :F => 0x46,
        :G => 0x47, :H => 0x48, :I => 0x49, :J => 0x4A, :K => 0x4B, :L => 0x4C,
        :M => 0x4D, :N => 0x4E, :O => 0x4F, :P => 0x50, :Q => 0x51, :R => 0x52,
        :S => 0x53, :T => 0x54, :U => 0x55, :V => 0x56, :W => 0x57, :X => 0x58,
        :Y => 0x59, :Z => 0x5A,

        :LWIN => 0x5B, :RWIN => 0x5C,

        :NUMPAD0 => 0x60, :NUMPAD1 => 0x61, :NUMPAD2 => 0x62, :NUMPAD3 => 0x63,
        :NUMPAD4 => 0x64, :NUMPAD5 => 0x65, :NUMPAD6 => 0x66, :NUMPAD7 => 0x67,
        :NUMPAD8 => 0x68, :NUMPAD9 => 0x69,
        :MULTIPLY => 0x6A, :ADD => 0x6B, :SEPARATOR => 0x6C, :SUBSTRACT => 0x6D,
        :DECIMAL => 0x6E, :DIVIDE => 0x6F,

        :F1 => 0x70, :F2 => 0x71, :F3 => 0x72, :F4 => 0x73,
        :F5 => 0x74, :F6 => 0x75, :F7 => 0x76, :F8 => 0x77,
        :F9 => 0x78, :F10 => 0x79, :F11 => 0x7A, :F12 => 0x7B,
        :F13 => 0x7C, :F14 => 0x7D, :F15 => 0x7E, :F16 => 0x7F,
        :F17 => 0x80, :F18 => 0x81, :F19 => 0x82, :F20 => 0x83,
        :F21 => 0x84, :F22 => 0x85, :F23 => 0x86, :F24 => 0x87,

        :NUMLOCK => 0x90, :SCROLL => 0x91,
        :LSHIFT => 0xA0, :RSHIFT => 0xA1, :LCONTROL => 0xA2, :RCONTROL => 0xA3,
        :LMENU => 0xA4, :RMENU => 0xA5, :OEM_1 => 0xBA,
        :OEM_PLUS => 0xBB, :OEM_COMMA => 0xBC, :OEM_MINUS => 0xBD, :OEM_PERIOD => 0xBE,
        :OEM_2 => 0xBF, :OEM_3 => 0xC0, :OEM_4 => 0xDB, :OEM_5 => 0xDC,
        :OEM_6 => 0xDD, :OEM_7 => 0xDE
    }

    WIN32INV = WIN32.invert

    WIN2SDL = {
        :BACK => :BACKSPACE,
        :CAPITAL => :CAPSLOCK,
        :PRIOR => :PAGEUP, :NEXT => :PAGEDOWN,
        :PRINT => :PRINTSCREEN,

        :LWIN => :LGUI, :RWIN => :RGUI,

        :NUMPAD0 => :KP_0, :NUMPAD1 => :KP_1, :NUMPAD2 => :KP_2, :NUMPAD3 => :KP_3,
        :NUMPAD4 => :KP_4, :NUMPAD5 => :KP_5, :NUMPAD6 => :KP_6, :NUMPAD7 => :KP_7,
        :NUMPAD8 => :KP_8, :NUMPAD9 => :KP_9,
        :MULTIPLY => :KP_MULTIPLY, :ADD => :KP_PLUS, :SUBSTRACT => :KP_MINUS,
        :DECIMAL => :KP_DECIMAL, :DIVIDE => :KP_DIVIDE,

        :NUMLOCK => :NUMLOCKCLEAR, :SCROLL => :SCROLLLOCK,
        :LCONTROL => :LCTRL, :RCONTROL => :RCTRL,
        # FIXME: Fill these out
        :LMENU => :LALT, :RMENU => :RALT, :OEM_1 => :SEMICOLON,
        :OEM_PLUS => :UNKNOWN, :OEM_COMMA => :UNKNOWN, :OEM_MINUS => :UNKNOWN, :OEM_PERIOD => :UNKNOWN,
        :OEM_2 => :UNKNOWN, :OEM_3 => :UNKNOWN, :OEM_4 => :UNKNOWN, :OEM_5 => :UNKNOWN,
        :OEM_6 => :UNKNOWN, :OEM_7 => :UNKNOWN
        }

    WIN2SDL.default = :UNKNOWN
end

$win32KeyStates = nil

module Graphics
    class << self
        alias_method(:win32wrap_update, :update)
        def update
            win32wrap_update
            $win32KeyStates = nil
        end
    end
end

def get_raw_keystates
    if $win32KeyStates == nil
        $win32KeyStates = Input.raw_key_states
    end

    return $win32KeyStates
end

def common_keystate(vkey)
    vkey_name = Scancodes::WIN32INV[vkey]

    states = get_raw_keystates
    pressed = false

    if vkey_name == :LBUTTON
        pressed = Input.press?(Input::MOUSELEFT)
    elsif vkey_name == :RBUTTON
        pressed = Input.press?(Input::MOUSERIGHT)
    elsif vkey_name == :MBUTTON
        pressed = Input.press?(Input::MOUSEMIDDLE)
    elsif vkey_name == :SHIFT
        pressed = double_state(states, :LSHIFT, :RSHIFT)
    elsif vkey_name == :MENU
        pressed = double_state(states, :LALT, :RALT)
    elsif vkey_name == :CONTROL
        pressed = double_state(states, :LCTRL, :RCTRL)
    else
        scan = nil
        if Scancodes::SDL.key?(vkey_name)
            scan = vkey_name
        else
            scan = Scancodes::WIN2SDL[vkey_name]
        end

        pressed = state_pressed(states, scan)
    end

    return pressed ? 1 : 0
end

def memcpy_string(dst, src)
    i = 0
    src.each_byte do |b|
        dst.setbyte(i, b)
        i += 1
    end
end

def state_pressed(states, sdl_scan)
    return states[Scancodes::SDL[sdl_scan]]
end

def double_state(states, left, right)
    return state_pressed(states, left) || state_pressed(states, right)
end

# Don't expose MiniFFI as Win32API
Object.remove_const :Win32API

module Win32API

    module Kernel32
        GetPrivateProfileInt = GetPrivateProfileIntA = ->(appname, keyname, default, filename) do
            Preload.require "PreloadIni.rb"
            s = Preload::Ini.readIniString filename, appname, keyname
            s.nil? ? default : s.to_i
        end
        GetPrivateProfileString = GetPrivateProfileStringA = ->(appname, keyname, default, ret, size, filename) do
            Preload.require "PreloadIni.rb"
            if appname.nil? then
                res = Preload::Ini.readIniSections(filename).join("\0") + "\0"
            elsif keyname.nil? then
                res = Preload::Ini.readIniKeys(filename, appname).join("\0") + "\0"
            else
                s = Preload::Ini.readIniString filename, appname, keyname
                res = s.nil? ? (default.nil? ? "" : default) : s
            end
            # C-String dance
            size -= 1
            if res.size > size then
                res.slice!(size...)
                res[size-1] = "\0" if appname.nil? or keyname.nil?
            end
            ret[...res.size] = res
            ret[res.size] = "\0"
            res.size
        end
        WritePrivateProfileString = WritePrivateProfileStringA = ->(appname, keyname, value, filename) do
            Preload.require "PreloadIni.rb"
            Preload::Ini.writeIniString filename, appname, keyname, value
        end
        # Zero a memory buffer (dest is a Ruby String acting as a byte buffer)
        RtlZeroMemory = ->(dest, length) do
            length = length.to_i
            return if length <= 0
            dest[0, length] = "\x00" * length
        end

        # Convert UTF-16LE (wide char) to a multibyte UTF-8 string and copy into buffer.
        # Signature approximates Windows:
        # (codepage, flags, wide_str, wide_len, buffer, buffer_size, default_char = nil, used_default_char = nil)
        WideCharToMultiByte = WideCharToMultiByteA = ->(codepage, flags, wide_str, wide_len, buffer, buffer_size, default_char = nil, used_default_char = nil) do
            # Handle nil/empty input
            wide_bytes = wide_str || ""
            # If wide_len is -1 (null-terminated) or nil, use entire string; otherwise take wide_len characters (2 bytes each)
            if wide_len && wide_len != -1
                byte_len = wide_len * 2
                wide_bytes = wide_bytes[0, byte_len] || ""
            else
                # If null-terminated, truncate at first UTF-16 NUL (two zero bytes)
                nul_pos = wide_bytes.index("\x00\x00")
                wide_bytes = wide_bytes[0, nul_pos] || "" if nul_pos
            end

            # Convert from UTF-16LE to UTF-8; be permissive if encoding is already UTF-8
            begin
                utf8 = wide_bytes.force_encoding('UTF-16LE').encode('UTF-8')
            rescue StandardError
                # Fallback: try to interpret as UTF-8 already
                utf8 = wide_bytes.to_s.force_encoding('UTF-8')
            end

            # If buffer is nil, return required size in bytes
            if buffer.nil? || buffer_size.nil? || buffer_size == 0
                return utf8.bytesize
            end

            # Copy up to buffer_size - 1 bytes and NUL-terminate
            max_copy = [buffer_size - 1, 0].max
            out = utf8.byteslice(0, max_copy) || ""
            memcpy_string(buffer, out)
            buffer[out.bytesize] = "\0"
            out.bytesize
        end
        # Convert a multibyte string (assumed UTF-8) to UTF-16LE and copy into buffer.
        # Signature: (codepage, flags, input_str, input_len, buffer, buffer_size) -> number_of_wide_chars_written
        MultiByteToWideChar = MultiByteToWideCharA = ->(codepage, flags, input_str, input_len, buffer, buffer_size) do
            # Normalize input
            mb = input_str || ""
            if input_len && input_len != -1
                mb = mb[0, input_len] || ""
            else
                nul = mb.index("\0")
                mb = nul ? mb[0, nul] : mb
            end

            # Convert to UTF-16LE; be permissive on encoding errors, then treat as raw bytes
            begin
                utf16 = mb.to_s.encode('UTF-16LE')
            rescue StandardError
                utf16 = mb.to_s.encode('UTF-16LE', invalid: :replace, undef: :replace, replace: '?')
            end
            # Treat UTF-16LE data as raw bytes to avoid encoding comparisons
            utf16.force_encoding(Encoding::ASCII_8BIT)

            # If input_len == -1, ensure terminating wide NUL present
            if input_len == -1
                utf16 += "\x00\x00".b unless utf16.bytesize >= 2 && utf16.byteslice(-2, 2) == "\x00\x00".b
            end

            # If caller asked for required size only (NULL buffer or zero size), return number of wide chars required
            if buffer.nil? || buffer_size.nil? || buffer_size == 0
                return (utf16.bytesize / 2)
            end

            # Copy up to buffer_size wide chars (2 bytes each)
            max_bytes = buffer_size * 2
            to_copy = utf16.byteslice(0, max_bytes) || "".b

            # Ensure buffer is treated as binary for assignment
            buffer.force_encoding(Encoding::ASCII_8BIT) if buffer.respond_to?(:force_encoding)

            memcpy_string(buffer, to_copy)

            # If we copied fewer than max_bytes and the source was not null-terminated, ensure NUL termination when space allows
            if to_copy.bytesize < max_bytes
                pos = to_copy.bytesize
                # Ensure we don't exceed buffer length; assign two zero bytes
                buffer[pos, 2] = "\x00\x00".b
            end

            # Return number of wide characters written
            (to_copy.bytesize / 2)
        end

        # Signature: (hwnd, text, caption, uType) -> int
        # Emulates MessageBoxA by printing to the preload log and returning a button ID.
        MessageBox = MessageBoxA = ->(hwnd, text, caption, uType) do
            # Normalize inputs
            hwnd = hwnd || 0
            text = text.to_s
            caption = caption.to_s
            uType = uType.to_i

            # Log the call so scripts can see what was requested
            Preload.print "MessageBoxA called: hwnd=#{hwnd} caption=#{caption.inspect} text=#{text.inspect} type=0x#{uType.to_s(16)}"

            # Optionally update the current window title when a caption is provided
            if caption && !caption.empty?
                # Keep the same helper used elsewhere for title
                User32.SetCurrentWindowTitle.call(caption) if User32.respond_to?(:SetCurrentWindowTitle)
            end

            # Determine a sensible default return value based on uType button flags
            # Common return values: IDOK = 1, IDCANCEL = 2, IDABORT = 3, IDRETRY = 4, IDIGNORE = 5, IDYES = 6, IDNO = 7
            # If the message box type requests Yes/No, return IDYES; if OK/Cancel, return IDOK.
            buttons = uType & 0xF
            case buttons
            when 0x00000004 # MB_YESNO
                return 6 # IDYES
            when 0x00000001 # MB_OKCANCEL
                return 1 # IDOK
            when 0x00000002 # MB_ABORTRETRYIGNORE
                return 3 # IDABORT
            when 0x00000003 # MB_YESNOCANCEL
                return 6 # IDYES
            else
                # Default to IDOK for unknown/other types
                return 1
            end
        end

        RtlMoveMemory = ->(dest, src, length) do
            dest[0, length] = src[0, length]
        end
    end

    module User32
        MapVirtualKeyEx = ->(code, map, layout) do
            # If layout is non-zero we only support layout==0 in this emulation.
            return 0 unless layout == 0 || layout.nil?
            # map values: 0 = VK->SC, 1 = SC->VK, 2 = VK->CHAR (we'll be permissive)
            case map
            when 0
                # Return the scan code equal to the code (simple identity mapping)
                code
            when 1
                # Reverse mapping: identity
                code
            else
                # Unknown mapping mode: return code unchanged
                code
            end
        end

# Stub for User32::MessageBoxA with UTF-16 decoding
            MessageBoxA = ->(hwnd, text, caption, uType) do
                hwnd    = hwnd || 0
                uType   = uType.to_i

                # Try to decode UTF-16LE text safely
                decoded_text = begin
                text.to_s.force_encoding('UTF-16LE').encode('UTF-8')
                rescue
                text.to_s
                end

                decoded_caption = begin
                caption.to_s.force_encoding('UTF-16LE').encode('UTF-8')
                rescue
                caption.to_s
                end

                # Log the call in human-readable form
                Preload.print "User32::MessageBoxA called: hwnd=#{hwnd} caption=#{decoded_caption.inspect} text=#{decoded_text.inspect} type=0x#{uType.to_s(16)}"

                # Optionally update the window title
                if decoded_caption && !decoded_caption.empty?
                SetCurrentWindowTitle.call(decoded_caption) if User32.respond_to?(:SetCurrentWindowTitle)
                end

                # Return a safe default value based on button flags
                buttons = uType & 0xF
                case buttons
                when 0x00000004 # MB_YESNO
                6 # IDYES
                when 0x00000001 # MB_OKCANCEL
                1 # IDOK
                when 0x00000002 # MB_ABORTRETRYIGNORE
                3 # IDABORT
                when 0x00000003 # MB_YESNOCANCEL
                6 # IDYES
                else
                1 # Default to IDOK
                end
            end




        # GetKeyboardState already exists in your file; ensure it accepts a buffer-like object.
        # (Your file already sets bytes in the provided buffer.)

        # ToUnicodeEx: translate virtual-key + scan code + key state -> UTF-16LE chars
        # Signature approximation:
        # (wVirtKey, wScanCode, lpKeyState, pwszBuff, cchBuff, wFlags, dwhkl) -> number_of_wide_chars_written
        ToUnicodeEx = ->(wVirtKey, wScanCode, lpKeyState, pwszBuff, cchBuff, wFlags, dwhkl) do
            # Normalize inputs
            vk = (wVirtKey || 0).to_i
            buf = pwszBuff
            max_chars = (cchBuff || 0).to_i

            # Helper: write UTF-16LE string into buffer (binary-safe)
            write_utf16le = lambda do |out_buf, str|
                # Ensure UTF-16LE bytes
                utf16 = str.to_s.encode('UTF-16LE', invalid: :replace, undef: :replace, replace: '?')
                # If caller asked only for required size (nil buffer or zero size), return number of wide chars
                return utf16.bytesize / 2 if out_buf.nil? || max_chars == 0
                # Copy up to max_chars wide chars (2 bytes each)
                max_bytes = max_chars * 2
                to_copy = utf16.byteslice(0, max_bytes) || "".b
                memcpy_string(out_buf, to_copy)
                # NUL-terminate if space remains
                if to_copy.bytesize < max_bytes
                    pos = to_copy.bytesize
                    out_buf[pos, 2] = "\x00\x00".b
                end
                to_copy.bytesize / 2
            end

            # Basic mapping for ASCII letters and digits
            char = nil
            if vk >= 0x41 && vk <= 0x5A
                # A-Z
                # Check shift state if lpKeyState provided (simple check for high bit 0x80)
                shift = false
                if lpKeyState && lpKeyState.respond_to?(:getbyte)
                    shift = (lpKeyState.getbyte(Scancodes::WIN32[:LSHIFT]) & 0x80) != 0 ||
                            (lpKeyState.getbyte(Scancodes::WIN32[:RSHIFT]) & 0x80) != 0
                end
                base = vk - 0x41
                char = (shift ? (65 + base).chr : (97 + base).chr)
            elsif vk >= 0x30 && vk <= 0x39
                # 0-9
                char = (48 + (vk - 0x30)).chr
            elsif vk == 0x20
                char = " "
            elsif vk == 0x0D
                char = "\r"
            else
                # Unknown/unsupported VK: return 0 (no translation)
                return 0
            end

            # If caller only asked for required size
            return 1 if buf.nil? || max_chars == 0

            # Write the UTF-16LE char into the provided buffer and return number of wide chars written
            write_utf16le.call(buf, char)
        end
        FindWindow = FindWindowA = ->(cls, wnd) do
            return 1
        end
        FindWindowEx = ->(parent, ca, cls, wnd) do
            return 1
        end
        GetAsyncKeyState = ->(key) do
            # Very naive
            return 128 if Input.pressex? key
            return 0
        end
        GetClientRect = ->(hWnd, out_rect) do
            return 0 unless hWnd == 1
            # out_rect.byteslice(0, 16, [0, 0, Graphics.width, Graphics.height].pack("llll"))
            out_rect[0, 16] = [0, 0, Graphics.width, Graphics.height].pack("llll")
            return 1
        end
        GetCursorPos = ->(args) do
            # Pack mouse coordinates into a binary string
            out = [Input.mouse_x, Input.mouse_y].pack('ll')
            memcpy_string(args, out)
            return 1
        end
        GetKeyState = ->(vkey) do
            return common_keystate(vkey)
        end

        GetAsyncKeyState = ->(vkey) do
            pressed_bit = (1 << 15)
            return common_keystate(vkey) == 1 ? pressed_bit : 0
        end

        @state = "\x00" * 256
        GetKeyboardState = ->(buf) do
            Scancodes::WIN32.each do |name, val|
                buf.setbyte(val, common_keystate(val) == 1 ? 0x80 : 0)
            end
            1
        end

        GetKeyboardLayout = ->(thread) do
            return 0
        end
        GetSystemMetrics = ->(index) do
            return Graphics.width if index == 0 # SM_CXSCREEN - Primary screen width
            return Graphics.height if index == 1 # SM_CYSCREEN - Primary screen height
            return 0 if index == 4 # SM_CYCAPTION - Height of caption area (title bar?)
            return 0 if index == 5 # SM_CXBORDER - Width of window borders
            return 0 if index == 6 # SM_CYBORDER - Height of window borders
            return 0 if index == 23 # SM_SWAPBUTTON - Swap left/right mouse buttons
            return 0 if index == 45 # SM_CXEDGE - Width of 3D window borders
            Preload.print("Warning: user32#GetSystemMetrics index #{index} not implemented")
            return 0
        end
        GetWindowRect = ->(hWnd, out_rect) do
            return 0 unless hWnd == 1
            # out_rect.byteslice(0, 16, [0, 0, Graphics.width, Graphics.height].pack("llll"))
            out_rect[0, 16] = [0, 0, Graphics.width, Graphics.height].pack("llll")
            return 1
        end
        MapVirtualKeyEx = ->(code, map, layout) do
            return 0 unless layout == 0
            return code
        end
        ScreenToClient = ->(hWnd, point) do
            return 1 unless hWnd != 1
            return 0
        end
        ShowCursor = ->(show) do
            Graphics.show_cursor = show == 1
            return show
        end
        @__current_window_title = "RGSS Player"

        # Helper to set the title from other scripts if needed
        SetCurrentWindowTitle = ->(title) do
            @__current_window_title = title.to_s
            1
        end

        # Return a fake HWND for the foreground window (other stubs expect 1)
        GetForegroundWindow = ->() do
            1
        end

        # Return the length of the window text (number of characters)
        GetWindowTextLength = ->(hwnd) do
            return 0 unless hwnd == 1
            @__current_window_title ? @__current_window_title.length : 0
        end

        # Copy the window title into the provided buffer (C-style)
        # Signature: (hwnd, out_buffer, max_count) -> number_of_chars_written
        GetWindowText = ->(hwnd, out_buf, max_count) do
            return 0 unless hwnd == 1
            title = @__current_window_title || ""
            # Ensure we don't overflow: Windows GetWindowText copies up to max_count-1 chars and NUL terminates
            max_copy = [max_count - 1, 0].max
            copy_str = title[0, max_copy]
            # Write bytes into the provided buffer
            memcpy_string(out_buf, copy_str)
            # NUL-terminate at position copy_str.length
            out_buf[copy_str.length] = "\0"
            copy_str.length
        end

        # Emulate bringing a window to foreground; accept hwnd and return success
        SetForegroundWindow = ->(hwnd) do
            # We accept 1 as the valid hwnd; if other values are passed, still return 1 to be permissive
            1
        end
    end

    module Xinput13
        XInputGetState = ->(pad_index, state) do
            # return "\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000"
            return 0
        end
    end

    # module CAMous
    #     GetWheelDelta = ->() do
    #         return 0
    #     end
    # end

    module SteamAPI
        # TODO: Forward to native steamapi?
        SteamAPI_Init = ->{1}
        SteamAPI_Shutdown = ->{}
    end

    Libraries = {
        "kernel32" => Kernel32,
        "XINPUT1_3" => Xinput13,
        "user32" => User32,
        "user32.dll" => User32,
        "steam_api" => SteamAPI,
    }

    def self.new(dllname, func, *rest)
        dllname = dllname[...-4] if dllname.end_with?(".dll")
        lib = Libraries[dllname]
        if lib
            return lib.method(func).to_proc if lib.respond_to?(func)
            return lib.const_get(func, false) if func =~ /^[A-Z]\w*/ && lib.const_defined?(func, false)
        end
        Preload.print("Warning: Win32API not implemented: #{dllname}##{func}")
        ->(*args){Preload.print "(STUB) #{dllname}##{func}: #{args}"}
    end

end
