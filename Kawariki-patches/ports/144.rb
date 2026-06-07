# coding: utf-8
# ===========================================================================
# ★ WF-RGSS Scripts ★
#    共通実行スクリプト(XP/VX/VXAce両対応版)
# バージョン   ： rev-29 (2013-3-26)
# 作者         ： A Crying Minister (WHITE-FLUTE)
# サポート先URI： http://www.whiteflute.org/wfrgss/
# ---------------------------------------------------------------------------
# 機能：
# ・デバッグモードで例外が発生したとき、エラーを errors.txt に記録します。
# ・高速なリセットを利用できるようになります。
# ---------------------------------------------------------------------------
# 影響：
# ・ファイルが見つからない例外は、 元の Errno::ENOENT が補足されます。
# ---------------------------------------------------------------------------
# 設置場所     ：Mainセクション(一番最後)に上書き
#                または、Mainセクションの直前
# 必要スクリプト：
# ・共通スクリプト
# 注意事項：
# ▽ 共通スクリプトが必要です。
#    改造して使用することを推奨しますが、そのまま使ってもOKです。
# ▽ デバッグモードでエラーを記録する場合、
#    現在のユーザで書き込みを行えることが必要になります。
#==============================================================================
# ◆ Main ( Execute )
#------------------------------------------------------------------------------
# 　各クラスの定義が終わった後、ここから実際の処理が始まります。
#==============================================================================

# ---------------------------------------------------------------------------
# ◆ 処理実行
# ---------------------------------------------------------------------------
# スレッド例外で即座に中断しないようにする。(デバッグ時は無効)
# ※ true に設定する場合はご注意ください。
#    終了する前に解放が必要なものもあります。
# Minimal SceneManager shim to avoid NameError when the real SceneManager is missing
unless defined?(SceneManager)
  module SceneManager
    class << self
      # Run a simple loop compatible with typical RGSS main loops
      def run
        # If $scene is already used by other scripts, prefer that loop
        if defined?($scene) && $scene
          $scene.main until $scene.nil?
          return
        end

        # Fallback: try to create Scene_Title if available
        if defined?(Scene_Title)
          $scene = Scene_Title.new
          $scene.main until $scene.nil?
          return
        end

        # Last resort: raise a clear error so you can see what's missing
        raise NameError, "SceneManager not implemented and no Scene_Title/$scene available"
      end
    end
  end
end

Thread.abort_on_exception = false
# RPGVX 互換
if rpgvx? and (not rpgvxace?)
  unless Font.exist?("UmePlus Gothic")
    print "UmePlus Gothic フォントが見つかりません。"
    exit
  end
end
begin
  unless rpgvxace?
    Graphics.freeze
    $scene = Scene_Title.new
    $scene.main until $scene.nil?
    Graphics.transition(20)
  else
    # Use rgss_main if available, otherwise fallback to direct run
    # Replace this:
    # if defined?(rgss_main) && rgss_main
    #   rgss_main { SceneManager.run }
    # else
    #   SceneManager.run
    # end

    # With this:
    if defined?(rgss_main)
      rgss_main { SceneManager.run }
    else
      SceneManager.run
    end

  end

rescue BugDetected, InternalBugDetected => errobj
  begin
    # sanitize message/backtrace to UTF-8 before showing
    safe_message = safe_to_utf8(errobj.message.to_s) rescue errobj.message.to_s
    safe_bt = ""
    if $@ && !$@.empty?
      $@.each { |line| safe_bt << (safe_to_utf8(line) rescue line.to_s) }
    end
    sanitized = StandardError.new(safe_message + (safe_bt.empty? ? "" : "\n** backtrace:\n" + safe_bt))
    MessageBox.fatalerror(sanitized)
    raise SystemExit.new(1)
  rescue Hangup
    nil
  end

rescue Reset
  raise

rescue Hangup => errobj
  begin
    MessageBox.fatalerror(errobj)
    raise SystemExit.new(1)
  rescue Hangup
    nil
  end

rescue SystemExit => errobj
  raise unless (errobj.status).zero?

rescue Exception => errobj
  begin
    MessageBox.fatalerror(errobj)
    raise SystemExit.new(1)
  rescue Hangup
    nil
  end

ensure
  unless $!.is_a?(Reset)
    # post-run cleanup here
  else
    $! = nil unless rpgvxace?
  end
end

