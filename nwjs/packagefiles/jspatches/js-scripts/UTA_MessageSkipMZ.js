//=============================================================================
// UTA_MessageSkipMZ.js
//=============================================================================
/*:
 * @target MZ
 * @plugindesc Could to skip message by holding down a specific key. (By default, "control" and "alt" keys are set.)
 *
 * @author t-akatsuki
 * @url https://www.utakata-no-yume.net
 *
 * @param assignKeyCodes
 * @text Assgin keys
 * @desc Keys to be assigned to message skip.
 * You can assign up to multiple keys.
 * @default ["control"]
 * @type select[]
 * @option tab (tab)
 * @value tab
 * @option enter/space/Z (ok)
 * @value ok
 * @option shift (shift)
 * @value shift
 * @option control/alt (control)
 * @value control
 * @option escape/insert/X/numpad 0 (escape)
 * @value escape
 * @option pageup/Q (pageup)
 * @value pageup
 * @option pagedown/W (pagedown)
 * @value pagedown
 * @option left arrow/nampad 4 (left)
 * @value letf
 * @option up arrow/nampad 8 (up)
 * @value up
 * @option right arrow/numpad 6 (right)
 * @value right
 * @option down arrow/numpad 2 (down)
 * @value down
 * @option F9 (debug)
 * @value debug
 *
 * @help # Overview
 * This plugin make to skip message by hold down a specific key 
 * while the message is displayed.
 * It is a message skip function that is often used Text adventure game etc.
 *
 * When a choice is inserted, the skipping is interrupted 
 * when the choice is displayed.
 *
 * The following messages can be skipped.
 * - Show Text
 * - Show Scrolling Text
 *   - not skip if check "No fast Forward".
 * - Battle log in battle
 *
 * # Plugin Parameters
 * ## Assgin keys
 * Key to be assigned to message skipping.
 * Multiple keys can be assigned.
 *
 * If you assign more than one key, the message will be skipped 
 * while any one of the keys is being pressed.
 *
 * Select one of the available keys in the dropdown list.
 * - Available keys are within the keymap defined in 
 *   the RPGMakerMZ core script.
 *
 * Keys in parentheses are identifiers at the time of setting.
 *
 *
 * # Plugin Commands
 * This plugin has no plugin commands.
 *
 * # Plugin Informations
 * Version      : 0.9.0
 * Last Updated : 2020.11.07
 * Author       : t-akatsuki
 * Web Site     : https://www.utakata-no-yume.net
 * GitHub       : https://github.com/t-akatsuki
 * Github's repository : https://github.com/t-akatsuki/UTA_MessageSkipMZ
 * Twitter      : https://twitter.com/T_Akatsuki
 * License      : MIT License
 *
 * # Changelog
 * ## 0.9.0 (2020.11.07)
 * Beta version.
 * Remake for RPGMakerMV based on UTA_MessageSkip plugin for RPGMakerMZ.
 */
