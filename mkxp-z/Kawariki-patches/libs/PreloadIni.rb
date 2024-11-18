# INI file tools for replacing Win32API usage
# Key and Section names are case-preserving
# Authors: Taeyeon Mori

module Preload
    module Ini
        # ********** Machinery **********
        class DummyReadFile
            def each_line(&p)
            end
        end

        class IniBase
            def initialize(file)
                @file = file
                @section = ""
                @section_lc = ""
            end

            attr_reader :section, :section_lc

            def self.open(filename)
                if block_given? then
                    File.open(filename, self::FileMode) do |file|
                        yield self.new file
                    end
                else
                    return self.new File.new(filename, self::FileMode)
                end
            end
        end

        class IniWriter < IniBase
            FileMode = "wt"

            def initialize(file)
                super file
                @newline = 1
            end

            def writeLine(line=nil)
                if line.nil? || line.empty? then
                    @file.write "\r\n"
                    @newline += 1
                else
                    @file.write "#{line}\r\n"
                    @newline = 0
                end
            end

            def writeComment(text)
                writeLine "; #{text}"
            end

            def writeSection(name)
                lc = name.downcase
                return if lc == @section_lc
                writeLine if @newline < 1
                writeLine "[#{name}]"
                @section = name
                @section_lc = lc
            end

            def writeKey(key, value)
                value = value.to_s
                value = "\"#{value}\"" if value.strip != value
                writeLine "#{key}=#{value}"
            end

            def writeEntry(section, key, value)
                writeSection section
                writeKey key, value
            end

            def forward(token, *args)
                # Can receive tokens from IniReader directly
                case token
                when :comment
                    writeComment *args
                when :section
                    writeSection *args
                when :key
                    writeKey *args
                when :line
                    writeLine *args
                when :empty
                    writeLine
                when :eof
                else
                    raise "Unknown token: #{token}"
                end
            end
        end

        class IniReader < IniBase
            FileMode = "rt"

            def self.open(filename)
                # Pretend file is empty if it doesn't exist
                if !File.exist? filename then
                    if block_given? then
                        yield self.new DummyReadFile.new
                    else
                        return self.new DummyReadFile.new
                    end
                else
                    return super
                end
            end

            def readComment(line)
                line.slice!(0, line[1] == " " ? 2 : 1)
                [line]
            end

            def readSection(line)
                raise "Malformed section header: '#{line}'" if line[0] != '[' || line[-1] != ']'
                @section = line[1...-1]
                @section_lc = @section.downcase
                return [@section]
            end

            def readKey(line)
                key, value = line.split('=', 2)
                value.strip!
                # Allow quoting to keep surrounding whitespace
                value = value[1...-1] if value.size > 1 && "'\"".include?(value[0]) && value[0] == value[-1]
                [key.strip, value]
                rescue ArgumentError => e
                    puts "Error processing line: #{line.inspect} - #{e.message}"
                    nil
            end

            def readLine(line)
                if line.valid_encoding?
                    line.strip!
                else
                    # Optionally, handle the invalid encoding here:
                    # You can choose to skip the line, replace invalid characters, or log it.
                    line = line.encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '?')
                end
                return [:empty] if line.empty?
                return :comment, *readComment(line) if line[0] == ';'
                return :section, *readSection(line) if line[0] == '['
                return :key, *readKey(line) if line.include? '='
                # Just pass it through as last resort
                return :line, line
            end

            def read
                raise "Must be called with block" unless block_given?
                last = nil
                @file.each_line do |line|
                    tok = readLine line
                    # Collapse empty lines
                    next if tok[0] == :empty && last == :empty
                    last = tok[0]
                    yield tok
                end
                yield :eof
            end
        end

        # ********** Simple API **********
        # Read
        def self.readIniString(filename, section, key)
            # Intended to be compatible with ReadPrivateProfileString
            section_lc = section.downcase
            key_lc = key.downcase
            found_section = section.empty?
            IniReader.open filename do |ir|
                ir.read do |type, *args|
                    case type
                    when :section
                        found_section = ir.section_lc == section_lc
                    when :key
                        fkey, fval = *args
                        return fval if found_section && fkey.downcase == key_lc
                    end
                end
            end
        end

        def self.readIniStrings(filename, section, keys=nil)
            result = {}
            section_lc = section.downcase
            keys_lc = {}
            keys.each {|key| keys_lc[key.downcase] = key} unless keys.nil?
            found_section = section.empty?
            IniReader.open filename do |ir|
                ir.read do |type, *args|
                    case type
                    when :section
                        found_section = ir.section_lc == section_lc
                    when :key
                        if found_section then
                            fkey, fval = *args
                            if keys.nil? then
                                result[fkey] = fval
                            else
                                zkey = keys_lc[fkey.downcase]
                                result[zkey] = fval unless zkey.nil?
                            end
                        end
                    end
                end
            end
            return result
        end

        def self.readIniPaths(filename, paths=nil)
            result = {}
            paths_lc = {}
            paths.each {|path| lc = path.downcase; paths_lc[lc] = path unless paths_lc.include? lc} unless paths.nil?
            section_all = paths.nil? || paths.include?("/*")
            section_all_name = nil
            IniReader.open filename do |ir|
                ir.read do |type, *args|
                    case type
                    when :section
                        unless paths.nil? then
                            section_all_name = paths_lc["#{ir.section_lc}/*"]
                            section_all = !section_all_name.nil?
                            section_all_name.slice!(-2...) if section_all
                        end
                    when :key
                        fkey, fval = *args
                        if section_all then
                            fpath = "#{section_all_name.nil? ? ir.section : section_all_name}/#{fkey}"
                            result[fpath] = fval
                        else
                            fpath = "#{ir.section_lc}/#{fkey.downcase}"
                            result[paths_lc[fpath]] = fval if paths_lc.key? fpath
                        end
                    end
                end
            end
            result
        end

        def self.readIniSections(filename)
            # Get a list of sections in the file
            # Note: may contain (possibly case-mismatched) duplicates.
            sections = []
            IniReader.open filename do |ir|
                ir.read do |type, *args|
                    case type
                    when :section
                        sections.push args[0]
                    end
                end
            end
            return sections
        end

        def self.readIniKeys(filename, section)
            # Get a list of keys in a section
            # Note: may contain (possibly case-mismatched) duplicates.
            keys = []
            section_lc = section.downcase
            found_section = section.empty?
            IniReader.open filename do |ir|
                ir.read do |type, *args|
                    case type
                    when :section
                        found_section = ir.section_lc == section_lc
                    when :key
                        keys.push args[0] if found_section
                    end
                end
            end
            return keys
        end

        # Write
        def self.writeIniString(filename, section, key, value)
            # Intended to be compatible with WritePrivateProfileString
            # Write to new file then rename over top.
            section_lc = section.downcase
            key_lc = key.downcase unless key.nil?
            found_section = section.empty?
            written = key.nil? || value.nil? # Delete instead if nil
            temp_name = "#{filename}.tmp"
            IniWriter.open temp_name do |iw|
                IniReader.open filename do |ir|
                    ir.read do |type, *args|
                        case type
                        when :section
                            # Insert new key before leaving section
                            if found_section && !written then
                                iw.writeKey key, value
                                written = true
                            end
                            # Start new section or omit whole section if key == nil
                            found_section = ir.section_lc == section_lc
                            iw.writeSection ir.section unless found_section && key.nil?
                        when :key
                            fkey, fval = *args
                            if found_section then
                                if fkey.downcase == key_lc then
                                    # Replace matching key
                                    iw.writeKey key, value unless written
                                    written = true
                                elsif !key.nil? then
                                    # Copy other keys
                                    iw.writeKey fkey, fval
                                end
                            else
                                iw.writeKey fkey, fval
                            end
                        when :eof
                            # Add to end of file if not found earlier
                            iw.writeEntry section, key, value unless written
                        else
                            iw.forward type, *args
                        end
                    end
                end
            end
            File.rename(temp_name, filename)
        end

        def self.writeIniStrings(filename, section, hash)
            # Write to new file then rename over top.
            section_lc = section.downcase
            hash_lc = {}
            written = []
            hash.each_pair do |key, value|
                key_lc = key.downcase
                hash_lc[key_lc] = [key, value] unless value.nil?
                written.push key_lc if value.nil?
            end
            found_section = section.empty?
            temp_name = "#{filename}.tmp"
            IniWriter.open temp_name do |iw|
                IniReader.open filename do |ir|
                    ir.read do |type, *args|
                        case type
                        when :section
                            # Insert new keys before leaving section
                            if found_section && !hash_lc.empty? then
                                hash_lc.each_pair {|key_lc, kv| iw.writeKey *kv}
                                written.push *hash_lc.keys
                                hash_lc.clear
                            end
                            # Start new section or omit whole section if key == nil
                            found_section = ir.section_lc == section_lc
                            iw.writeSection ir.section
                        when :key
                            fkey, fval = *args
                            if found_section then
                                fkey_lc = fkey.downcase
                                entry = hash_lc.delete fkey_lc
                                if !entry.nil? then
                                    # Replace matching key
                                    iw.writeKey *entry
                                    written.push fkey_lc
                                    next
                                elsif written.include? fkey_lc then
                                    next
                                end
                            end
                            iw.writeKey fkey, fval
                        when :eof
                            # Add to end of file if not found earlier
                            if !hash_lc.empty? then
                                iw.writeSection section
                                hash_lc.each_value {|key, value| iw.writeKey key, value}
                            end
                        else
                            iw.forward type, *args
                        end
                    end
                end
            end
            File.rename(temp_name, filename)
        end

        def self.writeIniPaths(filename, hash)
            # Write to new file then rename over top.
            sections = {}
            hash.each_pair do |path, value|
                section, _, key = path.rpartition '/'
                section_lc = section.downcase
                sections[section_lc] = {name: section, written: [], keys: {}} unless sections.key? section_lc
                sections[section_lc][:keys][key.downcase] = [key, value]
            end
            current_section = sections[""]
            temp_name = "#{filename}.tmp"
            IniWriter.open temp_name do |iw|
                IniReader.open filename do |ir|
                    ir.read do |type, *args|
                        case type
                        when :section
                            # Write new keys before leaving section
                            if !current_section.nil? then
                                current_section[:keys].each_value {|key, value| iw.writeKey key, value}
                                current_section[:written].push *current_section[:keys].keys
                                current_section[:keys].clear
                            end
                            # new section
                            iw.writeSection ir.section
                            current_section = sections[ir.section_lc]
                        when :key
                            fkey, fval = *args
                            fkey_lc = fkey.downcase
                            # Replace matching key
                            if !current_section.nil? then
                                replacement = current_section[:keys].delete fkey_lc
                                if !replacement.nil? then
                                    iw.writeKey *replacement unless replacement[1].nil?
                                    current_section[:written].push fkey_lc
                                    next
                                elsif current_section[:written].include? fkey_lc then
                                    next
                                end
                            end
                            # Copy other keys
                            iw.writeKey fkey, fval
                        when :eof
                            # Add sections not previously seen
                            sections.each_value do |sect|
                                if !sect[:keys].empty? then
                                    iw.writeSection sect[:name]
                                    sect[:keys].each_value do |key, value|
                                        iw.writeKey key, value
                                    end
                                end
                            end
                        else
                            iw.forward type, *args
                        end
                    end
                end
            end
            File.rename(temp_name, filename)
        end
    end
end
