#  RPG Maker MV / MZ for Linux [ cicpoffs mount]
The bash wrapper uses [native Linux libraries](DEPENDENCIES.md) to run Windows games. It creates a local port of the Linux version from the Windows port and then executes it.
Initially, it supported only RPG Maker MV and MZ, but now it also supports RPG Maker XP, VX, VX Ace, MV, MZ, TyranoBuilder, Godot, Construct 2/3, and Nscripter.

Priority is primarily on RPG Maker MV/MZ. (if you have errors with XP, VX, Vx Ace address this [link](https://github.com/mkxp-z/mkxp-z)).

#### Contains the following features (RPG Maker MV / MZ):
- Sharp increase in FPS (2 to 4 times more compared to Wine, viewable by pressing the F2 key).
- Download and select any version of NW.js (using the command line and GUI).
- Install the Text Hooker plug-in, which automatically copies the game's dialogues to your clipboard.
- Update Pixi 5 libraries for RPG Maker MV games to enhance performance.
- Launch a game using the command line.
- Display the NW.js, Node.js, and Chromium versions of your game.
- Can be used as compatibility tool in steam for Windows games.
- Native support for four architectures: x86-64, i386, armhf, and arm64.


 
After installing the program you can run the game using an application - "RPG Maker MV/MZ (cicpoffs mount)"

#
![img](https://github.com/bakustarver/rpgmakermlinux-cicpoffs/assets/66978329/4d55e52a-fe6d-44a5-a7bb-9380218d16f1)
![1123](https://github.com/bakustarver/rpgmakermlinux-cicpoffs/assets/66978329/58e47de8-3cce-47a8-a183-544c4ce1a624)

## Installation || Update
```
wget -qO- "https://raw.githubusercontent.com/bakustarver/rpgmakermlinux-cicpoffs/main/installgithub.sh" | bash
```


## Custom path
If you want to change the default installation directory, use the following command before installation
```
echo "$HOME/somedirpath/" > "$HOME/.config/defrpgmakerlinuxpath.txt"
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

#### To start the RPG Maker game, use the following command
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

#### To show the versions of the RPG Maker game libraries
```
rpgmaker-linux --gamepath /path/rpg-maker-game/ --printrpgmakerlibversions
```

#### Choose the version of NWJS you want to use:
```
rpgmaker-linux --nwjsversion 0.40.0 --gamepath /path/rpg-maker-game/
```
####  Send an anonymous report to developer about game data, system information, engine for fixing bugs and errors :
```
rpgmaker-linux --bugreport
```
#### Show donation links:
```
rpgmaker-linux --sourcelinks
```
####  Disable the GUI menu in steam :
```
rpgmaker-linux --steamskipgui true
```

### Interesting projects

- [mkxp-z](https://github.com/mkxp-z/mkxp-z) - Open-source cross-platform player for (some) RPG Maker XP / VX / VX Ace games. A very heavily modified fork of mkxp. RGSS on steroids with a stupid name. 
- [easyrpg](https://easyrpg.org/) - EasyRPG is a community project to create a free, open source, role playing game creation tool, compatible with RPG Maker 2000/2003 games.
- [Painless-Porter-CLI](https://github.com/m5kro/Painless-Porter-CLI) - A tool to quickly port RPG Maker MV and MZ games to Linux and MacOS and upload to file hosters. 
- [ruffle](https://github.com/ruffle-rs/ruffle) - A Flash Player emulator written in Rust 
- [RPGMaker MV/MZ Save Editor](https://www.appimagehub.com/p/2166407/) - This is a offile tool for editing RPGMaker save files. It currently supports save files written by RPG Maker MV (.rpgsave) & MZ (.rmmzsave).
- [Kawariki](https://github.com/Orochimarufan/Kawariki) - Kawariki

### Professional version:
<a href="https://bakurpg.itch.io/rpg-maker-mv-mz-for-linux"><img src="https://github.com/user-attachments/assets/421edc23-fdd5-47d4-aa8b-3d914be4a177" width="600"></a>



  
## Support me:
[Patreon](https://www.patreon.com/user/about?u=121421184)
[Buymeacoffee](https://www.buymeacoffee.com/rpgmakerlinux)




















##















