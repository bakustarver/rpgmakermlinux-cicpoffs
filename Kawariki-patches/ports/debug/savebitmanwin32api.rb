#==============================================================================
# ■ Audio
#==============================================================================
module Audio
    class << self
        #--------------------------------------------------------------------------
        # ● 基本初期化処理
        #--------------------------------------------------------------------------
        def init_basic
            bgm_stop
            bgs_stop
            @fiber_bgm = nil
            @fiber_bgs = nil
        end

        #--------------------------------------------------------------------------
        # ● 更新処理
        #--------------------------------------------------------------------------
        def update; end

            def alias_file_name(file_name)
                NWConst::Audio::AUDIO_ALIAS[file_name] || file_name
            end

            alias hima_alias_audio_bgm_play bgm_play
            def bgm_play(*args)
                args[0] = alias_file_name(args[0])
                hima_alias_audio_bgm_play(*args)
            end

            alias hima_alias_audio_me_play me_play
            def me_play(*args)
                args[0] = alias_file_name(args[0])
                hima_alias_audio_me_play(*args)
            end

            alias hima_alias_audio_se_play se_play
            def se_play(*args)
                args[0] = alias_file_name(args[0])
                hima_alias_audio_se_play(*args)
            end

            alias hima_alias_audio_bgs_play bgs_play
            def bgs_play(*args)
                args[0] = alias_file_name(args[0])
                hima_alias_audio_bgs_play(*args)
            end
        end
    end

    module BattleManager
        class << self
            #--------------------------------------------------------------------------
            # ○ セットアップ
            #--------------------------------------------------------------------------
            def setup(troop_id, can_escape = true, can_lose = false)
                init_members
                $game_troop.setup(troop_id)
                @can_escape = can_escape
                @can_lose = can_lose
                @troop_id = troop_id
                make_escape_ratio
                setup_terrain
                $game_temp.battle_init
            end

            def init_members
                @phase = :init              # 戦闘進行フェーズ
                @can_escape = false         # 逃走可能フラグ
                @can_lose = false           # 敗北可能フラグ
                @event_proc = nil           # イベント用コールバック
                @preemptive = false         # 先制攻撃フラグ
                @surprise = false           # 不意打ちフラグ
                @actor_index = -1           # コマンド入力中のアクター
                @action_forced = nil        # 戦闘行動の強制
                @map_bgm = nil              # 戦闘前の BGM 記憶用
                @map_bgs = nil              # 戦闘前の BGS 記憶用
                @action_battlers = []       # 行動順序リスト
                @action_game_masters = []   # 行動順序リスト（ＧＭ専用）
                @giveup = false             # 降参フラグ
                @giveup_count = 0           # 降参カウント
                @bind_count = 0             # 拘束カウント
                @terrain = :未定義 # 地形
                @troop_id = nil
                @fastest_action = nil
                @mimic_action_history = []
                @retry_data = nil
            end

            #--------------------------------------------------------------------------
            # ○ エンカウント時の処理
            #--------------------------------------------------------------------------
            def on_encounter
                @preemptive = (rand < rate_preemptive)
                @surprise = (rand < rate_surprise && !@preemptive)
                print "先制攻撃発動率#{(rate_preemptive * 100.0).to_i}%.先制#{@preemptive ? '成功' : '失敗'}。\n"
                print "不意打ち発動率#{(rate_surprise * 100.0).to_i}%.不意打ち#{@surprise ? '成功' : '失敗'}。\n"
            end

            #--------------------------------------------------------------------------
            # ○ 戦闘 BGM の演奏
            #--------------------------------------------------------------------------
            def play_battle_bgm
                $game_troop.battle_bgm.play unless bgm_same?($game_troop.battle_bgm)
                RPG::BGS.stop
            end

            #--------------------------------------------------------------------------
            # ● 初期フェイズ
            #--------------------------------------------------------------------------
            def init_phase
                @phase = :init
            end

            #--------------------------------------------------------------------------
            # ● 仲間入れ替えフェイズ
            #--------------------------------------------------------------------------
            def shift_change
                @phase = :shift_change
                $game_party.clear_actions
            end

            #--------------------------------------------------------------------------
            # ● 仲間入れ替えフェイズ?
            #--------------------------------------------------------------------------
            def shift_change?
                @phase == :shift_change
            end

            def battle_end?
                @phase.nil?
            end

            #--------------------------------------------------------------------------
            # ● 降参
            #--------------------------------------------------------------------------
            def giveup
                @giveup = true
                @giveup_count = 10
                $game_party.clear_actions
                $game_party.all_members.reject { |m| m.luca? }.each { |m| m.hide }
                ($game_party.all_members + $game_troop.alive_members).each { |m| m.clear_states }
                luca_index = 0
                $game_party.all_members.each_with_index do |actor, i|
                    luca_index = (actor.luca? ? i : luca_index)
                end
                $game_party.swap_order(0, luca_index)
            end

            #--------------------------------------------------------------------------
            # ● 降参中？
            #--------------------------------------------------------------------------
            def giveup?
                @giveup
            end

            #--------------------------------------------------------------------------
            # ● 降参カウントダウン
            #--------------------------------------------------------------------------
            def giveup_count_down
                @giveup_count -= 1
                @giveup_count == 0
            end

            #--------------------------------------------------------------------------
            # ● 拘束セット
            #--------------------------------------------------------------------------
            def bind_set(count)
                bind_reset
                @bind_count = count
                @bind_start_turn = $game_troop.turn_count
            end

            #--------------------------------------------------------------------------
            # ● 拘束ターン
            #--------------------------------------------------------------------------
            def binding_turn
                $game_troop.turn_count - @bind_start_turn
            end

            #--------------------------------------------------------------------------
            # ● 拘束カウントダウン
            #--------------------------------------------------------------------------
            def bind_count_down
                @bind_count -= 1
                bind_refresh
            end

            #--------------------------------------------------------------------------
            # ● 拘束リフレッシュ
            #--------------------------------------------------------------------------
            def bind_refresh
                bind_reset unless bind?
            end

            #--------------------------------------------------------------------------
            # ● 拘束発生中？
            #--------------------------------------------------------------------------
            def bind?
                0 != @bind_count && bind_user_exist? && bind_target_exist?
            end

            #--------------------------------------------------------------------------
            # ● 拘束状態のリセット
            #--------------------------------------------------------------------------
            def bind_reset
                $game_party.members.each { |m| m.clear_actions if m.bind_target? }
                $game_troop.members.each { |m| m.clear_actions if m.bind_user? }
                @bind_count = 0
                $game_troop.members.each do |m|
                    m.remove_state(NWConst::State::UBIND)
                    m.remove_state(NWConst::State::EUBIND)
                end
                $game_party.members.each do |m|
                    m.remove_state(NWConst::State::TBIND)
                    m.remove_state(NWConst::State::ETBIND)
                end
            end

            #--------------------------------------------------------------------------
            # ● 拘束技使用者は存在する？
            #--------------------------------------------------------------------------
            def bind_user_exist?
                $game_troop.members.any? { |m| m.bind_user? }
            end

            #--------------------------------------------------------------------------
            # ● 拘束技対象は存在する？
            #--------------------------------------------------------------------------
            def bind_target_exist?
                $game_party.members.any? { |m| m.bind_target? }
            end

            #--------------------------------------------------------------------------
            # ● 拘束技使用者のインデックス
            #--------------------------------------------------------------------------
            def bind_user_index
                $game_troop.members.each_with_index do |member, i|
                    return i if member.bind_user?
                end
                -1
            end

            #--------------------------------------------------------------------------
            # ○ 逃走成功率の作成
            #--------------------------------------------------------------------------
            def make_escape_ratio
                lv = 0
                lv = if $game_party.in_member_luca?
                $game_actors[NWConst::Actor::LUCA].base_level
            else
                $game_party.all_members.map(&:base_level).max
            end
            escape_level = $game_troop.escape_level_max
            @escape_ratio = lv >= escape_level ? 1.0 : (1.0 / (escape_level - lv + 1))
        end

        #--------------------------------------------------------------------------
        # ● 戦闘地形の設定
        #--------------------------------------------------------------------------
        def setup_terrain
            NWConst::Field::TERRAIN.each do |key, value|
                next if value[:tag] != $game_player.terrain_tag && !value[:map_id].include?($game_map.map_id)

                @terrain = key
                break
            end
        end

        #--------------------------------------------------------------------------
        # ● 戦闘地形の取得
        #--------------------------------------------------------------------------
        attr_reader :terrain

        #--------------------------------------------------------------------------
        # ○ 逃走許可の取得
        #--------------------------------------------------------------------------
        def can_escape?
            @can_escape && !bind? && !$game_troop.challenge_battle?
        end

        #--------------------------------------------------------------------------
        # ○ 戦闘開始
        #--------------------------------------------------------------------------
        def battle_start
            @retry_data = Marshal.dump(DataManager.make_save_contents)
            $game_variables[NWConst::Var::BATTLE_END_TURN] = 0
            $game_temp.reserve_common_event(NWConst::Common::BATTLE_START)
            $game_party.on_battle_start
            $game_troop.on_battle_start
            $game_troop.enemy_names.each do |name|
                $game_message.add(format(Vocab::Emerge, name))
            end
            tmp = []
            $game_troop.members.each { |enemy| tmp.push(enemy.id) if enemy }
            $game_library.enemy.set_discovery(tmp)
            if @preemptive
                $game_message.add(format(Vocab::Preemptive, $game_party.name))
            elsif @surprise
                $game_message.add(format(Vocab::Surprise, $game_party.name))
            end
            wait_for_message
        end

        #--------------------------------------------------------------------------
        # ● 好感度上昇
        #--------------------------------------------------------------------------
        def gain_love
            $game_party.battle_members.select do |member|
                !member.luca?
            end.each do |member|
                member.love += $game_variables[NWConst::Var::BATTLE_END_GAIN_LOVE]
            end
        end

        #--------------------------------------------------------------------------
        # ○ 逃走の処理
        #--------------------------------------------------------------------------
        def process_escape
            $game_message.add(format(Vocab::EscapeStart, $game_party.name))
            success = @preemptive ? true : (rand < @escape_ratio)
            Sound.play_escape
            if success
                process_abort
            else
                $game_message.add('\.' + Vocab::EscapeFailure)
                $game_party.clear_actions
            end
            wait_for_message
            success
        end

        #--------------------------------------------------------------------------
        # ● 強制逃走の処理
        #--------------------------------------------------------------------------
        def process_forced_escape
            $game_message.add(format(Vocab::EscapeStart, $game_party.name))
            Sound.play_escape
            if can_forced_escape?
                process_abort
            else
                $game_message.add('\.' + Vocab::EscapeFailure)
            end
            wait_for_message
        end

        #--------------------------------------------------------------------------
        # ● 強制逃走が可能か
        #--------------------------------------------------------------------------
        def can_forced_escape?
            can_escape? and !($game_switches[NWConst::Sw::STRICT_ENCOUNT])
        end

        #--------------------------------------------------------------------------
        # ● プレイヤのリセット
        #--------------------------------------------------------------------------
        def reset_player
            $game_player.transparent = true
            $game_player.followers.visible = false
            $game_player.moveto(0, 0)
            $game_player.refresh
        end

        #--------------------------------------------------------------------------
        # ● スキップ不能か
        #--------------------------------------------------------------------------
        def no_lose_skip?
            enemy_id = $game_troop.lose_event_id - NWConst::Common::LOSE_EVENT_BASE
            return true if enemy_id == 0 # LOSE_EVENT_BASEを直接実行=混沌の迷宮エネミー
            return true if $data_enemies[enemy_id].no_lose_skip?

            false
        end

        #--------------------------------------------------------------------------
        # ○ 戦闘終了
        #     result : 結果（0:勝利 1:逃走 2:敗北）
        #--------------------------------------------------------------------------
        def battle_end(result)
            @phase = nil
            @giveup = false
            @event_proc.call(result) if @event_proc
            $game_temp.reserve_common_event(NWConst::Common::BATTLE_END)
            $game_party.on_battle_end
            $game_troop.on_battle_end
            SceneManager.exit if $BTEST
            $game_temp.battle_init
            @retry_data = nil unless result == 2
        end

        #--------------------------------------------------------------------------
        # ○ 獲得した経験値の表示
        #--------------------------------------------------------------------------
        def display_exp
            if $game_troop.exp_total > 0
                text = format(Vocab::ObtainExp, $game_troop.exp_total)
                $game_message.add('\.' + text)
            end
            if $game_troop.class_exp_total > 0
                text2 = format(Vocab::ObtainJobExp, $game_troop.class_exp_total)
                $game_message.add('\.' + text2)
            end
        end

        #--------------------------------------------------------------------------
        # ○ 経験値の獲得とレベルアップの表示
        #--------------------------------------------------------------------------
        def gain_exp
            $game_party.all_members.each do |actor|
                actor.gain_exp($game_troop.exp_total, $game_troop.class_exp_total)
            end
            wait_for_message
        end

        #--------------------------------------------------------------------------
        # ● ドロップアイテムの獲得と表示 【再定義】
        #--------------------------------------------------------------------------
        def gain_drop_items
            $game_temp.clear_get_item

            $game_troop.make_drop_items.each do |item|
                $game_party.gain_item(item, 1)
            end

            $game_temp.get_item_data.each do |item, value|
                value.times do
                    $game_message.add(Vocab.item_get_message(item, 1))
                end
            end

            wait_for_message
        end

        def turn_start
            @phase = :turn
            @mimic_action_history = []
            clear_actor
            $game_party.set_action_history
            $game_party.check_change_action
            $game_troop.increase_turn
            make_action_orders
        end

        def setup_auto_skill?
            !giveup? || $game_party.in_battle || !$game_troop.interpreter.running?
        end

        def set_battle_start_skill
            set_auto_skill(&:battle_start_skill)
        end

        def set_turn_start_skill
            set_auto_skill(&:turn_start_skill)
        end

        def set_turn_end_skill
            set_auto_skill(&:turn_end_skill)
            set_turn_end_revive
        end

        def counter_skill(battler)
            auto_skill_per(battler.counter_skill, battler)
        end

        def set_auto_skill
            @action_game_masters = []
            return unless setup_auto_skill?

            members = ($game_troop.alive_members + $game_party.alive_members).select(&:enable_action?).reject(&:cant_move?)
            members.each do |member|
                skills = yield member
                auto_skills_per(skills, member).reverse_each do |skill|
                    act = skill_interrupt(member, skill)
                    act.target_index = member.index if act && act.object && act.object.scope == 7
                end
            end
        end

        def auto_skills_per(skills, battler)
            r = _auto_skill_per(skills, battler).group_by do |skill|
                skill.fetch(:priority, 99)
            end
            r.sort_by { |k, _| k }.map do |_, ss|
                ss.sample.fetch(:id)
            end
        end

        def auto_skill_per(skills, battler)
            _auto_skill_per(skills, battler).map { |s| s.fetch(:id) }.sample
        end

        def _auto_skill_per(skills, battler)
            skills.select do |obj|
                if obj[:condition_type]
                    next false unless battler.skill_race_ok?($data_skills[obj[:id]])

                    result = case obj[:condition_type]
                when 1
                    members = $game_party.battle_members_id
                    obj[:condition_ids].any? { |id| members.include?($game_actors.original_id(id)) }
                when 2
                    members = $game_troop.members.map(&:id)
                    obj[:condition_ids].any? { |id| members.include?(id) }
                when 3
                    members = $game_party.battle_members
                    obj[:condition_ids].any? { |id| members.any? { |m| m.state?(id) } }
                when 4
                    members = $game_troop.members
                    obj[:condition_ids].any? { |id| members.any? { |m| m.state?(id) } }
                when 5
                    obj[:condition_ids].any? { |id| battler.state?(id) }
                else
                    true
                end
                next false unless result
            end
            rand < obj[:per]
        end
    end

    def set_dead_skill(battler)
        return unless setup_auto_skill?

        battler.dead_skill.each do |skill|
            skill_interrupt(battler, skill, :dead_skill)
        end
    end

    def set_final_invoke(battler)
        return unless setup_auto_skill?

        battler.final_invoke.each do |skill|
            skill_interrupt(battler, skill, :final_invoke)
        end
    end

    #--------------------------------------------------------------------------
    # ○ 戦闘回想かどうか
    #--------------------------------------------------------------------------
    def memory_battle?
        $game_temp.in_memory_battle
    end

    #--------------------------------------------------------------------------
    # ○ 経験値を入手可能か
    #--------------------------------------------------------------------------
    def enable_get_exp?
        return false if memory_battle?
        return false if $game_switches[NWConst::Sw::GET_DISABLE_EXP_DROP]
        return false if $game_switches[NWConst::Sw::GET_DISABLE_EXP]

        true
    end

    #--------------------------------------------------------------------------
    # ○ ゴールドを入手可能か
    #--------------------------------------------------------------------------
    def enable_get_gold?
        return false if memory_battle?
        return false if $game_switches[NWConst::Sw::GET_DISABLE_GOLD]

        true
    end

    #--------------------------------------------------------------------------
    # ○ ドロップアイテムを入手可能か
    #--------------------------------------------------------------------------
    def enable_get_drop?
        return false if memory_battle?
        return false if $game_switches[NWConst::Sw::GET_DISABLE_EXP_DROP]
        return false if $game_switches[NWConst::Sw::GET_DISABLE_DROP]

        true
    end

    #--------------------------------------------------------------------------
    # ○ 敗北カウントを行うか
    #--------------------------------------------------------------------------
    def enable_party_lose_count?
        $game_troop.members.each do |enemy|
            return false if enemy.enemy.no_lose_skip?
        end
        true
    end

    def play_battle_end_me
        $game_system.battle_end_me.play unless bgm_same?($game_troop.battle_bgm)
    end

    #--------------------------------------------------------------------------
    # ○ 勝利の処理
    #--------------------------------------------------------------------------
    def process_victory
        @phase = nil
        $game_variables[NWConst::Var::BATTLE_END_TURN] = $game_troop.turn_count
        play_battle_end_me
        replay_bgm_and_bgs
        $game_temp.in_victory_message = true
        $game_message.add(format(Vocab::Victory, $game_party.name))
        display_exp     if enable_get_exp?
        gain_gold       if enable_get_gold?
        gain_drop_items if enable_get_drop?
        gain_exp        if enable_get_exp?
        gain_love
        process_follow unless memory_battle?
        wait_for_message if memory_battle?
        $game_temp.in_victory_message = false
        SceneManager.return
        battle_end(0)
        DataManager.auto_save_game if !memory_battle? && !@event_proc
        true
    end

    #--------------------------------------------------------------------------
    # ○ 敗北の処理 ベース/Module
    #--------------------------------------------------------------------------
    def process_defeat
        @phase = nil
        SceneManager.scene.process_common_event_on_defeat if $game_temp.common_event_reserved?
        $game_message.add(format(Vocab::Defeat, $game_party.name))
        wait_for_message
        if @can_lose
            revive_battle_members
            replay_bgm_and_bgs
            SceneManager.return
        else
            # 通常のゲームオーバーは完全排除
            Audio.bgm_stop
            Audio.bgs_stop
            revive_battle_members
            unless memory_battle?
                $game_map.interpreter.clear
                reset_player
            end
            change_novel_scene
        end
        battle_end(2)
        true
    end

    #--------------------------------------------------------------------------
    # ● ノベルパートへの移行
    #--------------------------------------------------------------------------
    def change_novel_scene
        unless memory_battle?
            SceneManager.clear
            SceneManager.push(Scene_Map)
        end
        $game_novel.setup($game_troop.lose_event_id)
        SceneManager.goto(Scene_Novel)

        skip_flag = $game_system.conf[:ls_skip] == 1
        skip_flag &&= $game_library.lose_event_view?($game_novel.event_id)
        check_flag = $game_system.conf[:ls_skip] == 2
        choice = -1
        if no_lose_skip?
            skip_flag  = false
            check_flag = false
        end
        if check_flag
            $game_message.add("Skip defeat scene?")
            ["Yes", "No"].each { |s| $game_message.choices.push(s) }
            $game_message.choice_cancel_type = 2
            $game_message.choice_proc = proc { |n| choice = n }
            wait_for_message
        end
        if no_lose_skip? and memory_battle?
            $game_novel.interpreter.memory_interruption
        elsif skip_flag || (choice == 0)
            $game_novel.interpreter.goto_ilias
        end
    end

    def follower_disable?
        $game_switches[NWConst::Sw::FOLLOWER_DISABLE_1] || $game_switches[NWConst::Sw::FOLLOWER_DISABLE_2] || ($game_party.temp_actors_use? && !$game_party.multi_party?)
    end

    #--------------------------------------------------------------------------
    # ● 仲間化の処理
    #--------------------------------------------------------------------------
    def process_follow
        return if follower_disable?

        $game_troop.check_getup
        return unless $game_troop.follower_enemy

        if NWConst::Follow::SPECIAL.include?($game_troop.follower_enemy.id)
            send("process_follow_enemy#{$game_troop.follower_enemy.id}".to_sym)
        else
            process_follow_normal
        end
    end

    #--------------------------------------------------------------------------
    # ● 仲間加入時の質問処理
    #--------------------------------------------------------------------------
    def process_follow_question
        e = $game_troop.follower_enemy
        e.follow_question_word.execute
        wait_for_message
    end

    #--------------------------------------------------------------------------
    # ● 仲間加入時の選択肢処理
    #--------------------------------------------------------------------------
    def process_follow_choice(follower_name = nil)
        e = $game_troop.follower_enemy
        follower_name ||= e.original_name
        $game_message.add("#{follower_name} manages to rise back up.")
        $game_message.add("She looks like she wants to join your party!\f")
        $game_message.add("Add her as a companion?")
        choice = 0
        ["Yes", "No"].each { |s| $game_message.choices.push(s) }
        $game_message.choice_cancel_type = 2
        $game_message.choice_proc = proc { |n| choice = n }
        wait_for_message

        choice == 0
    end

    #--------------------------------------------------------------------------
    # ● 仲間加入時の承諾処理
    #--------------------------------------------------------------------------
    def process_follow_ok(follower_name = nil)
        e = $game_troop.follower_enemy
        follower_name ||= e.original_name
        e.follow_yes_word.execute
        wait_for_message
        $game_message.add("#{follower_name} has joined the party!")
        if $game_party.multi_party?
            $game_message.add("#{wait_member_name} heads back to the pocket castle!")
            $game_party.add_stand_actor(e.follower_actor_id)
            $game_temp.getup_enemy = e.follower_actor_id
            wait_for_message
            return
        end
        wait_for_message
        process_follow_ok_member_full(e.follower_actor_id, follower_name) if $game_party.party_member_full?
        # 仲間になったエネミーを保存
        $game_actors[e.follower_actor_id].setup(e.follower_actor_id)
        $game_party.add_actor(e.follower_actor_id)
        $game_temp.getup_enemy = e.follower_actor_id
    end

    #--------------------------------------------------------------------------
    # ● パーティ満員時の選択
    #--------------------------------------------------------------------------
    def process_follow_ok_member_full(follower_id, follower_name = nil)
        $game_message.add("The party is full.")
        $game_message.add("Please choose a member to remove from the party.")
        wait_for_message
        stand_actor = $game_party.choice_stand_actor_on_member_full(follower_id, follower_name)
        $game_party.move_stand_actor(stand_actor.id) if stand_actor
        wait_member_name = stand_actor ? stand_actor.name : follower_name
        $game_message.add("#{wait_member_name} heads back to the pocket castle!")
        wait_for_message
    end

    #--------------------------------------------------------------------------
    # ● 仲間加入時の拒否処理
    #--------------------------------------------------------------------------
    def process_follow_no
        e = $game_troop.follower_enemy
        e.follow_no_word.execute
        wait_for_message
    end

    #--------------------------------------------------------------------------
    # ● 仲間加入時の去る処理
    #--------------------------------------------------------------------------
    def process_follow_bye(follower_name = nil)
        e = $game_troop.follower_enemy
        follower_name ||= e.original_name
        $game_troop.follower_enemy = nil
        $game_message.add("#{follower_name} sulks away...")
        wait_for_message
    end

    #--------------------------------------------------------------------------
    # ● 仲間加入時演出（通常パターン）
    #--------------------------------------------------------------------------
    def process_follow_normal
        process_follow_question
        if process_follow_choice
            process_follow_ok
        else
            process_follow_no
            process_follow_bye
        end
    end

    #--------------------------------------------------------------------------
    # ● ピクチャーの簡易操作
    #--------------------------------------------------------------------------
    def pic_easy_setup(num, name, x, y)
        name = "../Battlers/#{name}"
        $game_troop.screen.pictures[num].easy_setup(name, x, y)
    end

    def pic_easy_appear_move(num, x, y)
        $game_troop.screen.pictures[num].easy_appear_move(x, y)
    end

    def pic_easy_appear(num)
        $game_troop.screen.pictures[num].easy_appear
    end

    def pic_easy_erase(num)
        $game_troop.screen.pictures[num].easy_erase
    end

    #--------------------------------------------------------------------------
    # ● ピクチャーの表示
    #--------------------------------------------------------------------------
    def pic_show(num, name, ori, x, y, zx, zy, op, bl)
        name = "../Battlers/#{name}"
        $game_troop.screen.pictures[num].show(name, ori, x, y, zx, zy, op, bl)
    end

    #--------------------------------------------------------------------------
    # ● ピクチャーの移動
    #--------------------------------------------------------------------------
    def pic_move(num, ori, x, y, zx, zy, op, bl, dur)
        $game_troop.screen.pictures[num].move(ori, x, y, zx, zy, op, bl, dur)
    end

    #--------------------------------------------------------------------------
    # ● ピクチャーのクリア
    #--------------------------------------------------------------------------
    def pic_clear
        $game_troop.screen.clear_pictures
    end

    def skill_combo(battler, action, base_action)
        action.set_symbol(:skill_combo)
        return unless base_action.skill_combo_enable?(action)

        action.combo_setting(base_action)
        battler.actions << action
        @action_battlers.unshift(action)
    end

    #--------------------------------------------------------------------------
    # ○ 次の行動主体の取得
    #    行動順序リストの先頭からバトラーを取得する。
    #    現在パーティにいないアクターを取得した場合（index が nil, バトルイベ
    #    ントでの離脱直後などに発生）は、それをスキップする。
    #--------------------------------------------------------------------------
    def next_subject
        if gm_exist?
            subject = @action_game_masters.shift
            return battler(subject)
        end

        loop do
            subject = @action_battlers.shift
            return nil unless subject

            battler = battler(subject)
            next unless battler.index

            return battler
        end
    end

    #--------------------------------------------------------------------------
    # ○ 勝敗判定
    #--------------------------------------------------------------------------
    def judge_win_loss
        if @phase && !gm_exist?
            return process_abort   if $game_party.members.empty?
            return process_defeat  if $game_party.all_dead?
            return process_victory if $game_troop.all_dead?
            return process_abort   if aborting?
        end
        false
    end

    #--------------------------------------------------------------------------
    # ● ＧＭアクションが存在する？
    #--------------------------------------------------------------------------
    def gm_exist?
        !@action_game_masters.empty?
    end

    #--------------------------------------------------------------------------
    # ○ BGM と BGS の再開
    #--------------------------------------------------------------------------
    def replay_bgm_and_bgs
        @map_bgm.replay unless $BTEST || bgm_same?(RPG::BGM.last)
        @map_bgs.replay unless $BTEST
        $game_map.autoplay_field if $game_map.auto_bgm?
    end

    def skill_interrupt(battler, skill_id, symbol = :interrupt)
        return unless battler.skill_race_ok?($data_skills[skill_id])

        battler = Game_Master.new(battler)
        action = battler.skill_interrupt(skill_id, symbol)
        @action_game_masters.unshift(action)
        action
    end

    def make_action_orders
        ab = []
        ab += $game_troop.members unless @preemptive
        ab += $game_party.members unless @surprise
        ab.each(&:make_speed)
        i = 0

        @action_battlers = ab.map { |b| b.actions }.flatten.compact
        @action_battlers.sort_by! { |v| [v, i += 1] }
        @action_battlers += ab.select { |m| m.actions.empty? }.shuffle
        @fastest_action = @action_battlers.first
    end

    def delete_action(subject)
        @action_battlers.reject! { |ab| battler(ab) == subject }
    end

    def battler(obj)
        return nil unless obj

        if obj.action?
            obj.subject.current_action_index = obj
            obj.subject
        else
            obj.current_action_index = nil
            obj
        end
    end

    def force_action(battler)
        @action_forced = battler
        delete_action(battler)
    end

    def bgm_same?(bgm)
        return false unless @map_bgm

        @map_bgm.name == bgm.name && @map_bgm.volume == bgm.volume && @map_bgm.pitch == bgm.pitch
    end

    def can_giveup?
        return false if $game_switches[NWConst::Sw::INVALID_GIVEUP]
        return false if $game_troop.challenge_battle?

        $game_party.all_members.any? { |member| member.luca? } && $game_actors[NWConst::Actor::LUCA].exist?
    end

    def set_turn_end_revive
        return if giveup? || !$game_party.in_battle || $game_troop.interpreter.running?

        members = ($game_troop.dead_members + $game_party.dead_members).select(&:turn_end_revive?)
        members.each do |member|
            skill_interrupt(member, TURN_END_REVIVE_SKILL.id)
        end
    end

    def skill_chain(battler, base_action)
        action = base_action.chain_action
        return if action.nil?

        battler.actions << action
        @action_battlers.unshift(action)
    end

    def add_mimic_history(action)
        return if action.nil? || action.symbol != :count

        @mimic_action_history << action
    end

    def interrupt_mimic(batller)
        mimic_skills(battler).reverse_each do |skill_id|
            skill_interrupt(batller, skill_id, :mimic)
        end
    end

    def interrupt_super_mimic(battler)
        super_mimic_skills(battler).reverse_each do |skill_id|
            skill_interrupt(battler, skill_id, :mimic)
        end
    end

    def mimic_skills(action)
        m = mimic_items.last
        return [] if m.nil? || !action.subject.mimic_usable?(m)

        [m.id]
    end

    def super_mimic_skills(battler)
        items = mimic_items.select do |a|
            battler.mimic_usable?(a)
        end
        items.map(&:id)
    end

    def mimic_items
        @mimic_action_history.map(&:object).compact
    end

    def evasion_skill(battler)
        auto_skill_per(battler.evasion_skill, battler)
    end

    def interrupt_evasion_skill
        members = ($game_troop.alive_members + $game_party.alive_members).select(&:enable_action?).reject(&:cant_move?)
        members.select(&:evasion_action).each do |member|
            act = member.evasion_action
            bact = skill_interrupt(member, act.object.id)
            bact.target_index = act.target_index if bact
            member.clear_evasion_action
        end
    end

    def fastest_action?(action)
        return false unless $game_party.in_battle

        @fastest_action == action
    end

    def latest?
        return false unless $game_party.in_battle

        @action_battlers.select(&:action?).select { |a| a.symbol == :count }.empty?
    end

    def retry_battle
        return if $game_party.in_battle || @retry_data.nil?

        SceneManager.push(Scene_Battle)
        bgm = @map_bgm
        bgs = @map_bgs
        DataManager.extract_save_contents(Marshal.load(@retry_data))
        setup(@troop_id, @can_escape, @can_lose)
        play_battle_bgm
        @map_bgm = bgm
        @map_bgs = bgs
        true
    end
