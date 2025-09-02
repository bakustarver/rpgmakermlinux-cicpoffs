// disable-net.js
// Block all nodejs outbound connections to prevent downloading.
const Module = require("module");
const origRequire = Module.prototype.require;
global.netDisabled = true;

function showPopup(msg) {
    try {
        if (typeof window !== "undefined") {
            alert(msg);
            console.error(msg);
        } else console.error(msg);
    } catch (e) {
        console.error("Popup failed:", e);
    }
}

const ALLOW = new Set(["127.0.0.1", "::1", "localhost"]);
function isAllowedHost(host) {
    if (!host) return false;
    try {
        return ALLOW.has(host.toLowerCase());
    } catch {
        return false;
    }
}

function block(reason) {
    showPopup("⚠️ Network blocked: " + reason);
    const err = new Error("Outbound network disabled: " + reason);
    err.code = "ERR_NET_BLOCKED";
    throw err;
}

Module.prototype.require = function (id) {
    const m = origRequire.apply(this, arguments);

    // Higher-level HTTP(S)
    if (id === "http" || id === "https") {
        const wrapReq = (orig) =>
            function (options, cb) {
                const opts =
                    typeof options === "string" ? new URL(options) : options instanceof URL ? options : options || {};
                const host = opts.hostname || opts.host || (opts.headers && opts.headers.Host);
                if (!isAllowedHost(host)) block(id.toUpperCase() + " to " + host);
                return orig.apply(this, arguments);
            };
        m.request = wrapReq(m.request);
        if (m.get)
            m.get = function () {
                const req = m.request.apply(this, arguments);
                req.end();
                return req;
            };
    }

    // Lower-level TCP/TLS
    if (id === "net" || id === "tls") {
        const wrapConn = (orig) =>
            function () {
                const args = Array.prototype.slice.call(arguments);
                const opts = typeof args[0] === "object" ? args[0] : {};
                const host = opts.host || opts.hostname || args[0];
                if (!isAllowedHost(host)) block(id.toUpperCase() + " connect to " + host);
                return orig.apply(this, arguments);
            };
        m.connect = wrapConn(m.connect);
        if (m.createConnection) m.createConnection = wrapConn(m.createConnection);
    }

    // DNS: stop name resolution for non-allowlisted hosts
    if (id === "dns") {
        const wrapLookup = (orig) =>
            function (hostname) {
                if (!isAllowedHost(hostname)) block("DNS lookup for " + hostname);
                return orig.apply(this, arguments);
            };
        if (m.lookup) m.lookup = wrapLookup(m.lookup);
        if (m.resolve) m.resolve = wrapLookup(m.resolve);
        if (m.resolve4) m.resolve4 = wrapLookup(m.resolve4);
        if (m.resolve6) m.resolve6 = wrapLookup(m.resolve6);
        if (m.resolveAny) m.resolveAny = wrapLookup(m.resolveAny);
        if (m.resolveCname) m.resolveCname = wrapLookup(m.resolveCname);
        if (m.resolveTxt) m.resolveTxt = wrapLookup(m.resolveTxt);
        if (m.resolveSrv) m.resolveSrv = wrapLookup(m.resolveSrv);
        if (m.resolveNs) m.resolveNs = wrapLookup(m.resolveNs);
        if (m.resolveMx) m.resolveMx = wrapLookup(m.resolveMx);
        if (m.reverse) m.reverse = wrapLookup(m.reverse);
    }

    return m;
};
