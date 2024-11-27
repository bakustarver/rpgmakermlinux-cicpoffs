=begin
#_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

  メッセージテキストデータベース　by 村人Ａ
  
#_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/


#==============================================================================
# バージョン管理
#==============================================================================

20/06/01  バージョン2.0
          メッセージウィンドウの背景と位置が連番の際に反映されない不具合を修正し
          ました。

20/04/01  バージョン1.99
          csvの読み込みエンコードをShift JISからUTF8に変更しました

20/03/07  バージョン1.98
          任意の数の言語に対応できるようにしました。

20/02/08  バージョン1.97
          回帰エラーを修正
          エラーが発生しやすい箇所を修正しました。

20/01/09  バージョン1.967
          セーブデータ読み込み時に発生するエラー落ちを修正しました。

19/12/27  バージョン1.965
          BlueRedZone様のイベント呼び出しの際などメッセージイベントの間に場所移
          動があった場合に発生する不具合の修正しました。
          ログシートに半角カンマがあった際に文章両端にダブルクォーテーションが表
          示される不具合を修正しました。

19/12/16  バージョン1.961
          BlueRedZone様のイベント呼び出しスクリプトとの競合を解消しました。

19/12/12  バージョン1.96
          過去の不具合の修正をした箇所で抜けがあった箇所を修正しました。
          それにつき、19/11/29に修正したバージョンを1.94から1.945としました。

19/12/05  バージョン1.95
          イベントデータベースとコモンデータベースのテキスト番号に巨大数がふられ
          ていた場合にも対応できるように修正しました。

19/11/29  バージョン1.945
          BRZ様のマップイベント呼び出し時に連番メッセージ取得をした際に発生する
          不具合を修正

19/10/29  バージョン1.94
          場所移動後のデータベーステキスト表示の際に発生する不具合を修正

19/10/04  バージョン1.938
          制御文字記述した際にログデータが取得できない不具合を修正

19/10/03  バージョン1.935
          選択肢拡張の際に空白が出来てしまう競合を解消しました。

19/09/27  バージョン1.93
          選択肢内にログデータベースの文章を入れた際に変数の制御文字が入っていた
          場合、置換するようにしました。

19/09/12  バージョン1.92
          BlueRedZone様のスクリプトとの競合解消部分の不具合を修正

19/09/03  バージョン1.91
          コモンイベントを含んだデータベーステキストを選択肢前に置くと、テキストの
          順番が前後する不具合を修正
          
19/08/22  バージョン1.9
          変数にログデータベースのテキストを代入できるスクリプトを作りました。
          
19/08/09  バージョン1.84
          コモンイベントに係る不具合を修正
          
19/08/07  バージョン1.83
          選択肢や数値入力の処理があった場合に、メッセージが表示されない不具合を
          修正
          
19/08/03  バージョン1.82
          メッセージが挿入されてしまう不具合を修正
          
19/07/31  バージョン1.81
          連番表示後に場所移動があった際に発生するエラーを修正
          ログテキストの追加に不備があったものを修正
          
19/07/30  バージョン1.8
          確認されている不具合を修正
          アルゴリズムの変更
          
19/07/22  バージョン1.77
          確認されている不具合を修正
          
19/07/11  バージョン1.76
          確認されている不具合を修正
          
19/06/27  バージョン1.75
          イベントコマンドやコモンイベントが上手く流れない不具合を修正しました。
          
19/06/24  バージョン1.7
          メッセージデータベースの１行目にスクリプトの記述があった場合、メッセー
          ジ前にそのスクリプトの内容を実行するようにしました。
          
19/05/25  バージョン1.6
          コモンイベントの改行が正しく表示されない不具合を修正
          例外発生時にコンソールとメッセージに出力するようにしました。
          
19/05/22  バージョン1.5
          自動実行や並列実行のコモンイベントがあった場合にエラー落ちする不具合を
          修正しました。
          
19/05/19  バージョン1.4
          半角ハイフンを入れることで連番でデータベーステキストを表示できるように
          しました。
          ログウィンドウのＩＤを数値だけでなく英数記号に対応するようにしました。
          ＩＤに半角ハイフン-を入れるのは連番表示と被ってしまうのでお控えください。
          
19/05/13  バージョン1.3
          イベントページ数による不具合を修正
          マップイベント呼び出しとの競合部分を修正
          
