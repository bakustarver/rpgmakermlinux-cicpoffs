# ===========================================================================
# ★★ WF-RGSS Scripts ★★
#   Audio-EX オーディオストリーム再生スクリプト
# バージョン   ： rev-18.1(2013-4-13)
# 作者         ： A Crying Minister (WHITE-FLUTE)
# サポート先URI： http://www.whiteflute.org/wfrgss/
# ---------------------------------------------------------------------------
# 機能：
# ・ogg ファイルのストリーム再生をサポートします。
# ・RPGツクール(R)VX準拠のループ再生をサポートします。
# ・再生位置の記憶、呼び出しにより
#   途中からの再生を行う事が出来るようになります。
# ・様々なエフェクトにより更なる表現力をもたらします。
# ・戦闘曲からマップBGMへ遷移するとき、曲の途中再生を行います。
# ・曲の途中で任意のタイミングから曲をロードできます。
# ---------------------------------------------------------------------------
# 制限事項:
# ・現時点では、oggファイルしかサポートしていません。
# ---------------------------------------------------------------------------
# 設置場所     ：共通スクリプト より下、Mainより上
# 必要スクリプト：
# ・共通スクリプト、共通実行スクリプト
# 必要DLL：
# ・wfAudio.dll
# 注意事項：
# ▽Audio-ProtectEXと併用はできません。
# ▽VXAce環境ではExit-Exと併用してください。
#
# 著作権表記：
# ogg_static, vorbis_static, vorbisfile_static
# Copyright (C) 1994-2002 XIPHOPHORUS Company.
#==============================================================================
# =begin
# オーディオ保護スクリプトと対応はしていない
if defined? WFRGSS_AudioProtectEX
  raise "It is not possible to use simultaneously with this script."
end

module WFRGSS_AudioEX
# ---------------------------------------------------------------------------
# バトルBGMの途中再生を行うかを指定します。
  BATTLE_DURING_PLAYBACK = false

# ---------------------------------------------------------------------------
# マップBGMをバトルBGMに設定するスイッチIDを指定します。
  REPEAT_BATTLE_FLAG = 292

# ---------------------------------------------------------------------------
# パックファイルを使用するかを指定します。
  USE_PACKFILE = true

# ---------------------------------------------------------------------------
# パックファイルのファイルパスを指定します。
  # BGM_PACKFILE = "./Audio/bgm.bin"
  BGM_PACKFILE = "./Audio/bgm.bin"
  BGS_PACKFILE = "./Audio/bgs.bin"
  ME_PACKFILE = "./Audio/me.bin"
  SE_PACKFILE = "./Audio/se.bin"