end
end

module Cache
    class << self
        alias h_normal_bitmap normal_bitmap
        def normal_bitmap(path)
            check_filesize
            h_normal_bitmap(path)
        end

        alias h_hue_changed_bitmap hue_changed_bitmap
        def hue_changed_bitmap(path, hue)
            check_filesize
            h_hue_changed_bitmap(path, hue)
        end

        def check_filesize
            clear if @cache.size > 600
        end
    end
end

#==============================================================================
# ■ DataManager
#==============================================================================
module DataManager
    class << self
        #--------------------------------------------------------------------------
        # ○ データベースのロード
        #--------------------------------------------------------------------------
        def load_database
            if $BTEST
                load_battle_test_database
            else
                load_normal_database
                check_player_location
            end
            $data_library = Data_Library.new
        end

        #--------------------------------------------------------------------------
        # ○ 各種ゲームオブジェクトの作成
        #--------------------------------------------------------------------------
        def create_game_objects
            $game_temp          = Game_Temp.new
            $game_system        = Game_System.new
            $game_timer         = Game_Timer.new
            $game_message       = Game_Message.new
            $game_switches      = Game_Switches.new
            $game_variables     = Game_Variables.new
            $game_self_switches = Game_SelfSwitches.new
            $game_actors        = Game_Actors.new
            $game_party         = Game_Party.new
            $game_troop         = Game_Troop.new
            $game_map           = Game_Map.new
            $game_player        = Game_Player.new
            $game_novel         = Game_Novel.new
            $game_poker         = Game_Poker.new
            $game_slot          = Game_Slot.new
        end

        #--------------------------------------------------------------------------
        # ○ 戦闘テストのセットアップ
        #--------------------------------------------------------------------------
        def setup_battle_test
            $game_map.setup($data_system.start_map_id)
            $game_party.setup_battle_test
            BattleManager.setup($data_system.test_troop_id)
            BattleManager.play_battle_bgm
        end

        #--------------------------------------------------------------------------
        # ○ セーブ内容の作成
        #--------------------------------------------------------------------------
        def make_save_contents
            contents = {}
            contents[:system]        = $game_system
            contents[:timer]         = $game_timer
            contents[:message]       = $game_message
            contents[:switches]      = $game_switches
            contents[:variables]     = $game_variables
            contents[:self_switches] = $game_self_switches
            contents[:actors]        = $game_actors
            contents[:party]         = $game_party
            contents[:troop]         = $game_troop
            contents[:map]           = $game_map
            contents[:player]        = $game_player
            contents[:novel]         = $game_novel
            contents
        end

        #--------------------------------------------------------------------------
        # ○ セーブ内容の展開
        #--------------------------------------------------------------------------
        def extract_save_contents(contents)
            $game_system        = contents[:system]
            $game_timer         = contents[:timer]
            $game_message       = contents[:message]
            $game_switches      = contents[:switches]
            $game_variables     = contents[:variables]
            $game_self_switches = contents[:self_switches]
            $game_actors        = contents[:actors]
            $game_party         = contents[:party]
            $game_troop         = contents[:troop]
            $game_map           = contents[:map]
            $game_player        = contents[:player]
            $game_novel         = contents[:novel]
        end

        #--------------------------------------------------------------------------
        # ● ロードの実行（例外処理なし）
        #--------------------------------------------------------------------------
        def load_game_without_rescue(index)
            File.open(make_filename(index), "rb") do |file|
                Marshal.load(file)
                extract_save_contents(Marshal.load(file))
                update
                reload_map_if_updated
                @last_savefile_index = index.is_a?(Integer) ? index : 0
            end
            true
        end

        #--------------------------------------------------------------------------
        # ○ モジュール初期化
        #--------------------------------------------------------------------------
        def init
            @last_savefile_index = 0
            create_game_objects
            setup_battle_test if $BTEST
        end

        #--------------------------------------------------------------------------
        # ● システムバックアップファイル名の取得
        #--------------------------------------------------------------------------
        def system_backup_filename
            "Save/SystemSaveBackup.rvdata2"
        end

        #--------------------------------------------------------------------------
        # ● システムデータの初期化
        #--------------------------------------------------------------------------
        def setup_system
            return if system_object_exist?

            if system_file_exist?
                load_system
                fix_system
            else
                create_system_objects
                save_system
            end
            $game_library.make_preparation_list
        end

        def fix_system
            $game_global_system.fix
        end

        #--------------------------------------------------------------------------
        # ● システムオブジェクトが存在する？
        #--------------------------------------------------------------------------
        def system_object_exist?
            ($game_library && $game_system_switches)
        end

        #--------------------------------------------------------------------------
        # ● システムバックアップセーブの実行（例外処理なし）
        #--------------------------------------------------------------------------
        def save_system_backup_without_rescue
            File.open(system_backup_filename, "wb") do |file|
                Marshal.dump(make_system_save_contents, file)
            end
            true
        end

        #--------------------------------------------------------------------------
        # ● システムセーブ内容の作成
        #--------------------------------------------------------------------------
        def make_system_save_contents
            contents = {}
            contents[:system_save_count]  = @system_save_count
            contents[:library]            = $game_library
            contents[:system_switches]    = $game_system_switches
            contents[:global_system]      = $game_global_system
            contents
        end

        #--------------------------------------------------------------------------
        # ● システムセーブ内容の展開
        #--------------------------------------------------------------------------
        def extract_system_save_contents(contents)
            @system_save_count    = contents[:system_save_count].nil? ? 0 : contents[:system_save_count]
            $game_library         = contents[:library].nil? ? Game_Library.new : contents[:library]
            $game_system_switches = contents[:system_switches].nil? ? Game_SystemSwitches.new : contents[:system_switches]
            $game_global_system = contents[:global_system]
            if $game_global_system.nil?
                $game_global_system = Global::Game_System.new
                save_system
            end
        end

        #--------------------------------------------------------------------------
        # ● 各種システムオブジェクトの作成
        #--------------------------------------------------------------------------
        def create_system_objects
            p "システムオブジェクトの生成" if $TEST
            @system_save_count    = 0
            $game_library         = Game_Library.new
            $game_system_switches = Game_SystemSwitches.new
            $game_global_system = Global::Game_System.new
        end

        #--------------------------------------------------------------------------
        # ○ セーブファイルの存在判定
        #--------------------------------------------------------------------------
        def save_file_exists?
            !Dir.glob("Save/Save*.rvdata2").empty?
        end

        #--------------------------------------------------------------------------
        # ○ セーブファイルの最大数
        #--------------------------------------------------------------------------
        def savefile_max
            99
        end

        #--------------------------------------------------------------------------
        # ● ファイル名の作成
        #     index : ファイルインデックス
        #--------------------------------------------------------------------------
        def make_filename(index)
            if index.is_a?(Integer)
                format("Save/Save%02d.rvdata2", index + 1)
            else
                format("Save/AutoSave%s.rvdata2", index)
            end
        end

        #--------------------------------------------------------------------------
        # ○ セーブヘッダの作成
        #--------------------------------------------------------------------------
        def make_save_header
            header = {}
            header[:characters] = $game_party.characters_for_savefile
            header[:playtime_s] = $game_system.playtime_s
            header[:realtime_s] = $game_system.realtime_s
            header[:luca_level] = $game_actors[NWConst::Actor::LUCA].base_level
            header
        end

        #--------------------------------------------------------------------------
        # ● サムネイル画像の解放
        #--------------------------------------------------------------------------
        def dispose_thumbnail
            @current_thumbnail.dispose
            @dummy_thumbnail.dispose
            @thumbnails.each_value { |thumbnail| thumbnail.dispose }
            @current_thumbnail = nil
            @dummy_thumbnail = nil
            @thumbnails = {}
        end

        #--------------------------------------------------------------------------
        # ● 現在サムネイル画像の取得
        #--------------------------------------------------------------------------
        def get_current_thumbnail
            @current_thumbnail
        end

        #--------------------------------------------------------------------------
        # ● ダミーサムネイル画像の取得
        #--------------------------------------------------------------------------
        def get_dummy_thumbnail
            @dummy_thumbnail
        end

        #--------------------------------------------------------------------------
        # ● サムネイル画像の取得
        #--------------------------------------------------------------------------
        def get_thumbnail(index)
            @thumbnails[index]
        end

        #--------------------------------------------------------------------------
        # ● サムネイル画像の変更
        #--------------------------------------------------------------------------
        def change_thumbnail(index)
            @thumbnails[index].dispose if @thumbnails[index]
            bitmap = Bitmap.new(160, 120)
            bitmap.blt(0, 0, @current_thumbnail, bitmap.rect)
            @thumbnails[index] = bitmap
        end

        #--------------------------------------------------------------------------
        # ● サムネイル画像の保存
        #--------------------------------------------------------------------------
        def save_thumbnail(file_name)
            @current_thumbnail.save(file_name, :PNG)
        end

        def update_database?
            script_update? || diff_version_id? || data_update?
        end

        def diff_version_id?
            load_data("Data/ExVersionID.rvdata2") != load_data("Data/System.rvdata2").version_id
        rescue Errno::ENOENT
            true
        end

        def latest_updatetime
            return 0 if rgss_encrypt?

            files = ["Data/Actors", "Data/Classes", "Data/Skills", "Data/Items", "Data/Weapons", "Data/Armors",
                     "Data/Enemies", "Data/Troops", "Data/States", "Data/Animations", "Data/Tilesets", "Data/CommonEvents", "Data/System", "Data/MapInfos", "#{over_map_dir}/Data/MapInfos"]
            times = files.map do |f|
                next 0 if File.exist?("#{f}.rvdata2")

                File.mtime("#{f}.rvdata2")
            end
            times.max
        end

        def data_update?
            return false if rgss_encrypt?

            load_data("Data/ExDataUpdate.rvdata2") < latest_updatetime
        rescue Errno::ENOENT
            true
        end

        def script_update?
            SCRIPT_UPDATE != load_data("Data/ExScriptUpdate.rvdata2")
        rescue Errno::ENOENT
            true
        end

        def rgss_encrypt?
            @rgss_encrypt ||= FileTest.file?("Game.rgss3a")
        end

        def setting_features_data
            $data_actors.compact.each(&:setting_feature_data)
            $data_classes.compact.each(&:setting_feature_data)
            $data_weapons.compact.each(&:setting_feature_data)
            $data_armors.compact.each(&:setting_feature_data)
            $data_enemies.compact.each(&:setting_feature_data)
            $data_states.compact.each(&:setting_feature_data)
            $data_items.compact.each(&:setting_feature_data)
            $data_skills.compact.each(&:setting_feature_data)
        end

        #--------------------------------------------------------------------------
        # ● 通常のデータベースEXをロード
        #--------------------------------------------------------------------------
        def load_normal_database_ex
            ex_data = load_data("Data/DataEx.rvdata2")
            $data_actors        = ex_data[:actors]
            $data_classes       = ex_data[:classes]
            $data_skills        = ex_data[:skills]
            $data_items         = ex_data[:items]
            $data_weapons       = DataBaseEquip.new(ex_data[:weapons], :weapons)
            $data_armors        = DataBaseEquip.new(ex_data[:armors], :armors)
            $data_enemies       = ex_data[:enemies]
            $data_troops        = ex_data[:troops]
            $data_states        = ex_data[:states]
            $data_animations    = ex_data[:animations]
            $data_tilesets      = ex_data[:tilesets]
            $data_common_events = ex_data[:common_events]
            $data_system        = ex_data[:system]
            $data_mapinfos      = ex_data[:mapinfos]
        end

        #--------------------------------------------------------------------------
        # ● 戦闘テスト用のデータベースEXをロード
        #--------------------------------------------------------------------------
        def load_battle_test_database_ex
            ex_data = load_data("Data/DataEx.rvdata2")
            $data_actors        = ex_data[:actors]
            $data_classes       = ex_data[:classes]
            $data_skills        = ex_data[:skills]
            $data_items         = ex_data[:items]
            $data_weapons       = DataBaseEquip.new(ex_data[:weapons], :weapons)
            $data_armors        = DataBaseEquip.new(ex_data[:armors], :armors)
            $data_enemies       = ex_data[:enemies]
            $data_troops        = load_data("Data/BT_Troops.rvdata2")
            $data_states        = ex_data[:states]
            $data_animations    = load_data("Data/BT_Animations.rvdata2")
            $data_tilesets      = ex_data[:tilesets]
            $data_common_events = ex_data[:common_events]
            $data_system        = load_data("Data/BT_System.rvdata2")
        end

        #--------------------------------------------------------------------------
        # ● 解析済みデータベースEXをセーブ
        #--------------------------------------------------------------------------
        def save_analyzed_database_ex
            ex_data = {}
            ex_data[:actors]        = $data_actors
            ex_data[:classes]       = $data_classes
            ex_data[:skills]        = $data_skills
            ex_data[:items]         = $data_items
            ex_data[:weapons]       = $data_weapons
            ex_data[:armors]        = $data_armors
            ex_data[:enemies]       = $data_enemies
            ex_data[:troops]        = $data_troops
            ex_data[:states]        = $data_states
            ex_data[:tilesets]      = $data_tilesets
            ex_data[:animations]    = $data_animations
            ex_data[:common_events] = $data_common_events
            ex_data[:system]        = $data_system
            ex_data[:mapinfos]      = $data_mapinfos
            save_data(ex_data, "Data/DataEx.rvdata2")
            save_data($data_system.version_id, "Data/ExVersionID.rvdata2")
            save_data(SCRIPT_UPDATE, "Data/ExScriptUpdate.rvdata2")
            save_data(latest_updatetime, "Data/ExDataUpdate.rvdata2")

            p "DataEx.rvdata2をセーブしました"
        end

        #--------------------------------------------------------------------------
        # ○ 通常のデータベースをロード
        #--------------------------------------------------------------------------
        alias nw_base_load_normal_database load_normal_database
        def load_normal_database
            bm = Benchmark.new
            bm.start
            if update_database?
                nw_base_load_normal_database
                nw_analyze_database
                setting_features_data
                save_analyzed_database_ex unless rgss_encrypt?
            else
                load_normal_database_ex
            end
            bm.stop
            p "データベース読み込み時間は#{bm.elapsed}です"
            $data_skills << TURN_END_REVIVE_SKILL
            $data_skills << REVIVE_SKILL
            [TURN_END_REVIVE_SKILL, REVIVE_SKILL].each do |skill|
                skill.id = $data_skills.index(skill)
                skill.note_analyze
                skill.setting_feature_data
                skill.data_ex[:visible?] = true
                skill.data_ex[:lib_exclude?] = true
            end
        end

        #--------------------------------------------------------------------------
        # ○ 戦闘テスト用のデータベースをロード
        #--------------------------------------------------------------------------
        alias nw_base_load_battle_test_database load_battle_test_database
        def load_battle_test_database
            bm = Benchmark.new
            bm.start
            if update_database?
                nw_base_load_normal_database # Data_Ex作成には通常データベースを使う
                nw_analyze_database
                setting_features_data
                save_analyzed_database_ex
            end
            load_battle_test_database_ex
            bm.stop
            p "データベース読み込み時間は#{bm.elapsed}です" if $test_battlers
        end

        #--------------------------------------------------------------------------
        # ● セーブファイルの存在判定
        #--------------------------------------------------------------------------
        def auto_save_file_exists?
            return false if Dir.glob("Save/AutoSave*.rvdata2").empty?
            return false unless load_header("01")[:save_index].is_a?(Integer)

            true
        end

        #--------------------------------------------------------------------------
        # ● セーブ試行ファイル名の作成
        #--------------------------------------------------------------------------
        def make_temp_filename
            sprintf("Save/SaveTemp.rvdata2")
        end

        #--------------------------------------------------------------------------
        # ● セーブ試行ファイルの削除
        #--------------------------------------------------------------------------
        def delete_temp_file
            File.delete(make_temp_filename) if File.exist?(make_temp_filename)
        end

        #--------------------------------------------------------------------------
        # ○ オートセーブヘッダの作成
        #--------------------------------------------------------------------------
        def make_auto_save_header
            header = make_save_header
            header[:save_index] = DataManager.last_savefile_index
            header
        end

        #--------------------------------------------------------------------------
        # ○ セーブの実行
        #--------------------------------------------------------------------------
        def save_game(index)
            Dir.mkdir("Save") unless Dir.exist?("Save")
            save_game_without_rescue(index)
            begin; save_thumbnail(format("Save/Save%02d", index + 1))
            rescue StandardError; process_save_failure2("通常")
            end
            if $game_system.save_count % SaveData::BackUpNum == 0
                begin
                    save_game_backup_without_rescue
                    begin; save_thumbnail("Save/SaveBackup")
                    rescue StandardError; process_save_failure2("バックアップ")
                    end
                rescue StandardError; process_save_failure1("バックアップ")
                end
            end
            delete_temp_file
            true
        rescue StandardError
            process_save_failure1("通常")
            delete_temp_file
            false
        end

        #--------------------------------------------------------------------------
        # ● セーブの実行（例外処理なし）
        #--------------------------------------------------------------------------
        def save_game_without_rescue(index)
            File.open(make_temp_filename, "wb") do |file|
                $game_system.on_before_save
                Marshal.dump(make_save_header, file)
                Marshal.dump(make_save_contents, file)
                @last_savefile_index = index
            end
            File.rename(make_temp_filename, make_filename(index))
            true
        end

        #--------------------------------------------------------------------------
        # ● バックアップセーブの実行（例外処理なし）
        #--------------------------------------------------------------------------
        def save_game_backup_without_rescue
            File.open(make_temp_filename, "wb") do |file|
                Marshal.dump(make_save_header, file)
                Marshal.dump(make_save_contents, file)
            end
            File.rename(make_temp_filename, "Save/SaveBackup.rvdata2")
            true
        end

        #--------------------------------------------------------------------------
        # ● セーブ失敗時の表示名の作成
        #--------------------------------------------------------------------------
        def save_failure_word(text)
            NWPatch.ver_name(" - セーブ失敗メッセージ\n\n") + "【" + text + "】"
        end

        #--------------------------------------------------------------------------
        # ● セーブ失敗時の処理
        #--------------------------------------------------------------------------
        def process_save_failure1(text)
            text = save_failure_word(text)
            m1 = text + SaveData::FailureMes1.inject("") { |r, text| r += text + "\n" }
            m2 = "不明"
            begin
                File.open(make_temp_filename, "wb") do |file|
                    make_save_header.each do |key, value|
                        m2 = "header " + key.to_s
                        Marshal.dump(value, file)
                    end
                    make_save_contents.each do |key, value|
                        m2 = "contents " + key.to_s
                        Marshal.dump(value, file)
                    end
                end
                m2 = "不明"
            rescue StandardError
            end
            backup = text.include?("バックアップ")
            m1.gsub!("<1>") { backup ? "\n" + SaveData::FailureMesBackUp : "" }
            m1.gsub!("<2>") { format("セーブ失敗原因: %s", m2) }
            msgbox m1
        end

        #--------------------------------------------------------------------------
        # ● サムネイル失敗時の処理
        #--------------------------------------------------------------------------
        def process_save_failure2(text)
            text = save_failure_word(text)
            m1 = text + SaveData::FailureMes2.inject("") { |r, text| r += text + "\n" }
            backup = text.include?("バックアップ")
            m1.gsub!("<1>") { backup ? "\n" + SaveData::FailureMesBackUp : "" }
        end

        #--------------------------------------------------------------------------
        # ○ オートセーブの実行
        #--------------------------------------------------------------------------
        def auto_save_game
            return if $game_switches[NWConst::Sw::LIBRARY_H_MEMORY] || $BTEST

            if $game_system.save_disabled
                puts "★オートセーブを実行しようとしたが、セーブ不能のため無効"
                return
            end
            puts "★オートセーブを実行"
            index = "01"
            begin
                Dir.mkdir("Save") unless Dir.exist?("Save")
                auto_save_game_without_rescue(index)
                delete_temp_file
                true
            rescue StandardError
                process_save_failure1("オート")
                File.rename(make_temp_filename, make_filename(index)) if File.exist?(make_temp_filename)
                delete_temp_file
                false
            end
        end

        #--------------------------------------------------------------------------
        # ○ オートセーブの実行（例外処理なし）
        #--------------------------------------------------------------------------
        def auto_save_game_without_rescue(index)
            fname = make_filename(index)
            File.rename(fname, make_temp_filename) if File.exist?(fname)
            File.open(fname, "wb") do |file|
                $game_system.on_before_save
                $game_system.on_before_auto_save
                Marshal.dump(make_auto_save_header, file)
                Marshal.dump(make_save_contents, file)
            end

            true
        end

        #--------------------------------------------------------------------------
        # ● システムファイルが存在する？
        #--------------------------------------------------------------------------
        def system_file_exist?
            SaveSystemData.filename_set.any? { |name| File.exist?(name) }
        end

        #--------------------------------------------------------------------------
        # ● システムセーブの実行
        #--------------------------------------------------------------------------
        def save_system
            return false unless system_object_exist?

            begin
                Dir.mkdir("Save") unless Dir.exist?("Save")
                @system_save_count += 1
                save_system_without_rescue
                save_system_backup_without_rescue if @system_save_count % SaveSystemData::BackUpNum == 0
                true
            rescue StandardError
                msgbox save_failure_word("システム") +
                        SaveSystemData::FailureMes1.inject("") { |r, text| r += text + "\n" }
                false
            end
        end

        #--------------------------------------------------------------------------
        # ● システムロードの実行
        #--------------------------------------------------------------------------
        def load_system
            load_system_without_rescue
        rescue StandardError
            msgbox save_failure_word("システム") +
             SaveSystemData::FailureMes2.inject("") { |r, text| r += text + "\n" }
            Kernel.exit
        end

        #--------------------------------------------------------------------------
        # ● システムセーブの実行（例外処理なし）
        #--------------------------------------------------------------------------
        def save_system_without_rescue
            File.open(SaveSystemData.save_filename, "wb") do |file|
                Marshal.dump(make_system_save_contents, file)
            end
            true
        end

        #--------------------------------------------------------------------------
        # ● システムロードの実行（例外処理なし）
        #--------------------------------------------------------------------------
        def load_system_without_rescue
            File.open(SaveSystemData.load_filename, "rb") do |file|
                extract_system_save_contents(Marshal.load(file))
                update_system
            end
            true
        end

        def nw_analyze_database
            [$data_actors, $data_classes, $data_skills, $data_items, $data_weapons, $data_armors, $data_enemies,
             $data_states].each do |data|
                data.each_with_index do |obj, i|
                    next unless obj

                    obj.id = i
                    obj.note_analyze
                end
            end
            $data_classes.compact.each do |c|
                c.learnings.each { |l| l.nw_note_analyze }
            end
            $data_tilesets.compact.each { |t| t.nw_note_analyze }
            # スクリプト素材の関係でnote消しはNG
        end
        def make_thumbnail
            @thumbnails = {}  # Hash to store thumbnails
            @thumbnails.each_with_index do |(index, bitmap), i|
                if bitmap.nil?
                    puts "Thumbnail at index #{i} is nil."
                else
                    puts "Thumbnail at index #{i}:"
                    puts "  Class: #{bitmap.class}"
                    puts "  Dimensions: #{bitmap.rect.width}x#{bitmap.rect.height}"
                end
            end
            @current_thumbnail = nil
            @dummy_thumbnail = nil

            # Create current and dummy thumbnails
            src_bitmap = SceneManager.background_bitmap
            @current_thumbnail = Bitmap.new(160, 120)
            @current_thumbnail.stretch_blt(@current_thumbnail.rect, src_bitmap, src_bitmap.rect)

            @dummy_thumbnail = Bitmap.new(160, 120)
            @dummy_thumbnail.fill_rect(@dummy_thumbnail.rect, Color.new(0, 0, 0))

            puts "Skipping thumbnail creation because the height is greater than 2000: #{@current_thumbnail.height}"

            # Ensure the Save directory exists
            Dir.mkdir("Save") unless Dir.exist?("Save")

            # Process each file in the Save directory
            Dir.entries("Save").each do |file_name|
                puts "Checking file: #{file_name}"  # Debug log
                next unless file_name =~ /^Save(\d+)\.rvdata2/i  # Match save file pattern

                save_number = Regexp.last_match(1)  # Extract save number
                thumbnail_file = "Save/Save#{save_number}.png"  # Corresponding thumbnail path

                puts "Processing save file: #{file_name}, expected thumbnail: #{thumbnail_file}"

                index = save_number.to_i - 1

                # Check if the thumbnail exists
                if File.exist?(thumbnail_file)
                    puts "Thumbnail exists: #{thumbnail_file}"

                    # Check size before indexing
                    # temp_bitmap = Bitmap.new(thumbnail_file)
                    temp_bitmap = Bitmap.new(thumbnail_file) : @dummy_thumbnail
                    puts "Temp Bitmap size: #{temp_bitmap.rect.width}x#{temp_bitmap.rect.height} size"

                    # Add the bitmap to @thumbnails only if the size is acceptable
                    if temp_bitmap.rect.width > 0 && temp_bitmap.rect.height > 0
                        @thumbnails[index] = temp_bitmap
                        puts "Successfully added thumbnail at index #{index}."
                    else
                        temp_bitmap = @dummy_thumbnail
                        @thumbnails[index] = temp_bitmap

                    end
                elsif File.exist?("Graphics/System/NotThumbnailFile.png")
                    puts "Thumbnail missing, using fallback: Graphics/System/NotThumbnailFile.png"

                    # Check size of fallback image before indexing
                    fallback_bitmap = Bitmap.new("Graphics/System/NotThumbnailFile.png")
                    puts "Fallback Bitmap size: #{fallback_bitmap.rect.width}x#{fallback_bitmap.rect.height}"

                    # Add the fallback bitmap to @thumbnails
                    @thumbnails[index] = fallback_bitmap
                    puts "Using fallback thumbnail at index #{index}."
                else
                    temp_bitmap = @dummy_thumbnail
                    @thumbnails[index] = temp_bitmap
                    puts "Thumbnail for Save#{save_number} not found, and fallback image is missing."
                end

                # Check if the thumbnail is nil or has the correct class
                if @thumbnails[index].nil?
                    puts "Warning: Thumbnail at index #{index} is nil!"
                else
                    puts "Thumbnail at index #{index} is of class: #{@thumbnails[index].class}"
                    puts "Dimensions: #{@thumbnails[index].rect.width}x#{@thumbnails[index].rect.height}"
                end
            end
        end

        def update
            $game_actors.bugfix_ignore_flag = true
            $game_system.update_config
            $game_party.pre_update
            $game_actors.version_update
            $game_party.update
            $game_actors.bugfix_ignore_flag = false
        end

        def update_system
            $game_library.refresh_skill_update
        end

        def over_map_dir
            "Data/Map"
        end

        def map_file_name(map_id)
            div, mod = map_id.divmod(1000)
            return format("Data/Map%03d.rvdata2", mod) if div == 0

            format("#{over_map_dir}/Data/Map%03d.rvdata2", mod)
        end
    end
