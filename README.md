#  RPG Maker MV / MZ - Cicpoffs
The project contains a collection of shell scripts that will help you run games on the RPG Maker MV/MZ engine.
I was inspired by [m5kro](https://github.com/m5kro)'s project and his linux/mac os builds.

### The software use the following dependencies:
- nwjs - As the main engine of the game
- cicpoffs - For mounting the game folder in windows Case-Insensitive mode (that allows nwjs to find game files better)
- tools such as wget, ln, readlink, grep - For downloading the latest version of nwjs and viewing the files

#### Contains the following features:
- Running any RPG Maker MV/MZ game on linux.
- Downloading and selecting any version of NWJS (using the command line).
- Starting a game with the Japanese locale option.
- Launching a game using a command line.
- Showing the NWJS, Nodejs, Chromium versions of your downloaded game.
- The Native support of 4 architectures: x86-64, i386, armhf, arm64 



After installing the program you can run the game using an application - "RPG Maker MV/MZ (cicpoffs mount)"

#
![img](https://github.com/bakustarver/rpgmakermlinux-cicpoffs/assets/66978329/4d55e52a-fe6d-44a5-a7bb-9380218d16f1)


## Installation
```
wget -qO- "https://raw.githubusercontent.com/bakustarver/rpgmakermlinux-cicpoffs/main/installgithub.sh" | bash
```

## Command line Options

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

## Support the author of the program:
[Patreon](https://www.patreon.com/user/about?u=121421184)
[Buymeacoffee](https://www.buymeacoffee.com/rpgmakerlinux)





























##















