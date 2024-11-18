#==============================================================================
# ■ Window_Base
#------------------------------------------------------------------------------
# 　ゲーム中の全てのウィンドウのスーパークラスです。
#==============================================================================

class Window_Base < Window
    #--------------------------------------------------------------------------
    # ● オブジェクト初期化
    #--------------------------------------------------------------------------
    def initialize(x, y, width, height)
        super
        self.windowskin = Cache.system("Window")
        update_padding
        update_tone
        create_contents
        @opening = @closing = false
    end
    #--------------------------------------------------------------------------
    # ● 解放
    #--------------------------------------------------------------------------
    def dispose
        contents.dispose unless disposed?
        super
    end
    #--------------------------------------------------------------------------
    # ● 行の高さを取得
    #--------------------------------------------------------------------------
    def line_height
        return 24
    end
    #--------------------------------------------------------------------------
    # ● 標準パディングサイズの取得
    #--------------------------------------------------------------------------
    def standard_padding
        return 12
    end
    #--------------------------------------------------------------------------
    # ● パディングの更新
    #--------------------------------------------------------------------------
    def update_padding
        self.padding = standard_padding
    end
    #--------------------------------------------------------------------------
    # ● ウィンドウ内容の幅を計算
    #--------------------------------------------------------------------------
    def contents_width
        width - standard_padding * 2
    end
    #--------------------------------------------------------------------------
    # ● ウィンドウ内容の高さを計算
    #--------------------------------------------------------------------------
    def contents_height
        height - standard_padding * 2
    end
    #--------------------------------------------------------------------------
    # ● 指定行数に適合するウィンドウの高さを計算
    #--------------------------------------------------------------------------
    def fitting_height(line_number)
        line_number * line_height + standard_padding * 2
    end
    #--------------------------------------------------------------------------
    # ● 色調の更新
    #--------------------------------------------------------------------------
    def update_tone
        self.tone.set($game_system.window_tone)
    end

    #--------------------------------------------------------------------------
    # ● ウィンドウ内容の作成
    #--------------------------------------------------------------------------
    def create_contents
        test5 = contents_width
        testf = contents_height
        # Debugging: Log the current types and values of contents_width and contents_height
        puts "Before disposing, contents width: #{contents_width}, height: #{contents_height}"
        puts "Before disposing, contents width type: #{contents_width.class}, height type: #{contents_height.class}"

        contents.dispose

        # Check for nil and ensure that contents_width and contents_height are integers
        if contents_width.nil? || contents_height.nil?
            puts "sadada disposing, contents width: #{contents_width}, height: #{contents_height}"
            puts "Warning: contents_width or contents_height is nil, setting default values."
            contents_width = 190  # Default width (you can adjust this to your needs)
            contents_height = 120  # Default height (you can adjust this to your needs)
        end

        # Ensure contents_width and contents_height are valid integers before proceeding
        # if contents_width.is_a?(Integer) && contents_height.is_a?(Integer)
            if contents_width > 0 && contents_height > 0
                # Limit height to a maximum of 2048 pixels
                # contents_height = 2048 if contents_height > 2048
                self.contents = Bitmap.new(contents_width, contents_height)
                puts "Created new bitmap with dimensions: #{contents_width} x #{contents_height}"
            else
                puts "Invalid dimensions: creating fallback 1x1 bitmap"
                self.contents = Bitmap.new(1, 1)
            end
        # else
        #     # If contents_width or contents_height are not valid integers, create a fallback 1x1 bitmap
        #     puts "Warning: Invalid types for contents width or height. Creating fallback 1x1 bitmap."
        #     self.contents = Bitmap.new(1, 1)
        # end
    end
    def create_contents
        # puts "vv Before disposing, contents width: #{contents_width}, height: #{contents_height}"
        # puts "vv Before disposing, contents width type: #{contents_width.class}, height type: #{contents_height.class}"
        contents.dispose
        # puts "Before disposing, contents width: #{contents_width}, height: #{contents_height}"
        # puts "Before disposing, contents width type: #{contents_width.class}, height type: #{contents_height.class}"

        # end
        if contents_height > 10000
            self.contents = Bitmap.new(1, 1)
        elsif contents_width > 0 && contents_height > 0
            self.contents = Bitmap.new(contents_width, contents_height)
            puts "Created new bitmap with dimensions: #{contents_width} x #{contents_height}"
        else
            self.contents = Bitmap.new(1, 1)
        end
    end
    #--------------------------------------------------------------------------
    # ● フレーム更新
    #--------------------------------------------------------------------------
    def update
        super
        update_tone
        update_open if @opening
        update_close if @closing
    end
    #--------------------------------------------------------------------------
    # ● 開く処理の更新
    #--------------------------------------------------------------------------
    def update_open
        self.openness += 48
        @opening = false if open?
    end
    #--------------------------------------------------------------------------
    # ● 閉じる処理の更新
    #--------------------------------------------------------------------------
    def update_close
        self.openness -= 48
        @closing = false if close?
    end
    #--------------------------------------------------------------------------
    # ● ウィンドウを開く
    #--------------------------------------------------------------------------
    def open
        @opening = true unless open?
        @closing = false
        self
    end
    #--------------------------------------------------------------------------
    # ● ウィンドウを閉じる
    #--------------------------------------------------------------------------
    def close
        @closing = true unless close?
        @opening = false
        self
    end
    #--------------------------------------------------------------------------
    # ● ウィンドウの表示
    #--------------------------------------------------------------------------
    def show
        self.visible = true
        self
    end
    #--------------------------------------------------------------------------
    # ● ウィンドウの非表示
    #--------------------------------------------------------------------------
    def hide
        self.visible = false
        self
    end
    #--------------------------------------------------------------------------
    # ● ウィンドウのアクティブ化
    #--------------------------------------------------------------------------
    def activate
        self.active = true
        self
    end
    #--------------------------------------------------------------------------
    # ● ウィンドウの非アクティブ化
    #--------------------------------------------------------------------------
    def deactivate
        self.active = false
        self
    end
    #--------------------------------------------------------------------------
    # ● 文字色取得
    #     n : 文字色番号（0..31）
    #--------------------------------------------------------------------------
    def text_color(n)
        windowskin.get_pixel(64 + (n % 8) * 8, 96 + (n / 8) * 8)
    end
    #--------------------------------------------------------------------------
    # ● 各種文字色の取得
    #--------------------------------------------------------------------------
    def normal_color;      text_color(0);   end;    # 通常
        def system_color;      text_color(16);  end;    # システム
            def crisis_color;      text_color(17);  end;    # ピンチ
                def knockout_color;    text_color(18);  end;    # 戦闘不能
                    def gauge_back_color;  text_color(19);  end;    # ゲージ背景
                        def hp_gauge_color1;   text_color(20);  end;    # HP ゲージ 1
                            def hp_gauge_color2;   text_color(21);  end;    # HP ゲージ 2
                                def mp_gauge_color1;   text_color(22);  end;    # MP ゲージ 1
                                    def mp_gauge_color2;   text_color(23);  end;    # MP ゲージ 2
                                        def mp_cost_color;     text_color(23);  end;    # 消費 TP
                                            def power_up_color;    text_color(24);  end;    # 装備 パワーアップ
                                                def power_down_color;  text_color(25);  end;    # 装備 パワーダウン
                                                    def tp_gauge_color1;   text_color(28);  end;    # TP ゲージ 1
                                                        def tp_gauge_color2;   text_color(29);  end;    # TP ゲージ 2
                                                            def tp_cost_color;     text_color(29);  end;    # 消費 TP
                                                                #--------------------------------------------------------------------------
                                                                # ● 保留項目の背景色を取得
                                                                #--------------------------------------------------------------------------
                                                                def pending_color
                                                                    windowskin.get_pixel(80, 80)
                                                                end
                                                                #--------------------------------------------------------------------------
                                                                # ● 半透明描画用のアルファ値を取得
                                                                #--------------------------------------------------------------------------
                                                                def translucent_alpha
                                                                    return 160
                                                                end
                                                                #--------------------------------------------------------------------------
                                                                # ● テキスト描画色の変更
                                                                #     enabled : 有効フラグ。false のとき半透明で描画
                                                                #--------------------------------------------------------------------------
                                                                def change_color(color, enabled = true)
                                                                    contents.font.color.set(color)
                                                                    contents.font.color.alpha = translucent_alpha unless enabled
                                                                end
                                                                #--------------------------------------------------------------------------
                                                                # ● テキストの描画
                                                                #     args : Bitmap#draw_text と同じ
                                                                #--------------------------------------------------------------------------
                                                                def draw_text(*args)
                                                                    contents.draw_text(*args)
                                                                end
                                                                #--------------------------------------------------------------------------
                                                                # ● テキストサイズの取得
                                                                #--------------------------------------------------------------------------
                                                                def text_size(str)
                                                                    contents.text_size(str)
                                                                end
                                                                #--------------------------------------------------------------------------
                                                                # ● 制御文字つきテキストの描画
                                                                #--------------------------------------------------------------------------
                                                                def draw_text_ex(x, y, text)
                                                                    reset_font_settings
                                                                    text = convert_escape_characters(text)
                                                                    pos = {:x => x, :y => y, :new_x => x, :height => calc_line_height(text)}
                                                                    process_character(text.slice!(0, 1), text, pos) until text.empty?
                                                                end
                                                                #--------------------------------------------------------------------------
                                                                # ● フォント設定のリセット
                                                                #--------------------------------------------------------------------------
                                                                def reset_font_settings
                                                                    change_color(normal_color)
                                                                    contents.font.size = Font.default_size
                                                                    contents.font.bold = false
                                                                    contents.font.italic = false
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
                                                                # ● アクター n 番の名前を取得
                                                                #--------------------------------------------------------------------------
                                                                def actor_name(n)
                                                                    actor = n >= 1 ? $game_actors[n] : nil
                                                                    actor ? actor.name : ""
                                                                end
                                                                #--------------------------------------------------------------------------
                                                                # ● パーティメンバー n 番の名前を取得
                                                                #--------------------------------------------------------------------------
                                                                def party_member_name(n)
                                                                    actor = n >= 1 ? $game_party.members[n - 1] : nil
                                                                    actor ? actor.name : ""
                                                                end
                                                                #--------------------------------------------------------------------------
                                                                # ● 文字の処理
                                                                #     c    : 文字
                                                                #     text : 描画処理中の文字列バッファ（必要なら破壊的に変更）
                                                                #     pos  : 描画位置 {:x, :y, :new_x, :height}
                                                                #--------------------------------------------------------------------------
                                                                def process_character(c, text, pos)
                                                                    case c
                                                                    when "\n"   # 改行
                                                                        process_new_line(text, pos)
                                                                    when "\f"   # 改ページ
                                                                        process_new_page(text, pos)
                                                                    when "\e"   # 制御文字
                                                                        process_escape_character(obtain_escape_code(text), text, pos)
                                                                    else        # 普通の文字
                                                                        process_normal_character(c, pos)
                                                                    end
                                                                end
                                                                #--------------------------------------------------------------------------
                                                                # ● 通常文字の処理
                                                                #--------------------------------------------------------------------------
                                                                def process_normal_character(c, pos)
                                                                    text_width = text_size(c).width
                                                                    draw_text(pos[:x], pos[:y], text_width * 2, pos[:height], c)
                                                                    pos[:x] += text_width
                                                                end
                                                                #--------------------------------------------------------------------------
                                                                # ● 改行文字の処理
                                                                #--------------------------------------------------------------------------
                                                                def process_new_line(text, pos)
                                                                    pos[:x] = pos[:new_x]
                                                                    pos[:y] += pos[:height]
                                                                    pos[:height] = calc_line_height(text)
                                                                end
                                                                #--------------------------------------------------------------------------
                                                                # ● 改ページ文字の処理
                                                                #--------------------------------------------------------------------------
                                                                def process_new_page(text, pos)
                                                                end
                                                                #--------------------------------------------------------------------------
                                                                # ● 制御文字の本体を破壊的に取得
                                                                #--------------------------------------------------------------------------
                                                                def obtain_escape_code(text)
                                                                    text.slice!(/^[\$\.\|\^!><\{\}\\]|^[A-Z]+/i)
                                                                end
                                                                #--------------------------------------------------------------------------
                                                                # ● 制御文字の引数を破壊的に取得
                                                                #--------------------------------------------------------------------------
                                                                def obtain_escape_param(text)
                                                                    text.slice!(/^\[\d+\]/)[/\d+/].to_i rescue 0
                                                                end
                                                                #--------------------------------------------------------------------------
                                                                        # ● 制御文字の処理
                                                                #     code : 制御文字の本体部分（「\C[1]」なら「C」）
                                                                #--------------------------------------------------------------------------
                                                                        def process_escape_character(code, text, pos)
                                                                case code.upcase
                                                                when 'C'
                                                                    change_color(text_color(obtain_escape_param(text)))
                                                                when 'I'
                                                                    process_draw_icon(obtain_escape_param(text), pos)
                                                                when '{'
                                                                       make_font_bigger
                                                                      when '}'
                                                                    make_font_smaller
                                                                end
                                                            end
                                                            #--------------------------------------------------------------------------
                                                                    # ● 制御文字によるアイコン描画の処理
                                                            #--------------------------------------------------------------------------
                                                                    def process_draw_icon(icon_index, pos)
                                                            draw_icon(icon_index, pos[:x], pos[:y])
                                                            pos[:x] += 24
                                                        end
                                                        #--------------------------------------------------------------------------
                                                                # ● フォントを大きくする
                                                        #--------------------------------------------------------------------------
                                                                def make_font_bigger
                                                        contents.font.size += 8 if contents.font.size <= 64
                                                    end
                                                    #--------------------------------------------------------------------------
                                                            # ● フォントを小さくする
                                                    #--------------------------------------------------------------------------
                                                            def make_font_smaller
                                                    contents.font.size -= 8 if contents.font.size >= 16
                                                end
                                                #--------------------------------------------------------------------------
                                                        # ● 行の高さを計算
                                                #     restore_font_size : 計算後にフォントサイズを元に戻す
                                                #--------------------------------------------------------------------------
                                                        def calc_line_height(text, restore_font_size = true)
                                                result = [line_height, contents.font.size].max
                                                last_font_size = contents.font.size
                                                text.slice(/^.*$/).scan(/\e[\{\}]/).each do |esc|
                                                    make_font_bigger  if esc == "\e{"
                                                    make_font_smaller if esc == "\e}"
                                                    result = [result, contents.font.size].max
                                                end
                                                contents.font.size = last_font_size if restore_font_size
                                                result
                                            end
                                            #--------------------------------------------------------------------------
                                            # ● ゲージの描画
                                            #     rate   : 割合（1.0 で満タン）
                                            #     color1 : グラデーション 左端
                                            #     color2 : グラデーション 右端
                                            #--------------------------------------------------------------------------
                                            def draw_gauge(x, y, width, rate, color1, color2)
                                                fill_w = (width * rate).to_i
                                                gauge_y = y + line_height - 8
                                                contents.fill_rect(x, gauge_y, width, 6, gauge_back_color)
                                                contents.gradient_fill_rect(x, gauge_y, fill_w, 6, color1, color2)
                                            end
                                            #--------------------------------------------------------------------------
                                            # ● アイコンの描画
                                            #     enabled : 有効フラグ。false のとき半透明で描画
                                            #--------------------------------------------------------------------------
                                            def draw_icon(icon_index, x, y, enabled = true)
                                                bitmap = Cache.system("Iconset")
                                                rect = Rect.new(icon_index % 16 * 24, icon_index / 16 * 24, 24, 24)
                                                contents.blt(x, y, bitmap, rect, enabled ? 255 : translucent_alpha)
                                            end
                                            #--------------------------------------------------------------------------
                                            # ● 顔グラフィックの描画
                                            #     enabled : 有効フラグ。false のとき半透明で描画
                                            #--------------------------------------------------------------------------
                                            def draw_face(face_name, face_index, x, y, enabled = true)
                                                bitmap = Cache.face(face_name)
                                                rect = Rect.new(face_index % 4 * 96, face_index / 4 * 96, 96, 96)
                                                contents.blt(x, y, bitmap, rect, enabled ? 255 : translucent_alpha)
                                                bitmap.dispose
                                            end
                                            #--------------------------------------------------------------------------
                                            # ● 歩行グラフィックの描画
                                            #--------------------------------------------------------------------------
                                            def draw_character(character_name, character_index, x, y)
                                                return unless character_name
                                                bitmap = Cache.character(character_name)
                                                sign = character_name[/^[\!\$]./]
                                                if sign && sign.include?('$')
                                                    cw = bitmap.width / 3
                                                    ch = bitmap.height / 4
                                                else
                                                    cw = bitmap.width / 12
                                                    ch = bitmap.height / 8
                                                end
                                                n = character_index
                                                src_rect = Rect.new((n%4*3+1)*cw, (n/4*4)*ch, cw, ch)
                                                contents.blt(x - cw / 2, y - ch, bitmap, src_rect)
                                            end
                                            #--------------------------------------------------------------------------
                                            # ● HP の文字色を取得
                                            #--------------------------------------------------------------------------
                                            def hp_color(actor)
                                                return knockout_color if actor.hp == 0
                                                return crisis_color if actor.hp < actor.mhp / 4
                                                return normal_color
                                            end
                                            #--------------------------------------------------------------------------
                                            # ● MP の文字色を取得
                                            #--------------------------------------------------------------------------
                                            def mp_color(actor)
                                                return crisis_color if actor.mp < actor.mmp / 4
                                                return normal_color
                                            end
                                            #--------------------------------------------------------------------------
                                            # ● TP の文字色を取得
                                            #--------------------------------------------------------------------------
                                            def tp_color(actor)
                                                return normal_color
                                            end
                                            #--------------------------------------------------------------------------
                                            # ● アクターの歩行グラフィック描画
                                            #--------------------------------------------------------------------------
                                            def draw_actor_graphic(actor, x, y)
                                                draw_character(actor.character_name, actor.character_index, x, y)
                                            end
                                            #--------------------------------------------------------------------------
                                            # ● アクターの顔グラフィック描画
                                            #--------------------------------------------------------------------------
                                            def draw_actor_face(actor, x, y, enabled = true)
                                                draw_face(actor.face_name, actor.face_index, x, y, enabled)
                                            end
                                            #--------------------------------------------------------------------------
                                            # ● 名前の描画
                                            #--------------------------------------------------------------------------
                                            def draw_actor_name(actor, x, y, width = 112)
                                                change_color(hp_color(actor))
                                                draw_text(x, y, width, line_height, actor.name)
                                            end
                                            #--------------------------------------------------------------------------
                                            # ● 職業の描画
                                            #--------------------------------------------------------------------------
                                            def draw_actor_class(actor, x, y, width = 112)
                                                change_color(normal_color)
                                                draw_text(x, y, width, line_height, actor.class.name)
                                            end
                                            #--------------------------------------------------------------------------
                                            # ● 二つ名の描画
                                            #--------------------------------------------------------------------------
                                            def draw_actor_nickname(actor, x, y, width = 180)
                                                change_color(normal_color)
                                                draw_text(x, y, width, line_height, actor.nickname)
                                            end
                                            #--------------------------------------------------------------------------
                                            # ● レベルの描画
                                            #--------------------------------------------------------------------------
                                            def draw_actor_level(actor, x, y)
                                                change_color(system_color)
                                                draw_text(x, y, 32, line_height, Vocab::level_a)
                                                change_color(normal_color)
                                                draw_text(x + 32, y, 24, line_height, actor.level, 2)
                                            end
                                            #--------------------------------------------------------------------------
                                            # ● ステートおよび強化／弱体のアイコンを描画
                                            #--------------------------------------------------------------------------
                                            def draw_actor_icons(actor, x, y, width = 96)
                                                icons = (actor.state_icons + actor.buff_icons)[0, width / 24]
                                                icons.each_with_index {|n, i| draw_icon(n, x + 24 * i, y) }
                                            end
                                            #--------------------------------------------------------------------------
                                            # ● 現在値／最大値を分数形式で描画
                                            #     current : 現在値
                                            #     max     : 最大値
                                            #     color1  : 現在値の色
                                            #     color2  : 最大値の色
                                            #--------------------------------------------------------------------------
                                            def draw_current_and_max_values(x, y, width, current, max, color1, color2)
                                                change_color(color1)
                                                xr = x + width
                                                if width < 96
                                                    draw_text(xr - 40, y, 42, line_height, current, 2)
                                                else
                                                    draw_text(xr - 92, y, 42, line_height, current, 2)
                                                    change_color(color2)
                                                    draw_text(xr - 52, y, 12, line_height, "/", 2)
                                                    draw_text(xr - 42, y, 42, line_height, max, 2)
                                                end
                                            end
                                            #--------------------------------------------------------------------------
                                            # ● HP の描画
                                            #--------------------------------------------------------------------------
                                            def draw_actor_hp(actor, x, y, width = 124)
                                                draw_gauge(x, y, width, actor.hp_rate, hp_gauge_color1, hp_gauge_color2)
                                                change_color(system_color)
                                                draw_text(x, y, 30, line_height, Vocab::hp_a)
                                                draw_current_and_max_values(x, y, width, actor.hp, actor.mhp,
                                                                            hp_color(actor), normal_color)
                                            end
                                            #--------------------------------------------------------------------------
                                            # ● MP の描画
                                            #--------------------------------------------------------------------------
                                            def draw_actor_mp(actor, x, y, width = 124)
                                                draw_gauge(x, y, width, actor.mp_rate, mp_gauge_color1, mp_gauge_color2)
                                                change_color(system_color)
                                                draw_text(x, y, 30, line_height, Vocab::mp_a)
                                                draw_current_and_max_values(x, y, width, actor.mp, actor.mmp,
                                                                            mp_color(actor), normal_color)
                                            end
                                            #--------------------------------------------------------------------------
                                            # ● TP の描画
                                            #--------------------------------------------------------------------------
                                            def draw_actor_tp(actor, x, y, width = 124)
                                                draw_gauge(x, y, width, actor.tp_rate, tp_gauge_color1, tp_gauge_color2)
                                                change_color(system_color)
                                                draw_text(x, y, 30, line_height, Vocab::tp_a)
                                                change_color(tp_color(actor))
                                                draw_text(x + width - 42, y, 42, line_height, actor.tp.to_i, 2)
                                            end
                                            #--------------------------------------------------------------------------
                                            # ● シンプルなステータスの描画
                                            #--------------------------------------------------------------------------
                                            def draw_actor_simple_status(actor, x, y)
                                                draw_actor_name(actor, x, y)
                                                draw_actor_level(actor, x, y + line_height * 1)
                                                draw_actor_icons(actor, x, y + line_height * 2)
                                                draw_actor_class(actor, x + 120, y)
                                                draw_actor_hp(actor, x + 120, y + line_height * 1)
                                                draw_actor_mp(actor, x + 120, y + line_height * 2)
                                            end
                                            #--------------------------------------------------------------------------
                                            # ● 能力値の描画
                                            #--------------------------------------------------------------------------
                                            def draw_actor_param(actor, x, y, param_id)
                                                change_color(system_color)
                                                draw_text(x, y, 120, line_height, Vocab::param(param_id))
                                                change_color(normal_color)
                                                draw_text(x + 120, y, 36, line_height, actor.param(param_id), 2)
                                            end
                                            #--------------------------------------------------------------------------
                                            # ● アイテム名の描画
                                            #     enabled : 有効フラグ。false のとき半透明で描画
                                            #--------------------------------------------------------------------------
                                            def draw_item_name(item, x, y, enabled = true, width = 172)
                                                return unless item
                                                draw_icon(item.icon_index, x, y, enabled)
                                                change_color(normal_color, enabled)
                                                draw_text(x + 24, y, width, line_height, item.name)
                                            end
                                            #--------------------------------------------------------------------------
                                            # ● 通貨単位つき数値（所持金など）の描画
                                            #--------------------------------------------------------------------------
                                            def draw_currency_value(value, unit, x, y, width)
                                                cx = text_size(unit).width
                                                change_color(normal_color)
                                                draw_text(x, y, width - cx - 2, line_height, value, 2)
                                                change_color(system_color)
                                                draw_text(x, y, width, line_height, unit, 2)
                                            end
                                            #--------------------------------------------------------------------------
                                            # ● 能力値変化の描画色取得
                                            #--------------------------------------------------------------------------
                                            def param_change_color(change)
                                                return power_up_color   if change > 0
                                                return power_down_color if change < 0
                                                return normal_color
                                            end
                                        end