end

module EquipInfoScene
    #--------------------------------------------------------------------------
    # ● 開始処理
    #--------------------------------------------------------------------------
    def start
        super
        @deactivate_windows = []
        @equip_info_windows = []
        @hide_windows = []
        create_equip_info_itemname_window
        create_equip_info_page_window
        create_equip_info_window
        @equip_info_current_window_index = 0
        @equip_info_page = 0
        @equip_info_isshow = false
    end

    def update
        super
        equip_info_change_visible if Input.trigger?(:X)
    end

    def update_all_windows
        if @equip_info_isshow
            if Input.trigger?(:B)
                equip_info_hide
                Input.update
            elsif Input.trigger?(:L) || Input.trigger?(:LEFT)
                equip_info_before_page
                Input.update
            elsif Input.trigger?(:R) || Input.trigger?(:RIGHT)
                equip_info_next_page
                Input.update
            end
        end
        super
    end

    #--------------------------------------------------------------------------
    # ○ 性能差比較ウィンドウの表示状態を切り替え
    #--------------------------------------------------------------------------
    def equip_info_change_visible
        equip_info_next_page if @equip_info_isshow
        equip_info_show if !@equip_info_isshow && !equip_info_hide?
    end

    #--------------------------------------------------------------------------
    # ○ 性能差比較ウィンドウの非表示
    #--------------------------------------------------------------------------
    def equip_info_hide
        @equip_info_itemname_window.hide
        @equip_info_page_window.hide
        @equip_info_page = 0
        @equip_info_current_window_index = 0
        equip_info_windows.each { |window| window.hide }
        @deactivate_windows.each(&:activate)
        @hide_windows.each(&:show)
        @equip_info_isshow = false
    end

    #--------------------------------------------------------------------------
    # ● 性能差比較ウィンドウを非表示にするか
    #--------------------------------------------------------------------------
    def equip_info_hide?
        return true unless equip_info_select_item.is_a?(RPG::EquipItem)
    end

    #--------------------------------------------------------------------------
    # ● 性能差比較アイテム名の文字色を明るくするか
    #--------------------------------------------------------------------------
    def equip_info_enable
        true
    end

    def equip_info_init
        @equip_info_windows = __equip_info_windows
        equip_info_set_item
        equip_info_set_actor
        equip_info_windows.each do |window|
            window.page_index = 0
            window.refresh
        end
        equip_info_set_page
    end

    def equip_info_set_item
        select_item = equip_info_select_item
        @equip_info_itemname_window.item = select_item
        @equip_info_windows.each { |window| window.item = select_item }
    end

    def equip_info_set_page
        @equip_info_page_window.page_index = equip_info_get_all_page_index[@equip_info_current_window_index] + @equip_info_page
        @equip_info_page_window.page_max = equip_info_all_page_max
        equip_info_window.page_index = @equip_info_page
        equip_info_window.refresh if @equip_info_isshow
    end

    def equip_info_set_actor
        @equip_info_windows.each { |window| window.actor = equip_info_select_actor }
    end

    def equip_info_select_item
        nil
    end

    def equip_info_select_actor
        nil
    end

    def create_equip_info_window
        @compare_ex_window = Window_ShopCompareEx.new
        @equip_info_window = Window_ShopStatusEx.new(0, 56, 640, 368)
        @enchant_stone_window = Window_Enchant_Stones.new(0, 56, 640, 368)
        @set_effect_window = Window_SetEffect.new(0, 56, 640, 368)
        @compare_ex_window.z = 100
        @equip_info_window.z = 100
        @enchant_stone_window.z = 100
        @set_effect_window.z = 100
        @compare_ex_window.viewport = @viewport
        @equip_info_window.viewport = @viewport
        @enchant_stone_window.viewport = @viewport
        @enchant_stone_window.viewport = @viewport
    end

    def __equip_info_windows
        @equip_info_windows = [@equip_info_window, @set_effect_window, @enchant_stone_window, @compare_ex_window]
    end

    def create_equip_info_itemname_window
        @equip_info_itemname_window = Window_ItemName.new
        @equip_info_itemname_window.viewport = @viewport
    end

    def create_equip_info_page_window
        @equip_info_page_window = Window_Page.new
        @equip_info_page_window.viewport = @viewport
    end

    #--------------------------------------------------------------------------
    # ● 簡易操作説明テキスト
    #--------------------------------------------------------------------------
    def show_key_text
        if @equip_info_isshow
            [Help.equip_info_change,
             Help.equip_info_next,
             Help.equip_info_hide]
        else
            []
        end
    end

    #--------------------------------------------------------------------------
    # ● 全ページ
    #--------------------------------------------------------------------------
    def equip_info_all_page_max
        equip_info_windows.map(&:page_max).inject(:+)
    end

    #--------------------------------------------------------------------------
    # ● ウィンドウ毎の全ページから見た初期ページ数
    #--------------------------------------------------------------------------
    def equip_info_get_all_page_index
        equip_info_windows.map(&:page_max).map.with_index  do |_p, index|
            (equip_info_windows.map(&:page_max)[0, index] || []).inject(1) { |i, v| i + v }
        end
    end

    #--------------------------------------------------------------------------
    # ● 全ウィンドウ取得
    #--------------------------------------------------------------------------
    def equip_info_windows
        @equip_info_windows.select { |window| window.page_max > 0 }
    end

    #--------------------------------------------------------------------------
    # ● 現在の表示状態取得
    #--------------------------------------------------------------------------
    def equip_info_window_visible
        equip_info_windows.any?(&:visible)
    end

    #--------------------------------------------------------------------------
    # ● 次のページへ
    #--------------------------------------------------------------------------
    def equip_info_next_page
        @equip_info_page += 1
        if @equip_info_page >= equip_info_window.page_max
            equip_info_window.hide
            if @equip_info_current_window_index >= equip_info_windows.size - 1
                @equip_info_current_window_index = 0
            else
                @equip_info_current_window_index += 1
            end
            @equip_info_page = 0
            equip_info_window.show

        end
        equip_info_set_page
    end

    #--------------------------------------------------------------------------
    # ● 前のページへ
    #--------------------------------------------------------------------------
    def equip_info_before_page
        @equip_info_page -= 1
        if @equip_info_page == -1
            equip_info_window.hide
            if @equip_info_current_window_index == 0
                @equip_info_current_window_index = equip_info_windows.size - 1
            else
                @equip_info_current_window_index -= 1
            end
            @equip_info_page = (equip_info_window.page_max - 1)
            equip_info_window.show
        end
        equip_info_set_page
    end

    #--------------------------------------------------------------------------
    # ● 現在起動中のウィンドウ取得
    #--------------------------------------------------------------------------
    def equip_info_window
        equip_info_windows[@equip_info_current_window_index]
    end

    #--------------------------------------------------------------------------
    # ○ 性能差比較ウィンドウの表示
    #--------------------------------------------------------------------------
    def equip_info_show
        equip_info_init
        @equip_info_isshow = true
        @deactivate_windows = []
        @hide_windows = []
        instance_variables.each do |varname|
            ivar = instance_variable_get(varname)
            if ivar.is_a?(Window)
                @deactivate_windows << ivar if ivar.active
                @hide_windows << ivar if ivar.visible
            end
        end
        @deactivate_windows.each(&:deactivate)
        @hide_windows.each(&:hide)
        @equip_info_page = 0
        @equip_info_current_window_index = 0
        equip_info_window.show
        @equip_info_itemname_window.show
        @equip_info_itemname_window.refresh
        @equip_info_page_window.show
        equip_info_window.refresh
    end

    #--------------------------------------------------------------------------
    # ● 性能差比較ウィンドウを変更するか
    #--------------------------------------------------------------------------
    def equip_info_change?
        if (equip_info_select_item.nil? || !equip_info_select_item.enchant_item?) && @enchant_stone_window.visible
            return true
        end
        return true if equip_info_select_item.nil? && @equip_info_window.visible
    end