/*:ja
 * @target MZ
 * @plugindesc 特定キーを押し続ける事でメッセージを早送りできるようにします。
 *
 * @author 赤月 智平(t-akatsuki)
 * @url https://www.utakata-no-yume.net
 *
 * @param assignKeyCodes
 * @text 割り当てキー定義
 * @desc メッセージスキップに割り当てるキーです。
 * 複数割り当てる事ができます。
 * @default ["control"]
 * @type select[]
 * @option tab (tab)
 * @value tab
 * @option enter/space/Z (ok)
 * @value ok
 * @option shift (shift)
 * @value shift
 * @option control/alt (control)
 * @value control
 * @option escape/insert/X/numpad 0 (escape)
 * @value escape
 * @option pageup/Q (pageup)
 * @value pageup
 * @option pagedown/W (pagedown)
 * @value pagedown
 * @option left arrow/nampad 4 (left)
 * @value letf
 * @option up arrow/nampad 8 (up)
 * @value up
 * @option right arrow/numpad 6 (right)
 * @value right
 * @option down arrow/numpad 2 (down)
 * @value down
 * @option F9 (debug)
 * @value debug
 *
 * @help # 概要
 * メッセージ表示中に特定キーを押し続ける事で
 * メッセージの早送りを行う事ができるようになるプラグインです。
 *
 * ADV等で良くあるメッセージスキップ機能です。
 * 選択肢を挟む場合は選択肢が表示されるタイミングでスキップが中断されます。
 *
 * スキップできるメッセージは以下が対象です。
 *
 * ・文章の表示
 * ・文章のスクロール表示
 *   - 「早送りなし」を指定した場合はスキップ不可。
 * ・戦闘中のバトルログ
 *
 * # プラグインパラメータ
 * ## 割り当てキー定義
 * メッセージスキップに割り当てるキーです。
 * 複数割り当てる事ができます。
 * 複数割り当てた場合はいずれかのキーを押している間にスキップが行われます。
 *
 * 利用できるキーの中からドロップダウンリストで選択します。
 * ※利用できるキーはRPGツクールMZのコアスクリプトで定義された
 *   キーマップの範囲となります。
 * ※()内表記は設定時の識別子です。
 *
 * デフォルトは「control」「alt」キーが設定されています。
 *
 * # プラグインコマンド
 * プラグインコマンドはありません。
 *
 * # プラグインの情報
 * バージョン : 0.9.0
 * 最終更新日 : 2020.11.07
 * 制作者     : 赤月 智平(t-akatsuki)
 * Webサイト  : https://www.utakata-no-yume.net
 * GitHub    : https://github.com/t-akatsuki
 * Twitter   : https://twitter.com/T_Akatsuki
 * ライセンス : MIT License
 *
 * # 更新履歴
 * ## 0.9.0 (2020.11.07)
 * β版。
 * RPGツクールMV用UTA_MessageSkipをRPGツクールMZ用に移植。
 */
/**
 * @namespace utakata
 */
