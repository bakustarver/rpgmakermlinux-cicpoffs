# ===========================================================================
# ★ WF-RGSS Scripts ★
#    共通スクリプト(XP/VX/VXAce両対応版)
# バージョン   ： rev-29 (2013-3-26)
# 作者         ： A Crying Minister (WHITE-FLUTE)
# サポート先URI： http://www.whiteflute.org/wfrgss/
# ---------------------------------------------------------------------------
# 機能：
# ・このセクションより後ろのスクリプトでSyntaxError が発生しても
#   別の例外にすりかえられるため、詳細情報が削除されなくなります。
#   (VXAceでは標準で削除されなくなりました。)
# ・SyntaxErrorの情報をファイルに書き出します。
# ・不用意なデバッグモードへの遷移を防止します。
#   (元からデバッグモードの場合は問題ありません。)
# ・不正なデバッグモードへの遷移を阻害します。
# ・デバッグコンソールを表示しデバッグしやすくします。
# ---------------------------------------------------------------------------
# 影響：
# ・外部コマンド実行など一部の組み込み関数が未定義になります。
# ・例外 SyntaxError は作成できません。(XP/VX)
#   (※ ScriptSyntaxError にすりかえられます。)
# ---------------------------------------------------------------------------
# 設置場所：一番最初のセクション(Game_Temp(XP)/モジュール(VX/VXAce)よりも前)
# 必要スクリプト：
# ・共通実行スクリプト(VXAce は、Exit-EXで置き換える事ができます。)
# 注意事項：
#   共通実行スクリプトをMainセクションに上書きして利用することを推奨します。
# ===========================================================================
BEGIN {

    module WFRGSS
# -------------------------------------------------------------------------
# ● 調整ポイント
# -------------------------------------------------------------------------
# デバッグモード遷移を阻害するかを設定します。
# 確実に保護できるわけではありませんので過信は禁物です。

DEBUG_CHECK = true

# -------------------------------------------------------------------------
# デバッグモード時、デバッグコンソールを表示します。
# (VXAceでは設定に関わらず標準装備されています。)

DEBUG_CONSOLE = false

# -------------------------------------------------------------------------
# リリースモード時、デバッグメッセージを消去します。

DELETE_DEBUG_MESSAGE = false

# -------------------------------------------------------------------------
# XPのみ。 デバッグフラグをVX/VXAce準拠に修正するか？
# （！）スクリプト対応が必要となります。

DEBUG_FLAG_CHANGE = false


# -------------------------------------------------------------------------
# 調整ポイント終わり
# -------------------------------------------------------------------------
end



# ---------------------------------------------------------------------------
# ● 例外定義
# ---------------------------------------------------------------------------

# 継承例外
class InheritanceError < Exception;end

# Mix-in 例外
class IncludeError < Exception;end

# 仮想クラス、メソッドの使用
class AbstractError < NotImplementedError;end

# ◆ バグ検出
#    バグ以外、絶対にありえない状態になったときに発生させてください。
# ※ バグ報告を行うためのものなので途中で破棄してはいけません。
class BugDetected < Exception;end

# ◆ 内部バグ報告用
# これは、WFRGSS でバグしかありえない状態に陥ったときに発生します。
# ※ バグ報告を行うためのものなので途中で破棄してはいけません。
class InternalBugDetected < BugDetected;end

# イベント階層が深すぎる場合
class EventDeepError < SystemStackError;end

# 初期化失敗
class InitializeError < TypeError;end

# アサーション失敗
class AssertionError < Exception;end

# ◆ 例外 Hangup
# ハングアップしたとみなされたときに投げられる例外。
# 深い階層からでは捉えられないことがあるため、注意が必要
# RPGVX/VXAceにはありませんが、XPとの互換性を保つため、設定しています。
class Hangup < Exception;end

# ◆ 例外 Reset
# Graphics.update の呼び出し時にF12が押されていると投げられる例外。(XP)
# F12 が押されていると投げられる例外(VX)
# これがセクション外に出ると
# 最初のセクションから再び実行をやり直そうとします。
# この操作は、組み込みクラスのメソッドにて、
# alias や undef が使われていると
# 不具合の元になります。
class Reset < Exception;end

# セキュリティ違反
class SecurityHazard < Exception;end

# RPGXP互換性のため
if WFRGSS::DEBUG_FLAG_CHANGE
$TEST = $DEBUG
$DEBUG = false
else
$TEST = false unless $TEST
end

module WFRGSS
@@debug = ($TEST or $DEBUG)
def self.check
debug = ($TEST or $DEBUG)
if debug != @@debug or (@@debug and
                        (FileTest.file?("Game.rgssad") or FileTest.file?("Game.rgss2a") or
                         FileTest.file?("Game.rgss3a")))
raise(SecurityHazard ,"Insecure - debug flag can't be change.")
end
end
end

# ---------------------------------------------------------------------------
# ◆◆ デバッグモード阻止対策
# ---------------------------------------------------------------------------
# デバッグモード防止策
if defined? untrace_var
undef untrace_var
# デバッグモードでない場合、デバッグモードへの遷移を禁止する
proc = Proc.new {
                 if $DEBUG
                $DEBUG = false
                $TEST = false
                $BTEST = false
                raise(SecurityHazard ,"Insecure - debug flag can't be change.", caller(1))
                end
                }
trace_var( :$DEBUG , proc )
trace_var( :$-d , proc )    # $DEBUG の別名
proc = nil

# デバッグモードでない場合、デバッグモードへの遷移を禁止する
proc = Proc.new {
                 if $TEST
                $DEBUG = false
                $TEST = false
                $BTEST = false
                raise(SecurityHazard ,"Insecure - debug flag can't be change.", caller(1))
                end
                }
trace_var( :$TEST , proc )  # RPGVX デバッグフラグ
proc = nil

# 戦闘テストで無い場合、戦闘テストへの遷移を禁止する
proc = Proc.new {
                 if $BTEST
                $DEBUG = false
                $TEST = false
                $BTEST = false
                raise(SecurityHazard ,"Insecure - battle test flag can't be change.",
                      caller(1))
                end
                }
trace_var( :$BTEST , proc )
proc = nil
end

unless defined? ScriptSyntaxError
# RGSSでは、本来持っているSyntaxErrorの詳細情報をすべて削除してしまい、
# デバッグが非常に困難になってしまいます。
# そのために用意されている例外です。
# ※特にイベントスクリプト上でSyntaxErrorを出すととても悲惨なことに…
#  「スクリプト実行中に SyntaxError が発生しました。」だけで
#   すぐに修正できるのでしょうか？
class ScriptSyntaxError < Exception;end
# -------------------------------------------------------------------------
# ◆ 組み込み例外クラス SyntaxError <obsolete>
# -------------------------------------------------------------------------
# RGSSでは、本来持っているSyntaxErrorの詳細情報をすべて削除してしまうため、
# SyntaxError のコンストラクタを乗っ取って別の例外にすりかえています。
# ※ SyntaxError のインスタンスは作成できません。
class SyntaxError < ScriptError
ERROR = Hash.new
end
class << SyntaxError
#--------------------------------------------------------------------------
# ◆ (！※継承禁止※！)
#--------------------------------------------------------------------------
def SyntaxError.inherited( subclass )
raise( InheritanceError ,
       "can't inherit class #{subclass} from #{self}" , caller(1) )
end
private_class_method(:inherited)
unless defined? BasicObject
undef allocate
undef new
#------------------------------------------------------------------------
# ◆ 強制的に別の例外にすりかえる
#------------------------------------------------------------------------
def new( errors , *args )
error_message = make_error_message(errors)
error_message_dump(error_message)
ScriptSyntaxError.new(error_message)
end
else
alias __wfrgss__new__ new unless $!
def new( errors , *args )
error_message = make_error_message(errors)
error_message_dump(error_message)
__wfrgss__new__(errors)
end
end
private
#----------------------------------------------------------------------------
# ◆(内部専用)◆ エラーメッセージ作成
#----------------------------------------------------------------------------
def make_error_message( error_message )
extra = ""
unless (error_message[/^(?:Section)?{?(\d+)}?:(\d+):/]).nil?
nums = $1.to_i     # セクションを拾い出した場合
extra = $RGSS_SCRIPTS.at(nums).at(1)
unless $2.nil?
lines = $2.to_i
unless ($RGSS_SCRIPTS.at(nums).at(3)).nil?
details = show_details_source_code( nums , lines )
unless details.empty?
error_message += "\n** script source code：\n#{details}"
else
error_message +=
"\n** script source code：#{lines} unknown data.\n"
end
end
end
end
error_message.gsub!(/^(?:Section)?{?(\d+)}?:/){"( #{extra} )：#{$1}：lines "}
error_message
end
#--------------------------------------------------------------------------
# ◆(内部専用)◆ 情報を書きこみ
#--------------------------------------------------------------------------
def error_message_dump(error_message)
e = Zlib::crc32(error_message)
return if SyntaxError::ERROR[e]
SyntaxError::ERROR[e] = true
File.open("syntaxerror.txt","a") do | file |
file.write("*SyntaxError - " +
           (Time.now).strftime("%Y-%m-%d %H:%M:%S (%A)") + "\n")
file.write( "#{error_message}\n" )
end
end
#--------------------------------------------------------------------------
# ◆(内部専用)◆ ソースコード位置読み込み
#--------------------------------------------------------------------------
def show_details_source_code( nums , lines )
details = ""
splitstr = ($RGSS_SCRIPTS.at(nums).at(3)).split(/\r\n/)
if lines < 4
ranges = ( 0...( lines + 3 ))
else
ranges = (( lines - 4 )...( lines + 3 ))
end
for i in ranges
unless (splitstr.at(i)).nil?
if i != (lines - 1)
details += "|" + splitstr.at(i) + "\n"
else
details += ">" + splitstr.at(i) + "\n"
end
else
details += "[End of File]\n"
break
end
end
splitstr = nil
rpgvxace? ? details.force_encoding("UTF-8") : details
end
end


# -------------------------------------------------------------------------
# ◆ RGSS 組み込みモジュール Graphics
# -------------------------------------------------------------------------

class << Graphics
#------------------------------------------------------------------------
# ◆ リセットを無視する Graphics.update
#------------------------------------------------------------------------
def Graphics.safe_update
begin
update
rescue Reset
# リセット操作を無視する。
# ただしカーソルアニメーションなどが巻き戻される。
nil
end
end

if WFRGSS::DEBUG_CHECK
#------------------------------------------------------------------------
# ◆ Graphics.update にチェックを加える
#------------------------------------------------------------------------
alias ___original__update___ update
def Graphics.update
WFRGSS.check
___original__update___
end
private(:___original__update___)
end
end

module Graphics
# -----------------------------------------------------------------------
# ◆ クラス変数
# -----------------------------------------------------------------------
@@rate = 0
@@count = 0
# -----------------------------------------------------------------------
# ◆ フレームレートを一時的に変更
# -----------------------------------------------------------------------
def self.frame_workset( frame_rates )
@@rate = Graphics.frame_rate
@@count = Graphics.frame_count
Graphics.frame_rate = frame_rates
end
# -----------------------------------------------------------------------
# ◆ フレームレートを元に戻す
# -----------------------------------------------------------------------
def self.frame_restore
cnt = Graphics.frame_count - @@count
cnt *= @@rate
cnt /= Graphics.frame_rate
Graphics.frame_count = @@count + cnt
Graphics.frame_rate = @@rate
end
# -----------------------------------------------------------------------
# ◆ 解像度横の幅(VX/VXAceでは無視される)
# -----------------------------------------------------------------------
unless defined? Graphics.width
def self.width
640
end
end
# -----------------------------------------------------------------------
# ◆ 解像度縦の幅(VX/VXAceでは無視される)
# -----------------------------------------------------------------------
unless defined? Graphics.height
def self.height
480
end
end
end
end

# ---------------------------------------------------------------------------
# ◆ 組み込みモジュール GC
# ---------------------------------------------------------------------------
module GC
module_function
#--------------------------------------------------------------------------
# ◆ 安全にガーベージコレクションを行う
#--------------------------------------------------------------------------
def update_start
Graphics.safe_update
start
Graphics.safe_update
end
end

}