end

module EquipInfoWindow
    attr_accessor :page_index
    attr_writer :item
    attr_writer :actor

    def page_max
        1
    end
end

module FavoriteItem
    #--------------------------------------------------------------------------
    # ○ 選択中のアイテムのお気に入り状態を変更
    #--------------------------------------------------------------------------
    def process_set_favorite_item
        Input.update
        return Sound.play_buzzer if @item_window.item.nil?

        Sound.play_ok
        @item_window.set_favorite_item
        @item_window.refresh
        @item_window.select([@item_window.index - 1, 0].max) if @item_window.favorite_mode

        @item_window.refresh
    end

    #--------------------------------------------------------------------------
    # ○ お気に入り表示モードを変更
    #--------------------------------------------------------------------------
    def process_change_favorite_mode
        Input.update
        Sound.play_ok
        last_item = @item_window.item
        @item_window.change_favorite_mode
        @item_window.refresh
        if @item_window.active
            @item_window.select_item(last_item)
        else
            @item_window.select(-1)
        end
    end

    #--------------------------------------------------------------------------
    # ○ フレーム更新
    #--------------------------------------------------------------------------
    def update
        return process_set_favorite_item if enable_set_favorite_item? && Input.trigger?(:Y)
        return process_change_favorite_mode if enable_change_favorite_mode? && Input.trigger?(:Z)

        @item_window.change_favorite_mode if off_favorite_mode? and @item_window.favorite_mode
        super
    end

    #--------------------------------------------------------------------------
    # ○ 可否　選択中のアイテムのお気に入り状態を変更
    #--------------------------------------------------------------------------
    def enable_set_favorite_item?
        false
    end

    #--------------------------------------------------------------------------
    # ○ 可否　お気に入り表示モードを変更
    #--------------------------------------------------------------------------
    def enable_change_favorite_mode?
        false
    end

    #--------------------------------------------------------------------------
    # ○ 有無　お気に入り表示モードをオフ
    #--------------------------------------------------------------------------
    def off_favorite_mode?
        !@item_window.visible
    end
