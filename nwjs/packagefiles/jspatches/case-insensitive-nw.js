(()=>{
    console.log("ccsc22")
    const path = require('path');
    const {URL} = require('url');
    const fs_module = require('fs');
    const fsp_module = require('fs/promises');

    // Keep real functions around since we might patch some of fs below
    const fs = Object.assign({}, fs_module);
    const fsp = Object.assign({}, fsp_module);

    const casemapFilename = "case-mismatches.json";
    let casemap = null;
    const loadCasemapFile = async(pathBase) => {
        const pathDb = path.join(pathBase, casemapFilename);
        if (await fsp.stat(pathDb).then(st=>true,err=>false)) {
            const jsonData = await fsp.readFile(pathDb);
            casemap = JSON.parse(jsonData);
        } else {
            casemap = {
                version: 1,
                note: "This file records instances where resources were accessed with filenames differing in case. "
                + "This is fine in case-folding/case-preserving environments like Windows or some macOS setups, "
                + "but it results in e.g. broken images on case-sensitive/opaque-path environments like Linux. "
                + "Records are listed in <path-that-was-specified>: <path-that-was-actually-found> format.",
                base: pathBase,
                record: {},
            };
        }
    };
    const saveCasemapFile = async(pathBase) => {
        const pathDb = path.join(pathBase, casemapFilename);
        await fsp.writeFile(pathDb, JSON.stringify(casemap, null, 2));
    };

    // Async --------------------------
    /**
     * Find a file in a directory using case-folding
     * @param {string} pathParent
     * @param {string} name
     * @param {boolean} wantDir
     * @param {import('fs').Dir=} dirParent (always closed)
     * @returns {Promise<string|null>}
     */
    const findFileNameCI = async(pathParent, name, wantDir, dirParent) => {
        // Always closes dirParent
        let dir = dirParent ?? await fsp.opendir(pathParent);
        // JS doesn't seem to have proper casefolding, so lowercase will have to do.
        const namel = name.toLowerCase();
        for (let ent = await dir.read(); ent !== null; ent = await dir.read()) {
            if (ent.name.toLowerCase() === namel && (!wantDir || ent.isDirectory())) {
                await dir.close();
                return ent.name;
            }
        }
        await dir.close();
        return null;
    };

    /**
     * Asynchronously check if path exists
     * @param {string} path
     * @returns {Promise<boolean>}
     */
    const exists = (path) => {
        return fsp.stat(path).then(() => true, () => false);
    };

    /**
     * @param {string} pathParent
     * @param {string[]} pathElements
     * @param {import('fs').Dir=} dirParent
     * @returns {Promise<string|null>}
     */
    const findFilePathCI = async(pathParent, pathElements, dirParent) => {
        const nameTentative = pathElements.shift();
        const pathTentative = path.join(pathParent, nameTentative);
        //console.log(">> Looking for", nameTentative, "in", pathParent);
        if (!pathElements.length) {
            // want file
            if (await exists(pathTentative)) {
                if (dirParent)
                    await dirParent.close();
                return pathTentative;
            } else {
                const nameResolved = await findFileNameCI(pathParent, nameTentative, false, dirParent);
                if (nameResolved) {
                    console.log("Miscased file name:", nameTentative, "in", pathParent, "is really", nameResolved);
                    return path.join(pathParent, nameResolved)
                }
                console.log("Could not find file:", nameTentative, "in", pathParent);
            }
        } else {
            // want directory
            try {
                const dir = await fsp.opendir(pathTentative);
                if (dirParent)
                    await dirParent.close();
                return findFilePathCI(pathTentative, pathElements, dir);
            } catch (e) {
                const nameResolved = await findFileNameCI(pathParent, nameTentative, true, dirParent);
                if (nameResolved) {
                    console.log("Miscased directory name:", nameTentative, "in", pathParent, "is really", nameResolved);
                    return findFilePathCI(path.join(pathParent, nameResolved), pathElements);
                }
                console.log("Could not find directory:", nameTentative, "in", pathParent);
            }
        }
        return null;
    };

    /**
     * @param {string} path_
     * @returns {Promise<string|null>}
     */
    const lookupPathCI = async(path_) => {
        if (await exists(path_))
            return null;
        const relPath = path.isAbsolute(path_) ? path.relative(".", path_) : path_;
        if (casemap === null)
            await loadCasemapFile(".");
        if (casemap.record.hasOwnProperty(relPath)) {
            const pathCached = casemap.record[relPath];
            if (await exists(pathCached))
                return pathCached;
        }
        const pathFound = await (findFilePathCI(".", relPath.split(path.sep)).catch(() => null));
        casemap.record[relPath] = pathFound;
        saveCasemapFile(".").catch(console.error);
        return pathFound;
    };

    // Sync ---------------------------
    /**
     * Find a file in a directory using case-folding
     * @param {string} pathParent
     * @param {string} name
     * @param {boolean} wantDir
     * @param {fs.Dir=} dirParent (always closed)
     * @returns {string|null}
     */
    const findFileNameCISync = (pathParent, name, wantDir, dirParent) => {
        // Always closes dirParent
        let dir = dirParent ?? fs.opendirSync(pathParent);
        // JS doesn't seem to have proper casefolding, so lowercase will have to do.
        const namel = name.toLowerCase();
        for (let ent = dir.readSync(); ent !== null; ent = dir.readSync()) {
            if (ent.name.toLowerCase() === namel && (!wantDir || ent.isDirectory())) {
                dir.closeSync();
                return ent.name;
            }
        };
        dir.closeSync();
        return null;
    };

    /**
     * @param {string} pathParent
     * @param {string[]} pathElements
     * @param {fs.Dir=} dirParent
     * @returns {string|null}
     */
    const findFilePathCISync = (pathParent, pathElements, dirParent) => {
        const nameTentative = pathElements.shift();
        const pathTentative = path.join(pathParent, nameTentative);
        //console.log(">> Looking for", nameTentative, "in", pathParent);
        if (!pathElements.length) {
            // want file
            if (fs.existsSync(pathTentative)) {
                if (dirParent) dirParent.closeSync();
                    return pathTentative;
            } else {
                const nameResolved = findFileNameCISync(pathParent, nameTentative, false, dirParent);
                if (nameResolved) {
                    console.log("Miscased file name:", nameTentative, "in", pathParent, "is really", nameResolved);
                    return path.join(pathParent, nameResolved)
                }
                console.log("Could not find file:", nameTentative, "in", pathParent);
            }
        } else {
            // want directory
            try {
                const dir = fs.opendirSync(pathTentative);
                if (dirParent) dirParent.closeSync();
                return findFilePathCISync(pathTentative, pathElements, dir);
            } catch (e) {
                const nameResolved = findFileNameCISync(pathParent, nameTentative, true, dirParent);
                if (nameResolved) {
                    console.log("Miscased directory name:", nameTentative, "in", pathParent, "is really", nameResolved);
                    return findFilePathCISync(path.join(pathParent, nameResolved), pathElements);
                }
                console.log("Could not find directory:", nameTentative, "in", pathParent);
            }
        }
        return null;
    };

    /**
     * @param {string} path_
     * @returns {string|null}
     */
    const lookupPathCISync = (path_) => {
        if (fs.existsSync(path_))
            return null;
        const relPath = path.isAbsolute(path_) ? path.relative(".", path_) : path_;
        if (casemap !== null && casemap.record.hasOwnProperty(relPath)) {
            const pathCached = casemap.record[relPath];
            if (fs.existsSync(pathCached))
                return pathCached;
        }
        const pathFound = (() => {
            try {
                return findFilePathCISync(".", relPath.split(path.sep));
            } catch (e) {
                return null;
            }
        })();
        if (casemap !== null) {
            casemap.record[relPath] = pathFound;
            saveCasemapFile(".").catch(console.error);
        } else {
            console.warn("lookupPathCISync before casemap loaded!");
        }
        return pathFound;
    };

    // Patches ------------------------
    const interceptWebRequests = () => {
        chrome.webRequest.onBeforeRequest.addListener(details => {
            const url = new URL(details.url);
            const relPath = decodeURIComponent(url.pathname.substring(1));
            const foundPath = lookupPathCISync(relPath);
            if (foundPath !== null)
                return {redirectUrl: chrome.runtime.getURL(foundPath)};
            return {};
        },
        {urls:[chrome.runtime.getURL("/*")]}, ["blocking"]);
    };

    const patchNodeFilesystem = () => {
        // All fs functions with paths as the leading arguments
        const fs_functions = {
            access: 1,
            appendFile: 1,
            chmod: 1,
            chown: 1,
            copyFile: 2,
            cp: 2,
            exists: 1,
            lchmod: 1,
            fchown: 1,
            lutimes: 1,
            link: 2,
            lstat: 1,
            mkdir: 1,
            opendir: 1,
            open: 1,
            readdir: 1,
            readFile: 1,
            readlink: 1,
            realpath: 1,
            rename: 2,
            rmdir: 1,
            rm: 1,
            stat: 1,
            statfs: 1,
            symlink: 2,
            truncate: 1,
            unlink: 1,
            utimes: 1,
            writeFile: 1,
        };

        /**
         * @param {any[]} args
         * @param {number} count
         * @returns {Promise<any[]>}
         */
        const mapPaths = async(args, count) => {
            (await Promise.all(args.slice(0, count).map(lookupPathCI))).forEach((found, i) => {
                if (found !== null)
                    args[i] = found;
            });
            return args;
        };

        Object.keys(fs_functions).forEach(name => {
            const path_args = fs_functions[name];
            // 1. Sync
            /** @type {Function|undefined} */
            const sync_fn = fs_module[name + "Sync"];
            if (sync_fn !== undefined) {
                fs_module[name + "Sync"] = function(...args) {
                    for (let i=0; i<path_args; i++) {
                        const path = args[i];
                        const found = lookupPathCISync(path);
                        args[i] = found !== null ? found : path;
                    }
                    return sync_fn.apply(this, args);
                };
            }
            // 2. Callback
            /** @type {Function|undefined} */
            const cb_fn = fs_module[name];
            if (cb_fn !== undefined) {
                fs_module[name] = function(...args) {
                    mapPaths(args, path_args).then(args => {
                        cb_fn.apply(this, args);
                    });
                };
            }
            // 3. Promise
            /** @type {Function|undefined} */
            const promise_fn = fsp_module[name];
            if (promise_fn !== undefined) {
                fsp_module[name] = async function(...args) {
                    args = await mapPaths(args);
                    return promise_fn.apply(this, args);
                };
            }
        });

        console.log("[Kawariki] Patched Node filesystem functions for case-insensitivity");
    };

    loadCasemapFile(".").then(() => {
        interceptWebRequests();
    });

    if (process.env.KAWARIKI_NWJS_CIFS === '1')
        patchNodeFilesystem();

    const casein = {
        loadCasemapFile,
        saveCasemapFile,
        findFileNameCI,
        findFileNameCISync,
        findFilePathCI,
        findFilePathCISync,
        lookupPathCI,
        lookupPathCISync,
        get casemap() { return casemap; }
    };
    if (typeof exports !== "undefined") {
        Object.assign(exports, casein);
    } else {
        window._casein = casein;
    }
})();