19/05/11  バージョン1.2
          ページ読み込み時の不具合を修正
          スクリプトデータがないセーブで正常に動作するようにしました。
          
19/05/07  バージョン1.1
          コモンイベントのデータベースにも対応するようにしました。
          イベントについて2桁以上のIDで発生する不具合を修正しました。
          csvファイルはSystem/TextCsvフォルダ内に保存するようにしてください。
          
19/05/03  バージョン1.0
          試作品リリース


#==============================================================================
# ヘルプ
#==============================================================================


CSVファイルより表示するテキストデータを取得し、文章の表示を行うスクリプトです。

2019/5/20追加
注意として、コモンイベントの自動実行に関わるスクリプト素材とは競合する可能性があ
るので使用する場合はこのスクリプトよりも下に配置するようにしてください。


＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

19/6/24　追記
☆スクリプトの記述の仕方について

＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

現在データベースのスクリプト欄では変数操作、スイッチ操作、コモンイベント実行の
３つイベントが処理できるように設定されています。

●変数の場合

代入の場合

$v[変数ＩＤ] = 値

と記述します。例えば変数３に91を代入したい場合は

$v[3]=91

となります。
加減乗除,剰余,べき乗についてはそれぞれ

$v[3] += 91
$v[3] -= 91
$v[3] *= 91
$v[3] /= 91
$v[3] %= 91
$v[3] **= 91

と記述します。


●スイッチの場合

$s[スイッチＩＤ] = trueまたはfalse

と記述します。trueでon、falseでoffとなります。

例えばスイッチ１をonにしたい場合

$s[1]=true

となります。


●コモンイベントの場合

$c(コモンイベントのＩＤ)

と記述します。こちらは変数やスイッチとは違い、角括弧ではなく、丸括弧であることに
注意してください。

例えばコモンイベント３１を実行したい場合

$c(31)

となります。


＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

☆変数にログデータベースのテキストを代入するには　＊8/22追記

＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

変数にログデータベースのテキストを代入するスクリプトのコマンドを追加しました。

val_in_database(変数ＩＤ, ログデータベースのＩＤ)

と記述することで指定した変数にログデータベースのテキストを代入することが出来ます。
例えば変数3にログデータベース4のテキストを代入する場合は

val_in_database(3, 4)

となります。


＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

☆データベースへの文章の記述について、ご注意いただきたい点

＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

csvデータテキストをツクールVXAce内で使用する文字列に変換するため、文章の記述法
にいくつかご注意していただきたい点がございます。

・文章に改行を入れる場合は改行を入れる箇所に半角スラッシュ「/」を入れてください。

・文章中の半角カンマ「,」の前には半角円マーク「\」を入れてください。

・変数の\N[1]や文字色の\C[1]などは通常通りに記述してください。これは他スクリプト
素材で使用する特殊文字についても同様です。


＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

☆イベントのメッセージテキストに使用するデータベース記述の仕方

＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

・イベントコマンド「文章の表示」を記述する個所で

_event_data_base_text_ + テキストID

と記述してください。例えばそのイベントのテキスト3の取得したい場合は

_event_data_base_text_3

と記述してください。

・こちらのデータベースはマップＩＤ、イベントＩＤ，ページ、テキスト番号で管理され
ます。

・セルＡにはテキストの場合は「$text＋番号」、ページの場合は「$page＋ページ数」、
イベントの場合は「$event＋イベントＩＤ」、マップの場合は「$map＋マップＩＤ」
というように記述されます。

・csvデータについて、テキストは上部セルにあるページ数に、ページは上部セルにある
イベントＩＤに、イベントは上部セルにあるマップＩＤに所属します。

・マップ上イベントに記述することでそのイベントがあるマップＩＤ、イベントＩＤ、
スクリプトが書かれている現在のページ数が取得されます。このため、あるイベントから
他のイベントのデータベースに書かれているテキストを取得することは出来ません。

・もしイベントに縛られないテキストを取得した場合は

_log_database_text_ + ログ番号

と記述し、ログウィンドウのデータベースから取得してください。

・同じ行に英語と日本語のテキストを書き、Ｂ列に日本語を、Ｃ列に英語のテキストを
書いてください。



＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

☆ログウィンドウに使用するデータベース記述の仕方

＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

・ログウィンドウにてログデータベースのテキストを参照する場合はイベントスクリプト
にて