end

module Graphics
    class << self
        alias hima_set_frame_count frame_count=
                def frame_count=(other)
        @frame_count = other.abs
        hima_set_frame_count(0)
    end

    alias hima_frame_count frame_count
    def frame_count
        hima_frame_count + @frame_count
    end

    alias hima_update update
    def update
        hima_update
        Sprite_Base.clear_checker
    end
end
end
module Help
    class << self
        #--------------------------------------------------------------------------
        # ● アビリティ画面の上部ヘルプメッセージ
        #--------------------------------------------------------------------------
        def ability
            "Please choose an ability type"
        end

        #--------------------------------------------------------------------------
        # ● アビリティ画面の下部ヘルプメッセージ
        #--------------------------------------------------------------------------
        def ability_key
            "#{Vocab.key_c}:Select　#{Vocab.key_b}:Cancel　#{Vocab.key_a}:Remove"
        end

        #--------------------------------------------------------------------------
        # ● スキル画面の下部ヘルプメッセージ
        #--------------------------------------------------------------------------
        def skill_type_key
            t = ""
            t += "\\C[0]"
            t += "#{Vocab.key_a}:Hide in battle + Disable in auto mode"
            t += "(Disabled)" unless $game_system.conf[:bt_stype]
            t += "\n"
            t += "\\C[16]" if Input.press?(:X)
            t += "#{Vocab.key_x}＋↑/↓:Sort by skill type
            t += "#{Vocab.key_x}＋#{Vocab.key_b}:Reset skill order"
            t
        end

        #--------------------------------------------------------------------------
        # ● コンフィグ-色調のヘルプメッセージ
        #--------------------------------------------------------------------------
        def config_tone
            [
                "Set red value.\r\n←/→:-/+#{Vocab.key_l}/#{Vocab.key_r}:Big -/+",
                "Set green value.\r\n←/→:-/+#{Vocab.key_l}/#{Vocab.key_r}:Big -/+",
                "Set blue value.\r\n←/→:-/+#{Vocab.key_l}/#{Vocab.key_r}:Big -/+",
                "Restore defaults.",
                "Return"
            ]
        end

        #--------------------------------------------------------------------------
        # ● コンフィグ-音量のヘルプメッセージ
        #--------------------------------------------------------------------------
        def config_sound
            [
                "BGM Volume\r\n←/→:-/+#{Vocab.key_l}/#{Vocab.key_r}:Big -/+",
                "BGS Volume\r\n←/→:-/+#{Vocab.key_l}/#{Vocab.key_r}:Big -/+",
                "ME Volume\r\n←/→:-/+#{Vocab.key_l}/#{Vocab.key_r}:Big -/+",
                "SE Volume\r\n←/→:-/+#{Vocab.key_l}/#{Vocab.key_r}:Big -/+",
                "Restore defaults.",
                "Return."
            ]
        end

        #--------------------------------------------------------------------------
        # ● パーティ編成画面のヘルプメッセージ
        #--------------------------------------------------------------------------
        def party_edit
            [
                "#{Vocab.key_a}:Remove",
                "#{Vocab.key_x}:Status",
                "#{Vocab.key_y}:Sort",
                "#{Vocab.key_z}:Warp To",
                ]
        end

        #--------------------------------------------------------------------------
        # ● 転職画面のヘルプメッセージ
        #--------------------------------------------------------------------------
        def job_change
            ["#{Vocab.key_y}/#{Vocab.key_z}:Sort"]
        end

        #--------------------------------------------------------------------------
        # ● スロット画面の操作説明テキスト
        #--------------------------------------------------------------------------
        def slot_description
            {
                :stand => "→:Increase Wager　#{Vocab.key_c}:Spin Slots\n←:Decrease Wager　#{Vocab.key_b}:Quit",
                :play  => "#{Vocab.key_c}:Stop Reel"
            }
        end

        #--------------------------------------------------------------------------
        # ● ショップ画面の装備品情報変更テキスト
        #--------------------------------------------------------------------------
        def shop_equip_change
            "←/→:Info Change"
        end

        #--------------------------------------------------------------------------
        # ● ショップ画面の装備品性能比較テキスト
        #--------------------------------------------------------------------------
        def shop_param_compare
            "#{Vocab.key_x}:Stat Change"
        end

        #--------------------------------------------------------------------------
        # ● 性能差比較　装備情報ウインドウのボタン説明１
        #--------------------------------------------------------------------------
        def item_info_change
            "#{Vocab.key_x}:Info Change"
        end

        #--------------------------------------------------------------------------
        # ● 性能差比較　装備情報ウインドウのボタン説明２
        #--------------------------------------------------------------------------
        def item_info_exit
            "#{Vocab.key_x}:Close"
        end

        #--------------------------------------------------------------------------
        # ● 図鑑画面のヘルプメッセージ
        #--------------------------------------------------------------------------
        def library
            {
                :blank      => "This entry is blank.",
                :discovery  => "This entry's details are unknown.",
                :return_top => "Return to top.",
                :close_lib  => "Close and return to last screen.",
                :btn_detail => "#{Vocab.key_c}:View Details",
                :btn_column => "↑/↓:Select",
                :btn_jump   => "#{Vocab.key_l}/#{Vocab.key_r}:Jump",
                :btn_page   => "←/→:Page",
                :btn_scroll => "#{Vocab.key_y}/#{Vocab.key_z}:Scroll Text",
                :btn_equip => "#{Vocab.key_x}:Equip Info"
            }
        end

        #--------------------------------------------------------------------------
        # ● 装備品情報変更テキスト
        #--------------------------------------------------------------------------
        def equip_info_change
            "←/→,#{Vocab.key_l}/#{Vocab.key_r}:Switch info page"
        end

        #--------------------------------------------------------------------------
        # ● 装備品情報変更テキスト
        #--------------------------------------------------------------------------
        def equip_info_next
            "#{Vocab.key_x}:Next page"
        end

        #--------------------------------------------------------------------------
        # ● 装備品情報変更テキスト
        #--------------------------------------------------------------------------
        def equip_info_hide
            "#{Vocab.key_b}:Close info page"
        end
    end
