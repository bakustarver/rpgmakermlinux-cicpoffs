const fs   = require('fs');
const path = require('path');

// Ensure baseDir is available (injectjsend.js sets process.env.mainfd)
const baseDir = process.env.mainfd || process.env.mainfdrpgmlinux || '';

// Normalize and provide fallback script directory variables used below
const homeDirrpgmlinux = process.env.HOME || '';
const mainfdrpgmlinux = process.env.mainfdrpgmlinux || path.join(homeDirrpgmlinux.trim(), 'desktopapps');
const scriptsDirrpgmlinux = path.join(baseDir.trim(), 'nwjs', 'nwjs', 'packagefiles','jspatches', 'js-scripts');
const scriptsDir = scriptsDirrpgmlinux; // used by executeScript
const configPathrpgmlinux = path.join(homeDirrpgmlinux.trim(), ".config", 'rpgmenu-config.json');
const plugins_autoload_path = path.join(baseDir.trim(), 'nwjs', 'nwjs', 'packagefiles','jspatches', 'plugins_autoload');

function loadConfigrpgm() {
  try {
    const cfg = JSON.parse(fs.readFileSync(configPathrpgmlinux, 'utf8'));
    // Backwards-compat: if old uiVisibility exists, derive menuHidden from it
    if (typeof cfg.menuHidden === 'undefined' && cfg.uiVisibility) {
      const keys = ['scriptSelect','executeButton','resultDisplay','infoButton'];
      const allHidden = keys.every(k => cfg.uiVisibility[k] === false);
      cfg.menuHidden = !!allHidden;
      delete cfg.uiVisibility;
      try { fs.writeFileSync(configPathrpgmlinux, JSON.stringify(cfg, null, 2), 'utf8'); } catch (e) {}
    }
    // Ensure fields exist
    cfg.lastScript = cfg.lastScript || null;
    cfg.menuHidden = !!cfg.menuHidden;
    cfg.disableexec = !!cfg.disableexec;
    cfg.disablenet = !!cfg.disablenet;
    return cfg;
  } catch {
    // default visibility: all shown
    return {
      lastScript: null,
      menuHidden: true,
      disableexec: false,
      disablenet: false
    };
  }
}

function saveConfigrpgm(cfg) {
  try {
    // Persist minimal shape: lastScript, menuHidden, and any global flags you want to keep
    const out = {
      lastScript: cfg.lastScript || null,
      menuHidden: !!cfg.menuHidden,
      disableexec: !!cfg.disableexec,
      disablenet: !!cfg.disablenet
    };
    fs.writeFileSync(configPathrpgmlinux, JSON.stringify(out, null, 2), 'utf8');
  } catch (err) {
    console.error('Failed to save config:', err);
  }
}

/**
 * Unified executeScript
 * Accepts either a filename (relative to scriptsDir) or an absolute/full path.
 * If the argument is a directory entry name (no path separators and not absolute),
 * it will be resolved against scriptsDir. Otherwise it will be used as given.
 */
