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


        def last_script2
            script (script_count - 6)
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
        def add_script3(name, code)
            # Find the first empty slot (check for empty string) that is not the last slot

                # No empty slot found, so insert the new script 5 positions before the end
                insert_index = [@scripts.length - 5, 0].max  # Ensure the index is not negative
                @scripts.insert(insert_index, [name, "", nil, code])
            # end
        end
        def add_script2(name, code)
            empty_index = @scripts.each_index.find do |i|
                slot = @scripts[i]
                slot.is_a?(Array) &&
                        slot[0].is_a?(String) &&
                        slot[0].empty? &&
                        i < @scripts.length - 1
            end

            if empty_index
                @scripts[empty_index][0] = name
                @scripts[empty_index][3] = code
                Preload.print "inserted into empty slot ##{empty_index}"
                return empty_index
            end

            # No empty slot: insert a new script a few positions before the end.
            # Do NOT pop anything — that was deleting the real Main script.
            insert_index = [@scripts.length - 5, 0].max
            @scripts.insert(insert_index, [name, "", nil, code])
            Preload.print "inserted at #{insert_index}"

            return insert_index
        end
        def empty_slots_near_end(target_offset: 5, window: 15)
            last = @scripts.length - 1
            lo = [last - window, 0].max
            target_index = @scripts.length - target_offset

            (lo...last).select do |i|
                slot = @scripts[i]
                slot.is_a?(Array) &&
                        slot[0].is_a?(String) && slot[0].strip.empty? &&
                        slot[3].is_a?(String) && slot[3].strip.empty?
            end.sort_by { |i| (i - target_index).abs }
        end

        def fill_slot_near_end(name, code, target_offset: 5, window: 15)
            @claimed_empty ||= []
            idx = empty_slots_near_end(target_offset: target_offset, window: window)
            .find { |i| !@claimed_empty.include?(i) }
            return nil unless idx
            @claimed_empty.push idx
            @scripts[idx][0] = name
            @scripts[idx][3] = code
            Preload.print "Filled empty slot ##{idx} (near end) with '#{name}'"
            idx
        end
        # def add_script2(name, code)
        #     empty_index = @scripts.each_index.find do |i|
        #         slot = @scripts[i]
        #         slot.is_a?(Array) &&
        #                 slot[0].is_a?(String) &&
        #                 slot[0].empty? &&
        #                 i < @scripts.length - 1
        #     end
        #
        #     if empty_index
        #         @scripts[empty_index][0] = name
        #         @scripts[empty_index][3] = code
        #         Preload.print "inserted into empty slot ##{empty_index}"
        #         return empty_index
        #     end
        #
        #     insert_index = [@scripts.length - 5, 0].max
        #     @scripts.insert(insert_index, [name, "", nil, code])
        #     Preload.print "inserted at #{insert_index}"
        #
        #     return insert_index
        # end
        def self.script_at_offset(ctx, offset)
            ctx.script(ctx.script_count - offset)
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
        # Read scrconf.txt from a directory (game folder)
        # Read scrconf.txt from a directory (game folder)
        def read_plugins_config(dir)
            @disabled_indices ||= []
            @replacement_paths ||= {}   # index => path
            cfg = File.join(dir.to_s, "scrconf.txt")
            return unless File.exist?(cfg)
            File.readlines(cfg, encoding: "ASCII-8BIT").each do |line|
                line = line.strip
                next if line.empty? || line.start_with?("#")
                # Match "123" or "123-disable" or "123-/path/to/file"
                if m = line.match(/^\s*(\d+)\s*(?:[-:]\s*(disable|(.+)))?\s*$/i)
                    idx = m[1].to_i
                    suffix = m[2]
                    path_part = m[3]
                    if suffix.nil? || suffix.downcase == "disable"
                        @disabled_indices << idx
                    elsif path_part && !path_part.strip.empty?
                        @replacement_paths[idx] = path_part.strip
                    end
                end
            end
            @disabled_indices.uniq!
            @replacement_paths = @replacement_paths.transform_keys(&:to_i)
        end

        def disabled_index?(script_or_index)
            @disabled_indices ||= []
            idx = script_or_index.is_a?(Integer) ? script_or_index : script_or_index.index
            @disabled_indices.include?(idx)
        end

        def replacement_path_for(script_or_index)
            @replacement_paths ||= {}
            idx = script_or_index.is_a?(Integer) ? script_or_index : script_or_index.index
            @replacement_paths[idx]
        end

        def disabled_indices; @disabled_indices || []; end
            def replacement_paths; @replacement_paths || {}; end




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
        ImportedKeyExpr = /
                (?:\$imported|\(\s*\$imported(?:\s*\|\|=\s*\{\s*\})?\s*\))\s*

                \[\s*(:\w+|['"][^'"]+['"])\s*\]

        \s*=\s*(.+)
        /x.freeze

        def _extract_imported
            return unless source.is_a?(String) && !source.empty?
            src = source.force_encoding("UTF-8").scrub('?') rescue source.to_s
            m = ImportedKeyExpr.match(src) || src.each_line.lazy.map { |ln| ImportedKeyExpr.match(ln) }.find(&:itself)
            return unless m
            raw = m[1]
            @imported_key = raw.start_with?(':') ? raw[1..-1].to_sym : raw[1...-1]
            @imported_value = m[2].to_s.strip.sub(/\s*#.*$/, '')
            @imported_entry = true
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
        # Replace the existing include? method with this
        def include?(str)
            if? do |script|
                # Ensure script.source is a UTF-8 string (non-destructive to original object)
                src = script.source.dup.force_encoding("UTF-8").scrub

                # Ensure the needle is UTF-8 too (handles literal or external input)
                needle = str.to_s.dup.force_encoding("UTF-8").scrub

                src.include?(needle)
            end
        end
        def matchold?(*ps)
            pattern = Regexp.union(*ps)
            if? {|script| script.source.match? pattern}
        end

        # Source code matches (any) pattern
        def match?(*ps)
            pattern = Regexp.union(*ps)
            # lambda { |script| script.source.match?(pattern) }
            if? do |script|
                # Ensure script.source is a UTF-8 string (non-destructive to original object)
                src = script.source.dup.force_encoding("UTF-8").scrub

                # Ensure the needle is UTF-8 too (handles literal or external input)
                needle = pattern.to_s.dup.force_encoding("UTF-8").scrub

                src.match?(needle)
            end
        end


        # Script sets $imported[key]
        # Robust imported? condition for Patch
        def imported?(key)
            needle = key.to_s
            if? do |script|
                begin
                    if script.respond_to?(:imported_key)
                        script.imported_key.to_s == needle
                    elsif script.respond_to?(:imported) && (h = script.imported).respond_to?(:key?)
                        h.key?(needle) || h.key?(key) || h.key?(key.to_sym)
                    elsif defined?($imported) && $imported.is_a?(Hash)
                        $imported.key?(needle) || $imported.key?(key) || $imported.key?(key.to_sym)
                    else
                        false
                    end
                rescue
                    false
                end
            end
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
        # Replace the existing sub! definition with this:
        def sub!(pattern, replacement = nil, &block)
        if block_given?
            @actions.push proc { |script|
            # Use gsub! with block so callers can compute replacement dynamically
            script.source.gsub! pattern, &block
            }
        else
            # Two-arg form: pattern + replacement string
            @actions.push proc { |script|
            script.source.gsub! pattern, replacement
            }
        end
        self
        end

        # New helper: perform a scoped replacement only inside a single method body.
        # Usage: .sub_method_body!(/def\s+name.*?end/m) { |method_src| method_src.gsub!(...) }
        def sub_method_body!(method_header_regex, &block)
        raise ArgumentError, "block required" unless block_given?
        @actions.push proc { |script|
            src = script.source
            new_src = src.gsub(method_header_regex) do |method_src|
            # yield the whole method source to the block and use its return value
            result = block.call(method_src.dup)
            # If block returns nil, keep original; otherwise use returned string
            result.nil? ? method_src : result.to_s
            end
            script.source.replace(new_src)
        }
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
            # puts filename
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
            # Remove blacklisted scripts or those disabled by index
            if ctx.blacklisted? script || ctx.disabled_index?(script)
                print "Removed #{script.loc}: Blacklisted/Disabled"
                script.remove
                next
            end


            # Encodings are a mess in RGSS. Can break Regexp matching
            e = script.source.encoding
            script.source.force_encoding "ASCII-8BIT"
            # script.source.force_encoding("UTF-8")
            # script.source.encode!("ASCII-8BIT", invalid: :replace, undef: :replace, replace: "?")
            # Apply patches
            script.source.gsub!(".encode('SHIFT_JIS')", '')

            Patches.each do |patch|
                break if patch.eval script
            end
            print "Patched #{script.loc}: #{script.log.join(', ')}" if script.log.size > 0
            # Warn if Win32API references in source
            if script.source.include? "Win32API.new" then
            # #
            #     print "Warning: Script #{script.loc} uses Win32API."
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
                if script.name.valid_encoding?
                    filename = fn_format % [script.index,
                                            script.name.empty? ? "" : " ",
                                            script.name.tr(NoFilenameChars, "_"),
                                            script.source.empty? ? "" : ".rb"]
                    File.write File.join(dump, filename), script.source
                else
                    puts "Invalid encoding for script name: #{script.name.inspect}"
                    next
                end
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
        # Read plugin config from the game's folder
        game_folder = if defined?(CFG) && CFG.is_a?(Hash) && CFG["gameFolder"]
        CFG["gameFolder"].to_s
    else
        Dir.pwd
    end

    ctx.read_plugins_config(game_folder)
    Preload.print "Disabled script indices (from scrconf.txt): #{ctx.disabled_indices.inspect}" if ctx.disabled_indices.any?
    Preload.print "Replacement paths (from scrconf.txt): #{ctx.replacement_paths.inspect}" if ctx.replacement_paths.any?

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
        # ctx.each_script do |script|
        #     print "Script ##{script.index}: #{script.name}#{"\t[#{script.imported_key}]" if script.imported_key}"
        # end
        dump_scripts ctx, :dump_scripts_raw

        replace_files = {}
        Dir.glob(File.join(CFG["gameFolder"].to_s, 'scr-*.rb')).each do |full|
            if m = File.basename(full).match(/\Ascr-(\d+)\.rb\z/i)
                replace_files[m[1].to_i] ||= full
            end
        end
        ctx.each_script do |script|
            idx = script.index
            print "Script ##{script.index}: #{script.name}#{"\t[#{script.imported_key}]" if script.imported_key}"
              # Preload.print "rp = #{replace_files.inspect}"
            if (rp = replace_files[idx])
                script.load_file rp if File.file?(rp)
                next
            end
            # Replacement takes precedence over disable if both present
            if (rp = ctx.replacement_path_for(idx))
                # Resolve relative paths against game_folder
                rp_resolved = rp.start_with?("/") ? rp : File.expand_path(rp, game_folder)
                if File.exist?(rp_resolved)
                    Preload.print "Pre-replacing #{script.loc} with #{rp_resolved}"
                    script.load_file rp_resolved
                else
                    Preload.print "Replacement file not found for #{script.loc}: #{rp_resolved}"
                end
                next
            end

            if ctx.disabled_index?(idx)
                Preload.print "Pre-removed #{script.loc} (from scrconf.txt)"
                script.remove
                next
            end
        end

        # Patch Scripts
        patch_scripts ctx
        overwrite_redefinitions ctx if ctx.flag? :redefinitions_overwrite_class
        dump_scripts ctx, :dump_scripts_patched
        # Try to inject hook after most (plugin) scripts are loaded but before game starts

        # begin
        #     load script_file
        #     ctx.last_script.source= "Preload._run_boot\n\n" + ctx.last_script.source
        # rescue Errno::ENOENT
        #    warn "Extra script file not found: #{script_file}"
        # end
        mainfd = ENV['mainfd'] || File.join(ENV['HOME'], "desktopapps")


        # if ENV['MKXPZMOUSE'] == 'true'
        #     mousescriptpath = File.join(mainfd, "nwjs/nwjs/packagefiles/mkxpz-scripts/scripts/Mouse.rb")
        # ctx.add_script2('mousescript', File.read(mousescriptpath, encoding: 'ASCII-8BIT')) if File.exist?(mousescriptpath)
        # end
        if ENV['MKXPZ999_CHEATRUBYTEST'] == 'true'
             cheatscriptpath = File.join(mainfd, "nwjs/nwjs/packagefiles/mkxpz-scripts/scripts/999_CheatRuby.rb")
             ctx.add_script2('cheatscript', File.read(cheatscriptpath, encoding: 'ASCII-8BIT')) if File.exist?(cheatscriptpath)
        end
        # if ENV['MKXPZ500SLOTS'] == 'true'
        #     # Preload.print "MKXPZ500SLOTS---------"
        #     moreslots = File.join(mainfd, "nwjs/nwjs/packagefiles/mkxpz-scripts/scripts/500slots.rb")
        #     # Preload.print "6666666666666666666666666"
        #     # Preload.print "6666666666666666666666666" if File.exist?(moreslots)
        #     ctx.add_script2('moreslots', File.read(moreslots, encoding: 'ASCII-8BIT')) if File.exist?(moreslots)
        #     #
        #     # ctx.last_script2.source= File.read(moreslots, encoding: 'ASCII-8BIT') + ctx.last_script2.source if File.exist?(moreslots)
        # { env: 'MKXPZMOUSE', name: 'mousescript', file: 'Mouse.rb',          extra_cond: ->{ [2, 3].include?(ctx[:rgss_version]) } },
        # end
        # mainfd = ENV['mainfd'] || File.join(ENV['HOME'], "desktopapps")
        scripts_dir = File.join(mainfd, "nwjs/nwjs/packagefiles/mkxpz-scripts/scripts")
        #

        injections = [
            { env: 'MKXPZMOUSE',         name: 'mousescript', file: 'Mouse.rb',
              extra_cond: ->{ ctx[:rgss_version] == 3 } },
            { env: 'MKXPZ999_CHEATRUBY', name: 'cheatscript',  file: '999_CheatRuby.rb',
              extra_cond: ->{ ctx[:rgss_version] == 3 } },
            { env: 'MKXPZSKIPDIALOGS_HOSHIGATA_VXACE', name: 'skipdialogsvxace', file: 'skipdialogs_Hoshigata_vxace.rb',
              extra_cond: ->{ ctx[:rgss_version] == 3 } },
            { env: 'MKXPZ500SLOTS',      name: 'moreslots',    file: '500slots.rb' },
            ]

        injections.each do |inj|
            next unless ENV[inj[:env]] == 'true'
            next if inj[:extra_cond] && !inj[:extra_cond].call

            path = File.join(scripts_dir, inj[:file])
            next unless File.exist?(path)

            code = File.read(path, encoding: 'ASCII-8BIT')
            idx = ctx.fill_slot_near_end(inj[:name], code, target_offset: 5, window: 15)

            if idx.nil?
                target = ctx.script(ctx.script_count - 5)
                target.source = code.dup.force_encoding("ASCII-8BIT") +
                   target.source.dup.force_encoding("ASCII-8BIT")
                Preload.print "No empty slot near -5 for '#{inj[:name]}'"
            end
        end
        # ctx.last_script.source= "Preload._run_boot\n\n" + ctx.last_script.source
        # ctx.add_script('cheat2', File.read(script_file2)) if File.exist?(script_file2)
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
    # Check if the file path is nil or empty and set it to the current directory if necessary
    file_path = file_path.nil? || file_path.empty? ? Dir.pwd : file_path

    # Check if the path is a valid file and not a directory
    if File.exist?(file_path)
        if File.file?(file_path)
            # Read the content of the file
            input_string = File.read(file_path, encoding: 'ASCII-8BIT')

            # Match the content of the file and return the appropriate value
            if input_string =~ /rvdata2/
                return 3
            elsif input_string =~ /rvdata/
                return 2
            elsif input_string =~ /rxdata/
                return 1
            else
                return 3 # Return 3 if no pattern matches
            end
        else
            puts "The specified path is a directory, not a file."
            return 3
        end
    else
        puts "File does not exist!"
        return nil
    end
end
vers = checkini(game_ini_path)

rgssversioncodes = ["Unknown", ":xp", ":vx", ":vxace"]
rgssversioncodeshr = ["Unknown", "XP", "VX", "VX Ace"]

# vcode =
# set :zeusrpgver, vcode
ENV["vcode"] = rgssversioncodes[vers]
puts "Rpg Maker " + rgssversioncodeshr[vers] + " game"
ENV["rpgvers"] = vers.to_s
# puts "nbnn"+ENV["vcode"]
# Ensure Zlib is loaded

Kernel.require 'zlib' unless Kernel.const_defined? :Zlib
# Load patch definitions

Kernel.require File.join(Preload::Path, 'patches.rb')

# Inject user scripts
Dir['*.kawariki.rb'].each do |filename|
    Preload.print "Loading user script #{filename}"
    Kernel.require filename
end

mainfd = ENV['mainfd'] || File.join(ENV['HOME'], "desktopapps")




# Build newline-separated "index: name" list from $RGSS_SCRIPTS
if ENV['MKXPEDITLIST'] == 'true'
rgss_lines = $RGSS_SCRIPTS.each_with_index.map do |entry, i|
    name = entry && entry[1] ? entry[1].to_s : ""
    "#{i}: #{name}"
end.join("\n")

# Export into ENV and run the bash script, passing game folder as arg
# env = { 'RGSS_SCRIPTS' => rgss_lines }
game_dir = CFG["gameFolder"].to_s
editscriptpath = File.join(mainfd, "nwjs/nwjs/packagefiles/mkxpz-scripts/editscripts.sh")

env = {
    'RGSS_SCRIPTS' => rgss_lines,
    'GAME_DIR'     => game_dir
}
# Option A: simple blocking call, prints to stdout/stderr
system(env, "bash", editscriptpath)
end

# puts output
# Apply patches to scripts
Preload._run_preload
# Run load hooks just before control returns to MKXP to run the scripts
Preload._run_load


if ENV['MKXPZCHEAT1YAD'] == 'true'

    fifoscriptpath = File.join(mainfd, "nwjs/nwjs/packagefiles/mkxpz-scripts/testfifo.rb")
load fifoscriptpath  if File.exist?(fifoscriptpath)
end
