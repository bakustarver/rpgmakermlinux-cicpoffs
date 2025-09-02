const fsfunc = require('fs');
const pathfunc = require('path');

const baseDir = process.env.mainfd

const newpath = pathfunc.join(scriptsjsDir, 'menu.js');

const scriptContent = fsfunc.readFileSync(newpath, 'utf8');

eval(scriptContent);


