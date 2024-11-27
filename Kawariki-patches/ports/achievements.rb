# [122] 29075340: achievements
# cyanic's Quick and Easy Steamworks Achievements Integration for Ruby
# https://github.com/GMMan/RGSS_SteamUserStatsLite
# r4 06/16/16
#
# Drop steam_api.dll into the root of your project. Requires Steamworks SDK version >= 1.37.
#
# "Miller complained about how hard achievements were to implement in C++, so this was born."
#

$imported ||= {}
$imported['cyanic-SteamUserStatsLite'] = 4 # Slightly unorthodox, it's a version number.

# A context class to get Steamworks pointers to interfaces.
#
# @author cyanic
class SteamAPIContext
  STEAMCLIENT_INTERFACE_VERSION = 'SteamClient017'
  STEAMUSERSTATS_INTERFACE_VERSION = 'STEAMUSERSTATS_INTERFACE_VERSION011'
  STEAMAPPS_INTERFACE_VERSION = 'STEAMAPPS_INTERFACE_VERSION008'

  # Instantiates a new instance of +SteamAPIContext+.
  def initialize
    # @initted = false
    # @h_steam_user = # @@dll_SteamAPI_GetHSteamUser.call
    # if (@h_steam_pipe = # @@dll_SteamAPI_GetHSteamPipe.call) != 0
    #   return if (@steam_client = # @@dll_SteamInternal_CreateInterface.call(STEAMCLIENT_INTERFACE_VERSION)) == 0
    #   return if (@steam_user_stats = # @@dll_SteamAPI_ISteamClient_GetISteamUserStats.call(@steam_client, @h_steam_user, @h_steam_pipe, STEAMUSERSTATS_INTERFACE_VERSION)) == 0
    #   return if (@steam_apps = # @@dll_SteamAPI_ISteamClient_GetISteamApps.call(@steam_client, @h_steam_user, @h_steam_pipe, STEAMAPPS_INTERFACE_VERSION)) == 0
    #
    #   @initted = true
    # end
  end

  # Checks if context is initialized.
  #
  # @return [true, false] Whether context is initialized.
  def initted?
    @initted
  end

  # Gets the ISteamClient pointer
  #
  # @return [Fixnum, nil] The ISteamClient pointer if context is initialized, otherwise +nil+.
  def steam_client
    @steam_client if initted?
  end

  # Gets the ISteamUserStats pointer
  #
  # @return [Fixnum, nil] The ISteamUserStats pointer if context is initialized, otherwise +nil+.
  def steam_user_stats
    @steam_user_stats if initted?
  end

  # Gets the ISteamApps pointer
  #
  # @return [Fixnum, nil] The ISteamUserStats pointer if context is initialized, otherwise +nil+.
  def steam_apps
    @steam_apps if initted?
  end

  private
  def self.is_64bit?
    # Probably very bad detection of whether current runtime is 64-bit
    (/x64/ =~ RUBY_PLATFORM) != nil
  end

  def self.steam_dll_name
    # @@dll_name ||= self.is_64bit? ? 'steam_api64' : 'steam_api'
  end

  # @@dll_SteamAPI_GetHSteamUser = Win32API.new(self.steam_dll_name, 'SteamAPI_GetHSteamUser', '', 'I')
  # @@dll_SteamAPI_GetHSteamPipe = Win32API.new(self.steam_dll_name, 'SteamAPI_GetHSteamPipe', '', 'I')
  # @@dll_SteamInternal_CreateInterface = Win32API.new(self.steam_dll_name, 'SteamInternal_CreateInterface', 'P', 'I')
  # @@dll_SteamAPI_ISteamClient_GetISteamUserStats = Win32API.new(self.steam_dll_name, 'SteamAPI_ISteamClient_GetISteamUserStats', 'IIIP', 'I')
  # @@dll_SteamAPI_ISteamClient_GetISteamApps = Win32API.new(self.steam_dll_name, 'SteamAPI_ISteamClient_GetISteamApps', 'IIIP', 'I')

end

