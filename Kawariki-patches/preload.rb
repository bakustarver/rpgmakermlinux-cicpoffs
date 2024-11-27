# Kawariki MKXP preload infrastructure

module Preload
    # Kawariki mkxp resources location
    Path = File.dirname __FILE__

    # Require common libs
    def self.require(name)
         Kernel.require File.join(Path, "libs", name)
    end

    module Common
        # In RMXP mode, Kernel.print opens message boxes
        def print(text)
            STDOUT.puts("[preload] " + text.to_s)
        end
    end

    extend Common

    # -------------------------------------------------------------------------
    # Patches
    # -------------------------------------------------------------------------
    class Context
        include Common

        def initialize(scripts)
            @scripts = scripts
            @script_instances = {}
            @options = {}
            @blacklist = []
            @delay = {}
            @script_id_digits = Math.log10(scripts.size).ceil
        end

        attr_reader :script_id_digits, :script_loc_format

        # Scripts
        def script(i)
            @script_instances[i] ||= Script.new self, i, @scripts[i]
        end

        def script_count
            @scripts.size
        end

        def each_script
            (0...@scripts.size).each {|i| yield script i}
        end

        def last_script
            script (script_count - 1)
        end

        def script_loc(scriptid)
            return script(scriptid).loc
        end

        def blacklisted?(script)
            @blacklist.include? script.name
        end

        # def add_script(name, code)
        #     # Find an empty script slot (if any) to reuse (check for empty string)
        #     empty_slot = @scripts.find { |script| script[0].is_a?(String) && script[0].empty? }
        #
        #     if empty_slot
        #         # Reuse the empty slot
        #         empty_slot[0] = name  # Set the script name
        #         empty_slot[3] = code  # Set the script code
        #     else
        #         # No empty slot found, so we pop the last script and push a new one
        #         @scripts.pop
        #         @scripts.push [name, "", nil, code]
        #     end
        # end
        def add_script(name, code)
            # Find the first empty slot (check for empty string) that is not the last slot
            empty_slot = @scripts.find { |script| script[0].is_a?(String) && script[0].empty? && @scripts.index(script) < @scripts.length - 1 }

            if empty_slot
                # Reuse the empty slot and replace it with the new script
                empty_slot[0] = name  # Set the script name
                empty_slot[3] = code  # Set the script code
            else
                # No empty slot found, so insert the new script 5 positions before the end
                insert_index = [@scripts.length - 5, 0].max  # Ensure the index is not negative
                @scripts.insert(insert_index, [name, "", nil, code])
            end
        end
        # def add_script(name, code)
        #     @scripts.pop
        #     @scripts.push [name, "", nil, code]
        #     # TODO: Find an empty script to canibalize instead
        # end

        # Read options from environment
        FalseEnvValues = [nil, "", "0", "no"]
        def read_env(env=ENV)
            env_bool = ->(name) {!FalseEnvValues.include?(env[name])}
            env_str = ->(name) {e = env[name]; e unless e == ""}
            env_list = ->(name, delim) {e = env[name]; e.nil? ? [] :  e.split(delim)}

            set :dump_scripts_raw, env_str.("KAWARIKI_MKXP_DUMP_SCRIPTS")
            set :dump_scripts_patched, env_str.("KAWARIKI_MKXP_DUMP_PATCHED_SCRIPTS")
            mark :dont_run_game if env_bool.("KAWARIKI_MKXP_DRY_RUN")
            mark :no_font_effects if env_bool.("KAWARIKI_MKXP_NO_FONT_EFFECTS")
            @blacklist = env_list.("KAWARIKI_MKXP_FILTER_SCRIPTS", ",")
        end

        def read_system(system=System)
            # TODO: Non mkxp-z variants
            set :mkxp_version, system::VERSION
            set :mkxp_version_tuple, (system::VERSION.split ".").map{|d| d.to_i}

            if (self[:mkxp_version_tuple] <=> [2, 4]) >= 0 then
                mark :mkxpz_24
                _config = CFG
            else
                _config = system::CONFIG
            end
            # set :rgss_version, _config["rgssVersion"].to_i
            # puts "jj"+_config["gameFolder"].to_s
            # Preload.require "PreloadIni.rb"
            # puts "vvv"+ENV["rpgvers"]
            set :rgss_version, ENV["rpgvers"].to_i

             # puts self[:zeusrpgver]
            # puts vcode
            if defined?(RGSS_VERSION) && RGSS_VERSION == "3.0.1" then
                 # See mkxp-z/mri-binding.cpp
                 # puts "vvv"+RGSS_VERSION
                 set :rgss_version, 3
            end

            # FIXME: can this be reliably retrieved from MKXP if set to 0 in config?
            if self[:rgss_version] == 0 then
                print "Warning: rgssVersion not set in MKXP config. Are you running mkxp directly?"
                if RGSS_VERSION == "3.0.1" then
                    # See mkxp-z/mri-binding.cpp
                    set :rgss_version, 3
                else
                    print "Warning: Cannot guess RGSS version. Kawariki should automatically set it correctly."
                end
            end
            if self[:mkxp_version] == "MKXPZ_VERSION" then
                print "Note: Using mkxp-z with broken System::VERSION reporting. Cannot detect real mkxp-z version"
                set :mkxp_version, "mkxp-z"
            end
        end

        # Options
        def set(sym, value=true)
            @options.store sym, value unless value.nil?
        end

        def [](sym)
            @options[sym]
        end

        def mark(*flags)
            flags.each{|flag| set flag, true}
        end

        def flag?(flag)
            @options.key? flag
        end

        # Delay
        DelaySlots = [:after_patches]

        def delay(slot, &p)
            raise "Unknown delay slot #{slot}" unless DelaySlots.include? slot
            @delay[slot] = [] unless @delay.key? slot
            @delay[slot].push p
        end

        def run_delay_slot(slot, *args)
            raise "Unknown delay slot #{slot}" unless DelaySlots.include? slot
            if @delay[slot] then
                @delay[slot].each {|p| p.call(self, *args)}
                @delay.delete slot
            end
        end
    end

    class Script

        def initialize(context, i, script)
            @context = context
            @index = i
            @script = script
            @log = []
        end

        attr_reader :context
        attr_reader :index

        def log(msg=nil)
            @log.push msg unless msg.nil? || @log.last == msg
            @log
        end

        def loc
            "##{index.to_s.rjust @context.script_id_digits} '#{name}'"
        end

        def [](i)
            @script[i]
        end

        def name
            @script[1]
        end


        def source
            @script[3]
        end

        def sub!(*p)
            @script[3].gsub!(*p)
        end


        def source=(code)
            @script[3] = code
        end

        def load_file(path)
            log "replaced with #{File.basename path}"
            @script[3] = File.read(path)
        end

        def remove
            log "removed"
            @script[3] = ""
        end

        # Extract $imported key only once
        # $imported['Hello'] = 1
        # $imported[:Hello] = true
        # ($imported ||= {})["Hello"] = true
        # Type (String/Symbol) is preserved
        ImportedKeyExpr = /^\s*(?:\$imported|\(\s*\$imported(?:\s*\|\|=\s*\{\s*\})?\s*\))\[(:\w+|'[^']+'|"[^"]+")\]\s*=\s*(.+)\s*$/

        def _extract_imported
        if source.nil?
            puts "Warning: 'source' is nil at the beginning of _extract_imported"
            return
        end

        # Ensure 'source' is a string, and log the class type if it's not
        unless source.is_a?(String)
            puts "Warning: 'source' is not a string, it's a #{source.class}!"
            return
        end

        # Log the encoding type for debugging purposes
        # puts "Source encoding before: #{source.encoding.name}"

        # Force early return if source is unexpectedly nil just before encoding
        if source.nil?
            puts "Warning: 'source' unexpectedly nil before encoding"
            return
        end

        # Backup the original source value before encoding, to see if it changes unexpectedly
        original_source = source.dup

        # Force encode to ASCII-8BIT (binary ASCII), replacing non-ASCII characters with '?'
        if source.encoding.name != "ASCII-8BIT"
            begin
                # puts "Attempting to encode source..."
                # Try encoding, but ensure that source remains unchanged if encoding fails
                encoded_source = source.encode("ASCII-8BIT", invalid: :replace, undef: :replace, replace: "?")

                # If encoding results in an empty string or nil, restore original source
                if encoded_source.nil? || encoded_source.empty?
                    # puts "Warning: 'source' became nil or empty after encoding! Reverting to original source."
                    source = original_source
                    return
                else
                    # Otherwise, use the encoded result
                    source = encoded_source
                end

                # puts "Encoding successful, source encoding is now: #{source.encoding.name}"
            rescue Encoding::UndefinedConversionError, Encoding::InvalidByteSequenceError => e
                puts "Encoding failed: #{e.message}"
                return
            rescue StandardError => e
                puts "Unexpected error during encoding: #{e.message}"
                return
            end
        end

        # Check source after encoding to ensure it isn't nil
        if source.nil?
            # puts "Warning: 'source' is nil after encoding!"
            return
        end

        # After encoding (or skipping), match the regex pattern
        match = ImportedKeyExpr.match(source)

        # Check if a match was found
        @imported_entry = !match.nil?

        return unless @imported_entry

        # Extract the imported key and value from the match result
        @imported_key = match[1][0] == ':' ? match[1][1..].to_sym : match[1][1...-1]
        @imported_value = match[2]

        end

        def imported_entry?
            _extract_imported if @imported_entry.nil?
            @imported_entry
        end

        def imported_key
            _extract_imported if @imported_entry.nil?
            @imported_key
        end

        def imported_value
            _extract_imported if @imported_entry.nil?
            @imported_value
        end
    end

    class Patch
        include Common

        def initialize(desc=nil)
            @description = desc
            @conditions = []
            @actions = []
            @terminal = false
        end

        def is_applicable(script)
            return @conditions.all? {|cond| cond.call(script)}
        end

        def apply(script)
            print "Patch   #{script.loc}: #{@description}"
            @actions.each {|action| action.call script}
            @terminal
        end

        def eval(script)
            apply script if is_applicable script
        end

        # --- Conditions ---
        # Arbitrary condition
        def if?(&p)
            @conditions.push p
            self
        end

        # Source code contains text
        def include?(str)
            # XXX: maybe should restrict this to the start of the script for performance?
            if? {|script| script.source.include? str}
        end

        # Source code matches (any) pattern
        def match?(*ps)
            pattern = Regexp.union(*ps)
            if? {|script| script.source.match? pattern}
        end

        # Script sets $imported[key]
        def imported?(key)
            if? {|script| script.imported_key == key}
        end

        # Global flag set
        def flag?(flag)
            if? {|script| script.context.flag? flag}
        end

        # --- Actions ---
        # Arbitrary action
        def then!(&p)
            @actions.push p
            self
        end

        # Run arbitrary action later
        def delay!(slot, &p)
            @actions.push proc{|script|script.context.delay(slot, &p)}
            self
        end

        # Substitute text
        def sub!(pattern, replacement)
            @actions.push proc{|script| script.source.gsub! pattern, replacement}
            self
        end

        # Set a global flag for later reference
        def flag!(*flags)
            @actions.push proc{|script| script.context.mark *flags}
            self
        end

        # Remove the script (terminal)
        def remove!
            @actions.push proc{|script| script.remove }
            @terminal = true
            self
        end

        # Replace the whole script with a file from ports/ (terminal)
        def replace!(filename)
            puts filename
            @actions.push proc{|script| script.load_file File.join(Path, "ports", filename)}
            @terminal = true
            self
        end

        # Stop processing this script if patch is applicable (terminal)
        def next!
            @terminal = true
            self
        end
    end

    # -------------------------------------------------------------------------
    # Apply Patches
    # -------------------------------------------------------------------------
    class ClassInfo
        include Common

        def initialize(name, script, supername)
            @name = name
            @defs = [[script, supername]]
            @superdef = 0
        end

        attr_reader :name
        attr_reader :defs

        def first_script
            return @defs[0][0]
        end

        def super_name
            return @defs[@superdef][1]
        end

        def super_script
            return @defs[@superdef][0]
        end

        def first_loc
            return first_script.loc
        end

        def super_loc
            return super_script.loc
        end

        def add_definition(script, supername)
            if !supername.nil? && super_name != supername then
                print "Warning: Redefinition of class '#{name}' in #{script.loc} with inconsistent superclass '#{supername}'. Previous definition in #{super_loc} has superclass '#{super_name}'"
                @superdef = @defs.size
            end
            @defs.push [script, supername]
        end

        def inconsistent?
            return @superdef > 0
        end
    end

    def self.get_class_defs(ctx)
        classes = {}
        expr = /^class\s+(\w+)\s*(?:<\s*(\w+)\s*)?$/
        ctx.each_script do |script|
            # Encoding is all kinds of messed up in RM
            e = script.source.encoding
            script.source.force_encoding Encoding.find("ASCII-8BIT")
            script.source.scan(expr) do |groups|
                name, supername = *groups
                if !classes.include? name then
                    classes[name] = ClassInfo.new name, script, supername
                else
                    classes[name].add_definition script, supername
                end
            end
            script.source.force_encoding e
        end
        return classes
    end

    def self.overwrite_redefinitions(ctx)
        classes = get_class_defs ctx
        classes.each_pair do |name, cls|
            if cls.inconsistent? then
                print "Eliminating definitions of class '#{name}' before #{cls.super_loc}. First in #{cls.first_loc}"
                cls.super_script.sub!(Regexp.new("^(class\\s+#{name}\\s*<\\s*#{cls.super_name}\\s*)$"),
                    "Object.remove_const :#{name}\n\\1")
            end
        end
    end

    def self.patch_scripts(ctx)
        ctx.each_script do |script|
            # Remove blacklisted scripts
            if ctx.blacklisted? script then
                print "Removed #{script.loc}: Blacklisted"
                script.remove
                next
            end
            # Encodings are a mess in RGSS. Can break Regexp matching
            e = script.source.encoding
            script.source.force_encoding "ASCII-8BIT"
            # Apply patches
            script.source.gsub!(".encode('SHIFT_JIS')", '')

            Patches.each do |patch|
                break if patch.eval script
            end
            print "Patched #{script.loc}: #{script.log.join(', ')}" if script.log.size > 0
            # Warn if Win32API references in source
            if script.source.include? "Win32API.new" then

                 print "Warning: Script #{script.loc} uses Win32API."
                script.source.gsub!(/class\s+Win32API/, 'module Win32API')
                 require "Win32API.rb"
            end
            # Restore encoding
            script.source.force_encoding e
        end
        ctx.run_delay_slot :after_patches
    end

    NoFilenameChars = "/$|*#="

    def self.dump_scripts(ctx, opt)
        # Dump all scripts to a folder specified by opt
        if ctx.flag? opt then
            dump = ctx[opt]
            print "Dumping all scripts to %s" % dump
            Dir.mkdir dump unless Dir.exist? dump
            fn_format = "%0#{ctx.script_id_digits}d%s%s%s"
            ctx.each_script do |script|
                filename = fn_format % [script.index,
                                        script.name.empty? ? "" : " ",
                                        script.name.tr(NoFilenameChars, "_"),
                                        script.source.empty? ? "" : ".rb"]
                File.write File.join(dump, filename), script.source
            end
        end
    end

    # -------------------------------------------------------------------------
    # Logic
    # -------------------------------------------------------------------------
    RgssVersionNames = ["Unknown", "XP", "VX", "VX Ace"]



    @on_preload = []
    @on_load = []
    @on_boot = []
    @ctx = nil

    def self._run_preload
        # Initialize
        @ctx = ctx = Context.new $RGSS_SCRIPTS
        # ctx.add_script("5555555555555555555555555555555555555555Script1", "puts 'Hello, world!'")
        ctx.read_system
        ctx.read_env

        # Preload[:vcode] = vcode
        # Preload.Context.set(:vscode, vcode)
        # puts vcode
        # set :zeusrpgver, vcode
        # set :zeusrpgver, vcode
        # puts vcode
        # set :zeusrpgver, vcode
        # print "#{ctx[:zeusrpgver]}"
        print "MKXP mkxp-z #{ctx[:mkxp_version]} RGSS #{ctx[:rgss_version]} (#{RgssVersionNames[ctx[:rgss_version]]})\n"
        # Run preload hooks
        @on_preload.each{|p| p.call ctx}
        ctx.each_script do |script|
            print "Script ##{script.index}: #{script.name}#{"\t[#{script.imported_key}]" if script.imported_key}"
        end



        # Patch Scripts
        dump_scripts ctx, :dump_scripts_raw
        patch_scripts ctx
        overwrite_redefinitions ctx if ctx.flag? :redefinitions_overwrite_class
        dump_scripts ctx, :dump_scripts_patched
        # Try to inject hook after most (plugin) scripts are loaded but before game starts
        ctx.last_script.source= "Preload._run_boot\n\n" + ctx.last_script.source
        # ctx.add_script('cheat1', File.read(script_file, encoding: 'ASCII-8BIT')) if File.exist?(script_file)
        # ctx.add_script('cheat2', File.read(script_file2)) if File.exist?(script_file2)

        # Done
        if ctx.flag? :dont_run_game then
            print "KAWARIKI_MKXP_DRY_RUN is set, not continuing to game code"
            exit 123
        end
    end

    def self._run_load
        @on_load.each {|p| p.call @ctx}
    end

    def self._run_boot
        @on_boot.each {|p| p.call @ctx}
    end

    # -------------------------------------------------------------------------
    # Callbacks for user-scripts
    # -------------------------------------------------------------------------
    # Register block to be called with preload context
    def self.on_preload(&p)
        @on_preload.push p
    end

    # Register block to be called after patches are applied
    def self.on_load(&p)
        @on_load.push p
    end

    # Register block to be called on RGSS boot
    def self.on_boot(&p)
        @on_boot.push p
    end
end
_config = CFG

# puts "hhh"
def find_game_ini_in_directory(directory)
    # Search for "game.ini" within the specified directory, case-insensitive
    files = Dir.glob("#{directory}/Game.ini", File::FNM_CASEFOLD)

    # If the file exists, return the full path
    if files.any?
        return files.first  # Return the full path of the first match
    else
        return nil  # Return nil if no file is found
    end
end
game_ini_path = find_game_ini_in_directory(_config["gameFolder"].to_s)
# puts Dir.pwd



def checkini(file_path)
    # Check if the file exists
    file_path = file_path.nil? || file_path.empty? ? Dir.pwd : file_path

    if File.exist?(file_path)
        # Read the content of the file
        input_string = File.read(file_path, encoding: 'ASCII-8BIT')

        # Match the content of the file and return the appropriate value
        # Match the pattern in the input string and return corresponding values
        if input_string =~ /rvdata2/
                            return 3
        elsif input_string =~ /rvdata/
                            return 2
        elsif input_string =~ /rxdata/
                            return 1
        else
            return 3 # Return nil if none of the patterns match
        end
    else
        puts "File does not exist!"
        return nil
    end
end
vers = checkini(game_ini_path)

rgssversioncodes = ["Unknown", ":xp", ":vx", ":vxace"]

# vcode =
# set :zeusrpgver, vcode
ENV["vcode"] = rgssversioncodes[vers]
puts ENV["vcode"]
ENV["rpgvers"] = vers.to_s
# puts "nbnn"+ENV["vcode"]
# Ensure Zlib is loaded
system("testecho.sh 55555")
Kernel.require 'zlib' unless Kernel.const_defined? :Zlib
# Load patch definitions
Kernel.require File.join(Preload::Path, 'patches.rb')

# Inject user scripts
Dir['*.kawariki.rb'].each do |filename|
    Preload.print "Loading user script #{filename}"
    Kernel.require filename
end
# Apply patches to scripts
Preload._run_preload
# Run load hooks just before control returns to MKXP to run the scripts
Preload._run_load
