#  RPG Maker MV / MZ for Linux [ cicpoffs mount]
The bash wrapper that uses native linux libraries to run various game engines. Previously supported only RPG Maker MV/MZ.  Now supports RPG Maker XP, VX, VX Ace, MV, MZ, TyranoBuilder, Godot, Construct 2/3, Nscripter. There are plans to add other engines that use nwjs.
Priority is primarily on RPG Maker MV/MZ. (if you have errors with XP, VX, Vx Ace address this [link](https://github.com/mkxp-z/mkxp-z)).

#### Contains the following features (RPG Maker MV / MZ):
- Sharp increase in fps (from 2 to 4 times more compared to Wine, can be viewed by pressing the F2 key)
- Updating Pixi 5 libraries for RPG Maker MV games (that's supposed to increase performance)
- Downloading and selecting any version of NWJS (using the command line and GUI).
- Starting a game with the Japanese locale option.
- Launching a game using a command line.
- Showing the NWJS, Nodejs, Chromium versions of your game.
- Installing the Text hooker plug-in that copies the game's dialogs automatically to your clipboard.
- Can be used as compatibility tool in steam for Windows games.
- The Native support of 4 architectures: x86-64, i386, armhf, arm64

[Dependencies list](DEPENDENCIES.md)

 
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
####  Disable the GUI menu in steam :
```
rpgmaker-linux --steamskipgui true
```
####  Sends an anonymous report to developer about game data, system information, engine for fixing bugs and errors :
```
rpgmaker-linux --bugreport
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
- [RPGMaker MV/MZ Save Editor](https://www.appimagehub.com/p/2166407/) - This is a offile tool for editing RPGMaker save files. It currently supports save files written by RPG Maker MV (.rpgsave) & MZ (.rmmzsave).


### Professional version:
<a href="https://bakurpg.itch.io/rpg-maker-mv-mz-for-linux"><img src="https://github.com/user-attachments/assets/421edc23-fdd5-47d4-aa8b-3d914be4a177" width="600"></a>
  
## Support me:
[Patreon](https://www.patreon.com/user/about?u=121421184)
[Buymeacoffee](https://www.buymeacoffee.com/rpgmakerlinux)




















##















