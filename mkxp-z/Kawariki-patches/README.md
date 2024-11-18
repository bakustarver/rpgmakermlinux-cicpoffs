Kawariki MKXP runtime
=====================

The MKXP runtime handles games based on the `Ruby Game Scripting System`, RGSS.

The RPG Maker editions based on RGSS are:
- RPGMaker XP (RGSS1)
- RPGMaker VX (RGSS2)
- RPGMaker VX Ace (RGSS3)

[Official RPGMaker Website][rpgmakerweb]

MKXP-Z
------

The specific implementation used in Kawariki is [mkxp-z][mkxp-z] by Roza/Struma,
itself based on the original [mkxp][mkxp-github] by Ancurio.

Currently, a [repackaged distribution][mkxp-z-repack] of the [official releases][mkxp-z-releases] are used.
This is required mostly for ease of automatic downloading in Kawariki.

Links: [mkxp-z GitHub][mkxp-z-github]

Configuration
-------------

### mkxp.json

The mkxp-z configuration is merged from a number of files in order:
- `<kawariki>/mkxp/mkxp.json`: Global mkxp config
- `<game>/kawariki-mkxp.json`: Overrides specific for this game

See the [default included with mkxp-z for reference][mkxp-z-config]
Note that the runtime doesn't understand JSON comments for now,
unlike mkxp-z itself.

#### RTPs
The situation with RTPs is not optimal at the moment, but they
can be specified globally in `<kawariki>/mkxp/mkxp.json`:
```json
{
    "RTP": ["/path/to/rtp"]
}
```

### Environment Variables
- `KAWARIKI_MKXP_DUMP_SCRIPTS=<dirname>`: Dump scripts to <dirname> before applying patches
- `KAWARIKI_MKXP_DUMP_PATCHED_SCRIPTS=<dirname>`: Dump scripts to <dirname> after applying patches
- `KAWARIKI_MKXP_FILTER_SCRIPTS=<name>[,...]`: Blacklist scripts/plugins by name
- `KAWARIKI_MKXP_DRY_RUN=1`: Exit after patching scripts, don't run game
- `KAWARIKI_MKXP_NO_FONT_EFFECTS=1`: Disable all font effects. See relevant patch in `pathces.rb`
- `KAWARIKI_NO_OVERLAYNS=1` Disallow usage of overlayns-static

### versions.json
This file specifies the mkxp-z versions known to the runtime:
- `variant` *required string* Must be `"mkxp-z"` for now
- `version` *required array-of-numbers* The version of this distribution (e.g. `[2,3,0]`)
- `dist` *required string* The name of the directory the distribution is stored in.
- `dist_url` *optional string* An URL to download the distribution from if not already available. It must point to a gzip/bzip2/xz compressed tar-archive.
- `name` *optional string* An optional name given to the distribution. Defaults to the value of `dist`.

RGSS Plugins
------------

All functionality in RGSS-based games is derived from the core scripts
of it's respective RPGMaker edition and extended by usually rather large
numbers of third-party engine plugins.

Unfortunately, as a consequence of RGSS being a rather simplistic engine
and also being Windows-only, a lot of these plugins rely on assumptions
that don't hold true on Linux (though MKXP already implements case-insensitive
path lookups) or depend on the Win32 API or other (possibly custom) native
Windows libraries by way of a FFI (`Win32API` in RGSS).
As such, the runtime must apply a considerable amount of patches to a game
to allow it to run on Linux/MXKP-Z.

### Ports

Ports are modifications or re-implementations of third-party plugins to make
them work on Linux/MKXP-Z. They are contained in the `ports/` directory.

All ports retain their original license terms. If you are the original author
of one of the included scripts and want it removed, please open an issue on GitHub.

### Patches

A patch tries to identify a third-party plugin and then either modify it's code
or outright replace the plugin with a port from `ports/`. Patches are defined
in [`patches.rb`](patches.rb)

### Win32API Stubs
Win32API stubs are implemented in [`libs/Win32API.rb`](libs/Win32API.rb).
They are automatically loaded if any reference to Win32API is found in plugin
code after all patches are applied.

It is usually easier to port a heavily Win32API-dependent plugin instead of
trying to re-implement the relevant Win32 APIs.

Currently, implementations are included for these common APIs:
- kernel32/GetPrivateProfileString
- kernel32/GetPrivateProfileInt
- kernel32/WritePrivateProfileString

### Preload

The preload script `preload.rb` is registered with MKXP-Z and is responsible for
applying the patches defined in `patches.rb`. 

Some methods are provided for use in ports/patches:
- `Preload::require()`: Require a library from the `libs/` directory (see below)
- `Preload::print()`: Print to stderr. Note that Kernel.print may open a message box depending on RGSS version

### Libraries
The `libs/` directory contains a few libraries to support porting plugins.
- `ruby18.rb`: Some low-hanging compatibility modifications for RGSS1, which used Ruby 1.8
- `Win32API.rb`: Wrapper around Win32API to intercept imports with included ruby implementations
- `PreloadIni.rb`: Simple INI parser/generator for implementing {Get,Write}PrivateProfileString
- `XP_TileMapOverrideLib.rb`: Workaround for a MKXP-Z issue related to GL texture sizes


<!-- References -->
[mkxp-z]: https://roza-gb.gitbook.io/mkxp-z
[mkxp-z-config]: https://github.com/mkxp-z/mkxp-z/blob/release/mkxp.json
[mkxp-z-github]: https://github.com/mkxp-z/mkxp-z
[mkxp-z-releases]: https://github.com/mkxp-z/mkxp-z/releases
[mkxp-z-repack]: https://github.com/Orochimarufan/Kawariki/releases/tag/mkxp-2.3.0-kk

[mkxp-github]: https://github.com/Ancurio/mkxp
[rpgmakerweb]: https://www.rpgmakerweb.com/