unless defined? Abstract
    # -----------------------------------------------------------------------------
    # ◆◆ 組み込みクラス Class
    # -----------------------------------------------------------------------------
    class Class
        # ---------------------------------------------------------------------------
        # ◆ クラス変数
        # ---------------------------------------------------------------------------
        @@_abstract_class = Hash.new
        # ---------------------------------------------------------------------------
        # ◆ 抽象クラス追加
        # ---------------------------------------------------------------------------
        def self.abstract_class( klass )
            __failure_type_call__( klass ) unless klass.is_a?(Class)
            unless @@_abstract_class[klass.__id__]
                @@_abstract_class[klass.__id__] = klass
            end
        end
        # ---------------------------------------------------------------------------
        # ◆ 抽象クラス判定
        # ---------------------------------------------------------------------------
        def self.abstract?( klass )
            @@_abstract_class[klass.__id__]
        end
    end

    module Abstract
        # ---------------------------------------------------------------------------
        # ◆ 抽象化
        # ---------------------------------------------------------------------------
        def self.included( klass )
            if klass.include?(FinalClass)
                # FinalClass モジュールが既にインクルードされている
                raise( IncludeError ,
                       "can't include #{klass} from #{self}" , caller(1) )
            end
            Class.abstract_class( klass )
            klass.extend(Abstract_Class__)
        end
        private_class_method(:included)
    end

    # ---------------------------------------------------------------------------
    # ◆ 抽象化 ※ 特異メソッド専用 ※
    # ---------------------------------------------------------------------------
    module Abstract_Class__
        # -------------------------------------------------------------------------
        # ◆ ※ 抽象クラス
        # -------------------------------------------------------------------------
        def allocate
            return super unless Class.abstract?( self )
            raise( AbstractError ,
                   "class #{self} cannot use it because of the abstraction class.",
                   caller(1) )
        end
        # -------------------------------------------------------------------------
        # ◆ ※ 抽象クラス
        # -------------------------------------------------------------------------
        def new( *args )
            return super unless Class.abstract?( self )
            raise( AbstractError ,
                   "class #{self} cannot use it because of the abstraction class.",
                   caller(1) )
        end
        # -------------------------------------------------------------------------
        # ◆ ※ Mix-in 制限
        # -------------------------------------------------------------------------
        def self.included( klass )
            unless self.is_a?(Class)
                raise( IncludeError ,
                       "can't include #{klass} from #{self}" , caller(1) )
            end
        end
    end

    module FinalClass
        # ---------------------------------------------------------------------------
        # ◆ 継承できないクラス
        # ---------------------------------------------------------------------------
        def self.included( klass )
            if Class.abstract?( klass )
                # Abstract モジュールが既にインクルードされている
                raise( IncludeError ,
                       "can't include #{klass} from #{self}" , caller(1) )
            end
            klass.module_eval(<<-End)
            def self.inherited( subclass )
            raise( InheritanceError ,
            sprintf(\"can't inherit class %s from %s\",subclass.inspect,
            self.inspect ) , caller(1) )
            end
            private_class_method(:inherited)
            End
        end
        private_class_method(:included)
    end

    # ---------------------------------------------------------------------------
    # ◆ 組み込みモジュール Kernel
    # ---------------------------------------------------------------------------

    module Kernel
        # ---------------------------------------------------------------------------
        # ◆ 危険な関数を未定義に設定
        # ---------------------------------------------------------------------------
        # 外部コマンド読み込みなど危険な操作は明示的に禁止にします。
        # ※ これらのコマンドの必要性が(通常は)ないうえ、
        #    危険(システム破壊をもたらすことがある)なため取り外しています。
        # ※ もし、これらを使用する場合は、効果と危険性を考慮してください。
        # ---------------------------------------------------------------------------
        # 外部コマンドを実行する。
        undef `       #` # 外部コマンドを実行する。
        undef exec    # 外部コマンドを実行する 制御を返さない。
        undef fork    # サブシェルを生成する。
        undef system  # 外部コマンドを実行する。
        undef abort   # 後処理を行わずに強制終了する。後処理が必要な時に困る。
        undef exit!   # abort と同じ。
        undef open    # コマンドが実行できる。(ファイルを開くならIO.openを用いる)
        #--------------------------------------------------------------------------
        private
        #--------------------------------------------------------------------------
        # ◆ RPGVX/VXAce かどうか
        #--------------------------------------------------------------------------
        def rpgvx?
            defined? Graphics.resize_screen
        end
        #--------------------------------------------------------------------------
        # ◆ RPGVXAce かどうか
        #--------------------------------------------------------------------------
        def rpgvxace?
            defined? BasicObject
        end
        #--------------------------------------------------------------------------
        # ◆ RGSSのバージョン
        #--------------------------------------------------------------------------
        def rgss_version
            rpgvx? ? (rpgvxace? ? 3 : 2 ) : 1
        end
        #--------------------------------------------------------------------------
        # ◆ テストモードかどうか
        #--------------------------------------------------------------------------
        def debug?
            $DEBUG or $TEST
        end
        #--------------------------------------------------------------------------
        # ◆ デバッグコンソール
        #--------------------------------------------------------------------------
        if WFRGSS::DEBUG_CONSOLE and debug? and (not rpgvxace?)
            unless $@
                $VERBOSE = true
                alias wfrgss_p p
                Win32API.new("kernel32","AllocConsole",'v','l').call
                $stdout.reopen("conout$","w")
                def p(*a)
                    a.each{|v|$stdout.puts(String.utf82ansi(v.inspect))}
                end
            end
        elsif WFRGSS::DELETE_DEBUG_MESSAGE
            unless $@
                alias display_p p
                def p(*a)
                    # 何も出力しない
                end
            end
        end
        #--------------------------------------------------------------------------
        # ◆ 例外セット
        #    例外を発生させます。
        #--------------------------------------------------------------------------
        # ◆ method_missing と同様
        #--------------------------------------------------------------------------
        def __failure_method_call__( method_name , *args )
            raise( NoMethodError ,
                   "undefined method `#{method_name}' for #{self}" , caller(2) )
        end
        #--------------------------------------------------------------------------
        # ◆ オーバーライドが必要
        #--------------------------------------------------------------------------
        def __override_required_call__( method_name , *args )
            raise( AbstractError ,
                   "It is necessary to do override to use method `#{method_name}'" +
                 " of this class #{self}. " +
                 "(or, it tried to call the method of a super-class.)" , caller(2))
        end
        #--------------------------------------------------------------------------
        # ◆ 例外 TypeErrorを発生させる
        #--------------------------------------------------------------------------
        def __failure_type_call__( object_type )
            e = ( object_type.class ).to_s
            raise( TypeError , "no implicit conversion from #{e}" , caller(2) )
        end
        #--------------------------------------------------------------------------
        # ◆ 例外 RangeErrorを発生させる ( num が Numeric でない場合はBugDetected )
        #--------------------------------------------------------------------------
        def __outof_range_call__( num , str , call_value = 2 )
            if num.is_a?(Numeric)
                if str.is_a?(String)
                    raise( RangeError , "#{num} out of range of #{str}",caller(call_value))
                else
                    e = ( str.class ).to_s
                    raise(TypeError,"no implicit conversion from #{e}",caller(call_value))
                end
            else
                e = ( num.class ).to_s
                raise( BugDetected, "[BUG] no implicit conversion from #{e} (TypeError)",
                       caller(1))
            end
        end
        #--------------------------------------------------------------------------
        # ◆ 例外 ArgumentErrorを発生させる ( str が String でない場合はBugDetected )
        #--------------------------------------------------------------------------
        def __invalid_value_call__( str , value , call_value = 2 )
            if str.is_a?(String)
                raise( ArgumentError , "invalid #{str} for #{value.to_s}")
            else
                e = ( str.class ).to_s
                raise( BugDetected, "[BUG] no implicit conversion from #{e} (TypeError)",
                       caller(1))
            end
        end
        #--------------------------------------------------------------------------
        # ◆ 例外 SecurityErrorを発生させる ( str が String でない場合はBugDetected )
        #--------------------------------------------------------------------------
        def __insecure_call__( str )
            if str.is_a?(String)
                raise( SecurityError , "Insecure operation - #{str}" , caller(2) )
            else
                e = ( str.class ).to_s
                raise( BugDetected, "[BUG] no implicit conversion from #{e} (TypeError)",
                       caller(1))
            end
        end
        #--------------------------------------------------------------------------
        # ◆ バグを報告する。 ( str が String でない場合も BugDetected )
        #--------------------------------------------------------------------------
        def __report_bug( str )
            if str.is_a?(String)
                raise( BugDetected , str , caller(1))
            else
                e = ( str.class ).to_s
                raise( BugDetected ,
                       "[BUG] no implicit conversion from #{e} (TypeError)" , caller(1) )
            end
        end
        #--------------------------------------------------------------------------
        # ◆ バグを報告する。(異常な値を検出)
        #--------------------------------------------------------------------------
        def __report_bug_invalid_value( value )
            raise( BugDetected , "[BUG] invalid value for #{value}", caller(1))
        end
        #--------------------------------------------------------------------------
        # ◆※！※◆ WF-RGSS の バグを報告する。
        #    ※ このメソッドは WF-RGSS 内部バグを報告するためのものです。
        #    ※ カスタマイズ時にバグを報告したい場合は、
        #       __report_bug( str ) を使用してください。
        #--------------------------------------------------------------------------
        def __report_internal_bug( str )
            if str.is_a?(String)
                raise( InternalBugDetected , str , caller(1))
            else
                e = ( str.class ).to_s
                raise( InternalBugDetected ,
                       "[BUG] no implicit conversion from #{e} (TypeError)" , caller(1) )
            end
        end
        #--------------------------------------------------------------------------
        # ◆ チェック関連メソッド
        #    型や範囲をチェックします。
        #--------------------------------------------------------------------------
        # ◆ 型が合わない場合、例外 TypeErrorを発生させる
        #    (※ klass が異常な場合はBugDetected )
        #--------------------------------------------------------------------------
        def _type_check_( object_type , klass , call_value = 2 )
            begin
                return if object_type.is_a?(klass)
                e = ( object_type.class ).to_s
                raise( TypeError,"no implicit conversion from #{e}")
            rescue TypeError => errobj
                # 例外の報告位置をすりかえる
                if errobj.message[/^no/].nil?
                    raise( BugDetected , "[BUG] #{errobj.message} (TypeError)",caller(1))
                else
                    raise( TypeError , errobj.message , caller(call_value))
                end
            end
        end
        #--------------------------------------------------------------------------
        # ◆ Fixnum の範囲を検証する ※範囲が異常なら例外を発生させる
        #--------------------------------------------------------------------------
        def _fixnum_range_check( value , minimum , maximum )
            __failure_type_call__( value , 3 ) unless value.is_a?(Fixnum)
            unless value >= minimum and value <= maximum
                # 範囲外のため、例外を発生させる
                call_ary = caller(1)
                if call_ary.size > 0
                    sections = call_ary.at(0)
                    str = sections + " ( range #{minimum} .. #{maximum} )"
                else
                    str = "caller method (unknown) ( range #{minimum} .. #{maximum} )"
                end
                __outof_range_call__( value , str , 3 )
            end
        end
        #--------------------------------------------------------------------------
        # ◆ Integer の範囲にまとめる (※処理速度が求められる箇所では用いない)
        #    ※異常範囲が認められていない場合は、↑のメソッドを用いること
        #--------------------------------------------------------------------------
        def _integer_range_value( value , minimum , maximum )
            __failure_type_call__( value , 3 ) unless value.is_a?(Integer)
            if value < minimum
                return minimum
            elsif value > maximum
                return maximum
            else
                return value
            end
        end
        # ---------------------------------------------------------------------------
        # 可視性を変更
        public
        # これ以降はモジュール関数として定義
        module_function
        # ---------------------------------------------------------------------------
        # ◆ 真 を検証
        # ---------------------------------------------------------------------------
        def assert_if( value )
            unless value
                raise(AssertionError,"Assertion Failed (false for true)",caller(1))
            end
        end
        # ---------------------------------------------------------------------------
        # ◆ 偽 を検証
        # ---------------------------------------------------------------------------
        def assert_unless( value )
            if value
                raise(AssertionError,"Assertion Failed (true for false)",caller(1))
            end
        end
    end

    # ---------------------------------------------------------------------------
    # ◆ 組み込みクラス Object
    # ---------------------------------------------------------------------------
    class Object
        # 可視性を変更
        private
        #--------------------------------------------------------------------------
        # ◆ Mix-in禁止を実装
        #--------------------------------------------------------------------------
        def self.__cannot_mixin( klass )
            raise( IncludeError ,
                   "can't include #{klass} from #{self}" , caller(2) )
        end
        #--------------------------------------------------------------------------
        # ◆ 継承禁止を実装
        #--------------------------------------------------------------------------
        def self.__cannot_inherited( subclass )
            raise( InheritanceError ,
                   "can't inherit class #{subclass} from #{self}" , caller(2) )
        end
        #--------------------------------------------------------------------------
        # ◆ 抽象クラス (かならず継承が必要となる)
        #--------------------------------------------------------------------------
        def __abstract_class( target )
            klass = self.class
            unless target.is_a?(Class) or target.is_a?(Module)
                __report_bug("[BUG] class or modules required (TypeError)")
            end
            until ( klass = klass.superclass ) == Object
                return if klass == target
            end
            raise( AbstractError ,
                   "class #{target} cannot use it because of the abstraction class.",
                   caller(2) )
        end
    end

    # ---------------------------------------------------------------------------
    # ◆ 組み込みクラス String
    # ---------------------------------------------------------------------------
    class String
        # ---------------------------------------------------------------------------
        # ◆ 定数
        # ---------------------------------------------------------------------------
        CP_ACP   = 0         # ANSI コード
        CP_UTF7  = 65000     # UTF-7 コード
        CP_UTF8  = 65001     # UTF-8 コード
        EMPTY_STR = "".freeze
        #--------------------------------------------------------------------------
        # ◆ クラス変数
        #--------------------------------------------------------------------------
        @@rm = Win32API.new('kernel32','RtlZeroMemory',%w(p l),'l').freeze
        # 文字列をワイド文字列（Unicode）にマップするAPI
        @@mb2wc = Win32API.new('kernel32',
                               'MultiByteToWideChar', %w(i l p i p i), 'l').freeze
        # ワイド文字列を新しい文字列にマップするAPI
        @@wc2mb = Win32API.new('kernel32',
                               'WideCharToMultiByte', %w(i l p i p i p p), 'l').freeze
        #--------------------------------------------------------------------------
        # ◆ クリア
        #--------------------------------------------------------------------------
        unless rpgvxace?
            def clear
                @@rm.call( self , self.size )
                self.replace("")
            end
        end
        #--------------------------------------------------------------------------
        # ◆ エンコード
        #--------------------------------------------------------------------------
        def encode_by_
            for i in 0...self.size
                self[i] = 256 - self[i]
            end
        end
        #--------------------------------------------------------------------------
        # ◆ UTF-8 → ANSI 変換
        #--------------------------------------------------------------------------
        unless rpgvxace?
            def self.utf82ansi(str)
                to_multibyte(to_widechar(str, CP_UTF8), CP_ACP)
            end
        else
            def self.utf82ansi(str)
                result = to_multibyte(to_widechar(str, CP_UTF8), CP_ACP)
                result.empty? ? result : result.force_encoding("ASCII-8BIT")
            end
        end
        #--------------------------------------------------------------------------
        # ◆ ANSI → UTF-8 変換
        #--------------------------------------------------------------------------
        unless rpgvxace?
            def self.ansi2utf8( str )
                to_multibyte( to_widechar( str , CP_ACP ) , CP_UTF8 )
            end
        else
            def self.ansi2utf8( str )
                to_multibyte(to_widechar(str,CP_ACP),CP_UTF8).force_encoding("UTF-8")
            end
        end
        private  # 可視性を private に変更
        #--------------------------------------------------------------------------
        # ◆(内部専用)◆ ワイド文字列( Unicode ) へ変換
        #--------------------------------------------------------------------------
        def self.to_widechar(str, codepage)
            # puts "vvvvxzz"
            # Convert the string from the specified encoding to UTF-16 (which is Ruby's default wide character encoding)
            return ""
        end
        private_class_method(:to_widechar)
        #--------------------------------------------------------------------------
        # ◆(内部専用)◆ ワイド文字列( Unicode ) から 文字列を取得する
        #--------------------------------------------------------------------------
        def self.to_multibyte(str, codepage)
            # Convert a wide character string (UTF-16) to a multi-byte encoding (e.g., UTF-8 or Windows-1252)
            return ""
        end
        private_class_method(:to_multibyte)
    end

    # ---------------------------------------------------------------------------
    # ◆ モジュール ErrorLogWriter
    # ---------------------------------------------------------------------------

    module ErrorLogWriter
        #--------------------------------------------------------------------------
        # ◆(内部専用)◆ Mix-in 禁止
        #--------------------------------------------------------------------------
        def self.included( klass )
            __cannot_mixin( klass )
        end
        private_class_method(:included)

        ERROR_SECTION_NUM = (/^(?:Section)?{?(\d+)}?:/).freeze
        ERROR_SECTION     = (/^(?:Section)?{?\d+}?:/).freeze
        DOUBLE_CRLF       = (/\n\n/).freeze
        # -------------------------------------------------------------------------
        # ◆ エラー情報を記録 ( DEBUG のみ )
        # -------------------------------------------------------------------------
        def self.write( errobj )
            return unless debug?
            begin
                begin
                    Graphics.safe_update
                rescue SecurityHazard
                end
                sleep(0.1)
                File.open("errors.txt","a") do | file |
                    file.write("*Error - " +
                               (Time.now).strftime("%Y-%m-%d %H:%M:%S (%A)") + "\n")
                    file.write( "Exception : #{errobj.class}\n" )
                    file.write( errobj.message )
                    unless $@.nil? and $@.empty?
                        backtrace = ""
                        for str in $@.dup
                            unless (str[ERROR_SECTION_NUM]).nil?
                                extra = $RGSS_SCRIPTS.at($1.to_i).at(1)
                                str.gsub!(ERROR_SECTION) { "( " + extra + " )：" }
                            end
                            backtrace += str
                        end
                        file.write( "\ntrace:\n" + $@.inspect + "\n" )
                    end
                end
            rescue Exception => errs
                raise( errs ,
                       errs.message + "\n (" + (errobj.class).to_s + " )\n" + errobj.message )
            end
        end
    end