function executeScript(filename, options = {}) {
    const scriptsDir = options.scriptsDir || scriptsDirrpgmlinux;
    const fullPath = path.isAbsolute(filename) ? filename : path.join(scriptsDir, filename);
    const pluginKey = path.basename(filename).replace(/\.js$/i, '');

    // Parse header comment for @param and @default and for tag like <MBS MapZoom>
    function parseHeader(src) {
        const result = { defaults: {}, tag: null };
        const headerMatch = src.match(/\/\*:[\s\S]*?\*\//);
        if (!headerMatch) return result;
        const header = headerMatch[0];

        const tagMatch = header.match(/<([^>]+)>/);
        if (tagMatch) result.tag = tagMatch[1].trim();

        const paramRegex = /@param\s+([^\r\n]+)/g;
        const defaultRegex = /@default\s+([^\r\n]+)/g;
        const params = [];
        let m;
        while ((m = paramRegex.exec(header)) !== null) params.push(m[1].trim());
        const defaults = [];
        while ((m = defaultRegex.exec(header)) !== null) defaults.push(m[1].trim());

        for (let i = 0; i < params.length; i++) {
            result.defaults[params[i]] = (i < defaults.length) ? defaults[i] : '';
        }
        return result;
    }

    // Read file
    let src;
    try {
        src = fs.readFileSync(fullPath, 'utf8');
    } catch (err) {
        console.error('executeScript: failed to read file', fullPath, err);
        throw err;
    }

    const parsed = parseHeader(src);
    const extractedDefaults = parsed.defaults;
    const headerTag = parsed.tag; // e.g., "MBS MapZoom"

    // Save originals to restore later (use defensive type checks)
    const hadPluginManager = typeof window.PluginManager !== 'undefined';
    const originalParameters = (hadPluginManager && typeof PluginManager.parameters === 'function') ? PluginManager.parameters : null;
    const hadPluginsArray = Array.isArray(window.$plugins);
    const originalPlugins = hadPluginsArray ? window.$plugins.slice() : null;

    // Build injection snippet (defensive: only call original if it's a function)
    const injection = (function(pluginKey, defaults, headerTag) {
        // Escape JSON safely
        const defaultsJson = JSON.stringify(defaults || {});
        const pluginKeyJson = JSON.stringify(pluginKey);
        const headerTagJson = JSON.stringify(headerTag);

        return `
        (function(){
            try {
                // Safe accessor for original PluginManager.parameters
                function _callOrigParameters(name) {
                    try {
                        if (typeof PluginManager !== 'undefined' && typeof PluginManager.parameters === 'function') {
                            return PluginManager.parameters(name) || {};
                        }
                    } catch (e) {
                        console.warn('PluginManager.parameters threw', e);
                    }
                    return {};
                }

                var _defaults = ${defaultsJson};
                var _pluginKey = ${pluginKeyJson};
                var _headerTag = ${headerTagJson};

                // Temporary parameters wrapper that delegates to the safe accessor
                function _tempParameters(name) {
                    var p = {};
                    try {
                        p = _callOrigParameters(name) || {};
                    } catch (e) {
                        p = {};
                    }
                    if (name === _pluginKey) {
                        for (var k in _defaults) {
                            if (typeof p[k] === 'undefined' || p[k] === null || p[k] === '') {
                                p[k] = _defaults[k];
                            }
                        }
                    }
                    return p;
                }

                // Install wrapper or create PluginManager if missing
                if (typeof PluginManager === 'undefined') {
                    window.PluginManager = { parameters: _tempParameters };
                    window.___tempCreatedPluginManager = true;
                } else {
                    // Only replace parameters with our wrapper if it's not already our wrapper
                    try {
                        if (PluginManager.parameters !== _tempParameters) {
                            // store original on the PluginManager object for potential restore
                            if (!PluginManager.___orig_parameters_saved) {
                                PluginManager.___orig_parameters_saved = PluginManager.parameters;
                            }
                            PluginManager.parameters = _tempParameters;
                        }
                    } catch (e) {
                        console.warn('Could not replace PluginManager.parameters', e);
                    }
                }

                // If plugin header tag exists (e.g., <MBS MapZoom>), ensure $plugins has an entry
                if (_headerTag) {
                    if (!Array.isArray(window.$plugins)) window.$plugins = [];
                    var found = window.$plugins.find(function(p){ return p && p.description && p.description.indexOf('<' + _headerTag + '>') !== -1; });
                    if (!found) {
                        var paramsObj = {};
                        for (var k2 in _defaults) paramsObj[k2] = _defaults[k2];
                        var entry = {
                            name: _pluginKey,
         status: true,
         description: '<' + _headerTag + '>',
         parameters: paramsObj
                        };
                        window.$plugins.push(entry);
                        window.___tempAddedPluginEntry = entry;
                    } else {
                        for (var k3 in _defaults) {
                            if (typeof found.parameters[k3] === 'undefined' || found.parameters[k3] === null || found.parameters[k3] === '') {
                                found.parameters[k3] = _defaults[k3];
                            }
                        }
                    }
                }
            } catch (e) {
                console.error('executeScript injection error', e);
            }
        })();\n`;
    })(pluginKey, extractedDefaults, headerTag);

    // Create blob with injection + original source
    const finalSrc = injection + '\n' + src;
    const blob = new Blob([finalSrc], { type: 'application/javascript' });
    const blobURL = URL.createObjectURL(blob);
    const script = document.createElement('script');
    script.src = blobURL;
    script.async = false;

    // Cleanup and restore function (robust)
    function restoreEnvironment() {
        try {
            // Restore PluginManager.parameters
            try {
                if (originalParameters && typeof PluginManager !== 'undefined') {
                    PluginManager.parameters = originalParameters;
                } else if (window.___tempCreatedPluginManager) {
                    // We created the whole PluginManager object; remove it
                    try { delete window.PluginManager; } catch (e) { window.PluginManager = undefined; }
                    delete window.___tempCreatedPluginManager;
                } else if (typeof PluginManager !== 'undefined' && PluginManager.___orig_parameters_saved) {
                    // Restore any saved original
                    try { PluginManager.parameters = PluginManager.___orig_parameters_saved; } catch (e) {}
                    try { delete PluginManager.___orig_parameters_saved; } catch (e) {}
                } else {
                    // If PluginManager exists but we replaced parameters with our wrapper, attempt to remove it safely
                    try {
                        if (typeof PluginManager !== 'undefined' && PluginManager.parameters && PluginManager.parameters.name === '_tempParameters') {
                            try { delete PluginManager.parameters; } catch (e) { PluginManager.parameters = undefined; }
                        }
                    } catch (e) {}
                }
            } catch (e) {
                console.error('executeScript: error restoring PluginManager.parameters', e);
            }

            // Remove any plugin entry we added to $plugins
            if (window.___tempAddedPluginEntry && Array.isArray(window.$plugins)) {
                var idx = window.$plugins.indexOf(window.___tempAddedPluginEntry);
                if (idx !== -1) window.$plugins.splice(idx, 1);
                delete window.___tempAddedPluginEntry;
            }

            // If we created $plugins from nothing, restore original
            if (!hadPluginsArray && Array.isArray(window.$plugins) && originalPlugins === null) {
                try { delete window.$plugins; } catch (e) { window.$plugins = undefined; }
            }

            // Clean any saved markers
            try { delete PluginManager.___orig_parameters_saved; } catch (e) {}
        } catch (e) {
            console.error('executeScript: restoreEnvironment error', e);
        }
    }

    // Attach handlers
    script.onload = function() {
        try {
            URL.revokeObjectURL(blobURL);
            if (script.parentNode) script.parentNode.removeChild(script);
        } catch (e) {}
        restoreEnvironment();
        console.log('executeScript: loaded', filename);
    };

    script.onerror = function(err) {
        try {
            URL.revokeObjectURL(blobURL);
            if (script.parentNode) script.parentNode.removeChild(script);
        } catch (e) {}
        restoreEnvironment();
        console.error('executeScript: failed to load', filename, err);
    };

    // Append and execute
    document.body.appendChild(script);

    // Return extracted defaults for caller inspection
    return extractedDefaults;
}


// --- begin: automatic preload from plugins_autoload ---
function autoloadplugins() {
    try {
        if (fs.existsSync(plugins_autoload_path)) {
            const preloadFiles = fs.readdirSync(plugins_autoload_path)
            .filter(f => f.toLowerCase().endsWith('.js'))
            .sort((a, b) => a.localeCompare(b, undefined, { sensitivity: 'base' }));

            if (preloadFiles.length === 0) {
                // console.log(`Preload folder is empty: ${plugins_autoload_path}`);
                return;
            }

            preloadFiles.forEach(f => {
                const fullPath = path.join(plugins_autoload_path, f);
                try {
                    executeScript(fullPath);
                } catch (err) {
                    console.error(`Failed to preload script ${fullPath}:`, err);
                }
            });

            console.log(`Preloaded ${preloadFiles.length} plugin(s) from ${plugins_autoload_path}`);
        } else {
            console.log(`Preload folder not found: ${plugins_autoload_path}`);
        }
    } catch (err) {
        console.error('Error while preloading plugins:', err);
    }
}

// --- UI injection and menu logic ---

const configrpgm = loadConfigrpgm();

function injectmenu() {
    // helper to persist visibility state for the whole menu (menuHidden)
    function setVisibility(hidden) {
        const v = hidden ? 'hidden' : 'visible';
        try { if (typeof scriptSelect !== 'undefined' && scriptSelect) scriptSelect.style.visibility  = v; } catch (e) {}
        try { if (typeof executeButton !== 'undefined' && executeButton) executeButton.style.visibility = v; } catch (e) {}
        try { if (typeof resultDisplay !== 'undefined' && resultDisplay) resultDisplay.style.visibility = v; } catch (e) {}
        try { if (typeof infoButton !== 'undefined' && infoButton) infoButton.style.visibility = v; } catch (e) {}
        configrpgm.menuHidden = !!hidden;
        try { if (typeof saveConfigrpgm === 'function') saveConfigrpgm(configrpgm); } catch (e) {}
        try { localStorage.setItem('menuHidden', hidden); } catch (e) {}
    }

    // read and sort scripts
    let scriptFiles = [];
    try {
        const files = fs.readdirSync(scriptsDirrpgmlinux);
        scriptFiles = files
        .map(f => ({ file: f, mtime: fs.statSync(path.join(scriptsDirrpgmlinux, f)).mtime }))
        .sort((a, b) => b.mtime - a.mtime)
        .map(e => e.file);
    } catch (err) {
        console.error('Failed to read scripts directory:', err);
    }

    // build UI elements
    const container     = document.createElement('div');
    container.style.position = 'fixed';
    container.style.top      = '10px';
    container.style.right    = '10px';
    container.style.padding  = '10px';
    container.style.zIndex   = '10000'; // base UI z-index
    // container.style.backgroundColor = 'transparent';
    container.style.border          = 'none';
    container.style.display = 'flex';
    container.style.alignItems = 'flex-start';
    // container.style.gap = '0px';
    container.style.boxSizing = 'border-box';
    container.style.maxWidth = 'calc(100vw - 40px)';

    // create UI elements (select, execute button, info button, etc.)
    const scriptSelect  = document.createElement('select');

    const executeButton = document.createElement('button');
    executeButton.textContent = 'Execute Script';
    executeButton.style.flex = '0 0 auto';

    const infoButton = document.createElement('button');
    infoButton.textContent = '💬';
    infoButton.style.backgroundColor = 'transparent';
    infoButton.style.border = 'none'; // removes border
     infoButton.style.outline = 'none'; // removes focus outline
     infoButton.style.boxShadow = 'none';
     infoButton.style.fontSize = '16px';
    // infoButton.style.fontSize = '12px';
    infoButton.title = 'Show plugin description';
    // infoButton.style.flex = '0 0 auto';


    const resultDisplay = document.createElement('div');
    resultDisplay.style.color = 'white';
    resultDisplay.style.maxWidth = '11em';


    // Group reference for the main UI controls
    const uiControls = { scriptSelect, executeButton, resultDisplay, infoButton };

    // Simple per-element visibility setter (no per-control persistence)
    function setElementVisibility(el, visible) {
      if (!el) return;
      el.style.visibility = visible ? 'visible' : 'hidden';
    }

    // Show/hide the whole group and persist single flag menuHidden
    function setGroupVisibility(visible) {
      // visible === true => controls visible; menuHidden should be false
      Object.keys(uiControls).forEach(k => setElementVisibility(uiControls[k], !!visible));
      configrpgm.menuHidden = !visible;
      try { if (typeof saveConfigrpgm === 'function') saveConfigrpgm(configrpgm); } catch (e) {}
    }

    // create a right-side vertical stack where Execute is on top and Info sits below it
    const rightStack = document.createElement('div');
    rightStack.style.display = 'flex';
    // rightStack.style.flexDirection = 'column';
    // rightStack.style.gap = '2px';
    rightStack.style.alignItems = 'flex-start';

    // ensure execute button stays at the same horizontal position as before:
    // we wrap executeButton in a container that preserves its width and alignment
    const execWrapper = document.createElement('div');
    execWrapper.appendChild(executeButton);

    // place info button below execute button
    const infoWrapper = document.createElement('div');
    infoWrapper.style.display = 'flex';
    infoWrapper.style.alignItems = 'center';
    infoWrapper.appendChild(infoButton);

    // --- Large modal + backdrop for Info ---

    const infoBackdrop = document.createElement('div');
    infoBackdrop.style.position = 'fixed';
    infoBackdrop.style.left = '0';
    infoBackdrop.style.top = '0';
    infoBackdrop.style.width = '100vw';
    infoBackdrop.style.height = '100vh';
    infoBackdrop.style.backgroundColor = 'rgba(0,0,0,0.6)';
    infoBackdrop.style.zIndex = '10001';
    infoBackdrop.style.display = 'none';

    const infoPopup = document.createElement('div');
    infoPopup.style.position = 'fixed';
    infoPopup.style.left = '50%';
    infoPopup.style.top = '50%';
    infoPopup.style.transform = 'translate(-50%, -50%)';
    infoPopup.style.width = '80vw';
    infoPopup.style.maxWidth = '980px';
    infoPopup.style.height = '72vh';
    infoPopup.style.padding = '18px';
    infoPopup.style.backgroundColor = 'rgba(18,18,18,0.98)';
    infoPopup.style.color = 'white';
    infoPopup.style.borderRadius = '8px';
    infoPopup.style.boxShadow = '0 8px 30px rgba(0,0,0,0.7)';
    infoPopup.style.zIndex = '10002';
    infoPopup.style.display = 'none';
    infoPopup.style.overflow = 'auto';
    infoPopup.style.whiteSpace = 'pre-wrap';
    infoPopup.style.fontSize = '13px';
    infoPopup.style.lineHeight = '1.45';
    infoPopup.tabIndex = -1;

    const infoHeader = document.createElement('div');
    infoHeader.style.display = 'flex';
    infoHeader.style.alignItems = 'center';
    infoHeader.style.justifyContent = 'space-between';
    infoHeader.style.marginBottom = '10px';

    const infoTitle = document.createElement('div');
    infoTitle.textContent = 'Script Info';
    infoTitle.style.fontWeight = '600';
    infoTitle.style.fontSize = '15px';
    infoTitle.style.userSelect = 'text';


    const closeBtn = document.createElement('button');
    closeBtn.textContent = 'Close';
    closeBtn.style.background = '#333';
    closeBtn.style.color = '#fff';
    closeBtn.style.border = 'none';
    closeBtn.style.padding = '6px 10px';
    closeBtn.style.borderRadius = '6px';
    closeBtn.style.cursor = 'pointer';

    infoHeader.appendChild(infoTitle);
    infoHeader.appendChild(closeBtn);

    const infoContent = document.createElement('div');
    infoContent.style.whiteSpace = 'pre-wrap';
    infoContent.style.fontSize = '13px';
    infoContent.style.color = 'white';
    infoContent.style.userSelect = 'text';
    infoContent.style.webkitUserSelect = 'text';
    infoContent.style.MozUserSelect = 'text';
    infoContent.style.msUserSelect = 'text';
    infoContent.style.cursor = 'text';
    infoContent.style.wordBreak = 'break-word';

    infoPopup.appendChild(infoHeader);
    infoPopup.appendChild(infoContent);

    // append container and modal elements
    if (!window.opener) {
        document.body.appendChild(container);
    }
    document.body.appendChild(infoBackdrop);
    document.body.appendChild(infoPopup);

    // helper to resolve selected file to full path
    function resolveSelectedPath(nameOrPath) {
        const looksLikeRelativeName = !path.isAbsolute(nameOrPath) && nameOrPath.indexOf(path.sep) === -1;
        return looksLikeRelativeName ? path.join(scriptsDirrpgmlinux, nameOrPath) : nameOrPath;
    }

    // helper to extract description/help from plugin file content
    // Improved metadata extraction for RPG Maker style plugin files
    function extractPluginDescription(src) {
        let metaBlockMatch = src.match(/\/\*:[\s\S]*?\*\//);

        if (!metaBlockMatch) {
            metaBlockMatch = src.match(/\/\*[\s\S]*?\*\//);
        }
        let descriptionParts = [];

        let plugdescText = null;
        let helpText = null;
        let authorText = null;
        let urlText = null;


        // Track all URLs globally
        let seenUrls = new Set();

        // Helper to strip duplicate URLs from a block of text
        function dedupeUrlsFromText(text) {
            return text
            .split('\n')
            .filter(line => {
                const urlMatch = line.match(/https?:\/\/\S+/);
                if (urlMatch) {
                    const url = urlMatch[0];
                    if (seenUrls.has(url)) return false;
                    seenUrls.add(url);
                }
                return true;
            })
            .join('\n')
            .trim();
        }

        if (metaBlockMatch) {
            const block = metaBlockMatch[0];
            const helpBlock = block.match(/@help([\s\S]*?)$/i);
            const authorMatch = block.match(/@author\s+([^\r\n]+)/i);
            const urloMatch = block.match(/@url\s+([^\r\n]+)/i);
            const plugdescMatch = block.match(/@plugindesc\s+([^\r\n]+)/i);
            const descMatch = block.match(/@desc\s+([^\r\n]+)/i);

            let plugdesc = '';
            if (plugdescMatch) {
                plugdesc = plugdescMatch[1] // capture group for plugindesc
            }

            if (descMatch) {
                plugdesc += '\n' + descMatch[1] // append desc if present
            }



            if (plugdesc) plugdescText = plugdesc.trim();
            if (authorMatch) authorText = authorMatch[1].trim();
            if (urloMatch) urlText = urloMatch[1].trim();

            if (helpBlock) {
                helpText = helpBlock[1]
                .replace(/\*\/$/, '')
                .split('\n')
                .map(line => line.replace(/^\s*\*\s?/, ''))
                .join('\n')
                .trim();
                helpText = dedupeUrlsFromText(helpText);
            }

            if (!plugdesc && !helpBlock) {
                helpText = block.replace(/^\/\*:?/, '').replace(/\*\/$/, '').trim();
                helpText = dedupeUrlsFromText(helpText);
            }
        }

        // Capture metadata lines (Version, LastUpdate, Author, Website, License)
        let metaLines = src.match(/\/\/.*?(Version|LastUpdate|Author|Website|License).*$/gmi);
        if (metaLines) {
            metaLines = metaLines.map(line => line.replace(/^\/\/\s?/, '').trim());
            metaLines = dedupeUrlsFromText(metaLines.join('\n')).split('\n');
        }

        // Capture all link lines (plain // http... or labeled [Blog], [Twitter], [GitHub])
        let linkLines = src.match(/\/\/.*?http.*$/gmi);
        let uniqueLinks = [];
        if (linkLines) {
            uniqueLinks = linkLines.map(line => line.replace(/^\/\/\s?/, '').trim());
            uniqueLinks = dedupeUrlsFromText(uniqueLinks.join('\n')).split('\n');
        }

        // Build output order: plugdesc → author → metaLines → links → helpText
        if (plugdescText) descriptionParts.push(plugdescText);
        if (authorText) descriptionParts.push("Author: " + authorText);
        if (urlText) descriptionParts.push("Website: " + urlText);

        if (metaLines && metaLines.length) descriptionParts.push(metaLines.join('\n').trim());
        if (uniqueLinks.length) descriptionParts.push("Links:\n" + uniqueLinks.join('\n'));
        if (helpText) descriptionParts.push(helpText);

        if (descriptionParts.length) {
            return descriptionParts.join('\n\n');
        }

        return 'No description found in this script.';
    }













    // helper to extract a plugin name; prefer metadata @name or @plugindesc, otherwise filename
    function extractPluginName(src, filename) {
        try {
            const base = filename ? filename.replace(/\.[^/.]+$/, "") : '';
            if (base) return base;
        } catch (e) {}
        return 'Script Info';
    }

    // showInfo opens the modal and fills content; accepts optional title override
    function showInfo(text, title) {
        infoContent.textContent = text || 'No description available.';
        infoTitle.textContent = title || 'Script Info';
        infoBackdrop.style.display = 'block';
        infoPopup.style.display = 'block';
        infoBackdrop.style.zIndex = '10001';
        infoPopup.style.zIndex = '10002';
        try { document.body.style.overflow = 'hidden'; } catch (e) {}
        try { infoPopup.focus(); } catch (e) {}
    }

    // close handler
    function closeInfo() {
        infoPopup.style.display = 'none';
        infoBackdrop.style.display = 'none';
        try { document.body.style.overflow = ''; } catch (e) {}
    }

    // wire close button and backdrop click to close
    closeBtn.addEventListener('click', closeInfo);
    infoBackdrop.addEventListener('click', closeInfo);

    // close on Escape key
    document.addEventListener('keydown', (ev) => {
        if (ev.key === 'Escape' && infoPopup.style.display === 'block') {
            closeInfo();
        }
    });

    // populate select options
    scriptFiles.forEach(name => {
        const opt = document.createElement('option');
        opt.value       = name;
        opt.textContent = name;
        scriptSelect.appendChild(opt);
    });

    scriptSelect.addEventListener('change', () => {
        configrpgm.lastScript = scriptSelect.value;
        try { if (typeof saveConfigrpgm === 'function') saveConfigrpgm(configrpgm); } catch (e) {}
    });

    const COOL_DOWN_MS = 200;           // button cool-down time
    let isCoolingDown = false;
    executeButton.addEventListener('click', () => {
        if (isCoolingDown) return;
        isCoolingDown = true;
        executeButton.disabled = true;
        try {
            if (typeof executeScript === 'function') {
                executeScript(scriptSelect.value);
                resultDisplay.textContent = `${scriptSelect.value} executed.`;
            } else {
                throw new Error('executeScript not available');
            }
        } catch (err) {
            resultDisplay.textContent = `Error: ${err.message}`;
        }
        setTimeout(() => { resultDisplay.textContent = ''; }, 800);
        setTimeout(() => { isCoolingDown = false; executeButton.disabled = false; }, COOL_DOWN_MS);
    });

    // wire up info button to read file and show modal; set modal title to plugin name
    infoButton.addEventListener('click', () => {
        const sel = scriptSelect.value;
        if (!sel) {
            showInfo('No script selected.', 'Script Info');
            return;
        }
        const fullPath = resolveSelectedPath(sel);
        try {
            if (!fs.existsSync(fullPath)) {
                showInfo(`Script not found: ${fullPath}`, sel.replace(/\.[^/.]+$/, ""));
                return;
            }
            const src = fs.readFileSync(fullPath, 'utf8');
            const desc = extractPluginDescription(src);
            const pluginName = extractPluginName(src, sel);
            showInfo(desc, pluginName);
        } catch (err) {
            showInfo(`Failed to read script: ${err.message}`, sel.replace(/\.[^/.]+$/, ""));
        }
    });

    // --- Assemble controls: left stack (select + result) and right stack (exec + info) ---
    const leftStack = document.createElement('div');
    leftStack.style.flex = '1 1 auto';
    leftStack.style.minWidth = '0';


    // left column: select and result
    leftStack.appendChild(scriptSelect);
    leftStack.appendChild(resultDisplay);



    // right column: Execute on top, Info below
    rightStack.appendChild(infoWrapper);
    rightStack.appendChild(execWrapper);

    // append left and right stacks to the container
    container.append(leftStack, rightStack);

    // apply saved visibility state (menuHidden)
    try { setVisibility(!!configrpgm.menuHidden); } catch (e) {}

    if (configrpgm.lastScript) {
        try { scriptSelect.value = configrpgm.lastScript; } catch (e) {}
    }

    // Apply saved state (menuHidden) using group helper
    try {
      setGroupVisibility(!configrpgm.menuHidden);
    } catch (e) {
      setGroupVisibility(true);
    }

    // F10 toggles the whole group
    document.addEventListener('keydown', event => {
      if (event.key === 'F10') {
        const newVisible = !!configrpgm.menuHidden; // if currently hidden => show
        setGroupVisibility(newVisible);
      }
    });
}
setTimeout(autoloadplugins, 400);
setTimeout(injectmenu, 500);