end

#==============================================================================
# ■ SceneManager
#==============================================================================
module SceneManager
    class << self
        attr_writer :background_bitmap
        attr_accessor :stack

        #--------------------------------------------------------------------------
        # ○ 実行
        #--------------------------------------------------------------------------
        def run
            Audio.setup_midi if use_midi?
            # ~     Audio.init_basic
            Audio.reset_sound
            DataManager.init
            LibraryH::Manager.init
            @scene = first_scene_class.new
            @scene.main while @scene
        end

        #--------------------------------------------------------------------------
        # ● シーンスタックへのプッシュ
        #--------------------------------------------------------------------------
        def push(scene)
            @stack.push(scene.new)
        end

        #--------------------------------------------------------------------------
        # ○ 背景として使うためのスナップショット作成
        #--------------------------------------------------------------------------
        def snapshot_for_background
            @background_bitmap.dispose if @background_bitmap
            @background_bitmap = Graphics.snap_to_bitmap
            #    @background_bitmap.blur
        end
    end
end

#==============================================================================
# ■ ShowKey_Help
#==============================================================================
module ShowKey_Help
    class << self
        #--------------------------------------------------------------------------
        # ● 各画面
        #--------------------------------------------------------------------------
        def lr_scroll
            "#{Vocab.key_l}/#{Vocab.key_r}:Page Scroll"
        end

        #--------------------------------------------------------------------------
        # ● アイテムを表示する画面
        #--------------------------------------------------------------------------
        def favorite_item(state)
            "#{Vocab.key_y}:#{state ? "Remove" : "Save"} favorite"
        end

        #--------------------------------------------------------------------------
        # ● アイテムを表示する画面
        #--------------------------------------------------------------------------
        def favorite_mode(mode)
            "#{Vocab.key_z}:#{mode ? "Display all but" : "Display only"} favorites"
        end

        #--------------------------------------------------------------------------
        # ● 装備を表示する画面
        #--------------------------------------------------------------------------
        def equip_info
            "#{Vocab.key_x}:Equip Info"
        end

        #--------------------------------------------------------------------------
        # ● キャラごとの画面
        #--------------------------------------------------------------------------
        def lr_actor
            "#{Vocab.key_l}/#{Vocab.key_r}:Switch Character"
        end

        #--------------------------------------------------------------------------
        # ● スキル画面
        #--------------------------------------------------------------------------
        def stype_disable
            "#{Vocab.key_a}:Hide in Battle + Disable in Auto Mode"
        end

        #--------------------------------------------------------------------------
        # ● スキル画面
        #--------------------------------------------------------------------------
        def stype_move
            "#{Vocab.key_x}+↑↓:Sort"
        end

        #--------------------------------------------------------------------------
        # ● 装備画面
        #--------------------------------------------------------------------------
        def equip_shift
            "#{Vocab.key_y}:Remove Equip"
        end

        def equip_stone
            "#{Vocab.key_a}:Switch Gem"
        end
        #--------------------------------------------------------------------------
        # ● アビリティ画面
        #--------------------------------------------------------------------------
        def ability_shift_all
            "#{Vocab.key_a}:Remove all Abilities"
        end

        #--------------------------------------------------------------------------
        # ● アビリティ画面
        #--------------------------------------------------------------------------
        def ability_shift
            "#{Vocab.key_a}:Remove Ability"
        end

        #--------------------------------------------------------------------------
        # ● ショップ画面の装備品情報変更テキスト
        #--------------------------------------------------------------------------
        def shop_equip_change
            Help.shop_equip_change
        end

        #--------------------------------------------------------------------------
        # ● ショップ画面の装備品性能比較テキスト
        #--------------------------------------------------------------------------
        def shop_param_compare
            Help.shop_param_compare
        end

        #--------------------------------------------------------------------------
        # ● 秘石画面
        #--------------------------------------------------------------------------
        def stone_shift_all
            "#{Vocab.key_a}:Remove All Gems"
        end

        #--------------------------------------------------------------------------
        # ●  秘石画面
        #--------------------------------------------------------------------------
        def stone_shift
            "#{Vocab.key_a}:Remove Gem"
        end

        def stone_change_scene
            "←/→：Gem Equip Screen"
        end
    end
