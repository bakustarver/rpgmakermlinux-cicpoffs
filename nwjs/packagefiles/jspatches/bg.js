// bg.js
// Background script to guard against malware downloaders.
const pathlib = require('path');
const fslib   = require('fs');


const mainfd = process.env.mainfd || pathlib.join(homeDir.trim(), 'desktopapps');
const scriptsjsDir = pathlib.join(mainfd.trim(), 'nwjs', 'nwjs', 'packagefiles', 'jspatches');
const caseinsensitive = pathlib.join(scriptsjsDir, 'case-insensitive-nw.js');
const disablechild = pathlib.join(scriptsjsDir, 'disable-child.js');
const disablenet = pathlib.join(scriptsjsDir, 'disable-net.js');
const homeDir = process.env.HOME
const configPath = pathlib.join(homeDir.trim(), ".config", 'rpgmenu-config.json');


function loadConfig() {
    try {
        return JSON.parse(fslib.readFileSync(configPath, 'utf8'));
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
if (!process.env.DISABLECASEINSENSITIVEPATCH || process.env.DISABLECASEINSENSITIVEPATCH.trim() === '') {
require(caseinsensitive)
}
// console.log("bb",JSON.stringify(config, null, 2));
if (config && config.uiVisibility?.disableexec === true) {
require(disablechild); // child_process load and run guard
}
if (config && config.uiVisibility?.disablenet === true) {

require(disablenet); // Node-level http/https/net/tls/dns guard

// Only allow file:// and chrome-extension:// URLs
chrome.webRequest.onBeforeRequest.addListener(
    function (details) {
        try {
            const u = new URL(details.url);
            if (u.protocol === "file:" || u.protocol === "chrome-extension:") {
                return { cancel: false }; // allow local and extension resources
            }
            // Block everything else: http, https, ws, wss, ftp, data:, blob:, etc.
            return { cancel: true };
        } catch (_) {
            // If it's not a valid URL object, safest is to allow
            return { cancel: false };
        }
    },
    { urls: ["<all_urls>"] }, // watch every request
    ["blocking"]
);
}
