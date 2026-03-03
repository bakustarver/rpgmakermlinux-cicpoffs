//=============================================================================
// cheatbuttons
//=============================================================================
/*:
 * @url https://github.com/bakustarver/rpgmakermlinux-cicpoffs/blob/main/nwjs/packagefiles/jspatches/js-scripts/cheatbuttons.js
 *
 * @help
 * Adds a small on-screen debug panel with buttons to modify gold, player speed,
 * force battle victory, open save/load/debug screens, toggle debug walking, return to title,
 * and reload the game.
 *
 *
 * Click buttons to perform common development actions at runtime:
 * - Set party gold to 1,000,000
 * - Set player move speed to 6
 * - Force a battle victory
 * - Open Save or Load scenes
 * - Toggle debug walking (walk-through)
 * - Open the Debug scene
 * - Return to the Title screen
 * - Reload Game
 *
 */
    if (window.Utils && Utils.RPGMAKER_NAME) {


        // Create a button and add it to the body of the original page
        const buttonHtml = `
        <button id="setGoldButton" style="position: fixed; top: 180px; right: 10px; z-index: 1000000;">Set Gold to 1000000</button>
        <button id="setSpeedButton" style="position: fixed; top: 220px; right: 10px; z-index: 1000000;">Set Speed to 6</button>
        <button id="winBattleButton" style="position: fixed; top: 260px; right: 10px; z-index: 1000000;">Win Battle</button>
        <button id="saveScreenButton" style="position: fixed; top: 300px; right: 10px; z-index: 1000000;">Save Screen</button>
        <button id="loadScreenButton" style="position: fixed; top: 340px; right: 10px; z-index: 1000000;">Load Screen</button>
        <button id="returntothemenu" style="position: fixed; top: 380px; right: 10px; z-index: 1000000;">Return to Title</button>
        <button id="debugWalkButton" style="position: fixed; top: 420px; right: 10px; z-index: 1000000;">Enable Debug Walking</button>
        <button id="debugscreenbutton" style="position: fixed; top: 460px; right: 10px; z-index: 1000000;">Debug Screen</button>
        <button id="reloadthepage" style="position: fixed; top: 500px; right: 10px; z-index: 1000000;">Reload Game</button>


        `;

        document.body.insertAdjacentHTML('beforeend', buttonHtml);

        // Add event listeners to the buttons
        document.getElementById('setGoldButton').addEventListener('click', function() {
            if (typeof $gameParty !== 'undefined') {
                $gameParty._gold = 1000000;
                //alert('Gold set to 1000000!');
            } else {
                alert('$gameParty is not defined.');
            }
            document.getElementById('setGoldButton').disabled = false;
            document.getElementById('setGoldButton').blur()
        });

        document.getElementById('setSpeedButton').addEventListener('click', function() {
            if (typeof $gamePlayer !== 'undefined') {
                $gamePlayer.setMoveSpeed(6, true);
                //alert('Speed set to 6!');
            } else {
                alert('$gamePlayer is not defined.');
            }
            document.getElementById('setSpeedButton').disabled = false;
            document.getElementById('setSpeedButton').blur()
        });

        document.getElementById('winBattleButton').addEventListener('click', function() {
            if (typeof BattleManager !== 'undefined') {
                BattleManager.processVictory();
                alert('Battle won!');
            } else {
                alert('BattleManager is not defined.');
            }
            document.getElementById('winBattleButton').disabled = false;
            document.getElementById('winBattleButton').blur()
        });

        document.getElementById('saveScreenButton').addEventListener('click', function() {
            if (typeof SceneManager !== 'undefined') {
                SceneManager.push(Scene_Save);
            } else {
                alert('SceneManager is not defined.');
            }
            document.getElementById('saveScreenButton').disabled = false;
            document.getElementById('saveScreenButton').blur()
        });

        document.getElementById('loadScreenButton').addEventListener('click', function() {
            if (typeof SceneManager !== 'undefined') {
                SceneManager.push(Scene_Load);
                //alert('Navigating to Load Screen...');
            } else {
                alert('SceneManager is not defined.');
            }
            document.getElementById('loadScreenButton').disabled = false;
            document.getElementById('loadScreenButton').blur()
        });

        // Define the debug walking function
        let debugWalkingEnabled = false;
        // Add event listener for the debug walking button
        document.getElementById('debugWalkButton').addEventListener('click', function() {
            debugWalkingEnabled = !debugWalkingEnabled; // Toggle state

            $gamePlayer.isDebugThrough = function() {
                return debugWalkingEnabled;
            };
             this.textContent = debugWalkingEnabled ? "Disable Debug Walking" : "Enable Debug Walking";
            document.getElementById('debugWalkButton').disabled = false;
            document.getElementById('debugWalkButton').blur()
        });


        document.getElementById('debugscreenbutton').addEventListener('click', function() {
            if (typeof SceneManager !== 'undefined') {
                SceneManager.push(Scene_Debug);
            } else {
                alert('SceneManager is not defined.');
            }
            document.getElementById('debugscreenbutton').disabled = false;
            document.getElementById('debugscreenbutton').blur()
        });

        document.getElementById('reloadthepage').addEventListener('click', function() {
            location.reload();
        });
        document.getElementById('returntothemenu').addEventListener('click', function() {
            if (typeof SceneManager !== 'undefined') {
                // SceneManager.push(Scene_GameEnd);
                // Scene_Base.prototype.fadeOutAll();
                SceneManager._scene.fadeOutAll();
                SceneManager.goto(Scene_Title);
                Window_TitleCommand.initCommandPosition();
            } else {
                alert('SceneManager is not defined.');
            }
            document.getElementById('debugscreenbutton').disabled = false;
            document.getElementById('debugscreenbutton').blur()
        });

    };