# ---------------------------------------------------------------------------
  REMOVE_BGM_PATH = (/Audio\/BGM\//i).freeze
  REMOVE_BGS_PATH = (/Audio\/BGS\//i).freeze
  REMOVE_ME_PATH = (/Audio\/ME\//i).freeze
  REMOVE_SE_PATH = (/Audio\/SE\//i).freeze
end



# F12 リセット対策
unless defined? Audio::BGM

  module Audio
    begin
      @audio_init = Win32API.new('System/wfAudio','initialize','v','l')
      @audio_dispose = Win32API.new('System/wfAudio','dispose','v','v')
      @audio_play = Win32API.new('System/wfAudio','playBGM',%w(p i i p),'l')
      @audio_meplay = Win32API.new('System/wfAudio','playME',%w(p i i),'l')
      @audio_stop = Win32API.new('System/wfAudio','stop','v','v')
      @audio_stopsecond = Win32API.new('System/wfAudio','stopSecond','v','v')
      @audio_stopb = Win32API.new('System/wfAudio','stopBoth','v','v')
      @audio_stopme = Win32API.new('System/wfAudio','stopME','v','v')
      @audio_memory = Win32API.new('System/wfAudio','SeekMemorise','v','n')
      @audio_set = Win32API.new('System/wfAudio','SeekSet','v','n')
      @audio_clear = Win32API.new('System/wfAudio','SeekClear','v','v')
      @audio_pause = Win32API.new('System/wfAudio','Pause','v','v')
      @audio_resume = Win32API.new('System/wfAudio','Resume','v','v')
      @audio_cross = Win32API.new('System/wfAudio','setCrossFade','i','l')
      @audio_bgmfade = Win32API.new('System/wfAudio','fadeBGM','i','l')
      @audio_bgsfade = Win32API.new('System/wfAudio','fadeBGS','i','l')
      @audio_mefade = Win32API.new('System/wfAudio','fadeME','i','l')
      @audio_rtp = Win32API.new('System/wfAudio','getRTPPath',%w(p p i),'l')
      @audio_plays = Win32API.new('System/wfAudio' , 'playSecond' , %w(p i i i p) , 'l')
      @audio_balance = Win32API.new('System/wfAudio','balanceSet','i','v')
      @audio_seplay = Win32API.new('System/wfAudio','playSE',%w(p i i),'l')
      @audio_stopse = Win32API.new('System/wfAudio','stopSE','v','v')
      @audio_bgsplay = Win32API.new('System/wfAudio','playBGS',%w(p i i p),'l')
      @audio_stopbgs = Win32API.new('System/wfAudio','stopBGS','v','v')
      @audio_play_m = Win32API.new('System/wfAudio','playBGMMemory',%w(p p i i p),'l')
      @audio_plays_m = Win32API.new('System/wfAudio' , 'playSecondMemory' , %w(p p i i i p) , 'l')
      @audio_bgsplay_m = Win32API.new('System/wfAudio','playBGSMemory',%w(p p i i p),'l')
      @audio_meplay_m = Win32API.new('System/wfAudio','playMEMemory',%w(p p i i),'l')
      @audio_seplay_m = Win32API.new('System/wfAudio','playSEMemory',%w(p p i i),'l')
      @audio_isbgm = Win32API.new('System/wfAudio','isPrimaryBGMPosition','v','n')
      @audio_isbgms = Win32API.new('System/wfAudio','isSecoundryBGMPosition','v','n')
      @audio_isbgs = Win32API.new('System/wfAudio','isBGSPosition','v','n')
      @audio_bgmpan = Win32API.new('System/wfAudio','primaryBGMPan','i','v')
      @audio_secondpan = Win32API.new('System/wfAudio','secondryBGMPan','i','v')
      @audio_bgspan = Win32API.new('System/wfAudio','BGSPan','i','v')
      @audio_mepan = Win32API.new('System/wfAudio','MEPan','i','v')
      @audio_sepan = Win32API.new('System/wfAudio','SEPan','i','v')
      @audio_pbgmreverb = Win32API.new('System/wfAudio','primaryBGMReverb',%w(i i),'v')
      @audio_sbgmreverb = Win32API.new('System/wfAudio','secondryBGMReverb',%w(i i),'v')
      @audio_bgsreverb = Win32API.new('System/wfAudio','BGSReverb',%w(i i),'v')
      @audio_mereverb = Win32API.new('System/wfAudio','MEReverb',%w(i i),'v')
      @audio_sereverb = Win32API.new('System/wfAudio','SEReverb',%w(i i),'v')
      @audio_pbgmeffect = Win32API.new('System/wfAudio','primaryBGMEffect',%w(i i),'v')
      @audio_sbgmeffect = Win32API.new('System/wfAudio','secondryBGMEffect',%w(i i),'v')
      @audio_bgseffect = Win32API.new('System/wfAudio','BGSEffect',%w(i i),'v')
      @audio_meeffect = Win32API.new('System/wfAudio','MEEffect',%w(i i),'v')
      @audio_seeffect = Win32API.new('System/wfAudio','SEEffect',%w(i i),'v')
      @audio_pbgmeffectd = Win32API.new('System/wfAudio','primaryBGMEffectDetail',%w(i i),'v')
      @audio_sbgmeffectd = Win32API.new('System/wfAudio','secondryBGMEffectDetail',%w(i i),'v')
      @audio_bgseffectd = Win32API.new('System/wfAudio','BGSEffectDetail',%w(i i),'v')
      @audio_meeffectd = Win32API.new('System/wfAudio','MEEffectDetail',%w(i i),'v')
      @audio_seeffectd = Win32API.new('System/wfAudio','SEEffectDetail',%w(i i),'v')

      @audio_vceffectd = Win32API.new('System/wfAudio','voiceEffectDetail',%w(i i),'v')
      @audio_vceffect = Win32API.new('System/wfAudio','voiceEffect',%w(i i),'v')
      @audio_vcreverb = Win32API.new('System/wfAudio','voiceReverb',%w(i i),'v')
      @audio_vcpan = Win32API.new('System/wfAudio','voicePan','i','v')
      @audio_isvcn = Win32API.new('System/wfAudio','isVoicePositionNumber','i','n')
      @audio_isvcf = Win32API.new('System/wfAudio','isVoicePositionFileName','p','n')
      @audio_vclenn = Win32API.new('System/wfAudio','voiceLengthNumber','i','n')
      @audio_vclenf = Win32API.new('System/wfAudio','voiceLengthFileName','p','n')
      @audio_vcpingn = Win32API.new('System/wfAudio','isVoicePlayingNumber','i','i')
      @audio_vcpingf = Win32API.new('System/wfAudio','isVoicePlayingFileName','p','i')
      @audio_stopvc = Win32API.new('System/wfAudio','stopVoice','v','v')
      @audio_vcplay = Win32API.new('System/wfAudio','playVoice',%w(p i i i),'l')
      @audio_vcplay_m = Win32API.new('System/wfAudio','playVoiceMemory',%w(p p i i i),'l')

      @audio_pbgmlen = Win32API.new('System/wfAudio','primaryBGMLength','v','n')
      @audio_sbgmlen = Win32API.new('System/wfAudio','secondryBGMLength','v','n')
      @audio_bgslen = Win32API.new('System/wfAudio','BGSLength','v','n')
      @audio_pbgmloop = Win32API.new('System/wfAudio','isPrimaryBGMLoopEnd','v','i')
      @audio_sbgmloop = Win32API.new('System/wfAudio','isSecondryBGMLoopEnd','v','i')
      @audio_bgsloop = Win32API.new('System/wfAudio','isBGSLoopEnd','v','i')
      @audio_vcpermiln = Win32API.new('System/wfAudio','isVoicePositionPermilNumber','i','i')
      @audio_vcpermilf = Win32API.new('System/wfAudio','isVoicePositionPermilFileName','p','i')

      @audio_pbgmcheck = Win32API.new('System/wfAudio','isPrimaryBGMCheckPoint','l','i')
      @audio_sbgmcheck = Win32API.new('System/wfAudio','isSecoundryBGMCheckPoint','l','i')
      @audio_bgscheck = Win32API.new('System/wfAudio','isBGSCheckPoint','l','i')
      @audio_cue = Win32API.new('System/wfAudio','cuePrimaryBGM','v','v')
      @audio_pbgm_reserve = Win32API.new('System/wfAudio','reservePrimaryBGM',%w(p i i l l i),'l')
      @audio_pbgm_reserve_m = Win32API.new('System/wfAudio','reservePrimaryBGMMemory',%w(p p i i l l i),'l')
    rescue Exception
      raise if debug?
      raise(LoadError,"cannot read modules.(wfAudio.dll)")
    end

    begin
      @audio_mci = Win32API.new('winmm', 'mciSendString', %w(p p l l),'i')
    rescue Exception
      raise if debug?
      raise(LoadError,"cannot read modules.(winmm.dll)")
    end
    begin
      # ini ファイルから、セクションのキーを取得するAPI
      @audio_gpps = Win32API.new('kernel32',
                      'GetPrivateProfileStringA',%w(p p p p l p),'l').freeze
    rescue Exception
      raise if debug?
      raise(LoadError,"cannot read modules.(kernel32.dll)")              
    end
    
    @audio__init = false
    @audio_bgm = Hash.new
    @audio_bgs = Hash.new
    @audio_me = Hash.new

    @audio_t = nil
    @audio_tbgm = nil
    @audio_tbgs = nil
    # -----------------------------------------------------------------------
    # この定数は削除しないでください。
    # この定数を削除してF12によるリセットを行うと、
    # 例外 SystemStackError が発生します。
    BGM = true

    # -----------------------------------------------------------------------
    # リバーブのタイプ 
    # ※一般的に遠くに聞こえるようになり、音量が小さくなります。
    # ※聞こえにくいものもあります。
    REVERB_DEFAULT         = 0  # デフォルト
    REVERB_GENERIC         = 1  # 一般
    REVERB_PADDEDCELL      = 2  # クッション壁のある部屋
    REVERB_ROOM            = 3  # 室内
    REVERB_BATHROOM        = 4  # バスルーム
    REVERB_LIVINGROOM      = 5  # リビングルーム
    REVERB_STONEROOM       = 6  # 石造りの部屋
    REVERB_AUDITORIUM      = 7  # 講堂
    REVERB_CONCERTHALL     = 8  # コンサートホール
    REVERB_CAVE            = 9  # 洞窟
    REVERB_ARENA           = 10 # 競技場
    REVERB_HANGAR          = 11 # 格納庫
    REVERB_CARPETEDHALLWAY = 12 # 絨毯敷きの通路
    REVERB_HALLWAY         = 13 # 廊下
    REVERB_STONECORRIDOR   = 14 # 石造りの廊下
    REVERB_ALLEY           = 15 # 路地
    REVERB_FOREST          = 16 # 森
    REVERB_CITY            = 17 # 街・都会
    REVERB_MOUNTAINS       = 18 # 山中
    REVERB_QUARRY          = 19 # 採石場
    REVERB_PLAIN           = 20 # 平原
    REVERB_PARKINGLOT      = 21 # 駐車場
    REVERB_SEWERPIPE       = 22 # 下水管内
    REVERB_UNDERWATER      = 23 # 水中
    REVERB_SMALLROOM       = 24 # 小部屋
    REVERB_MEDIUMROOM      = 25 # 中部屋
    REVERB_LARGEROOM       = 26 # 大部屋
    REVERB_MEDIUMHALL      = 27 # 中ホール
    REVERB_LARGEHALL       = 28 # 大ホール
    REVERB_PLATE           = 29 # プレートリバーブ
    # -----------------------------------------------------------------------
    # エフェクト
    OFF        = 0 # オフ(リバーブ使用可)
    ECHO       = 1 # エコー
    CHORUS     = 2 # コーラス
    FLANGER    = 3 # フランジャー
    GARGLE     = 4 # ガーグル
    DISTORTION = 5 # ディストーション
    COMPRESSOR = 6 # コンプレッション
    PARAMEQ    = 7 # パラメトリック・イコライザー

    # -----------------------------------------------------------------------
    # 波形
    WAVE_TRIANGLE = 0 # 三角波
    WAVE_SIN      = 1 # サイン波
    WAVE_SQUARE   = 1 # 矩形波

    # -----------------------------------------------------------------------
    # フェイズ
    PHASE_NEG_180 = 0 # -180°
    PHASE_NEG_90  = 1 # -90°
    PHASE_ZERO    = 2 # 0°
    PHASE_90      = 3 # 90°
    PHASE_180     = 4 # 180°

    # -----------------------------------------------------------------------
    # エコー
    ECHO_WETDRYMIX  = 0 # 0～10000 (0.00％～100.00％)
    ECHO_FEEDBACK   = 1 # 0～10000 (0.00％～100.00％)
    ECHO_LEFTDELAY  = 2 # 100～200000 (1ms～2000ms)
    ECHO_RIGHTDELAY = 3 # 100～200000 (1ms～2000ms)
    ECHO_PANDELAY   = 4 # 0～1

    # -----------------------------------------------------------------------
    # コーラス
    CHORUS_WETDRYMIX = 0 # 0～10000 (0.00％～100.00％)
    CHORUS_DEPTH     = 1 # 0～10000 (0.00％～100.00％)
    CHORUS_FEEDBACK  = 2 # -9900～9900 (-99.00％～99.00％)
    CHORUS_FREQUENCY = 3 # 0～10
    CHORUS_WAVE_FORM = 4 # 波形(0～1)三角波・サイン波
    CHORUS_PHASE     = 5 # フェイズ(0～4)
    CHORUS_DELAY     = 6 # 0～2000

    # -----------------------------------------------------------------------
    # フランジャー
    FLANGER_WETDRYMIX = 0 # 0～10000 (0.00％～100.00％)
    FLANGER_DEPTH     = 1 # 0～10000 (0.00％～100.00％)
    FLANGER_FEEDBACK  = 2 # -9900～9900 (-99.00％～99.00％)
    FLANGER_FREQUENCY = 3 # 0～10
    FLANGER_WAVE_FORM = 4 # 波形(0～1)三角波・サイン波
    FLANGER_PHASE     = 5 # フェイズ(0～4)
    FLANGER_DELAY     = 6 # 0～400

    # -----------------------------------------------------------------------
    # ガーグル
    GARGLE_RATEHZ    = 0 # 1～1000(Hz)
    GARGLE_WAVE_FORM = 1 # 波形(0～1)三角波・矩形波

    # -----------------------------------------------------------------------
    # ディストーション
    DISTORTION_GAIN                  = 0 # -6000～0(-60.00dB～0.00dB)
    DISTORTION_EDGE                  = 1 # 0～10000 (0.00％～100.00％)
    DISTORTION_POSTEQCENTERFREQUENCY = 2 # 10000～800000(100Hz～8000Hz)
    DISTORTION_POSTEQBANDWIDTH       = 3 # 10000～800000(100Hz～8000Hz)
    DISTORTION_PRELOWPASSCUTOFF      = 4 # 10000～800000(100Hz～8000Hz)

    # -----------------------------------------------------------------------
    # コンプレッション
    COMPRESSOR_GAIN      = 0 # -6000～6000(-60.00dB～60.00dB)
    COMPRESSOR_ATTACK    = 1 # 1～50000(0.01ms～500ms)
    COMPRESSOR_RELEASE   = 2 # 5000～300000(50ms～3000ms)
    COMPRESSOR_THRESHOLD = 3 # -6000～0(-60.00dB～0.00dB)
    COMPRESSOR_RATIO     = 4 # 100～10000(1n:m～100n:m)
    COMPRESSOR_PREDELAY  = 5 # 0～400

    # -----------------------------------------------------------------------
    # パラメトリック・イコライザー
    PARAMEQ_CENTER    = 0 # 8000～1600000(80Hz～16000Hz)
    PARAMEQ_BANDWIDTH = 1 # 100～3600(1～36)
    PARAMEQ_GAIN      = 2 # -1500～1500(-15.00dB～15.00dB)

  end

  class << Audio
    # -------------------------------------------------------------------------
    # ● データの取得
    # -------------------------------------------------------------------------
    def Audio.get
      get_file( "Audio/BGM/" , @audio_bgm )
      get_file( "Audio/BGS/" , @audio_bgs )
      get_file( "Audio/ME/" , @audio_me )
      if rpgvx?
        if rpgvxace?
          ret = "\x00" * 256
          @audio_gpps.call('Game',"RTP",'' , ret , 255 , '.\Game.ini' )
          ret.tr!("\x00","")
          return if ret.empty?
          path = "\x00" * 301
          @audio_rtp.call( ret , path , 3 )
          path.force_encoding("ASCII-8BIT")
          # p "Audio.get path = #{path}"
          for j in 0...path.size
            break if path[j] == "\x00"
          end
          path = path[0...j]
          return if path.empty?
          path = String.ansi2utf8( path )
          path.gsub!(/\x00/){""}
          path.gsub!(/\\/){"/"}
          # p "Audio.get path = #{path}"
          # RTPのインストール情報はレジストリの値に設定されてるっぽい add zorome
          get_file( "#{path}/Audio/BGM/" , @audio_bgm )
          get_file( "#{path}/Audio/BGS/" , @audio_bgs )
          get_file( "#{path}/Audio/ME/" , @audio_me )
        else
          ret = "\x00" * 256
          @audio_gpps.call('Game',"RTP",'' , ret , 255 , '.\Game.ini' )
          ret.tr!("\x00","")
          return if ret.empty?
          path = "\x00" * 301
          @audio_rtp.call( ret , path , 2 )
          for j in 0...path.size
            break if path[j] == 0
          end
          path = path[0...j]
          return if path.empty?
          path = String.ansi2utf8( path )
          path.gsub!(/\x00/){""}
          path.gsub!(/\\/){"/"}
          get_file( "#{path}/Audio/BGM/" , @audio_bgm )
          get_file( "#{path}/Audio/BGS/" , @audio_bgs )
          get_file( "#{path}/Audio/ME/" , @audio_me )
        end
      else
        for i in 1..3
          ret = "\x00" * 256
          @audio_gpps.call('Game',"RTP#{i}",'' , ret , 255 , '.\Game.ini' )
          ret.tr!("\x00","")
          next if ret.empty?
          path = "\x00" * 301
          @audio_rtp.call( ret , path , 1 )
          for j in 0...path.size
            break if path[j] == 0
          end
          path = path[0...j]
          next if path.empty?
          path = String.ansi2utf8( path )
          path.gsub!(/\x00/){""}
          path.gsub!(/\\/){"/"}
          get_file( "#{path}/Audio/BGM/" , @audio_bgm )
          get_file( "#{path}/Audio/BGS/" , @audio_bgs )
          get_file( "#{path}/Audio/ME/" , @audio_me )
        end
      end
    end
    # -------------------------------------------------------------------------
    # ● データの取得
    # -------------------------------------------------------------------------
    def Audio.get_file( path , data )
      Dir.foreach( path ) do | file |
        xpath = File.basename(file,File.extname(file))
        if rpgvxace? && xpath.encoding.name != "UTF-8"
          xpath = String.ansi2utf8( xpath )
          xpath.gsub!(/\x00/){""}
        end
        bfile = path + xpath
        next if xpath == "." or xpath == ".."
        data[bfile] = File.extname(file).downcase
      end
    rescue SystemCallError
    end
    # -------------------------------------------------------------------------
    # ● プライマリBGMの長さ
    # -------------------------------------------------------------------------
    def Audio.primary_bgm_length
      @audio_pbgmlen.call() if init_check
    end
    # -------------------------------------------------------------------------
    # ● セカンダリBGMの長さ
    # -------------------------------------------------------------------------
    def Audio.secondry_bgm_length
      @audio_sbgmlen.call() if init_check
    end
    # -------------------------------------------------------------------------
    # ● BGSの長さ
    # -------------------------------------------------------------------------
    def Audio.bgs_length
      @audio_bgslen.call() if init_check
    end
    # -------------------------------------------------------------------------
    # ● プライマリBGMループ
    # -------------------------------------------------------------------------
    def Audio.primary_bgm_loop?
      (@audio_pbgmloop.call() == 1) if init_check
    end
    # -------------------------------------------------------------------------
    # ● セカンダリBGMループ
    # -------------------------------------------------------------------------
    def Audio.secondry_bgm_loop?
      (@audio_sbgmloop.call() == 1) if init_check
    end
    # -------------------------------------------------------------------------
    # ● BGSループ
    # -------------------------------------------------------------------------
    def Audio.bgs_loop?
      (@audio_bgsloop.call() == 1) if init_check
    end
    # -------------------------------------------------------------------------
    # ● BGMのエフェクト
    # -------------------------------------------------------------------------
    def Audio.bgm_effect( type , effect )
      # p "※Audio_EX2 Audio.bgm_effect start" # add zorome
      @audio_pbgmeffect.call( type , effect ? 1 : 0 ) if init_check
    end
    # -------------------------------------------------------------------------
    # ● BGMのエフェクト
    # -------------------------------------------------------------------------
    def Audio.second_effect( type , effect )
      @audio_sbgmeffect.call( type , effect ? 1 : 0 ) if init_check
    end
    # -------------------------------------------------------------------------
    # ● BGSのエフェクト
    # -------------------------------------------------------------------------
    def Audio.bgs_effect( type , effect )
      @audio_bgseffect.call( type , effect ? 1 : 0 ) if init_check
    end
    # -------------------------------------------------------------------------
    # ● MEのエフェクト
    # -------------------------------------------------------------------------
#~     def Audio.me_effect( type , effect )
#~       @audio_meeffect.call( type , effect ? 1 : 0 ) if init_check
#~     end
    # -------------------------------------------------------------------------
    # ● SEのエフェクト
    # -------------------------------------------------------------------------
    def Audio.se_effect( type , effect )
      @audio_seeffect.call( type , effect ? 1 : 0 ) if init_check
    end
    # -------------------------------------------------------------------------
    # ● ボイスのエフェクト
    # -------------------------------------------------------------------------
    def Audio.voice_effect( type , effect )
      @audio_vceffect.call( type , effect ? 1 : 0 ) if init_check
    end
    # -------------------------------------------------------------------------
    # ● BGMのエフェクト 詳細
    # -------------------------------------------------------------------------
    def Audio.bgm_effect_detail( item , value )
      # p "※Audio_EX2 Audio.bgm_effect_detail start" # add zorome
      @audio_pbgmeffectd.call( item , value ) if init_check
    end
    # -------------------------------------------------------------------------
    # ● BGMのエフェクト 詳細
    # -------------------------------------------------------------------------
    def Audio.second_effect_detail( item , value )
      @audio_sbgmeffectd.call( item , value ) if init_check
    end
    # -------------------------------------------------------------------------
    # ● BGSのエフェクト 詳細
    # -------------------------------------------------------------------------
    def Audio.bgs_effect_detail( item , value )
      @audio_bgseffectd.call( item , value ) if init_check
    end
    # -------------------------------------------------------------------------
    # ● MEのエフェクト 詳細
    # -------------------------------------------------------------------------
#~     def Audio.me_effect_detail( item , value )
#~       @audio_meeffectd.call( item , value ) if init_check
#~     end
    # -------------------------------------------------------------------------
    # ● SEのエフェクト 詳細
    # -------------------------------------------------------------------------
    def Audio.se_effect_detail( item , value )
      @audio_seeffectd.call( item , value ) if init_check
    end
    # -------------------------------------------------------------------------
    # ● ボイスのエフェクト 詳細
    # -------------------------------------------------------------------------
    def Audio.voice_effect_detail( item , value )
      @audio_vceffectd.call( item , value ) if init_check
    end
    # -------------------------------------------------------------------------
    # ● BGMのリバーブ
    # -------------------------------------------------------------------------
    def Audio.bgm_reverb( type , effect )
      # p "※Audio_EX2 Audio.bgm_reverb start" # add zorome
      @audio_pbgmreverb.call( type , effect ? 1 : 0 ) if init_check
    end
    # -------------------------------------------------------------------------
    # ● BGMのリバーブ
    # -------------------------------------------------------------------------
    def Audio.second_reverb( type , effect )
      @audio_sbgmreverb.call( type , effect ? 1 : 0 ) if init_check
    end
    # -------------------------------------------------------------------------
    # ● BGSのリバーブ
    # -------------------------------------------------------------------------
    def Audio.bgs_reverb( type , effect )
      @audio_bgsreverb.call( type , effect ? 1 : 0 ) if init_check
    end
    # -------------------------------------------------------------------------
    # ● MEのリバーブ
    # -------------------------------------------------------------------------
#~     def Audio.me_reverb( type , effect )
#~       @audio_mereverb.call( type , effect ? 1 : 0 ) if init_check
#~     end
    # -------------------------------------------------------------------------
    # ● SEのリバーブ
    # -------------------------------------------------------------------------
    def Audio.se_reverb( type , effect )
      @audio_sereverb.call( type , effect ? 1 : 0 ) if init_check
    end
    # -------------------------------------------------------------------------
    # ● ボイスのリバーブ
    # -------------------------------------------------------------------------
    def Audio.voice_reverb( type , effect )
      @audio_vcreverb.call( type , effect ? 1 : 0 ) if init_check
    end
    # -------------------------------------------------------------------------
    # ● BGMの定位
    # -------------------------------------------------------------------------
    def Audio.bgm_pan( pan )
      # p "※Audio_EX2 Audio.bgm_pan start" # add zorome
      @audio_bgmpan.call(pan) if init_check
    end
    # -------------------------------------------------------------------------
    # ● BGMの定位
    # -------------------------------------------------------------------------
    def Audio.second_pan( pan )
      @audio_secondpan.call(pan) if init_check
    end
    # -------------------------------------------------------------------------
    # ● BGSの定位
    # -------------------------------------------------------------------------
    def Audio.bgs_pan( pan )
      @audio_bgspan.call(pan) if init_check
    end
    # -------------------------------------------------------------------------
    # ● MEの定位
    # -------------------------------------------------------------------------
    def Audio.me_pan( pan )
      @audio_mepan.call(pan) if init_check
    end
    # -------------------------------------------------------------------------
    # ● SEの定位
    # -------------------------------------------------------------------------
    def Audio.se_pan( pan )
      @audio_sepan.call(pan) if init_check
    end
    # -------------------------------------------------------------------------
    # ● ボイスの定位
    # -------------------------------------------------------------------------
    def Audio.voice_pan( pan )
      @audio_vcpan.call(pan) if init_check
    end
    # -------------------------------------------------------------------------
    # ● BGMのフェードイン
    # -------------------------------------------------------------------------
    def Audio.bgm_fadein( bgm ,fadetime ,volume ,pitch )
      # p "※Audio_EX2 Audio.bgm_fadein start" # add zorome
      tm = 0.01
      tm = fadetime.to_f / volume.to_f if volume > 0
      @audio_tbgm = Thread.new do
        loop do
          break unless @audio_t
          sleep(0.01)
        end
        _bgm_play( bgm , 0 , pitch )
        for i in 1..volume
          sleep(tm)
          _bgm_play( bgm , i, pitch )
        end
        Graphics.frame_reset
        @audio_tbgm = nil
      end
      Graphics.frame_reset
    end
    # -------------------------------------------------------------------------
    # ● BGSのフェードイン
    # -------------------------------------------------------------------------
    def Audio.bgs_fadein( bgs ,fadetime ,volume ,pitch )
      tm = 0.01
      tm = fadetime.to_f / volume.to_f if volume > 0
      @audio_tbgs = Thread.new do
        loop do
          break unless @audio_t
          sleep(0.01)
        end
        _bgs_play( bgs , 0 , pitch )
        for i in 1..volume
          sleep(tm)
          _bgs_play( bgs , i, pitch )
        end
        Graphics.frame_reset
        @audio_tbgs = nil
      end
      Graphics.frame_reset
    end
    # -------------------------------------------------------------------------
    # ● BGMのフェードイン
    # -------------------------------------------------------------------------
    def Audio.bgm_fadein?
      # p "※Audio_EX2 Audio.bgm_fadein? start" # add zorome
      @audio_tbgm
    end   
    # -------------------------------------------------------------------------
    # ● BGSのフェードイン
    # -------------------------------------------------------------------------
    def Audio.bgs_fadein?
      @audio_tbgs
    end
    # -------------------------------------------------------------------------
    # ● 初期化
    # -------------------------------------------------------------------------
    def Audio.ogg_init
#~       p "Audio.ogg_init"
      unless @audio__init
#~         p "Audio.ogg_init unless"
        ret = @audio_init.call() 
      end
      @audio__init = true if ret == 0
    end
    # -------------------------------------------------------------------------
    # ● 解放
    # -------------------------------------------------------------------------
    def Audio.dispose
#~       p "Audio.dispose"
      if init_check
#~         p "Audio.dispose init_check true"
        @audio_dispose.call() 
      end
      @audio__init = false
    end
    # -------------------------------------------------------------------------
    # ● 再生位置取得
    # -------------------------------------------------------------------------
    def Audio.is_primary_bgm_position
      @audio_isbgm.call() if init_check
    end
    # -------------------------------------------------------------------------
    # ● 再生位置取得
    # -------------------------------------------------------------------------
    def Audio.is_secondry_bgm_position
      @audio_isbgms.call() if init_check
    end
    # -------------------------------------------------------------------------
    # ● 再生位置取得
    # -------------------------------------------------------------------------
    def Audio.is_bgs_position
      @audio_isbgs.call() if init_check
    end
    # -------------------------------------------------------------------------
    # ● 再生位置取得
    # -------------------------------------------------------------------------
    alias :__wfrgss_audio_bgm_pos__ :bgm_pos if rpgvxace?
    def Audio.bgm_pos
#~       p "※Audio_EX2 Audio.bgm_pos start" # add zorome
      pos = is_primary_bgm_position
      # pos = __wfrgss_audio_bgm_pos__ if pos.zero? && rpgvxace?
      pos
    end
    private(:__wfrgss_audio_bgm_pos__) if rpgvxace?
    # -------------------------------------------------------------------------
    # ● 再生位置取得
    # -------------------------------------------------------------------------
    alias :__wfrgss_audio_bgs_pos__ :bgs_pos if rpgvxace?
    def Audio.bgs_pos
      pos = is_bgs_position
      # pos = __wfrgss_audio_bgs_pos__ if pos.zero? && rpgvxace?
      pos
    end
    private(:__wfrgss_audio_bgs_pos__) if rpgvxace?
    # -------------------------------------------------------------------------
    # ● 再生位置取得
    # -------------------------------------------------------------------------
    def Audio.is_voice_position_number(n)
      @audio_isvcn.call(n) if init_check
    end
    # -------------------------------------------------------------------------
    # ● 再生位置取得
    # -------------------------------------------------------------------------
    def Audio.is_voice_position_filename(filename)
      val = 0
      val = @audio_isvcf.call(String.utf82ansi(filename + '.ogg')) if init_check
      if val <= 0
        filenames = filename.sub(WFRGSS_AudioEX::REMOVE_SE_PATH){ "" }
        return @audio_isvcf.call(String.utf82ansi(filenames + '.ogg')) if init_check
        return val
      else
        return val
      end
    end
    # -------------------------------------------------------------------------
    # ● ボイスの長さ取得
    # -------------------------------------------------------------------------
    def Audio.voice_length_number(n)
      @audio_vclenn.call(n) if init_check
    end
    # -------------------------------------------------------------------------
    # ● ボイスの長さ取得
    # -------------------------------------------------------------------------
    def Audio.voice_length_filename(filename)
      val = 0
      val = @audio_vclenf.call(String.utf82ansi(filename + '.ogg')) if init_check
      if val <= 0
        filenames = filename.sub(WFRGSS_AudioEX::REMOVE_SE_PATH){ "" }
        return @audio_vclenf.call(String.utf82ansi(filenames + '.ogg')) if init_check
        return val
      else
        return val
      end
    end
    # -------------------------------------------------------------------------
    # ● ボイスの演奏中か？
    # -------------------------------------------------------------------------
    def Audio.voice_playing_number?(n)
      @audio_vcpingn.call(n) != 0 if init_check
    end
    # -------------------------------------------------------------------------
    # ● ボイスの演奏中か？
    # -------------------------------------------------------------------------
    def Audio.voice_playing_filename?(filename)
      val = 0
      val = @audio_vcpingf.call(String.utf82ansi(filename + '.ogg')) if init_check
      if val.zero?
        filenames = filename.sub(WFRGSS_AudioEX::REMOVE_SE_PATH){ "" }
        return @audio_vcpingf.call(String.utf82ansi(filenames + '.ogg')) != 0 if init_check
        return false
      else
        return true
      end
    end
    # -------------------------------------------------------------------------
    # ● ボイスの進行度 ‰
    # -------------------------------------------------------------------------
    def Audio.voice_permil_number(n)
      @audio_vcpermiln.call(n) if init_check
    end
    # -------------------------------------------------------------------------
    # ● ボイスの進行度 ‰
    # -------------------------------------------------------------------------
    def Audio.voice_permil_filename(filename)
      val = 0
      val = @audio_vcpermilf.call(String.utf82ansi(filename + '.ogg')) if init_check
      if val.zero?
        filenames = filename.sub(WFRGSS_AudioEX::REMOVE_SE_PATH){ "" }
        return @audio_vcpermilf.call(String.utf82ansi(filenames + '.ogg')) if init_check
        return val
      else
        return val
      end
    end
    # -------------------------------------------------------------------------
    # ● プライマリBGM チェックポイント
    # -------------------------------------------------------------------------
    def Audio.is_primary_bgm_checkpoint( checkpoint )
      # p "※Audio_EX2 Audio.is_primary_bgm_checkpoint start" # add zorome
      @audio_pbgmcheck.call(checkpoint) != 0 if init_check
    end
    # -------------------------------------------------------------------------
    # ● セカンダリBGM チェックポイント
    # -------------------------------------------------------------------------
    def Audio.is_secoundry_bgm_checkpoint( checkpoint )
      @audio_sbgmcheck.call(checkpoint) != 0 if init_check
    end
    # -------------------------------------------------------------------------
    # ● BGS チェックポイント
    # -------------------------------------------------------------------------
    def Audio.is_bgs_checkpoint( checkpoint )
      @audio_bgscheck.call(checkpoint) != 0 if init_check
    end
    # -------------------------------------------------------------------------
    # ● プライマリBGM キュー
    # -------------------------------------------------------------------------
    def Audio.primary_bgm_cue
      # p "※Audio_EX2 Audio.primary_bgm_cue start" # add zorome
      @audio_cue.call() if init_check
    end
    # -------------------------------------------------------------------------
    # ● 一時停止
    # -------------------------------------------------------------------------
    def Audio.pause
      # p "※Audio_EX2 Audio.pause start" # add zorome
      @audio_pause.call() if init_check
    end
    # -------------------------------------------------------------------------
    # ● レジューム
    # -------------------------------------------------------------------------
    def Audio.resume
      # p "※Audio_EX2 Audio.resume start" # add zorome
      @audio_resume.call() if init_check
    end
    # -------------------------------------------------------------------------
    # ● 再生位置記憶
    # -------------------------------------------------------------------------
    def Audio.seek_memorise
      @audio_memory.call() if init_check
    end
    # -------------------------------------------------------------------------
    # ● 再生位置セット
    # -------------------------------------------------------------------------
    def Audio.seek_set
      @audio_set.call() if init_check
    end
    # -------------------------------------------------------------------------
    # ● 再生位置クリア
    # -------------------------------------------------------------------------
    def Audio.seek_clear
      @audio_clear.call() if init_check
    end
    # -------------------------------------------------------------------------
    # ● クロスフェードの設定
    # -------------------------------------------------------------------------
    def Audio.cross_fade( fade_time )
#~       p "※Audio_EX2 Audio.cross_fade start" # add zorome
      @audio_cross.call( fade_time ) if init_check
    end
    # -------------------------------------------------------------------------
    # ● ヘッダの参照
    # -------------------------------------------------------------------------
    def Audio.open_file( filename , ext )
      fns = f = data = nil
      begin
        fns = filename + ext
        f = File.open(fns,"rb")
        data = f.read(32)
        f.close
        f = nil
      rescue Exception => errs
        return ""
      ensure
        f.close unless f.closed? if f
        f = nil
      end
      data
    end
    # -------------------------------------------------------------------------
    # ● ヘッダの参照
    # -------------------------------------------------------------------------
    def Audio.rtp_open_file_bgm( filename )
      for key in @audio_bgm.keys
        if key.match(/#{filename}$/)
          ext = @audio_bgm[key]
#~           p "rtp_open_file_bgm ext = #{ext}" # 拡張子
#~           p "rtp_open_file_bgm key = #{key}" # ファイルのパス
          return key + ext if self.check( self.open_file( key , ext ))
        end
      end
      return ""
    end
    # -------------------------------------------------------------------------
    # ● ヘッダの参照
    # -------------------------------------------------------------------------
    def Audio.rtp_open_file_bgs( filename )
      for key in @audio_bgs.keys
        if key.match(/#{filename}$/)
          ext = @audio_bgs[key]
          return key + ext if self.check( self.open_file( key , ext ))
        end
      end
      return ""
    end
    # -------------------------------------------------------------------------
    # ● ヘッダの参照
    # -------------------------------------------------------------------------
#~     def Audio.rtp_open_file_me( filename )
#~       for key in @audio_me.keys
#~         if key.match(/#{filename}$/)
#~           ext = @audio_me[key]
#~           return key + ext if self.check( self.open_file( key , ext ))
#~         end
#~       end
#~       return ""
#~     end
    # -------------------------------------------------------------------------
    # ● ヘッダの参照
    # -------------------------------------------------------------------------
    def Audio.check( data )
      return false unless @audio__init
      unless rpgvxace?
        if data[0] == 0x4f and data[1] == 0x67 and
           data[2] == 0x67 and data[3] == 0x53
          return true
        end
      else
        if data[0] == 'O' and data[1] == 'g' and
           data[2] == 'g' and data[3] == 'S'
          return true
        end
      end
      false  # other
    end
    #--------------------------------------------------------------------------
    # ● すべての音を止める
    #--------------------------------------------------------------------------
    def Audio.all_noteoff
      # p "※Audio_EX2 Audio.all_noteoff start" # add zorome
      bgm_stop 
      bgs_stop
      me_stop
      se_stop
      voice_stop
    end
    #--------------------------------------------------------------------------
    # ● セカンダリBGM の演奏を開始します
    #--------------------------------------------------------------------------
    def Audio.second_play( filename, volume = 100, pitch = 100 ,
                           balance = 50, pos = 0)
      # p "※Audio_EX2 Audio.second_play start" # add zorome
      init_check
      if WFRGSS_AudioEX::USE_PACKFILE
        filenames = filename.sub(WFRGSS_AudioEX::REMOVE_BGM_PATH){ "" }
        __original_bgm_stop__
        r = @audio_plays_m.call(String.utf82ansi(filenames + '.ogg'),
                           WFRGSS_AudioEX::BGM_PACKFILE,
                           volume,pitch,balance,[pos].pack("q"))
       return if r.zero?
      end
      ext = @audio_bgm[ filename ]
      ext = "" if ext.nil?
      if self.check( self.open_file(filename,ext) )
        __original_bgm_stop__
        @audio_plays.call(String.utf82ansi('./' + filename + '.ogg'),
                          volume,pitch,balance,[pos].pack("q"))
      elsif not (path = self.rtp_open_file_bgm( filename )).empty?
        __original_bgm_stop__
        @audio_plays.call(String.utf82ansi(path),volume,pitch,balance,
                          [pos].pack("q"))
      end
    end
    #--------------------------------------------------------------------------
    # ● セカンダリBGMのバランス
    #--------------------------------------------------------------------------
    def Audio.balance( balance = 50 )
      @audio_balance.call(balance) if init_check
    end
    #--------------------------------------------------------------------------
    # ● セカンダリBGMの停止
    #--------------------------------------------------------------------------
    def Audio.second_stop
      @audio_stopsecond.call() if init_check
    end
    #--------------------------------------------------------------------------
    # ● BGMの予約
    #--------------------------------------------------------------------------
    def Audio.bgm_reserve(filename, checkpoint, autoplay = false,
                          volume = 100, pitch = 100, pos = 0)
      # p "※Audio_EX2 Audio.bgm_reserve start" # add zorome
      init_check
      if WFRGSS_AudioEX::USE_PACKFILE
        filenames = filename.sub(WFRGSS_AudioEX::REMOVE_BGM_PATH){ "" }
        r = @audio_pbgm_reserve_m.call(String.utf82ansi(filenames + '.ogg'),
                           WFRGSS_AudioEX::BGM_PACKFILE,
                           volume,pitch,pos,checkpoint,autoplay ? 1 : 0)
        return if r.zero?
      end
      ext = @audio_bgm[ filename ]
      ext = "" if ext.nil?
      if self.check( self.open_file(filename,ext) )
        @audio_pbgm_reserve.call(String.utf82ansi('./' + filename + '.ogg'),
                         volume,pitch,pos,checkpoint,autoplay ? 1 : 0)
      elsif not (path = self.rtp_open_file_bgm( filename )).empty?
        @audio_pbgm_reserve.call(String.utf82ansi(path),volume,pitch,
                                 pos,checkpoint,autoplay ? 1 : 0)
      end
    end # def
    #--------------------------------------------------------------------------
    # ● BGM の演奏を開始します
    #--------------------------------------------------------------------------
    alias :__original_bgm_play__ :bgm_play
    def Audio.bgm_play(filename, volume = 100, pitch = 100, pos = 0)
#~       p "※Audio_EX2 Audio.bgm_play start" # add zorome
      begin
        @audio_tbgm.kill if @audio_tbgm
      rescue
        nil
      ensure
        @audio_tbgm = nil
      end
      _bgm_play(filename, volume, pitch, pos)
#~       p "※Audio_EX2 bgm_play filename = #{filename}"
      # p "pos = #{pos}"
#~       p "@audio_bgm = #{@audio_bgm}"
#~       p "@audio_tbgm = #{@audio_tbgm}"
      # p "※Audio_EX2 volume = #{volume}"
#~       p "※Audio_EX2 Audio.bgm_play end" # add zorome
    end # def
    
    private(:__original_bgm_play__)
    def Audio._bgm_play(filename, volume = 100, pitch = 100, pos = 0)
      init_check
      if WFRGSS_AudioEX::USE_PACKFILE
        filenames = filename.sub(WFRGSS_AudioEX::REMOVE_BGM_PATH){ "" }
        # p "filename = #{filename}"
#~         p "filenames = #{filenames}"
        puts filenames + '.ogg'
        puts WFRGSS_AudioEX::BGM_PACKFILE,
            #                    volume,pitch,[pos].pack("q")
        # r = @audio_play_m.call(String.utf82ansi(filenames + '.ogg'),
        #                    WFRGSS_AudioEX::BGM_PACKFILE,
        #                    volume,pitch,[pos].pack("q"))
        r = 0
        # if r.zero?
        #   # p "ファイルなし1 RTP以外 くさい"
        #   __original_bgm_stop__
        #   return
        # end
      end
      # たぶんＲＴＰ
      ext = @audio_bgm[ filename ]
      ext = "" if ext.nil?
#~       p "ext = #{ext}"
      if self.check( self.open_file(filename,ext) )
#~         p "※※Audio_EX2 filename = #{filename}"
        __original_bgm_stop__
        @audio_play.call(String.utf82ansi('./' + filename + '.ogg'),
                         volume,pitch,[pos].pack("q"))
        # 従来の再生
        # __original_bgm_play__(filename, volume, pitch, pos)
      elsif not (path = self.rtp_open_file_bgm( filename )).empty?
#~         p "ファイルなしじゃない？"
#~         p "path = #{path}"
         __original_bgm_stop__
        @audio_play.call(String.utf82ansi(path),volume,pitch,[pos].pack("q"))
        # 従来の再生
        # __original_bgm_play__(filename, volume, pitch, pos)
      else
        puts "ggg"
        # @audio_stop.call() if init_check
        # if pos > 0
        #   # p "再生開始 1"
        #   __original_bgm_play__(filename, volume, pitch, pos)
        # else
        #   # p "再生開始 2"
        #   __original_bgm_play__(filename, volume, pitch)
        # end
      end
    end # def
    private(:_bgm_play)
    #--------------------------------------------------------------------------
    # ● BGM の演奏を停止します。
    #--------------------------------------------------------------------------
    alias :__original_bgm_stop__ :bgm_stop
    def Audio.bgm_stop
#~       p "※Audio_EX2 Audio.bgm_stop start" # add zorome
      @audio_stopb.call() if init_check
      __original_bgm_stop__
#~       p "※Audio_EX2 Audio.bgm_stop end" # add zorome
    end
    private(:__original_bgm_stop__)
    #--------------------------------------------------------------------------
    # ● BGS の演奏を開始します
    #--------------------------------------------------------------------------
    alias :__original_bgs_play__ :bgs_play
    def Audio.bgs_play(filename, volume = 100, pitch = 100, pos = 0)
      begin
        @audio_tbgs.kill if @audio_tbgs
      rescue
        nil
      ensure
        @audio_tbgs = nil
      end
      _bgs_play(filename, volume, pitch, pos)
    end
    private(:__original_bgs_play__)
    def Audio._bgs_play(filename, volume = 100, pitch = 100 , pos = 0)
      init_check
      if WFRGSS_AudioEX::USE_PACKFILE
        filenames = filename.sub(WFRGSS_AudioEX::REMOVE_BGS_PATH){ "" }
        r = @audio_bgsplay_m.call(String.utf82ansi(filenames + '.ogg'),
                               WFRGSS_AudioEX::BGS_PACKFILE,
                               volume,pitch, [pos].pack("q"))
        if r.zero?
          __original_bgs_stop__
          return
        end
      end
      ext = @audio_bgs[ filename ]
      ext = "" if ext.nil?
      if self.check( self.open_file(filename,ext) )
        __original_bgs_stop__
        @audio_bgsplay.call(String.utf82ansi('./' + filename + '.ogg'),
                            volume,pitch,[pos].pack("q"))
      elsif not (path = self.rtp_open_file_bgs( filename )).empty?
        __original_bgs_stop__
        @audio_bgsplay.call(String.utf82ansi(path),volume,pitch,[pos].pack("q"))
      else
        @audio_stopbgs.call() if init_check
        if pos > 0
          __original_bgs_play__(filename, volume, pitch, pos)
        else
          __original_bgs_play__(filename, volume, pitch)
        end
      end
    end
    private(:_bgs_play)
    #--------------------------------------------------------------------------
    # ● BGS の演奏を停止します。
    #--------------------------------------------------------------------------
    alias :__original_bgs_stop__ :bgs_stop
    def Audio.bgs_stop
      @audio_stopbgs.call() if init_check
      __original_bgs_stop__
    end
    private(:__original_bgs_stop__)
    #--------------------------------------------------------------------------
    # ● ME の演奏を開始します。
    #--------------------------------------------------------------------------
#~     alias :__original_me_play__ :me_play
#~     def Audio.me_play(filename, volume = 100, pitch = 100)
#~       p "※Audio_EX2 Audio.me_play start" # add zorome
#~       # init_check
#~       temp_chk = init_check
#~       p "temp_chk = #{temp_chk}"
#~       if WFRGSS_AudioEX::USE_PACKFILE
#~         filenames = filename.sub(WFRGSS_AudioEX::REMOVE_ME_PATH){ "" }
#~         r = @audio_meplay_m.call(String.utf82ansi(filenames + '.ogg'),
#~                             WFRGSS_AudioEX::ME_PACKFILE,
#~                             volume,pitch)
#~         if r.zero?
#~           p "ME ファイルなし1？"
#~           __original_me_stop__
#~           return
#~         end
#~       end
      # p "@audio_me = #{@audio_me}"
#~       p "@audio_t = #{@audio_t}"
#~       ext = @audio_me[ filename ]
#~       ext = "" if ext.nil?
#~       if self.check( self.open_file(filename,ext) )
#~         __original_me_stop__
#~         @audio_meplay.call(String.utf82ansi('./' + filename + '.ogg'),volume,pitch)
#~       elsif not (path = self.rtp_open_file_me( filename )).empty?
#~         __original_me_stop__
#~         @audio_meplay.call(String.utf82ansi(path),volume,pitch)
#~       else
#~         @audio_stopme.call() if init_check
#~         me_sleep( filename )
#~         __original_me_play__(filename, volume, pitch)
#~       end
#~       p "※Audio_EX2 Audio.me_play end" # add zorome
#~     end # def
#~     private(:__original_me_play__)
    
    #--------------------------------------------------------------------------
    # ● ME の演奏を開始します。add zorome
    #    古いのを呼び出してみる
    #--------------------------------------------------------------------------
#~     def Audio.me_play_old(filename, volume = 100, pitch = 100)
#~       __original_me_play__(filename, volume, pitch)
#~     end # def
    #--------------------------------------------------------------------------
    # ● ME の演奏を停止します。
    #--------------------------------------------------------------------------
#~     alias :__original_me_stop__ :me_stop
#~     def Audio.me_stop
#~       p "※Audio_EX2 Audio.me_stop start" # add zorome
#~       # init_check
#~       temp_chk = init_check
#~       p "temp_chk = #{temp_chk}"
#~       @audio_stopme.call()
#~       __original_me_stop__
#~       if @audio_t
#~         @audio_t.kill rescue nil
#~         @audio_t = nil
#~         Audio.resume
#~       end
#~       p "※Audio_EX2 Audio.me_stop end" # add zorome
#~     end  # def
#~     private(:__original_me_stop__)
    #--------------------------------------------------------------------------
    # ● SE の演奏を開始します。
    #--------------------------------------------------------------------------
    alias :__original_se_play__ :se_play
    def Audio.se_play(filename, volume = 80, pitch = 100)
      # p "Audio.se_play"
      init_check
      if WFRGSS_AudioEX::USE_PACKFILE
        filenames = filename.sub(WFRGSS_AudioEX::REMOVE_SE_PATH){ "" }
        r = @audio_seplay_m.call(String.utf82ansi(filenames + '.ogg'),
                            WFRGSS_AudioEX::SE_PACKFILE,
                            volume,pitch)
        # return if r >= 0
        return r=0
      end
      # p "Audio.se_play2"
      # p "filename = #{filename}"
      __original_se_play__(filename, volume, pitch)
      # p "Audio.se_play3"
    end
    #--------------------------------------------------------------------------
    # ● ボイス の演奏を開始します。
    #--------------------------------------------------------------------------
    def Audio.voice_play(filename, volume = 80, pitch = 100, number = -1)
      init_check
      if WFRGSS_AudioEX::USE_PACKFILE
        filenames = filename.sub(WFRGSS_AudioEX::REMOVE_SE_PATH){ "" }
        r = @audio_vcplay_m.call(String.utf82ansi(filenames + '.ogg'),
                            WFRGSS_AudioEX::SE_PACKFILE,
                            volume,pitch,number)
        return if r >= 0
      end
      @audio_vcplay.call(String.utf82ansi(filename + '.ogg'),volume,pitch,number)
    end
    private(:__original_se_play__)
    #--------------------------------------------------------------------------
    # ● SE の演奏を停止します。
    #--------------------------------------------------------------------------
    alias :__original_se_stop__ :se_stop
    def Audio.se_stop
      @audio_stopse.call() if init_check
      __original_se_stop__
    end
    private(:__original_se_stop__)
    #--------------------------------------------------------------------------
    # ● ボイス の演奏を停止します。
    #--------------------------------------------------------------------------
    def Audio.voice_stop
      @audio_stopvc.call() if init_check
    end
    #--------------------------------------------------------------------------
    # ● BGMのフェードアウト
    #--------------------------------------------------------------------------
    alias :__original_bgm_fade__ :bgm_fade
    def Audio.bgm_fade( fadetime )
#~       p "※Audio_EX2 Audio.bgm_fade start" # add zorome
      __original_bgm_fade__(fadetime) 
      @audio_bgmfade.call(fadetime) if init_check
    end
    private(:__original_bgm_fade__)
    #--------------------------------------------------------------------------
    # ● BGSのフェードアウト
    #--------------------------------------------------------------------------
    alias :__original_bgs_fade__ :bgs_fade
    def Audio.bgs_fade( fadetime )
      __original_bgs_fade__(fadetime) 
      @audio_bgsfade.call(fadetime) if init_check
    end
    private(:__original_bgs_fade__)
    #--------------------------------------------------------------------------
    # ● MEのフェードアウト
    #--------------------------------------------------------------------------
#~     alias :__original_me_fade__ :me_fade
#~     def Audio.me_fade( fadetime )
#~       __original_me_fade__(fadetime) 
#~       @audio_mefade.call(fadetime) if init_check
#~     end
#~     private(:__original_me_fade__)
    private
    #--------------------------------------------------------------------------
    # ● MEの長さを取得して一時停止する
    #--------------------------------------------------------------------------
#~     def Audio.me_sleep( filename )
#~       ext = ""
#~       filenames = ""
#~       for key in @audio_me.keys
#~         if key.match(/#{filename}$/)
#~           ext = @audio_me[key]
#~           filenames = key
#~           break
#~         end
#~       end
#~       case ext
#~       when ".mid"
#~         open = "Open \"#{filenames}#{ext}\" alias soundlength type sequencer"
#~         @audio_mci.call(open, "", 0, 0)
#~         
#~         set = "Set soundlength time format milliseconds"
#~         @audio_mci.call(set, "" , 0, 0)
#~       when ".wav"
#~         open = "Open \"#{filenames}#{ext}\" alias soundlength type waveaudio"
#~         @audio_mci.call(open, "", 0, 0)
#~       when ".mp3"
#~         open = "Open \"#{filenames}#{ext}\" alias soundlength type MPEGVideo"
#~         @audio_mci.call(open, "", 0, 0)
#~       else
#~         return
#~       end
#~       ret = "\x00" * 255
#~       @audio_mci.call("status soundlength length", ret, 255, 0)
#~       @audio_mci.call("close soundlength", "", 0, 0)
#~       ret.tr!("\x00","")
#~       msec = ret.to_i
#~       sec = msec.to_f / 1000.0
#~       @audio_t.kill if @audio_t
#~       @audio_t = Thread.new do
#~         Audio.pause
#~         Thread.pass
#~         sleep(sec)
#~         Audio.resume
#~         @audio_t = nil
#~       end
#~     end
    #--------------------------------------------------------------------------
    # ● 
    #--------------------------------------------------------------------------
    def Audio.init_check
      return true
      # if @audio__init
      raise "Initialization is required, has not been initialized."
    end
  end
end

Audio.get

unless rpgvxace?
  class RPG::BGM < RPG::AudioFile
    @@last = RPG::BGM.new
    def play(pos = 0)
      # p "※Audio_EX2 RPG::BGM play" # add zorome
      if @name.empty?
        Audio.bgm_stop
        @@last = RPG::BGM.new
      else
        Audio.bgm_play('Audio/BGM/' + @name, @volume, @pitch, pos)
        @@last = self.clone
      end
    end
    def replay
      play(@pos)
    end
    def self.stop
      Audio.bgm_stop
      @@last = RPG::BGM.new
    end
    def self.fade(time)
      Audio.bgm_fade(time)
      @@last = RPG::BGM.new
    end
    def self.last
      @@last.pos = Audio.bgm_pos
      @@last
    end
    attr_accessor :pos
  end
  class RPG::BGS < RPG::AudioFile
    @@last = RPG::BGS.new
    def play(pos = 0)
      if @name.empty?
        Audio.bgs_stop
        @@last = RPG::BGS.new
      else
        Audio.bgs_play('Audio/BGS/' + @name, @volume, @pitch, pos)
        @@last = self.clone
      end
    end
    def replay
      play(@pos)
    end
    def self.stop
      Audio.bgs_stop
      @@last = RPG::BGS.new
    end
    def self.fade(time)
      Audio.bgs_fade(time)
      @@last = RPG::BGS.new
    end
    def self.last
      @@last.pos = Audio.bgs_pos
      @@last
    end
    attr_accessor :pos
  end
end

class RPG::SBGM < RPG::AudioFile
  @@last = RPG::SBGM.new
  @@balance = 50
  def play(balance = @@balance, pos = 0)
    # p "※Audio_EX2 RPG::SBGM play" # add zorome
    if @name.empty?
      Audio.second_stop
      @@last = RPG::BGM.new
    else
      Audio.second_play('Audio/BGM/' + @name, @volume, @pitch, balance, pos)
      @@last = self.clone
    end
  end
  def replay(balance = @@balance)
    play(balance ,@pos)
  end
  def self.stop
    Audio.second_stop
    @@last = RPG::SBGM.new
  end
  def self.fade(time)
    Audio.bgm_fade(time)
    @@last = RPG::SBGM.new
  end
  def self.balance( balance )
    @@balance = balance
    Audio.balance(@@balance)
  end
  def self.last
    @@last.pos = Audio.is_secondry_bgm_position
    @@last
  end
  attr_accessor :pos
end

# バトルBGMの途中再生を行うか？
if WFRGSS_AudioEX::BATTLE_DURING_PLAYBACK

unless rpgvx?
  class Game_System
    #--------------------------------------------------------------------------
    # ● BGM の演奏
    #     bgm : 演奏する BGM
    #--------------------------------------------------------------------------
    def bgm_play(bgm)
      @playing_bgm = bgm
      if bgm && !bgm.name.empty?
        playbgm = RPG::BGM.new(bgm.name, bgm.volume, bgm.pitch)
        playbgm.play
      else
        RPG::BGM.stop
      end
      Graphics.frame_reset
    end
    #--------------------------------------------------------------------------
    # ● BGM の停止
    #--------------------------------------------------------------------------
    def bgm_stop
      RPG::BGM.stop
    end
    #--------------------------------------------------------------------------
    # ● BGM のフェードアウト
    #     time : フェードアウト時間 (秒)
    #--------------------------------------------------------------------------
    def bgm_fade(time)
      @playing_bgm = nil
      RPG::BGM.fade(time * 1000)
    end
    #--------------------------------------------------------------------------
    # ● BGM の記憶
    #--------------------------------------------------------------------------
    def bgm_memorize
      @memorized_bgm = RPG::BGM.last
    end
    #--------------------------------------------------------------------------
    # ● BGM の復帰
    #--------------------------------------------------------------------------
    def bgm_restore
      @memorized_bgm.replay
    end
    #--------------------------------------------------------------------------
    # ● BGS の演奏
    #     bgs : 演奏する BGS
    #--------------------------------------------------------------------------
    def bgs_play(bgs)
      if bgs && !bgs.name.empty?
        playbgs = RPG::BGS.new(bgs.name, bgs.volume, bgs.pitch)
        playbgs.play
      else
        RPG::BGS.stop
      end
      Graphics.frame_reset
    end
    #--------------------------------------------------------------------------
    # ● BGS のフェードアウト
    #     time : フェードアウト時間 (秒)
    #--------------------------------------------------------------------------
    def bgs_fade(time)
       RPG::BGS.fade(time * 1000)
    end
    #--------------------------------------------------------------------------
    # ● BGS の記憶
    #--------------------------------------------------------------------------
    def bgs_memorize
      @memorized_bgs = RPG::BGS.last
    end
    #--------------------------------------------------------------------------
    # ● BGS の復帰
    #--------------------------------------------------------------------------
    def bgs_restore
      @memorized_bgs.replay
    end
    #--------------------------------------------------------------------------
    # ● 演奏中 BGM の取得
    #--------------------------------------------------------------------------
    def playing_bgm
      RPG::BGM.last
    end
    #--------------------------------------------------------------------------
    # ● 演奏中 BGS の取得
    #--------------------------------------------------------------------------
    def playing_bgs
      RPG::BGS.last
    end
    #--------------------------------------------------------------------------
    # ● BGM と BGS の保存
    #--------------------------------------------------------------------------
    def save_bgm_and_bgs
      @map_bgm = RPG::BGM.last
      @map_bgs = RPG::BGS.last
    end
    #--------------------------------------------------------------------------
    # ● BGM と BGS の再開
    #--------------------------------------------------------------------------
    def replay_bgm_and_bgs
      # p "※Audio_EX2 replay_bgm_and_bgs"
      @map_bgm.replay
      @map_bgs.replay
    end
  end

  class Scene_Map
    #--------------------------------------------------------------------------
    # ● バトルの呼び出し
    #--------------------------------------------------------------------------
    def call_battle
      $game_temp.battle_calling = false
      $game_temp.menu_calling = false
      $game_temp.menu_beep = false
      $game_player.make_encounter_count
      $game_temp.map_bgm = $game_system.playing_bgm
      unless $game_switches[WFRGSS_AudioEX::REPEAT_BATTLE_FLAG]
        $game_system.save_bgm_and_bgs
        $game_system.bgm_stop
        $game_system.se_play($data_system.battle_start_se)
        $game_system.bgm_play($game_system.battle_bgm)
      else
        $game_system.se_play($data_system.battle_start_se)
      end
      $game_player.straighten
      $scene = Scene_Battle.new
    end
  end
  class Scene_Battle
    #--------------------------------------------------------------------------
    # ● フレーム更新 (パーティコマンドフェーズ : 逃げる)
    #--------------------------------------------------------------------------
    def update_phase2_escape
      enemies_agi = 0
      enemies_number = 0
      for enemy in $game_troop.enemies
        if enemy.exist?
          enemies_agi += enemy.agi
          enemies_number += 1
        end
      end
      enemies_agi /= enemies_number if enemies_number > 0
      actors_agi = 0
      actors_number = 0
      for actor in $game_party.actors
        if actor.exist?
          actors_agi += actor.agi
          actors_number += 1
        end
      end
      actors_agi /= actors_number if actors_number > 0
      success = rand(100) < 50 * actors_agi / enemies_agi
      if success
        $game_system.se_play($data_system.escape_se)
        unless $game_switches[WFRGSS_AudioEX::REPEAT_BATTLE_FLAG]
          $game_system.replay_bgm_and_bgs
        end
        battle_end(1)
      else
        $game_party.clear_actions
        start_phase4
      end
    end
    #--------------------------------------------------------------------------
    # ● アフターバトルフェーズ開始
    #--------------------------------------------------------------------------
    def start_phase5
      @phase = 5
      $game_system.me_play($game_system.battle_end_me)
      unless $game_switches[WFRGSS_AudioEX::REPEAT_BATTLE_FLAG]
        $game_system.replay_bgm_and_bgs
      end
      exp = 0
      gold = 0
      treasures = []
      for enemy in $game_troop.enemies
        unless enemy.hidden
          exp += enemy.exp
          gold += enemy.gold
          if rand(100) < enemy.treasure_prob
            if enemy.item_id > 0
              treasures.push($data_items[enemy.item_id])
            end
            if enemy.weapon_id > 0
              treasures.push($data_weapons[enemy.weapon_id])
            end
            if enemy.armor_id > 0
              treasures.push($data_armors[enemy.armor_id])
            end
          end
        end
      end
      treasures = treasures[0..5]
      for i in 0...$game_party.actors.size
        actor = $game_party.actors[i]
        if actor.cant_get_exp? == false
          last_level = actor.level
          actor.exp += exp
          if actor.level > last_level
            @status_window.level_up(i)
          end
        end
      end
      $game_party.gain_gold(gold)
      for item in treasures
        case item
        when RPG::Item
          $game_party.gain_item(item.id, 1)
        when RPG::Weapon
          $game_party.gain_weapon(item.id, 1)
        when RPG::Armor
          $game_party.gain_armor(item.id, 1)
        end
      end
      @result_window = Window_BattleResult.new(exp, gold, treasures)
      @phase5_wait_count = 100
    end
  end
else
  unless rpgvxace?
    class Game_System
      #------------------------------------------------------------------------
      # ● BGM と BGS の保存
      #------------------------------------------------------------------------
      def save_bgm_and_bgs
        # p "※Audio_EX2 save_bgm_and_bgs"
        @map_bgm = RPG::BGM.last
        @map_bgs = RPG::BGS.last
      end
      #------------------------------------------------------------------------
      # ● BGM と BGS の再開
      #------------------------------------------------------------------------
      def replay_bgm_and_bgs
        @map_bgm.replay
        @map_bgs.replay
      end
    end
    class Scene_Map < Scene_Base
      #------------------------------------------------------------------------
      # ● バトル画面への切り替え
      #------------------------------------------------------------------------
      def call_battle
        @spriteset.update
        Graphics.update
        $game_player.make_encounter_count
        $game_player.straighten
        $game_system.save_bgm_and_bgs
        unless $game_switches[WFRGSS_AudioEX::REPEAT_BATTLE_FLAG]
          RPG::BGM.stop
          RPG::BGS.stop
          Sound.play_battle_start
          $game_system.battle_bgm.play
        else
          Sound.play_battle_start
        end
        $game_temp.next_scene = nil
        $scene = Scene_Battle.new
      end
    end
    class Scene_Battle < Scene_Base
      #------------------------------------------------------------------------
      # ● 勝利の処理
      #------------------------------------------------------------------------
      def process_victory
        @info_viewport.visible = false
        @message_window.visible = true
        unless $game_switches[WFRGSS_AudioEX::REPEAT_BATTLE_FLAG]
          RPG::BGM.stop
          $game_system.battle_end_me.play
          $game_system.replay_bgm_and_bgs unless $BTEST
        else
          $game_system.battle_end_me.play
        end
        display_exp_and_gold
        display_drop_items
        display_level_up
        battle_end(0)
      end
      #------------------------------------------------------------------------
      # ● 戦闘終了
      #     result : 結果 (0:勝利 1:逃走 2:敗北)
      #------------------------------------------------------------------------
      def battle_end(result)
        # p "※Audio_EX2 battle_end"
        if result == 2 and not $game_troop.can_lose
          call_gameover
        else
          $game_party.clear_actions
          $game_party.remove_states_battle
          $game_troop.clear
          if $game_temp.battle_proc != nil
            $game_temp.battle_proc.call(result)
            $game_temp.battle_proc = nil
          end
          unless $game_switches[WFRGSS_AudioEX::REPEAT_BATTLE_FLAG]
            $game_system.replay_bgm_and_bgs unless result.zero? unless $BTEST
          end
          $scene = Scene_Map.new
          @message_window.clear
          Graphics.fadeout(30)
        end
        $game_temp.in_battle = false
      end
    end
  end
end

end

#~ if rpgvxace?
#~   alias __wfrgss_audioex_rgss_main__ rgss_main
#~   def rgss_main(&block)
#~     Audio.ogg_init
#~     __wfrgss_audioex_rgss_main__(&block)
#~   ensure
#~     Audio.dispose
#~   end
#~ end

# =end
