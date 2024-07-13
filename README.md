#  RPG Maker MV / MZ for Linux [ cicpoffs mount]
The project contains a collection of shell scripts that will help you run games on the RPG Maker MV/MZ engine on linux.
I was inspired by [m5kro](https://github.com/m5kro)'s project and his linux/mac os builds. 
Priority is primarily on RPG Maker MV/MZ. (if you have errors with XP, VX, Vx Ace address this [link](https://github.com/mkxp-z/mkxp-z)).


### The software uses the following dependencies for RPG Maker MV/MZ:
- [nwjs](https://nwjs.io/) - As the main engine of the game
- [cicpoffs](https://github.com/adlerosn/cicpoffs) - For mounting the game folder in windows Case-Insensitive mode (that allows nwjs better find the game files)
- [evbunpack](https://github.com/mos9527/evbunpack) - For unpacking game files stored in Game.exe (if they are packaged)
- tools such as wget, ln, readlink, grep - For downloading the latest version of nwjs and viewing the files.

### Dependencies for tyranobuilder (Supports this engine since v1.0.9)
- [nwjs](https://nwjs.io/) - As the main engine of the game
- python script tyranoextract with these dependencies (asarlib,pefile)

### Dependencies for RPG Maker XP / VX / VX Ace (Supports this engine since v1.0.9)
- [mkxp-z](https://github.com/mkxp-z/mkxp-z) - Open-source cross-platform player for (some) RPG Maker XP / VX / VX Ace games. A very heavily modified fork of mkxp. RGSS on steroids with a stupid name. (May have limited support for games, due to win32api)
  
#### Contains the following features:
- Sharp increase in fps (from 2 to 4 times more compared to Wine, can be viewed by pressing the F2 key)
- Updating Pixi 5 libraries for RPG Maker MV games (that's supposed to increase performance)
- Downloading and selecting any version of NWJS (using the command line).
- Easily installable SDK version of NWJS with one click in the gui, or via cli.
- Starting a game with the Japanese locale option.
- Launching a game using a command line.
- Showing the NWJS, Nodejs, Chromium versions of your downloaded game.
- Installing the Text hooker plug-in that copies the game's dialogs automatically to your clipboard.
- Can be used as compatibility tool in steam for Windows games.
- The Native support of 4 architectures: x86-64, i386, armhf, arm64


 
After installing the program you can run the game using an application - "RPG Maker MV/MZ (cicpoffs mount)"

#
![img](https://github.com/bakustarver/rpgmakermlinux-cicpoffs/assets/66978329/4d55e52a-fe6d-44a5-a7bb-9380218d16f1)
![1123](https://github.com/bakustarver/rpgmakermlinux-cicpoffs/assets/66978329/58e47de8-3cce-47a8-a183-544c4ce1a624)

## Installation || Update
```
wget -qO- "https://raw.githubusercontent.com/bakustarver/rpgmakermlinux-cicpoffs/main/installgithub.sh" | bash
```

## Uninstall
```
wget -qO- "https://raw.githubusercontent.com/bakustarver/rpgmakermlinux-cicpoffs/main/uninstallgithub.sh" | bash
```
or 
```
rm -rf "$HOME/desktopapps/nwjs" && rm "$HOME/.local/share/applications/nwjstest.desktop" && rm "$HOME/.local/bin/rpgmaker-linux"
```

## Command line Commands

#### Run the rpg maker game
```
rpgmaker-linux 
```

```
rpgmaker-linux --gamepath /path/rpg-maker-game/
```
#### Show version of the program
```
rpgmaker-linux --version
```

#### Update the nwjs to the latest version
```
rpgmaker-linux --updatenwjs
```

#### Show versions of rpg maker game libraries
```
rpgmaker-linux --gamepath /path/rpg-maker-game/ --printrpgmakerlibversions
```

#### Choose the version of NWJS you want to use:
```
rpgmaker-linux --nwjsversion 0.40.0 --gamepath /path/rpg-maker-game/
```
#### In certain games you may need the Japanese locale use:
```
rpgmaker-linux --jpnlocale --gamepath /path/rpg-maker-game/
```
#### Show donation links:
```
rpgmaker-linux --sourcelinks
```

### Interesting projects

- [mkxp-z](https://github.com/mkxp-z/mkxp-z) - Open-source cross-platform player for (some) RPG Maker XP / VX / VX Ace games. A very heavily modified fork of mkxp. RGSS on steroids with a stupid name. 
- [easyrpg](https://easyrpg.org/) - EasyRPG is a community project to create a free, open source, role playing game creation tool, compatible with RPG Maker 2000/2003 games.
- [Painless-Porter-CLI](https://github.com/m5kro/Painless-Porter-CLI) - A tool to quickly port RPG Maker MV and MZ games to Linux and MacOS and upload to file hosters. 
- [ruffle](https://github.com/ruffle-rs/ruffle) - A Flash Player emulator written in Rust 


  
## Support me:
[Patreon](https://www.patreon.com/user/about?u=121421184)
[Buymeacoffee](https://www.buymeacoffee.com/rpgmakerlinux)















![img](https://github.com/bakustarver/rpgmakermlinux-cicpoffs/assets/66978329/2a82ecd6-e45e-4cce-a83c-f215fdde7c1e)





##