set_mlog("_log_database_text_+テキスト番号")

と記述してください。例えば番号が4のログテキストを表示する場合は

set_mlog("_log_database_text_4")

となります。

・Ａ列にはログの番号が記述されます。半角数字で記述してください。

・同じ行に日本語と英語のテキストを書き、Ｂ列に日本語を、Ｃ列に英語のテキストを
書いてください。

・ログテキストはメッセージウィンドウでも上記_log_database_text_+テキスト番号
と書くことでログデータベースに書かれたテキストを表示することが可能です。


＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

☆CSVファイルの保存方法

＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

・csvについてはイベントのメッセージに使用するものについては「sheet.csv」という
名前で、ログウィンドウに使用するものについては「logSheet.csv」という名前で保存
してください。

・csvの編集についてはExcelで色分けしたもので編集し、出来次第csvに変換するという
手順をお勧めします。ファイルがある場合は上書き保存してください。
csvではセルの大きさや色分けが保存されないためです。TechnoBrake様にとって一番良き
ように操作してください。
今回こちらが編集に使ったExcelファイルも同梱しましたので、よろしければご参照くだ
さい。


＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

☆その他ご注意いただきたい点

＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

・現在このスクリプトはイベントコマンドで行う「文章の表示」と「ログウィンドウの
スクリプトでの表示」のみに対応しています。

・日本語と英語の切り替えには変数を使用しています。現在は変数が0の時日本語、1の時
英語となります。今後もし、英語以外の言語でも表示したいとなった場合に拡張性を持た
せるために変数を使用しました。
使用する変数のＩＤは下記MessageTextDataBaseにて変更可能です。



何かご不明な点等ございましたらお気兼ねなくメールでご質問ください。

=end

