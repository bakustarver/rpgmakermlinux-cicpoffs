=begin
Win32API emulation

MKXP-Z exposes an implementation of the Win32API module (called MiniFFI) by default.
However, this alias is only actually useful on Windows. Therefore, we replace it
with a pure-ruby version specifically implementing the most common imports.
Real native libraries can still be accessed through MiniFII.new (e.g. in ports)

Lambdas are used for implementations as they replicate Win32API's #call interface.
=end

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
    end

    module User32
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
        GetCursorPos = ->(out_point) do
            # Pack mouse coordinates into a binary string
            packed_coords = [Input.mouse_x, Input.mouse_y].pack("ll")

            # Update the out_point string with the packed data (overwrite first 8 bytes)
            out_point[0, 8] = packed_coords

            return 1
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
    end

    module SteamAPI
        # TODO: Forward to native steamapi?
        SteamAPI_Init = ->{1}
        SteamAPI_Shutdown = ->{}
    end

    Libraries = {
        "kernel32" => Kernel32,
        "user32" => User32,
        "steam_api" => SteamAPI,
    }

    def self.new(dllname, func, *rest)
        dllname = dllname[...-4] if dllname[...-4] == ".dll"
        lib = Libraries[dllname]
        return lib.const_get(func, false) if lib.const_defined?(func, false) unless lib.nil?
        Preload.print("Warning: Win32API not implemented: #{dllname}##{func}")
        return ->(*args){Preload.print "(STUB) #{dllname}##{func}: #{args}"}
    end
end