var utakata;
(function (utakata) {
    "use_strict";
    /**
     * @static
     * @class MessageSkip
     * @classdesc メッセージスキップ関連の処理を扱う静的クラス。
     */
    var MessageSkip = /** @class */ (function () {
        function MessageSkip() {
            throw new Error("MessageSkip is static class.");
        }
        /**
         * 初期化処理。
         * @static
         */
        MessageSkip.initialize = function () {
            this._keyNameList = [];
            this._parameters = PluginManager.parameters(this.PLUGIN_NAME);
            // プラグインパラメータに指定された値を読み込む
            var assignKeyCodes = JsonEx.parse(this._parameters.assignKeyCodes);
            this._loadKeyNameList(assignKeyCodes);
        };
        /**
         * 文字列配列からメッセージスキップキー名リストをロードする。
         * Input.keyMapperで定義されていないものしか受け付けない。
         * 重複する設定があった場合はエラーとせず、uniqueな状態に調整される。
         * @static
         * @private
         * @param {string[]} targetList 読み込み対象文字列配列。
         */
        MessageSkip._loadKeyNameList = function (targetList) {
            this._keyNameList = [];
            var keyMapperNames = Object.values(Input.keyMapper);
            for (var _i = 0, targetList_1 = targetList; _i < targetList_1.length; _i++) {
                var targetStr = targetList_1[_i];
                // Input.keyMapperで定義されているものしか受け付けない
                if (!keyMapperNames.includes(targetStr)) {
                    throw new Error(this.PLUGIN_NAME + ": plugin parameter error: invalid value. (" + targetStr + ")");
                }
                this._keyNameList.push(targetStr);
            }
            // unique
            this._keyNameList = this._keyNameList.filter(function (x, i, self) {
                return self.indexOf(x) === i;
            });
        };
        /**
         * 設定したメッセージスキップキーのいずれかが押されているかを判定する。
         * @static
         * @private
         * @return {boolean} メッセージスキップキーが押されている場合trueを返す。
         */
        MessageSkip._isPressedSkipButton = function () {
            for (var _i = 0, _a = this._keyNameList; _i < _a.length; _i++) {
                var keyName = _a[_i];
                if (Input.isPressed(keyName)) {
                    return true;
                }
            }
            return false;
        };
        /**
         * メッセージスキップ状態であるかを判定する。
         * @static
         * @return {boolean} メッセージスキップ状態である場合trueを返す。
         */
        MessageSkip.isMessageSkip = function () {
            return this._isPressedSkipButton();
        };
        MessageSkip.getScrollMessageSpeedRate = function () {
            return this._scrollMessageSpeedRate;
        };
        MessageSkip.getBattleLogMessageSpeed = function () {
            return this._battleLogMessageSpeed;
        };
        /**
         * プラグイン名称定義
         * @static
         * @type {string}
         */
        MessageSkip.PLUGIN_NAME = "UTA_MessageSkipMZ";
        /**
         * プラグインのバージョン定義
         * @static
         * @type {object}
         */
        MessageSkip.PLUGIN_VERSION = {
            major: 0,
            minor: 9,
            patch: 0
        };
        /**
         * メッセージスキップにアサインしたキー名のリスト
         * @static
         * @private
         * @type {string[]}
         */
        MessageSkip._keyNameList = [];
        /**
         * スクロールメッセージのスキップ時速度レート
         * @static
         * @private
         * @type {number}
         */
        MessageSkip._scrollMessageSpeedRate = 100;
        /**
         * バトルログのスキップ時速度
         * @static
         * @private
         * @type {number}
         */
        MessageSkip._battleLogMessageSpeed = 1;
        return MessageSkip;
    }());
    utakata.MessageSkip = MessageSkip;
    MessageSkip.initialize();
    /**
     * Window_Message
     */
    // 文章表示中にスキップキーが押された場合は即全表示するように
    var _Window_Message_updateShowFast = Window_Message.prototype.updateShowFast;
    Window_Message.prototype.updateShowFast = function () {
        _Window_Message_updateShowFast.call(this);
        if (MessageSkip.isMessageSkip()) {
            this._showFast = true;
            this._lineShowFast = true;
            this._pauseSkip = true;
        }
    };
    // 文章表示キー入力待ちの際もスキップキーの監視を行う
    var _Window_Message_updateInput = Window_Message.prototype.updateInput;
    Window_Message.prototype.updateInput = function () {
        var ret = _Window_Message_updateInput.call(this);
        if (this.pause && MessageSkip.isMessageSkip()) {
            Input.update();
            this.pause = false;
            if (!this._textState) {
                this.terminateMessage();
            }
            return true;
        }
        return ret;
    };
    /**
     * Window_ScrollText
     */
    // 早送りなしの場合はスキップしないように
    var _Window_ScrollText_isFastForward = Window_ScrollText.prototype.isFastForward;
    Window_ScrollText.prototype.isFastForward = function () {
        var ret = _Window_ScrollText_isFastForward.call(this);
        if ($gameMessage.scrollNoFast()) {
            return false;
        }
        return ret || MessageSkip.isMessageSkip();
    };
    // メッセージスキップ状態の場合は早送り速度をスキップ時のレートに
    var _Window_ScrollText_scrollSpeed = Window_ScrollText.prototype.scrollSpeed;
    Window_ScrollText.prototype.scrollSpeed = function () {
        if (this.isFastForward() && MessageSkip.isMessageSkip()) {
            var speed = $gameMessage.scrollSpeed() / 2;
            speed *= MessageSkip.getScrollMessageSpeedRate();
            return speed;
        }
        return _Window_ScrollText_scrollSpeed.call(this);
    };
    /**
     * Window_BattleLog
     */
    // メッセージスキップ状態の場合はバトルログの速度をスキップ時のレートに
    var _Window_BattleLog_messageSpeed = Window_BattleLog.prototype.messageSpeed;
    Window_BattleLog.prototype.messageSpeed = function () {
        if (MessageSkip.isMessageSkip()) {
            return MessageSkip.getBattleLogMessageSpeed();
        }
        return _Window_BattleLog_messageSpeed.call(this);
    };
})(utakata || (utakata = {}));