# A simple class for Steamworks UserStats integration.
#
# @author cyanic
class SteamUserStatsLite

  # Instantiates a new instance of +SteamUserStatsLite+.
  def initialize
    @initted = false
    api_initted = # @@dll_SteamAPI_Init.call % 256 != 0
    if api_initted
      @context = SteamAPIContext.new
      if @context.initted?
        @i_apps = @context.steam_apps
        @i_user_stats = @context.steam_user_stats
        @initted = true
      end
    end
  end

  # Shuts down Steamworks.
  #
  # @return [void]
  def shutdown
    if @initted
      @i_apps = nil
      @i_user_stats = nil
      # @@dll_SteamAPI_Shutdown.call
      @initted = false
    end
  end

  # Checks if Steamworks is initialized.
  #
  # @return [true, false] Whether Steamworks is initialized.
  def initted?
    @initted
  end

  # Restarts the app if Steamworks is not availble.
  #
  # @param app_id [Integer] The app ID to relaunch as.
  # @return [true, false] +true+ if current instance should exit, +false+ if not.
  def self.restart_app_if_necessary(app_id)
    # @@dll_SteamAPI_RestartAppIfNecessary.call(app_id) % 256 != 0
  end

  # Runs Steam callbacks.
  #
  # @return [void]
  def update
    # @@dll_SteamAPI_RunCallbacks.call if initted?
  end

  # Checks if current app is owned.
  #
  # @return [true, false, nil] Whether the current user has a license for the current app. +nil+ is returned if ownership status can't be retrieved.
  def is_subscribed
    if initted?
      # @@dll_SteamAPI_ISteamApps_BIsSubscribed.call(@i_apps) % 256 != 0
    else
      nil
    end
  end

  # Checks if a DLC is installed.
  #
  # @param app_id [Integer] The app ID of the DLC to check.
  # @return [true, false, nil] Whether the DLC is installed. +nil+ is returned if the installation status can't be retrieved.
  def is_dlc_installed(app_id)
    if initted?
      # @@dll_SteamAPI_ISteamApps_BIsDlcInstalled.call(@i_apps, app_id) % 256 != 0
    else
      nil
    end
  end

  # Pulls current user's stats from Steam.
  #
  # @return [true, false] Whether the stats have been successfully pulled.
  def request_current_stats
    if initted?
      # @@dll_SteamAPI_ISteamUserStats_RequestCurrentStats.call(@i_user_stats) % 256 != 0
    else
      false
    end
  end

  # Gets the value of an INT stat.
  #
  # @param name [String] The name of the stat.
  # @return [Integer, nil] The value of the stat, or +nil+ if the stat cannot be retrieved.
  def get_stat_int(name)
    if initted?
      val = ' ' * 4
      ok = # @@dll_SteamAPI_ISteamUserStats_GetStat.call(@i_user_stats, name, val) % 256 != 0
      ok ? val.unpack('I')[0] : nil
    else
      nil
    end
  end

  # Gets the value of an FLOAT stat.
  #
  # @param name [String] The name of the stat.
  # @return [Float, nil] The value of the stat, or +nil+ if the stat cannot be retrieved.
  def get_stat_float(name)
    if initted?
      val = ' ' * 4
      ok = # @@dll_SteamAPI_ISteamUserStats_GetStat0.call(@i_user_stats, name, val) % 256 != 0
      ok ? val.unpack('f')[0] : nil
    else
      nil
    end
  end

  # Sets the value of a stat.
  #
  # @param name [String] The name of the stat.
  # @param val [Integer, Float] The value of the stat.
  # @return [true, false] Whether the stat was successfully updated.
  # @example
  #   steam = SteamUserStatsLite.instance
  #   steam.set_stat 'YOUR_STAT_ID_HERE', 100
  #   steam.update
  def set_stat(name, val)
    if initted?

      # @@dll_SteamAPI_ISteamUserStats_StoreStats.call(@i_user_stats) % 256 != 0 && ok
    end
  end

  # Updates an AVGRATE stat.
  #
  # @param name [String] The name of the stat.
  # @param count_this_session [Float] The value during this session.
  # @param session_length [Float] The length of this session.
  # @return [true, false] Whether the stat was successfully updated.
  def update_avg_rate_stat(name, count_this_session, session_length)
    if initted?
      packed = self.class.pack_double session_length
    end
  end

  # Gets an achievement's state.
  #
  # @param name [String] The name of the achievement.
  # @return [true, false, nil] Whether the achievement has unlocked, or +nil+ if the achievement cannot be retrieved.
  def get_achievement(name)
    if initted?
      val = ' '
      ok = # @@dll_SteamAPI_ISteamUserStats_GetAchievement.call(@i_user_stats, name, val) % 256 != 0
      ok ? val.unpack('C')[0] != 0 : nil
    else
      nil
    end
  end

  # Sets an achievement as unlocked.
  #
  # @param name [String] The name of the achievement.
  # @return [true, false] Whether the achievement was set successfully.
  # @example
  #   steam = SteamUserStatsLite.instance
  #   steam.set_achievement 'YOUR_ACH_ID_HERE'
  #   steam.update
  def set_achievement(name)
    # if initted?
    #   ok = # @@dll_SteamAPI_ISteamUserStats_SetAchievement.call(@i_user_stats, name) % 256 != 0
    #   # @@dll_SteamAPI_ISteamUserStats_StoreStats.call(@i_user_stats) % 256 != 0 && ok
    # # else
    # #   false
    # end
  end

  # Sets an achievement as locked.
  #
  # @param name [String] The name of the achievement.
  # @return [true, false] Whether the achievement was cleared successfully.
  def clear_achievement(name)
    # if initted?
    #   ok = # @@dll_SteamAPI_ISteamUserStats_ClearAchievement.call(@i_user_stats, name) % 256 != 0
    #   # @@dll_SteamAPI_ISteamUserStats_StoreStats.call(@i_user_stats) % 256 != 0 && ok
    # else
    #   false
    # end
  end

  # Gets an achievement's state and unlock time.
  #
  # @param name [String] The name of the achievement.
  # @return [<Object, Time>] The achievement's state (+true+ or +false+) and the time it was unlocked.
  def get_achievement_and_unlock_time(name)
    if initted?
      achieved = ' '
      unlock_time = ' ' * 4
      ok = # @@dll_SteamAPI_ISteamUserStats_GetAchievementAndUnlockTime.call(@i_user_stats, name, achieved, unlock_time) % 256 != 0
      ok ? [achieved.unpack('C')[0] != 0, Time.at(unlock_time.unpack('L')[0])] : nil
    else
      nil
    end
  end

  # Gets the value of an achievement's display attribute.
  #
  # @param name [String] The name of the achievement.
  # @param key [String] The key of the display attribute.
  # @return [String] The value of the display attribute.
  def get_achievement_display_attribute(name, key)
    if initted?
      # @@dll_SteamAPI_ISteamUserStats_GetAchievementDisplayAttribute.call @i_user_stats, name, key
    else
      nil
    end
  end

  # Gets the number of achievements.
  #
  # @return [Integer, nil] The number of achievements, or +nil+ if the number cannot be retrieved.
  def get_num_achievements
    if initted?
      # @@dll_SteamAPI_ISteamUserStats_GetNumAchievements.call @i_user_stats
    else
      nil
    end
  end

  # Gets the name of an achievement by its index.
  #
  # @param achievement [Integer] The index of the achievement.
  # @return [String] The name of the achievement.
  def get_achievement_name(achievement)
    if initted?
      # @@dll_SteamAPI_ISteamUserStats_GetAchievementName.call @i_user_stats, achievement
    else
      nil
    end
  end

  # Resets all stats.
  #
  # @param achievements_too [true, false] Whether to reset achievements as well.
  # @return [true, false] Whether achievements have been reset.
  def reset_all_stats(achievements_too)
    # if initted?
    #   ok = # @@dll_SteamAPI_ISteamUserStats_ResetAllStats.call(@i_user_stats, achievements_too ? 1 : 0) % 256 != 0
    #   # @@dll_SteamAPI_ISteamUserStats_StoreStats.call(@i_user_stats) % 256 != 0 && ok
    # else
    #   false
    # end
  end

  # Gets the global instance of SteamUserStatsLite.
  #
  # @return [SteamUserStatsLite] The global instance of the class.
  def self.instance
    @@instance
  end

  private
  def self.is_64bit?
    # Probably very bad detection of whether current runtime is 64-bit
    (/x64/ =~ RUBY_PLATFORM) != nil
  end

  def self.steam_dll_name
    # @@dll_name ||= self.is_64bit? ? 'steam_api64' : 'steam_api'
  end

  # Function imports
  # @@dll_SteamAPI_RestartAppIfNecessary = Win32API.new(self.steam_dll_name, 'SteamAPI_RestartAppIfNecessary', 'I', 'I')
  # @@dll_SteamAPI_Init = Win32API.new(self.steam_dll_name, 'SteamAPI_Init', '', 'I')
  # @@dll_SteamAPI_Shutdown = Win32API.new(self.steam_dll_name, 'SteamAPI_Shutdown', '', 'V')
  # @@dll_SteamAPI_RunCallbacks = Win32API.new(self.steam_dll_name, 'SteamAPI_RunCallbacks', '', 'V')
  # @@dll_SteamAPI_ISteamUserStats_RequestCurrentStats = Win32API.new(self.steam_dll_name, 'SteamAPI_ISteamUserStats_RequestCurrentStats', 'P', 'I')
  # @@dll_SteamAPI_ISteamUserStats_GetStat = Win32API.new(self.steam_dll_name, 'SteamAPI_ISteamUserStats_GetStat', 'PPP', 'I')
  # @@dll_SteamAPI_ISteamUserStats_GetStat0 = Win32API.new(self.steam_dll_name, 'SteamAPI_ISteamUserStats_GetStat0', 'PPP', 'I')
  # @@dll_SteamAPI_ISteamUserStats_SetStat = Win32API.new(self.steam_dll_name, 'SteamAPI_ISteamUserStats_SetStat', 'PPL', 'I')
  # @@dll_SteamAPI_ISteamUserStats_SetStat0 = Win32API.new(self.steam_dll_name, 'SteamAPI_ISteamUserStats_SetStat0', 'PPI', 'I')
  # @@dll_SteamAPI_ISteamUserStats_UpdateAvgRateStat = Win32API.new(self.steam_dll_name, 'SteamAPI_ISteamUserStats_UpdateAvgRateStat', 'PPIII', 'I')
  # @@dll_SteamAPI_ISteamUserStats_GetAchievement = Win32API.new(self.steam_dll_name, 'SteamAPI_ISteamUserStats_GetAchievement', 'PPP', 'I')
  # @@dll_SteamAPI_ISteamUserStats_SetAchievement = Win32API.new(self.steam_dll_name, 'SteamAPI_ISteamUserStats_SetAchievement', 'PP', 'I')
  # @@dll_SteamAPI_ISteamUserStats_ClearAchievement = Win32API.new(self.steam_dll_name, 'SteamAPI_ISteamUserStats_ClearAchievement', 'PP', 'I')
  # @@dll_SteamAPI_ISteamUserStats_GetAchievementAndUnlockTime = Win32API.new(self.steam_dll_name, 'SteamAPI_ISteamUserStats_GetAchievementAndUnlockTime', 'PPPP', 'I')
  # @@dll_SteamAPI_ISteamUserStats_GetAchievementDisplayAttribute = Win32API.new(self.steam_dll_name, 'SteamAPI_ISteamUserStats_GetAchievementDisplayAttribute', 'PPP', 'P')
  # @@dll_SteamAPI_ISteamUserStats_GetNumAchievements = Win32API.new(self.steam_dll_name, 'SteamAPI_ISteamUserStats_GetNumAchievements', 'P', 'I')
  # @@dll_SteamAPI_ISteamUserStats_GetAchievementName = Win32API.new(self.steam_dll_name, 'SteamAPI_ISteamUserStats_GetAchievementName', 'PI', 'P')
  # @@dll_SteamAPI_ISteamUserStats_StoreStats = Win32API.new(self.steam_dll_name, 'SteamAPI_ISteamUserStats_StoreStats', 'P', 'I')
  # @@dll_SteamAPI_ISteamUserStats_ResetAllStats = Win32API.new(self.steam_dll_name, 'SteamAPI_ISteamUserStats_ResetAllStats', 'PI', 'I')
  # @@dll_SteamAPI_ISteamApps_BIsSubscribed = Win32API.new(self.steam_dll_name, 'SteamAPI_ISteamApps_BIsSubscribed', 'P', 'I')
  # @@dll_SteamAPI_ISteamApps_BIsDlcInstalled = Win32API.new(self.steam_dll_name, 'SteamAPI_ISteamApps_BIsDlcInstalled', 'PI', 'I')

  @@instance = self.new

  def self.pack_float(val)
    # Packs number to a string, then unpack to an int
    inter = [val].pack 'e'
    inter.unpack('I')[0]
  end

  def self.pack_double(val)
    # Packs number to a string, then unpack to an array of two ints
    inter = [val].pack 'd'
    inter.unpack 'II'
  end

end