module MessageTextDataBase
    #言語を設定する変数のIDを指定します。
    #変数が0の時日本語、1の時英語となります。
    LANG_VARIABLE_ID = 1
  end
  
  
  #============================================================================
  #
  #  以下変更不要
  #
  #============================================================================
  
  class << DataManager
    attr_accessor :ms_database
    attr_accessor :log_database
    attr_accessor :common_database
    


    def convert_ms_csv_data(file_name)
      fn = "System/TextCsv/#{file_name}.csv"
      res = ""

      # Check if the file exists
      unless File.exist?(fn)
        puts "Error: File not found - #{fn}"
        puts "pls rename #{fn} for the game"
        return nil
      end

      # Read the file content
      begin
        # puts "DEBUG start"
        puts Dir.pwd
        File.open(fn, mode = "r") do |f|
          res = f.read
        end
      rescue Errno::ENOENT
        puts "Error: File not found - #{fn}"
        puts "pls rename #{fn} for the game"
        return nil
      end

      # Process the CSV data
      res.gsub!(/\\,/, "\&\%")
      res.gsub!(/(\/\n)/, "\&\#")
      res.gsub!(/(\"\")/, "\&\$")

      # Split the data into lines
      rows = res.split("\n")

      # Initialize an array to hold processed rows
      processed_rows = []

      # Iterate over each row and split into columns
      rows.each do |row|
        # Split the row by commas and replace placeholders back to commas
        processed_row = row.split(',').map { |str| str.gsub(/\&\%/, ",") }
        processed_rows << processed_row
      end

      # Remove the header row (first row)
      processed_rows.shift if processed_rows.any?

      return processed_rows
    end


    def create_common_database_text
      @common_database = {}
      common_res = convert_ms_csv_data('commonSheet')
      common_id  = -1
      common_res.each{|arr|
        identifier = arr[0]
        next unless identifier
        if identifier.match(/\$common(\d+)/)
          common_id = $1.to_i
        elsif identifier.match(/\$text(\d+)/)
          text_id = $1.to_i
          @common_database[common_id] = {} unless @common_database[common_id]
          arr.shift
          arr.map!{|str| str ? str : ""}
          @common_database[common_id][text_id] = arr.dup
        end
      }
    end
    
    def create_log_database_text
      @log_database = {}

      log_res = convert_ms_csv_data('logSheet')

      # Check if log_res is nil or empty
      if log_res.nil? || log_res.empty?
        puts "Error: logSheet.csv is missing or empty"
        return
      end

      n = log_res.length - 1
      for i in 0..n
        num = log_res[i].shift
        log_res[i].map! { |str| str ? str : "" }
        @log_database[num] = log_res[i].dup
      end
    end

    
    def create_event_database_text
      res = convert_ms_csv_data('sheet')
      @ms_database = {}
      map_id = event_id = page = text_id = -1
      res.each{|arr|
        identifier = arr[0]
        next unless identifier
        if identifier.match(/\$map(\d+)/)
          map_id = $1.to_i
        elsif identifier.match(/\$event(\d+)/)
          event_id = $1.to_i
        elsif identifier.match(/\$page(\d+)/)
          page = $1.to_i
        elsif identifier.match(/\$text(\d+)/)
          text_id = $1.to_i
          @ms_database[map_id] = {} unless @ms_database[map_id]
          @ms_database[map_id][event_id] = {} unless @ms_database[map_id][event_id]
          @ms_database[map_id][event_id][page] = {} unless @ms_database[map_id][event_id][page]
          @ms_database[map_id][event_id][page][text_id] = {} unless @ms_database[map_id][event_id][page][text_id]
          arr.shift
          arr.map!{|str| str ? str : ""}
          @ms_database[map_id][event_id][page][text_id] = arr.dup
        end
      }
    end
    
    
    alias _msdate_load_normal_database load_normal_database
    def load_normal_database
      _msdate_load_normal_database
      create_common_database_text
      create_log_database_text
      create_event_database_text
    end
  end
  #==============================================================================
  # ■ Scene_Map
  #==============================================================================
  class Scene_Map < Scene_Base
    attr_reader :message_window
  end
  
  #==============================================================================
  # ■ Scene_Load
  #------------------------------------------------------------------------------
  # 　ロード画面の処理を行うクラスです。
  #==============================================================================
  
  class Scene_Load < Scene_File
    #--------------------------------------------------------------------------
    # ● ロード成功時の処理
    #--------------------------------------------------------------------------
    alias _msdata_on_load_success on_load_success
    private :_msdata_on_load_success
    def on_load_success
      _msdata_on_load_success
      $game_system.map_log_text_array = [] if $game_system.map_log_text_array.nil?
      #$game_system.logwindow_message = [] if $game_system.logwindow_message.nil?
    end
  end
  
  #==============================================================================
  # ■ Window_Message
  #==============================================================================
  
  class Window_Message < Window_Base
    #--------------------------------------------------------------------------
    # ● 改ページ処理
    #--------------------------------------------------------------------------
    alias _msdata_new_page new_page
    def new_page(text, pos)
      tex = text.split("\f")[0]
      if tex
        if tex.match(/_msdate_common\((.+)\)/)
          $game_message._interpreter.set_common_event($1.to_i)
        end
        if tex.match(/_msdate_switch\((.+)\)/)
          res_arr = $1.split(",")
          $game_switches[res_arr[0].to_i] = res_arr[1] == "true"
        end
        if tex.match(/_msdate_variable\((.+)\)/)
          res_arr = $1.split(",")
          $game_variables[res_arr[0].to_i] = res_arr[1].to_i
        end
      end
      _msdata_new_page(text, pos)
    end
  end
  #==============================================================================
  # ■ Window_ChoiceList
  #==============================================================================
  
  class Window_ChoiceList < Window_Command
    #--------------------------------------------------------------------------
    # ● 選択肢の最大幅を取得
    #--------------------------------------------------------------------------
    def max_choice_width
      arr = $game_message.choices.map{|choice| convert_escape_characters(choice)}
      arr.collect {|s| text_size(s).width }.max
    end
  end
  
  #==============================================================================
  # ■ Game_Interpreter
  #==============================================================================
  
  class Game_Interpreter
    attr_accessor :is_common
    attr_accessor :in_common
    
    #--------------------------------------------------------------------------
    # ● イベントのセットアップ
    #--------------------------------------------------------------------------
    alias _msdata_setup setup
    private :_msdata_setup
    def setup(list, event_id = 0)
      _msdata_setup(list, event_id)
      if get_character(0)
        @call_event = get_character(0)
        page_num = @call_event.page_number
        @database_text_map_id_array = [$game_map.map_id, @event_id, page_num]
      end
    end
    #--------------------------------------------------------------------------
    # ● 文章の表示
    #--------------------------------------------------------------------------
    alias _msdata_command_101 command_101
    private :_msdata_command_101
    def command_101
      set_event_info_array
      $game_message._interpreter = self
      $game_message.background = @params[2]
      $game_message.position = @params[3]
      text = check_msdata
      if text
        after_message_common
      #20/06/01 修正
        $game_message.background = @params[2]
        $game_message.position = @params[3]
        $game_message.add(text.join("\n"))
        after_message_code_pros
        wait_for_message
      else
        _msdata_command_101
      end
    end
    
    #--------------------------------------------------------------------------
    # ● 場所移動
    #--------------------------------------------------------------------------
    alias _msdata_command_201 command_201
    private :_msdata_command_201
    def command_201
      #$game_map.another_map_event_list = @list#get_character(0).list
      _msdata_command_201
    end
    
    #--------------------------------------------------------------------------
    # ● データベース用メッセージ
    #--------------------------------------------------------------------------
    def after_message_code_pros
      case next_event_code
      when 102  # 選択肢の表示
        @index += 1
        setup_choices(@list[@index].parameters)
      when 103  # 数値入力の処理
        @index += 1
        setup_num_input(@list[@index].parameters)
      when 104  # アイテム選択の処理
        @index += 1
        setup_item_choice(@list[@index].parameters)
      end
    end
    
    #--------------------------------------------------------------------------
    # ● データベース用メッセージ
    #--------------------------------------------------------------------------
    def check_msdata
      arr = ["_event_data_base_text_", "_common_database_text_", "_log_database_text_"]
      func = ["convert_event_database_one_text", "convert_common_database_one_text", "convert_log_database_one_text"]
      for i in 0..arr.length-1
        text = check_msdata_pros(arr[i], func[i])
        return text if text
      end
      return false
    end
    
    #--------------------------------------------------------------------------
    # ● データベース用メッセージ処理
    #--------------------------------------------------------------------------
    def check_msdata_pros(data_text, func_name)
      return false unless @list[@index+1].parameters[0].match(/#{data_text}(.+)/)
      id = $1
      if id.match(/(\d+)-(\d+)/)
        start_index = $1.to_i
        n1 = $1.to_i+1
        n2 = $2.to_i
        for i in n1-1..n2-1
          text = $game_message.send(func_name, i.to_i)
          set_common_event($game_temp.instant_common_event_id) if $game_temp.instant_common_event_id
          $game_temp.instant_common_event_id = nil
          #20/06/01 修正
          $game_message.background = @params[2]
          $game_message.position = @params[3]
          $game_message.add(text.join("\n"))
          wait_for_message
        end
        text = $game_message.send(func_name, n2.to_i)
        return text
      else
        num = data_text == "_log_database_text_" ? id : id.to_i
        text = $game_message.send(func_name, num)
        @index += 1
      end
      return text
    end
    
    #--------------------------------------------------------------------------
    # ● 選択肢のセットアップ
    #--------------------------------------------------------------------------
    alias _msdata_setup_choices setup_choices
    private :_msdata_setup_choices
    def setup_choices(params)
      return @msdata_added_ms_command = false if @msdata_added_ms_command == "choice"
      _msdata_setup_choices(params)
    end
    
    #--------------------------------------------------------------------------
    # ● 数値入力のセットアップ
    #--------------------------------------------------------------------------
    alias _msdata_setup_num_input setup_num_input
    private :_msdata_setup_num_input
    def setup_num_input(params)
      return @msdata_added_ms_command = false if @msdata_added_ms_command == "number"
      _msdata_setup_num_input(params)
    end
    
    #--------------------------------------------------------------------------
    # ● アイテム選択のセットアップ
    #--------------------------------------------------------------------------
    alias _msdata_setup_item_choice setup_item_choice
    private :_msdata_setup_item_choice
    def setup_item_choice(params)
      return @msdata_added_ms_command = false if @msdata_added_ms_command == "item"
      _msdata_setup_item_choice(params)
    end
    #--------------------------------------------------------------------------
    # ● メッセージデータベースを使用するための情報を設定
    #--------------------------------------------------------------------------
    def set_event_info_array
      map_id = event_id = page_num = nil
      set_map_id_array
      a = @database_text_map_id_array || [nil,nil,nil]
      $game_message.get_event_info(a[0], a[1], a[2], @in_common)
    end
    
    #--------------------------------------------------------------------------
    # ● メッセージ追加後即時コモンイベント
    #--------------------------------------------------------------------------
    def set_map_id_array
      return unless @database_text_map_id_array.nil?
      return if @in_common
      info = $game_system.call_map_script_info
      if info
        @database_text_map_id_array = info.dup
      else
        if get_character(0)
          page_num = get_character(0).page_number
          @database_text_map_id_array = [$game_map.map_id, @event_id, page_num]
        end
      end
      $game_system.call_map_script_info = nil
    end
    
    #--------------------------------------------------------------------------
    # ● メッセージ追加後即時コモンイベント
    #--------------------------------------------------------------------------
    def after_message_common
      return unless $game_temp.instant_common_event_id
      id = $game_temp.instant_common_event_id
      $game_temp.instant_common_event_id = nil
      set_common_event(id)
    end
    
    #--------------------------------------------------------------------------
    # ● コモンイベント
    #--------------------------------------------------------------------------
    def command_117
      set_common_event(@params[0])
    end
    
    #--------------------------------------------------------------------------
    # ● コモンイベントのセット
    #--------------------------------------------------------------------------
    def set_common_event(id)
      common_event = $data_common_events[id]
      pre_info = [$game_message.background, $game_message.position]
      if common_event
        child = Game_Interpreter.new(@depth + 1)
        child.setup(common_event.list, same_map? ? @event_id : 0)
        child.is_common = true
        child.in_common = id
        child.run
      end
      $game_message.background = pre_info[0]
      $game_message.position   = pre_info[1]
    end
    
    #--------------------------------------------------------------------------
    # ● イベントコマンドの実行
    #--------------------------------------------------------------------------
    alias _msdata_execute_command execute_command
    private :_msdata_execute_command
    def execute_command
      _msdata_execute_command
      command = @list[@index]
#~       puts command
      if command != nil && command.code == 0 && !@is_common && @indent == 0 && @index == @list.size - 1
        end_pross
      end
    end
    
    #--------------------------------------------------------------------------
    # ● リストの復元
    #--------------------------------------------------------------------------
    def restore_list
      if @pre_list
        if @is_common
          $data_common_events[@in_common].list = @pre_list
        else
          $game_map.events[@event_id].reset_list(@pre_list)
          #@save_character_event.reset_list(@pre_list)
        end
        @list = @pre_list
        @index -= @msdata_back_index_num
        @msdata_add_pros_ms = false
      end
      @pre_list = nil
    end
    
    #--------------------------------------------------------------------------
    # ● 終了処理
    #--------------------------------------------------------------------------
    def end_pross
      @in_common = nil
      @database_text_map_id_array = nil
    end
    
    #--------------------------------------------------------------------------
    # ● 変数にデータベースの情報を代入
    #--------------------------------------------------------------------------
    def val_in_database(val, id)
      puts MessageTextDataBase::LANG_VARIABLE_ID.to_s
      begin
        lang = $game_variables[MessageTextDataBase::LANG_VARIABLE_ID]
        text = DataManager.log_database.dup[id.to_s][lang]
      rescue
        puts "ログデータベースにデータが見つかりません。ID：" + id.to_s + "　言語番号：" + lang.to_s
        return
      end
      text = $game_message.convert_app_text(text)[0]
      raise("戦闘中の代入は実装しておりません。") if $game_party.in_battle
      $game_variables[val] = SceneManager.scene.message_window.convert_escape_characters(text)
    end

    def var_from_sheet(var, map, event, page, text, line)
        raw = DataManager.ms_database[map][event][page][text][ $game_variables[MessageTextDataBase::LANG_VARIABLE_ID] + 1 ]
        convert = $game_message.convert_app_text(raw)[line]
        $game_variables[var] = SceneManager.scene.message_window.convert_escape_characters(convert)
    end

    def var_from_common(var, common, text, line)
        raw = DataManager.common_database[common][text][ $game_variables[MessageTextDataBase::LANG_VARIABLE_ID] + 1 ]
        convert = $game_message.convert_app_text(raw)[line]
        $game_variables[var] = SceneManager.scene.message_window.convert_escape_characters(convert)
    end
  end
  #==============================================================================
  # ■ Game_Temp
  #==============================================================================
  
  class Game_Temp
    attr_accessor   :instant_common_event_id          # コモンイベント ID
    def instant_exec_common(id)
      @instant_common_event_id = id
    end
  end
  
  #==============================================================================
  # ■ Game_Map
  #==============================================================================
  
  class Game_Map
    attr_accessor :another_map_event_list
    #--------------------------------------------------------------------------
    # ● 自動実行のコモンイベントを検出／セットアップ
    #--------------------------------------------------------------------------
    alias _msdata_setup_autorun_common_event setup_autorun_common_event
    private :_msdata_setup_autorun_common_event
    def setup_autorun_common_event
      event = _msdata_setup_autorun_common_event
      if event
        @interpreter.setup(event.list)
        @interpreter.in_common = event.id
      end
      event
    end
  end
  
  #==============================================================================
  # ■ Game_CommonEvent
  #==============================================================================
  
  class Game_CommonEvent
    attr_accessor :common_id
    #--------------------------------------------------------------------------
    # ● オブジェクト初期化
    #--------------------------------------------------------------------------
    alias _msdata_initialize initialize
    private :_msdata_initialize
    def initialize(common_event_id)
      _msdata_initialize(common_event_id)
      @common_id = common_event_id
    end
    #--------------------------------------------------------------------------
    # ● リフレッシュ
    #--------------------------------------------------------------------------
    alias _msdata_refresh refresh
    private :_msdata_refresh
    def refresh
      _msdata_refresh
      if active?
        @interpreter.in_common = @common_id
      end
    end
  end
  
  #==============================================================================
  # ■ Game_System
  #==============================================================================
  
  class Game_System
    #--------------------------------------------------------------------------
    # ● 公開インスタンス変数
    #--------------------------------------------------------------------------
    attr_accessor :call_map_script_info      # 追加するログのメッセージ
  end
  
  #==============================================================================
  # ■ Game_Event
  #==============================================================================
  
  class Game_Event < Game_Character
    attr_reader :page_number
    #--------------------------------------------------------------------------
    # ● リフレッシュ
    #--------------------------------------------------------------------------
    alias _msdata_refresh refresh
    def refresh
      _msdata_refresh
      if @event.pages.reverse.index(@page)
        @page_number = @event.pages.index(@page) + 1
      end
    end
    
    #--------------------------------------------------------------------------
    # ● イベントリストの復元
    #--------------------------------------------------------------------------
    def reset_list(list)
      @list = list
    end
  end
  
  
  #==============================================================================
  # ■ Game_Message
  #==============================================================================
  
  class Game_Message
    attr_accessor :pre_md_message_info
    attr_accessor :_interpreter
    
    #--------------------------------------------------------------------------
    # ● クリア
    #--------------------------------------------------------------------------
    alias _msdata_clear clear
    def clear
      @call_map_script_info = ""
      _msdata_clear
    end
    
    #--------------------------------------------------------------------------
    # ● メッセージが表示された時のマップイベント情報を取得
    #--------------------------------------------------------------------------
    def get_event_info(map_id, id, page, is_common)
      @msd_map_id = map_id
      @msd_event_id = id
      @msd_event_page = page
      @common_id = is_common
    end
    
    #--------------------------------------------------------------------------
    # ● その他のテキストだった場合その他のデータベースより取得
    #--------------------------------------------------------------------------
    def convert_other_database_text(text)
      m1 = text.match(/_log_database_text_(.+)/)
      return false unless m1
      log_num = m1[1]
      if log_num.match(/(\d+)-(\d+)/)
        series_text = []
        for i in $1.to_i..$2.to_i
          text = check_log_database_text(i.to_s)
          series_text.push(text)
          if i != $2.to_i
            series_text[series_text.length-1] += "\f"
          end
        end
        return series_text
      else
        text = check_log_database_text(log_num)
        return convert_app_text(text)
      end
    end
    #--------------------------------------------------------------------------
    # ● ログテキストの取得と存在確認
    #--------------------------------------------------------------------------
    def check_log_database_text(ind)
      lang = $game_variables[MessageTextDataBase::LANG_VARIABLE_ID]
      data = DataManager.log_database[ind]
      unless data
        tex = "ログテキストデータが不正かデータがありません。\n"
        tex += "番号：" + ind.to_s
        puts tex
        return tex
      end
      return data[lang]
    end
    #--------------------------------------------------------------------------
    # ● 単一のメッセージ用のテキストだった場合メッセージデータベースより取得
    #--------------------------------------------------------------------------
    def convert_event_database_one_text(t_index)
      lang = $game_variables[MessageTextDataBase::LANG_VARIABLE_ID] + 1
      begin
        script_str = DataManager.ms_database[@msd_map_id][@msd_event_id][@msd_event_page][t_index][0].dup
        pre_script_check(script_str)
        text = DataManager.ms_database[@msd_map_id][@msd_event_id][@msd_event_page][t_index][lang]
        res_arr = convert_app_text(text)
      rescue
        tex = "イベントテキストデータが不正かデータがありません。\n"
        tex += "マップID：" + @msd_map_id.to_s + "　イベントID：" + @msd_event_id.to_s + "　ページ：" + @msd_event_page.to_s + "　テキストID：" + t_index.to_s + "　言語番号：" + lang.to_s
        puts tex
        return [tex]
      end
      return res_arr
    end
    #--------------------------------------------------------------------------
    # ● 単一のメッセージ用のテキストだった場合メッセージデータベースより取得
    #--------------------------------------------------------------------------
    def convert_common_database_one_text(ind)
      lang = $game_variables[MessageTextDataBase::LANG_VARIABLE_ID] + 1
      begin
        data = DataManager.common_database[@common_id][ind]
        script_str = data[0].dup
        pre_script_check(script_str)
        text = DataManager.common_database[@common_id][ind][lang]
        res_arr = convert_app_text(text)
      rescue
        tex = "コモンIDか番号が不正か、データがありません。\n"
        tex += "コモンID：" + @common_id.to_s + "　番号：" + ind.to_s + "　言語：" + lang.to_s
        puts tex
        return [tex]
      end
      return res_arr
    end
    #--------------------------------------------------------------------------
    # ● ログテキストの取得と存在確認
    #--------------------------------------------------------------------------
    def convert_log_database_one_text(ind)
      lang = $game_variables[MessageTextDataBase::LANG_VARIABLE_ID]
      data = DataManager.log_database[ind]
      unless data
        tex = "ログテキストデータが不正かデータがありません。\n"
        tex += "番号：" + ind.to_s
        puts tex
        return [tex]
      end
      return puts "変数：" + lang.to_s + "に対応する言語のデータがありません。" unless data[lang]
      return convert_app_text(data[lang].dup)
    end
    
    #--------------------------------------------------------------------------
    # ● 制御文字の事前変換
    #    実際の描画を始める前に、原則として文字列に変わるものだけを置き換える。
    #    文字「\」はエスケープ文字（\e）に変換。
    #--------------------------------------------------------------------------
    def convert_escape_characters(text)
      result = text.to_s.clone
      result.gsub!(/\\/)            { "\e" }
      result.gsub!(/\e\e/)          { "\\" }
      result.gsub!(/\eV\[(\d+)\]/i) { $game_variables[$1.to_i] }
      result.gsub!(/\eV\[(\d+)\]/i) { $game_variables[$1.to_i] }
      result.gsub!(/\eN\[(\d+)\]/i) { actor_name($1.to_i) }
      result.gsub!(/\eP\[(\d+)\]/i) { party_member_name($1.to_i) }
      result.gsub!(/\eG/i)          { Vocab::currency_unit }
      result
    end
    #--------------------------------------------------------------------------
    # ● コモンテキストの取得と存在確認
    #--------------------------------------------------------------------------
    def pre_script_check(script_str)
      #２つ以上のコモンがある場合は考えない
      has_common = !script_str.index("$c").nil?
      $game_temp.instant_common_event_id = nil
      @controll_switch_val    = []
      @controll_variables_val = []
      script_str.gsub!(/\$v/){|w| "$game_variables"}
      script_str.gsub!(/\$s/){|w| "$game_switches"}
      script_str.gsub!(/\$c/){|w| "$game_temp.instant_exec_common"}
      script_str_arr = convert_app_text(script_str)
      script_str_arr.each{|str| eval(str)}
      return has_common
    end
    
    #--------------------------------------------------------------------------
    # ● テキストの最終コンバート
    #--------------------------------------------------------------------------
    def convert_app_text(text)
      text = text || ""
      return [""] if text == ""
      mch1 = text.match(/\"(.+)/)
      mch2 = mch1[1].match(/(.+)\"/) if mch1
      text = mch2 ? mch2[1] : mch1 ? mch1[1] : text
      text.gsub!(/(\&\$)/, "\"")
      arr = text.split("&#")
      return arr
    end
  end  