end

module ShowKey_HelpWindow
    def post_start
        create_show_key_sprite
        super
    end

    #--------------------------------------------------------------------------
    # ● 簡易操作説明スプライトの作成
    #--------------------------------------------------------------------------
    def create_show_key_sprite
        @show_key_sprite = Sprite_ShowKey.new(show_key_sprite_window)
        update_show_key_sprite
    end

    #--------------------------------------------------------------------------
    # ● 簡易操作説明の更新
    #--------------------------------------------------------------------------
    def set_text_show_key_sprite(text)
        @show_key_sprite.set_text(text)
    end

    #--------------------------------------------------------------------------
    # ● 簡易操作説明ウィンドウ
    #--------------------------------------------------------------------------
    def show_key_sprite_window
        @help_window
    end

    #--------------------------------------------------------------------------
    # ● フレーム更新
    #--------------------------------------------------------------------------
    def update
        super
        update_show_key_sprite
    end

    #--------------------------------------------------------------------------
    # ● 簡易操作説明の更新
    #--------------------------------------------------------------------------
    def update_show_key_sprite
        set_text_show_key_sprite(show_key_text)
    end

    #--------------------------------------------------------------------------
    # ● 終了処理
    #--------------------------------------------------------------------------
    def terminate
        @show_key_sprite.dispose
        super
    end
