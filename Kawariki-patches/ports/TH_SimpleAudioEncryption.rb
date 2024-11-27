=begin
#===============================================================================
Title: Simple Audio Encryption MKXP-Z
Author: Taeyeon Mori
Date: Feb 23, 2022
Original Title: Simple Audio Encryption
Original Author: Hime
Original Date: Mar 22, 2014
Original URL: http://www.himeworks.com/2014/03/21/simple-audio-encryption/
--------------------------------------------------------------------------------
 ** Original Terms of Use
 * Free to use in non-commercial projects
 * Contact me for commercial use
 * No real support. The script is provided as-is
 * Will do bug fixes, but no compatibility patches
 * Features may be requested but no guarantees, especially if it is non-trivial
 * Credits to Hime Works in your project
 * Preserve this header
#===============================================================================
=end

$imported = {} if $imported.nil?
$imported[:TH_SimpleAudioEncryption] = true

module TH
    module Crypt
        @@video_extensions = [".ogv"]
        @@audio_extensions = ["", ".ogg", ".mp3", ".mid", ".wav"]
        @@cache = {}

        def self.find_real_path(path, exts)
            # return unmodified if we can verify that it exists outside archive
            return path if exts.any? {|ext| File.exist? (path + ext)}
            exts.each do|ext|
                # There is no way to check if a file exists in the archive from Ruby
                # So we try to load it to a string and see if it fails.
                # This is expensive so make sure to cache the result of this method
                candidate = "Data/" + path + ext
                begin
                    # MKXP-Z extension
                    load_data candidate, true
                rescue
                    next
                end
                Preload.print "TH_SAE: Found #{path} at #{candidate}"
                return candidate
            end
            # return nil if not found
            return nil
        end

        def self.real_path(path, exts)
            # Check cache
            real_path = @@cache[path]
            return real_path unless real_path.nil?
            # Try to find
            real_path = self.find_real_path path, exts
            # Just fall back to the original path if not found
            # Otherwise, we'll repeat the expensive lookup
            # whenever this path comes up
            real_path = path if real_path.nil?
            # Save to cache
            @@cache[path] = real_path
            return real_path
        end

        def self.real_audio_path(path)
            self.real_path path, @@audio_extensions
        end

        def self.real_video_path(path)
            self.real_path path, @@video_extensions
        end
    end
end

module Audio
    class << self
        alias :th_simple_audio_decryption_bgm_play :bgm_play
        alias :th_simple_audio_decryption_bgs_play :bgs_play
        alias :th_simple_audio_decryption_me_play :me_play
        alias :th_simple_audio_decryption_se_play :se_play
    end

    def self.bgm_play(name, *args)
        th_simple_audio_decryption_bgm_play(TH::Crypt::real_audio_path(name), *args)
    end

    def self.bgs_play(name, *args)
        th_simple_audio_decryption_bgs_play(TH::Crypt::real_audio_path(name), *args)
    end

    def self.me_play(name, *args)
        th_simple_audio_decryption_me_play(TH::Crypt::real_audio_path(name), *args)
    end

    def self.se_play(name, *args)
        th_simple_audio_decryption_se_play(TH::Crypt::real_audio_path(name), *args)
    end
end

module Graphics
    class << self
        alias :th_simple_audio_encryption_play_movie :play_movie
    end

    def self.play_movie(name, *args)
      th_simple_audio_encryption_play_movie(TH::Crypt::real_video_path(name), *args)
    end
end
