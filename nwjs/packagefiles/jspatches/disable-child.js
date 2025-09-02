// disable-child.js
// Guard against requiring or using child_process in any way.
global.execDisabled = true;
const Module = require("module");
const origRequire = Module.prototype.require;

function showPopup(msg) {
    try {
        if (typeof window !== "undefined") {
            alert(msg);
            console.error(msg);
        } else {
            console.error(msg);
        }
    } catch (e) {
        console.error("Popup failed:", e);
    }
}

Module.prototype.require = function (id) {
    if (id === "child_process" || id === "node:child_process") {
        showPopup("⚠️ Attempt to load child_process was blocked!");
        throw new Error("child_process is disabled in this runtime");
    }
    return origRequire.apply(this, arguments);
};

// If anything already obtained a reference, neuter the methods.
try {
    const cp = origRequire.call({}, "node:child_process");
    for (const k of ["exec", "execFile", "spawn", "fork", "spawnSync", "execSync", "execFileSync"]) {
        if (k in cp) {
            cp[k] = function () {
                showPopup("⚠️ Attempt to use child_process." + k + "() was blocked!");
                throw new Error("child_process is disabled");
            };
        }
    }
} catch (_) {
    /* ignore if loading itself throws */
}
