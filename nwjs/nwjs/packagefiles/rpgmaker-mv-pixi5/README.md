# RPGMaker MV Game Engine 1.6.2.1

This is a set of updates based on RPGMaker MV 1.6.2 to use [PixiJS 5.3.3](https://github.com/pixijs/pixi.js/releases/tag/v5.3.3)

## Features

- Faster rendering
- Case insensitive file loading to better support Linux/Android without having to change your scripts
- With [NW.js v0.45.6](https://dl.nwjs.io/v0.45.6/) plays webm (VP8/VP9) files properly
- Filter change for Pixi-Picture to get it to run properly (Issue submitted waiting for a real fix)
- Added more keys in the keymap for easier use in scripts
- Fixes to documentation, spelling, and javascript syntax
- Added jshint information

## Known Issues

- ShaderTilemap is not working properly falling back on Tilemap
  - Doesn't seem to be affecting performance
- Plugins the load files directly or override the functions which load from disk may fail in case sensitive environments
  - Wrap the file path with `CS_URL.MapURL()` to ensure it resolves to the correct case sensitive name
- Overrides or calls to `refereshVehicles` will fail
  - Use `refreshVehicles` instead
- Overrides or calls to `updateButtonsVisiblity` will fail
  - Use `updateButtonsVisibility` instead

## Further Work

- Cleanup of Javascript (using let/const)
- Add updates to plugins
- Investigate if garbage collection needs to run (possibly do this during scene changes)
- Check for any memory leaks
- Submit issue against Pixi-Tilemap for the rendering issue
- Submit issue against NW.js for performance issues starting with v0.46
- Bring in proper filter fix for Pixi-Picture when it is released

## License

- PixiJS is covered by the [MIT License](https://github.com/pixijs/pixi.js/blob/dev/LICENSE)
- Typescript and other libraries, see the file headers
- My Modifications: MIT License
