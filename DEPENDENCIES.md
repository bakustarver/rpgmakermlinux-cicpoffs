
#### The software uses the following dependencies for RPG Maker MV/MZ:
- [nwjs](https://nwjs.io/) - As the main engine of the game
- [cicpoffs](https://github.com/adlerosn/cicpoffs) - For mounting the game folder in windows Case-Insensitive mode (that allows nwjs better find the game files)
- [evbunpack](https://github.com/mos9527/evbunpack) - For unpacking game files stored in Game.exe (if they are packaged)
- tools such as wget, ln, readlink, grep - For downloading the latest version of nwjs and viewing the files.

#### Dependencies for tyranobuilder
- [nwjs](https://nwjs.io/) - As the main engine of the game
- [electron 9.4.4](https://github.com/electron/electron/releases/tag/v9.4.4) to run v5 version games of this engine
- python script tyranoextract with these dependencies (asarlib,pefile)

#### Dependencies for RPG Maker XP / VX / VX Ace
- [mkxp-z](https://github.com/mkxp-z/mkxp-z) - Open-source cross-platform player for (some) RPG Maker XP / VX / VX Ace games. A very heavily modified fork of mkxp. RGSS on steroids with a stupid name. (May have limited support for games, due to win32api in plugins)
