// bg.js
// Background script to guard against malware downloaders.
const pathlib = require('path');
const fslib   = require('fs');

// Resolve home and main directories safely
const homeDirrpgmlinuxn = (process.env.HOME || '').trim();
const mainfd = (process.env.mainfd || process.env.mainfdrpgmlinux || pathlib.join(homeDir || '', 'desktopapps')).trim();

// Paths to helper patches
const scriptsjsDir = pathlib.join(mainfd, 'nwjs', 'nwjs', 'packagefiles', 'jspatches');
const caseinsensitive = pathlib.join(scriptsjsDir, 'case-insensitive-nw.js');
const disablechild = pathlib.join(scriptsjsDir, 'disable-child.js');
const disablenet = pathlib.join(scriptsjsDir, 'disable-net.js');


// Config path
// const configPathrpgmlinuxnn = path.join(homeDirrpgmlinuxn.trim(), ".config", 'rpgmenu-config.json');

function loadConfigrpgm() {
    try {
        const raw = fslib.readFileSync(path.join(homeDirrpgmlinuxn.trim(), ".config", 'rpgmenu-config.json'), 'utf8');
        const cfg = JSON.parse(raw || '{}');

        // Backwards compatibility: if old uiVisibility exists, derive menuHidden
        if (typeof cfg.menuHidden === 'undefined' && cfg.uiVisibility) {
            const keys = ['scriptSelect','executeButton','resultDisplay','infoButton'];
            const allHidden = keys.every(k => cfg.uiVisibility[k] === false);
            cfg.menuHidden = !!allHidden;
            delete cfg.uiVisibility;
            try { fslib.writeFileSync(path.join(homeDirrpgmlinuxn.trim(), ".config", 'rpgmenu-config.json'), JSON.stringify(cfg, null, 2), 'utf8'); } catch (e) {}
        }

        // Ensure expected fields
        return {
            lastScript: typeof cfg.lastScript !== 'undefined' ? cfg.lastScript : null,
            menuHidden: !!cfg.menuHidden,
            disableexec: typeof cfg.disableexec !== 'undefined' ? !!cfg.disableexec : false,
            disablenet: typeof cfg.disablenet !== 'undefined' ? !!cfg.disablenet : false
        };
    } catch (e) {
        // Default config
        return {
            lastScript: null,
            menuHidden: true,
            disableexec: false,
            disablenet: false
        };
    }
}

const configrpgm = loadConfigrpgm();
if (!process.env.DISABLECASEINSENSITIVEPATCH || process.env.DISABLECASEINSENSITIVEPATCH.trim() === '') {
require(caseinsensitive)

}
// console.log("bb",JSON.stringify(config, null, 2));
if (configrpgm && configrpgm.disableexec === true) {
require(disablechild); // child_process load and run guard
}
if (configrpgm && configrpgm.disablenet === true) {

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