end

#==============================================================================
# ■ Vocab
#==============================================================================
module Vocab
    #--------------------------------------------------------------------------
    # ○ 基本挿替
    #--------------------------------------------------------------------------
    # Evasion         = "しかし%sは素早くかわした！"
    ActorNoHit      = "But %s quickly dodged!"
    EnemyNoHit      = "But %s quickly dodged!"
    ActorNoDamage   = "%s took no damage!"
    EnemyNoDamage   = "%s took no damage!"
    Block = "%s blocked the attack with their shield!"
    #--------------------------------------------------------------------------
    # ● ユーザ定義
    #--------------------------------------------------------------------------
    Giveup = [
        "Luka yields to temptation and stops fighting!",
        "His companions desert and leave him to his fate..."
    ]
    BindingStart = [
        "%s is bound!",
        "%s is being raped!",
        "%s is being raped!",
        "But %s is already bound!"
    ]
    TemptationActionFailure = "But Luka has already been defeated!"

    Ability = "Ability"
    Shortage            = "But there isn't enough %s!"
    SkillSealedFailure  = "But that skill is sealed!"
    ObtainJobExp        = "%s job XP gained."
    Stealed             = "Stole %s from %s!"
    StealFailure        = "Couldn't steal anything from %s!"
    StealedItemEmpty    = "%s has nothing to steal!"
    Stand               = "%s refused to admit defeat!"
    Invalidate          = "It had no effect on %s!"
    DefenseWall         = "%s was defended by a wall!"
    PayLife             = "%s was spent!"
    PayLifeFailure      = "%s was debilitated!"
    OverDriveSuccess    = "%s stopped time!"
    OverDriveFailure    = "But time was already stopped!"
    BindResistSuccess   = "...and escaped from %s's restraint!"
    BindResistFailure   = "...but couldn't escape from %s's restraint!"
    EternalBindResist   = "...but is still being held down by %s!"
    PleasureFinished    = " came!"
    Predation           = "%s was devoured!"
    ReStoration         = "%s absorbed %s!"
    ThrowItem           = "%s threw a %s!"
    PhysicalReflection = "%s reflects the attack!"
    NotObtainItem = "%s obtained but you can't carry any more..."
    ACTOR_DAMAGE = "%s takes %s %s damage!"
    ENEMY_DAMAGE = "%s takes %s %s damage!"
    STATE_BOOST = "Condition bonus!!"
    EX_CATEGORY_BOOST = "Slayer bonus!!"

    AUTOBATTLE = "Auto"
    BATTLE_STATES = "Status"
    ENCHANT_STONE = "Gem"
    ClassLevel = "Job Level"
    TribeLevel = "Race Level"

    module AutoBattle
        NORMAL = "Random"
        NOT_MP_SKILL = "Conserve MP"
        REPEAT = "Repeat"
        ATTACK_ONLY = "Normal Attack"
    end

    PartySaveMessage = "Which slot do you want to register a party?"
    PartyLoadMessage = "Which party do you want to call?"

    class << self
        # 能力値 (短)
        def params_a(param_id)
            ["ATK", "DEF", "MAG", "WIL", "AGI", "DEX"][param_id]
        end

        # 仮想キー
        def key_a
            { :gamepad => "1", :keyboard => "Shift" }[$game_system.conf[:key_text]]
        end

        def key_b
            { :gamepad => "2", :keyboard => "X" }[$game_system.conf[:key_text]]
        end

        def key_c
            { :gamepad => "3", :keyboard => "Z" }[$game_system.conf[:key_text]]
        end

        def key_x
            { :gamepad => "4", :keyboard => "A" }[$game_system.conf[:key_text]]
        end

        def key_y
            { :gamepad => "5", :keyboard => "S" }[$game_system.conf[:key_text]]
        end

        def key_z
            { :gamepad => "6", :keyboard => "D" }[$game_system.conf[:key_text]]
        end

        def key_l
            { :gamepad => "7", :keyboard => "Q" }[$game_system.conf[:key_text]]
        end

        def key_r
            { :gamepad => "8", :keyboard => "W" }[$game_system.conf[:key_text]]
        end

        # パーティコマンド
        def giveup
            "Give Up"
        end

        def shift_change
            "Party"
        end

        def library
            "Library"
        end

        def config
            "Config"
        end

        def all_attack
            "Auto Atk"
        end

        def item_get_message(item, value, is_display_value = false)
            message = item.window_name
            if value == 0
                format(NotObtainItem, message)
            else
                #Below was reordered so the number is leading(before the item that is obtained)
                format(ObtainItem,(item.enchant_item? || !is_display_value ? "":" #{value}") + message )
            end
        end
    end
end
