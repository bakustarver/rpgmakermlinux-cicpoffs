const path = require('path');
const fs   = require('fs');

const homeDir = process.env.HOME
const mainfd = process.env.mainfd || path.join(homeDir.trim(), 'desktopapps');
const scriptsDir = path.join(baseDir.trim(), 'nwjs', 'nwjs', 'packagefiles','jspatches', 'js-scripts');
const configPath = path.join(homeDir.trim(), ".config", 'rpgmenu-config.json');

function loadConfig() {
    try {
        return JSON.parse(fs.readFileSync(configPath, 'utf8'));
    } catch {
        // default visibility: all shown
        return {
            lastScript: null,
            uiVisibility: {
                scriptSelect: true,
                executeButton: true,
                disableexec: true,
                disablenet: false,
                resultDisplay: true
            }
        };
    }
}

function saveConfig(cfg) {
    try {
        fs.writeFileSync(configPath, JSON.stringify(cfg, null, 2), 'utf8');
    } catch (err) {
        console.error('Failed to save config:', err);
    }
}

const config = loadConfig();

function setElementVisibility(el, key, visible) {
    el.style.visibility = visible ? 'visible' : 'hidden';
    config.uiVisibility[key] = visible;
    saveConfig(config);
}

function injectmenu() {
    function setVisibility(hidden) {
        const v = hidden ? 'hidden' : 'visible';
        scriptSelect.style.visibility  = v;
        executeButton.style.visibility = v;
        resultDisplay.style.visibility = v;
        localStorage.setItem('menuHidden', hidden);
    }

    // function executeScript(name) {
    //     const fullPath = path.join(scriptsDir, name);
    //     const src      = fs.readFileSync(fullPath, 'utf8');
    //     eval(src);
    // }
    function executeScript(name) {
        const fullPath = path.join(scriptsDir, name);
        const src = fs.readFileSync(fullPath, 'utf8');

        // Create a Blob from the file content
        const blob = new Blob([src], { type: 'application/javascript' });

        // Create a Blob URL
        const blobURL = URL.createObjectURL(blob);

        // Now you can use the blobURL to create a script element
        const script = document.createElement('script');
        script.src = blobURL;

        // Append the script to the document to execute it
        document.body.appendChild(script);

        // Clean up the blob URL after execution
        script.onload = () => {
            URL.revokeObjectURL(blobURL);
            console.log('Blob script executed and URL revoked.');
        };
    }

    // read and sort scripts
    const files = fs.readdirSync(scriptsDir);
    const scriptFiles = files
    .map(f => ({ file: f, mtime: fs.statSync(path.join(scriptsDir, f)).mtime }))
    .sort((a, b) => b.mtime - a.mtime)
    .map(e => e.file);

    // build UI elements
    const container     = document.createElement('div');
    container.style.position = 'fixed';
    container.style.top      = '10px';
    container.style.right    = '10px';
    container.style.padding  = '10px';
    container.style.zIndex   = '10000';
    container.style.backgroundColor = 'transparent';
    container.style.border          = 'none';

    const scriptSelect  = document.createElement('select');
    const executeButton = document.createElement('button');
    executeButton.textContent = 'Execute Script';
    executeButton.style.marginLeft = '10px';

    const resultDisplay = document.createElement('div');
    resultDisplay.style.color = 'white';

    scriptFiles.forEach(name => {
        const opt = document.createElement('option');
        opt.value       = name;
        opt.textContent = name;
        scriptSelect.appendChild(opt);
    });

    scriptSelect.addEventListener('change', () => {
        config.lastScript = scriptSelect.value;
        saveConfig(config);
    });

    const COOL_DOWN_MS = 200;           // button cool-down time
    let isCoolingDown = false;
    executeButton.addEventListener('click', () => {
        // const config = loadConfig();

        // if we’re still in the cool-down window, ignore further clicks
        if (isCoolingDown) return;

        isCoolingDown = true;
        executeButton.disabled = true;    // disable button in UI

        try {
            executeScript(scriptSelect.value);
            resultDisplay.textContent = `${scriptSelect.value} executed.`;
        } catch (err) {
            resultDisplay.textContent = `Error: ${err.message}`;
        }

        // clear the result text after 800ms (your existing logic)
        setTimeout(() => {
            resultDisplay.textContent = '';
        }, 800);

        // re-enable after the cool-down expires
        setTimeout(() => {
            isCoolingDown = false;
            executeButton.disabled = false;
        }, COOL_DOWN_MS);
    });


    container.append(scriptSelect, executeButton, resultDisplay);

    if (!window.opener) {
    document.body.appendChild(container);
    }
    setVisibility(config.menuHidden);

    if (config.lastScript) {
        scriptSelect.value = config.lastScript;
        // optional automatic execution:
        // executeScript(config.lastScript);
    }
    setElementVisibility(scriptSelect,  'scriptSelect',  config.uiVisibility.scriptSelect);
    setElementVisibility(executeButton, 'executeButton', config.uiVisibility.executeButton);
    setElementVisibility(resultDisplay, 'resultDisplay', config.uiVisibility.resultDisplay)

    document.addEventListener('keydown', event => {
        if (event.key === 'F10') {
            ['scriptSelect','executeButton','resultDisplay'].forEach(key => {
                const el = { scriptSelect, executeButton, resultDisplay }[key];
                setElementVisibility(el, key, !config.uiVisibility[key]);
            });
        }
    });
}

setTimeout(injectmenu, 500);