end
def hook_exit(arg,arg2,arg3,arg4)
    # puts arg,arg2,arg3,arg4
    puts "Exporting [#{arg}] ##{arg2}: #{arg3} #{arg4}"
    # Simulate what the hookExit function might do
    # puts "Simulated hookExit called with parameter:"
    # You can add more simulated behavior here, like logging, altering global variables, etc.
end
module MessageBox
    #----------------------------------------------------------------------------
    # ◆(内部専用)◆ Mix-in 禁止
    #----------------------------------------------------------------------------
    def self.included( klass )
        raise( IncludeError , "can't include #{klass} from #{self}" , caller(1) )
    end
    private_class_method(:included)
    # ---------------------------------------------------------------------------
    # ◆ 定数
    # ---------------------------------------------------------------------------
    MB_OK               = 0x0    #
    MB_OKCANCEL         = 0x1    #
    MB_ABORTRETRYIGNORE = 0x2    #
    MB_YESNOCANCEL      = 0x3    #
    MB_YESNO            = 0x4    #
    MB_RETRYCANCEL      = 0x5    #

    MB_ICONERROR        = 0x10     # エラー
    MB_ICONQUESTION     = 0x20     # 問い合わせ
    MB_ICONWARNING      = 0x30     # 警告
    MB_ICONINFORMATION  = 0x40     # 情報
    MB_SYSTEMMODAL      = 0x1000   # システムモーダル
    MB_TASKMODAL        = 0x2000   # タスクモーダル
    MB_TOPMOST          = 0x040000 # 最前面
    MB_FATAL            = 0x042010 # 致命的エラー用
    MB_WARN             = 0x042030 # 警告

    IDOK     = 1
    IDCANCEL = 2
    IDABORT  = 3
    IDRETRY  = 4
    IDIGNORE = 5
    IDYES    = 6
    IDNO     = 7
    # ---------------------------------------------------------------------------
    # ◆ 内部使用定数
    # ---------------------------------------------------------------------------
    ERROR_SECTION_NUM = (/^(?:Section)?{?(\d+)}?:/).freeze
    ERROR_SECTION     = (/^(?:Section)?{?\d+}?:/).freeze
    DOUBLE_CRLF       = (/\n\n/).freeze

    begin
        # メッセージボックス
        @@mb = method(:hook_exit)
    rescue Exception
        # 取得失敗
        Script_Deleter.finalizer
        raise( LoadError , "cannot read modules.(user32.dll)",caller(0))
    end
    begin
        # ini ファイルから、セクションのキーを取得するAPI
        @@gpps = Win32API.new('kernel32',
                              'GetPrivateProfileStringA',%w(p p p p l p),'l').freeze
    rescue Exception
        # 取得失敗
        Script_Deleter.finalizer
        raise( LoadError , "cannot read modules.(kernel32.dll)",caller(0))
    end
    #--------------------------------------------------------------------------
    # ◆(！要注意メソッド！)◆ メッセージボックスを表示
    #   ※警告 ：例外 Hangup 対策をかならず行うこと！
    #--------------------------------------------------------------------------
    def self.messagebox( message , title , type )
        begin
            # 停止対策用
            begin
                Graphics.safe_update
            rescue SecurityHazard
            end
            @@mb.call(0, String.utf82ansi( message ), String.utf82ansi( title ),type)
        rescue Hangup
            nil # ！※例外時にここを通過せずに外部に投げられる恐れあり
        ensure
            # ！※例外時にここを通過せずに外部に投げられる恐れあり
            begin
                Graphics.safe_update
            rescue SecurityHazard
            end
        end
    end
    #--------------------------------------------------------------------------
    # ◆(！特定外使用禁止！)◆ 致命的エラーを通知
    #   ※警告 ：例外 Hangup 対策をかならず行うこと！
    #--------------------------------------------------------------------------
    def self.fatalerror( errobj )
        begin
            ErrorLogWriter.write( errobj )
            error_message , tracer = error_message_setup( errobj )
            # 瞬間消去
            Graphics.transition(0)
            Audio.bgm_stop
            Audio.bgs_stop
            Audio.me_stop
            Audio.se_stop
            if debug? and ( not (tracer[/^(?:Section)?{?(\d+)}?:(\d+)/]).nil? )
                # セクションを拾い出した場合
                nums = $1.to_i
                extra = $RGSS_SCRIPTS.at(nums).at(1)
                lines = $2.to_i
                tracer = "#{extra} の #{lines} 行目で、\n"
                error_message = tracer + error_message
            end
            title = "\x00" * 256
            @@gpps.call( 'Game' , 'Title' , '' , title , 255 , '.\\Game.ini' )
            title = String.ansi2utf8(title)
            title.tr("\x00","")
            # マウスカーソルを表示
            Input.mouse_show if Input.method_defined?(:mouse_show)
            # メッセージボックス
            puts  error_message , title , MB_FATAL
            messagebox( error_message , title , MB_FATAL )
        rescue Hangup
            nil # ！※例外時にここを通過せずに外部に投げられる恐れあり
        end
    rescue Hangup
        nil
    end
    # ---------------------------------------------------------------------------
    # ◆ 異常終了のメッセージを整形
    # ---------------------------------------------------------------------------
    def self.error_message_setup( errobj )
        Graphics.freeze
        begin
            Graphics.safe_update
        rescue SecurityHazard
        end
        _message = ""
        # バックトレースを記憶する
        unless $@.nil? or ($@.at(0)).nil?
            tracer =  ($@.at(0)).dup
            # バックトレースを解析する
            backtrace = ""
            i = 0
            for str in $@.dup
                unless (str[ERROR_SECTION_NUM]).nil?
                    extra = $RGSS_SCRIPTS.at($1.to_i).at(1)
                    str.gsub!(ERROR_SECTION) { "( " + extra + " )：" }
                end
                backtrace += str
            end
            unless errobj.is_a?(SystemStackError)
                if rpgvxace?
                    _message = errobj.message.force_encoding("UTF-8") +
                     "\n** backtrace：\n" + backtrace
                else
                    _message = errobj.message + "\n** backtrace：\n" + backtrace
                end
            end
        else
            tracer = "" # バックトレース取得失敗
            if rpgvxace?
                _message = errobj.message.force_encoding("UTF-8")
            else
                _message = errobj.message
            end
        end
        until (_message[DOUBLE_CRLF]).nil?
            _message.gsub!(DOUBLE_CRLF){ "\n" }
        end
        if debug?
            _message = "解決できない例外 " + (errobj.class).inspect +
                 " が発生したため、処理を継続できません。\n" +
                 _message
        else
            _message = "解決できない例外 " + (errobj.class).inspect +
                 " が発生したため、処理を継続できませんでした。\n" +
                 "お手数をおかけして申し訳ありません。\n\n詳細情報：\n" +
                 _message
        end
        return _message, tracer
    end
end

# RGSS2 環境だと、リセットは阻止できない。
if $@ and WFRGSS::DEBUG_CONSOLE and debug?
    p "例外 Reset が外部へ投げられました。"
end
