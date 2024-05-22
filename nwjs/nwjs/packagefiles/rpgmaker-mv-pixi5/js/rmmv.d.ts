/*
* Do Not Remove This Header
//=============================================================================
//  ChangeLog
//=============================================================================
* version 1.0.0
* - Added most major MV functions.
* - Added PIXI.js type definitions
* - Added LZString type definitions
* - Added FPSMeter type definitions
//=============================================================================
//  Credits
//=============================================================================
*
*  AsterAtwood: https://github.com/AsterAtwood
*  Sabakan03: https://github.com/sabakan03
*  For providing the base d.ts files to work from.
//=============================================================================
//  Contact Information
//=============================================================================
*
* Contact me via twitter: EISKino, or on the rpg maker forums.
* Username on forums: Kino.
*
* Forum Link: http://forums.rpgmakerweb.com/index.php?/profile/75879-kino/
* Website Link: http://endlessillusoft.com/
* Twitter Link: https://twitter.com/EISKino
* Patreon Link: https://www.patreon.com/EISKino
*
* Hope this makes your plugin creation all the better.
* --Kino
*/

declare class Bitmap {
    /**
     * Loads a image file and returns a new bitmap object.
     *
     * @static
     * @method load
     * @param {String} url The image url of the texture
     * @return Bitmap
     */
    static load(url: string): Bitmap;

    /**
     * Takes a snapshot of the game screen and returns a new bitmap object.
     *
     * @static
     * @method snap
     * @param {Stage} stage The stage object
     * @return Bitmap
     */
    static snap(stage: Stage): Bitmap;

    /**
     * The face name of the font.
     *
     * @property fontFace
     * @type String
     */
    fontFace: string;

    /**
     * The size of the font in pixels.
     *
     * @property fontSize
     * @type Number
     */
    fontSize: number;

    /**
     * Whether the font is italic.
     *
     * @property fontItalic
     * @type Boolean
     */
    fontItalic: number;

    /**
     * The color of the text in CSS format.
     *
     * @property textColor
     * @type String
     */
    textColor: string;

    /**
     * The color of the outline of the text in CSS format.
     *
     * @property outlineColor
     * @type String
     */
    outlineColor: string;

    /**
     * The width of the outline of the text.
     *
     * @property outlineWidth
     * @type Number
     */
    outlineWidth: number;

    /**
     * [read-only] The url of the image file.
     *
     * @property url
     * @type String
     */
    url: string;

    /**
     * [read-only] The base texture that holds the image.
     *
     * @property baseTexture
     * @type PIXI.BaseTexture
     */
    baseTexture: PIXI.BaseTexture;

    /**
     * [read-only] The bitmap canvas.
     *
     * @property canvas
     * @type HTMLCanvasElement
     */
    canvas: HTMLCanvasElement;

    /**
     * [read-only] The 2d context of the bitmap canvas.
     *
     * @property context
     * @type CanvasRenderingContext2D
     */
    context: CanvasRenderingContext2D;

    /**
     * [read-only] The width of the bitmap.
     *
     * @property width
     * @type Number
     */
    width: number;

    /**
     * [read-only] The height of the bitmap.
     *
     * @property height
     * @type Number
     */
    height: number;

    /**
     * [read-only] The rectangle of the bitmap.
     *
     * @property rect
     * @type Rectangle
     */
    rect: Rectangle;

    /**
     * Whether the smooth scaling is applied.
     *
     * @property smooth
     * @type Boolean
     */
    smooth: boolean;

    /**
     * The opacity of the drawing object in the range (0, 255).
     *
     * @property paintOpacity
     * @type Number
     */
    paintOpacity: number;

    /**
     * Cache entry, for images. In all cases _url is the same as cacheEntry.key
     * @type CacheEntry
     */
    cacheEntry: CacheEntry;

    /**
     * The basic object that represents an image.
     *
     * @class Bitmap
     * @constructor
     * @param {Number} width The width of the bitmap
     * @param {Number} height The height of the bitmap
     */
    constructor();
    constructor(width: number, height: number);

    /**
     * Checks whether the bitmap is ready to render.
     *
     * @method isReady
     * @return {Boolean} True if the bitmap is ready to render
     */
    isReady(): boolean;

    /**
     * Checks whether a loading error has occurred.
     *
     * @method isError
     * @return {Boolean} True if a loading error has occurred
     */
    isError(): boolean;

    /**
     * Resizes the bitmap.
     *
     * @method resize
     * @param {Number} width The new width of the bitmap
     * @param {Number} height The new height of the bitmap
     */
    resize(width: number, height: number): void;

    /**
     * Performs a block transfer.
     *
     * @method blt
     * @param {Bitmap} source The bitmap to draw
     * @param {Number} sx The x coordinate in the source
     * @param {Number} sy The y coordinate in the source
     * @param {Number} sw The width of the source image
     * @param {Number} sh The height of the source image
     * @param {Number} dx The x coordinate in the destination
     * @param {Number} dy The y coordinate in the destination
     * @param {Number} [dw=sw] The width to draw the image in the destination
     * @param {Number} [dh=sh] The height to draw the image in the destination
     */
    blt(source: Bitmap, sx: number, sy: number, sw: number, sh: number,
        dx: number, dy: number, dw?: number, dh?: number): void;

    /**
     * Returns pixel color at the specified point.
     *
     * @method getPixel
     * @param {Number} x The x coordinate of the pixel in the bitmap
     * @param {Number} y The y coordinate of the pixel in the bitmap
     * @return {String} The pixel color (hex format)
     */
    getPixel(x: number, y: number): string;

    /**
     * Returns alpha pixel value at the specified point.
     *
     * @method getAlphaPixel
     * @param {Number} x The x coordinate of the pixel in the bitmap
     * @param {Number} y The y coordinate of the pixel in the bitmap
     * @return {String} The alpha value
     */
    getAlphaPixel(x: number, y: number): string;

    /**
     * Clears the specified rectangle.
     *
     * @method clearRect
     * @param {Number} x The x coordinate for the upper-left corner
     * @param {Number} y The y coordinate for the upper-left corner
     * @param {Number} width The width of the rectangle to clear
     * @param {Number} height The height of the rectangle to clear
     */
    clearRect(x: number, y: number, width: number, height: number): void;

    /**
     * Clears the entire bitmap.
     *
     * @method clear
     */
    clear(): void;

    /**
     * Fills the specified rectangle.
     *
     * @method fillRect
     * @param {Number} x The x coordinate for the upper-left corner
     * @param {Number} y The y coordinate for the upper-left corner
     * @param {Number} width The width of the rectangle to clear
     * @param {Number} height The height of the rectangle to clear
     * @param {String} color The color of the rectangle in CSS format
     */
    fillRect(x: number, y: number, width: number, height: number, color: string): void;

    /**
     * Fills the entire bitmap.
     *
     * @method fillAll
     * @param {String} color The color of the rectangle in CSS format
     */
    fillAll(color: string): void;

    /**
     * Draws the rectangle with a gradation.
     *
     * @method gradientFillRect
     * @param {Number} x The x coordinate for the upper-left corner
     * @param {Number} y The y coordinate for the upper-left corner
     * @param {Number} width The width of the rectangle to clear
     * @param {Number} height The height of the rectangle to clear
     * @param {String} color1 The start color of the gradation
     * @param {String} color2 The end color of the gradation
     * @param {Boolean} vertical Whether it draws a vertical gradient
     */
    gradientFillRect(x: number, y: number, width: number, height: number,
        color1: string, color2: string, vertical?: boolean): void;

    /**
     * Draw the filled circle.
     *
     * @method drawCircle
     * @param {Number} x The x coordinate of the center of the circle
     * @param {Number} y The y coordinate of the center of the circle
     * @param {Number} radius The radius of the circle
     * @param {String} color The color of the circle in CSS format
     */
    drawCircle(x: number, y: number, radius: number, color: string): void;

    /**
     * Draws the outline text to the bitmap.
     *
     * @method drawText
     * @param {String} text The text that will be drawn
     * @param {Number} x The x coordinate for the left of the text
     * @param {Number} y The y coordinate for the top of the text
     * @param {Number} maxWidth The maximum allowed width of the text
     * @param {Number} lineHeight The height of the text line
     * @param {String} align The alignment of the text
     */
    drawText(text: string, x: number, y: number,
        maxWidth: number, lineHeight: number, align: string): void;

    /**
     * Returns the width of the specified text.
     *
     * @method measureTextWidth
     * @param {String} text The text to be measured
     * @return {Number} The width of the text in pixels
     */
    measureTextWidth(text: string): number;

    /**
     * Changes the color tone of the entire bitmap.
     *
     * @method adjustTone
     * @param {Number} r The red strength in the range (-255, 255)
     * @param {Number} g The green strength in the range (-255, 255)
     * @param {Number} b The blue strength in the range (-255, 255)
     */
    adjustTone(r: number, g: number, b: number): void;

    /**
     * Rotates the hue of the entire bitmap.
     *
     * @method rotateHue
     * @param {Number} offset The hue offset in 360 degrees
     */
    rotateHue(offset: number): void;

    /**
     * Applies a blur effect to the bitmap.
     *
     * @method blur
     */
    blur(): void;

    /**
     * Add a callback function that will be called when the bitmap is loaded.
     *
     * @method addLoadListener
     * @param {Function} listener The callback function
     */
    addLoadListener(listener: () => void): void;

    /**
     * touch the resource
     * @method touch
     */
    touch(): void;

    /**
     * Performs a block transfer, using assumption that original image was not modified (no hue)
     *
     * @method blt
     * @param {Bitmap} source The bitmap to draw
     * @param {Number} sx The x coordinate in the source
     * @param {Number} sy The y coordinate in the source
     * @param {Number} sw The width of the source image
     * @param {Number} sh The height of the source image
     * @param {Number} dx The x coordinate in the destination
     * @param {Number} dy The y coordinate in the destination
     * @param {Number} [dw=sw] The width to draw the image in the destination
     * @param {Number} [dh=sh] The height to draw the image in the destination
     */
    bltImage(source: Bitmap, sx: number, sy: number, sw: number, sh: number, dx: number, dy: number, dw: number, dh: number): void;

    protected _canvas: HTMLCanvasElement;
    protected _context: CanvasRenderingContext2D;
    protected _baseTexture: PIXI.BaseTexture;
    protected _image: HTMLImageElement;
    protected _url: string;
    protected _paintOpacity: number;
    protected _smooth: boolean;
    protected _loadListeners: () => void;
    protected _isLoading: boolean;
    protected _hasError: boolean;

    /**
     * @method _makeFontNameText
     * @return {String} FontNameText
     * @private
     */
    protected _makeFontNameText(): string;

    /**
     * @method _drawTextOutline
     * @param {String} text
     * @param {Number} tx
     * @param {Number} ty
     * @param {Number} maxWidth
     * @private
     */
    protected _drawTextOutline(text: number, tx: number, ty: number, maxWidth: number): void;

    /**
     * @method _drawTextBody
     * @param {String} text
     * @param {Number} tx
     * @param {Number} ty
     * @param {Number} maxWidth
     * @private
     */
    protected _drawTextBody(text: string, tx: number, ty: number, maxWidth: number): void;

    /**
     * @method _onLoad
     * @private
     */
    protected _onLoad(): void;

    /**
     * @method _callLoadListeners
     * @private
     */
    protected _callLoadListeners(): void;

    /**
     * @method _onError
     * @private
     */
    protected _onError(): void;

    /**
     * @method _setDirty
     * @private
     */
    protected _setDirty(): void;
}

/**
 * The static class that carries out graphics processing.
 *
 * @class Graphics
 */
interface GraphicsStatic {
    /**
     * The total frame count of the game screen.
     *
     * @static
     * @property frameCount
     * @type Number
     */
    frameCount: number;

    /**
     * The alias of PIXI.blendModes.NORMAL.
     *
     * @static
     * @property BLEND_NORMAL
     * @type Number
     * @final
     */
    BLEND_NORMAL: number;

    /**
     * The alias of PIXI.blendModes.ADD.
     *
     * @static
     * @property BLEND_ADD
     * @type Number
     * @final
     */
    BLEND_ADD: number;

    /**
     * The alias of PIXI.blendModes.MULTIPLY.
     *
     * @static
     * @property BLEND_MULTIPLY
     * @type Number
     * @final
     */
    BLEND_MULTIPLY: number;

    /**
     * The alias of PIXI.blendModes.SCREEN.
     *
     * @static
     * @property BLEND_SCREEN
     * @type Number
     * @final
     */
    BLEND_SCREEN: number;

    /**
     * The width of the game screen.
     *
     * @static
     * @property width
     * @type Number
     */
    width: number;

    /**
     * The height of the game screen.
     *
     * @static
     * @property height
     * @type Number
     */
    height: number;

    /**
     * The width of the window display area.
     *
     * @static
     * @property boxWidth
     * @type Number
     */
    boxWidth: number;

    /**
     * The height of the window display area.
     *
     * @static
     * @property boxHeight
     * @type Number
     */
    boxHeight: number;

    /**
     * The zoom scale of the game screen.
     *
     * @static
     * @property scale
     * @type Number
     */
    scale: number;

    /**
     * Initializes the graphics system.
     *
     * @static
     * @method initialize
     * @param {Number} width The width of the game screen
     * @param {Number} height The height of the game screen
     * @param {String} type The type of the renderer.
     *                 'canvas', 'webgl', or 'auto'.
     */
    initialize(): void;
    initialize(width: number, height: number, type: string): void;

    /**
     * Marks the beginning of each frame for FPSMeter.
     *
     * @static
     * @method tickStart
     */
    tickStart(): void;

    /**
     * Marks the end of each frame for FPSMeter.
     *
     * @static
     * @method tickEnd
     */
    tickEnd(): void;

    /**
     * Renders the stage to the game screen.
     *
     * @static
     * @method render
     * @param {Stage} stage The stage object to be rendered
     */
    render(stage?: Stage): void;

    /**
     * Checks whether the renderer type is WebGL.
     *
     * @static
     * @method isWebGL
     * @return {Boolean} True if the renderer type is WebGL
     */
    isWebGL(): boolean;

    /**
     * Checks whether the current browser supports WebGL.
     *
     * @static
     * @method hasWebGL
     * @return {Boolean} True if the current browser supports WebGL.
     */
    hasWebGL(): boolean;

    /**
     * Checks whether the canvas blend mode 'difference' is supported.
     *
     * @static
     * @method canUseDifferenceBlend
     * @return {Boolean} True if the canvas blend mode 'difference' is supported
     */
    canUseDifferenceBlend(): boolean;

    /**
     * Checks whether the canvas blend mode 'saturation' is supported.
     *
     * @static
     * @method canUseSaturationBlend
     * @return {Boolean} True if the canvas blend mode 'saturation' is supported
     */
    canUseSaturationBlend(): boolean;

    /**
     * Sets the source of the "Now Loading" image.
     *
     * @static
     * @method setLoadingImage
     * @param {String} Path of image
     */
    setLoadingImage(src: string);

    /**
     * Initializes the counter for displaying the "Now Loading" image.
     *
     * @static
     * @method startLoading
     */
    startLoading(): void;

    /**
     * Increments the loading counter and displays the "Now Loading" image if necessary.
     *
     * @static
     * @method updateLoading
     */
    updateLoading(): void;

    /**
     * Erases the "Now Loading" image.
     *
     * @static
     * @method endLoading
     */
    endLoading(): void;

    /**
     * Displays the error text to the screen.
     *
     * @static
     * @method printError
     * @param {String} name The name of the error
     * @param {String} message The message of the error
     */
    printError(name: string, message: string): void;

    /**
     * Shows the FPSMeter element.
     *
     * @static
     * @method showFps
     */
    showFps(): void;

    /**
     * Hides the FPSMeter element.
     *
     * @static
     * @method hideFps
     */
    hideFps(): void;

    /**
     * Loads a font file.
     *
     * @static
     * @method loadFont
     * @param {String} name The face name of the font
     * @param {String} url The url of the font file
     */
    loadFont(name: string, url: string): void;

    /**
     * Checks whether the font file is loaded.
     *
     * @static
     * @method isFontLoaded
     * @param {String} name The face name of the font
     * @return {Boolean} True if the font file is loaded
     */
    isFontLoaded(name: string): boolean;

    /**
     * Starts playback of a video.
     *
     * @static
     * @method playVideo
     * @param {String} src
     */
    playVideo(src: string): void;

    /**
     * Checks whether the video is playing.
     *
     * @static
     * @method isVideoPlaying
     * @return {Boolean} True if the video is playing
     */
    isVideoPlaying(): boolean;

    /**
     * Checks whether the browser can play the specified video type.
     *
     * @static
     * @method canPlayVideoType
     * @param {String} type The video type to test support for
     * @return {Boolean} True if the browser can play the specified video type
     */
    canPlayVideoType(type: string): boolean;

    /**
     * Converts an x coordinate on the page to the corresponding
     * x coordinate on the canvas area.
     *
     * @static
     * @method pageToCanvasX
     * @param {Number} x The x coordinate on the page to be converted
     * @return {Number} The x coordinate on the canvas area
     */
    pageToCanvasX(x: number): number;

    /**
     * Converts a y coordinate on the page to the corresponding
     * y coordinate on the canvas area.
     *
     * @static
     * @method pageToCanvasY
     * @param {Number} y The y coordinate on the page to be converted
     * @return {Number} The y coordinate on the canvas area
     */
    pageToCanvasY(y: number): number;

    /**
     * Checks whether the specified point is inside the game canvas area.
     *
     * @static
     * @method isInsideCanvas
     * @param {Number} x The x coordinate on the canvas area
     * @param {Number} y The y coordinate on the canvas area
     * @return {Boolean} True if the specified point is inside the game canvas area
     */
    isInsideCanvas(x: number, y: number): boolean;

    /**
     * Calls pixi.js garbage collector
     */
    callGC(): void;



    _width: number;
    _height: number;
    _rendererType: string;
    _boxWidth: number;
    _boxHeight: number;
    _scale: number;
    _realScale: number;
    _errorPrinter: boolean;
    _canvas: HTMLCanvasElement;
    _video: HTMLVideoElement;
    _upperCanvas: HTMLCanvasElement;
    _renderer: PIXI.SystemRenderer;
    _fpsMeter: FPSMeter;
    _modeBox: HTMLDivElement;
    _skipCount: number;
    _maxSkip: number;
    _rendered: boolean;
    _loadingImage: HTMLImageElement;
    _loadingCount: number;
    _fpsMeterToggled: boolean;
    _stretchEnabled: boolean;
    _canUseDifferenceBlend: boolean;
    _canUseSaturationBlend: boolean;
    _hiddenCanvas: HTMLCanvasElement;

    /**
     * @static
     * @method _createAllElements
     * @private
     */
    _createAllElements(): void;

    /**
     * @static
     * @method _updateAllElements
     * @private
     */
    _updateAllElements(): void;

    /**
     * @static
     * @method _updateRealScale
     * @private
     */
    _updateRealScale(): void;

    /**
     * @static
     * @method _makeErrorHtml
     * @param {String} name
     * @param {String} message
     * @return {String}
     * @private
     */
    _makeErrorHtml(name: string, message: string): void;

    /**
     * @static
     * @method _defaultStretchMode
     * @private
     */
    _defaultStretchMode(): boolean;

    /**
     * @static
     * @method _testCanvasBlendModes
     * @private
     */
    _testCanvasBlendModes(): void;

    /**
     * @static
     * @method _modifyExistingElements
     * @private
     */
    _modifyExistingElements(): void;

    /**
     * @static
     * @method _createErrorPrinter
     * @private
     */
    _createErrorPrinter(): void;

    /**
     * @static
     * @method _updateErrorPrinter
     * @private
     */
    _updateErrorPrinter(): void;

    /**
     * @static
     * @method _createCanvas
     * @private
     */
    _createCanvas(): void;

    /**
     * @static
     * @method _updateCanvas
     * @private
     */
    _updateCanvas(): void;

    /**
     * @static
     * @method _createVideo
     * @private
     */
    _createVideo(): void;

    /**
     * @static
     * @method _updateVideo
     * @private
     */
    _updateVideo(): void;

    /**
     * @static
     * @method _createUpperCanvas
     * @private
     */
    _createUpperCanvas(): void;

    /**
     * @static
     * @method _updateUpperCanvas
     * @private
     */
    _updateUpperCanvas(): void;

    /**
     * @static
     * @method _clearUpperCanvas
     * @private
     */
    _clearUpperCanvas(): void;

    /**
     * @static
     * @method _paintUpperCanvas
     * @private
     */
    _paintUpperCanvas(): void;

    /**
     * @static
     * @method _createRenderer
     * @private
     */
    _createRenderer(): void;

    /**
     * @static
     * @method _updateRenderer
     * @private
     */
    _updateRenderer(): void;

    /**
     * @static
     * @method _createFPSMeter
     * @private
     */
    _createFPSMeter(): void;

    /**
     * @static
     * @method _createModeBox
     * @private
     */
    _createModeBox(): void;

    /**
     * @static
     * @method _createGameFontLoader
     * @private
     */
    _createGameFontLoader(): void;

    /**
     * @static
     * @method _createFontLoader
     * @param {String} name
     * @private
     */
    _createFontLoader(name: string): void;

    /**
     * @static
     * @method _centerElement
     * @param {HTMLCanvasElement} element
     * @private
     */
    _centerElement(element: HTMLCanvasElement): void;

    /**
     * @static
     * @method _disableTextSelection
     * @private
     */
    _disableTextSelection(): void;

    /**
     * @static
     * @method _disableContextMenu
     * @private
     */
    _disableContextMenu(): void;

    /**
     * @static
     * @method _applyCanvasFilter
     * @private
     */
    _applyCanvasFilter(): void;

    /**
     * @static
     * @method _onVideoLoad
     * @private
     */
    _onVideoLoad(): void;

    /**
     * @static
     * @method _onVideoError
     * @private
     */
    _onVideoError(): void;

    /**
     * @static
     * @method _onVideoEnd
     * @private
     */
    _onVideoEnd(): void;

    /**
     * @static
     * @method _updateVisibility
     * @param {Boolean} videoVisible
     * @private
     */
    _updateVisibility(videoVisible: boolean): void;

    /**
     * @static
     * @method _isVideoVisible
     * @return {Boolean}
     * @private
     */
    _isVideoVisible(): boolean;

    /**
     * @static
     * @method _setupEventHandlers
     * @private
     */
    _setupEventHandlers(): void;

    /**
     * @static
     * @method _onWindowResize
     * @private
     */
    _onWindowResize(): void;

    /**
     * @static
     * @method _onKeyDown
     * @param {KeyboardEvent} event
     * @private
     */
    _onKeyDown(event: KeyboardEvent): void;

    /**
     * @static
     * @method _switchFPSMeter
     * @private
     */
    _switchFPSMeter(): void;

    /**
     * @static
     * @method _switchStretchMode
     * @return {Boolean}
     * @private
     */
    _switchStretchMode(): void;

    /**
     * @static
     * @method _switchFullScreen
     * @private
     */
    _switchFullScreen(): void;

    /**
     * @static
     * @method _isFullScreen
     * @return {Boolean}
     * @private
     */
    _isFullScreen(): boolean;

    /**
     * @static
     * @method _requestFullScreen
     * @private
     */
    _requestFullScreen(): void;

    /**
     * @static
     * @method _cancelFullScreen
     * @private
     */
    _cancelFullScreen(): void;
}
declare var Graphics: GraphicsStatic;

/**
 * The static class that handles HTML5 Audio.
 *
 * @class Html5Audio
 * @constructor
 */
interface Html5AudioStatic {
    _initialized: boolean;
    _unlocked: boolean;
    _audioElement: HTMLAudioElement;
    _gainTweenInterval: number;
    _tweenGain: number;
    _tweenTargetGain: number;
    _tweenGainStep: number;
    _staticSePath: boolean;
    _volume: number;
    _loadListeners: Array<() => void>;
    _hasError: boolean;
    _autoPlay: boolean;
    _isLoading: boolean;
    _buffered: boolean;

    /**
     * [read-only] The url of the audio file.
     *
     * @property url
     * @type String
     */
    url: string;

    /**
     * The volume of the audio.
     *
     * @property volume
     * @type Number
     */
    volume: number;

    /**
     * Sets up the Html5 Audio.
     *
     * @static
     * @method setup
     * @param {String} url The url of the audio file
     */
    setup(url: string): void;

    /**
     * Initializes the audio system.
     *
     * @static
     * @method initialize
     * @return {Boolean} True if the audio system is available
     */
    initialize(): void;

    /**
     * Clears the audio data.
     *
     * @static
     * @method clear
     */
    clear(): void;

    /**
     * Set the URL of static se.
     *
     * @static
     * @param {String} url
     */
    setStaticSe(url: string): void;

    /**
     * Checks whether the audio data is ready to play.
     *
     * @static
     * @method isReady
     * @return {Boolean} True if the audio data is ready to play
     */
    isReady(): boolean;

    /**
     * Checks whether a loading error has occurred.
     *
     * @static
     * @method isError
     * @return {Boolean} True if a loading error has occurred
     */
    isError(): boolean;

    /**
     * Checks whether the audio is playing.
     *
     * @static
     * @method isPlaying
     * @return {Boolean} True if the audio is playing
     */
    isPlaying(): boolean;

    /**
     * Plays the audio.
     *
     * @static
     * @method play
     * @param {Boolean} loop Whether the audio data play in a loop
     * @param {Number} offset The start position to play in seconds
     */
    play(loop: boolean, offset: number): void;

    /**
     * Stops the audio.
     *
     * @static
     * @method stop
     */
    stop(): void;

    /**
     * Performs the audio fade-in.
     *
     * @static
     * @method fadeIn
     * @param {Number} duration Fade-in time in seconds
     */
    fadeIn(duration: number): void;

    /**
     * Performs the audio fade-out.
     *
     * @static
     * @method fadeOut
     * @param {Number} duration Fade-out time in seconds
     */
    fadeOut(duration: number): void;

    /**
     * Gets the seek position of the audio.
     *
     * @static
     * @method seek
     */
    seek(): void;

    /**
     * Add a callback function that will be called when the audio data is loaded.
     *
     * @static
     * @method addLoadListener
     * @param {Function} listener The callback function
     */
    addLoadListener(listener: () => void): void;

    /**
     * @static
     * @method _setupEventHandlers
     * @private
     */
    _setupEventHandlers(): void;

    /**
     * @static
     * @method _onTouchStart
     * @private
     */
    _onTouchStart(): void;

    /**
     * @static
     * @method _onVisibilityChange
     * @private
     */
    _onVisibilityChange(): void;

    /**
     * @static
     * @method _onLoadedData
     * @private
     */
    _onLoadedData(): void;

    /**
     * @static
     * @method _onError
     * @private
     */
    _onError(): void;

    /**
     * @static
     * @method _onEnded
     * @private
     */
    _onEnded(): void;

    /**
     * @static
     * @method _onHide
     * @private
     */
    _onHide(): void;

    /**
     * @static
     * @method _onShow
     * @private
     */
    _onShow(): void;

    /**
     * @static
     * @method _load
     * @param {String} url
     * @private
     */
    _load(url: string): void;

    /**
     * @static
     * @method _startPlaying
     * @param {Boolean} loop
     * @param {Number} offset
     * @private
     */
    _startPlaying(loop: boolean, offset: number): void;

    /**
     * @static
     * @method _onLoad
     * @private
     */
    _onLoad(): void;

    /**
     * @static
     * @method _startGainTween
     * @params {Number} duration
     * @private
     */
    _startGainTweenfunction(duration: number): void;

    /**
     * @static
     * @method _applyTweenValue
     * @param {Number} volume
     * @private
     */
    _applyTweenValue(volume: number): void;
}
declare var Html5Audio: Html5AudioStatic;

/**
 * The static class that handles input data from the keyboard and gamepads.
 *
 * @class Input
 */
interface InputStatic {
    _currentState: { [key: string]: boolean };
    _previousState: { [key: string]: boolean };
    _gamepadStates: Array<Array<boolean>>;
    _latestButton: string;
    _pressedTime: number;
    _dir4: number;
    _dir8: number;
    _preferredAxis: string;
    _date: number;

    /**
     * The wait time of the key repeat in frames.
     *
     * @static
     * @property keyRepeatWait
     * @type Number
     */
    keyRepeatWait: number;

    /**
     * The interval of the key repeat in frames.
     *
     * @static
     * @property keyRepeatInterval
     * @type Number
     */
    keyRepeatInterval: number;

    /**
     * A hash table to convert from a virtual key code to a mapped key name.
     *
     * @static
     * @property keyMapper
     * @type Object
     */
    keyMapper: { [key: number]: string };

    /**
     * A hash table to convert from a gamepad button to a mapped key name.
     *
     * @static
     * @property gamepadMapper
     * @type Object
     */
    gamepadMapper: { [key: number]: string };

    /**
     * [read-only] The four direction value as a number of the numpad, or 0 for neutral.
     *
     * @static
     * @property dir4
     * @type Number
     */
    dir4: number;

    /**
     * [read-only] The eight direction value as a number of the numpad, or 0 for neutral.
     *
     * @static
     * @property dir8
     * @type Number
     */
    dir8: number;

    /**
     * [read-only] The time of the last input in milliseconds.
     *
     * @static
     * @property date
     * @type Number
     */
    date: number;

    /**
     * Initializes the input system.
     *
     * @static
     * @method initialize
     */
    initialize(): void;

    /**
     * Clears all the input data.
     *
     * @static
     * @method clear
     */
    clear(): void;

    /**
     * Updates the input data.
     *
     * @static
     * @method update
     */
    update(): void;

    /**
     * Checks whether a key is currently pressed down.
     *
     * @static
     * @method isPressed
     * @param {String} keyName The mapped name of the key
     * @return {Boolean} True if the key is pressed
     */
    isPressed(keyName: string): boolean;

    /**
     * Checks whether a key is just pressed.
     *
     * @static
     * @method isTriggered
     * @param {String} keyName The mapped name of the key
     * @return {Boolean} True if the key is triggered
     */
    isTriggered(keyName: string): boolean;

    /**
     * Checks whether a key is just pressed or a key repeat occurred.
     *
     * @static
     * @method isRepeated
     * @param {String} keyName The mapped name of the key
     * @return {Boolean} True if the key is repeated
     */
    isRepeated(keyName: string): boolean;

    /**
     * Checks whether a key is kept depressed.
     *
     * @static
     * @method isLongPressed
     * @param {String} keyName The mapped name of the key
     * @return {Boolean} True if the key is long-pressed
     */
    isLongPressed(keyName: string): boolean;

    /**
     * @static
     * @method _wrapNwjsAlert
     * @private
     */
    _wrapNwjsAlert(): void;

    /**
     * @static
     * @method _setupEventHandlers
     * @private
     */
    _setupEventHandlers(): void;

    /**
     * @static
     * @method _onKeyDown
     * @param {KeyboardEvent} event
     * @private
     */
    _onKeyDown(event: KeyboardEvent): void;

    /**
     * @static
     * @method _shouldPreventDefault
     * @param {Number} keyCode
     * @return {Boolean}
     * @private
     */
    _shouldPreventDefault(keyCode: number): boolean;

    /**
     * @static
     * @method _onKeyUp
     * @param {KeyboardEvent} event
     * @private
     */
    _onKeyUp(event: KeyboardEvent): void;

    /**
     * @static
     * @method _onLostFocus
     * @private
     */
    _onLostFocus(): void;

    /**
     * @static
     * @method _pollGamepads
     * @private
     */
    _pollGamepads(): void;

    /**
     * @static
     * @method _updateGamepadState
     * @param {Gamepad} gamepad
     * @private
     */
    _updateGamepadState(gamepad: Gamepad): void;

    /**
     * @static
     * @method _updateDirection
     * @private
     */
    _updateDirection(): void;

    /**
     * @static
     * @method _signX
     * @return {Number}
     * @private
     */
    _signX(): number;

    /**
     * @static
     * @method _signY
     * @return {Number}
     * @private
     */
    _signY(): number;

    /**
     * @static
     * @method _makeNumpadDirection
     * @param {Number} x
     * @param {Number} y
     * @return {Number}
     * @private
     */
    _makeNumpadDirection(x: number, y: number): number;

    /**
     * @static
     * @method _isEscapeCompatible
     * @param {String} keyName
     * @return {Boolean}
     * @private
     */
    _isEscapeCompatible(keyName: string): boolean;
}
declare var Input: InputStatic;

/**
 * This is not a class, but contains some methods that will be added to the
 * standard Javascript objects.
 *
 * @class JsExtensions
 */
declare class JsExtensions { }

interface Array<T> {
    /**
     * Makes a shallow copy of the array.
     *
     * @method Array.prototype.clone
     * @return {Array} A shallow copy of the array
     */
    clone(): Array<T>;

    /**
     * Checks whether the array contains a given element.
     *
     * @method Array.prototype.contains
     * @param {Any} element The element to search for
     * @return {Boolean} True if the array contains a given element
     */
    contains(element: T): boolean;

    /**
     * Checks whether the two arrays are same.
     *
     * @method Array.prototype.equals
     * @param {Array} array The array to compare to
     * @return {Boolean} True if the two arrays are same
     */
    equals(array: Array<any>): boolean;
}

interface Math {
    /**
     * Generates a random integer in the range (0, max-1).
     *
     * @static
     * @method Math.randomInt
     * @param {Number} max The upper boundary (excluded)
     * @return {Number} A random integer
     */
    randomInt(max: number): number;
}

interface Number {
    /**
     * Returns a number whose value is limited to the given range.
     *
     * @method Number.prototype.clamp
     * @param {Number} min The lower boundary
     * @param {Number} max The upper boundary
     * @return {Number} A number in the range (min, max)
     */
    clamp(min: number, max: number): number;

    /**
     * Returns a modulo value which is always positive.
     *
     * @method Number.prototype.mod
     * @param {Number} n The divisor
     * @return {Number} A modulo value
     */
    mod(n: number): number;

    /**
     * Makes a number string with leading zeros.
     *
     * @method Number.prototype.padZero
     * @param {Number} length The length of the output string
     * @return {String} A string with leading zeros
     */
    padZero(length: number): string;
}

interface String {
    /**
     * Checks whether the string contains a given string.
     *
     * @method String.prototype.contains
     * @param {String} string The string to search for
     * @return {Boolean} True if the string contains a given string
     */
    contains(string): boolean;

    /**
     * Replaces %1, %2 and so on in the string to the arguments.
     *
     * @method String.prototype.format
     * @param {Any} ...args The objects to format
     * @return {String} A formatted string
     */
    format(...args: Array<any>): string;

    /**
     * Makes a number string with leading zeros.
     *
     * @method String.prototype.padZero
     * @param {Number} length The length of the output string
     * @return {String} A string with leading zeros
     */
    padZero(length: number): string;
}

declare class Point extends PIXI.Point {
    /**
     * The point class.
     *
     * @class Point
     * @constructor
     * @param {Number} x The x coordinate
     * @param {Number} y The y coordinate
     */
    constructor(x?: number, y?: number);

    /**
     * The x coordinate.
     *
     * @property x
     * @type Number
     */
    x: number;

    /**
     * The y coordinate.
     *
     * @property y
     * @type Number
     */
    y: number;
}

declare class Rectangle extends PIXI.Rectangle {
    /**
     * @static
     * @property emptyRectangle
     * @type Rectangle
     */
    static emptyRectangle: Rectangle;

    /**
     * The rectangle class.
     *
     * @class Rectangle
     * @constructor
     * @param {Number} x The x coordinate for the upper-left corner
     * @param {Number} y The y coordinate for the upper-left corner
     * @param {Number} width The width of the rectangle
     * @param {Number} height The height of the rectangle
     */
    constructor(x?: number, y?: number, width?: number, height?: number);

    /**
     * The x coordinate for the upper-left corner.
     *
     * @property x
     * @type Number
     */
    x: number;

    /**
     * The y coordinate for the upper-left corner.
     *
     * @property y
     * @type Number
     */
    y: number;

    /**
     * The width of the rectangle.
     *
     * @property width
     * @type Number
     */
    width: number;

    /**
     * The height of the rectangle.
     *
     * @property height
     * @type Number
     */
    height: number;
}

/**
 * The static class that handles JSON with object information.
 *
 * @class JsonEx
 */
interface JsonExStatic {
    /**
     * The maximum depth of objects.
     *
     * @static
     * @property maxDepth
     * @type Number
     * @default 100
     */
    maxDepth: number;

    /**
     * Makes a deep copy of the specified object.
     *
     * @static
     * @method makeDeepCopy
     * @param {Object} object The object to be copied
     * @return {Object} The copied object
     */
    makeDeepCopy(object: any): any;

    /**
     * Converts an object to a JSON string with object information.
     *
     * @static
     * @method stringify
     * @param {Object} object The object to be converted
     * @return {String} The JSON string
     */
    stringify(object: any): string;

    /**
     * Parses a JSON string and reconstructs the corresponding object.
     *
     * @static
     * @method parse
     * @param {String} json The JSON string
     * @return {Object} The reconstructed object
     */
    parse(json: string): any;

    /**
     * @static
     * @method _encode
     * @param {Object} value
     * @param {Number} depth
     * @return {Object}
     * @private
     */
    _encode(value: any, depth: number): any;

    /**
     * @static
     * @method _decode
     * @param {Object} value
     * @return {Object}
     * @private
     */
    _decode(value: any): any;

    /**
     * @static
     * @method _getConstructorName
     * @param {Object} value
     * @return {String}
     * @private
     */
    _getConstructorName(value: any): string;

    /**
     * @static
     * @method _resetPrototype
     * @param {Object} value
     * @param {Object} prototype
     * @return {Object}
     * @private
     */
    _resetPrototype(value: any, prototype: any): any;
}

/**
 * The static class that handles JSON with object information.
 *
 * @class JsonEx
 */
declare var JsonEx: JsonExStatic;

declare class ScreenSprite extends PIXI.Sprite {
    /**
     * The opacity of the sprite (0 to 255).
     *
     * @property opacity
     * @type Number
     */
    opacity: number;

    /**
     * The sprite which covers the entire game screen.
     *
     * @class ScreenSprite
     * @constructor
     */
    constructor();

    /**
     * Sets black to the color of the screen sprite.
     *
     * @method setBlack
     */
    setBlack(): void;

    /**
     * Sets white to the color of the screen sprite.
     *
     * @method setWhite
     */
    setWhite(): void;

    /**
     * Sets the color of the screen sprite by values.
     *
     * @method setColor
     * @param {Number} r The red value in the range (0, 255)
     * @param {Number} g The green value in the range (0, 255)
     * @param {Number} b The blue value in the range (0, 255)
     */
    setColor(r?: number, g?: number, b?: number): void;

    protected _graphics: PIXI.Graphics;
    protected _red: number;
    protected _green: number;
    protected _blue: number;
    protected _colorText: string;
}

declare class Sprite extends PIXI.Sprite {
    /**
     * Number of the created objects.
     *
     * @static
     * @property _counter
     * @type Number
     */
    static _counter: number;

    /**
     * The image for the sprite.
     *
     * @property bitmap
     * @type Bitmap
     */
    bitmap: Bitmap;

    /**
     * The width of the sprite without the scale.
     *
     * @property width
     * @type Number
     */
    width: number;

    /**
     * The height of the sprite without the scale.
     *
     * @property height
     * @type Number
     */
    height: number;

    /**
     * The opacity of the sprite (0 to 255).
     *
     * @property opacity
     * @type Number
     */
    opacity: number;

    /**
     * The visibility of the sprite.
     *
     * @property visible
     * @type Boolean
     */
    visible: boolean;

    /**
     * The x coordinate of the sprite.
     *
     * @property x
     * @type Number
     */
    x: number;

    /**
     * The y coordinate of the sprite.
     *
     * @property y
     * @type Number
     */
    y: number;

    /**
     * The origin point of the sprite. (0,0) to (1,1).
     *
     * @property anchor
     * @type Point
     */
    point: Point;

    /**
     * The scale factor of the sprite.
     *
     * @property scale
     * @type Point
     */
    scale: Point;

    /**
     * The rotation of the sprite in radians.
     *
     * @property rotation
     * @type Number
     */
    rotation: number;

    /**
     * The blend mode to be applied to the sprite.
     *
     * @property blendMode
     * @type Number
     */
    blendMode: number;

    /**
     * Sets the filters for the sprite.
     *
     * @property filters
     * @type Array<PIXI.Filter>
     */
    filters: Array<PIXI.Filter>;

    /**
     * [read-only] The array of children of the sprite.
     *
     * @property children
     * @type Array<PIXI.DisplayObject>
     */
    children: Array<PIXI.DisplayObject>;

    /**
     * [read-only] The object that contains the sprite.
     *
     * @property parent
     * @type PIXI.DisplayObjectContainer
     */
    parent: PIXI.Container;

    spriteId: number;
    opaque: boolean;
    voidFilter: PIXI.Filter;

    /**
     * The basic object that is rendered to the game screen.
     *
     * @class Sprite
     * @constructor
     * @param {Bitmap} bitmap The image for the sprite
     */
    constructor(bitmap?: Bitmap);

    /**
     * Updates the sprite for each frame.
     *
     * @method update
     */
    update(): void;

    /**
     * @method updateTransform
     * @private
     */
    updateTransform(): void;

    /**
     * Sets the x and y at once.
     *
     * @method move
     * @param {Number} x The x coordinate of the sprite
     * @param {Number} y The y coordinate of the sprite
     */
    move(x: number, y: number): void;

    /**
     * Sets the rectangle of the bitmap that the sprite displays.
     *
     * @method setFrame
     * @param {Number} x The x coordinate of the frame
     * @param {Number} y The y coordinate of the frame
     * @param {Number} width The width of the frame
     * @param {Number} height The height of the frame
     */
    setFrame(x: number, y: number, width: number, height: number): void;

    /**
     * Gets the blend color for the sprite.
     *
     * @method getBlendColor
     * @return {Array} The blend color [r, g, b, a]
     */
    getBlendColor(): Array<number>;

    /**
     * Sets the blend color for the sprite.
     *
     * @method setBlendColor
     * @param {Array} color The blend color [r, g, b, a]
     */
    setBlendColor(color: Array<number>): void;

    /**
     * Gets the color tone for the sprite.
     *
     * @method getColorTone
     * @return {Array} The color tone [r, g, b, gray]
     */
    getColorTone(): Array<number>;

    /**
     * Sets the color tone for the sprite.
     *
     * @method setColorTone
     * @param {Array} tone The color tone [r, g, b, gray]
     */
    setColorTone(tone: Array<number>): void;

    /**
     * Adds a child to the container.
     *
     * @method addChild
     * @param {PIXI.DisplayObject} child The child to add
     * @return {PIXI.DisplayObject} The child that was added
     */
    addChild(child: PIXI.DisplayObject): PIXI.DisplayObject;

    /**
     * Adds a child to the container at a specified index.
     *
     * @method addChildAt
     * @param {PIXI.DisplayObject} child The child to add
     * @param {Number} index The index to place the child in
     * @return {PIXI.DisplayObject} The child that was added
     */
    addChildAt(child: PIXI.DisplayObject, index: number): PIXI.DisplayObject;

    /**
     * Removes a child from the container.
     *
     * @method removeChild
     * @param {PIXI.DisplayObject} child The child to remove
     * @return {PIXI.DisplayObject} The child that was removed
     */
    removeChild(child: PIXI.DisplayObject): PIXI.DisplayObject;

    /**
     * Removes a child from the specified index position.
     *
     * @method removeChildAt
     * @param {Number} index The index to get the child from
     * @return {PIXI.DisplayObject} The child that was removed
     */
    removeChildAt(index: number): PIXI.DisplayObject;

    protected _bitmap: Bitmap;
    protected _frame: Rectangle;
    protected _realFrame: Rectangle;
    protected _offset: Point;
    protected _blendColor: Array<Number>;
    protected _colorTone: Array<Number>;
    protected _canvas: HTMLCanvasElement;
    protected _context: CanvasRenderingContext2D;
    protected _tintTexture: PIXI.BaseTexture;

    /**
     * use heavy renderer that will reduce border artifacts and apply advanced blendModes
     * @type {boolean}
     * @private
     */
    protected _isPicture: boolean;

    /**
     * @method _onBitmapLoad
     * @private
     */
    protected _onBitmapLoad(): void;

    /**
     * @method _refresh
     * @private
     */
    protected _refresh(): void;

    /**
     * @method _isInBitmapRect
     * @param {Number} x
     * @param {Number} y
     * @param {Number} w
     * @param {Number} h
     * @return {Boolean}
     * @private
     */
    protected _isInBitmapRect(x: number, y: number, w: number, h: number): boolean;

    /**
     * @method _needsTint
     * @return {Boolean}
     * @private
     */
    protected _needsTint(): boolean;

    /**
     * @method _createTinter
     * @param {Number} w
     * @param {Number} h
     * @private
     */
    protected _createTinter(w: number, h: number): void;

    /**
     * @method _executeTint
     * @param {Number} x
     * @param {Number} y
     * @param {Number} w
     * @param {Number} h
     * @private
     */
    protected _executeTint(x: number, y: number, w: number, h: number): void;

    /**
     * @method _renderCanvas
     * @param {PIXI.CanvasRenderer} renderer
     * @private
     */
    protected _renderCanvas_PIXI(renderer: PIXI.CanvasRenderer): void;

    /**
     * @method _renderWebGL
     * @param {PIXI.WebGLRenderer} renderer
     * @private
     */
    protected _renderWebGL_PIXI(renderer: PIXI.WebGLRenderer): void;

    /**
     * @method _renderCanvas
     * @param {PIXI.CanvasRenderer} renderer
     * @private
     */
    protected _renderCanvas(renderer: PIXI.CanvasRenderer): void;

    /**
     * @method _renderWebGL
     * @param {PIXI.WebGLRenderer} renderer
     * @private
     */
    protected _renderWebGL(renderer: PIXI.WebGLRenderer): void;

    /**
     * checks if we need to speed up custom blendmodes
     * @param renderer
     * @private
     */
    protected _speedUpCustomBlendModes(renderer: PIXI.WebGLRenderer): void;
}

declare class Stage extends PIXI.Container {
    // The interactive flag causes a memory leak.
    interactive: boolean;

    /**
     * The root object of the display tree.
     *
     * @class Stage
     * @constructor
     */
    constructor();

    /**
     * Adds a child to the container.
     *
     * @method addChild
     * @param {PIXI.DisplayObject} child The child to add
     * @return {PIXI.DisplayObject} The child that was added
     */
    addChild(child: PIXI.DisplayObject): PIXI.DisplayObject;

    /**
     * Adds a child to the container at a specified index.
     *
     * @method addChildAt
     * @param {PIXI.DisplayObject} child The child to add
     * @param {Number} index The index to place the child in
     * @return {PIXI.DisplayObject} The child that was added
     */
    addChildAt(child: PIXI.DisplayObject, index: number): PIXI.DisplayObject;

    /**
     * Removes a child from the container.
     *
     * @method removeChild
     * @param {PIXI.DisplayObject} child The child to remove
     * @return {PIXI.DisplayObject} The child that was removed
     */
    removeChild(child: PIXI.DisplayObject): PIXI.DisplayObject;

    /**
     * Removes a child from the specified index position.
     *
     * @method removeChildAt
     * @param {Number} index The index to get the child from
     * @return {PIXI.DisplayObject} The child that was removed
     */
    removeChildAt(index: number): PIXI.DisplayObject;
}

declare class Tilemap extends PIXI.Container {
    // Tile type checkers

    static TILE_ID_A1: number;
    static TILE_ID_A2: number;
    static TILE_ID_A3: number;
    static TILE_ID_A4: number;
    static TILE_ID_A5: number;
    static TILE_ID_B: number;
    static TILE_ID_C: number;
    static TILE_ID_D: number;
    static TILE_ID_E: number;
    static TILE_ID_MAX: number;

    static FLOOR_AUTOTILE_TABLE: Array<Array<Array<number>>>;
    static WALL_AUTOTILE_TABLE: Array<Array<Array<number>>>;
    static WATERFALL_AUTOTILE_TABLE: Array<Array<Array<number>>>;

    static isVisibleTile(tileId: number): boolean;
    static isAutotile(tileId: number): boolean;
    static getAutotileKind(tileId: number): number;
    static getAutotileShape(tileId: number): number;
    static makeAutotileId(kind: number, shape: number): number;
    static isSameKindTile(tileID1: number, tileID2: number): boolean;
    static isTileA1(tileId: number): boolean;
    static isTileA2(tileId: number): boolean;
    static isTileA3(tileId: number): boolean;
    static isTileA4(tileId: number): boolean;
    static isTileA5(tileId: number): boolean;
    static isWaterTile(tileId: number): boolean;
    static isWaterfallTile(tileId: number): boolean;
    static isGroundTile(tileId: number): boolean;
    static isShadowingTile(tileId: number): boolean;
    static isRoofTile(tileId: number): boolean;
    static isWallTopTile(tileId: number): boolean;
    static isWallSideTile(tileId: number): boolean;
    static isWallTile(tileId: number): boolean;
    static isFloorTypeAutotile(tileId: number): boolean;
    static isWallTypeAutotile(tileId: number): boolean;
    static isWaterfallTypeAutotile(tileId: number): boolean;

    /**
     * The bitmaps used as a tileset.
     *
     * @property bitmaps
     * @type Array
     */
    bitmaps: Array<Bitmap>;

    /**
     * The origin point of the tilemap for scrolling.
     *
     * @property origin
     * @type Point
     */
    origin: Point;

    /**
     * The tileset flags.
     *
     * @property flags
     * @type Array
     */
    flags: Array<number>;

    /**
     * The animation count for autotiles.
     *
     * @property animationCount
     * @type Number
     */
    animationCount: number;

    /**
     * Whether the tilemap loops horizontal.
     *
     * @property horizontalWrap
     * @type Boolean
     */
    horizontalWrap: boolean;

    /**
     * Whether the tilemap loops vertical.
     *
     * @property verticalWrap
     * @type Boolean
     */
    verticalWrap: boolean;

    /**
     * The width of the screen in pixels.
     *
     * @property width
     * @type Number
     */
    width: number;

    /**
     * The height of the screen in pixels.
     *
     * @property height
     * @type Number
     */
    height: number;

    /**
     * The width of a tile in pixels.
     *
     * @property tileWidth
     * @type Number
     */
    tileWidth: number;

    /**
     * The height of a tile in pixels.
     *
     * @property tileHeight
     * @type Number
     */
    tileHeight: number;

    /**
     * [read-only] The array of children of the sprite.
     *
     * @property children
     * @type Array<PIXI.DisplayObject>
     */
    children: Array<PIXI.DisplayObject>;

    /**
     * [read-only] The object that contains the sprite.
     *
     * @property parent
     * @type PIXI.DisplayObjectContainer
     */
    parent: PIXI.Container;

    /**
     * The tilemap which displays 2D tile-based game map.
     *
     * @class Tilemap
     * @constructor
     */
    constructor();

    /**
     * Sets the tilemap data.
     *
     * @method setData
     * @param {Number} width The width of the map in number of tiles
     * @param {Number} height The height of the map in number of tiles
     * @param {Array} data The one dimensional array for the map data
     */
    setData(width: number, height: number, data: Array<number>);

    /**
     * Checks whether the tileset is ready to render.
     *
     * @method isReady
     * @type Boolean
     * @return {Boolean} True if the tilemap is ready
     */
    isReady(): boolean;

    /**
     * Updates the tilemap for each frame.
     *
     * @method update
     */
    update(): void;

    /**
     * @method updateTransform
     * @private
     */
    updateTransform(): void;

    /**
     * Forces to repaint the entire static
     *
     * @method refresh
     */
    refresh(): void;

    /**
     * Adds a child to the container.
     *
     * @method addChild
     * @param {PIXI.DisplayObject} child The child to add
     * @return {PIXI.DisplayObject} The child that was added
     */
    addChild(child: PIXI.DisplayObject): PIXI.DisplayObject;

    /**
     * Adds a child to the container at a specified index.
     *
     * @method addChildAt
     * @param {PIXI.DisplayObject} child The child to add
     * @param {Number} index The index to place the child in
     * @return {PIXI.DisplayObject} The child that was added
     */
    addChildAt(child: PIXI.DisplayObject, index: number): PIXI.DisplayObject;

    /**
     * Removes a child from the container.
     *
     * @method removeChild
     * @param {PIXI.DisplayObject} child The child to remove
     * @return {PIXI.DisplayObject} The child that was removed
     */
    removeChild(child: PIXI.DisplayObject): PIXI.DisplayObject;

    /**
     * Removes a child from the specified index position.
     *
     * @method removeChildAt
     * @param {Number} index The index to get the child from
     * @return {PIXI.DisplayObject} The child that was removed
     */
    removeChildAt(index: number): PIXI.DisplayObject;

    /**
     * Forces to refresh the tileset
     *
     * @method refresh
     */
    refreshTileset(): void;


    protected _margin: number;
    protected _width: number;
    protected _height: number;
    protected _tileWidth: number;
    protected _tileHeight: number;
    protected _mapWidth: number;
    protected _mapHeight: number;
    protected _mapData: Array<number>;
    protected _layerWidth: number;
    protected _layerHeight: number;
    protected _lastTiles: Array<Array<Array<Array<number>>>>;
    protected _lowerLayer: Sprite;
    protected _upperLayer: Sprite;

    /**
     * @method _createLayers
     * @private
     */
    protected _createLayers(): void;

    /**
     * @method _updateLayerPositions
     * @param {Number} startX
     * @param {Number} startY
     * @private
     */
    protected _updateLayerPositions(startX: number, startY: number): void;

    /**
     * @method _paintAllTiles
     * @param {Number} startX
     * @param {Number} startY
     * @private
     */
    protected _paintAllTiles(startX: number, startY: number): void;

    /**
     * @method _paintTiles
     * @param {Number} startX
     * @param {Number} startY
     * @param {Number} x
     * @param {Number} y
     * @private
     */
    protected _paintTiles(startX: number, startY: number, x: number, y: number): void;

    /**
     * @method _readLastTiles
     * @param {Number} i
     * @param {Number} x
     * @param {Number} y
     * @private
     */
    protected _readLastTiles(i: number, x: number, y: number): Array<number>;

    /**
     * @method _writeLastTiles
     * @param {Number} i
     * @param {Number} x
     * @param {Number} y
     * @param {Array} tiles
     * @private
     */
    protected _writeLastTiles(i: number, x: number, y: number, tiles: Array<number>): void;

    /**
     * @method _drawTile
     * @param {Bitmap} bitmap
     * @param {Number} tileId
     * @param {Number} dx
     * @param {Number} dy
     * @private
     */
    protected _drawTile(bitmap: Bitmap, tileId: number, dx: number, dy: number): void;

    /**
     * @method _drawNormalTile
     * @param {Bitmap} bitmap
     * @param {Number} tileId
     * @param {Number} dx
     * @param {Number} dy
     * @private
     */
    protected _drawNormalTile(bitmap: Bitmap, tileId: number, dx: number, dy: number): void;

    /**
     * @method _drawAutotile
     * @param {Bitmap} bitmap
     * @param {Number} tileId
     * @param {Number} dx
     * @param {Number} dy
     * @private
     */
    protected _drawAutotile(bitmap: Bitmap, tileId: number, dx: number, dy: number): void;

    /**
     * @method _drawTableEdge
     * @param {Bitmap} bitmap
     * @param {Number} tileId
     * @param {Number} dx
     * @param {Number} dy
     * @private
     */
    protected _drawTableEdge(bitmap: Bitmap, tileId: number, dx: number, dy: number): void;

    /**
     * @method _drawShadow
     * @param {Bitmap} bitmap
     * @param {Number} shadowBits
     * @param {Number} dx
     * @param {Number} dy
     * @private
     */
    protected _drawShadow(bitmap: Bitmap, shadowBits: number, dx: number, dy: number): void;

    /**
     * @method _readMapData
     * @param {Number} x
     * @param {Number} y
     * @param {Number} z
     * @return {Number}
     * @private
     */
    protected _readMapData(x: number, y: number, z: number): number;

    /**
     * @method _isHigherTile
     * @param {Number} tileId
     * @return {Boolean}
     * @private
     */
    protected _isHigherTile(tileId: number): boolean;

    /**
     * @method _isTableTile
     * @param {Number} tileId
     * @return {Boolean}
     * @private
     */
    protected _isTableTile(tileId: number): boolean;

    /**
     * @method _isOverpassPosition
     * @param {Number} mx
     * @param {Number} my
     * @return {Boolean}
     * @private
     */
    protected _isOverpassPosition(mx: number, my: number): boolean;

    /**
     * @method _sortChildren
     * @private
     */
    protected _sortChildren(): void;

    /**
     * @method _compareChildOrder
     * @param {Sprite} a
     * @param {Sprite} b
     * @private
     */
    protected _compareChildOrder(a: Sprite, b: Sprite): number;
}

declare class ShaderTilemap extends Tilemap {
    /**
     * Uploads animation state in renderer
     *
     * @method _hackRenderer
     * @param {PIXI.SystemRenderer} pixi renderer
     * @private
     */
    _hackRenderer(renderer: PIXI.SystemRenderer): PIXI.SystemRenderer;

    /**
     * PIXI render method
     *
     * @method renderWebGL
     * @param {PIXI.WebGLRenderer} pixi renderer
     */
    renderWebGL(renderer: PIXI.WebGLRenderer): void;

    /**
     * PIXI render method
     *
     * @method renderCanvas
     * @param {PIXI.CanvasRenderer} pixi renderer
     */
    renderCanvas(renderer: PIXI.CanvasRenderer): void;

    /**
     * Forces to repaint the entire tilemap AND update bitmaps list if needed
     *
     * @method refresh
     */
    refresh(): void;

    /**
     * Call after you update tileset
     *
     * @method refreshTileset
     */
    refreshTileset(): void;
}

declare class TilingSprite extends PIXI.extras.TilingSprite {
    /**
     * The origin point of the tiling sprite for scrolling.
     *
     * @property origin
     * @type Point
     */
    origin: Point;

    /**
     * The image for the tiling sprite.
     *
     * @property bitmap
     * @type Bitmap
     */
    bitmap: Bitmap;

    /**
     * The opacity of the tiling sprite (0 to 255).
     *
     * @property opacity
     * @type Number
     */
    opacity: number;

    /**
     * The visibility of the tiling sprite.
     *
     * @property visible
     * @type Boolean
     */
    visibility: boolean;

    /**
     * The x coordinate of the tiling sprite.
     *
     * @property x
     * @type Number
     */
    x: number;

    /**
     * The y coordinate of the tiling sprite.
     *
     * @property y
     * @type Number
     */
    y: number;

    spriteId: number;

    /**
     * The sprite object for a tiling image.
     *
     * @class TilingSprite
     * @constructor
     * @param {Bitmap} bitmap The image for the tiling sprite
     */
    constructor(bitmap: Bitmap);

    /**
     * Updates the tiling sprite for each frame.
     *
     * @method update
     */
    update(): void;

    /**
     * @method updateTransform
     * @private
     */
    updateTransform(): void;

    /**
     * Sets the x, y, width, and height all at once.
     *
     * @method move
     * @param {Number} x The x coordinate of the tiling sprite
     * @param {Number} y The y coordinate of the tiling sprite
     * @param {Number} width The width of the tiling sprite
     * @param {Number} height The height of the tiling sprite
     */
    move(x?: number, y?: number, width?: number, height?: number): void;

    /**
     * Specifies the region of the image that the tiling sprite will use.
     *
     * @method setFrame
     * @param {Number} x The x coordinate of the frame
     * @param {Number} y The y coordinate of the frame
     * @param {Number} width The width of the frame
     * @param {Number} height The height of the frame
     */
    setFrame(x: number, y: number, width: number, height: number): void;

    updateTransformTS(): void;

    protected _bitmap: Bitmap;
    protected _width: number;
    protected _height: number;
    protected _frame: Rectangle;

    /**
     * @method _onBitmapLoad
     * @private
     */
    protected _onBitmapLoad(): void;

    /**
     * @method _refresh
     * @private
     */
    protected _refresh(): void;

    /**
     * @method _renderCanvas
     * @param {PIXI.CanvasRenderer} renderer
     * @private
     */
    protected _renderCanvas(renderer: PIXI.CanvasRenderer): void;

    /**
     * @method _renderWebGL
     * @param {PIXI.WebGLRenderer} renderer
     * @private
     */
    protected _renderWebGL(renderer: PIXI.WebGLRenderer): void;

    /**
     * @method generateTilingTexture
     * @param {Boolean} arg
     */
    // generateTilingTexture(arg: boolean): void;
}

declare class ToneFilter extends PIXI.filters.ColorMatrixFilter {
    /**
     * The color matrix filter for WebGL.
     *
     * @class ToneFilter
     * @extends PIXI.Filter
     * @constructor
     */
    constructor();

    /**
     * Changes the hue.
     *
     * @method adjustHue
     * @param {Number} value The hue value in the range (-360, 360)
     */
    adjustHue(value?: number): void;

    /**
     * Changes the saturation.
     *
     * @method adjustSaturation
     * @param {Number} value The saturation value in the range (-255, 255)
     */
    adjustSaturation(value?: number): void;

    /**
     * Changes the tone.
     *
     * @method adjustTone
     * @param {Number} r The red strength in the range (-255, 255)
     * @param {Number} g The green strength in the range (-255, 255)
     * @param {Number} b The blue strength in the range (-255, 255)
     */
    adjustTone(r?: number, g?: number, b?: number): void;
}

declare class ToneSprite extends PIXI.Container {
    /**
     * The sprite which changes the screen color in 2D canvas mode.
     *
     * @class ToneSprite
     * @constructor
     */
    constructor();

    /**
     * Clears the tone.
     *
     * @method reset
     */
    clear(): void;

    /**
     * Sets the tone.
     *
     * @method setTone
     * @param {Number} r The red strength in the range (-255, 255)
     * @param {Number} g The green strength in the range (-255, 255)
     * @param {Number} b The blue strength in the range (-255, 255)
     * @param {Number} gray The grayscale level in the range (0, 255)
     */
    setTone(r: number, g: number, b: number, gray: number): void;

    protected _red: number;
    protected _green: number;
    protected _blue: number;
    protected _gray: number;

    /**
     * @method _renderCanvas
     * @param {PIXI.CanvasRenderer} renderer
     * @private
     */
    protected _renderCanvas(renderer: PIXI.CanvasRenderer): void;

    /**
     * @method _renderWebGL
     * @param {PIXI.WebGLRenderer} renderer
     * @private
     */
    protected _renderWebGL(renderer: PIXI.WebGLRenderer): void;
}

interface TouchInputStatic {
    _mousePressed: boolean;
    _screenPressed: boolean;
    _pressedTime: number;
    _events: MV.TouchInputEvents;
    _triggered: boolean;
    _cancelled: boolean;
    _moved: boolean;
    _released: boolean;
    _wheelX: number;
    _wheelY: number;
    _x: number;
    _y: number;
    _date: number;

    /**
     * The wait time of the pseudo key repeat in frames.
     *
     * @static
     * @property keyRepeatWait
     * @type Number
     */
    keyRepeatWait: number;

    /**
     * The interval of the pseudo key repeat in frames.
     *
     * @static
     * @property keyRepeatInterval
     * @type Number
     */
    keyRepeatInterval: number;

    /**
     * [read-only] The horizontal scroll amount.
     *
     * @static
     * @property wheelX
     * @type Number
     */
    wheelX: number;

    /**
     * [read-only] The vertical scroll amount.
     *
     * @static
     * @property wheelY
     * @type Number
     */
    wheelY: number;

    /**
     * [read-only] The x coordinate on the canvas area of the latest touch event.
     *
     * @static
     * @property x
     * @type Number
     */
    x: number;

    /**
     * [read-only] The y coordinate on the canvas area of the latest touch event.
     *
     * @static
     * @property y
     * @type Number
     */
    y: number;

    /**
     * [read-only] The time of the last input in milliseconds.
     *
     * @static
     * @property date
     * @type Number
     */
    date: number;

    /**
     * Initializes the touch system.
     *
     * @static
     * @method initialize
     */
    initialize(): void;

    /**
     * Clears all the touch data.
     *
     * @static
     * @method clear
     */
    clear(): void;

    /**
     * Updates the touch data.
     *
     * @static
     * @method update
     */
    update(): void;

    /**
     * Checks whether the mouse button or touchscreen is currently pressed down.
     *
     * @static
     * @method isPressed
     * @return {Boolean} True if the mouse button or touchscreen is pressed
     */
    isPressed(): boolean;

    /**
     * Checks whether the left mouse button or touchscreen is just pressed.
     *
     * @static
     * @method isTriggered
     * @return {Boolean} True if the mouse button or touchscreen is triggered
     */
    isTriggered(): boolean;

    /**
     * Checks whether the left mouse button or touchscreen is just pressed
     * or a pseudo key repeat occurred.
     *
     * @static
     * @method isRepeated
     * @return {Boolean} True if the mouse button or touchscreen is repeated
     */
    isRepeated(): boolean;

    /**
     * Checks whether the left mouse button or touchscreen is kept depressed.
     *
     * @static
     * @method isLongPressed
     * @return {Boolean} True if the left mouse button or touchscreen is long-pressed
     */
    isLongPressed(): boolean;

    /**
     * Checks whether the right mouse button is just pressed.
     *
     * @static
     * @method isCancelled
     * @return {Boolean} True if the right mouse button is just pressed
     */
    isCancelled(): boolean;

    /**
     * Checks whether the mouse or a finger on the touchscreen is moved.
     *
     * @static
     * @method isMoved
     * @return {Boolean} True if the mouse or a finger on the touchscreen is moved
     */
    isMoved(): boolean;

    /**
     * Checks whether the left mouse button or touchscreen is released.
     *
     * @static
     * @method isReleased
     * @return {Boolean} True if the mouse button or touchscreen is released
     */
    isReleased(): boolean;

    /**
     * @static
     * @method _setupEventHandlers
     * @private
     */
    _setupEventHandlers(): void;

    /**
     * @static
     * @method _onMouseDown
     * @param {MouseEvent} event
     * @private
     */
    _onMouseDown(event: MouseEvent): void;

    /**
     * @static
     * @method _onLeftButtonDown
     * @param {MouseEvent} event
     * @private
     */
    _onLeftButtonDown(event: MouseEvent): void;

    /**
     * @static
     * @method _onMiddleButtonDown
     * @param {MouseEvent} event
     * @private
     */
    _onMiddleButtonDown(event: MouseEvent): void;

    /**
     * @static
     * @method _onRightButtonDown
     * @param {MouseEvent} event
     * @private
     */
    _onRightButtonDown(event: MouseEvent): void;

    /**
     * @static
     * @method _onMouseMove
     * @param {MouseEvent} event
     * @private
     */
    _onMouseMove(event: MouseEvent): void;

    /**
     * @static
     * @method _onMouseUp
     * @param {MouseEvent} event
     * @private
     */
    _onMouseUp(event: MouseEvent): void;

    /**
     * @static
     * @method _onWheel
     * @param {WheelEvent} event
     * @private
     */
    _onWheel(event: WheelEvent): void;

    /**
     * @static
     * @method _onTouchStart
     * @param {TouchEvent} event
     * @private
     */
    _onTouchStart(event: TouchEvent): void;

    /**
     * @static
     * @method _onTouchMove
     * @param {TouchEvent} event
     * @private
     */
    _onTouchMove(event: TouchEvent): void;

    /**
     * @static
     * @method _onTouchEnd
     * @param {TouchEvent} event
     * @private
     */
    _onTouchEnd(event: TouchEvent): void;

    /**
     * @static
     * @method _onTouchCancel
     * @param {TouchEvent} event
     * @private
     */
    _onTouchCancel(event: TouchEvent): void;

    /**
     * @static
     * @method _onPointerDown
     * @param {PointerEvent} event
     * @private
     */
    _onPointerDown(event: PointerEvent): void;

    /**
     * @static
     * @method _onTrigger
     * @param {Number} x
     * @param {Number} y
     * @private
     */
    _onTrigger(x: number, y: number): void;

    /**
     * @static
     * @method _onCancel
     * @param {Number} x
     * @param {Number} y
     * @private
     */
    _onCancel(x: number, y: number): void;

    /**
     * @static
     * @method _onMove
     * @param {Number} x
     * @param {Number} y
     * @private
     */
    _onMove(x: number, y: number): void;

    /**
     * @static
     * @method _onRelease
     * @param {Number} x
     * @param {Number} y
     * @private
     */
    _onRelease(x: number, y: number): void;
}
declare var TouchInput: TouchInputStatic;

/**
 * The static class that defines utility methods.
 *
 * @class Utils
 */
interface UtilsStatic {
    /**
     * The name of the RPG Maker. 'MV' in the current version.
     *
     * @static
     * @property RPGMAKER_NAME
     * @type String
     * @final
     */
    RPGMAKER_NAME: string;

    /**
     * The version of the RPG Maker.
     *
     * @static
     * @property RPGMAKER_VERSION
     * @type String
     * @final
     */
    RPGMAKER_VERSION: string;

    /**
     * Checks whether the option is in the query string.
     *
     * @static
     * @method isOptionValid
     * @param {String} name The option name
     * @return {Boolean} True if the option is in the query string
     */
    isOptionValid(name: string): boolean;

    /**
     * Checks whether the platform is NW.js.
     *
     * @static
     * @method isNwjs
     * @return {Boolean} True if the platform is NW.js
     */
    isNwjs(): boolean;

    /**
     * Checks whether the platform is a mobile device.
     *
     * @static
     * @method isMobileDevice
     * @return {Boolean} True if the platform is a mobile device
     */
    isMobileDevice(): boolean;

    /**
     * Checks whether the browser is Mobile Safari.
     *
     * @static
     * @method isMobileSafari
     * @return {Boolean} True if the browser is Mobile Safari
     */
    isMobileSafari(): boolean;

    /**
     * Checks whether the browser is Android Chrome.
     *
     * @static
     * @method isAndroidChrome
     * @return {Boolean} True if the browser is Android Chrome
     */
    isAndroidChrome(): boolean;

    /**
     * Checks whether the browser can read files in the game folder.
     *
     * @static
     * @method canReadGameFiles
     * @return {Boolean} True if the browser can read files in the game folder
     */
    canReadGameFiles(): boolean;

    /**
     * Makes a CSS color string from RGB values.
     *
     * @static
     * @method rgbToCssColor
     * @param {Number} r The red value in the range (0, 255)
     * @param {Number} g The green value in the range (0, 255)
     * @param {Number} b The blue value in the range (0, 255)
     * @return {String} CSS color string
     */
    rgbToCssColor(r: number, g: number, b: number): string;
}
declare var Utils: UtilsStatic;


declare class WebAudio {
    static _context: AudioContext;
    static _masterGainNode: GainNode;
    static _initialized: boolean;
    static _unlocked: boolean;

    /**
     * Initializes the audio system.
     *
     * @static
     * @method initialize
     * @param {Boolean} noAudio Flag for the no-audio mode
     * @return {Boolean} True if the audio system is available
     */
    static initialize(noAudio?: boolean): boolean;

    /**
     * Checks whether the browser can play ogg files.
     *
     * @static
     * @method canPlayOgg
     * @return {Boolean} True if the browser can play ogg files
     */
    static canPlayOgg(): boolean;

    /**
     * Checks whether the browser can play m4a files.
     *
     * @static
     * @method canPlayM4a
     * @return {Boolean} True if the browser can play m4a files
     */
    static canPlayM4a(): boolean;

    /**
     * @static
     * @method _createContext
     * @private
     */
    static _createContext(): void;

    /**
     * @static
     * @method _detectCodecs
     * @private
     */
    static _detectCodecs(): void;

    /**
     * @static
     * @method _createMasterGainNode
     * @private
     */
    static _createMasterGainNode(): void;

    /**
     * @static
     * @method _setupEventHandlers
     * @private
     */
    static _setupEventHandlers(): void;

    /**
     * @static
     * @method _onTouchStart
     * @private
     */
    static _onTouchStart(): void;

    /**
     * @static
     * @method _onVisibilityChange
     * @private
     */
    static _onVisibilityChange(): void;

    /**
     * @static
     * @method _onHide
     * @private
     */
    static _onHide(): void;

    /**
     * @static
     * @method _onShow
     * @private
     */
    static _onShow(): void;

    /**
     * @static
     * @method _shouldMuteOnHide
     * @private
     */
    static _shouldMuteOnHide(): void;

    /**
     * @static
     * @method _fadeIn
     * @param {Number} duration
     * @private
     */
    static _fadeIn(duration: number): void;

    /**
     * @static
     * @method _fadeOut
     * @param {Number} duration
     * @private
     */
    static _fadeOut(duration: number): void;

    /**
     * [read-only] The url of the audio file.
     *
     * @property url
     * @type String
     */
    url: string;

    /**
     * The volume of the audio.
     *
     * @property volume
     * @type Number
     */
    volume: number;

    /**
     * The pitch of the audio.
     *
     * @property pitch
     * @type Number
     */
    pitch: number;

    /**
     * The pan of the audio.
     *
     * @property pan
     * @type Number
     */
    pan: number;

    /**
     * The audio object of Web Audio API.
     *
     * @class WebAudio
     * @constructor
     * @param {String} url The url of the audio file
     */
    constructor(url: string);

    /**
     * Clears the audio data.
     *
     * @method clear
     */
    clear(): void;

    /**
     * Checks whether the audio data is ready to play.
     *
     * @method isReady
     * @return {Boolean} True if the audio data is ready to play
     */
    isReady(): boolean;

    /**
     * Checks whether a loading error has occurred.
     *
     * @method isError
     * @return {Boolean} True if a loading error has occurred
     */
    isError(): boolean;

    /**
     * Checks whether the audio is playing.
     *
     * @method isPlaying
     * @return {Boolean} True if the audio is playing
     */
    isPlaying(): boolean;

    /**
     * Plays the audio.
     *
     * @method play
     * @param {Boolean} loop Whether the audio data play in a loop
     * @param {Number} offset The start position to play in seconds
     */
    play(loop: boolean, offset: number): void;

    /**
     * Stops the audio.
     *
     * @method stop
     */
    stop(): void;

    /**
     * Performs the audio fade-in.
     *
     * @method fadeIn
     * @param {Number} duration Fade-in time in seconds
     */
    fadeIn(duration: number): void;

    /**
     * Performs the audio fade-out.
     *
     * @method fadeOut
     * @param {Number} duration Fade-out time in seconds
     */
    fadeOut(duration: number): void;

    /**
     * Gets the seek position of the audio.
     *
     * @method seek
     */
    seek(): void;

    /**
     * Add a callback function that will be called when the audio data is loaded.
     *
     * @method addLoadListener
     * @param {Function} listener The callback function
     */
    addLoadListener(listener: () => void): void;

    /**
     * Add a callback function that will be called when the playback is stopped.
     *
     * @method addStopListener
     * @param {Function} listener The callback function
     */
    addStopListener(listener: () => void): void;

    protected _buffer: AudioNode;
    protected _sourceNode: AudioBufferSourceNode;
    protected _gainNode: GainNode;
    protected _pannerNode: PannerNode;
    protected _totalTime: number;
    protected _sampleRate: number;
    protected _loopStart: number;
    protected _loopLength: number;
    protected _startTime: number;
    protected _volume: number;
    protected _pitch: number;
    protected _pan: number;
    protected _endTimer: number;
    protected _loadListeners: Array<() => void>;
    protected _stopListeners: Array<() => void>;
    protected _hasError: boolean;
    protected _autoPlay: boolean;

    /**
     * @method _load
     * @param {String} url
     * @private
     */
    protected _load(url: string): void;

    /**
     * @method _onXhrLoad
     * @param {XMLHttpRequest} xhr
     * @private
     */
    protected _onXhrLoad(xhr: XMLHttpRequest): void;

    /**
     * @method _startPlaying
     * @param {Boolean} loop
     * @param {Number} offset
     * @private
     */
    protected _startPlaying(loop: boolean, offset: number): void;

    /**
     * @method _createNodes
     * @private
     */
    protected _createNodes(): void;

    /**
     * @method _connectNodes
     * @private
     */
    protected _connectNodes(): void;

    /**
     * @method _removeNodes
     * @private
     */
    protected _removeNodes(): void;

    /**
     * @method _createEndTimer
     * @private
     */
    protected _createEndTimer(): void;

    /**
     * @method _removeEndTimer
     * @private
     */
    protected _removeEndTimer(): void;

    /**
     * @method _updatePanner
     * @private
     */
    protected _updatePanner(): void;

    /**
     * @method _onLoad
     * @private
     */
    protected _onLoad(): void;

    /**
     * @method _readLoopComments
     * @param {Uint8Array} array
     * @private
     */
    protected _readLoopComments(array: Uint8Array): void;

    /**
     * @method _readOgg
     * @param {Uint8Array} array
     * @private
     */
    protected _readOgg(array: Uint8Array): void;

    /**
     * @method _readMp4
     * @param {Uint8Array} array
     * @private
     */
    protected _readMp4(array: Uint8Array): void;

    /**
     * @method _readMetaData
     * @param {Uint8Array} array
     * @param {Number} index
     * @param {Number} size
     * @private
     */
    protected _readMetaData(array: Uint8Array, index: number, size: number): void;

    /**
     * @method _readLittleEndian
     * @param {Uint8Array} array
     * @param {Number} index
     * @private
     */
    protected _readLittleEndian(array: Uint8Array, index: number): void;

    /**
     * @method _readBigEndian
     * @param {Uint8Array} array
     * @param {Number} index
     * @private
     */
    protected _readBigEndian(array: Uint8Array, index: number): void;

    /**
     * @method _readFourCharacters
     * @param {Uint8Array} array
     * @param {Number} index
     * @private
     */
    protected _readFourCharacters(array: Uint8Array, index: number): void;
}

declare class Weather extends PIXI.Container {
    /**
     * The type of the weather in ['none', 'rain', 'storm', 'snow'].
     *
     * @property type
     * @type String
     */
    type: string;

    /**
     * The power of the weather in the range (0, 9).
     *
     * @property power
     * @type Number
     */
    power: number;

    /**
     * The origin point of the weather for scrolling.
     *
     * @property origin
     * @type Point
     */
    origin: Point;

    /**
     * The weather effect which displays rain, storm, or snow.
     *
     * @class Weather
     * @constructor
     */
    constructor();

    /**
     * Updates the weather for each frame.
     *
     * @method update
     */
    update(): void;

    protected _width: number;
    protected _height: number;
    protected _sprites: Array<Sprite>;
    protected _rainBitmap: Bitmap;
    protected _stormBitmap: Bitmap;
    protected _snowBitmap: Bitmap;
    protected _dimmerSprite: ScreenSprite;

    /**
     * @method _createBitmaps
     * @private
     */
    protected _createBitmaps(): void;

    /**
     * @method _createDimmer
     * @private
     */
    protected _createDimmer(): void;

    /**
     * @method _updateDimmer
     * @private
     */
    protected _updateDimmer(): void;

    /**
     * @method _updateAllSprites
     * @private
     */
    protected _updateAllSprites(): void;

    /**
     * @method _addSprite
     * @private
     */
    protected _addSprite(): void;

    /**
     * @method _removeSprite
     * @private
     */
    protected _removeSprite(): void;

    /**
     * @method _updateSprite
     * @param {Sprite} sprite
     * @private
     */
    protected _updateSprite(sprite: Sprite): void;

    /**
     * @method _updateRainSprite
     * @param {Sprite} sprite
     * @private
     */
    protected _updateRainSprite(sprite: Sprite): void;

    /**
     * @method _updateStormSprite
     * @param {Sprite} sprite
     * @private
     */
    protected _updateStormSprite(sprite: Sprite): void;

    /**
     * @method _updateSnowSprite
     * @param {Sprite} sprite
     * @private
     */
    protected _updateSnowSprite(sprite: Sprite): void;

    /**
     * @method _rebornSprite
     * @param {Sprite} sprite
     * @private
     */
    protected _rebornSprite(sprite: Sprite): void;
}

declare abstract class _Window extends PIXI.Container {
    /**
     * The origin point of the window for scrolling.
     *
     * @property origin
     * @type Point
     */
    origin: Point;

    /**
     * The active state for the window.
     *
     * @property active
     * @type Boolean
     */
    active: boolean;

    /**
     * The visibility of the down scroll arrow.
     *
     * @property downArrowVisible
     * @type Boolean
     */
    downArrowVisible: boolean;

    /**
     * The visibility of the up scroll arrow.
     *
     * @property upArrowVisible
     * @type Boolean
     */
    upArrowVisible: boolean;

    /**
     * The visibility of the pause sign.
     *
     * @property pause
     * @type Boolean
     */
    pause: boolean;

    /**
     * The image used as a window skin.
     *
     * @property windowskin
     * @type Bitmap
     */
    windowskin: Bitmap;

    /**
     * The bitmap used for the window contents.
     *
     * @property contents
     * @type Bitmap
     */
    contents: Bitmap;

    /**
     * The width of the window in pixels.
     *
     * @property width
     * @type Number
     */
    width: number;

    /**
     * The height of the window in pixels.
     *
     * @property height
     * @type Number
     */
    height: number;

    /**
     * The size of the padding between the frame and contents.
     *
     * @property padding
     * @type Number
     */
    padding: number;

    /**
     * The size of the margin for the window background.
     *
     * @property margin
     * @type Number
     */
    margin: number;

    /**
     * The opacity of the window without contents (0 to 255).
     *
     * @property opacity
     * @type Number
     */
    opacity: number;

    /**
     * The opacity of the window background (0 to 255).
     *
     * @property backOpacity
     * @type Number
     */
    backOpacity: number;

    /**
     * The opacity of the window contents (0 to 255).
     *
     * @property contentsOpacity
     * @type Number
     */
    contentsOpacity: number;

    /**
     * The openness of the window (0 to 255).
     *
     * @property openness
     * @type Number
     */
    openness: number;

    /**
     * The visibility of the sprite.
     *
     * @property visible
     * @type Boolean
     */
    visible: boolean;

    /**
     * The x coordinate of the sprite.
     *
     * @property x
     * @type Number
     */
    x: number;

    /**
     * The y coordinate of the sprite.
     *
     * @property y
     * @type Number
     */
    y: number;

    /**
     * [read-only] The array of children of the sprite.
     *
     * @property children
     * @type Array<PIXI.DisplayObject>
     */
    children: Array<PIXI.DisplayObject>;

    /**
     * [read-only] The object that contains the sprite.
     *
     * @property parent
     * @type PIXI.DisplayObjectContainer
     */
    parent: PIXI.Container;

    /**
     * The window in the game.
     *
     * @class Window
     * @constructor
     */
    constructor();

    /**
     * Updates the window for each frame.
     *
     * @method update
     */
    update(): void;

    /**
     * Sets the x, y, width, and height all at once.
     *
     * @method move
     * @param {Number} x The x coordinate of the window
     * @param {Number} y The y coordinate of the window
     * @param {Number} width The width of the window
     * @param {Number} height The height of the window
     */
    move(x?: number, y?: number, width?: number, height?: number): void;

    /**
     * Returns true if the window is completely open (openness == 255).
     *
     * @method isOpen
     * @return {Boolean}
     */
    isOpen(): boolean;

    /**
     * Returns true if the window is completely closed (openness == 0).
     *
     * @method isClosed
     * @return {Boolean}
     */
    isClosed(): boolean;

    /**
     * Sets the position of the command cursor.
     *
     * @method setCursorRect
     * @param {Number} x The x coordinate of the cursor
     * @param {Number} y The y coordinate of the cursor
     * @param {Number} width The width of the cursor
     * @param {Number} height The height of the cursor
     */
    setCursorRect(x?: number, y?: number, width?: number, height?: number): void;

    /**
     * Changes the color of the background.
     *
     * @method setTone
     * @param {Number} r The red value in the range (-255, 255)
     * @param {Number} g The green value in the range (-255, 255)
     * @param {Number} b The blue value in the range (-255, 255)
     */
    setTone(r: number, g: number, b: number): void;

    /**
     * Adds a child between the background and contents.
     *
     * @method addChildToBack
     * @param {PIXI.DisplayObject} child The child to add
     * @return {PIXI.DisplayObject} The child that was added
     */
    addChildToBack(child: PIXI.DisplayObject): PIXI.DisplayObject;

    /**
     * Adds a child to the container.
     *
     * @method addChild
     * @param {PIXI.DisplayObject} child The child to add
     * @return {PIXI.DisplayObject} The child that was added
     */
    addChild(child: PIXI.DisplayObject): PIXI.DisplayObject;

    /**
     * Adds a child to the container at a specified index.
     *
     * @method addChildAt
     * @param {PIXI.DisplayObject} child The child to add
     * @param {Number} index The index to place the child in
     * @return {PIXI.DisplayObject} The child that was added
     */
    addChildAt(child: PIXI.DisplayObject, index: number): PIXI.DisplayObject;

    /**
     * Removes a child from the container.
     *
     * @method removeChild
     * @param {PIXI.DisplayObject} child The child to remove
     * @return {PIXI.DisplayObject} The child that was removed
     */
    removeChild(child: PIXI.DisplayObject): PIXI.DisplayObject;

    /**
     * Removes a child from the specified index position.
     *
     * @method removeChildAt
     * @param {Number} index The index to get the child from
     * @return {PIXI.DisplayObject} The child that was removed
     */
    removeChildAt(index: number): PIXI.DisplayObject;

    /**
     * @method updateTransform
     * @private
     */
    updateTransform(): void;

    protected _isWindow: boolean;
    protected _windowskin: Bitmap;
    protected _width: number;
    protected _height: number;
    protected _cursorRect: Rectangle;
    protected _openness: number;
    protected _animationCount: number;
    protected _padding: number;
    protected _margin: number;
    protected _colorTone: Array<number>;
    protected _windowSpriteContainer: PIXI.Container;
    protected _windowBackSprite: Sprite;
    protected _windowCursorSprite: Sprite;
    protected _windowFrameSprite: Sprite;
    protected _windowContentsSprite: Sprite;
    protected _windowArrowSprites: Array<any>;
    protected _windowPauseSignSprite: Sprite;
    protected _downArrowSprite: Sprite;
    protected _upArrowSprite: Sprite;

    /**
     * @method _createAllParts
     * @private
     */
    protected _createAllParts(): void;

    /**
     * @method _onWindowskinLoad
     * @private
     */
    protected _onWindowskinLoad(): void;

    /**
     * @method _refreshAllParts
     * @private
     */
    protected _refreshAllParts(): void;

    /**
     * @method _refreshBack
     * @private
     */
    protected _refreshBack(): void;

    /**
     * @method _refreshFrame
     * @private
     */
    protected _refreshFrame(): void;

    /**
     * @method _refreshCursor
     * @private
     */
    protected _refreshCursor(): void;

    /**
     * @method _refreshContents
     * @private
     */
    protected _refreshContents(): void;

    /**
     * @method _refreshArrows
     * @private
     */
    protected _refreshArrows(): void;

    /**
     * @method _refreshPauseSign
     * @private
     */
    protected _refreshPauseSign(): void;

    /**
     * @method _updateCursor
     * @private
     */
    protected _updateCursor(): void;

    /**
     * @method _updateContents
     * @private
     */
    protected _updateContents(): void;

    /**
     * @method _updateArrows
     * @private
     */
    protected _updateArrows(): void;

    /**
     * @method _updatePauseSign
     * @private
     */
    protected _updatePauseSign(): void;
}


declare class WindowLayer extends PIXI.Container {
    /**
     * The width of the window layer in pixels.
     *
     * @property width
     * @type Number
     */
    width: number;

    /**
     * The height of the window layer in pixels.
     *
     * @property height
     * @type Number
     */
    height: number;

    /**
     * The x coordinate of the sprite.
     *
     * @property x
     * @type Number
     */
    x: number;

    /**
     * The y coordinate of the sprite.
     *
     * @property y
     * @type Number
     */
    y: number;

    /**
     * [read-only] The array of children of the sprite.
     *
     * @property children
     * @type Array<PIXI.DisplayObject>
     */
    children: Array<PIXI.DisplayObject>;

    /**
     * [read-only] The object that contains the sprite.
     *
     * @property parent
     * @type PIXI.DisplayObjectContainer
     */
    parent: PIXI.Container;

    voidFilter: PIXI.Filter;

    /**
     * The layer which contains game windows.
     *
     * @class WindowLayer
     * @constructor
     */
    constructor();

    /**
     * Sets the x, y, width, and height all at once.
     *
     * @method move
     * @param {Number} x The x coordinate of the window layer
     * @param {Number} y The y coordinate of the window layer
     * @param {Number} width The width of the window layer
     * @param {Number} height The height of the window layer
     */
    move(x: number, y: number, width: number, height: number): void;

    /**
     * Updates the window layer for each frame.
     *
     * @method update
     */
    update(): void;

    /**
     * Adds a child to the container.
     *
     * @method addChild
     * @param {PIXI.DisplayObject} child The child to add
     * @return {PIXI.DisplayObject} The child that was added
     */
    addChild(child: PIXI.DisplayObject): PIXI.DisplayObject;

    /**
     * Adds a child to the container at a specified index.
     *
     * @method addChildAt
     * @param {PIXI.DisplayObject} child The child to add
     * @param {Number} index The index to place the child in
     * @return {PIXI.DisplayObject} The child that was added
     */
    addChildAt(child: PIXI.DisplayObject, index: number): PIXI.DisplayObject;

    /**
     * Removes a child from the container.
     *
     * @method removeChild
     * @param {PIXI.DisplayObject} child The child to remove
     * @return {PIXI.DisplayObject} The child that was removed
     */
    removeChild(child: PIXI.DisplayObject): PIXI.DisplayObject;

    /**
     * Removes a child from the specified index position.
     *
     * @method removeChildAt
     * @param {Number} index The index to get the child from
     * @return {PIXI.DisplayObject} The child that was removed
     */
    removeChildAt(index: number): PIXI.DisplayObject;

    /**
     * @method _renderCanvas
     * @param {PIXI.CanvasRenderer} renderer
     * @private
     */
    renderCanvas(renderer: PIXI.CanvasRenderer);

    /**
     * @method _renderWebGL
     * @param {PIXI.WebGLRenderer} renderer
     * @private
     */
    renderWebGL(renderer: PIXI.WebGLRenderer): void;

    protected _width: number;
    protected _height: number;
    protected _tempCanvas: HTMLCanvasElement;
    protected _translationMatrix: Array<number>;
    protected _windowMask: PIXI.Graphics;
    protected _renderSprite: PIXI.Container;

    /**
     * @method _canvasClearWindowRect
     * @param {PIXI.CanvasRenderer} renderSession
     * @param {Window} window
     * @private
     */
    protected _canvasClearWindowRect(renderSession: PIXI.CanvasRenderer, window: Window): void;

    /**
     * @method _maskWindow
     * @param {Window} window
     * @private
     */
    protected _maskWindow(window: _Window): void;
}

declare class CacheEntry {
    /**
     * The resource class. Allows to be collected as a garbage if not use for some time or ticks
     *
     * @class CacheEntry
     * @constructor
     * @param {ResourceManager} resource manager
     * @param {string} key, url of the resource
     * @param {string} item - Bitmap, HTML5Audio, WebAudio - whatever you want to store in the cache
     */
    constructor(cache: CacheMap, key: string, item: string)

    /**
     * frees the resource
     */
    free(byTTL?: boolean): void;

    /**
     * Allocates the resource
     * @returns {CacheEntry}
     */
    allocate(): CacheEntry;

    /**
     * Sets the time to live
     * @param {number} ticks TTL in ticks, 0 if not set
     * @param {number} time TTL in seconds, 0 if not set
     * @returns {CacheEntry}
     */
    setTimeToLive(ticks?: number, seconds?: number): CacheEntry;

    isStillAlive(): boolean;

    /**
     * makes sure that resource wont freed by Time To Live
     * if resource was already freed by TTL, put it in cache again
     */
    touch(): void;
}

declare class CacheMap {
    /**
     * Cache for images, audio, or any other kind of resource
     * @param manager
     * @constructor
     */
    constructor(manager: ImageManagerStatic);

    /**
     * checks ttl of all elements and removes dead ones
     */
    checkTTL(): void;

    /**
     * cache item
     * @param key url of cache element
     * @returns {*|null}
     */
    getItem(key: string): any;

    clear(): void;
    setItem(key, item): CacheEntry;
    update(ticks: number, delta: number): void;
}


interface DecrypterStatic {
    hasEncryptedImages: boolean;
    hasEncryptedAudio: boolean;

    _requestImgFile: Array<string>;
    _headerlength: number;
    _xhrOk: number;
    _encryptionKey: string;
    _ignoreList: Array<string>;

    SIGNATURE: string;
    VER: string;
    REMAIN: string;

    checkImgIgnore(url: string): boolean;
    decryptImg(url: string, bitmap: Bitmap): void;
    decryptHTML5Audio(url: string, bgm: MV.AudioParameters, pos?: number): void;
    cutArrayHeader(arrayBuffer: ArrayBuffer, length: number): ArrayBuffer;
    decryptArrayBuffer(arrayBuffer: ArrayBuffer): void;
    createBlobUrl(arrayBuffer: ArrayBuffer): string;
    extToEncryptExt(url: string): string;
    readEncryptionkey(): void;
}
declare var Decrypter: DecrypterStatic; declare namespace RPG {
    export interface MetaData {
        /**
         * The text of the note.
         */
        note: string;

        /**
         * The Meta.
         */
        meta: { [key: string]: any };
    }

    /**
     * The data class for maps.
     */
    export interface Map extends MetaData {
        /**
         * The map's display name.
         */
        displayName: string;

        /**
         * The map's tile set.
         */
        tilesetId: number;

        /**
         * The map's width.
         */
        width: number;

        /**
         * The map's height.
         */
        height: number;

        /**
         * The scroll type (0: No Loop, 1: Vertical Loop, 2: Horizontal Loop, 3: Both Loop).
         */
        scrollType: number;

        /**
         * The truth value indicating whether the battle background specification is enabled.
         */
        specifyBattleback: boolean;

        /**
         * The file name of the floor graphic if the battle background specification is enabled.
         */
        battleback1Name: string;

        /**
         * The file name of the wall graphic if the battle background specification is enabled.
         */
        battleback2_name: string;

        /**
         * The truth value indicating whether BGM autoswitching is enabled.
         */
        autoplayBgm: boolean;

        /**
         * The name of that BGM (RPG.AudioFile) if BGM autoswitching is enabled.
         */
        bgm: AudioFile;

        /**
         * The truth value indicating whether BGS autoswitching is enabled.
         */
        autoplayBgs: boolean;

        /**
         * The name of that BGS (RPG.AudioFile) if BGS autoswitching is enabled.
         */
        bgs: AudioFile;

        /**
         * The truth value of the [Disable Dashing] option.
         */
        disableDashing: boolean;

        /**
         * An encounter list. A RPG.Map.Encounter ID array.
         */
        encounterList: Array<Map.Encounter>;

        /**
         * The average number of steps between encounters.
         */
        encounterStep: number;

        /**
         * The file name of the parallax background's graphic.
         */
        parallaxName: string;

        /**
         * The truth value of the [Loop Horizontal] option for the parallax background.
         */
        parallaxLoopX: boolean;

        /**
         * The truth value of the [Loop Vertical] option for the parallax background.
         */
        parallaxLoopY: boolean;

        /**
         * The automatic x-axis scrolling speed for the parallax background.
         */
        parallaxSx: number;

        /**
         * The automatic y-axis scrolling speed for the parallax background.
         */
        parallaxSy: number;

        /**
         * The truth value of the [Show in the Editor] option for the parallax background.
         */
        parallaxShow: boolean;

        /**
         * The map data. A 3-dimensional tile ID array (Table).
         */
        data: Array<number>;

        /**
         * The array of RPG.Event data.
         */
        events: Array<Event>;
    }

    namespace Map {
        /**
         * The data class for the encounter settings.
         */
        export interface Encounter {
            /**
             * The enemy troop ID.
             */
            troopId: number;

            /**
             * Weight.
             */
            weight: number;

            /**
             * An array containing region IDs.
             */
            regionSet: Array<number>;
        }
    }

    /**
     * The data class for map information.
     */
    export interface MapInfo {
        /**
         * The map name.
         */
        name: string;

        /**
         * The parent map ID.
         */
        parentId: number;

        /**
         * The map tree display order, which is used internally.
         */
        order: number;
    }

    /**
     * The data class for map events.
     */
    export interface Event extends MetaData {
        /**
         * The event ID.
         */
        id: number;

        /**
         * The event name.
         */
        name: string;

        /**
         * The event's x-coordinate on the map.
         */
        x: number;

        /**
         * The event's y-coordinate on the map.
         */
        y: number;

        /**
         * The event pages. RPG.EventPage array.
         */
        pages: Array<EventPage>;
    }

    /**
     * The data class for the event page.
     */
    export interface EventPage {
        /**
         * The event condition (RPG.EventPage.Condition).
         */
        conditions: EventPage.Conditions;

        /**
         * The event graphic (RPG.EventPage.Image) .
         */
        image: EventPage.Image;

        /**
         * The type of movement (0: fixed, 1: random, 2: approach, 3: custom).
         */
        moveType: number;

        /**
         * The movement speed (1: x8 slower, 2: x4 slower, 3: x2 slower, 4: normal, 5: x2 faster, 6: x4 faster).
         */
        moveSpeed: number;

        /**
         * The movement frequency (1: lowest, 2: lower, 3: normal, 4: higher, 5: highest).
         */
        moveFrequency: number;

        /**
         * The movement route (RPG.MoveRoute). Referenced only when the movement type is set to custom.
         */
        moveRoute: Array<MoveRoute>;

        /**
         * The truth value of the [Walking Animation] option.
         */
        walkAnime: boolean;

        /**
         * The truth value of the [Stepping Animation] option.
         */
        stepAnime: boolean;

        /**
         * The truth value of the [Direction Fix] option.
         */
        directionFix: boolean;

        /**
         * The truth value of the [Through] option.
         */
        through: boolean;

        /**
         * The priority type (0: below characters, 1: same as characters, 2: above characters).
         */
        priorityType: number;

        /**
         * The event trigger (0: action button, 1: player touch, 2: event touch, 3: autorun, 4: parallel).
         */
        trigger: number;

        /**
         * A list of event commands. An RPG.EventCommand array.
         */
        list: Array<EventCommand>;
    }

    namespace EventPage {
        /**
         * The data class for the event page conditions.
         */
        export interface Conditions {
            /**
             * The truth value indicating whether the first [Switch] condition is valid.
             */
            switch1Valid: boolean;

            /**
             * The truth value indicating whether the second [Switch] condition is valid.
             */
            switch2Valid: boolean;

            /**
             * The truth value indicating whether the [Variable] condition is valid.
             */
            variableValid: boolean;

            /**
             * The truth value indicating whether the [Self Switch] condition is valid.
             */
            selfSwitchValid: boolean;

            /**
             * The truth value indicating whether the [Item] condition is valid.
             */
            itemValid: boolean;

            /**
             * The truth value indicating whether the [Actor] condition is valid.
             */
            actorValid: boolean;

            /**
             * The ID of that switch if the first [Switch] condition is valid.
             */
            switch1Id: number;

            /**
             * The ID of that switch if the second [Switch] condition is valid.
             */
            switch2Id: number;

            /**
             * The ID of that variable if the [Variable] condition is valid.
             */
            variableId: number;

            /**
             * The standard value of that variable (x and greater) if the [Variable] condition is valid.
             */
            variableValue: number;

            /**
             * The letter of that self switch ("A".."D") if the [Self Switch] condition is valid.
             */
            selfSwitchCh: string;

            /**
             * The ID of that item if the [Item] condition is valid.
             */
            itemId: number;

            /**
             * The ID of that actor if the [Actor] condition is valid.
             */
            actorId: number;
        }

        /**
         * The data class for the Event page [Graphics].
         */
        export interface Image {
            /**
             * The tile ID. If the specified graphic is not a tile, this value is 0.
             */
            tileId: number;

            /**
             * The file name of the character's graphic.
             */
            characterName: string;

            /**
             * The index of the character's graphic file (0..7).
             */
            characterIndex: number;

            /**
             * The direction in which the character is facing (2: down, 4: left, 6: right, 8: up).
             */
            direction: number;

            /**
             * The character's pattern (0..2).
             */
            pattern: number;
        }
    }

    /**
     * The data class for the event page.
     */
    export interface BattleEventPage {
        /**
         * The event condition (RPG.EventPage.Condition).
         */
        conditions: BattleEventPage.Conditions;

        /**
         * A list of event commands. An RPG.EventCommand array.
         */
        list: Array<EventCommand>;

        /**
         * The span.
         */
        span: number;
    }

    namespace BattleEventPage {
        /**
         * The data class for the event page conditions.
         */
        export interface Conditions {
            /**
             * The percentage of actor HP.
             */
            actorHp: number;

            /**
             * The ID of that actor if the [Actor] condition is valid.
             */
            actorId: number;

            /**
             * The truth value indicating whether the [Actor] condition is valid.
             */
            actorValid: boolean;

            /**
             * The percentage of enemy HP.
             */
            enemyHp: number;

            /**
             * The enemy index.
             */
            enemyIndex: number;

            /**
             * The truth value indicating whether the [Enemy] condition is valid.
             */
            enemyValid: boolean;

            /**
             * The ID of that switch if the [Switch] condition is valid.
             */
            switchId: number;

            /**
             * The truth value indicating whether the [Switch] condition is valid.
             */
            switchValid: boolean;

            /**
             * The turn condition value A.
             */
            turnA: number;

            /**
             * The turn condition value B.
             */
            turnB: number;

            /**
             * The boolean value indicating whether the "turn end" is valid.
             */
            turnEnding: boolean;

            /**
             * The boolean value indicating whether the "turn" is valid.
             */
            turnValid: boolean;
        }
    }

    /**
     * The data class for the Event command.
     */
    export interface EventCommand {
        /**
         * The event code.
         */
        code: number;

        /**
         * The indent depth. Usually 0. The [Conditional Branch] command, among others, adds 1 with every step deeper.
         */
        indent: number;

        /**
         * An array containing the Event command's arguments. The contents vary for each command.
         */
        parameters: Array<any>;
    }

    /**
     * The data class for the Move route.
     */
    export interface MoveRoute {
        /**
         * The truth value of the [Repeat Action] option.
         */
        repeat: boolean;

        /**
         * The truth value of the [Skip If Cannot Move] option.
         */
        skippable: boolean;

        /**
         * The truth value of the [Wait for Completion] option.
         */
        wait: boolean;

        /**
         * Program contents. An RPG.MoveCommand array.
         */
        list: Array<MoveCommand>;
    }

    /**
     * The data class for the Move command.
     */
    export interface MoveCommand {
        /**
         * Move command code.
         */
        code: number;

        /**
         * An array containing the Move command's arguments. The contents vary for each command.
         */
        parameters: Array<any>;
    }

    /**
     * The data class for actors.
     */
    export interface Actor extends MetaData {
        /**
         * The ID.
         */
        id: number;

        /**
         * The name.
         */
        name: string;

        /**
         * The actor's nickname.
         */
        nickname: string;

        /**
         * The actor's class ID.
         */
        classId: number;

        /**
         * The actor's initial level.
         */
        initialLevel: number;

        /**
         * The actor's max level
         */
        maxLevel: number;

        /**
         * The file name of the actor's walking graphic.
         */
        characterName: string;

        /**
         * The index (0..7) of the actor's walking graphic.
         */
        characterIndex: number;

        /**
         * The file name of the actor's face graphic.
         */
        faceName: string;

        /**
         * The index (0..7) of the actor's face graphic.
         */
        faceIndex: number;

        /**
         * The file name of the actor's battler graphic.
         */
        battlerName: string;

        /**
         * The actor's initial equipment. An array of weapon IDs or armor IDs with the following subscripts:
         */
        equips: Array<number>;

        /**
         * The profile.
         */
        profile: string;

        /**
         * The array of Trait data.
         */
        traits: Array<Trait>;
    }

    /**
     * The data class for class.
     */
    export interface Class extends MetaData {
        /**
         * The ID.
         */
        id: number;

        /**
         * The name.
         */
        name: string;

        /**
         * An array of values that decides the experience curve. The subscripts are as follows:
         *
         * 0: Base value
         * 1: Extra value
         * 2: Acceleration A
         * 3: Acceleration B
         */
        expParams: Array<number>;

        /**
         * The parameter development curve. A 2-dimensional array containing ordinary parameters according to level (Table).
         *
         * The format is params[param_id, level], and param_id is assigned as follows:
         *
         * 0: Maximum hit points
         * 1: Maximum magic points
         * 2: Attack power
         * 3: Defense power
         * 4: Magic attack power
         * 5: Magic defense power
         * 6: Agility
         * 7: Luck
         */
        params: Array<Array<number>>;

        /**
         * The skills to learn. An array of RPG.Class.Learning.
         */
        learnings: Array<Class.Learning>;

        /**
         * The array of Trait data.
         */
        traits: Array<Trait>;
    }

    namespace Class {
        /**
         * The data class for a class's [Skills to Learn].
         */
        export interface Learning extends MetaData {
            /**
             * The data class for a class's [Skills to Learn].
             */
            level: number;

            /**
             * The ID of the skill to learn.
             */
            skillId: number;
        }
    }

    /**
     * A superclass of actor, class, skill, item, weapon, armor, enemy, and state.
     *
     * Some items are unnecessary depending on the type of data, but they are included for convenience sake.
     */
    export interface BaseItem extends MetaData {
        /**
         * The item ID.
         */
        id: number;

        /**
         * The item name.
         */
        name: string;

        /**
         * The icon number.
         */
        iconIndex: number;

        /**
         * The description text.
         */
        description: string;
    }
    /**
     * The Superclass of Skill and Item.
     */

    export interface UsableItem extends BaseItem {
        /**
         * The scope of effects.
         *
         * 0: None
         * 1: One Enemy
         * 2: All Enemies
         * 3: One Random Enemy
         * 4: Two Random Enemies
         * 5: Three Random Enemies
         * 6: Four Random Enemies
         * 7: One Ally
         * 8: All Allies
         * 9: One Ally (Dead)
         * 10: All Allies (Dead)
         * 11: The User
         */
        scope: number;

        /**
         * When the item/skill may be used.
         *
         * 0: Always
         * 1: Only in battle
         * 2: Only from the menu
         * 3: Never
         */
        occasion: number;

        /**
         * The speed correction.
         */
        speed: number;

        /**
         * The success rate.
         */
        successRate: number;

        /**
         * The number of repeats.
         */
        repeats: number;

        /**
         * The number of TP gained.
         */
        tpGain: number;

        /**
         * The type of hit.
         *
         * 0: Certain hit
         * 1: Physical attack
         * 2: Magical attack
         */
        hitType: number;

        /**
         * The animation ID.
         */
        animationId: number;

        /**
         * Damage (RPG.Damage).
         */
        damage: Damage;

        /**
         * A list of use effects. An RPG.Effect array.
         */
        effects: Array<Effect>;
    }
    /**
     * The data class for skills.
     */

    export interface Skill extends UsableItem {
        /**
         * Skill type ID.
         */
        stypeId: number;

        /**
         * Number of MP consumed.
         */
        mpCost: number;

        /**
         * Number of TP consumed
         */
        tpCost: number;

        /**
         * The use message.
         */
        message1: string;

        /**
         * The use message.
         */
        message2: string;

        /**
         * Weapon type required.
         */
        requiredWtypeId1: number;

        /**
         * Weapon type required.
         */
        requiredWtypeId2: number;
    }
    /**
     * The data class for items.
     */
    export interface Item extends UsableItem {
        /**
         * The item type ID.
         *
         * 1: Regular item
         * 2: Key item
         */
        itypeId: number;

        /**
         * The item's price.
         */
        price: number;

        /**
         * The truth value indicating whether the item disappears when used.
         */
        consumable: boolean;
    }

    /**
     * A superclass of weapons and armor.
     */
    export interface EquipItem extends BaseItem {
        /**
         * The price of the weapon or armor.
         */
        price: number;

        /**
         * The type of weapon or armor.
         *
         * 0: Weapon
         * 1: Shield
         * 2: Head
         * 3: Body
         * 4: Accessory
         */
        etypeId: number;

        /**
         * The amount of parameter change. An array of integers using the following IDs as subscripts:
         *
         * 0: Maximum hit points
         * 1: Maximum magic points
         * 2: Attack power
         * 3: Defense power
         * 4: Magic attack power
         * 5: Magic defense power
         * 6: Agility
         * 7: Luck
         */
        params: Array<number>;

        /**
         * The array of Trait data.
         */
        traits: Array<Trait>;
    }

    /**
     * The data class for weapons.
     */
    export interface Weapon extends EquipItem {
        /**
         * The weapon type ID.
         */
        wtypeId: number;

        /**
         * The animation ID when using the weapon.
         */
        animationId: number;
    }

    /**
     * The data class for armor.
     */
    export interface Armor extends EquipItem {
        /**
         * The armor type ID.
         */
        atypeId: number;
    }

    /**
     * The data class for enemies.
     */
    export interface Enemy extends MetaData {
        /**
         * The file name of the enemy's battler graphic.
         */
        battlerName: string;

        /**
         * The adjustment value for the battler graphic's hue (0..360).
         */
        battlerHue: number;

        /**
         * The name of the enemy in the database.
         * 
         * @type {string}
         * @memberof Enemy
         */
        name: string

        /**
         * The ID of the enemy in the database.
         * 
         * @type {number}
         * @memberof Enemy
         */
        id: number

        /**
         * Parameters. An array of integers using the following IDs as subscripts:
         *
         * 0: Maximum hit points
         * 1: Maximum magic points
         * 2: Attack power
         * 3: Defense power
         * 4: Magic attack power
         * 5: Magic defense power
         * 6: Agility
         * 7: Luck
         */
        params: Array<number>;

        /**
         * The enemy's experience.
         */
        exp: number;

        /**
         * The enemy's gold.
         */
        gold: number;

        /**
         * The items the enemy drops. An RPG.Enemy.DropItem array.
         */
        dropItems: Array<Enemy.DropItem>;

        /**
         * The enemy's action pattern. An array of RPG.Enemy.Action.
         */
        actions: Array<Enemy.Action>;
    }

    namespace Enemy {
        /**
         * The data class for enemy [Drop Items].
         */
        export interface DropItem {
            /**
             * The type of dropped item.
             *
             * 0: None
             * 1: Item
             * 2: Weapon
             * 3: Armor
             */
            kind: number;

            /**
             * The ID of the data depending on the type of dropped item (item, weapon, or armor).
             */
            dataId: number;

            /**
             * N of the probability that the item will be dropped, 1/N.
             */
            denominator: number;
        }

        /**
         * The data class for enemy [Actions].
         */
        export interface Action {
            /**
             * The ID of skills to be employed as actions.
             */
            skillId: number;

            /**
             * The type of condition.
             *
             * 0: Always
             * 1: Turn No.
             * 2: HP
             * 3: MP
             * 4: State
             * 5: Party Level
             * 6: Switch
             */
            conditionType: number;

            /**
             * The first parameter of the condition.
             */
            conditionParam1: number;

            /**
             * The second parameter of the condition.
             */
            conditionParam2: number;

            /**
             * The action's priority rating (1..10).
             */
            rating: number;
        }
    }

    /**
     * The data class for state.
     */
    export interface State extends MetaData {
        /**
         * The ID.
         */
        id: number;

        /**
         * The name.
         */
        name: string;

        /**
         * Action restrictions.
         *
         * 0: None
         * 1: Attack enemy
         * 2: Attack enemy or ally
         * 3: Attack ally
         * 4: Cannot act
         */
        restriction: number;

        /**
         * The state priority (0..100).
         */
        priority: number;

        /**
         * Removes state at end of battle (true/false).
         */
        removeAtBattleEnd: boolean;

        /**
         * Removes state by action restriction (true/false).
         */
        removeByRestriction: boolean;

        /**
         * The timing of automatic state removal.
         *
         * 0: None
         * 1: At end of action
         * 2: At end of turn
         */
        autoRemovalTiming: number;

        /**
         * The minimum turns of the duration.
         */
        minTurns: number;

        /**
         * The maximum turns of the duration.
         */
        maxTurns: number;

        /**
         * Removes state by damage (true/false).
         */
        removeByDamage: boolean;

        /**
         * Chance of state being removed by damage (%).
         */
        chanceByDamage: number;

        /**
         * Removes state by walking (true/false).
         */
        removeByWalking: boolean;

        /**
         * Number of steps until state is removed.
         */
        stepToRemove: number;

        /**
         * The icon number.
         */
        iconIndex: number;

        /**
         * The message when an actor fell in the state.
         */
        message1: string;

        /**
         * The message when an enemy fell in the state.
         */
        message2: string;

        /**
         * The message when the state remains.
         */
        message3: string;

        /**
         * The message when the state is removed.
         */
        message4: string;

        /**
         * The side-view motion.
         */
        motion: number;

        /**
         * The side-view overlay.
         */
        overlay: number;

        /**
         * The array of Trait data.
         */
        traits: Array<Trait>;
        releaseByDamage?: boolean;
        description?: string;
    }

    export interface Trait {
        /**
         * The trait code.
         */
        code: number;

        /**
         * The ID of the data (such as elements or states) according to the type of the trait.
         */
        dataId: number;

        /**
         * The value set according to the type of the trait.
         */
        value: number;

        /**
         * The map tree expansion flag, which is used internally.
         */
        expanded: boolean;

        /**
         * The x-axis scroll position, which is used internally.
         */
        scrollX: number;

        /**
         * The y-axis scroll position, which is used internally.
         */
        scrollY: number;
    }

    /**
     * The data class for damage.
     */
    export interface Damage {
        /**
         * The type of damage.
         *
         * 0: None
         * 1: HP damage
         * 2: MP damage
         * 3: HP recovery
         * 4: MP recovery
         * 5: HP drain
         * 6: MP drain
         */
        type: number;

        /**
         * The element ID.
         */
        elementId: number;

        /**
         * The formula.
         */
        formula: string;

        /**
         * The degree of variability.
         */
        variance: number;

        /**
         * Critical hit (true/false).
         */
        critical: boolean;
    }

    /**
     * The data class for use effects.
     */
    export interface Effect {
        /**
         * The use effect code.
         */
        code: number;

        /**
         * The ID of data (state, parameter, and so on) according to the type of use effect.
         */
        dataId: number;

        /**
         * Value 1 set according to the type of use effect.
         */
        value1: number;

        /**
         * Value 2 set according to the type of use effect.
         */
        value2: number;
    }

    /**
     * The data class for enemy troops.
     */
    export interface Troop {
        /**
         * The troop ID.
         */
        id: number;

        /**
         * The troop name.
         */
        name: string;

        /**
         * The troop members. An RPG.Troop.Member array.
         */
        members: Array<RPG.Troop.Member>;

        /**
         * The battle events. An RPG.Troop.Page array.
         */
        pages: Array<RPG.Troop.Page>;
    }

    namespace Troop {
        /**
         * The data class for enemy troop members.
         */
        export interface Member {
            /**
             * The enemy ID.
             */
            enemyId: number;

            /**
             * The troop member's x-coordinate.
             */
            x: number;

            /**
             * The troop member's y-coordinate.
             */
            y: number;

            /**
             * The truth value of the [Appear Halfway] option.
             */
            hidden: boolean;
        }

        /**
         * The data class for battle events (pages).
         */
        export interface Page {
            /**
             * Condition (RPG.Troop.Page.Condition).
             */
            condition: Page.Condition;

            /**
             * Span (0: battle, 1: turn, 2: moment).
             */
            span: number;

            /**
             * Program contents. An RPG.EventCommand array.
             */
            list: Array<EventCommand>;
        }

        namespace Page {
            /**
             * The data class of battle event [Conditions].
             */
            export interface Condition {
                /**
                 * The truth value indicating whether the [At End of Turn] condition is valid.
                 */
                turnEnding: boolean;

                /**
                 * The truth value indicating whether the [Turn No.] condition is valid.
                 */
                turnValid: boolean;

                /**
                 * The truth value indicating whether the [Enemy] condition is valid.
                 */
                enemyValid: boolean;

                /**
                 * The truth value indicating whether the [Actor] condition is valid.
                 */
                actorValid: boolean;

                /**
                 * The truth value indicating whether the [Switch] condition is valid.
                 */
                switchValid: boolean;

                /**
                 * The a and b values specified in the [Turn No.] condition. To be input in the form A + B * X.
                 */
                turnA: number;

                /**
                 * The a and b values specified in the [Turn No.] condition. To be input in the form A + B * X.
                 */
                turnB: number;

                /**
                 * The troop member index specified in the [Enemy] condition (0..7).
                 */
                enemyIndex: number;

                /**
                 * The HP percentage specified in the [Enemy] condition.
                 */
                enemyHp: number;

                /**
                 * The actor ID specified in the [Actor] condition.
                 */
                actorId: number;

                /**
                 * The HP percentage specified in the [Actor] condition.
                 */
                actorHp: number;

                /**
                 * The switch ID specified in the [Switch] condition.
                 */
                switchId: number;
            }
        }
    }

    /**
     * The data class for animation.
     */
    export interface Animation {
        /**
         * The animation ID.
         */
        id: number;

        /**
         * The animation name.
         */
        name: string;

        /**
         * The file name of the first animation's graphic.
         */
        animation1Name: string;

        /**
         * The adjustment value for the hue of the first animation's graphic (0..360).
         */
        animation1Hue: number;

        /**
         * The file name of the second animation's graphic.
         */
        animation2Name: string;

        /**
         * The adjustment value for the hue of the second animation's graphic (0..360).
         */
        animation2Hue: number;

        /**
         * The base position (0: head, 1: center, 2: feet, 3: screen).
         */
        position: number;

        /**
         * Number of frames.
         */
        frameMax: number;

        /**
         * The three-dimensional array containing the frame contents.
         */
        frames: Array<Array<Array<number>>>;

        /**
         * Timing for SE and flash effects. An RPG.Animation.Timing array.
         */
        timings: Array<Animation.Timing>;
    }

    namespace Animation {
        /**
         * The data class for the timing of an animation's SE and flash effects.
         */
        export interface Timing {
            /**
             * The frame number. 1 less than the number displayed in RPG Maker.
             */
            frame: number;

            /**
             * The sound effect or SE (RPG.AudioFile).
             */
            se: AudioFile;

            /**
             * The flash area (0: none, 1: target, 2: screen; 3: hide target).
             */
            flashScope: number;

            /**
             * The color of the flash (Color).
             */
            flashColor: Array<number>;

            /**
             * The duration of the flash.
             */
            flashDuration: number;
        }
    }

    /**
     * The data class for tile sets.
     */
    export interface Tileset extends MetaData {
        /**
         * The ID of the tile set.
         */
        id: number;

        /**
         * The name of the tile set.
         */
        name: string;

        /**
         * The mode of the tile set (0: Field type, 1: Area type, 2: VX compatible type).
         */
        mode: number;

        /**
         * The file name of the graphic used as the number index (0-8) tile set.
         *
         * The correspondence between numbers and sets is illustrated in the table below.
         *
         * 0 TileA1
         * 1 TileA2
         * 2 TileA3
         * 3 TileA4
         * 4 TileA5
         * 5 TileB
         * 6 TileC
         * 7 TileD
         * 8 TileE
         */
        tilesetNames: Array<string>;

        /**
         * The flags table. A 1-dimensional array containing a variety of flags (Table).
         *
         * Uses tile IDs as subscripts. The correspondence of each bit is as shown below:
         *
         * 0x0001: Impassable downward
         * 0x0002: Impassable leftward
         * 0x0004: Impassable rightward
         * 0x0008: Impassable upward
         * 0x0010: Display on normal character
         * 0x0020: Ladder
         * 0x0040: Bush
         * 0x0080: Counter
         * 0x0100: Damage floor
         * 0x0200: Impassable by boat
         * 0x0400: Impassable by ship
         * 0x0800: Airship cannot land
         * 0xF000: Terrain tag
         * This manual does not discuss bit operations, but they are similar to those in C.
         * We recommend an Internet search using keywords such as "hexadecimal bit operations" when necessary.
         */
        flags: Array<number>;
    }

    /**
     * The data class for common events.
     */
    export interface CommonEvent {
        /**
         * The event ID.
         */
        id: number;

        /**
         * The event name.
         */
        name: string;

        /**
         * The event trigger (0: none, 1: autorun; 2: parallel).
         */
        trigger: number;

        /**
         * The condition switch ID.
         */
        switchId: number;

        /**
         * A list of event commands. An RPG.EventCommand array.
         */
        list: Array<EventCommand>;
    }

    export interface System {
        /**
         * The game title.
         */
        gameTitle: string;

        /**
         * A random number used for update checks. The number changes every time data is saved in RPG Maker.
         */
        versionId: number;

        /**
         * The locale string such as "ja_JP" and "en_US".
         */
        locale: string;

        /**
         * The initial party. An array of actor IDs.
         */
        partyMembers: Array<number>;

        /**
         * The unit of currency.
         */
        currencyUnit: string;

        /**
         * The window color.
         */
        windowTone: Array<number>;

        /**
         * The array of System.AttackMotion data.
         */
        attackMotions: Array<System.AttackMotion>;

        /**
         * A list of elements. A string array using element IDs as subscripts, with the element in the 0 position being nil.
         */
        elements: Array<string>;

        /**
         * he equipment type. A string array with the following subscripts:
         * 1: Weapon
         * 2: Shield
         * 3: Head
         * 4: Body
         * 5: Accessory
         */
        equipTypes: Array<string>;

        /**
         * A list of skill types. A string array using skill type IDs as subscripts, with the element in the 0 position being nil.
         */
        skillTypes: Array<string>;

        /**
         * A list of weapon types. A string array using weapon type IDs as subscripts, with the element in the 0 position being nil.
         */
        weaponTypes: Array<string>;

        /**
         * A list of armor types. A string array using armor type IDs as subscripts, with the element in the 0 position being nil.
         */
        armorTypes: Array<string>;

        /**
         * A switch name list. A string array using switch IDs as subscripts, with the element in the 0 position being nil.
         */
        switches: Array<string>;

        /**
         * A variable name list. A string array using variable IDs as subscripts, with the element in the 0 position being nil.
         */
        variables: Array<string>;

        /**
         * Boat settings (RPG.System.Vehicle).
         */
        boat: System.Vehicle;

        /**
         * Ship settings (RPG.System.Vehicle).
         */
        ship: System.Vehicle;

        /**
         * Airship settings (RPG.System.Vehicle).
         */
        airship: System.Vehicle;

        /**
         * The file name of the title (background) graphic.
         */
        title1Name: string;

        /**
         * The file name of the title (frame) graphic.
         */
        title2Name: string;

        /**
         * The truth value of the [Draw Game Title] option.
         */
        optDrawTitle: boolean;

        /**
         * The truth value of the [Start Transparent] option.
         */
        optTransparent: boolean;

        /**
         * The truth value of the [Show Player Followers] option.
         */
        optFollowers: boolean;

        /**
         * The truth value of the [K.O. by Slip Damage] option.
         */
        optSlipDeath: boolean;

        /**
         * The truth value of the [K.O. by Floor Damage] option.
         */
        optFloorDeath: boolean;

        /**
         * The truth value of the [Display TP in Battle] option.
         */
        optDisplayTp: boolean;

        /**
         * The truth value of the [Reserve Members' EXP] option.
         */
        optExtraExp: boolean;

        /**
         * The truth value of the [use side-view battle] option.
         */
        optSideView: boolean;

        /**
         * The title BGM (RPG.AudioFile).
         */
        titleBgm: AudioFile;

        /**
         * The battle BGM (RPG.AudioFile).
         */
        battleBgm: AudioFile;

        /**
         * The battle end ME (RPG.AudioFile).
         */
        battleEndMe: AudioFile;

        /**
         * The gameover ME (RPG.AudioFile).
         */
        gameoverMe: AudioFile;

        /**
         * Sound effects. An RPG.SE array.
         */
        sounds: Array<AudioFile>;

        /**
         * The map ID of the player's initial position.
         */
        startMapId: number;

        /**
         * The map's x-coordinate of the player's initial position.
         */
        startX: number;

        /**
         * The map's y-coordinate of the player's initial position.
         */
        startY: number;

        /**
         * Terms (RPG.System.Terms).
         */
        terms: System.Terms;

        /**
         * Party settings for battle tests. An RPG.System.TestBattler array.
         */
        testBattlers: Array<System.TestBattler>;

        /**
         * The enemy troop ID for battle tests.
         */
        testTroopId: number;

        /**
         * The file name of the battle background (floor) graphic for use in editing enemy troops and battle tests.
         */
        battleback1Name: string;

        /**
         * The file name of the battle background (wall) graphic for use in editing enemy troops and battle tests.
         */
        battleback2Name: string;

        /**
         * The battler graphic file name for use in editing animations.
         */
        battlerName: string;

        /**
         * The adjustment value for the battler graphic's hue (0..360) for use in editing animations.
         */
        battlerHue: number;

        /**
         * The ID of the map currently being edited. For internal use.
         */
        editMapId: number;
    }

    namespace System {
        /**
         * The data class for vehicles.
         */
        export interface Vehicle {
            /**
             * The file name of the vehicle's walking graphic.
             */
            characterName: string;
            /**

             * The index of the vehicle's walking graphic (0..7).
             */
            characterIndex: number;

            /**
             * The vehicle's BGM (RPG.AudioFile).
             */
            bgm: AudioFile;

            /**
             * The map ID of the vehicle's initial position.
             */
            startMapId: number;

            /**
             * The map's x-coordinate of the vehicle's initial position.
             */
            startX: number;

            /**
             * The map's y-coordinate of the vehicle's initial position.
             */
            startY: number;
        }

        /**
         * The data class for terminology.
         */
        export interface Terms {
            /**
             * The basic status. A string array with the following subscripts:
             *
             * 0: Level
             * 1: Level (short)
             * 2: HP
             * 3: HP (short)
             * 4: MP
             * 5: MP (short)
             * 6: TP
             * 7: TP (short)
             * 8: EXP
             * 9: EXP (short)
             */
            basic: Array<string>;

            /**
             * Parameters. A string array with the following subscripts:
             *
             * 0: Maximum hit points
             * 1: Maximum magic points
             * 2: Attack power
             * 3: Defense power
             * 4: Magic attack power
             * 5: Magic defense power
             * 6: Agility
             * 7: Luck
             * 8: Hit
             * 9: Evasion
             */
            params: Array<string>;

            /**
             * 0: Fight
             * 1: Escape
             * 2: Attack
             * 3: Defend
             * 4: Item
             * 5: Skill
             * 6: Equip
             * 7: Status
             * 8: Sort
             * 9: Save
             * 10: Exit Game
             * 11: Option
             * 12: Weapon
             * 13: Armor
             * 14: Key Item
             * 15: Change Equipment
             * 16: Ultimate Equipment
             * 17: Remove All
             * 18: New Game
             * 19: Continue
             * 20: (not used)
             * 21: Go to Title
             * 22: Cancel
             * 23: (not used)
             * 24: Buy
             * 25: Sell
             */
            commands: Array<string>;

            /**
             * The messages.
             */
            messages: { [key: string]: string };
        }

        /**
         * The data class for the actors used in battle tests.
         */
        export interface TestBattler {
            /**
             * The actor ID.
             */
            actorId: number;

            /**
             * The actor's level.
             */
            level: number;

            /**
             * The actor's equipment. An array of weapon IDs or armor IDs with the following subscripts:
             *
             * 0: Weapon
             * 1: Shield
             * 2: Head
             * 3: Body
             * 4: Accessory
             */
            equips: Array<number>;
        }

        export interface AttackMotion {
            /**
             * The type of the motion.
             */
            type: number;

            /**
             * The ID of the weapon image.
             */
            weaponImageId: number;
        }
    }

    /**
     * The data class for audio file.
     */
    export interface AudioFile {
        /**
         * The sound file name.
         */
        name: string;

        /**
         * The pan.
         */
        pan: number;

        /**
         * The sound's pitch (50..150). The default value is 100.
         */
        pitch: number;

        /**
         * The sound's volume (0..100). The default values are 100 for BGM and ME and 80 for BGS and SE.
         */
        volume: number;
    }
}
//=============================================================================
// rpg_managers.js v1.5.0
//=============================================================================
/** @global RPGMakerMV Actor data. */
declare var $dataActors: Array<RPG.Actor>;
/** @global RPGMakerMV Class data. */
declare var $dataClasses: Array<RPG.Class>;
/** @global RPGMakerMV Skill data. */
declare var $dataSkills: Array<RPG.Skill>;
/** @global RPGMakerMV Item data. */
declare var $dataItems: Array<RPG.Item>;
/** @global RPGMakerMV Weapon data. */
declare var $dataWeapons: Array<RPG.Weapon>;
/** @global RPGMakerMV Armor data. */
declare var $dataArmors: Array<RPG.Armor>;
/** @global RPGMakerMV Enemy data. */
declare var $dataEnemies: Array<RPG.Enemy>;
/** @global RPGMakerMV Troop data. */
declare var $dataTroops: Array<RPG.Troop>;
/** @global RPGMakerMV State data. */
declare var $dataStates: Array<RPG.State>;
/** @global RPGMakerMV Animation data. */
declare var $dataAnimations: Array<RPG.Animation>;
/** @global RPGMakerMV Tileset data. */
declare var $dataTilesets: Array<RPG.Tileset>;
/** @global RPGMakerMV CommonEvent data. */
declare var $dataCommonEvents: Array<RPG.CommonEvent>;
/** @global RPGMakerMV System data. */
declare var $dataSystem: RPG.System;
/** @global RPGMakerMV MapInfo data. */
declare var $dataMapInfos: Array<RPG.MapInfo>;
/** @global RPGMakerMV Map data for the current map. */
declare var $dataMap: RPG.Map;
/** @global RPGMakerMV Temporary game data; not saved with the game. */
declare var $gameTemp: Game_Temp;
/** @global RPGMakerMV Game System data; saved with the game.
 * @type {Game_Temp}
*/
declare var $gameSystem: Game_System;
/** @global RPGMakerMV Game Screen; contains properties and methods
 * for adjusting the game screen.
 * @type {Game_Screen}
 */
declare var $gameScreen: Game_Screen;
declare var $gameTimer: Game_Timer;
/** @global RPGMakerMV Game Message; contains properties and methods
 * for displaying messages in the game message window. 
 * @type {Game_Message}
*/
declare var $gameMessage: Game_Message;
/** @global RPGMakerMV Game Switches; contains properties and methods
 * for modifying in game switches while the game is running.
 * These are boolean values: true or false.
 * @type {Game_Switches}
 */
declare var $gameSwitches: Game_Switches;
/** @global RPGMakerMV Game Variables; contains properties and methods
 * for modifying the values of game variables.
 * The variables can contain anything.
 * @type {Game_Variables}
 */
declare var $gameVariables: Game_Variables;
declare var $gameSelfSwitches: Game_SelfSwitches;
declare var $gameActors: Game_Actors;
/** @global RPGMaker MV Game Party; contains properties and methods
 * for interacting with the game party. Some of the methods include
 * number of party members, etc.
 * @type {Game_Party}
 */
declare var $gameParty: Game_Party;
/** @global RPGMakerMV Game Troop; contains properties and methods
 * for interacting with the game troops. Some of the methods include
 * enemy data, enemy names, etc.
 * @type {Game_Troop}
 */
declare var $gameTroop: Game_Troop;
/** @global RPGMakerMV Game Map; contains properties and methods
 * for interacting with the game map. Some of these methods include
 * interacting with the map's game_interpreter, and event information.
 * @type {Game_Map}
 */
declare var $gameMap: Game_Map;
/** @global RPGMakerMV Game Player; contains properties and methods
 * for interacting with the game player. Some of these methods
 * include interacting with the player's position and move route.
 * @type {Game_Player}
 */
declare var $gamePlayer: Game_Player;
declare var $testEvent: Array<RPG.EventCommand>;

declare class DataManager {
    protected static _globalId: string;
    protected static _lastAccessedId: number;
    protected static _errorUrl: any;
    protected static _databaseFiles: Array<Object>;
    constructor();
    static loadDatabase(): void;
    static loadDataFile(name: string, src: string): void;
    static isDatabaseLoaded(): boolean;
    static loadMapData(mapId: number): void;
    static makeEmptyMap(): void;
    static isMapLoaded(): boolean;
    static onLoad(object: any);
    static extractMetaData(data: object): void;
    static checkError(): void;
    static isBattleTest(): boolean;
    static isEventTest(): boolean;
    /**
     * Returns a boolean value given an item.
     * Item being a database object representing a skill.
     * @static
     * @param {object} item 
     * @returns {boolean} 
     * @memberof DataManager
     */
    static isSkill(item: object): boolean;
    /**
     * Returns a boolean value given an item.
     * Item must be a database item to be true.
     * @static
     * @param {object} item 
     * @returns {boolean} 
     * @memberof DataManager
     */
    static isItem(item: object): boolean;
    /**
     * Returns a boolean value given an item.
     * Item must be a database weapon to be true.
     * @static
     * @param {object} item 
     * @returns {boolean} 
     * @memberof DataManager
     */
    static isWeapon(item: object): boolean;
    /**
     * Returns a boolean value given an item.
     * Item must be a database armor to be true.
     * @static
     * @param {object} item 
     * @returns {boolean} 
     * @memberof DataManager
     */
    static isArmor(item: object): boolean;
    static createGameObjects(): void;
    static setupNewGame(): void;
    static setupBattleTest(): void;
    static setupEventTest(): void;
    static loadGlobalInfo(): void;
    static saveGlobalInfo(info: object): void;
    /**
     * Returns a boolean value given a savefileId.
     * If the savefileId exists; the value will be true.
     * @static
     * @param {number} savefileId 
     * @returns {boolean} 
     * @memberof DataManager
     */
    static isThisGameFile(savefileId: number): boolean;
    static isAnySavefileExists(): boolean;
    static latestSavefileId(): number;
    static loadAllSavefileImages(): void;
    static loadSavefileImages(info: object): void;
    /**
     * Returns the maximum number of save files 
     * allocated in the game.
     * @static
     * @returns {number} 
     * @memberof DataManager
     */
    static maxSavefiles(): number;
    /**
     * Saves the RPGMakerMV game given a savefileId.
     * Returns true if successful.
     * @static
     * @param {number} savefileId 
     * @returns {boolean} 
     * @memberof DataManager
     */
    static saveGame(savefileId: number): boolean;
    static loadGame(savefileId: number): boolean;
    /**
     * Returns the last accessed save fileId upon
     * saving or loading the game.
     * @static
     * @returns {number} 
     * @memberof DataManager
     */
    static lastAccessedSavefileId(): number;
    static saveGameWithoutRescue(savefileId: number): boolean;
    static loadGameWithoutRescue(savefileId: number): boolean;
    static selectSavefileForNewGame(): void;
    /**
     * Creates a new save file on the global
     * save file information containing important
     * data such as play time, characters, timestamp.
     * @static
     * @memberof DataManager
     */
    static makeSavefileInfo(): void;
    /**
     * Creates the save file contents when saving your game.
     * Good for aliasing when you want to add more data
     * to the game's save contents.
     * @static
     * @returns {object} 
     * @memberof DataManager
     */
    static makeSaveContents(): object;
    /**
     * Extracts the save file contents into the game's
     * variables. An excellent method to alias when you
     * wish to extend the game's save contents for a plugin.
     * @static
     * @param {object} contents 
     * @memberof DataManager
     */
    static extractSaveContents(contents: object): void;
}

/**
 * The static class that handles BGM, BGS, ME, and SE.
 * 
 * @interface AudioManagerStatic
 */
interface AudioManagerStatic {
    _bgmVolume: number;
    _bgsVolume: number;
    _meVolume: number;
    _seVolume: number;
    _currentBgm: MV.AudioParameters;
    _currentBgs: MV.AudioParameters;
    _bgmBuffer: Html5AudioStatic | WebAudio;
    _bgsBuffer: Html5AudioStatic | WebAudio;
    _meBuffer: Html5AudioStatic | WebAudio;
    _seBuffers: Array<Html5AudioStatic | WebAudio>;
    _staticBuffers: Array<Html5AudioStatic | WebAudio>;
    _replayFadeTime: number;
    _path: string;
    _blobUrl: string;

    bgmVolume: number;
    bgsVolume: number;
    meVolume: number;
    seVolume: number;

    playBgm(bgm: MV.AudioParameters, pos?: number): void;
    replayBgm(bgm: MV.AudioParameters): void;
    isCurrentBgm(bgm: MV.AudioParameters): boolean;
    updateBgmParameters(bgm: MV.AudioParameters): void;
    updateCurrentBgm(bgm: MV.AudioParameters, pos: number): void;
    stopBgm(): void;
    fadeOutBgm(duration: number): void;
    fadeInBgm(duration: number): void;

    playBgs(bgs: MV.AudioParameters, pos?: number): void;
    replayBgs(bgs: MV.AudioParameters): void;
    isCurrentBgs(bgs: MV.AudioParameters): boolean;
    updateBgsParameters(bgs: MV.AudioParameters): void;
    updateCurrentBgs(bgs: MV.AudioParameters, pos: number): void;
    stopBgs(): void;
    fadeOutBgs(duration: number): void;
    fadeInBgs(duration: number): void;
    playMe(me: MV.AudioParameters): void;
    updateMeParameters(me: MV.AudioParameters): void;
    fadeOutMe(duration: number): void;
    stopMe(): void;
    playMe(me: MV.AudioParameters): void;
    updateMeParameters(me: MV.AudioParameters): void;
    fadeOutMe(duration: number): void;
    stopMe(): void;
    playSe(se: MV.AudioParameters): void;
    updateSeParameters(buffer: MV.AudioParameters, se: MV.AudioParameters): void;
    stopSe(): void;
    playStaticSe(se: MV.AudioParameters): void;
    loadStaticSe(se: MV.AudioParameters): void;
    isStaticSe(se: MV.AudioParameters): boolean;
    stopAll(): void;
    saveBgm(): MV.AudioParameters;
    saveBgs(): MV.AudioParameters;
    makeEmptyAudioObject(): MV.AudioParameters;
    createBuffer(): Html5AudioStatic | WebAudio;
    updateBufferParameters(buffer: MV.AudioParameters, configVolume: number, audio: MV.AudioParameters): void;
    audioFileExt(): string;
    shouldUseHtml5Audio(): boolean;
    checkErrors(): void;
    checkWebAudioError(): void;
    checkWebAudioError(webAudio: Html5AudioStatic | WebAudio): void;
    playEncryptedBgm(bgm: MV.AudioParameters, pos?: number): void;
    createDecryptBuffer(url: string, bgm: MV.AudioParameters, pos?: number): void;
}
declare var AudioManager: AudioManagerStatic;


/**
 * SoundManager
 * The static class that plays sound effects defined in the database
 * @interface SoundManagerStatic
 */
interface SoundManagerStatic {
    preloadImportantSounds(): void;
    loadSystemSound(n: number): void;
    playSystemSound(n: number): void;
    playCursor(): void;
    playOk(): void;
    playCancel(): void;
    playBuzzer(): void;
    playEquip(): void;
    playSave(): void;
    playLoad(): void;
    playBattleStart(): void;
    playEscape(): void;
    playEnemyAttack(): void;
    playEnemyDamage(): void;
    playEnemyCollapse(): void;
    playBossCollapse1(): void;
    playBossCollapse2(): void;
    playActorDamage(): void;
    playActorCollapse(): void;
    playRecovery(): void;
    playMiss(): void;
    playEvasion(): void;
    playMagicEvasion(): void;
    playReflection(): void;
    playShop(): void;
    playUseItem(): void;
    playUseSkill(): void;
}
declare var SoundManager: SoundManagerStatic;

/**
 * The static class that manages the
 * battle process.
 * @interface BattleManagerStatic
 */
interface BattleManagerStatic {
    _phase: string;
    _canEscape: boolean;
    _canLose: boolean;
    _battleTest: boolean;
    _eventCallback: () => void;
    _preemptive: boolean;
    _surprise: boolean;
    _actorIndex: number;
    _actionForcedBattler: Game_Battler;
    _mapBgm: MV.AudioParameters;
    _mapBgs: MV.AudioParameters;
    _actionBattlers: Array<Game_Battler>;
    _subject: Game_Battler;
    _action: Game_Action;
    _targets: Array<Game_Battler>;
    _logWindow: Window_BattleLog;
    _statusWindow: Window_BattleStatus;
    _spriteset: Spriteset_Battle;
    _escapeRatio: number;
    _escaped: boolean;
    _rewards: MV.BattleRewards;

    setup(troopId: number, canEscape: boolean, canLose: boolean): void;
    initMembers(): void;
    isBattleTest(): boolean;
    setBattleTest(battleTest: boolean): void;
    setEventCallback(callback: () => void): void;
    setLogWindow(logWindow: Window_BattleLog): void;
    setStatusWindow(statusWindow: Window_BattleStatus): void;
    setSpriteset(spriteset: Spriteset_Battle): void;
    onEncounter(): void;
    ratePreemptive(): number;
    rateSurprise(): number;
    saveBgmAndBgs(): void;
    playBattleBgm(): void;
    playVictoryMe(): void;
    playDefeatMe(): void;
    replayBgmAndBgs(): void;
    makeEscapeRatio(): void;
    update(): void;
    updateEvent(): boolean;
    updateEventMain(): boolean;
    isBusy(): boolean;
    isInputting(): boolean;
    isInTurn(): boolean;
    isTurnEnd(): boolean;
    isAborting(): boolean;
    isBattleEnd(): boolean;
    canEscape(): boolean;
    canLose(): boolean;
    isEscaped(): boolean;
    actor(): Game_Actor;
    clearActor(): void;
    changeActor(newActorIndex: number, lastActorActionState: string): void;
    startBattle(): void;
    displayStartMessages(): void;
    startInput(): void;
    inputtingAction(): Game_Action;
    selectNextCommand(): void;
    selectPreviousCommand(): void;
    refreshStatus(): void;
    startTurn(): void;
    updateTurn(): void;
    processTurn(): void;
    endTurn(): void;
    updateTurnEnd(): void;
    getNextSubject(): Game_Battler;
    allBattleMembers(): Array<Game_Battler>;
    makeActionOrders(): void;
    startAction(): void;
    updateAction(): void;
    endAction(): void;
    invokeAction(): void;
    invokeNormalAction(): void;
    invokeCounterAttack(): void;
    invokeMagicReflection(): void;
    applySubstitute(target: Game_Battler): Game_Battler;
    checkSubstitute(target: Game_Battler): boolean;
    isActionForced(): boolean;
    forceAction(battler: Game_Battler): void;
    processForcedAction(): void;
    abort(): void;
    checkBattleEnd(): boolean;
    checkAbort(): boolean;
    processVictory(): void;
    processEscape(): boolean;
    processAbort(): void;
    processDefeat(): void;
    endBattle(result: number): void;
    updateBattleEnd(): void;
    makeRewards(): void;
    displayVictoryMessage(): void;
    displayDefeatMessage(): void;
    displayEscapeSuccessMessage(): void;
    displayEscapeFailureMessage(): void;
    displayRewards(): void;
    displayExp(): void;
    displayGold(): void;
    displayDropItems(): void;
    gainRewards(): void;
    gainExp(): void;
    gainGold(): void;
    gainDropItems(): void;
}
declare var BattleManager: BattleManagerStatic;

interface ConfigManagerStatic extends MV.ConfigData {
    load(): void;
    save(): void;
    makeData(): MV.ConfigData;
    applyData(config: MV.ConfigData): void;
    readFlag(config: MV.ConfigData, name: string): boolean;
    readVolume(config: MV.ConfigData, name: string): number;
}
declare var ConfigManager: ConfigManagerStatic;

/**
 * ImageManager
 * The static class that loads images, create bitmap objects and retains them.
 * @interface ImageManagerStatic
 */
interface ImageManagerStatic {
    cache: CacheMap;

    /**
     * Loads a Bitmap object from the 'img/animations/' folder
     * and returns it.
     * @param {string} filename 
     * @param {number} [hue] 
     * @returns {Bitmap} 
     * @memberof ImageManagerStatic
     */
    loadAnimation(filename: string, hue?: number): Bitmap;
    /**
     * Loads a Bitmap object from the 'img/battlebacks1/' folder
     *  and returns it.
     * @param {string} filename 
     * @param {number} [hue] 
     * @returns {Bitmap} 
     * @memberof ImageManagerStatic
     */
    loadBattleback1(filename: string, hue?: number): Bitmap;
    /**
     * Loads a Bitmap object from the 'img/battlebacks2/' folder
     * and returns it.
     * @param {string} filename 
     * @param {number} [hue] 
     * @returns {Bitmap} 
     * @memberof ImageManagerStatic
     */
    loadBattleback2(filename: string, hue?: number): Bitmap;
    /**
     * Loads a Bitmap object from the 'img/enemies/' folder
     * and returns it.
     * @param {string} filename 
     * @param {number} [hue] 
     * @returns {Bitmap} 
     * @memberof ImageManagerStatic
     */
    loadEnemy(filename: string, hue?: number): Bitmap;
    /**
     * Loads a Bitmap object from the 'img/characters/' folder
     * and returns it.
     * @param {string} filename 
     * @param {number} [hue] 
     * @returns {Bitmap} 
     * @memberof ImageManagerStatic
     */
    loadCharacter(filename: string, hue?: number): Bitmap;
    /**
     * Loads a Bitmap object from the 'img/faces/' folder
     * and returns it.
     * @param {string} filename 
     * @param {number} [hue] 
     * @returns {Bitmap} 
     * @memberof ImageManagerStatic
     */
    loadFace(filename: string, hue?: number): Bitmap;
    /**
     * Loads a Bitmap object from the 'img/parallaxes/' folder
     * and returns it.
     * @param {string} filename 
     * @param {number} [hue] 
     * @returns {Bitmap} 
     * @memberof ImageManagerStatic
     */
    loadParallax(filename: string, hue?: number): Bitmap;
    /**
     * Loads a Bitmap object from the 'img/pictures/' folder
     * and returns it.
     * @param {string} filename 
     * @param {number} [hue] 
     * @returns {Bitmap} 
     * @memberof ImageManagerStatic
     */
    loadPicture(filename: string, hue?: number): Bitmap;
    /**
     * Loads a Bitmap object from the 'img/sv_actors/' folder
     * and returns it.
     * @param {string} filename 
     * @param {number} [hue] 
     * @returns {Bitmap} 
     * @memberof ImageManagerStatic
     */
    loadSvActor(filename: string, hue?: number): Bitmap;
    /**
     * Loads a Bitmap object from the 'img/sv_enemies/' folder
     * and returns it.
     * @param {string} filename 
     * @param {number} [hue] 
     * @returns {Bitmap} 
     * @memberof ImageManagerStatic
     */
    loadSvEnemy(filename: string, hue?: number): Bitmap;
    /**
     * Loads a Bitmap object from 'img/system/' folder
     * and returns it.
     * @param {string} filename 
     * @param {number} [hue] 
     * @returns {Bitmap} 
     * @memberof ImageManagerStatic
     */
    loadSystem(filename: string, hue?: number): Bitmap;
    /**
     * Loads a Bitmap object from the 'img/tilesets/' folder
     * and returns it.
     * @param {string} filename 
     * @param {number} [hue] 
     * @returns {Bitmap} 
     * @memberof ImageManagerStatic
     */
    loadTileset(filename: string, hue?: number): Bitmap;
    /**
     * Loads a Bitmap object from the 'img/titles1/' folder
     * and returns it.
     * @param {string} filename 
     * @param {number} [hue] 
     * @returns {Bitmap} 
     * @memberof ImageManagerStatic
     */
    loadTitle1(filename: string, hue?: number): Bitmap;
    /**
     * Loads a Bitmap object from the 'img/titles2/' folder
     * and returns it.
     * @param {string} filename 
     * @param {number} [hue] 
     * @returns {Bitmap} 
     * @memberof ImageManagerStatic
     */
    loadTitle2(filename: string, hue?: number): Bitmap;
    /**
     * Loads a Bitmap object from any folder and returns it.
     * 
     * @param {string} folder 
     * @param {string} filename 
     * @param {number} hue 
     * @param {boolean} smooth 
     * @returns {Bitmap} 
     * @memberof ImageManagerStatic
     */
    loadBitmap(folder: string, filename: string, hue: number, smooth: boolean): Bitmap;
    /**
     * Loads an empty Bitmap object and returns it.
     * 
     * @param {string} path 
     * @param {number} hue 
     * @returns {Bitmap} 
     * @memberof ImageManagerStatic
     */
    loadEmptyBitmap(path: string, hue: number): Bitmap;
    /**
     * Loads a Bitmap object given a path
     * and returns it.
     * @param {string} path 
     * @param {number} hue 
     * @returns {Bitmap} 
     * @memberof ImageManagerStatic
     */
    loadNormalBitmap(path: string, hue: number): Bitmap;
    /**
     * Clears the image cache in RPGMakerMV.
     * 
     * @memberof ImageManagerStatic
     */
    clear(): void;
    /**
     * Returns true if the image cache
     * is ready.
     * @returns {boolean} 
     * @memberof ImageManagerStatic
     */
    isReady(): boolean;
    /**
     * Returns true if the given filename
     * is an object character. Must contain
     * a  '!' in the file name to be an
     * object character.
     * @param {string} filename 
     * @returns {boolean} 
     * @memberof ImageManagerStatic
     */
    isObjectCharacter(filename: string): boolean;
    /**
     * Returns true if the given filename is
     * a large character. Must contain a '$'
     * in the file name to be a large character.
     * @param {string} filename 
     * @returns {boolean} 
     * @memberof ImageManagerStatic
     */
    isBigCharacter(filename: string): boolean;
    isZeroParallax(filename: string): boolean;
}
declare var ImageManager: ImageManagerStatic;

interface SceneManagerStatic {
    _scene: Scene_Base;
    _nextScene: Scene_Base;
    _stack: Array<() => void>;
    _stopped: boolean;
    _sceneStarted: boolean;
    _exiting: boolean;
    _previousClass: () => void;
    _backgroundBitmap: Bitmap;
    _screenWidth: number;
    _screenHeight: number;
    _boxWidth: number;
    _boxHeight: number;
    _deltaTime: number;
    _currentTime: number;
    _accumulator: number;

    run(sceneClass: () => void): void;
    initialize(): void;
    initGraphics(): void;
    preferableRendererType(): string;
    shouldUseCanvasRenderer(): boolean;
    checkWebGL(): void;
    checkFileAccess(): void;
    initAudio(): void;
    initInput(): void;
    initNwjs(): void;
    checkPluginErrors(): void;
    setupErrorHandlers(): void;
    requestUpdate(): void;
    update(): void;
    terminate(): void;
    onError(e: Event): void;
    onKeyDown(event: KeyboardEvent): void;
    catchException(e: Event): void;
    tickStart(): void;
    tickEnd(): void;
    updateInputData(): void;
    updateMain(): void;
    changeScene(): void;
    updateScene(): void;
    renderScene(): void;
    onSceneCreate(): void;
    onSceneStart(): void;
    onSceneLoading(): void;
    isSceneChanging(): boolean;
    isCurrentSceneBusy(): boolean;
    isCurrentSceneStarted(): boolean;
    isNextScene(sceneClass: () => void): boolean;
    isPreviousScene(sceneClass: () => void): boolean;
    goto(sceneClass: () => void): void;
    push(sceneClass: () => void): void;
    pop(): void;
    exit(): void;
    clearStack(): void;
    stop(): void;
    prepareNextScene(): void;
    snap(): Bitmap;
    snapForBackground(): void;
    backgroundBitmap(): Bitmap;
    updateManagers(ticks: number, delta: number): void;
}
declare var SceneManager: SceneManagerStatic;

/**
 * StorageManager
 * The static class that manages storage saving game data.
 * @interface StorageManagerStatic
 */
interface StorageManagerStatic {
    save(savefileId: number, json: string): void;
    load(savefileId: number): string;
    exists(savefileId: number): boolean;
    remove(savefileId: number): void;
    backup(savefileId: number): void;
    backupExists(savefileId: number): boolean;
    cleanBackup(savefileId: number): boolean;
    restoreBackup(savefileId: number): void;
    isLocalMode(): boolean;
    saveToLocalFile(savefileId: number, json: string): void;
    loadFromLocalFile(savefileId: number): string;
    loadFromLocalBackupFile(savefileId: number): string;
    localFileBackupExists(savefileId: number): boolean;
    localFileExists(savefileId: number): boolean;
    removeLocalFile(savefileId: number): void;
    saveToWebStorage(savefileId: number, json: string): void;
    loadFromWebStorage(savefileId: number): string;
    loadFromWebStorageBackup(savefileId: number): string;
    webStorageBackupExists(savefileId: number): boolean;
    webStorageExists(savefileId: number): boolean;
    removeWebStorage(savefileId: number): void;
    localFileDirectoryPath(): string;
    localFilePath(savefileId: number): string;
    webStorageKey(savefileId: number): string;
}
declare var StorageManager: StorageManagerStatic;

/**
 * TextManager
 * The static class that handles terms and messages.
 * @interface TextManagerStatic
 */
interface TextManagerStatic {
    currencyUnit: string;
    level: string;
    levelA: string;
    hp: string;
    hpA: string;
    mp: string;
    mpA: string;
    tp: string;
    tpA: string;
    exp: string;
    expA: string;
    fight: string;
    escape: string;
    attack: string;
    guard: string;
    item: string;
    skill: string;
    equip: string;
    status: string;
    formation: string;
    save: string;
    gameEnd: string;
    options: string;
    weapon: string;
    armor: string;
    keyItem: string;
    equip2: string;
    optimize: string;
    clear: string;
    newGame: string;
    continue_: string;
    toTitle: string;
    cancel: string;
    buy: string;
    sell: string;
    alwaysDash: string;
    commandRemember: string;
    bgmVolume: string;
    bgsVolume: string;
    meVolume: string;
    seVolume: string;
    possession: string;
    expTotal: string;
    expNext: string;
    saveMessage: string;
    loadMessage: string;
    file: string;
    partyName: string;
    emerge: string;
    preemptive: string;
    surprise: string;
    escapeStart: string;
    escapeFailure: string;
    victory: string;
    defeat: string;
    obtainExp: string;
    obtainGold: string;
    obtainItem: string;
    levelUp: string;
    obtainSkill: string;
    useItem: string;
    criticalToEnemy: string;
    criticalToActor: string;
    actorDamage: string;
    actorRecovery: string;
    actorGain: string;
    actorLoss: string;
    actorDrain: string;
    actorNoDamage: string;
    actorNoHit: string;
    enemyDamage: string;
    enemyRecovery: string;
    enemyGain: string;
    enemyLoss: string;
    enemyDrain: string;
    enemyNoDamage: string;
    enemyNoHit: string;
    evasion: string;
    magicEvasion: string;
    magicReflection: string;
    counterAttack: string;
    substitute: string;
    buffAdd: string;
    debuffAdd: string;
    buffRemove: string;
    actionFailure: string;
    basic(basicId: number): string;
    param(paramId: number): string;
    command(commandId: number): string;
    message(messageId: string): string;
    getter(method: string, param: number): string;
}
declare var TextManager: TextManagerStatic;

/**
 * PluginManager
 * The static class that manages plugins.
 * @interface PluginManagerStatic
 */
interface PluginManagerStatic {
    _path: string;
    _scripts: Array<string>;
    _errorUrls: Array<string>;
    _parameters: { [key: string]: { [key: string]: string } };

    setup(plugins: Array<MV.PluginSettings>): void;
    /**
     * Checks for errors in the plugins.
     * 
     * @memberof PluginManagerStatic
     */
    checkErrors(): void;
    parameters(name: string): any;
    setParameters(name: string, parameters: { [key: string]: string }): void;
    loadScript(name: string): void;
    onError(e: Event): void;
}
declare var PluginManager: PluginManagerStatic;

declare namespace MV {
    export interface Matrix {
        type: string;
        value: Array<number>;
    }
    export interface TouchInputEvents {
        trigger: boolean;
        cancelled: boolean;
        moved: boolean;
        released: boolean;
        wheelX: number;
        wheelY: number;
    }
    export interface AudioParameters {
        name: string;
        volume: number;
        pitch: number;
        pan: number;
        pos: number;
    }
    export interface BattleRewards {
        gold: number;
        exp: number;
        items: Array<RPG.BaseItem>;
    }
    export interface BattlerAnimation {
        animationId: number;
        mirror: boolean;
        delay: number;
    }
    export interface CommandItem {
        name: string;
        symbol: string;
        enabled: boolean;
        ext: any;
    }
    export interface TextState {
        index: number;
        x: number;
        y: number;
        left: number;
    }
    export interface BattleLogMethod {
        name: string;
        params: any;
    }
    export interface Motion {
        index: number;
        loop: boolean;
    }
    export interface ConfigData {
        alwaysDash: boolean;
        commandRemember: boolean;
        bgmVolume: number;
        bgsVolume: number;
        meVolume: number;
        seVolume: number;
    }
    export interface DatabaseFile {
        name: string;
        src: string;
    }
    export interface SaveFileInfo {
        globalId: string;
        title: string;
        characters: Array<Array<any>>;
        faces: Array<Array<any>>;
        playtime: string;
        timestamp: number;
    }
    export interface SaveContents {
        system: Game_System;
        screen: Game_Screen;
        timer: Game_Timer;
        switches: Game_Switches;
        variables: Game_Variables;
        selfSwitches: Game_SelfSwitches;
        actors: Game_Actors;
        party: Game_Party;
        map: Game_Map;
        player: Game_Party;
    }
    export interface PluginSettings {
        name: string;
        status: string;
        description: string;
        parameters: { [key: string]: string };
    }
}
/**
 * The game object class for temporary data that is not
 * included in the save data.
 * @class Game_Temp
 */
declare class Game_Temp {
    protected _isPlaytest: boolean;
    protected _commonEventId: number;
    protected _destinationX: number;
    protected _destinationY: number;

    /**
     * Determines if the game is in Play Test mode.
     * 
     * @returns {boolean} 
     * @memberof Game_Temp
     */
    isPlaytest(): boolean;
    /**
     * Reserves the given commonEventId to be processed later.
     * 
     * @param {number} commonEventId 
     * @memberof Game_Temp
     */
    reserveCommonEvent(commonEventId: number): void;
    /**
     * Clears the current reserved common event.
     * 
     * @memberof Game_Temp
     */
    clearCommonEvent(): void;
    /**
     * Returns true if a common event has been reserved.
     * 
     * @returns {boolean} 
     * @memberof Game_Temp
     */
    isCommonEventReserved(): boolean;
    /**
     * Returns common event data from the database.
     * 
     * @returns {any} 
     * @memberof Game_Temp
     */
    reservedCommonEvent(): any;
    /**
     * Sets the destination of the player for movement.
     * 
     * @param {number} x 
     * @param {number} y 
     * @memberof Game_Temp
     */
    setDestination(x: number, y: number): void;
    /**
     * Clears the destination of movement for the player.
     * 
     * @memberof Game_Temp
     */
    clearDestination(): void;
    /**
     * Determines if the destination for the player to move to is valid.
     * 
     * @returns {boolean} 
     * @memberof Game_Temp
     */
    isDestinationValid(): boolean;
    /**
     * Returns the x coordinate of the destination.
     * 
     * @returns {number} 
     * @memberof Game_Temp
     */
    destinationX(): number;
    /**
     * Returns the y coordinate of the destination.
     * 
     * @returns {number} 
     * @memberof Game_Temp
     */
    destinationY(): number;
}

/**
 * Game Object class for the system data.
 * 
 * @class Game_System
 */
declare class Game_System {
    protected _saveEnabled: boolean;
    protected _menuEnabled: boolean;
    protected _encounterEnabled: boolean;
    protected _formationEnabled: boolean;
    protected _battleCount: number;
    protected _winCount: number;
    protected _escapeCount: number;
    protected _saveCount: number;
    protected _versionId: number;
    protected _framesOnSave: number;
    protected _bgmOnSave: RPG.AudioFile;
    protected _bgsOnSave: RPG.AudioFile;
    protected _windowTone: Array<number>;
    protected _battleBgm: RPG.AudioFile;
    protected _victoryMe: RPG.AudioFile;
    protected _defeatMe: RPG.AudioFile;
    protected _savedBgm: RPG.AudioFile;
    protected _walkingBgm: RPG.AudioFile;

    isJapanese(): boolean;
    isChinese(): boolean;
    isKorean(): boolean;
    isCJK(): boolean;
    isRussian(): boolean;
    isSideView(): boolean;
    isSaveEnabled(): boolean;
    /**
     * Disables the ability to save the game.
     * 
     * @memberof Game_System
     */
    disableSave(): void;
    /**
     * Enables the ability to save the game.
     * 
     * @memberof Game_System
     */
    enableSave(): void;
    /**
     * Returns true if the menu is enabled.
     * 
     * @returns {boolean} 
     * @memberof Game_System
     */
    isMenuEnabled(): boolean;
    /**
     * Disables the menu from being accessed.
     * 
     * @memberof Game_System
     */
    disableMenu(): void;
    /**
     * Enables the menu to be accessed.
     * 
     * @memberof Game_System
     */
    enableMenu(): void;
    isEncounterEnabled(): boolean;
    /**
     * Returns true if the player can encounter enemies.
     * 
     * @memberof Game_System
     */
    disableEncounter(): void;
    enableEncounter(): void;
    isFormationEnabled(): boolean;
    /**
     * Disables the use of the formation command in the menu.
     * 
     * @memberof Game_System
     */
    disableFormation(): void;
    /**
     * Enables the use of the formation command in the menu.
     * 
     * @memberof Game_System
     */
    enableFormation(): void;
    /**
     * Returns the number of battles the player has participated in.
     * 
     * @returns {number} 
     * @memberof Game_System
     */
    battleCount(): number;
    /**
     * Returns the number of the wins the player has gained in battle.
     * 
     * @returns {number} 
     * @memberof Game_System
     */
    winCount(): number;
    /**
     * Returns the number of battles the player has escaped from in battle.
     * 
     * @returns {number} 
     * @memberof Game_System
     */
    escapeCount(): number;
    /**
     * Returns the number of saves the player has made in game.
     * 
     * @returns {number} 
     * @memberof Game_System
     */
    saveCount(): number;
    /**
     * Returns the version id represented in the database.
     * 
     * @returns {number} 
     * @memberof Game_System
     */
    versionId(): number;
    /**
     * Returns the tone of the window in the database.
     * 
     * @returns {Array<number>} 
     * @memberof Game_System
     */
    windowTone(): Array<number>;
    /**
     * Sets the window tone, given an array
     * of rgb. Example: [0, 255, 255].
     * @param {Array<number>} value 
     * @memberof Game_System
     */
    setWindowTone(value: Array<number>): void;
    /**
     * Returns the current battle background music.
     * 
     * @returns {RPG.AudioFile} 
     * @memberof Game_System
     */
    battleBgm(): RPG.AudioFile;
    /**
     * Sets the battle background music.
     * 
     * @param {RPG.AudioFile} value 
     * @memberof Game_System
     */
    setBattleBgm(value: RPG.AudioFile): void;
    /**
     * Returns the victory musical effect.
     * 
     * @returns {RPG.AudioFile} 
     * @memberof Game_System
     */
    victoryMe(): RPG.AudioFile;
    /**
     * Sets the victory musical effect.
     * 
     * @param {RPG.AudioFile} value 
     * @memberof Game_System
     */
    setVictoryMe(value: RPG.AudioFile): void;
    /**
     * Returns the defeat musical effect.
     * 
     * @returns {RPG.AudioFile} 
     * @memberof Game_System
     */
    defeatMe(): RPG.AudioFile;
    /**
     * Sets the defeat musical effect.
     * 
     * @param {RPG.AudioFile} value 
     * @memberof Game_System
     */
    setDefeatMe(value: RPG.AudioFile): void;
    onBattleStart(): void;
    onBattleWin(): void;
    onBattleEscape(): void;
    onBeforeSave(): void;
    onAfterLoad(): void;
    /**
     * Returns the total play time.
     * 
     * @returns {number} 
     * @memberof Game_System
     */
    playtime(): number;
    playtimeText(): string;
    /**
     * Saves background music to the game system object.
     * 
     * @memberof Game_System
     */
    saveBgm(): void;
    /**
     * Replays the saved background music.
     * 
     * @memberof Game_System
     */
    replayBgm(): void;
    /**
     * Saves the walking background music.
     * 
     * @memberof Game_System
     */
    saveWalkingBgm(): void;
    /**
     * Replays the saved walking background music.
     * 
     * @memberof Game_System
     */
    replayWalkingBgm(): void;
    /**
     * Saves the second walking bgm from the map data.
     * 
     * @memberof Game_System
     */
    saveWalkingBgm2(): void;
}

/**
 * The game object class for the timer.
 * 
 * @class Game_Timer
 */
declare class Game_Timer {
    protected _frames: number;
    protected _working: boolean;

    /**
     * Updates the game timer.
     * 
     * @param {boolean} sceneActive 
     * @memberof Game_Timer
     */
    update(sceneActive: boolean): void;
    /**
     * Starts the timer with the specified number of frames as count.
     * 
     * @param {number} count 
     * @memberof Game_Timer
     */
    start(count: number): void;
    /**
     * Stops the timer.
     * 
     * @memberof Game_Timer
     */
    stop(): void;
    /**
     * Returns true if the timer is working and counting down.
     * 
     * @returns {boolean} 
     * @memberof Game_Timer
     */
    isWorking(): boolean;
    /**
     * Returns the number of seconds on the timer.
     * 
     * @returns {number} 
     * @memberof Game_Timer
     */
    seconds(): number;
    /**
     * Handler for when the time expires on the timer.
     * 
     * @memberof Game_Timer
     */
    onExpire(): void;
}

/**
 * The game object class for the state of the message window
 * that displays text or selections.
 * @class Game_Message
 */
declare class Game_Message {
    protected _texts: Array<string>;
    protected _choices: Array<string>;
    protected _faceName: string;
    protected _faceIndex: number;
    protected _background: number;
    protected _positionType: number;
    protected _choiceDefaultType: number;
    protected _choiceCancelType: number;
    protected _choiceBackground: number;
    protected _choicePostionType: number;
    protected _numInputVariableId: number;
    protected _numInputMaxDigits: number;
    protected _itemChoiceVariableId: number;
    protected _itemChoiceItypeId: number;
    protected _scrollMode: boolean;
    protected _scrollSpeed: number;
    protected _scrollNoFast: boolean;
    protected _choiceCallback: (n: number) => void;

    clear(): void;
    choices(): Array<string>;
    /**
     * Returns the name of the face image used for the message.
     * 
     * @returns {string} 
     * @memberof Game_Message
     */
    faceName(): string;
    /**
     * Returns the face index within the face image to display the
     * correct face.
     * @returns {number} 
     * @memberof Game_Message
     */
    faceIndex(): number;
    /**
     * Returns the background associated with the message;
     * this is the background
     * @returns {number} 
     * @memberof Game_Message
     */
    background(): number;
    /**
     * Returns the current position type of the message window.
     * 
     * @returns {number} 
     * @memberof Game_Message
     */
    positionType(): number;
    choiceDefaultType(): number;
    choiceCancelType(): number;
    /**
     * Returns the background type of the choice window.
     * 
     * @returns {number} 
     * @memberof Game_Message
     */
    choiceBackground(): number;
    /**
     * Returns the position of the choice window.
     * 
     * @returns {number} 
     * @memberof Game_Message
     */
    choicePositionType(): number;
    /**
     * Returns the number input variable id.
     * 
     * @returns {number} 
     * @memberof Game_Message
     */
    numInputVariableId(): number;
    /**
     * Returns the number input maximum digits.
     * 
     * @returns {number} 
     * @memberof Game_Message
     */
    numInputMaxDigits(): number;
    /**
     * Returns the item choice variable id.
     * 
     * @returns {number} 
     * @memberof Game_Message
     */
    itemChoiceVariableId(): number;
    /**
     * Returns the item choice item type id.
     * 
     * @returns {number} 
     * @memberof Game_Message
     */
    itemChoiceItypeId(): number;
    /**
     * Returns true if the scroll mode is set to true.
     * 
     * @returns {boolean} 
     * @memberof Game_Message
     */
    scrollMode(): boolean;
    /**
     * Returns the scroll speed.
     * 
     * @returns {number} 
     * @memberof Game_Message
     */
    scrollSpeed(): number;
    /**
     * Returns true if the scroll is set to not being fast.
     * 
     * @returns {boolean} 
     * @memberof Game_Message
     */
    scrollNoFast(): boolean;
    /**
     * Adds text to the game message object.
     * 
     * @param {string} text 
     * @memberof Game_Message
     */
    add(text: string): void;
    setFaceImage(faceName: string, faceIndex: number): void;
    /**
     * Sets the background of the message window;
     * options are 0 (fully opaque), 1 (transparent), 2 (invisible background).
     * The default is 0.
     * @param {number} background 
     * @memberof Game_Message
     */
    setBackground(background: number): void;
    /**
     * Sets the position of the message window;
     * default is 2.
     * @param {number} positionType 
     * @memberof Game_Message
     */
    setPositionType(positionType: number): void;
    /**
     * Sets the choices within the choice window;
     * sets the default and cancel choices for the window.
     * @param {Array<string>} choices 
     * @param {number} defaultType 
     * @param {number} cancelType 
     * @memberof Game_Message
     */
    setChoices(choices: Array<string>, defaultType: number, cancelType: number): void;
    setChoiceBackground(background: number): void;
    /**
     * Sets the position of the choice window associated with the
     * message window.
     * @param {number} positionType 
     * @memberof Game_Message
     */
    setChoicePositionType(positionType: number): void;
    /**
     * Sets the number input and associates it with a variable id;
     * the max number of digits can also be set.
     * @param {number} variableId 
     * @param {number} maxDigits 
     * @memberof Game_Message
     */
    setNumberInput(variableId: number, maxDigits: number): void;
    /**
     * Sets the choice and associates it with a variable id;
     * sets the itemtype id associated with the choice.
     * @param {number} variableId 
     * @param {number} itemType 
     * @memberof Game_Message
     */
    setItemChoice(variableId: number, itemType: number): void;
    /**
     * Sets the scroll speed of the message window;
     * disable fast movement if noFast is set to true.
     * @param {number} speed 
     * @param {boolean} noFast 
     * @memberof Game_Message
     */
    setScroll(speed: number, noFast: boolean): void;
    /**
     * Sets a callback to be associated with a specific choice;
     * a callback is a JavaScript function that will be run when the
     * choice is selected.
     * @param {((n: number) => void)} callback 
     * @memberof Game_Message
     */
    setChoiceCallback(callback: ((n: number) => void)): void;
    onChoice(n: number): void;
    /**
     * Returns true if the game message object has text.
     * 
     * @returns {boolean} 
     * @memberof Game_Message
     */
    hasText(): boolean;
    /**
     * Returns true if the game message object has a set of choices.
     * 
     * @returns {boolean} 
     * @memberof Game_Message
     */
    isChoice(): boolean;
    /**
     * Returns true if the game message object has a number input attached.
     * 
     * @returns {boolean} 
     * @memberof Game_Message
     */
    isNumberInput(): boolean;
    /**
     * Returns true if the game message object has an item choice attached.
     * 
     * @returns {boolean} 
     * @memberof Game_Message
     */
    isItemChoice(): boolean;
    /**
     * Returns true if the game message object has text, choices, number input,
     * or item choice.
     * @returns {boolean} 
     * @memberof Game_Message
     */
    isBusy(): boolean;
    /**
     * Creates a new page for the text within the message window.
     * 
     * @memberof Game_Message
     */
    newPage(): void;
    /**
     * Returns all of the text contained within the message.
     * 
     * @returns {string} 
     * @memberof Game_Message
     */
    allText(): string;
}

/**
 * The game object class for game switches.
 *
 * @class Game_Switches
 */
declare class Game_Switches {
    protected _data: Array<boolean>;

    clear(): void;
    value(switchId: number): boolean;
    setValue(switchId: number, value: boolean): void;
    onChange(): void;
}

/**
 * The game object class for game variables.
 * 
 * @class Game_Variables
 */
declare class Game_Variables {
    protected _data: Array<number>;

    clear(): void;
    value(variableId: number): number;
    setValue(variableId: number, value: number): void;
    onChange(): void;
}

/**
 * The game object class for self switches.
 * 
 * @class Game_SelfSwitches
 */
declare class Game_SelfSwitches {
    protected _data: { key: Array<any> };

    /**
     * Clears the array of data for the game's self switches.
     * 
     * @memberof Game_SelfSwitches
     */
    clear(): void;
    /**
     * Returns the value of the switch at the current key;
     * the value is a boolean (true or false).
     * @param {Array<any>} key 
     * @returns {boolean} 
     * @memberof Game_SelfSwitches
     */
    value(key: Array<any>): boolean;
    /**
     * Sets the value of the key of the respected self switch.
     * 
     * @param {Array<any>} key 
     * @param {boolean} value 
     * @memberof Game_SelfSwitches
     */
    setValue(key: Array<any>, value: boolean): void;
    onChange(): void;
}

/**
 * The game object class for screen effect data, such as
 * changes in color tone and flashes.
 * aliased as $gameScreen.
 * @class Game_Screen
 */
declare class Game_Screen {
    protected _shake: number;
    protected _shakePower: number;
    protected _shakeSpeed: number;
    protected _shakeDuration: number;
    protected _shakeDirection: number;

    /**
     * _zoomX property of the game screen.
     * 
     * @protected
     * @type {number}
     * @memberof Game_Screen
     */
    protected _zoomX: number;
    /**
     * _zoomY property of the game screen.
     * 
     * @protected
     * @type {number}
     * @memberof Game_Screen
     */
    protected _zoomY: number;
    protected _zoomScale: number;
    protected _zoomScaleTarget: number;
    protected _zoomDuration: number;

    protected _weatherType: string;
    protected _weatherPower: number;
    protected _weatherPowerTarget: number;
    protected _weatherDuration: number;

    /**
     * The _brightness property of the game screen;
     * returned when calling the brightness method.
     * @protected
     * @type {number}
     * @memberof Game_Screen
     */
    protected _brightness: number;
    protected _fadeOutDuration: number;
    protected _fadeInDuration: number;

    protected _tone: Array<number>;
    protected _toneTarget: Array<number>;
    protected _toneDuration: number;

    protected _flashColor: Array<number>;
    protected _flashDuration: number;

    /**
     * The array of Game_Pictures that are 
     * attached to the game screen.
     * @protected
     * @type {Array<Game_Picture>}
     * @memberof Game_Screen
     */
    protected _pictures: Array<Game_Picture>;

    clear(): void;
    /**
     * Handler for when the battle starts in game; prepares
     * the screen for the battle scene.
     * @memberof Game_Screen
     */
    onBattleStart(): void;
    /**
     * Returns the brightness of the game screen.
     * 
     * @returns {number} 
     * @memberof Game_Screen
     */
    brightness(): number;
    tone(): Array<number>;
    flashColor(): Array<number>;
    shake(): number;
    /**
     * Returns the  zoom x coordinate of the screen.
     * 
     * @returns {number} 
     * @memberof Game_Screen
     */
    zoomX(): number;
    /**
     * Returns the zoom y coordinate of the screen.
     * 
     * @returns {number} 
     * @memberof Game_Screen
     */
    zoomY(): number;
    /**
     * Returns the zoom scale of the screen.
     * 
     * @returns {number} 
     * @memberof Game_Screen
     */
    zoomScale(): number;
    /**
     * Returns the current weather type.
     * 
     * @returns {string} 
     * @memberof Game_Screen
     */
    weatherType(): string;
    /**
     * Returns the weather power.
     * 
     * @returns {number} 
     * @memberof Game_Screen
     */
    weatherPower(): number;
    /**
     * Returns the specified picture given the picture id.
     * 
     * @param {number} pictureId 
     * @returns {Game_Picture} 
     * @memberof Game_Screen
     */
    picture(pictureId: number): Game_Picture;
    /**
     * Returns the real picture id, given the picture id.
     * 
     * @param {number} pictureId 
     * @returns {number} 
     * @memberof Game_Screen
     */
    realPictureId(pictureId: number): number;
    /**
     * Clears the screen fade.
     * 
     * @memberof Game_Screen
     */
    clearFade(): void;
    /**
     * Clears the screen tone.
     * 
     * @memberof Game_Screen
     */
    clearTone(): void;
    /**
     * Clears the screen flash.
     * 
     * @memberof Game_Screen
     */
    clearFlash(): void;
    /**
     * Clears the screen shake.
     * 
     * @memberof Game_Screen
     */
    clearShake(): void;
    /**
     * Clears the screen zoom.
     * 
     * @memberof Game_Screen
     */
    clearZoom(): void;
    /**
     * Clears the screen weather.
     * 
     * @memberof Game_Screen
     */
    clearWeather(): void;
    /**
     * Clears the pictures set on the game screen.
     * 
     * @memberof Game_Screen
     */
    clearPictures(): void;
    /**
     * Erases the battle pictures.
     * 
     * @memberof Game_Screen
     */
    eraseBattlePictures(): void;
    /**
     * Returns the maximum number of pictures set on the game screen.
     * 
     * @returns {number} 
     * @memberof Game_Screen
     */
    maxPictures(): number;
    startFadeOut(duration: number): void;
    startFadeIn(duration: number): void;
    startTint(tone: Array<number>, duration: number): void;
    startFlash(color: Array<number>, duration: number): void;
    startShake(power: number, speed: number, duration: number): void;
    startZoom(x: number, y: number, scale: number, duration: number): void;
    setZoom(x: number, y: number, scale: number): void;
    changeWeather(type: string, power: number, duration: number): void;
    /**
     * Updates the game screen.
     * 
     * @memberof Game_Screen
     */
    update(): void;
    /**
     * Updates the screen fade out.
     * 
     * @memberof Game_Screen
     */
    updateFadeOut(): void;
    /**
     * Updates the screen fade in.
     * 
     * @memberof Game_Screen
     */
    updateFadeIn(): void;
    /**
     * Updates the screen tone.
     * 
     * @memberof Game_Screen
     */
    updateTone(): void;
    /**
     * Update the screen flash.
     * 
     * @memberof Game_Screen
     */
    updateFlash(): void;
    /**
     * Update the screen shake.
     * 
     * @memberof Game_Screen
     */
    updateShake(): void;
    /**
     * Update the screen zoom.
     * 
     * @memberof Game_Screen
     */
    updateZoom(): void;
    /**
     * Update the screen weather.
     * 
     * @memberof Game_Screen
     */
    updateWeather(): void;
    /**
     * Update the screen pictures.
     * 
     * @memberof Game_Screen
     */
    updatePictures(): void;
    startFlashForDamage(): void;
    showPicture(pictureId: number, name: string, origin: number, x: number, y: number,
        scaleX: number, scaleY: number, opacity: number, blendMode: number): void;
    movePicture(pictureId: number, origin: number, x: number, y: number,
        scaleX: number, scaleY: number, opacity: number, blendMode: number, duration: number): void;
    rotatePicture(pictureId: number, speed: number): void;
    tintPicture(pictureId: number, tone: Array<number>, duration: number): void;
    /**
     * Erases a picture from the screen given the respected picture id.
     * 
     * @param {number} pictureId 
     * @memberof Game_Screen
     */
    erasePicture(pictureId: number): void;
}

/**
 * The game object class for a picture.
 * 
 * @class Game_Picture
 */
declare class Game_Picture {
    /**
     * _name property of the current picture.
     * 
     * @protected
     * @type {string}
     * @memberof Game_Picture
     */
    protected _name: string;
    protected _origin: number;
    protected _x: number;
    protected _y: number;
    protected _scaleX: number;
    protected _scaleY: number;
    protected _opacity: number;
    protected _blendMode: number;

    protected _targetX: number;
    protected _targetY: number;
    protected _targetScaleX: number;
    protected _targetScaleY: number;
    protected _targetOpacity: number;
    protected _duration: number;

    protected _tone: Array<number>;
    protected _toneTarget: Array<number>;
    protected _toneDuration: number;

    protected _angle: number;
    protected _rotationSpeed: number;

    /**
     * Returns the name of the game picture.
     * 
     * @returns {string} 
     * @memberof Game_Picture
     */
    name(): string;
    /**
     * Returns the origin of the game picture.
     * 
     * @returns {number} 
     * @memberof Game_Picture
     */
    origin(): number;
    /**
     * Returns the picture x coordinate.
     * 
     * @returns {number} 
     * @memberof Game_Picture
     */
    x(): number;
    /**
     * Returns the picture y coordinate.
     * 
     * @returns {number} 
     * @memberof Game_Picture
     */
    y(): number;
    /**
     * Returns x scale of the game picture.
     * 
     * @returns {number} 
     * @memberof Game_Picture
     */
    scaleX(): number;
    /**
     * Returns the y scale of the game picture.
     * 
     * @returns {number} 
     * @memberof Game_Picture
     */
    scaleY(): number;
    /**
     * Returns the opacity of the game picture.
     * 
     * @returns {number} 
     * @memberof Game_Picture
     */
    opacity(): number;
    /**
     * Returns the blend mode of the game picture.
     * 
     * @returns {number} 
     * @memberof Game_Picture
     */
    blendMode(): number;
    /**
     * Returns the tone of the game picture.
     * 
     * @returns {Array<number>} 
     * @memberof Game_Picture
     */
    tone(): Array<number>;
    /**
     * Returns the angle of the game picture.
     * 
     * @returns {number} 
     * @memberof Game_Picture
     */
    angle(): number;
    initBasic(): void;
    initTarget(): void;
    initTone(): void;
    initRotation(): void;
    show(name: string, origin: number, x: number, y: number, scaleX: number, scaleY: number, opacity: number, blendMode: number): void;
    move(origin: number, x: number, y: number, scaleX: number, scaleY: number, opacity: number, blendMode: number, duration: number): void;
    rotate(speed: number): void;
    tint(tone: Array<number>, duration: number): void;
    /**
     * Erases the game picture.
     * 
     * @memberof Game_Picture
     */
    erase(): void;
    /**
     * Updates the game picture.
     * 
     * @memberof Game_Picture
     */
    update(): void;
    /**
     * Updates the movement of the game picture.
     * 
     * @memberof Game_Picture
     */
    updateMove(): void;
    /**
     * Updates the tone of the game picture.
     * 
     * @memberof Game_Picture
     */
    updateTone(): void;
    /**
     * Updates the rotation of the game picture.
     * 
     * @memberof Game_Picture
     */
    updateRotation(): void;
}

/**
 * Game_Item
 * The game object class for handling skills, items, weapons. armor.
 * This is required, because the save data should not include the database object itself.
 * @class Game_Item
 */
declare class Game_Item {
    protected _dataClass: string;
    protected _itemId: number;

    constructor(item: RPG.BaseItem);
    /**
     * Returns true the item is a skill.
     * 
     * @returns {boolean} 
     * @memberof Game_Item
     */
    isSkill(): boolean;
    /**
     * Returns true if the item is an item.
     * 
     * @returns {boolean} 
     * @memberof Game_Item
     */
    isItem(): boolean;
    /**
     * Returns true if the item is a usable item, similar to a potion.
     * 
     * @returns {boolean} 
     * @memberof Game_Item
     */
    isUsableItem(): boolean;
    /**
     * Returns true if the item is a weapon.
     * 
     * @returns {boolean} 
     * @memberof Game_Item
     */
    isWeapon(): boolean;
    /**
     * Returns true if the item is an armor.
     * 
     * @returns {boolean} 
     * @memberof Game_Item
     */
    isArmor(): boolean;
    /**
     * Returns true if the item can be equipped (weapon or armor).
     * 
     * @returns {boolean} 
     * @memberof Game_Item
     */
    isEquipItem(): boolean;
    /**
     * Returns true if the item is 'null'.
     * 
     * @returns {boolean} 
     * @memberof Game_Item
     */
    isNull(): boolean;
    /**
     * Returns the current itemId.
     * 
     * @returns {number} 
     * @memberof Game_Item
     */
    itemId(): number;
    object(): RPG.BaseItem;
    /**
     * Sets the current item of the current Game_Item object.
     * 
     * @param {RPG.BaseItem} item 
     * @memberof Game_Item
     */
    setObject(item: RPG.BaseItem): void;
    setEquip(isWeapon: boolean, itemId: number): void;
}

/**
 * Game_Action
 * The game object class representing a battle action.
 * @class Game_Action
 */
declare class Game_Action {
    static EFFECT_RECOVER_HP: number;
    static EFFECT_RECOVER_MP: number;
    static EFFECT_GAIN_TP: number;
    static EFFECT_ADD_STATE: number;
    static EFFECT_REMOVE_STATE: number;
    static EFFECT_ADD_BUFF: number;
    static EFFECT_ADD_DEBUFF: number;
    static EFFECT_REMOVE_BUFF: number;
    static EFFECT_REMOVE_DEBUFF: number;
    static EFFECT_SPECIAL: number;
    static EFFECT_GROW: number;
    static EFFECT_LEARN_SKILL: number;
    static EFFECT_COMMON_EVENT: number;
    static SPECIAL_EFFECT_ESCAPE: number;
    static HITTYPE_CERTAIN: number;
    static HITTYPE_PHYSICAL: number;
    static HITTYPE_MAGICAL: number;

    protected _subjectActorId: number;
    protected _subjectEnemyIndex: number;
    protected _targetIndex: number;
    protected _forcing: boolean;
    protected _item: Game_Item;

    constructor(subject: Game_Battler, forcing: boolean);

    clear(): void;
    setSubject(subject: Game_Battler): void;
    subject(): Game_Battler;
    friendsUnit(): Game_Unit;
    opponentsUnit(): Game_Unit;
    setEnemyAction(action: RPG.Enemy.Action): void;
    setAttack(): void;
    setGuard(): void;
    setSkill(skillId: number): void;
    setItem(itemId: number): void;
    setItemObject(object: RPG.UsableItem): void;
    setTarget(targetIndex: number): void;
    item(): RPG.UsableItem;
    isSkill(): boolean;
    isItem(): boolean;
    numRepeats(): number;
    checkItemScope(list: Array<number>): boolean;
    isForOpponent(): boolean;
    isForFriend(): boolean;
    isForDeadFriend(): boolean;
    isForUser(): boolean;
    isForOne(): boolean;
    isForRandom(): boolean;
    isForAll(): boolean;
    needsSelection(): boolean;
    numTargets(): number;
    checkDamageType(list: Array<number>): boolean;
    isHpEffect(): boolean;
    isMpEffect(): boolean;
    isDamage(): boolean;
    isRecover(): boolean;
    isDrain(): boolean;
    isHpRecover(): boolean;
    isMpRecover(): boolean;
    isCertainHit(): boolean;
    isPhysical(): boolean;
    isMagical(): boolean;
    isAttack(): boolean;
    isGuard(): boolean;
    isMagicSkill(): boolean;
    decideRandomTarget(): void;
    setConfusion(): void;
    prepare(): void;
    isValid(): boolean;
    speed(): number;
    makeTargets(): Array<Game_Battler>;
    repeatTargets(targets: Array<Game_Battler>): Array<Game_Battler>;
    confusionTarget(): Game_Battler;
    targetsForOpponents(): Array<Game_Battler>;
    targetsForFriends(): Array<Game_Battler>;
    evaluate(): number;
    itemTargetCandidates(): Array<Game_Battler>;
    evaluateWithTarget(target: Game_Battler): number;
    testApply(target: Game_Battler): boolean;
    hasItemAnyValidEffects(target: Game_Battler): boolean;
    testItemEffect(target: Game_Battler, effect: RPG.Effect): boolean;
    itemCnt(target: Game_Battler): number;
    itemMrf(target: Game_Battler): number;
    itemHit(target: Game_Battler): number;
    itemEva(target: Game_Battler): number;
    itemCri(target: Game_Battler): number;
    apply(target: Game_Battler): void;
    makeDamageValue(target: Game_Battler, critical: boolean): number;
    evalDamageFormula(target: Game_Battler): number;
    calcElementRate(target: Game_Battler): number;
    elementsMaxRate(target: Game_Battler, elements: Array<number>): number;
    applyCritical(damage: number): number;
    applyVariance(damage: number, variance: number): number;
    applyGuard(damage: number, target: Game_Battler): number;
    executeDamage(target: Game_Battler, value: number): void;
    executeHpDamage(target: Game_Battler, value: number): void;
    executeMpDamage(target: Game_Battler, value: number): void;
    gainDrainedHp(value: number): void;
    gainDrainedMp(value: number): void;
    applyItemEffect(target: Game_Battler, effect: RPG.Effect): void;
    itemEffectRecoverHp(target: Game_Battler, effect: RPG.Effect): void;
    itemEffectRecoverMp(target: Game_Battler, effect: RPG.Effect): void;
    itemEffectGainTp(target: Game_Battler, effect: RPG.Effect): void;
    itemEffectAddState(target: Game_Battler, effect: RPG.Effect): void;
    itemEffectAddAttackState(target: Game_Battler, effect: RPG.Effect): void;
    itemEffectAddNormalState(target: Game_Battler, effect: RPG.Effect): void;
    itemEffectRemoveState(target: Game_Battler, effect: RPG.Effect): void;
    itemEffectAddBuff(target: Game_Battler, effect: RPG.Effect): void;
    itemEffectAddDebuff(target: Game_Battler, effect: RPG.Effect): void;
    itemEffectRemoveBuff(target: Game_Battler, effect: RPG.Effect): void;
    itemEffectRemoveDebuff(target: Game_Battler, effect: RPG.Effect): void;
    itemEffectSpecial(target: Game_Battler, effect: RPG.Effect): void;
    itemEffectGrow(target: Game_Battler, effect: RPG.Effect): void;
    itemEffectLearnSkill(target: Game_Battler, effect: RPG.Effect): void;
    itemEffectCommonEvent(target: Game_Battler, effect: RPG.Effect): void;
    makeSuccess(target: Game_Battler): void;
    applyItemUserEffect(target: Game_Battler): void;
    lukEffectRate(target: Game_Battler): number;
    applyGlobal(): void;
}


/**
 * -----------------------------------------------------------------------------
 * Game_ActionResult
 *
 * The game object declare class for a result of a battle action. For convenience, all
 * member variables in this declare class are public.
 * @class Game_ActionResult
 */
declare class Game_ActionResult {
    used: boolean;
    missed: boolean;
    evaded: boolean;
    physical: boolean;
    drain: boolean;
    critical: boolean;
    success: boolean;
    hpAffected: boolean;
    hpDamage: number;
    mpDamage: number;
    tpDamage: number;
    addedStates: Array<number>;
    removedStates: Array<number>;
    addedBuffs: Array<number>;
    addedDebuffs: Array<number>;
    removedBuffs: Array<number>;

    /**
     * Clears the game action result.
     * 
     * @memberof Game_ActionResult
     */
    clear(): void;
    /**
     * Returns the added states from the action result.
     * 
     * @returns {Array<RPG.State>} 
     * @memberof Game_ActionResult
     */
    addedStateObjects(): Array<RPG.State>;
    /**
     * Returns the removes states from the result.
     * 
     * @returns {Array<RPG.State>} 
     * @memberof Game_ActionResult
     */
    removedStateObjects(): Array<RPG.State>;
    isStatusAffected(): boolean;
    /**
     * Returns true if the action result is a hit.
     * 
     * @returns {boolean} 
     * @memberof Game_ActionResult
     */
    isHit(): boolean;
    isStateAdded(stateId: number): boolean;
    pushAddedState(stateId: number): void;
    isStateRemoved(stateId: number): boolean;
    pushRemovedState(stateId: number): void;
    /**
     * Returns true if the a buff is added to the specified param
     * from the action result.
     * @param {number} paramId 
     * @returns {boolean} 
     * @memberof Game_ActionResult
     */
    isBuffAdded(paramId: number): boolean;
    pushAddedBuff(paramId: number): void;
    isDebuffAdded(paramId: number): boolean;
    pushAddedDebuff(paramId: number): void;
    isBuffRemoved(paramId: number): boolean;
    pushRemovedBuff(paramId: number): void;
}

/**
 * -----------------------------------------------------------------------------
 * Game_BattlerBase
 *
 * The superdeclare class of Game_Battler. It mainly contains parameters calculation.
 * @class Game_BattlerBase
 */
declare class Game_BattlerBase {
    static TRAIT_ELEMENT_RATE: number;
    static TRAIT_DEBUFF_RATE: number;
    static TRAIT_STATE_RATE: number;
    static TRAIT_STATE_RESIST: number;
    static TRAIT_PARAM: number;
    static TRAIT_XPARAM: number;
    static TRAIT_SPARAM: number;
    static TRAIT_ATTACK_ELEMENT: number;
    static TRAIT_ATTACK_STATE: number;
    static TRAIT_ATTACK_SPEED: number;
    static TRAIT_ATTACK_TIMES: number;
    static TRAIT_STYPE_ADD: number;
    static TRAIT_STYPE_SEAL: number;
    static TRAIT_SKILL_ADD: number;
    static TRAIT_SKILL_SEAL: number;
    static TRAIT_EQUIP_WTYPE: number;
    static TRAIT_EQUIP_ATYPE: number;
    static TRAIT_EQUIP_LOCK: number;
    static TRAIT_EQUIP_SEAL: number;
    static TRAIT_SLOT_TYPE: number;
    static TRAIT_ACTION_PLUS: number;
    static TRAIT_SPECIAL_FLAG: number;
    static TRAIT_COLLAPSE_TYPE: number;
    static TRAIT_PARTY_ABILITY: number;
    static FLAG_ID_AUTO_BATTLE: number;
    static FLAG_ID_GUARD: number;
    static FLAG_ID_SUBSTITUTE: number;
    static FLAG_ID_PRESERVE_TP: number;
    static ICON_BUFF_START: number;
    static ICON_DEBUFF_START: number;

    protected _hp: number;
    protected _mp: number;
    protected _tp: number;
    protected _hidden: boolean;

    protected _paramPlus: Array<number>;
    protected _states: Array<number>;
    protected _stateTurns: { [stateId: number]: number };
    protected _buffs: Array<number>;
    protected _buffTurns: Array<number>;

    /** [read-only] Hit Points */
    hp: number;
    /** [read-only] Magic Points */
    mp: number;
    /** [read-only] Tactical Points */
    tp: number;
    /** [read-only] Maximum Hit Points - param 0*/
    mhp: number;
    /** [read-only] Maximum Magic Points - param 1*/
    mmp: number;
    /** [read-only] ATtacK power - param 2*/
    atk: number;
    /** [read-only] DEFense power - param 3*/
    def: number;
    /** [read-only] Magic Attack power - param 4*/
    mat: number;
    /** [read-only] Magic Defense power - param 5*/
    mdf: number;
    /** [read-only] Agility - param 6 */
    agi: number;
    /** [read-only] LucK - param 7*/
    luk: number;
    /** [read-only] HIT rate -xparam 0*/
    hit: number;
    /** [read-only] EVAsion rate */
    eva: number;
    /** [read-only] CRItical rate */
    cri: number;
    /** [read-only] Critical EVasion rate */
    cev: number;
    /** [read-only] Magic EVasion rate */
    mev: number;
    /** [read-only] Magic ReFlection rate */
    mrf: number;
    /** [read-only] CouNTer attack rate */
    cnt: number;
    /** [read-only] Hp ReGeneration rate */
    hrg: number;
    /** [read-only] Mp ReGeneration rate */
    mrg: number;
    /** [read-only] Tp ReGeneration rate */
    trg: number;
    /** [read-only] TarGet Rate */
    tgr: number;
    /** [read-only] GuaRD effect rate */
    grd: number;
    /** [read-only] RECovery effect rate */
    rec: number;
    /** [read-only] PHArmacology */
    pha: number;
    /** [read-only] Mp Cost Rate */
    mcr: number;
    /** [read-only] Tp Charge Rate */
    tcr: number;
    /** [read-only] Physical Damage Rate */
    pdr: number;
    /** [read-only] Magical Damage Rate */
    mdr: number;
    /** [read-only] Floor Damage Rate */
    fdr: number;
    /** [read-only] EXperience Rate */
    exr: number;

    initMembers(): void;
    clearParamPlus(): void;
    clearStates(): void;
    /**
     * Erases the current state from the game battler given the 
     * stateId in the editor database.
     * @param {number} stateId 
     * @memberof Game_BattlerBase
     */
    eraseState(stateId: number): void;
    /**
     * Returns true if the battler is affected by the specified state given
     * the state id.
     * @param {number} stateId 
     * @returns {boolean} 
     * @memberof Game_BattlerBase
     */
    isStateAffected(stateId: number): boolean;
    isDeathStateAffected(): boolean;
    /**
     * Returns the death state id.
     * 
     * @returns {number} 
     * @memberof Game_BattlerBase
     */
    deathStateId(): number;
    /**
     * Resets the state count of the specified state, given the state id.
     * 
     * @param {number} stateId 
     * @memberof Game_BattlerBase
     */
    resetStateCounts(stateId: number): void;
    /**
     * Returns true if the state, given the state id is expired.
     * 
     * @param {number} stateId 
     * @returns {boolean} 
     * @memberof Game_BattlerBase
     */
    isStateExpired(stateId: number): boolean;
    updateStateTurns(): void;
    /**
     * Clears buffs from the battler.
     * 
     * @memberof Game_BattlerBase
     */
    clearBuffs(): void;
    eraseBuff(paramId: number): void;
    /**
     * Returns the length of the buff.
     * 
     * @returns {number} 
     * @memberof Game_BattlerBase
     */
    buffLength(): number;
    /**
     * Buffs the current parameter id.
     * 
     * @param {number} paramId 
     * @returns {number} 
     * @memberof Game_BattlerBase
     */
    buff(paramId: number): number;
    isBuffAffected(paramId: number): boolean;
    isDebuffAffected(paramId: number): boolean;
    isBuffOrDebuffAffected(paramId: number): boolean;
    isMaxBuffAffected(paramId: number): boolean;
    isMaxDebuffAffected(paramId: number): boolean;
    increaseBuff(paramId: number): void;
    decreaseBuff(paramId: number): void;
    overwriteBuffTurns(paramId: number, turns: number): void;
    isBuffExpired(paramId: number): boolean;
    /**
     * Updates the buff turns on battler.
     * 
     * @memberof Game_BattlerBase
     */
    updateBuffTurns(): void;
    /**
     * Kills the battler.
     * 
     * @memberof Game_BattlerBase
     */
    die(): void;
    /**
     * Revives the battler.
     * 
     * @memberof Game_BattlerBase
     */
    revive(): void;
    /**
     * Returns the states applied to the battler.
     * 
     * @returns {Array<RPG.State>} 
     * @memberof Game_BattlerBase
     */
    states(): Array<RPG.State>;
    /**
     * Returns the array of state icons attached to the battler;
     * this is determined by the active states on the battler.
     * @returns {Array<number>} 
     * @memberof Game_BattlerBase
     */
    stateIcons(): Array<number>;
    /**
     * Returns the array of buff icons attached to the battler;
     * this is determined by the active buffs on the battler.
     * @returns {Array<number>} 
     * @memberof Game_BattlerBase
     */
    buffIcons(): Array<number>;
    buffIconIndex(buffLevel: number, paramId: number): number;
    /**
     * Returns all of the icons attached to the battler.
     * 
     * @returns {Array<number>} 
     * @memberof Game_BattlerBase
     */
    allIcons(): Array<number>;
    traitObjects(): Array<any>;
    /**
     * Returns all the traits of the battler.
     * 
     * @returns {Array<RPG.Trait>} 
     * @memberof Game_BattlerBase
     */
    allTraits(): Array<RPG.Trait>;
    traits(code: number): Array<RPG.Trait>;
    traitsWithId(code: number, id: number): Array<RPG.Trait>;
    traitsPi(code: number, id: number): number;
    traitsSum(code: number, id: number): number;
    traitsSumAll(code: number): number;
    traitsSet(code: number): Array<number>;
    /**
     * Returns the base parameters of the battler; this is determined by their
     * current level and the paramId given.
     * @param {number} paramId 
     * @returns {number} 
     * @memberof Game_BattlerBase
     */
    paramBase(paramId: number): number;
    paramPlus(paramId: number): number;
    paramMin(paramId: number): number;
    paramMax(paramId: number): number;
    paramRate(paramId: number): number;
    paramBuffRate(paramId: number): number;
    /**
     * Returns a standard parameter, given a paramId;
     * standard parameters include: HP, MP, Atk, M.Atk, Def, M.Def, Luck, Agility.
     * @param {number} paramId 
     * @returns {number} 
     * @memberof Game_BattlerBase
     */
    param(paramId: number): number;
    xparam(xparamId: number): number;
    sparam(sparamId: number): number;
    elementRate(elementId: number): number;
    debuffRate(paramId: number): number;
    stateRate(stateId: number): number;
    stateResistSet(): Array<number>;
    isStateResist(stateId: number): boolean;
    /**
     * Returns the attack elements of the battler
     * as a list of numbers.
     * @returns {Array<number>} 
     * @memberof Game_BattlerBase
     */
    attackElements(): Array<number>;
    /**
     * Returns the attack states of the battler as a
     * list of numbers.
     * @returns {Array<number>} 
     * @memberof Game_BattlerBase
     */
    attackStates(): Array<number>;
    attackStatesRate(stateId: number): void;
    /**
     * Returns the attack speed of the battler.
     * 
     * @returns {number} 
     * @memberof Game_BattlerBase
     */
    attackSpeed(): number;
    /**
     * Returns the number of attacks available to the battler.
     * 
     * @returns {number} 
     * @memberof Game_BattlerBase
     */
    attackTimesAdd(): number;
    addedSkillTypes(): Array<number>;
    isSkillTypeSealed(stypeId: number): boolean;
    addedSkills(): Array<number>;
    isSkillSealed(skillId: number): boolean;
    isEquipWtypeOk(wtypeId: number): boolean;
    isEquipAtypeOk(atypeId: number): boolean;
    isEquipTypeLocked(etypeId: number): boolean;
    isEquipTypeSealed(etypeId: number): boolean;
    /**
     * Returns the battler slot type of a trait.
     * 
     * @returns {number} 
     * @memberof Game_BattlerBase
     */
    slotType(): number;
    /**
     * Returns true if the battler dual wields.
     * 
     * @returns {boolean} 
     * @memberof Game_BattlerBase
     */
    isDualWield(): boolean;
    actionPlusSet(): Array<number>;
    specialFlag(flagId: number): boolean;
    /**
     * Returns the collapse type of the battler.
     * 
     * @returns {number} 
     * @memberof Game_BattlerBase
     */
    collapseType(): number;
    partyAbility(abilityId: number): boolean;
    /**
     * Returns true if the battler is set to battle automatically.
     * 
     * @returns {boolean} 
     * @memberof Game_BattlerBase
     */
    isAutoBattle(): boolean;
    /**
     * Returns true if the battler is guarding.
     * 
     * @returns {boolean} 
     * @memberof Game_BattlerBase
     */
    isGuard(): boolean;
    isSubstitute(): boolean;
    /**
     * Returns true if tp is preserved between battles.
     * 
     * @returns {boolean} 
     * @memberof Game_BattlerBase
     */
    isPreserveTp(): boolean;
    addParam(paramId: number, value: number): void;
    /**
     * Sets the battler hp.
     * 
     * @param {number} hp 
     * @memberof Game_BattlerBase
     */
    setHp(hp: number): void;
    /**
     * Sets the battler mp.
     * 
     * @param {number} mp 
     * @memberof Game_BattlerBase
     */
    setMp(mp: number): void;
    /**
     * Sets the battler tp.
     * 
     * @param {number} tp 
     * @memberof Game_BattlerBase
     */
    setTp(tp: number): void;
    /**
     * Returns the maximum tp of the battler.
     * 
     * @returns {number} 
     * @memberof Game_BattlerBase
     */
    maxTp(): number;
    /**
     * Refreshes the battler.
     * 
     * @memberof Game_BattlerBase
     */
    refresh(): void;
    /**
     * Recovers the battler from all states and restores the
     * battler to maximum hp and mp.
     * @memberof Game_BattlerBase
     */
    recoverAll(): void;
    /**
     * Returns the percentage of the battler's hp left as a float.
     * 
     * @returns {number} 
     * @memberof Game_BattlerBase
     */
    hpRate(): number;
    /**
     * Returns the percentage of the battler's mp left as a float.
     * 
     * @returns {number} 
     * @memberof Game_BattlerBase
     */
    mpRate(): number;
    /**
     * Returns the percentage of the battler's tp left as a float.
     * 
     * @returns {number} 
     * @memberof Game_BattlerBase
     */
    tpRate(): number;
    /**
     * Hides the game battler.
     * 
     * @memberof Game_BattlerBase
     */
    hide(): void;
    /**
     * Shows the game battler.
     * 
     * @memberof Game_BattlerBase
     */
    appear(): void;
    /**
     * Returns true if the game battler is hidden.
     * 
     * @returns {boolean} 
     * @memberof Game_BattlerBase
     */
    isHidden(): boolean;
    /**
     * Returns true if the game battler is not hidden.
     * 
     * @returns {boolean} 
     * @memberof Game_BattlerBase
     */
    isAppeared(): boolean;
    /**
     * Returns true if the battler is dead.
     * 
     * @returns {boolean} 
     * @memberof Game_BattlerBase
     */
    isDead(): boolean;
    /**
     * Returns true if the battler is alive.
     * 
     * @returns {boolean} 
     * @memberof Game_BattlerBase
     */
    isAlive(): boolean;
    /**
     * Returns true if the battler is dying.
     * 
     * @returns {boolean} 
     * @memberof Game_BattlerBase
     */
    isDying(): boolean;
    /**
     * Returns true if the game battler is restricted.
     * 
     * @returns {boolean} 
     * @memberof Game_BattlerBase
     */
    isRestricted(): boolean;
    /**
     * Returns true if the battler can input actions.
     * 
     * @returns {boolean} 
     * @memberof Game_BattlerBase
     */
    canInput(): boolean;
    canMove(): boolean;
    /**
     * Returns true if the battler is confused.
     * 
     * @returns {boolean} 
     * @memberof Game_BattlerBase
     */
    isConfused(): boolean;
    /**
     * Returns the confusion level of the battler.
     * 
     * @returns {number} 
     * @memberof Game_BattlerBase
     */
    confusionLevel(): number;
    /**
     * Returns true if the battler is an actor.
     * 
     * @returns {boolean} 
     * @memberof Game_BattlerBase
     */
    isActor(): boolean;
    /**
     * Returns true if the battler is an enemy.
     * 
     * @returns {boolean} 
     * @memberof Game_BattlerBase
     */
    isEnemy(): boolean;
    /**
     * Sorts the states attached to the battler.
     * 
     * @memberof Game_BattlerBase
     */
    sortStates(): void;
    /**
     * Returns the number of the restriction.
     * 
     * @returns {number} 
     * @memberof Game_BattlerBase
     */
    restriction(): number;
    /**
     * Adds a new state given a state id to the battler.
     * 
     * @param {number} stateId 
     * @memberof Game_BattlerBase
     */
    addNewState(stateId: number): void;
    /**
     * Handler for when the battler is restricted.
     * 
     * @memberof Game_BattlerBase
     */
    onRestrict(): void;
    mostImportantStateText(): string;
    stateMotionIndex(): number;
    stateOverlayIndex(): number;
    /**
     * Returns true if the skill is a weapon type
     * oriented skill.
     * @param {RPG.Skill} skill 
     * @returns {boolean} 
     * @memberof Game_BattlerBase
     */
    isSkillWtypeOk(skill: RPG.Skill): boolean;
    /**
     * Returns the mp cost of the skill.
     * 
     * @param {RPG.Skill} skill 
     * @returns {number} 
     * @memberof Game_BattlerBase
     */
    skillMpCost(skill: RPG.Skill): number;
    /**
     * Returns the tp cost of the skill.
     * 
     * @param {RPG.Skill} skill 
     * @returns {number} 
     * @memberof Game_BattlerBase
     */
    skillTpCost(skill: RPG.Skill): number;
    /**
     * Returns true if the battler can pay the cost
     * of the specified skill.
     * @param {RPG.Skill} skill 
     * @returns {boolean} 
     * @memberof Game_BattlerBase
     */
    canPaySkillCost(skill: RPG.Skill): boolean;
    /**
     * Pays the cost of the skill when activating the skill.
     * 
     * @param {RPG.Skill} skill 
     * @memberof Game_BattlerBase
     */
    paySkillCost(skill: RPG.Skill): void;
    /**
     * Returns true if the item occasion is okay.
     * 
     * @param {RPG.UsableItem} item 
     * @returns {boolean} 
     * @memberof Game_BattlerBase
     */
    isOccasionOk(item: RPG.UsableItem): boolean;
    meetsUsableItemConditions(item: RPG.UsableItem): boolean;
    /**
     * Returns true if the battler meets the skill conditions.
     * 
     * @param {RPG.Skill} skill 
     * @returns {boolean} 
     * @memberof Game_BattlerBase
     */
    meetsSkillConditions(skill: RPG.Skill): boolean;
    /**
     * Returns true if the battler meets the item conditions.
     * 
     * @param {RPG.Item} item 
     * @returns {boolean} 
     * @memberof Game_BattlerBase
     */
    meetsItemConditions(item: RPG.Item): boolean;
    /**
     * Returns true if the battler can use the item.
     * 
     * @param {RPG.UsableItem} item 
     * @returns {boolean} 
     * @memberof Game_BattlerBase
     */
    canUse(item: RPG.UsableItem): boolean;
    /**
     * Returns true if the battler can equip the item.
     * 
     * @param {RPG.EquipItem} item 
     * @returns {boolean} 
     * @memberof Game_BattlerBase
     */
    canEquip(item: RPG.EquipItem): boolean;
    /**
     * Returns true if the battler can equip a weapon.
     * 
     * @param {RPG.EquipItem} item 
     * @returns {boolean} 
     * @memberof Game_BattlerBase
     */
    canEquipWeapon(item: RPG.EquipItem): boolean;
    /**
     * Returns true if the battler can equip armor.
     * 
     * @param {RPG.EquipItem} item 
     * @returns {boolean} 
     * @memberof Game_BattlerBase
     */
    canEquipArmor(item: RPG.EquipItem): boolean;
    /**
     * Returns the attack skill id in the database.
     * 
     * @returns {number} 
     * @memberof Game_BattlerBase
     */
    attackSkillId(): number;
    /**
     * Returns the guard skill id in the database.
     * 
     * @returns {number} 
     * @memberof Game_BattlerBase
     */
    guardSkillId(): number;
    /**
     * Returns true if the battler can attack.
     * 
     * @returns {boolean} 
     * @memberof Game_BattlerBase
     */
    canAttack(): boolean;
    /**
     * Returns true if the battler can guard.
     * 
     * @returns {boolean} 
     * @memberof Game_BattlerBase
     */
    canGuard(): boolean;
}

/**
 * -----------------------------------------------------------------------------
 * Game_Battler
 *
 * The superdeclare class of Game_Actor and Game_Enemy. It contains methods for sprites
 * and actions.
 * @class Game_Battler
 */
declare class Game_Battler extends Game_BattlerBase {
    protected _actions: Array<Game_Action>;
    protected _speed: number;
    protected _result: Game_ActionResult;
    protected _actionState: string;
    protected _lastTargetIndex: number;
    protected _animations: Array<MV.BattlerAnimation>;
    protected _damagePopup: boolean;
    protected _effectType: string;
    protected _motionType: string;
    protected _weaponImageId: number;
    protected _motionRefresh: boolean;
    protected _selected: boolean;

    /**
     * Returns the name of the battler.
     * 
     * @returns {string} 
     * @memberof Game_Battler
     */
    name(): string;
    /**
     * Returns the battler name of the battler;
     * the battler name is associated with the file used as the battler graphic.
     * @returns {string} 
     * @memberof Game_Battler
     */
    battlerName(): string;
    /**
     * Returns the index of the battler.
     * 
     * @returns {number} 
     * @memberof Game_Battler
     */
    index(): number;
    /**
     * Returns the unit of the battler; this is either the 
     * game party or game troop.
     * @returns {Game_Unit} 
     * @memberof Game_Battler
     */
    friendsUnit(): Game_Unit;
    /**
     * Returns the opponents unit; this is either
     * game party or game troop.
     * @returns {Game_Unit} 
     * @memberof Game_Battler
     */
    opponentsUnit(): Game_Unit;
    /**
     * Clears animations from the battler.
     * 
     * @memberof Game_Battler
     */
    clearAnimations(): void;
    /**
     * Clear damage pop up from the battler.
     * 
     * @memberof Game_Battler
     */
    clearDamagePopup(): void;
    /**
     * Clear weapon animation from the battler.
     * 
     * @memberof Game_Battler
     */
    clearWeaponAnimation(): void;
    /**
     * Clears effect from the battler.
     * 
     * @memberof Game_Battler
     */
    clearEffect(): void;
    /**
     * Clears motion from the battler.
     * 
     * @memberof Game_Battler
     */
    clearMotion(): void;
    requestEffect(effectType: string): void;
    /**
     * Request the specified motion on the game battler.
     * 
     * @param {string} motionType 
     * @memberof Game_Battler
     */
    requestMotion(motionType: string): void;
    requestMotionRefresh(): void;
    select(): void;
    deselect(): void;
    isAnimationRequested(): boolean;
    isDamagePopupRequested(): boolean;
    isEffectRequested(): boolean;
    /**
     * Returns true if a motion is requested.
     * 
     * @returns {boolean} 
     * @memberof Game_Battler
     */
    isMotionRequested(): boolean;
    /**
     * Returns true if a weapon animation is requested.
     * 
     * @returns {boolean} 
     * @memberof Game_Battler
     */
    isWeaponAnimationRequested(): boolean;
    isMotionRefreshRequested(): boolean;
    isSelected(): boolean;
    /**
     * Returns the effect type of the battler.
     * 
     * @returns {string} 
     * @memberof Game_Battler
     */
    effectType(): string;
    /**
     * Returns the motion type of the battler.
     * 
     * @returns {string} 
     * @memberof Game_Battler
     */
    motionType(): string;
    /**
     * Returns the weapon image id.
     * 
     * @returns {number} 
     * @memberof Game_Battler
     */
    weaponImageId(): number;
    /**
     * Shifts the battler animation.
     * 
     * @returns {MV.BattlerAnimation} 
     * @memberof Game_Battler
     */
    shiftAnimation(): MV.BattlerAnimation;
    /**
     * Starts the specified animation, given the animation id on the
     * battler.
     * @param {number} animationId 
     * @param {boolean} mirror 
     * @param {number} delay 
     * @memberof Game_Battler
     */
    startAnimation(animationId: number, mirror: boolean, delay: number): void;
    /**
     * Starts a damage pop up on the battler.
     * 
     * @memberof Game_Battler
     */
    startDamagePopup(): void;
    /**
     * Starts the weapon animation on te battler given a weapon id.
     * 
     * @param {number} weaponImageId 
     * @memberof Game_Battler
     */
    startWeaponAnimation(weaponImageId: number): void;
    action(index: number): Game_Action;
    /**
     * Sets the action at the specified index for the battler.
     * 
     * @param {number} index 
     * @param {Game_Action} action 
     * @memberof Game_Battler
     */
    setAction(index: number, action: Game_Action): void;
    /**
     * Returns the number of battler actions.
     * 
     * @returns {number} 
     * @memberof Game_Battler
     */
    numActions(): number;
    /**
     * Clears the battler actions.
     * 
     * @memberof Game_Battler
     */
    clearActions(): void;
    /**
     * Returns the battler action result.
     * 
     * @returns {Game_ActionResult} 
     * @memberof Game_Battler
     */
    result(): Game_ActionResult;
    /**
     * Clears the battler action result.
     * 
     * @memberof Game_Battler
     */
    clearResult(): void;
    /**
     * Refreshes the battler.
     * 
     * @memberof Game_Battler
     */
    refresh(): void;
    /**
     * Adds a state to the battler given the specified
     * state id.
     * @param {number} stateId 
     * @memberof Game_Battler
     */
    addState(stateId: number): void;
    /**
     * Returns true if the specified state given the state id
     * is addable.
     * @param {number} stateId 
     * @returns {boolean} 
     * @memberof Game_Battler
     */
    isStateAddable(stateId: number): boolean;
    /**
     * Returns true if the specified state given the state id
     * restricts.
     * 
     * @param {number} stateId 
     * @returns {boolean} 
     * @memberof Game_Battler
     */
    isStateRestrict(stateId: number): boolean;
    /**
     * Handler for when the battler is restricted.
     * 
     * @memberof Game_Battler
     */
    onRestrict(): void;
    /**
     * Removes the specified state given the state id.
     * 
     * @param {number} stateId 
     * @memberof Game_Battler
     */
    removeState(stateId: number): void;
    /**
     * Has the battler escape from battle; plays a sound on escaping.
     * 
     * @memberof Game_Battler
     */
    escape(): void;
    /**
     * Adds a buff to the battler for the specified number of turns
     * on the selected parameter.
     * @param {number} paramId 
     * @param {number} turns 
     * @memberof Game_Battler
     */
    addBuff(paramId: number, turns: number): void;
    /**
     * Adds a debuff to the battler for the specified number of turns
     * on the selected parameter.
     * @param {number} paramId 
     * @param {number} turns 
     * @memberof Game_Battler
     */
    addDebuff(paramId: number, turns: number): void;
    removeBuff(paramId: number): void;
    removeBattleStates(): void;
    /**
     * Removes all buffs from the battler.
     * 
     * @memberof Game_Battler
     */
    removeAllBuffs(): void;
    removeStatesAuto(timing: number): void;
    removeBuffsAuto(): void;
    removeStatesByDamage(): void;
    /**
     * Creates the number of times for
     * an action.
     * @returns {number} 
     * @memberof Game_Battler
     */
    makeActionTimes(): number;
    /**
     * Creates the actions for the battler.
     * 
     * @memberof Game_Battler
     */
    makeActions(): void;
    /**
     * Returns the speed of the battler.
     * 
     * @returns {number} 
     * @memberof Game_Battler
     */
    speed(): number;
    /**
     * Calculates the speed of the battler.
     * 
     * @memberof Game_Battler
     */
    makeSpeed(): void;
    /**
     * Returns the current action of the battler.
     * 
     * @returns {Game_Action} 
     * @memberof Game_Battler
     */
    currentAction(): Game_Action;
    /**
     * Removes the current battler action.
     * 
     * @memberof Game_Battler
     */
    removeCurrentAction(): void;
    setLastTarget(target: Game_Battler): void;
    forceAction(skillId: number, targetIndex: number): void;
    /**
     * Has the battler use the given item.
     * 
     * @param {RPG.UsableItem} item 
     * @memberof Game_Battler
     */
    useItem(item: RPG.UsableItem): void;
    /**
     * Has the battler consume the given item.
     * 
     * @param {RPG.UsableItem} item 
     * @memberof Game_Battler
     */
    consumeItem(item: RPG.UsableItem): void;
    /**
     * Adds the specified amount of hp to the battler.
     * 
     * @param {number} value 
     * @memberof Game_Battler
     */
    gainHp(value: number): void;
    /**
     * Adds the specified amount of mp to the battler.
     * 
     * @param {number} value 
     * @memberof Game_Battler
     */
    gainMp(value: number): void;
    /**
     * Adds the specified amount of tp to the battler.
     * 
     * @param {number} value 
     * @memberof Game_Battler
     */
    gainTp(value: number): void;
    /**
     * Adds a specified amount of tp to the battler silently.
     * 
     * @param {number} value 
     * @memberof Game_Battler
     */
    gainSilentTp(value: number): void;
    /**
     * Initializes the battler's tp; tp is random.
     * 
     * @memberof Game_Battler
     */
    initTp(): void;
    /**
     * Clears the battler's tp.
     * 
     * @memberof Game_Battler
     */
    clearTp(): void;
    chargeTpByDamage(damageRate: number): void;
    /**
     * Has the battler regenerate hp based on their hp regen.
     * 
     * @memberof Game_Battler
     */
    regenerateHp(): void;
    maxSlipDamage(): number;
    /**
     * Has the battler regenerate mp based on their mp regen.
     * 
     * @memberof Game_Battler
     */
    regenerateMp(): void;
    /**
     * Has the battler regenerate tp based on their tp regen.
     * 
     * @memberof Game_Battler
     */
    regenerateTp(): void;
    /**
     * Has the battler regenerate all resources based on
     * their respective regeneration stats.
     * @memberof Game_Battler
     */
    regenerateAll(): void;
    /**
     * Handler for when battle has started.
     * 
     * @memberof Game_Battler
     */
    onBattleStart(): void;
    onAllActionsEnd(): void;
    onTurnEnd(): void;
    onBattleEnd(): void;
    onDamage(value: number): void;
    setActionState(actionState: string): void;
    isUndecided(): boolean;
    /**
     * Returns true if the battler is inputting commands in battle.
     * 
     * @returns {boolean} 
     * @memberof Game_Battler
     */
    isInputting(): boolean;
    /**
     * Returns true if the battler is waiting in battle.
     * 
     * @returns {boolean} 
     * @memberof Game_Battler
     */
    isWaiting(): boolean;
    /**
     * Returns true if the battler is performing an action in battle.
     * 
     * @returns {boolean} 
     * @memberof Game_Battler
     */
    isActing(): boolean;
    /**
     * Returns true if the battler is chanting in combat.
     * 
     * @returns {boolean} 
     * @memberof Game_Battler
     */
    isChanting(): boolean;
    /**
     * Returns true if the battler is waiting to guard.
     * 
     * @returns {boolean} 
     * @memberof Game_Battler
     */
    isGuardWaiting(): boolean;
    /**
     * Perform action start motion, given the specified game action.
     * 
     * @param {Game_Action} action 
     * @memberof Game_Battler
     */
    performActionStart(action: Game_Action): void;
    /**
     * Perform given action motion.
     * 
     * @param {Game_Action} action 
     * @memberof Game_Battler
     */
    performAction(action: Game_Action): void;
    /**
     * Perform action end motion.
     * 
     * @memberof Game_Battler
     */
    performActionEnd(): void;
    /**
     * Perform damage motion.
     * 
     * @memberof Game_Battler
     */
    performDamage(): void;
    /**
     * Perform miss motion.
     * 
     * @memberof Game_Battler
     */
    performMiss(): void;
    /**
     * Perform recovery motion.
     * 
     * @memberof Game_Battler
     */
    performRecovery(): void;
    /**
     * Perform evasion motion.
     * 
     * @memberof Game_Battler
     */
    performEvasion(): void;
    /**
     * Perform magic evasion motion.
     * 
     * @memberof Game_Battler
     */
    performMagicEvasion(): void;
    /**
     * Perform counter motion.
     * 
     * @memberof Game_Battler
     */
    performCounter(): void;
    /**
     * Performs the reflect motion.
     * 
     * @memberof Game_Battler
     */
    performReflection(): void;
    /**
     * Perform substitute motion with the specified game battler.
     * 
     * @param {Game_Battler} target 
     * @memberof Game_Battler
     */
    performSubstitute(target: Game_Battler): void;
    /**
     * Performs the collapse motion.
     * 
     * @memberof Game_Battler
     */
    performCollapse(): void;
}

/**
 * -----------------------------------------------------------------------------
 * Game_Actor
 *
 * The game object declare class for an actor.
 * @class Game_Actor
 */
declare class Game_Actor extends Game_Battler {
    protected _actorId: number;
    protected _name: string;
    protected _nickname: string;
    protected _profile: string;
    protected _classId: number;
    protected _level: number;
    protected _characterName: string;
    protected _characterIndex: number;
    protected _faceName: string;
    protected _faceIndex: number;
    protected _battlerName: string;
    protected _exp: { [classId: number]: number };
    protected _skills: Array<number>;
    protected _equips: Array<Game_Item>;
    protected _actionInputIndex: number;
    protected _lastMenuSkill: Game_Item;
    protected _lastBattleSkill: Game_Item;
    protected _lastCommandSymbol: string;
    protected _stateSteps: { [stateId: number]: number };

    /** [read-only] */
    level: number;

    constructor(actorId: number);

    setup(actorId: number): void;
    /**
     * Returns the id of the actor.
     * 
     * @returns {number} 
     * @memberof Game_Actor
     */
    actorId(): number;
    /**
     * Returns the database information of the actor.
     * 
     * @returns {RPG.Actor} 
     * @memberof Game_Actor
     */
    actor(): RPG.Actor;
    /**
     * Sets the actor name.
     * 
     * @param {string} name 
     * @memberof Game_Actor
     */
    setName(name: string): void;
    /**
     * Returns the nickname of the actor.
     * 
     * @returns {string} 
     * @memberof Game_Actor
     */
    nickname(): string;
    /**
     * Sets the nickname of the actor.
     * 
     * @param {string} nickname 
     * @memberof Game_Actor
     */
    setNickname(nickname: string): void;
    /**
     * Returns the actor profile.
     * 
     * @returns {string} 
     * @memberof Game_Actor
     */
    profile(): string;
    /**
     * Sets the actor profile.
     * 
     * @param {string} profile 
     * @memberof Game_Actor
     */
    setProfile(profile: string): void;
    /**
     * Returns the face name of the actor; this is
     * the image of faces for the actor.
     * @returns {string} 
     * @memberof Game_Actor
     */
    faceName(): string;
    /**
     * Returns the face index of the actor.
     * 
     * @returns {number} 
     * @memberof Game_Actor
     */
    faceIndex(): number;
    /**
     * Clears all states from the actor.
     * 
     * @memberof Game_Actor
     */
    clearStates(): void;
    /**
     * Erase the specified state from the actor.
     * 
     * @param {number} stateId 
     * @memberof Game_Actor
     */
    eraseState(stateId: number): void;
    /**
     * Reset state count of the specified state.
     * 
     * @param {number} stateId 
     * @memberof Game_Actor
     */
    resetStateCounts(stateId: number): void;
    /**
     * Initialize images of the actor.
     * 
     * @memberof Game_Actor
     */
    initImages(): void;
    /**
     * Returns the exp required to level.
     * 
     * @param {number} level 
     * @returns {number} 
     * @memberof Game_Actor
     */
    expForLevel(level: number): number;
    /**
     * Initialize exp of the actor.
     * 
     * @memberof Game_Actor
     */
    initExp(): void;
    /**
     * Returns the current experience points of the actor.
     * 
     * @returns {number} 
     * @memberof Game_Actor
     */
    currentExp(): number;
    /**
     * Returns the current level's experience for the actor.
     * 
     * @returns {number} 
     * @memberof Game_Actor
     */
    currentLevelExp(): number;
    /**
     * Returns the experience points for the next level of the actor.
     * 
     * @returns {number} 
     * @memberof Game_Actor
     */
    nextLevelExp(): number;
    /**
     * Returns the next required experience points for the actor to level up.
     * 
     * @returns {number} 
     * @memberof Game_Actor
     */
    nextRequiredExp(): number;
    /**
     * Returns the maximum level of the actor.
     * 
     * @memberof Game_Actor
     */
    maxLevel(): void;
    /**
     * Returns true if the actor is max level.
     * 
     * @returns {boolean} 
     * @memberof Game_Actor
     */
    isMaxLevel(): boolean;
    /**
     * Initialize actor skills.
     * 
     * @memberof Game_Actor
     */
    initSkills(): void;
    /**
     * Initialize actor equipment in the given slots.
     * 
     * @param {Array<number>} equips 
     * @memberof Game_Actor
     */
    initEquips(equips: Array<number>): void;
    /**
     * Returns the equip slots of the actor.
     * 
     * @returns {Array<number>} 
     * @memberof Game_Actor
     */
    equipSlots(): Array<number>;
    /**
     * Returns the equipment of the actor.
     * 
     * @returns {Array<RPG.EquipItem>} 
     * @memberof Game_Actor
     */
    equips(): Array<RPG.EquipItem>;
    /**
     * Returns the weapon of the actor.
     * 
     * @returns {Array<RPG.Weapon>} 
     * @memberof Game_Actor
     */
    weapons(): Array<RPG.Weapon>;
    /**
     * Returns the armor of the actor.
     * 
     * @returns {Array<RPG.Armor>} 
     * @memberof Game_Actor
     */
    armors(): Array<RPG.Armor>;
    /**
     * Returns true if the actor has a weapon.
     * 
     * @param {RPG.Weapon} weapon 
     * @returns {boolean} 
     * @memberof Game_Actor
     */
    hasWeapon(weapon: RPG.Weapon): boolean;
    /**
     * Returns true if the actor has armor.
     * 
     * @param {RPG.Armor} armor 
     * @returns {boolean} 
     * @memberof Game_Actor
     */
    hasArmor(armor: RPG.Armor): boolean;
    /**
     * Returns true if the equip change is okay in the given slot.
     * 
     * @param {number} slotId 
     * @returns {boolean} 
     * @memberof Game_Actor
     */
    isEquipChangeOk(slotId: number): boolean;
    /**
     * Changes the actor equipment in the given slot with the
     * given equip item. Places the original item into the party
     * inventory.
     * @param {number} slotId 
     * @param {RPG.EquipItem} item 
     * @memberof Game_Actor
     */
    changeEquip(slotId: number, item: RPG.EquipItem): void;
    /**
     * Forces the actor to change equipment in the given slot
     * with the given equip item without placing the item back into
     * the party inventory.
     * @param {number} slotId 
     * @param {RPG.EquipItem} item 
     * @memberof Game_Actor
     */
    forceChangeEquip(slotId: number, item: RPG.EquipItem): void;
    /**
     * Trades the new item with the old item in the party inventory.
     * 
     * @param {RPG.EquipItem} newItem 
     * @param {RPG.EquipItem} oldItem 
     * @returns {boolean} 
     * @memberof Game_Actor
     */
    tradeItemWithParty(newItem: RPG.EquipItem, oldItem: RPG.EquipItem): boolean;
    /**
     * Changes the actor equip with an item based on the equip id.
     * 
     * @param {number} etypeId 
     * @param {number} itemId 
     * @memberof Game_Actor
     */
    changeEquipById(etypeId: number, itemId: number): void;
    /**
     * Returns true if the actor is equipped with the specific item.
     * 
     * @param {RPG.EquipItem} item 
     * @returns {boolean} 
     * @memberof Game_Actor
     */
    isEquipped(item: RPG.EquipItem): boolean;
    /**
     * Discards the given equip item from the actor; item
     * is not return to the party inventory.
     * @param {RPG.EquipItem} item 
     * @memberof Game_Actor
     */
    discardEquip(item: RPG.EquipItem): void;
    /**
     * Returns items the actor can't normally equip to the party inventory.
     * 
     * @param {boolean} forcing 
     * @memberof Game_Actor
     */
    releaseUnequippableItems(forcing: boolean): void;
    /**
     * Clears the actor's equipment; items are returned to the inventory.
     * 
     * @memberof Game_Actor
     */
    clearEquipments(): void;
    /**
     * Optimize the actor's equipment.
     * 
     * @memberof Game_Actor
     */
    optimizeEquipments(): void;
    /**
     * Equips the best item in the given slot.
     * 
     * @param {number} slotId 
     * @memberof Game_Actor
     */
    bestEquipItem(slotId: number): void;
    /**
     * Calculates the equip item performance and returns the sum/difference.
     * 
     * @param {RPG.EquipItem} item 
     * @returns {number} 
     * @memberof Game_Actor
     */
    calcEquipItemPerformance(item: RPG.EquipItem): number;
    isSkillWtypeOk(skill: RPG.Skill): boolean;
    isWtypeEquipped(wtypeId: number): boolean;
    /**
     * Refreshes the actor.
     * 
     * @memberof Game_Actor
     */
    refresh(): void;
    friendsUnit(): Game_Party;
    opponentsUnit(): Game_Troop;
    /**
     * Returns true if the actor is a member in battle.
     * 
     * @returns {boolean} 
     * @memberof Game_Actor
     */
    isBattleMember(): boolean;
    isFormationChangeOk(): boolean;
    /**
     * Returns the current class of the actor from the database.
     * 
     * @returns {RPG.Class} 
     * @memberof Game_Actor
     */
    currentClass(): RPG.Class;
    /**
     * Returns true if the actor is the specified class from the database.
     * 
     * @param {RPG.Class} gameClass 
     * @returns {boolean} 
     * @memberof Game_Actor
     */
    isClass(gameClass: RPG.Class): boolean;
    /**
     * Returns the actor's skills; even if the skills are not usable.
     * 
     * @returns {Array<RPG.Skill>} 
     * @memberof Game_Actor
     */
    skills(): Array<RPG.Skill>;
    /**
     * Returns the usable skills of the actor.
     * 
     * @returns {Array<RPG.Skill>} 
     * @memberof Game_Actor
     */
    usableSkills(): Array<RPG.Skill>;
    /**
     * Returns the attack element ids.
     * 
     * @returns {Array<number>} 
     * @memberof Game_Actor
     */
    attackElements(): Array<number>;
    /**
     * Returns true if the actor has no weapon.
     * 
     * @returns {boolean} 
     * @memberof Game_Actor
     */
    hasNoWeapons(): boolean;
    /**
     * Returns the element id of barehanded attacks.
     * 
     * @returns {number} 
     * @memberof Game_Actor
     */
    bareHandsElementId(): number;
    /**
     * Returns the first attack animation id.
     * 
     * @returns {number} 
     * @memberof Game_Actor
     */
    attackAnimationId1(): number;
    /**
     * Returns the second attack animation id.
     * 
     * @returns {number} 
     * @memberof Game_Actor
     */
    attackAnimationId2(): number;
    /**
     * Returns the animation id for a barehanded attack.
     * 
     * @returns {number} 
     * @memberof Game_Actor
     */
    bareHandsAnimationId(): number;
    /**
     * Change the actor experience points; leveling up the actor
     * if it's above the required exp for the current level.
     * If show is set to true, actor level up with be displayed.
     * @param {number} exp 
     * @param {boolean} show 
     * @memberof Game_Actor
     */
    changeExp(exp: number, show: boolean): void;
    /**
     * Level up the actor.
     * 
     * @memberof Game_Actor
     */
    levelUp(): void;
    /**
     * Level down the actor.
     * 
     * @memberof Game_Actor
     */
    levelDown(): void;
    findNewSkills(lastSkills: Array<RPG.Skill>): Array<RPG.Skill>;
    /**
     * Displays the actor level up in a message window, with the learned skills.
     * 
     * @param {Array<RPG.Skill>} newSkills 
     * @memberof Game_Actor
     */
    displayLevelUp(newSkills: Array<RPG.Skill>): void;
    /**
     * Gives the specified exp to the actor.
     * 
     * @param {number} exp 
     * @memberof Game_Actor
     */
    gainExp(exp: number): void;
    /**
     * Returns the final exp rate of the actor based on if the actor 
     * is a reserved party member or an active battle member. 
     * @returns {number} 
     * @memberof Game_Actor
     */
    finalExpRate(): number;
    /**
     * Returns the exp rate of actors not in battle; this is set in the database.
     * 
     * @returns {number} 
     * @memberof Game_Actor
     */
    benchMembersExpRate(): number;
    /**
     * Returns true if the actor should display level up in a message window.
     * 
     * @returns {boolean} 
     * @memberof Game_Actor
     */
    shouldDisplayLevelUp(): boolean;
    /**
     * Changes the actor level; if show is set to true,
     * the actor level will be displayed.
     * @param {number} level 
     * @param {boolean} show 
     * @memberof Game_Actor
     */
    changeLevel(level: number, show: boolean): void;
    /**
     * Actor learns the specified skill given the skill id.
     * 
     * @param {number} skillId 
     * @memberof Game_Actor
     */
    learnSkill(skillId: number): void;
    /**
     * Actor forgets the specified skill given the skill id from 
     * the actor's usable skills.
     * @param {number} skillId 
     * @memberof Game_Actor
     */
    forgetSkill(skillId: number): void;
    /**
     * Returns true if the actor has learned the specified
     * skill given the specified skill id.
     * @param {number} skillId 
     * @returns {boolean} 
     * @memberof Game_Actor
     */
    isLearnedSkill(skillId: number): boolean;
    /**
     * Changes the actor class; if keep is true, the actor
     * will retain their experience points.
     * @param {number} classId 
     * @param {boolean} keepExp 
     * @memberof Game_Actor
     */
    changeClass(classId: number, keepExp: boolean): void;
    setCharacterImage(characterName: string, characterIndex: number): void;
    /**
     * Sets the face image of the actor given the face image (from database)
     * and face index within the image.
     * 
     * @param {string} faceName 
     * @param {number} faceIndex 
     * @memberof Game_Actor
     */
    setFaceImage(faceName: string, faceIndex: number): void;
    /**
     * Sets the battler image of the actor; this is the sprite displayed
     * in the side view mode.
     * @param {string} battlerName 
     * @memberof Game_Actor
     */
    setBattlerImage(battlerName: string): void;
    /**
     * Returns true if the actor sprite is visible.
     * 
     * @returns {boolean} 
     * @memberof Game_Actor
     */
    isSpriteVisible(): boolean;
    /**
     * Starts the animation on the actor given the specified animation id;
     * if  mirror is set to true, the animation will be mirrored. If a delay is enter,
     * the animation will be delayed.
     * @param {number} animationId 
     * @param {boolean} mirror 
     * @param {number} delay 
     * @memberof Game_Actor
     */
    startAnimation(animationId: number, mirror: boolean, delay: number): void;
    /**
     * Performs the attack motion for the actor.
     * 
     * @memberof Game_Actor
     */
    performAttack(): void;
    /**
     * Perform the victory motion for the actor.
     * 
     * @memberof Game_Actor
     */
    performVictory(): void;
    /**
     * Performs the escape motion for the actor.
     * 
     * @memberof Game_Actor
     */
    performEscape(): void;
    /**
     * Creates the action list for the actor.
     * 
     * @returns {Array<Game_Action>} 
     * @memberof Game_Actor
     */
    makeActionList(): Array<Game_Action>;
    /**
     * Creates the auto battle actions for the game actor.
     * 
     * @memberof Game_Actor
     */
    makeAutoBattleActions(): void;
    makeConfusionActions(): void;
    /**
     * Handler for when the player walks on the map scene.
     * 
     * @memberof Game_Actor
     */
    onPlayerWalk(): void;
    updateStateSteps(state: RPG.State): void;
    /**
     * Shows the added states to the actor.
     * 
     * @memberof Game_Actor
     */
    showAddedStates(): void;
    /**
     * Shows the removed states from the actor.
     * 
     * @memberof Game_Actor
     */
    showRemovedStates(): void;
    stepsForTurn(): number;
    turnEndOnMap(): void;
    /**
     * Checks the effect of the floor on the actor.
     * 
     * @memberof Game_Actor
     */
    checkFloorEffect(): void;
    /**
     * Executes the floor damage on the actor.
     * 
     * @memberof Game_Actor
     */
    executeFloorDamage(): void;
    /**
     * Returns the basic floor damage.
     * 
     * @returns {number} 
     * @memberof Game_Actor
     */
    basicFloorDamage(): number;
    /**
     * Returns the max floor damage.
     * 
     * @returns {number} 
     * @memberof Game_Actor
     */
    maxFloorDamage(): number;
    /**
     * Perform damage to the actor on the map scene.
     * 
     * @memberof Game_Actor
     */
    performMapDamage(): void;
    /**
     * Clears all of the actor's animations.
     * 
     * @memberof Game_Actor
     */
    clearActions(): void;
    /**
     * Returns action the actor is inputting.
     * 
     * @returns {Game_Action} 
     * @memberof Game_Actor
     */
    inputtingAction(): Game_Action;
    selectNextCommand(): boolean;
    selectPreviousCommand(): boolean;
    /**
     * Returns the last menu skill of the actor.
     * 
     * @returns {RPG.Skill} 
     * @memberof Game_Actor
     */
    lastMenuSkill(): RPG.Skill;
    setLastMenuSkill(skill: RPG.Skill): void;
    /**
     * Returns the last battle skill of the actor.
     * 
     * @returns {RPG.Skill} 
     * @memberof Game_Actor
     */
    lastBattleSkill(): RPG.Skill;
    setLastBattleSkill(skill: RPG.Skill): void;
    /**
     * Returns the last command symbol that the actor used.
     * 
     * @returns {string} 
     * @memberof Game_Actor
     */
    lastCommandSymbol(): string;
    /**
     * Sets the last command symbol to the given symbol; this is the
     * selected command in the battle menu.
     * @param {string} symbol 
     * @memberof Game_Actor
     */
    setLastCommandSymbol(symbol: string): void;
}

/**
 * -----------------------------------------------------------------------------
 * Game_Enemy
 *
 * The game object declare class for an enemy.
 * @class Game_Enemy
 */
declare class Game_Enemy extends Game_Battler {
    protected _enemyId: number;
    protected _letter: string;
    protected _plural: boolean;
    protected _screenX: number;
    protected _screenY: number;

    constructor(enemyId: number, x: number, y: number);

    initMembers(): void;
    setup(enemyId: number, x: number, y: number): void;
    /**
     * Returns the other troops in the enemy team.
     * 
     * @returns {Game_Troop} 
     * @memberof Game_Enemy
     */
    friendsUnit(): Game_Troop;
    /**
     * Returns the game party.
     * 
     * @returns {Game_Party} 
     * @memberof Game_Enemy
     */
    opponentsUnit(): Game_Party;
    isBattleMember(): boolean;
    /**
     * Returns the enemy id.
     * 
     * @returns {number} 
     * @memberof Game_Enemy
     */
    enemyId(): number;
    /**
     * Returns the enemy information from the database.
     * 
     * @returns {RPG.Enemy} 
     * @memberof Game_Enemy
     */
    enemy(): RPG.Enemy;
    /**
     * Returns the enemy's exp amount.
     * 
     * @memberof Game_Enemy
     */
    exp(): void;
    /**
     * Returns enemy's given gold.
     * 
     * @memberof Game_Enemy
     */
    gold(): void;
    /**
     * Creates the drop items for the enemy specified by the database.
     * 
     * @returns {Array<RPG.BaseItem>} 
     * @memberof Game_Enemy
     */
    makeDropItems(): Array<RPG.BaseItem>;
    /**
     * Returns the item drop rate of the enemy.
     * 
     * @returns {number} 
     * @memberof Game_Enemy
     */
    dropItemRate(): number;
    itemObject(kind: number, dataId: number): void;
    /**
     * Returns true if the enemy sprite is visible.
     * 
     * @returns {boolean} 
     * @memberof Game_Enemy
     */
    isSpriteVisible(): boolean;
    /**
     * Returns enemy screen X coordinate.
     * 
     * @returns {number} 
     * @memberof Game_Enemy
     */
    screenX(): number;
    /**
     * Returns enemy screen Y position.
     * 
     * @returns {number} 
     * @memberof Game_Enemy
     */
    screenY(): number;
    /**
     * Returns the hue of the enemy.
     * 
     * @returns {number} 
     * @memberof Game_Enemy
     */
    battlerHue(): number;
    /**
     * Returns the enemy original name.
     * 
     * @returns {string} 
     * @memberof Game_Enemy
     */
    originalName(): string;
    isLetterEmpty(): boolean;
    setLetter(letter: string): void;
    setPlural(plural: boolean): void;
    /**
     * Transform the enemy into another enemy based on id.
     * 
     * @param {number} enemyId 
     * @memberof Game_Enemy
     */
    transform(enemyId: number): void;
    meetsCondition(action: RPG.Enemy.Action): boolean;
    meetsTurnCondition(param1: number, param2: number): boolean;
    meetsHpCondition(param1: number, param2: number): boolean;
    meetsMpCondition(param1: number, param2: number): boolean;
    meetsStateCondition(param: number): boolean;
    meetsPartyLevelCondition(param: number): boolean;
    meetsSwitchCondition(param: number): boolean;
    /**
     * Returns true if the enemy action is valid.
     * 
     * @param {RPG.Enemy.Action} action 
     * @returns {boolean} 
     * @memberof Game_Enemy
     */
    isActionValid(action: RPG.Enemy.Action): boolean;
    selectAction(actionList: Array<RPG.Enemy.Action>, ratingZero: number): RPG.Enemy.Action;
    selectAllActions(actionList: Array<RPG.Enemy.Action>): void;
}



/**
 * Wrapper class for Game_Actor.
 * This is the array form.
 * @class Game_Actors
 */
declare class Game_Actors {
    protected _data: Array<Game_Actor>;

    /**
     * Returns the actor with the specified id.
     * 
     * @param {number} actorId 
     * @returns {Game_Actor} 
     * @memberof Game_Actors
     */
    actor(actorId: number): Game_Actor;
}

/**
 * Superclass of Game_Party & Game_Troop
 * 
 * @class Game_Unit
 */
declare class Game_Unit {
    protected _inBattle: boolean;

    /**
     * Returns true if unit is in battle.
     * 
     * @returns {boolean} 
     * @memberof Game_Unit
     */
    inBattle(): boolean;
    /**
     * Returns the list of battlers.
     * 
     * @returns {Array<Game_Battler>} 
     * @memberof Game_Unit
     */
    members(): Array<Game_Battler>;
    /**
     * Returns the list of alive battlers.
     * 
     * @returns {Array<Game_Battler>} 
     * @memberof Game_Unit
     */
    aliveMembers(): Array<Game_Battler>;
    /**
     * Returns the list of dead battlers.
     * 
     * @returns {Array<Game_Battler>} 
     * @memberof Game_Unit
     */
    deadMembers(): Array<Game_Battler>;
    /**
     * Returns the list of movable members.
     * 
     * @returns {Array<Game_Battler>} 
     * @memberof Game_Unit
     */
    movableMembers(): Array<Game_Battler>;
    /**
     * Clears the unit's actions.
     * 
     * @memberof Game_Unit
     */
    clearActions(): void;
    /**
     * Returns the agility of the unit.
     * 
     * @returns {number} 
     * @memberof Game_Unit
     */
    agility(): number;
    tgrSum(): number;
    /**
     * Returns a random target from the game unit.
     * 
     * @returns {Game_Battler} 
     * @memberof Game_Unit
     */
    randomTarget(): Game_Battler;
    /**
     * Returns a random dead target from the game unit.
     * 
     * @returns {Game_Battler} 
     * @memberof Game_Unit
     */
    randomDeadTarget(): Game_Battler;
    smoothTarget(index: number): Game_Battler;
    smoothDeadTarget(index: number): Game_Battler;
    /**
     * Clears the action results.
     * 
     * @memberof Game_Unit
     */
    clearResults(): void;
    /**
     * Handler for when battle is started.
     * 
     * @memberof Game_Unit
     */
    onBattleStart(): void;
    /**
     * Handler for when battle has ended.
     * 
     * @memberof Game_Unit
     */
    onBattleEnd(): void;
    /**
     * Creates the action's of the game unit.
     * 
     * @memberof Game_Unit
     */
    makeActions(): void;
    /**
     * Selects a member of the unit given a battler.
     * 
     * @param {Game_Battler} activeMember 
     * @memberof Game_Unit
     */
    select(activeMember: Game_Battler): void;
    /**
     * Returns true if all members of the unit are dead.
     * 
     * @returns {boolean} 
     * @memberof Game_Unit
     */
    isAllDead(): boolean;
    substituteBattler(): Game_Battler;
}

/**
 * -----------------------------------------------------------------------------
 * Game_Party
 *
 * The game object declare class for the party. Information such as gold and items is
 * included.
 * @class Game_Party
 */
declare class Game_Party extends Game_Unit {
    static ABILITY_ENCOUNTER_HALF: number;
    static ABILITY_ENCOUNTER_NONE: number;
    static ABILITY_CANCEL_SURPRISE: number;
    static ABILITY_RAISE_PREEMPTIVE: number;
    static ABILITY_GOLD_DOUBLE: number;
    static ABILITY_DROP_ITEM_DOUBLE: number;

    protected _gold: number;
    protected _steps: number;
    protected _lastItem: Game_Item;
    protected _menuActorId: number;
    protected _targetActorId: number;
    protected _actors: Array<Game_Actor>;

    protected _items: { [itemId: number]: number };
    protected _weapons: { [itemId: number]: number };
    protected _armors: { [itemId: number]: number };

    /**
     * Returns all party members.
     * 
     * @returns {Array<Game_Actor>} 
     * @memberof Game_Party
     */
    members(): Array<Game_Actor>;
    /**
     * Returns the living party members.
     * 
     * @returns {Array<Game_Actor>} 
     * @memberof Game_Party
     */
    aliveMembers(): Array<Game_Actor>;
    /**
     * Returns the dead party members.
     * 
     * @returns {Array<Game_Actor>} 
     * @memberof Game_Party
     */
    deadMembers(): Array<Game_Actor>;
    /**
     * Returns the movable members in the party.
     * 
     * @returns {Array<Game_Actor>} 
     * @memberof Game_Party
     */
    movableMembers(): Array<Game_Actor>;
    /**
     * Returns the battle members in the party.
     * 
     * @returns {Array<Game_Actor>} 
     * @memberof Game_Party
     */
    battleMembers(): Array<Game_Actor>;
    /**
     * Initialize all party items.
     * 
     * @memberof Game_Party
     */
    initAllItems(): void;
    /**
     * Returns true if the game party exists.
     * 
     * @returns {boolean} 
     * @memberof Game_Party
     */
    exists(): boolean;
    /**
     * Returns the size of the party.
     * 
     * @returns {number} 
     * @memberof Game_Party
     */
    size(): number;
    /**
     * Returns true if the game party is empty.
     * 
     * @returns {boolean} 
     * @memberof Game_Party
     */
    isEmpty(): boolean;
    /**
     * Returns the maximum battle members in the party.
     * 
     * @returns {number} 
     * @memberof Game_Party
     */
    maxBattleMembers(): number;
    /**
     * Returns the leader of the party.
     * 
     * @returns {Game_Actor} 
     * @memberof Game_Party
     */
    leader(): Game_Actor;
    /**
     * Revive the battle members of the party.
     * 
     * @memberof Game_Party
     */
    reviveBattleMembers(): void;
    items(): Array<RPG.Item>;
    /**
     * Returns the weapons of the party.
     * 
     * @returns {Array<RPG.Weapon>} 
     * @memberof Game_Party
     */
    weapons(): Array<RPG.Weapon>;
    /**
     * Returns the party's armor.
     * 
     * @returns {Array<RPG.Armor>} 
     * @memberof Game_Party
     */
    armors(): Array<RPG.Armor>;
    /**
     * Returns the party's items which can be equipped.
     * 
     * @returns {Array<RPG.EquipItem>} 
     * @memberof Game_Party
     */
    equipItems(): Array<RPG.EquipItem>;
    /**
     * Returns all items within the party's posession.
     * 
     * @returns {Array<RPG.BaseItem>} 
     * @memberof Game_Party
     */
    allItems(): Array<RPG.BaseItem>;
    itemContainer(item: RPG.BaseItem): { [itemId: number]: number };
    /**
     * Sets up the starting party members.
     * 
     * @memberof Game_Party
     */
    setupStartingMembers(): void;
    name(): string;
    /**
     * Sets up a test battle with the party.
     * 
     * @memberof Game_Party
     */
    setupBattleTest(): void;
    /**
     * Sets up the battle test members.
     * 
     * @memberof Game_Party
     */
    setupBattleTestMembers(): void;
    /**
     * Sets up the battle test items.
     * 
     * @memberof Game_Party
     */
    setupBattleTestItems(): void;
    /**
     * Returns the highest level in the party.
     * 
     * @returns {number} 
     * @memberof Game_Party
     */
    highestLevel(): number;
    /**
     * Adds an actor to the party given the actor id.
     * 
     * @param {number} actorId 
     * @memberof Game_Party
     */
    addActor(actorId: number): void;
    /**
     * Removes an actor from the party given the actor id.
     * 
     * @param {number} actorId 
     * @memberof Game_Party
     */
    removeActor(actorId: number): void;
    /**
     * Returns party gold.
     * 
     * @returns {number} 
     * @memberof Game_Party
     */
    gold(): number;
    /**
     * Increases the party gold given a specified amount.
     * 
     * @param {number} amount 
     * @memberof Game_Party
     */
    gainGold(amount: number): void;
    /**
     * Decreases the party gold given a specified amount.
     * 
     * @param {number} amount 
     * @memberof Game_Party
     */
    loseGold(amount: number): void;
    /**
     * Returns maximum gold of the party.
     * 
     * @returns {number} 
     * @memberof Game_Party
     */
    maxGold(): number;
    /**
     * Returns the number of steps the party has taken.
     * 
     * @returns {number} 
     * @memberof Game_Party
     */
    steps(): number;
    /**
     * Increases the number of steps the party has taken.
     * 
     * @memberof Game_Party
     */
    increaseSteps(): void;
    /**
     * Returns the number of items in the possession of the party of the
     * given item.
     * @param {RPG.BaseItem} item 
     * @returns {number} 
     * @memberof Game_Party
     */
    numItems(item: RPG.BaseItem): number;
    /**
     * Returns the maximum number of items of the given item.
     * 
     * @param {RPG.BaseItem} item 
     * @returns {number} 
     * @memberof Game_Party
     */
    maxItems(item: RPG.BaseItem): number;
    hasMaxItems(item: RPG.BaseItem): boolean;
    /**
     * Returns true if the party has the given item;
     * if includeEquip is set to true, this will also check party equipment.
     * @param {RPG.BaseItem} item 
     * @param {boolean} includeEquip 
     * @returns {boolean} 
     * @memberof Game_Party
     */
    hasItem(item: RPG.BaseItem, includeEquip: boolean): boolean;
    /**
     * Returns true if any party member has the specified equip item.
     * 
     * @param {RPG.EquipItem} item 
     * @returns {boolean} 
     * @memberof Game_Party
     */
    isAnyMemberEquipped(item: RPG.EquipItem): boolean;
    gainItem(item: RPG.BaseItem, amount: number, includeEquip: boolean): void;
    discardMembersEquip(item: RPG.EquipItem, amount: number): void;
    loseItem(item: RPG.BaseItem, amount: number, includeEquip: boolean): void;
    /**
     * Has the party consume the given item.
     * 
     * @param {RPG.BaseItem} item 
     * @memberof Game_Party
     */
    consumeItem(item: RPG.BaseItem): void;
    /**
     * Returns true if the party can use the item.
     * 
     * @param {RPG.BaseItem} item 
     * @returns {boolean} 
     * @memberof Game_Party
     */
    canUse(item: RPG.BaseItem): boolean;
    canInput(): boolean;
    /**
     * Handler for when the player walks.
     * 
     * @memberof Game_Party
     */
    onPlayerWalk(): void;
    /**
     * Returns the actor that will be used in the current menu;
     * this is for menu scenes that target one actor.
     * @returns {Game_Actor} 
     * @memberof Game_Party
     */
    menuActor(): Game_Actor;
    setMenuActor(actor: Game_Actor): void;
    makeMenuActorNext(): void;
    makeMenuActorPrevious(): void;
    targetActor(): Game_Actor;
    setTargetActor(actor: Game_Actor): void;
    /**
     * Returns the last item selected by the game party.
     * 
     * @returns {RPG.BaseItem} 
     * @memberof Game_Party
     */
    lastItem(): RPG.BaseItem;
    setLastItem(item: RPG.BaseItem): void;
    swapOrder(index1: number, index2: number): void;
    /**
     * Returns the characters that go on the save life.
     * 
     * @returns {Array<Array<any>>} 
     * @memberof Game_Party
     */
    charactersForSavefile(): Array<Array<any>>;
    /**
     * Returns the actor faces for the save file.
     * 
     * @returns {Array<Array<any>>} 
     * @memberof Game_Party
     */
    facesForSavefile(): Array<Array<any>>;
    partyAbility(abilityId: number): boolean;
    /**
     * Returns true if the encounter rate is set to half.
     * 
     * @returns {boolean} 
     * @memberof Game_Party
     */
    hasEncounterHalf(): boolean;
    /**
     * Returns true if the encounter rate is set to none.
     * 
     * @returns {boolean} 
     * @memberof Game_Party
     */
    hasEncounterNone(): boolean;
    hasCancelSurprise(): boolean;
    /**
     * Returns true if the party has an increased chance of preemptive strike.
     * 
     * @returns {boolean} 
     * @memberof Game_Party
     */
    hasRaisePreemptive(): boolean;
    /**
     * Returns true if the party has double gold in effect.
     * 
     * @returns {boolean} 
     * @memberof Game_Party
     */
    hasGoldDouble(): boolean;
    hasDropItemDouble(): boolean;
    ratePreemptive(troopAgi: number): number;
    rateSurprise(troopAgi: number): number;
    /**
     * Performs victory motion for the entire party.
     * 
     * @memberof Game_Party
     */
    performVictory(): void;
    /**
     * Performs escape motion for the entire party.
     * 
     * @memberof Game_Party
     */
    performEscape(): void;
    /**
     * Remove battle states from all actors in the party.
     * 
     * @memberof Game_Party
     */
    removeBattleStates(): void;
    /**
     * Refreshes the motion on all actors in the party.
     * 
     * @memberof Game_Party
     */
    requestMotionRefresh(): void;
}

/**
 * -----------------------------------------------------------------------------
 * Game_Troop
 *
 * The game object declare class for a troop and the battle-related data.
 * @class Game_Troop
 */
declare class Game_Troop extends Game_Unit {
    static LETTER_TABLE_HALF: Array<string>;
    static LETTER_TABLE_FULL: Array<string>;

    protected _interpreter: Game_Interpreter;
    protected _troopId: number;
    protected _eventFlags: { [page: number]: boolean };
    protected _enemies: Array<Game_Enemy>;
    protected _turnCount: number;
    protected _namesCount: { [name: string]: number };

    /**
     * Returns all enemies in the battle.
     * 
     * @returns {Array<Game_Enemy>} 
     * @memberof Game_Troop
     */
    members(): Array<Game_Enemy>;
    /**
     * Returns all alive enemies.
     * 
     * @returns {Array<Game_Enemy>} 
     * @memberof Game_Troop
     */
    aliveMembers(): Array<Game_Enemy>;
    /**
     * Returns all dead enemies.
     * 
     * @returns {Array<Game_Enemy>} 
     * @memberof Game_Troop
     */
    deadMembers(): Array<Game_Enemy>;
    /**
     * Returns movable enemies.
     * 
     * @returns {Array<Game_Enemy>} 
     * @memberof Game_Troop
     */
    movableMembers(): Array<Game_Enemy>;
    /**
     * Returns true if event is running.
     * 
     * @returns {boolean} 
     * @memberof Game_Troop
     */
    isEventRunning(): boolean;
    /**
     * Updates the game interpreter.
     * 
     * @memberof Game_Troop
     */
    updateInterpreter(): void;
    /**
     * Returns the turn count.
     * 
     * @returns {number} 
     * @memberof Game_Troop
     */
    turnCount(): number;
    clear(): void;
    /**
     * Returns troop information from the database.
     * 
     * @returns {RPG.Troop} 
     * @memberof Game_Troop
     */
    troop(): RPG.Troop;
    setup(troopId: number): void;
    /**
     * Creates unique names for each enemy.
     * 
     * @memberof Game_Troop
     */
    makeUniqueNames(): void;
    /**
     * Returns the letter table for enemy troops.
     * 
     * @returns {Array<string>} 
     * @memberof Game_Troop
     */
    letterTable(): Array<string>;
    /**
     * Returns the name of enemies within the troop.
     * 
     * @returns {Array<string>} 
     * @memberof Game_Troop
     */
    enemyNames(): Array<string>;
    meetsConditions(page: RPG.BattleEventPage): boolean;
    setupBattleEvent(): void;
    /**
     * Increases the turn number.
     * 
     * @memberof Game_Troop
     */
    increaseTurn(): void;
    /**
     * Returns the total exp of all members of the enemy troop.
     * 
     * @returns {number} 
     * @memberof Game_Troop
     */
    expTotal(): number;
    /**
     * Return the total gold of all enemies.
     * 
     * @returns {number} 
     * @memberof Game_Troop
     */
    goldTotal(): number;
    /**
     * Returns the gold rate based on game party gold rate.
     * 
     * @returns {number} 
     * @memberof Game_Troop
     */
    goldRate(): number;
    /**
     * Creates the drop items for all members of the enemy troop, and
     * returns the item information.
     * @returns {Array<RPG.BaseItem>} 
     * @memberof Game_Troop
     */
    makeDropItems(): Array<RPG.BaseItem>;
}

/**
 * -----------------------------------------------------------------------------
 * Game_Map
 *
 * The game object declare class for a map. It contains scrolling and passage
 * determination functions.
 * @class Game_Map
 */
declare class Game_Map {
    protected _interpreter: Game_Interpreter;
    protected _mapId: number;
    protected _tilesetId: number;
    protected _events: Array<Game_Event>;
    protected _commonEvents: Array<Game_CommonEvent>;
    protected _vehicles: Array<Game_Vehicle>;
    protected _displayX: number;
    protected _displayY: number;
    protected _nameDisplay: boolean;
    protected _scrollDirection: number;
    protected _scrollRest: number;
    protected _scrollSpeed: number;
    protected _parallaxName: string;
    protected _parallaxZero: boolean;
    protected _parallaxLoopX: boolean;
    protected _parallaxLoopY: boolean;
    protected _parallaxSx: number;
    protected _parallaxSy: number;
    protected _parallaxX: number;
    protected _parallaxY: number;
    protected _battleback1Name: string;
    protected _battleback2Name: string;
    protected _needsRefresh: boolean;

    setup(mapId: number): void;
    /**
     * Returns true if an event is running.
     * 
     * @returns {boolean} 
     * @memberof Game_Map
     */
    isEventRunning(): boolean;
    /**
     * Returns tile width.
     * 
     * @returns {number} 
     * @memberof Game_Map
     */
    tileWidth(): number;
    /**
     * Returns tile height.
     * 
     * @returns {number} 
     * @memberof Game_Map
     */
    tileHeight(): number;
    /**
     * Returns map id.
     * 
     * @returns {number} 
     * @memberof Game_Map
     */
    mapId(): number;
    /**
     * Returns the tileset id.
     * 
     * @returns {number} 
     * @memberof Game_Map
     */
    tilesetId(): number;
    /**
     * Returns the display x coordinate.
     * 
     * @returns {number} 
     * @memberof Game_Map
     */
    displayX(): number;
    /**
     * Returns the display y coordinate.
     * 
     * @returns {number} 
     * @memberof Game_Map
     */
    displayY(): number;
    parallaxName(): string;
    /**
     * Returns the name of battle back 1.
     * 
     * @returns {string} 
     * @memberof Game_Map
     */
    battleback1Name(): string;
    /**
     * Returns the name of battle back 2.
     * 
     * @returns {string} 
     * @memberof Game_Map
     */
    battleback2Name(): string;
    requestRefresh(mapId: number): void;
    /**
     * Returns true if the name display is enabled.
     * 
     * @returns {boolean} 
     * @memberof Game_Map
     */
    isNameDisplayEnabled(): boolean;
    /**
     * Disables name display.
     * 
     * @memberof Game_Map
     */
    disableNameDisplay(): void;
    /**
     * Enable name display.
     * 
     * @memberof Game_Map
     */
    enableNameDisplay(): void;
    /**
     * Creates the vehicles for the game map.
     * 
     * @memberof Game_Map
     */
    createVehicles(): void;
    /**
     * Refreshes the vehicles on the game map.
     * 
     * @memberof Game_Map
     */
    refreshVehicles(): void;
    vehicles(): Array<Game_Vehicle>;
    /**
     * Returns the game vehicle specified by type.
     * 
     * @param {string} type 
     * @returns {Game_Vehicle} 
     * @memberof Game_Map
     */
    vehicle(type: string): Game_Vehicle;
    /**
     * Returns the game boat.
     * 
     * @returns {Game_Vehicle} 
     * @memberof Game_Map
     */
    boat(): Game_Vehicle;
    /**
     * Returns the game ship.
     * 
     * @returns {Game_Vehicle} 
     * @memberof Game_Map
     */
    ship(): Game_Vehicle;
    /**
     * Returns the game airship.
     * 
     * @returns {Game_Vehicle} 
     * @memberof Game_Map
     */
    airship(): Game_Vehicle;
    setupEvents(): void;
    /**
     * Returns all events on the game map.
     * 
     * @returns {Array<Game_Event>} 
     * @memberof Game_Map
     */
    events(): Array<Game_Event>;
    /**
     * Returns an event, given the event id.
     * 
     * @param {number} eventId 
     * @returns {Game_Event} 
     * @memberof Game_Map
     */
    event(eventId: number): Game_Event;
    /**
     * Erases the event given the event id.
     * 
     * @param {number} eventId 
     * @memberof Game_Map
     */
    eraseEvent(eventId: number): void;
    /**
     * Returns all the parallel running common events.
     * 
     * @returns {Array<RPG.CommonEvent>} 
     * @memberof Game_Map
     */
    parallelCommonEvents(): Array<RPG.CommonEvent>;
    setupScroll(): void;
    setupParallax(): void;
    setupBattleback(): void;
    setDisplayPos(x: number, y: number): void;
    parallaxOx(): number;
    parallaxOy(): number;
    /**
     * Returns the tilset of the game map.
     * 
     * @returns {RPG.Tileset} 
     * @memberof Game_Map
     */
    tileset(): RPG.Tileset;
    /**
     * Returns the tileset flags of the game map.
     * 
     * @returns {Array<number>} 
     * @memberof Game_Map
     */
    tilesetFlags(): Array<number>;
    /**
     * Returns the display name of the game map.
     * 
     * @returns {string} 
     * @memberof Game_Map
     */
    displayName(): string;
    /**
     * Returns the map width.
     * 
     * @returns {number} 
     * @memberof Game_Map
     */
    width(): number;
    /**
     * Returns the map height.
     * 
     * @returns {number} 
     * @memberof Game_Map
     */
    height(): number;
    /**
     * Returns the map data.
     * 
     * @returns {Array<number>} 
     * @memberof Game_Map
     */
    data(): Array<number>;
    /**
     * Returns true if the map loops horizontally.
     * 
     * @returns {boolean} 
     * @memberof Game_Map
     */
    isLoopHorizontal(): boolean;
    /**
     * Returns true if the map loops vertically.
     * 
     * @returns {boolean} 
     * @memberof Game_Map
     */
    isLoopVertical(): boolean;
    /**
     * Returns true if dash is disabled on the map.
     * 
     * @returns {boolean} 
     * @memberof Game_Map
     */
    isDashDisabled(): boolean;
    /**
     * Returns the list of possible encounters on the current map.
     * 
     * @returns {Array<RPG.Map.Encounter>} 
     * @memberof Game_Map
     */
    encounterList(): Array<RPG.Map.Encounter>;
    /**
     * Returns the number of encounter steps on the map.
     * 
     * @returns {number} 
     * @memberof Game_Map
     */
    encounterStep(): number;
    /**
     * Returns true if the map is an over world map.
     * 
     * @returns {boolean} 
     * @memberof Game_Map
     */
    isOverworld(): boolean;
    /**
     * Returns the screen tile x coordinate.
     * 
     * @returns {number} 
     * @memberof Game_Map
     */
    screenTileX(): number;
    /**
     * Returns the screen tile y coordinate.
     * 
     * @returns {number} 
     * @memberof Game_Map
     */
    screenTileY(): number;
    adjustX(x: number): number;
    adjustY(y: number): number;
    roundX(x: number): number;
    roundY(y: number): number;
    xWithDirection(x: number, d: number): number;
    yWithDirection(y: number, d: number): number;
    roundXWithDirection(x: number, d: number): number;
    roundYWithDirection(y: number, d: number): number;
    deltaX(x1: number, x2: number): number;
    deltaY(y1: number, y2: number): number;
    distance(x1: number, y1: number, x2: number, y2: number): number;
    /**
     * Converts the x coordinate from canvas to map coordinate x.
     * 
     * @param {number} x 
     * @returns {number} 
     * @memberof Game_Map
     */
    canvasToMapX(x: number): number;
    /**
     * Converts the y coordinate from canvas to map y coordinate.
     * 
     * @param {number} y 
     * @returns {number} 
     * @memberof Game_Map
     */
    canvasToMapY(y: number): number;
    /**
     * Auto plays the game map.
     * 
     * @memberof Game_Map
     */
    autoplay(): void;
    refreshIfNeeded(): void;
    refresh(): void;
    refreshTileEvents(): void;
    /**
     * Returns the game events at the specified
     * x and y position.
     * @param {number} x 
     * @param {number} y 
     * @returns {Array<Game_Event>} 
     * @memberof Game_Map
     */
    eventsXy(x: number, y: number): Array<Game_Event>;
    eventsXyNt(x: number, y: number): Array<Game_Event>;
    tileEventsXy(x: number, y: number): Array<Game_Event>;
    eventIdXy(x: number, y: number): number;
    scrollDown(distance: number): void;
    scrollLeft(distance: number): void;
    scrollRight(distance: number): void;
    scrollUp(distance: number): void;
    /**
     * Returns true if the x and y coordinates are valid.
     * 
     * @param {number} x 
     * @param {number} y 
     * @returns {boolean} 
     * @memberof Game_Map
     */
    isValid(x: number, y: number): boolean;
    checkPassage(x: number, y: number, bit: number): boolean;
    /**
     * Returns the tile id at the specified x, y, and z coordinates.
     * 
     * @param {number} x 
     * @param {number} y 
     * @param {number} z 
     * @returns {number} 
     * @memberof Game_Map
     */
    tileId(x: number, y: number, z: number): number;
    layeredTiles(x: number, y: number): Array<number>;
    allTiles(x: number, y: number): Array<number>;
    autotileType(x: number, y: number, z: number): number;
    isPassable(x: number, y: number, d: number): boolean;
    isBoatPassable(x: number, y: number): boolean;
    isShipPassable(x: number, y: number): boolean;
    isAirshipLandOk(x: number, y: number): boolean;
    checkLayeredTilesFlags(x: number, y: number, bit: number): boolean;
    /**
     * Returns true if the specified element at the given x and y coordinates
     * is a ladder.
     * @param {number} x 
     * @param {number} y 
     * @returns {boolean} 
     * @memberof Game_Map
     */
    isLadder(x: number, y: number): boolean;
    isBush(x: number, y: number): boolean;
    isCounter(x: number, y: number): boolean;
    isDamageFloor(x: number, y: number): boolean;
    terrainTag(x: number, y: number): number;
    regionId(x: number, y: number): number;
    startScroll(direction: number, distance: number, speed: number): void;
    isScrolling(): boolean;
    /**
     * Updates the game map, given that the scene is active.
     * 
     * @param {boolean} sceneActive 
     * @memberof Game_Map
     */
    update(sceneActive: boolean): void;
    updateScroll(): void;
    scrollDistance(): number;
    doScroll(direction: number, distance: number): void;
    /**
     * Updates all events on the map.
     * 
     * @memberof Game_Map
     */
    updateEvents(): void;
    /**
     * Updates all game vehicles on the map.
     * 
     * @memberof Game_Map
     */
    updateVehicles(): void;
    /**
     * Updates the map parallaxes.
     * 
     * @memberof Game_Map
     */
    updateParallax(): void;
    /**
     * Changes them ap tileset, given the tileset id.
     * 
     * @param {number} tilesetId 
     * @memberof Game_Map
     */
    changeTileset(tilesetId: number): void;
    changeBattleback(battleback1Name: string, battleback2Name: string): void;
    changeParallax(name: string, loopX: boolean, loopY: boolean, sx: number, sy: number): void;
    /**
     * Updates the map's game interpreter.
     * 
     * @memberof Game_Map
     */
    updateInterpreter(): void;
    /**
     * Unlocks an event on the map given the event id.
     * 
     * @param {number} eventId 
     * @memberof Game_Map
     */
    unlockEvent(eventId: number): void;
    setupStartingEvent(): boolean;
    setupTestEvent(): boolean;
    setupStartingMapEvent(): boolean;
    /**
     * Sets up an auto run common event.
     * 
     * @returns {boolean} 
     * @memberof Game_Map
     */
    setupAutorunCommonEvent(): boolean;
    /**
     * Returns true if any event is starting on the map.
     * 
     * @returns {boolean} 
     * @memberof Game_Map
     */
    isAnyEventStarting(): boolean;
}

/**
 * -----------------------------------------------------------------------------
 * Game_CommonEvent
 *
 * The game object declare class for a common event. It contains functionality for
 * running parallel process events.
 * @class Game_CommonEvent
 */
declare class Game_CommonEvent {
    protected _commonEventId: number;
    protected _interpreter: Game_Interpreter;

    constructor(commonEventId: number);

    /**
     * Returns the common event information from the database.
     * 
     * @returns {RPG.CommonEvent} 
     * @memberof Game_CommonEvent
     */
    event(): RPG.CommonEvent;
    /**
     * Returns the common event's list of event commands.
     * 
     * @returns {Array<RPG.EventCommand>} 
     * @memberof Game_CommonEvent
     */
    list(): Array<RPG.EventCommand>;
    /**
     * Refreshes the common event.
     * 
     * @memberof Game_CommonEvent
     */
    refresh(): void;
    /**
     * Returns true if the common event is active.
     * 
     * @returns {boolean} 
     * @memberof Game_CommonEvent
     */
    isActive(): boolean;
    /**
     * Updates the common event.
     * 
     * @memberof Game_CommonEvent
     */
    update(): void;
}

/**
 * -----------------------------------------------------------------------------
 * Game_CharacterBase
 *
 * The superdeclare class of Game_Character. It handles basic information, such as
 * coordinates and images, shared by all characters.
 * @class Game_CharacterBase
 */
declare class Game_CharacterBase {
    protected _x: number;
    protected _y: number;
    protected _realX: number;
    protected _realY: number;
    protected _moveSpeed: number;
    protected _moveFrequency: number;
    protected _opacity: number;
    protected _blendMode: number;
    protected _direction: number;
    protected _pattern: number;
    protected _priorityType: number;
    protected _tileId: number;
    protected _characterName: string;
    protected _characterIndex: number;
    protected _isObjectCharacter: boolean;
    protected _walkAnime: boolean;
    protected _stepAnime: boolean;
    protected _directionFix: boolean;
    protected _through: boolean;
    protected _transparent: boolean;
    protected _bushDepth: number;
    protected _animationId: number;
    protected _balloonId: number;
    protected _animationPlaying: boolean;
    protected _balloonPlaying: boolean;
    protected _animationCount: number;
    protected _stopCount: number;
    protected _jumpCount: number;
    protected _jumpPeak: number;
    protected _movementSuccess: boolean;

    /** [read-only] */
    x: number;
    /** [read-only] */
    y: number;

    initMembers(): void;
    pos(x: number, y: number): boolean;
    posNt(x: number, y: number): boolean;
    /**
     * Returns the move speed of the game character.
     * 
     * @returns {number} 
     * @memberof Game_CharacterBase
     */
    moveSpeed(): number;
    setMoveSpeed(moveSpeed: number): void;
    /**
     * Returns the move frequency of the character.
     * 
     * @returns {number} 
     * @memberof Game_CharacterBase
     */
    moveFrequency(): number;
    setMoveFrequency(moveFrequency: number): void;
    opacity(): number;
    setOpacity(opacity: number): void;
    /**
     * Returns the blend mode of the character;
     * these are represented by numbers.
     * @returns {number} 
     * @memberof Game_CharacterBase
     */
    blendMode(): number;
    /**
     * Sets the blend mode of the character;
     * these are represented by numbers.
     * @param {number} blendMode 
     * @memberof Game_CharacterBase
     */
    setBlendMode(blendMode: number): void;
    /**
     * Returns true if the character is
     * normal priority; this means you can collide with them.
     * @returns {boolean} 
     * @memberof Game_CharacterBase
     */
    isNormalPriority(): boolean;
    setPriorityType(priorityType: number): void;
    /**
     * Returns true if the character is moving.
     * 
     * @returns {boolean} 
     * @memberof Game_CharacterBase
     */
    isMoving(): boolean;
    /**
     * Returns true if the character is jumping.
     * 
     * @returns {boolean} 
     * @memberof Game_CharacterBase
     */
    isJumping(): boolean;
    /**
     * Returns the jump height of base character.
     * 
     * @returns {number} 
     * @memberof Game_CharacterBase
     */
    jumpHeight(): number;
    /**
     * Returns true if the character is stopping.
     * 
     * @returns {boolean} 
     * @memberof Game_CharacterBase
     */
    isStopping(): boolean;
    checkStop(threshold: number): boolean;
    /**
     * Resets the step count of the character.
     * 
     * @memberof Game_CharacterBase
     */
    resetStopCount(): void;
    realMoveSpeed(): number;
    distancePerFrame(): number;
    /**
     * Returns true if the character is dashing.
     * 
     * @returns {boolean} 
     * @memberof Game_CharacterBase
     */
    isDashing(): boolean;
    isDebugThrough(): boolean;
    /**
     * Straightens the character.
     * 
     * @memberof Game_CharacterBase
     */
    straighten(): void;
    reverseDir(d: number): number;
    canPass(x: number, y: number, d: number): boolean;
    canPassDiagonally(x: number, y: number, horz: number, vert: number): boolean;
    isMapPassable(x: number, y: number, d: number): boolean;
    isCollidedWithCharacters(x: number, y: number): boolean;
    isCollidedWithEvents(x: number, y: number): boolean;
    isCollidedWithVehicles(x: number, y: number): boolean;
    setPosition(x: number, y: number): void;
    copyPosition(character: Game_Player): void;
    locate(x: number, y: number): void;
    direction(): number;
    /**
     * Sets the direction of the character based on numpad
     * directions.
     * @param {number} d 
     * @memberof Game_CharacterBase
     */
    setDirection(d: number): void;
    /**
     * Returns true if the character is a tile; these
     * are events without character sprites.
     * @returns {boolean} 
     * @memberof Game_CharacterBase
     */
    isTile(): boolean;
    /**
     * Returns true if the character is an object character;
     * these are events with character sprites.
     * @returns {boolean} 
     * @memberof Game_CharacterBase
     */
    isObjectCharacter(): boolean;
    shiftY(): number;
    scrolledX(): number;
    scrolledY(): number;
    /**
     * Returns the character's screen x position.
     * 
     * @returns {number} 
     * @memberof Game_CharacterBase
     */
    screenX(): number;
    /**
     * Returns the character's screen y position.
     * 
     * @returns {number} 
     * @memberof Game_CharacterBase
     */
    screenY(): number;
    /**
     * Returns the character's screen z position.
     * 
     * @returns {number} 
     * @memberof Game_CharacterBase
     */
    screenZ(): number;
    isNearTheScreen(): boolean;
    update(): void;
    updateStop(): void;
    updateJump(): void;
    updateMove(): void;
    updateAnimation(): void;
    animationWait(): number;
    /**
     * Updates the character's animation count.
     * 
     * @memberof Game_CharacterBase
     */
    updateAnimationCount(): void;
    updatePattern(): void;
    maxPattern(): number;
    /**
     * Returns the pattern of the character; these are the walking 
     * patterns.
     * @returns {number} 
     * @memberof Game_CharacterBase
     */
    pattern(): number;
    /**
     * Sets the pattern of the character, given 
     * a pattern number.
     * @param {number} pattern 
     * @memberof Game_CharacterBase
     */
    setPattern(pattern: number): void;
    isOriginalPattern(): boolean;
    /**
     * Resets the pattern of the character.
     * 
     * @memberof Game_CharacterBase
     */
    resetPattern(): void;
    refreshBushDepth(): void;
    isOnLadder(): boolean;
    isOnBush(): boolean;
    /**
     * Returns the terrain tag of the character.
     * 
     * @returns {number} 
     * @memberof Game_CharacterBase
     */
    terrainTag(): number;
    /**
     * Returns the region id of the character.
     * 
     * @returns {number} 
     * @memberof Game_CharacterBase
     */
    regionId(): number;
    /**
     * Increases the character steps.
     * 
     * @memberof Game_CharacterBase
     */
    increaseSteps(): void;
    /**
     * Returns the tile id of character.
     * 
     * @returns {number} 
     * @memberof Game_CharacterBase
     */
    tileId(): number;
    characterName(): string;
    characterIndex(): number;
    setImage(characterName: string, characterIndex: number): void;
    setTileImage(tileId: number): void;
    checkEventTriggerTouchFront(d: number): void;
    checkEventTriggerTouch(x: number, y: number): boolean;
    isMovementSucceeded(x: number, y: number): boolean;
    setMovementSuccess(success: boolean): void;
    moveStraight(d: number): void;
    moveDiagonally(horz: number, vert: number): void;
    jump(xPlus: number, yPlus: number): void;
    hasWalkAnime(): boolean;
    setWalkAnime(walkAnime: boolean): void;
    /**
     * Returns true if the character has step animation.
     * 
     * @returns {boolean} 
     * @memberof Game_CharacterBase
     */
    hasStepAnime(): boolean;
    setStepAnime(stepAnime: boolean): void;
    /**
     * Returns true if the character is set to a fixed direction.
     * 
     * @returns {boolean} 
     * @memberof Game_CharacterBase
     */
    isDirectionFixed(): boolean;
    /**
     * Sets the character to be fixed in a specified direction
     * given a boolean value.
     * @param {boolean} directionFix 
     * @memberof Game_CharacterBase
     */
    setDirectionFix(directionFix: boolean): void;
    /**
     * Returns true if the character is set to pass through.
     * 
     * @returns {boolean} 
     * @memberof Game_CharacterBase
     */
    isThrough(): boolean;
    setThrough(through: boolean): void;
    isTransparent(): boolean;
    /**
     * Returns the bush depth around the character.
     * 
     * @returns {number} 
     * @memberof Game_CharacterBase
     */
    bushDepth(): number;
    setTransparent(transparent: boolean): void;
    /**
     * Requests an animation given the animation id.
     * 
     * @param {number} animationId 
     * @memberof Game_CharacterBase
     */
    requestAnimation(animationId: number): void;
    /**
     * Requests the balloon animation given the balloon id.
     * 
     * @param {number} balloonId 
     * @memberof Game_CharacterBase
     */
    requestBalloon(balloonId: number): void;
    /**
     * Returns the animation id.
     * 
     * @returns {number} 
     * @memberof Game_CharacterBase
     */
    animationId(): number;
    /**
     * Returns the id of the balloon animation.
     * 
     * @returns {number} 
     * @memberof Game_CharacterBase
     */
    balloonId(): number;
    /**
     * Starts the requested animation.
     * 
     * @memberof Game_CharacterBase
     */
    startAnimation(): void;
    /**
     * Stars a balloon animation.
     * 
     * @memberof Game_CharacterBase
     */
    startBalloon(): void;
    isAnimationPlaying(): boolean;
    /**
     * Returns true if a balloon animation is playing.
     * 
     * @returns {boolean} 
     * @memberof Game_CharacterBase
     */
    isBalloonPlaying(): boolean;
    endAnimation(): void;
    /**
     * Ends the balloon animation on the character.
     * 
     * @memberof Game_CharacterBase
     */
    endBalloon(): void;
}

/**
 * -----------------------------------------------------------------------------
 * Game_Character
 *
 * The superdeclare class of Game_Player, Game_Follower, GameVehicle, and Game_Event.
 * @class Game_Character
 */
declare class Game_Character extends Game_CharacterBase {
    static ROUTE_END: number;
    static ROUTE_MOVE_DOWN: number;
    static ROUTE_MOVE_LEFT: number;
    static ROUTE_MOVE_RIGHT: number;
    static ROUTE_MOVE_UP: number;
    static ROUTE_MOVE_LOWER_L: number;
    static ROUTE_MOVE_LOWER_R: number;
    static ROUTE_MOVE_UPPER_L: number;
    static ROUTE_MOVE_UPPER_R: number;
    static ROUTE_MOVE_RANDOM: number;
    static ROUTE_MOVE_TOWARD: number;
    static ROUTE_MOVE_AWAY: number;
    static ROUTE_MOVE_FORWARD: number;
    static ROUTE_MOVE_BACKWARD: number;
    static ROUTE_JUMP: number;
    static ROUTE_WAIT: number;
    static ROUTE_TURN_DOWN: number;
    static ROUTE_TURN_LEFT: number;
    static ROUTE_TURN_RIGHT: number;
    static ROUTE_TURN_UP: number;
    static ROUTE_TURN_90D_R: number;
    static ROUTE_TURN_90D_L: number;
    static ROUTE_TURN_180D: number;
    static ROUTE_TURN_90D_R_L: number;
    static ROUTE_TURN_RANDOM: number;
    static ROUTE_TURN_TOWARD: number;
    static ROUTE_TURN_AWAY: number;
    static ROUTE_SWITCH_ON: number;
    static ROUTE_SWITCH_OFF: number;
    static ROUTE_CHANGE_SPEED: number;
    static ROUTE_CHANGE_FREQ: number;
    static ROUTE_WALK_ANIME_ON: number;
    static ROUTE_WALK_ANIME_OFF: number;
    static ROUTE_STEP_ANIME_ON: number;
    static ROUTE_STEP_ANIME_OFF: number;
    static ROUTE_DIR_FIX_ON: number;
    static ROUTE_DIR_FIX_OFF: number;
    static ROUTE_THROUGH_ON: number;
    static ROUTE_THROUGH_OFF: number;
    static ROUTE_TRANSPARENT_ON: number;
    static ROUTE_TRANSPARENT_OFF: number;
    static ROUTE_CHANGE_IMAGE: number;
    static ROUTE_CHANGE_OPACITY: number;
    static ROUTE_CHANGE_BLEND_MODE: number;
    static ROUTE_PLAY_SE: number;
    static ROUTE_SCRIPT: number;

    protected _moveRouteForcing: boolean;
    protected _moveRoute: RPG.MoveRoute;
    protected _moveRouteIndex: number;
    protected _originalMoveRoute: RPG.MoveRoute;
    protected _originalMoveRouteIndex: number;
    protected _waitCount: number;

    initMembers(): void;
    /**
     * Memorizes the movement route.
     * 
     * @memberof Game_Character
     */
    memorizeMoveRoute(): void;
    /**
     * Restores the original movement route.
     * 
     * @memberof Game_Character
     */
    restoreMoveRoute(): void;
    /**
     * Returns true if the move route is being forced.
     * 
     * @returns {boolean} 
     * @memberof Game_Character
     */
    isMoveRouteForcing(): boolean;
    /**
     * Sets the move route of the game character.
     * 
     * @param {RPG.MoveRoute} moveRoute 
     * @memberof Game_Character
     */
    setMoveRoute(moveRoute: RPG.MoveRoute): void;
    /**
     * Forces the move route of the game character.
     * 
     * @param {RPG.MoveRoute} moveRoute 
     * @memberof Game_Character
     */
    forceMoveRoute(moveRoute: RPG.MoveRoute): void;
    updateStop(): void;
    /**
     * Updates the game character's move routine.
     * 
     * @memberof Game_Character
     */
    updateRoutineMove(): void;
    /**
     * Processes the given move commands.
     * 
     * @param {RPG.MoveCommand} command 
     * @memberof Game_Character
     */
    processMoveCommand(command: RPG.MoveCommand): void;
    deltaXFrom(x: number): number;
    deltaYFrom(y: number): number;
    /**
     * Move's the game character at random.
     * 
     * @memberof Game_Character
     */
    moveRandom(): void;
    /**
     * Moves the game character toward the other game character.
     * 
     * @param {Game_Character} character 
     * @memberof Game_Character
     */
    moveTowardCharacter(character: Game_Character): void;
    /**
     * Moves the game character away from the other game character.
     * 
     * @param {Game_Character} character 
     * @memberof Game_Character
     */
    moveAwayFromCharacter(character: Game_Character): void;
    /**
     * Turns the game character toward the other game character.
     * 
     * @param {Game_Character} character 
     * @memberof Game_Character
     */
    turnTowardCharacter(character: Game_Character): void;
    /**
     * Turns the game character away from the other game character.
     * 
     * @param {Game_Character} character 
     * @memberof Game_Character
     */
    turnAwayFromCharacter(character: Game_Character): void;
    /**
     * Turns the game character toward the player.
     * 
     * @memberof Game_Character
     */
    turnTowardPlayer(): void;
    /**
     * Turns the game character away from the player.
     * 
     * @memberof Game_Character
     */
    turnAwayFromPlayer(): void;
    /**
     * Moves the game character toward the player.
     * 
     * @memberof Game_Character
     */
    moveTowardPlayer(): void;
    /**
     * Moves the game character away from the player.
     * 
     * @memberof Game_Character
     */
    moveAwayFromPlayer(): void;
    /**
     * Moves the game character forward.
     * 
     * @memberof Game_Character
     */
    moveForward(): void;
    /**
     * Moves the game character backward.
     * 
     * @memberof Game_Character
     */
    moveBackward(): void;
    /**
     * Handles the end of the move route.
     * 
     * @memberof Game_Character
     */
    processRouteEnd(): void;
    advanceMoveRouteIndex(): void;
    /**
     * Turns the game character right by 90 degrees.
     * 
     * @memberof Game_Character
     */
    turnRight90(): void;
    /**
     * Turns the game character left by 90 degrees.
     * 
     * @memberof Game_Character
     */
    turnLeft90(): void;
    turn180(): void;
    /**
     * Turns the game character or left by 90 degrees.
     * 
     * @memberof Game_Character
     */
    turnRightOrLeft90(): void;
    /**
     * Turns the game character at random.
     * 
     * @memberof Game_Character
     */
    turnRandom(): void;
    swap(character: Game_Character): void;
    findDirectionTo(goalX: number, goalY: number): number;
    /**
     * Returns the search limit for path finding.
     * 
     * @returns {number} 
     * @memberof Game_Character
     */
    searchLimit(): number;
}

/**
 * -----------------------------------------------------------------------------
 * Game_Player
 *
 * The game object declare class for the player. It contains event starting
 * determinants and map scrolling functions.
 * @class Game_Player
 */
declare class Game_Player extends Game_Character {
    protected _vehicleType: string;
    protected _vehicleGettingOn: boolean;
    protected _vehicleGettingOff: boolean;
    protected _dashing: boolean;
    protected _needsMapReload: boolean;
    protected _transferring: boolean;
    protected _newMapId: number;
    protected _newX: number;
    protected _newY: number;
    protected _newDirection: number;
    protected _fadeType: number;
    protected _followers: Game_Followers;
    protected _encounterCount: number;

    /**
     * Clears the transfer information for the player.
     * 
     * @memberof Game_Player
     */
    clearTransferInfo(): void;
    /**
     * Returns the player followers (party members).
     * 
     * @returns {Game_Followers} 
     * @memberof Game_Player
     */
    followers(): Game_Followers;
    /**
     * Refreshes the game player.
     * 
     * @memberof Game_Player
     */
    refresh(): void;
    /**
     * Returns true if the player is stopping.
     * 
     * @returns {boolean} 
     * @memberof Game_Player
     */
    isStopping(): boolean;
    /**
     * Reserves a transfer of the player to the specified map, at the given
     * x and y coordinates, facing the given direction (d). Using a specific fade.
     * @param {number} mapId 
     * @param {number} x 
     * @param {number} y 
     * @param {number} [d] 
     * @param {number} [fadeType] 
     * @memberof Game_Player
     */
    reserveTransfer(mapId: number, x: number, y: number, d?: number, fadeType?: number): void;
    requestMapReload(): void;
    isTransferring(): boolean;
    /**
     * Returns the new map id.
     * 
     * @returns {number} 
     * @memberof Game_Player
     */
    newMapId(): number;
    fadeType(): number;
    /**
     * Performs a transfer of the player to a different area or map.
     * 
     * @memberof Game_Player
     */
    performTransfer(): void;
    isMapPassable(x: number, y: number, d: number): boolean;
    /**
     * Returns the current vehicles the player is riding in.
     * 
     * @returns {Game_Vehicle} 
     * @memberof Game_Player
     */
    vehicle(): Game_Vehicle;
    /**
     * Returns true if the player is in a boat.
     * 
     * @returns {boolean} 
     * @memberof Game_Player
     */
    isInBoat(): boolean;
    /**
     * Returns true if the player is in a ship.
     * 
     * @returns {boolean} 
     * @memberof Game_Player
     */
    isInShip(): boolean;
    /**
     * Returns true if the player is in an airship.
     * 
     * @returns {boolean} 
     * @memberof Game_Player
     */
    isInAirship(): boolean;
    /**
     * Returns true if the player is in a vehicle.
     * 
     * @returns {boolean} 
     * @memberof Game_Player
     */
    isInVehicle(): boolean;
    /**
     * Returns true if the player is in their normal state.
     * 
     * @returns {boolean} 
     * @memberof Game_Player
     */
    isNormal(): boolean;
    /**
     * Returns true if the player is dashing.
     * 
     * @returns {boolean} 
     * @memberof Game_Player
     */
    isDashRing(): boolean;
    isDebugThrough(): boolean;
    isCollided(x: number, y: number): boolean;
    /**
     * Returns the player's center x coordinate.
     * 
     * @returns {number} 
     * @memberof Game_Player
     */
    centerX(): number;
    /**
     * Returns the player's center y coordinate.
     * 
     * @returns {number} 
     * @memberof Game_Player
     */
    centerY(): number;
    center(x: number, y: number): void;
    locate(x: number, y: number): void;
    increaseSteps(): void;
    /**
     * Creates the encounter count for the player.
     * 
     * @memberof Game_Player
     */
    makeEncounterCount(): void;
    /**
     * Creates the encounter troop id and returns it.
     * 
     * @returns {number} 
     * @memberof Game_Player
     */
    makeEncounterTroopId(): number;
    meetsEncounterConditions(encounter: RPG.Map.Encounter): boolean;
    /**
     * Executes an encounter.
     * 
     * @returns {boolean} 
     * @memberof Game_Player
     */
    executeEncounter(): boolean;
    /**
     * Has the player start a map event at the given x and y coordinates.
     * Also passing the triggers and whether the event start is normal.
     * @param {number} x 
     * @param {number} y 
     * @param {Array<number>} triggers 
     * @param {boolean} normal 
     * @memberof Game_Player
     */
    startMapEvent(x: number, y: number, triggers: Array<number>, normal: boolean): void;
    moveByInput(): void;
    /**
     * Returns true if the player can move.
     * 
     * @returns {boolean} 
     * @memberof Game_Player
     */
    canMove(): boolean;
    /**
     * Gets the input direction of the player as a number.
     * 
     * @returns {number} 
     * @memberof Game_Player
     */
    getInputDirection(): number;
    executeMove(direction: number): void;
    update(sceneActive?: boolean): void;
    /**
     * Updates the dashing of the player.
     * 
     * @memberof Game_Player
     */
    updateDashing(): void;
    /**
     * Returns true if the dash button is pressed.
     * 
     * @returns {boolean} 
     * @memberof Game_Player
     */
    isDashButtonPressed(): boolean;
    updateScroll(lastScrolledX: number, lastScrolledY: number): void;
    /**
     * Updates the vehicle.
     * 
     * @memberof Game_Player
     */
    updateVehicle(): void;
    /**
     * Updates the player getting on the vehicle.
     * 
     * @memberof Game_Player
     */
    updateVehicleGetOn(): void;
    /**
     * Updates the player getting off the vehicle.
     * 
     * @memberof Game_Player
     */
    updateVehicleGetOff(): void;
    updateNonmoving(wasMoving: boolean): void;
    triggerAction(): boolean;
    triggerButtonAction(): boolean;
    /**
     * Returns true if the player triggered a touch action.
     * 
     * @returns {boolean} 
     * @memberof Game_Player
     */
    triggerTouchAction(): boolean;
    triggerTouchActionD1(x1: number, y1: number): boolean;
    triggerTouchActionD2(x2: number, y2: number): boolean;
    triggerTouchActionD3(x2: number, y2: number): boolean;
    /**
     * Updates the player encounter count.
     * 
     * @memberof Game_Player
     */
    updateEncounterCount(): void;
    /**
     * Returns true if the player can encounter enemies.
     * 
     * @returns {boolean} 
     * @memberof Game_Player
     */
    canEncounter(): boolean;
    /**
     * Returns the encounter progress value of the player.
     * 
     * @returns {number} 
     * @memberof Game_Player
     */
    encounterProgressValue(): number;
    checkEventTriggerHere(triggers: Array<number>): void;
    checkEventTriggerThere(triggers: Array<number>): void;
    /**
     * Returns true if the player can start local events.
     * 
     * @returns {boolean} 
     * @memberof Game_Player
     */
    canStartLocalEvents(): boolean;
    /**
     * Returns true if the player is getting on/off a vehicle.
     * 
     * @returns {boolean} 
     * @memberof Game_Player
     */
    getOnOffVehicle(): boolean;
    /**
     * Returns true if the player is getting on a vehicle.
     * 
     * @returns {boolean} 
     * @memberof Game_Player
     */
    getOnVehicle(): boolean;
    /**
     * Returns true if the player is getting off a vehicle.
     * 
     * @returns {boolean} 
     * @memberof Game_Player
     */
    getOffVehicle(): boolean;
    /**
     * Forces the player to move forward.
     * 
     * @memberof Game_Player
     */
    forceMoveForward(): void;
    /**
     * Returns true if the player is on a floor that does damage.
     * 
     * @returns {boolean} 
     * @memberof Game_Player
     */
    isOnDamageFloor(): boolean;
    /**
     * Moves the player straight, given a direction.
     * 
     * @param {number} d 
     * @memberof Game_Player
     */
    moveStraight(d: number): void;
    /**
     * Moves the player diagonally, given a horizontal
     * and vertical direction. The numpad represents the directions.
     * @param {number} horz 
     * @param {number} vert 
     * @memberof Game_Player
     */
    moveDiagonally(horz: number, vert: number): void;
    /**
     * Has the player jump in the given direction at the specified
     * x and y coordinate. This x and y will be added to the player's current
     * position. 
     * @param {number} xPlus 
     * @param {number} yPlus 
     * @memberof Game_Player
     */
    jump(xPlus: number, yPlus: number): void;
    /**
     * Shows the player followers.
     * 
     * @memberof Game_Player
     */
    showFollowers(): void;
    /**
     * Hides the player followers.
     * 
     * @memberof Game_Player
     */
    hideFollowers(): void;
    /**
     * Gather followers around the player.
     * 
     * @memberof Game_Player
     */
    gatherFollowers(): void;
    /**
     * Returns true if the followers are currently gathering.
     * 
     * @returns {boolean} 
     * @memberof Game_Player
     */
    areFollowersGathering(): boolean;
    /**
     * Returns true if the followers are gathered.
     * 
     * @returns {boolean} 
     * @memberof Game_Player
     */
    areFollowersGathered(): boolean;
}

/**
 * -----------------------------------------------------------------------------
 * Game_Follower
 *
 * The game object declare class for a follower. A follower is an allied character,
 * other than the front character, displayed in the party.
 * @class Game_Follower
 */
declare class Game_Follower extends Game_Character {
    protected _memberIndex: number;

    constructor(memberIndex: number);

    refresh(): void;
    /**
     * Returns the current actor.
     * 
     * @returns {Game_Actor} 
     * @memberof Game_Follower
     */
    actor(): Game_Actor;
    /**
     * Returns true if the follower is visible.
     * 
     * @returns {boolean} 
     * @memberof Game_Follower
     */
    isVisible(): boolean;
    /**
     * Updates the game follower.
     * 
     * @memberof Game_Follower
     */
    update(): void;
    /**
     * Has the follower chase a game actor.
     * 
     * @param {Game_Character} character 
     * @memberof Game_Follower
     */
    chaseCharacter(character: Game_Character): void;
}

/**
 * -----------------------------------------------------------------------------
 * Game_Followers
 *
 * The wrapper declare class for a follower array.
 * @class Game_Followers
 */
declare class Game_Followers {
    protected _visible: boolean;
    protected _gathering: boolean;
    protected _data: Array<Game_Follower>;

    /**
     * Returns true if the followers are visible.
     * 
     * @returns {boolean} 
     * @memberof Game_Followers
     */
    isVisible(): boolean;
    /**
     * Shows  the followers.
     * 
     * @memberof Game_Followers
     */
    show(): void;
    /**
     * Hides the followers.
     * 
     * @memberof Game_Followers
     */
    hide(): void;
    /**
     * Returns the followers at the specified index.
     * 
     * @param {number} index 
     * @returns {Game_Follower} 
     * @memberof Game_Followers
     */
    follower(index: number): Game_Follower;
    forEach(callback: () => void, thisObject: any): void;
    reverseEach(callback: () => void, thisObject: any): void;
    /**
     * Refreshes the game followers.
     * 
     * @memberof Game_Followers
     */
    refresh(): void;
    /**
     * Updates the game followers.
     * 
     * @memberof Game_Followers
     */
    update(): void;
    /**
     * Updates the movement of game followers.
     * 
     * @memberof Game_Followers
     */
    updateMove(): void;
    jumpAll(): void;
    synchronize(x: number, y: number, d: number): void;
    /**
     * Gathers the followers.
     * 
     * @memberof Game_Followers
     */
    gather(): void;
    /**
     * Returns true if the followers are gathering.
     * 
     * @returns {boolean} 
     * @memberof Game_Followers
     */
    areGathering(): boolean;
    /**
     * Returns the visible followers.
     * 
     * @returns {Array<Game_Follower>} 
     * @memberof Game_Followers
     */
    visibleFollowers(): Array<Game_Follower>;
    /**
     * Returns true if the followers are moving.
     * 
     * @returns {boolean} 
     * @memberof Game_Followers
     */
    areMoving(): boolean;
    /**
     * Returns true if the followers are gathered.
     * 
     * @returns {boolean} 
     * @memberof Game_Followers
     */
    areGathered(): boolean;
    /**
     * Returns true if the specified follower is collided at the specified x and y
     *coordinate.
     * 
     * @param {number} x 
     * @param {number} y 
     * @returns {boolean} 
     * @memberof Game_Followers
     */
    isSomeoneCollided(x: number, y: number): boolean;
}

/**
 * -----------------------------------------------------------------------------
 * Game_Vehicle
 *
 * The game object declare class for a vehicle.
 * @class Game_Vehicle
 */
declare class Game_Vehicle extends Game_Character {
    protected _type: string;
    protected _mapId: number;
    protected _altitude: number;
    protected _driving: boolean;
    protected _bgm: RPG.AudioFile;

    constructor(type: string);
    initMembers(): void;
    /**
     * Returns true if the vehicle is a boat.
     * 
     * @returns {boolean} 
     * @memberof Game_Vehicle
     */
    isBoat(): boolean;
    /**
     * Returns true if the vehicle is a ship.
     * 
     * @returns {boolean} 
     * @memberof Game_Vehicle
     */
    isShip(): boolean;
    /**
     * Returns true if the vehicle is an airship.
     * 
     * @returns {boolean} 
     * @memberof Game_Vehicle
     */
    isAirship(): boolean;
    /**
     * Resets the direction of the vehicle.
     * 
     * @memberof Game_Vehicle
     */
    resetDirection(): void;
    initMoveSpeed(): void;
    /**
     * Returns the current vehicle.
     * 
     * @returns {RPG.System.Vehicle} 
     * @memberof Game_Vehicle
     */
    vehicle(): RPG.System.Vehicle;
    loadSystemSettings(): void;
    /**
     * Refreshes the game vehicle.
     * 
     * @memberof Game_Vehicle
     */
    refresh(): void;
    setLocation(mapId: number, x: number, y: number): void;
    pos(x: number, y: number): boolean;
    isMapPassable(x: number, y: number, d: number): boolean;
    /**
     * Gets on the vehicle.
     * 
     * @memberof Game_Vehicle
     */
    getOn(): void;
    /**
     * Gets off the vehicle.
     * 
     * @memberof Game_Vehicle
     */
    getOff(): void;
    /**
     * Sets the bgm associated with the vehicle.
     * 
     * @param {RPG.AudioFile} bgm 
     * @memberof Game_Vehicle
     */
    setBgm(bgm: RPG.AudioFile): void;
    /**
     * Plays the bgm associated with the vehicle.
     * 
     * @memberof Game_Vehicle
     */
    playBgm(): void;
    /**
     * Syncs the vehicle with the player.
     * 
     * @memberof Game_Vehicle
     */
    syncWithPlayer(): void;
    /**
     * Returns the screen y position of the vehicle.
     * 
     * @returns {number} 
     * @memberof Game_Vehicle
     */
    screenY(): number;
    /**
     * Returns the shadow x position of the vehicle's shadow.
     * 
     * @returns {number} 
     * @memberof Game_Vehicle
     */
    shadowX(): number;
    /**
     * Returns the shadow y position of the vehicle's shadow.
     * 
     * @returns {number} 
     * @memberof Game_Vehicle
     */
    shadowY(): number;
    /**
     * Returns the shadow opacity of the vehicle's shadow.
     * 
     * @returns {number} 
     * @memberof Game_Vehicle
     */
    shadowOpacity(): number;
    /**
     * Returns true if the vehicle can move.
     * 
     * @returns {boolean} 
     * @memberof Game_Vehicle
     */
    canMove(): boolean;
    /**
     * Updates the vehicle.
     * 
     * @memberof Game_Vehicle
     */
    update(): void;
    /**
     * Updates the airship.
     * 
     * @memberof Game_Vehicle
     */
    updateAirship(): void;
    /**
     * Updates airship altitude.
     * 
     * @memberof Game_Vehicle
     */
    updateAirshipAltitude(): void;
    /**
     * Returns the max altitude of the vehicle.
     * 
     * @returns {number} 
     * @memberof Game_Vehicle
     */
    maxAltitude(): number;
    /**
     * Returns true if the vehicle is at it's lowest altitude.
     * 
     * @returns {boolean} 
     * @memberof Game_Vehicle
     */
    isLowest(): boolean;
    /**
     * Returns true if the vehicle is at it's highest altitude.
     * 
     * @returns {boolean} 
     * @memberof Game_Vehicle
     */
    isHighest(): boolean;
    /**
     * Returns true if take off is ok.
     * 
     * @returns {boolean} 
     * @memberof Game_Vehicle
     */
    isTakeoffOk(): boolean;
    /**
     * Returns true if the vehicle is capable of landing at the specified
     * x, y coordinate, with the specified direction (d).
     * @param {number} x 
     * @param {number} y 
     * @param {number} d 
     * @returns {boolean} 
     * @memberof Game_Vehicle
     */
    isLandOk(x: number, y: number, d: number): boolean;
}

/**
 * -----------------------------------------------------------------------------
 * Game_Event
 *
 * The game object declare class for an event. It contains functionality for event page
 * switching and running parallel process events.
 * @class Game_Event
 */
declare class Game_Event extends Game_Character {
    protected _mapId: number;
    protected _eventId: number;
    protected _moveType: number;
    protected _trigger: number;
    protected _starting: boolean;
    protected _erased: boolean;
    protected _pageIndex: number;
    protected _originalPattern: number;
    protected _originalDirection: number;
    protected _prelockDirection: number;
    protected _locked: boolean;

    constructor(mapId: number, eventId: number);

    initMembers(): void;
    /**
     * Returns the event id of the game event.
     * 
     * @returns {number} 
     * @memberof Game_Event
     */
    eventId(): number;
    /**
     * Returns the event database information.
     * 
     * @returns {RPG.Event} 
     * @memberof Game_Event
     */
    event(): RPG.Event;
    /**
     * Returns the event page created in the database.
     * 
     * @returns {RPG.EventPage} 
     * @memberof Game_Event
     */
    page(): RPG.EventPage;
    /**
     * Returns the list of event commands on the current page of the game event.
     * 
     * @returns {Array<RPG.EventCommand>} 
     * @memberof Game_Event
     */
    list(): Array<RPG.EventCommand>;
    isCollidedWithCharacters(x: number, y: number): boolean;
    isCollidedWithEvents(x: number, y: number): boolean;
    /**
     * Returns true if the event has collided with the player character
     * at the specified x and y coordinates.
     * @param {number} x 
     * @param {number} y 
     * @returns {boolean} 
     * @memberof Game_Event
     */
    isCollidedWithPlayerCharacters(x: number, y: number): boolean;
    /**
     * Locks the game event.
     * 
     * @memberof Game_Event
     */
    lock(): void;
    /**
     * Unlocks the game event.
     * 
     * @memberof Game_Event
     */
    unlock(): void;
    updateStop(): void;
    /**
     * Updates the self movement of the game event.
     * 
     * @memberof Game_Event
     */
    updateSelfMovement(): void;
    stopCountThreshold(): number;
    moveTypeRandom(): void;
    moveTypeTowardPlayer(): void;
    /**
     * Returns true if the game event is near the player.
     * 
     * @returns {boolean} 
     * @memberof Game_Event
     */
    isNearThePlayer(): boolean;
    moveTypeCustom(): void;
    /**
     * Returns true if the event is staring.
     * 
     * @returns {boolean} 
     * @memberof Game_Event
     */
    isStarting(): boolean;
    /**
     * Clears the starting flag.
     * 
     * @memberof Game_Event
     */
    clearStartingFlag(): void;
    isTriggerIn(triggers: Array<number>): boolean;
    /**
     * Starts the game event.
     * 
     * @memberof Game_Event
     */
    start(): void;
    /**
     * Erases the event.
     * 
     * @memberof Game_Event
     */
    erase(): void;
    /**
     * Refreshes the game event.
     * 
     * @memberof Game_Event
     */
    refresh(): void;
    /**
     * Finds the proper page index of the game event for
     * event command processing.
     * @returns {number} 
     * @memberof Game_Event
     */
    findProperPageIndex(): number;
    meetsConditions(page: RPG.EventPage): boolean;
    /**
     * Sets up the event page.
     * 
     * @memberof Game_Event
     */
    setupPage(): void;
    /**
     * Clears the page settings of the game event.
     * 
     * @memberof Game_Event
     */
    clearPageSettings(): void;
    /**
     * Sets up the event page settings.
     * 
     * @memberof Game_Event
     */
    setupPageSettings(): void;
    isOriginalPattern(): boolean;
    /**
     * Resets the pattern of the game event.
     * 
     * @memberof Game_Event
     */
    resetPattern(): void;
    checkEventTriggerAuto(): void;
    update(): void;
    updateParallel(): void;
    locate(x: number, y: number): void;
    /**
     * Forces the game event to move along the specified route.
     * 
     * @param {RPG.MoveRoute} moveRoute 
     * @memberof Game_Event
     */
    forceMoveRoute(moveRoute: RPG.MoveRoute): void;
}

/**
 * -----------------------------------------------------------------------------
 * Game_Interpreter
 *
 * The interpreter for running event commands.
 * @class Game_Interpreter
 */
declare class Game_Interpreter {
    protected _depth: number;
    protected _branch: { [indent: number]: number | boolean };
    protected _params: Array<any>;
    protected _indent: number;
    protected _frameCount: number;
    protected _freezeChecker: number;
    protected _mapId: number;
    protected _eventId: number;
    protected _list: Array<RPG.EventCommand>;
    protected _index: number;
    protected _waitCount: number;
    protected _waitMode: string;
    protected _comments: string;
    protected _character: Game_Event;
    protected _childInterpreter: Game_Interpreter;

    constructor(depth: number);
    checkOverflow(): void;
    /**
     * Clears the interpreter.
     * 
     * @memberof Game_Interpreter
     */
    clear(): void;
    /**
     * Sets up the interpreter with the list of event commands, and the given
     * event Id.
     * 
     * @param {Array<RPG.EventCommand>} list 
     * @param {number} eventId 
     * @memberof Game_Interpreter
     */
    setup(list: Array<RPG.EventCommand>, eventId: number): void;
    /**
     * Returns the current eventId.
     * 
     * @returns {number} 
     * @memberof Game_Interpreter
     */
    eventId(): number;
    /**
     * Returns true if the event is on the current map.
     * 
     * @returns {boolean} 
     * @memberof Game_Interpreter
     */
    isOnCurrentMap(): boolean;
    /**
     * Returns true after setting up the reserved common event.
     * 
     * @returns {boolean} 
     * @memberof Game_Interpreter
     */
    setupReservedCommonEvent(): boolean;
    /**
     * Returns true if the interpreter is running.
     * 
     * @returns {boolean} 
     * @memberof Game_Interpreter
     */
    isRunning(): boolean;
    update(): void;
    /**
     * Updates the child game interpreter.
     * 
     * @returns {boolean} 
     * @memberof Game_Interpreter
     */
    updateChild(): boolean;
    /**
     * Updates the wait of the game interpreter.
     * 
     * @returns {boolean} 
     * @memberof Game_Interpreter
     */
    updateWait(): boolean;
    updateWaitCount(): boolean;
    updateWaitMode(): boolean;
    /**
     * Sets the wait mode of the interpreter.
     * 
     * @param {string} waitMode 
     * @memberof Game_Interpreter
     */
    setWaitMode(waitMode: string): void;
    /**
     * sets a specified wait duration for the interpreter.
     * 
     * @param {number} duration 
     * @memberof Game_Interpreter
     */
    wait(duration: number): void;
    fadeSpeed(): number;
    /**
     * Executes the event command;
     * returns true or false based on execution.
     * @returns {boolean} 
     * @memberof Game_Interpreter
     */
    executeCommand(): boolean;
    /**
     * Checks if the interpreter has frozen.
     * 
     * @returns {boolean} 
     * @memberof Game_Interpreter
     */
    checkFreeze(): boolean;
    /**
     * Terminates the game interpreter.
     * 
     * @memberof Game_Interpreter
     */
    terminate(): void;
    /**
     * Skips a conditional branch on the interpreter.
     * 
     * @memberof Game_Interpreter
     */
    skipBranch(): void;
    /**
     * Returns the current event command.
     * 
     * @returns {RPG.EventCommand} 
     * @memberof Game_Interpreter
     */
    currentCommand(): RPG.EventCommand;
    /**
     * Returns the next event code.
     * 
     * @returns {number} 
     * @memberof Game_Interpreter
     */
    nextEventCode(): number;
    iterateActorId(param: number, callback: (actor: Game_Actor) => void): void;
    iterateActorEx(param1: number, param2: number, callback: (actor: Game_Actor) => void): void;
    iterateActorIndex(param: number, callback: (actor: Game_Actor) => void): void;
    iterateEnemyIndex(param: number, callback: (enemy: Game_Enemy) => void): void;
    iterateBattler(param1: number, param2: number, callback: (battler: Game_Battler) => void): void;
    character(param: number): Game_Character;
    operateValue(operation: number, operandType: number, operand: number): number;
    changeHp(target: number, value: number, allowDeath: boolean): void;

    /**
     * Show Text
     */
    command101(): boolean;

    /**
     * Show Choices
     */
    command102(): boolean;
    setupChoices(params: Array<any>): void;

    /**
     * When [**]
     */
    command402(): boolean;

    /**
     * When Cancel
     */
    command403(): boolean;

    /**
     * Input Number
     */
    command103(): boolean;

    /**
     *
     * @param params
     */
    setupNumInput(params: Array<number>): void;

    /**
     * Select Item
     */
    command104(): boolean;
    setupItemChoice(params: Array<number>): void;

    /**
     * Show Scrolling Text
     */
    command105(): boolean;

    /**
     * Comment
     */
    command108(): boolean;

    /**
     * Conditional Branch
     */
    command111(): boolean;

    /**
     * Else
     */
    command411(): boolean;

    /**
     * Loop
     */
    command112(): boolean;

    /**
     * Repeat Above
     */
    command413(): boolean;

    /**
     * Break Loop
     */
    command113(): boolean;

    /**
     * Exit Event Processing
     */
    command115(): boolean;

    /**
     * Common Event
     */
    command117(): boolean;
    setupChild(list: Array<RPG.EventCommand>, eventId: number): void;

    /**
     * Label
     */
    command118(): boolean;

    /**
     * Jump to Label
     */
    command119(): boolean;
    jumpTo(index: number): void;

    /**
     * Control Switches
     */
    command121(): boolean;

    /**
     * Control Variables
     */
    command122(): boolean;
    gameDataOperand(type: number, param1: number, param2: number): number;
    operateVariable(variableId: number, operationType: number, value: number): void;

    /**
     * Control Self Switch
     */
    command123(): boolean;

    /**
     * Control Timer
     */
    command124(): boolean;

    /**
     * Change Gold
     */
    command125(): boolean;

    /**
     * Change Items
     */
    command126(): boolean;

    /**
     * Change Weapons
     */
    command127(): boolean;

    /**
     * Change Armors
     */
    command128(): boolean;

    /**
     * Change Party Member
     */
    command129(): boolean;

    /**
     * Change Battle BGM
     */
    command132(): boolean;

    /**
     * Change Victory ME
     */
    command133(): boolean;

    /**
     * Change Save Access
     */
    command134(): boolean;

    /**
     * Change Menu Access
     */
    command135(): boolean;

    /**
     * Change Encounter Disable
     */
    command136(): boolean;

    /**
     * Change Formation Access
     */
    command137(): boolean;

    /**
     * Change Window Color
     */
    command138(): boolean;

    /**
     * Change Defeat ME
     */
    command139(): boolean;

    /**
     * Change Vehicle BGM
     */
    command140(): boolean;

    /**
     * Transfer Player
     */
    command201(): boolean;

    /**
     * Set Vehicle Location
     */
    command202(): boolean;

    /**
     * Set Event Location
     */
    command203(): boolean;

    /**
     * Scroll Map
     */
    command204(): boolean;

    /**
     * Set Movement Route
     */
    command205(): boolean;

    /**
     * Getting On and Off Vehicles
     */
    command206(): boolean;

    /**
     * Change Transparency
     */
    command211(): boolean;

    /**
     * Show Animation
     */
    command212(): boolean;

    /**
     * Show Balloon Icon
     */
    command213(): boolean;

    /**
     * Erase Event
     */
    command214(): boolean;

    /**
     * Change Player Followers
     */
    command216(): boolean;

    /**
     * Gather Followers
     */
    command217(): boolean;

    /**
     * Fadeout Screen
     */
    command221(): boolean;

    /**
     * Fadein Screen
     */
    command222(): boolean;

    /**
     * Tint Screen
     */
    command223(): boolean;

    /**
     * Flash Screen
     */
    command224(): boolean;

    /**
     * Shake Screen
     */
    command225(): boolean;

    /**
     * Wait
     */
    command230(): boolean;

    /**
     * Show Picture
     */
    command231(): boolean;

    /**
     * Move Picture
     */
    command232(): boolean;

    /**
     * Rotate Picture
     */
    command233(): boolean;

    /**
     * Tint Picture
     */
    command234(): boolean;

    /**
     * Erase Picture
     */
    command235(): boolean;

    /**
     * Set Weather Effect
     */
    command236(): boolean;

    /**
     * Play BGM
     */
    command241(): boolean;

    /**
     * Fadeout BGM
     */
    command242(): boolean;

    /**
     * Save BGM
     */
    command243(): boolean;

    /**
     * Resume BGM
     */
    command244(): boolean;

    /**
     * Play BGS
     */
    command245(): boolean;

    /**
     * Fadeout BGS
     */
    command246(): boolean;

    /**
     * Play ME
     */
    command249(): boolean;

    /**
     * Play SE
     */
    command250(): boolean;

    /**
     * Stop SE
     */
    command251(): boolean;

    /**
     * Play Movie
     */
    command261(): boolean;
    videoFileExt(): string;

    /**
     * Change Map Name Display
     */
    command281(): boolean;

    /**
     * Change Tileset
     */
    command282(): boolean;

    /**
     * Change Battle Back
     */
    command283(): boolean;

    /**
     * Change Parallax
     */
    command284(): boolean;

    /**
     * Get Location Info
     */
    command285(): boolean;

    /**
     * Battle Processing
     */
    command301(): boolean;

    /**
     * If Win
     */
    command601(): boolean;

    /**
     * If Escape
     */
    command602(): boolean;

    /**
     * If Lose
     */
    command603(): boolean;

    /**
     * Shop Processing
     */
    command302(): boolean;

    /**
     * Name Input Processing
     */
    command303(): boolean;

    /**
     * Change HP
     */
    command311(): boolean;

    /**
     * Change MP
     */
    command312(): boolean;

    /**
     * Change TP
     */
    command326(): boolean;

    /**
     * Change State
     */
    command313(): boolean;

    /**
     * Recover All
     */
    command314(): boolean;

    /**
     * Change EXP
     */
    command315(): boolean;

    /**
     * Change Level
     */
    command316(): boolean;

    /**
     * Change Parameter
     */
    command317(): boolean;

    /**
     * Change Skill
     */
    command318(): boolean;

    /**
     * Change Equipment
     */
    command319(): boolean;

    /**
     * Change Name
     */
    command320(): boolean;

    /**
     * Change Class
     */
    command321(): boolean;

    /**
     * Change Actor Images
     */
    command322(): boolean;

    /**
     * Change Vehicle Image
     */
    command323(): boolean;

    /**
     * Change Nickname
     */
    command324(): boolean;

    /**
     * Change Profile
     */
    command325(): boolean;

    /**
     * Change Enemy HP
     */
    command331(): boolean;

    /**
     * Change Enemy MP
     */
    command332(): boolean;

    /**
     * Change Enemy TP
     */
    command342(): boolean;

    /**
     * Change Enemy State
     */
    command333(): boolean;

    /**
     * Enemy Recover All
     */
    command334(): boolean;

    /**
     * Enemy Appear
     */
    command335(): boolean;

    /**
     * Enemy Transform
     */
    command336(): boolean;

    /**
     * Show Battle Animation
     */
    command337(): boolean;

    /**
     * Force Action
     */
    command339(): boolean;

    /**
     * Abort Battle
     */
    command340(): boolean;

    /**
     * Open Menu Screen
     */
    command351(): boolean;

    /**
     * Open Save Screen
     */
    command352(): boolean;

    /**
     * Game Over
     */
    command353(): boolean;

    /**
     * Return to Title Screen
     */
    command354(): boolean;

    /**
     * Script
     */
    command355(): boolean;

    /**
     * Plugin Command
     */
    command356(): boolean;
    pluginCommand(command: string, args: Array<string>): void;
}


declare class Scene_Base extends Stage {
    protected _active: boolean;
    protected _fadeSign: number;
    protected _fadeDuration: number;
    protected _fadeSprite: ScreenSprite;
    protected _imageReservationId: any | number;
    protected _windowLayer: WindowLayer;

    /**
     * Attach a reservation to the reserve queue
     * 
     * @memberof Scene_Base
     */
    attachReservation(): void;
    /**
     * Remove the reservation from the reserve queue.
     * 
     * @memberof Scene_Base
     */
    detachReservation(): void;
    /**
     * Creates the scene's important properties.
     * 
     * @memberof Scene_Base
     */
    create(): void;
    /**
     * Returns whether the scene is active or not.
     * 
     * @returns {boolean} 
     * @memberof Scene_Base
     */
    isActive(): boolean;
    /**
     * Returns if the scene is ready to start or not.
     * 
     * @returns {boolean} 
     * @memberof Scene_Base
     */
    isReady(): boolean;
    /**
     * Starts the scene.
     * 
     * @memberof Scene_Base
     */
    start(): void;
    /**
     * Updates the scene.
     * 
     * @memberof Scene_Base
     */
    update(): void;
    /**
     * Stops the scene.
     * 
     * @memberof Scene_Base
     */
    stop(): void;
    /**
     * Returns a boolean value.
     * Checks if the Scene is busy processing an event or
     * other conditions.
     * @returns {boolean} 
     * @memberof Scene_Base
     */
    isBusy(): boolean;
    /**
     * Terminates/ends the scene.
     * 
     * @memberof Scene_Base
     */
    terminate(): void;
    /**
     * Creates the window layer on the current scene
     * for displaying any and all windows.
     * @memberof Scene_Base
     */
    createWindowLayer(): void;
    /**
    * Adds a child window to the windowLayer process.
    * 
    * @method addWindow
    * @param {Window_Base}
    * @instance 
    * @memberof Scene_Base
    */
    addWindow(window: Window_Base): void;
    /**
    * Request a fadeIn screen process.
    * 
    * @method startFadeIn
    * @param {Number} [duration=30] The time the process will take for fadeIn the screen
    * @param {Boolean} [white=false] If true the fadein will be process with a white color else it's will be black
    * 
    * @instance 
    * @memberof Scene_Base
    */
    startFadeIn(duration: number, white: boolean): void;
    /**
    * Request a fadeOut screen process.
    * 
    * @method startFadeOut
    * @param {Number} [duration=30] The time the process will take for fadeOut the screen
    * @param {Boolean} [white=false] If true the fadeOut will be process with a white color else it's will be black
    * 
    * @instance 
    * @memberof Scene_Base
    */
    startFadeOut(duration: number, white: boolean): void;
    createFadeSprite(white: boolean): void;
    /**
     * Updates the game's fade.
     * 
     * @memberof Scene_Base
     */
    updateFade(): void;
    updateChildren(): void;
    /**
     * Pops the current scene and returns to the previous
     * scene if available.
     * @memberof Scene_Base
     */
    popScene(): void;
    /**
     * Checks for game over.
     * 
     * @memberof Scene_Base
     */
    checkGameover(): void;
    fadeOutAll(): void;
    /**
     * Returns the fade speed.
     * 
     * @returns {number} 
     * @memberof Scene_Base
     */
    fadeSpeed(): number;
    /**
     * Returns the slow fade speed.
     * 
     * @returns {number} 
     * @memberof Scene_Base
     */
    slowFadeSpeed(): number;
}

/**
 * The scene class for initialize the entire game.
 * 
 * @class Scene_Boot
 * @extends {Scene_Base}
 */
declare class Scene_Boot extends Scene_Base {
    protected _startDate: Date;

    /**
     * Loads the system images upon booting the game.
     * 
     * @memberof Scene_Boot
     */
    loadSystemImages(): void;
    /**
     * Loads the system window image for showing
     * all the windows in game.
     * @memberof Scene_Boot
     */
    loadSystemWindowImage(): void;
    /**
     * Returns true if the game font is loaded.
     * 
     * @returns {boolean} 
     * @memberof Scene_Boot
     */
    isGameFontLoaded(): boolean;
    updateDocumentTitle(): void;
    /**
     * Checks the player location upon booting the game.
     * 
     * @memberof Scene_Boot
     */
    checkPlayerLocation(): void;
}

/**
 * The scene class of the title screen.
 * 
 * @class Scene_Title
 * @extends {Scene_Base}
 */
declare class Scene_Title extends Scene_Base {
    protected _commandWindow: Window_TitleCommand;
    protected _backSprite1: Sprite;
    protected _backSprite2: Sprite;
    protected _gameTitleSprite: Sprite;

    /**
     * Creates the title scene background.
     * 
     * @memberof Scene_Title
     */
    createBackground(): void;
    /**
     * Creates the title screen foreground.
     * 
     * @memberof Scene_Title
     */
    createForeground(): void;
    /**
     * Draws the game title.
     * 
     * @memberof Scene_Title
     */
    drawGameTitle(): void;
    centerSprite(sprite: Sprite): void;
    /**
     * Creates the command window on the title scene.
     * 
     * @memberof Scene_Title
     */
    createCommandWindow(): void;
    /**
     * Handler for the new game command.
     * 
     * @memberof Scene_Title
     */
    commandNewGame(): void;
    /**
     * Handler for the continue command.
     * 
     * @memberof Scene_Title
     */
    commandContinue(): void;
    /**
     * Handler for the options command.
     * 
     * @memberof Scene_Title
     */
    commandOptions(): void;
    /**
     * Plays the title screen music
     * upon enter the title scene.
     * @memberof Scene_Title
     */
    playTitleMusic(): void;
}

/**
 * The scene class of the map screen.
 * 
 * @class Scene_Map
 * @extends {Scene_Base}
 */
declare class Scene_Map extends Scene_Base {
    protected _waitCount: number;
    protected _encounterEffectDuration: number;
    protected _mapLoaded: boolean;
    protected _touchCount: number;
    protected _transfer: boolean;

    protected _spriteset: Spriteset_Map;
    protected _mapNameWindow: Window_MapName;
    protected _scrollTextWindow: Window_ScrollText;
    protected _messageWindow: Window_Message;

    menuCalling: boolean;

    /**
     * Handler for when the map scene is loaded.
     * 
     * @memberof Scene_Map
     */
    onMapLoaded(): void;
    /**
     * Speeds up the updateMain if
     * the map scene is in fast forward mode.
     * @memberof Scene_Map
     */
    updateMainMultiply(): void;
    /**
     * Updates the main $game globals
     * if the map scene is active.
     * @memberof Scene_Map
     */
    updateMain(): void;
    /**
     * Returns true if the player
     * is holding down the confirm button to
     * fast forward through text.
     * @returns {boolean} 
     * @memberof Scene_Map
     */
    isFastForward(): boolean;
    /**
     * Stops the map scene and prepares
     * for a new scene.
     * @memberof Scene_Map
     */
    stop(): void;
    /**
     * Returns true if the map scene needs a slow fade in.
     * 
     * @returns {boolean} 
     * @memberof Scene_Map
     */
    needsFadeIn(): boolean;
    /**
     * Returns true if the map scene needs a slow fade out.
     * 
     * @returns {boolean} 
     * @memberof Scene_Map
     */
    needsSlowFadeOut(): boolean;
    updateWaitCount(): boolean;
    /**
     * Constantly checks if the player
     * is touching the map, then processes
     * a map touch for mouse based player character movement.
     * @memberof Scene_Map
     */
    updateDestination(): void;
    /**
     * Returns true if the map scene is
     * active and the player can move. Used for
     * mouse movement on the map scene.
     * @returns {boolean} 
     * @memberof Scene_Map
     */
    isMapTouchOk(): boolean;
    /**
     * Processes the map touch and turns it
     * into coordinates for the player character to move to.
     * @memberof Scene_Map
     */
    processMapTouch(): void;
    isSceneChangeOk(): boolean;
    /**
     * Updates the scene.
     * 
     * @memberof Scene_Map
     */
    updateScene(): void;
    /**
     * Creates all the display objects on the map scene;
     * this includes the sprites, window layer, windows, and more.
     * @memberof Scene_Map
     */
    createDisplayObjects(): void;
    /**
     * Creates the spriteset on the map scene; 
     * this shows all the characters and events on the map.
     * @memberof Scene_Map
     */
    createSpriteset(): void;
    /**
     * Creates all the windows on the map scene
     * contains other window creation methods.
     * @memberof Scene_Map
     */
    createAllWindows(): void;
    /**
    * Creates the map name window within
    * the map scene; display map name.
    * @memberof Scene_Map
    */
    createMapNameWindow(): void;
    /**
     * Creates the message window for displaying
     * text on the map scene. Commonly used with the
     * showText command.
     * @memberof Scene_Map
     */
    createMessageWindow(): void;
    /**
     * Creates a scrolling text window on the map scene.
     * 
     * @memberof Scene_Map
     */
    createScrollTextWindow(): void;
    /**
     * Checks if the player is transferring;
     * if the player is transferring, move to a new map scene.
     * @memberof Scene_Map
     */
    updateTransferPlayer(): void;
    /**
     * Processes starting an encounter on the map scene.
     * 
     * @memberof Scene_Map
     */
    updateEncounter(): void;
    /**
     * Processes calling the menu on the map scene.
     * 
     * @memberof Scene_Map
     */
    updateCallMenu(): void;
    /**
     * Returns true if the menu is enabled
     * in the database.
     * @returns {boolean} 
     * @memberof Scene_Map
     */
    isMenuEnabled(): boolean;
    /**
     * Returns true if the menu is called
     * via an input trigger.
     * @returns {boolean} 
     * @memberof Scene_Map
     */
    isMenuCalled(): boolean;
    /**
     * Calls the standard RPGMakerMV menu scene.
     * 
     * @memberof Scene_Map
     */
    callMenu(): void;
    /**
     * Checks if debug is called via input trigger
     * and starts the debug scene.
     * 
     * @memberof Scene_Map
     */
    updateCallDebug(): void;
    /**
     * Returns true if the debug
     * scene is called via button press and in play test mode.
     * @returns {boolean} 
     * @memberof Scene_Map
     */
    isDebugCalled(): boolean;
    fadeInForTransfer(): void;
    fadeOutForTransfer(): void;
    /**
     * Launches into the battle scene.
     * 
     * @memberof Scene_Map
     */
    launchBattle(): void;
    /**
     * Stops all audio on battle start.
     * 
     * @memberof Scene_Map
     */
    stopAudioOnBattleStart(): void;
    /**
     * Starts the encounter effect on the map scene.
     * 
     * @memberof Scene_Map
     */
    startEncounterEffect(): void;
    updateEncounterEffect(): void;
    /**
     * Takes a snapshot of the map scene for displaying
     * on the battle scene if no battleback is present.
     * @memberof Scene_Map
     */
    snapForBattleBackground(): void;
    /**
     * Starts a flash encounter effect on the map scene
     * given a duration of the flash.
     * @param {number} duration 
     * @memberof Scene_Map
     */
    startFlashForEncounter(duration: number): void;
    /**
     * Returns the speed of the encounter effect.
     * 
     * @returns {number} 
     * @memberof Scene_Map
     */
    encounterEffectSpeed(): number;
}

/**
 * The super class of all menu-type scenes.
 * 
 * @class Scene_MenuBase
 * @extends {Scene_Base}
 */
declare class Scene_MenuBase extends Scene_Base {
    /**
     * The current actor selected in the base menu scene.
     * 
     * @protected
     * @type {Game_Actor}
     * @memberof Scene_MenuBase
     */
    protected _actor: Game_Actor;
    /**
     * The background sprite used to display the scene background.
     * 
     * @protected
     * @type {Sprite}
     * @memberof Scene_MenuBase
     */
    protected _backgroundSprite: Sprite;
    /**
     * The help window attached to the base menu scene.
     * 
     * @protected
     * @type {Window_Help}
     * @memberof Scene_MenuBase
     */
    protected _helpWindow: Window_Help;

    /**
     * Returns the current game actor.
     * 
     * @returns {Game_Actor} 
     * @memberof Scene_MenuBase
     */
    actor(): Game_Actor;
    /**
     * Updates the current actor.
     * 
     * @memberof Scene_MenuBase
     */
    updateActor(): void;
    /**
     * Creates the background of the base menu scene.
     * 
     * @memberof Scene_MenuBase
     */
    createBackground(): void;
    /**
     * Sets the background opacity of the base menu scene background.
     * 
     * @param {number} opacity 
     * @memberof Scene_MenuBase
     */
    setBackgroundOpacity(opacity: number): void;
    /**
     * Creates the help window.
     * 
     * @memberof Scene_MenuBase
     */
    createHelpWindow(): void;
    /**
     * Moves to the next actor in the party.
     * 
     * @memberof Scene_MenuBase
     */
    nextActor(): void;
    /**
     * Moves to the previous actor in the party.
     * 
     * @memberof Scene_MenuBase
     */
    previousActor(): void;
    onActorChange(): void;
}


/**
 * -----------------------------------------------------------------------------
 * Scene_Menu
 *
 * The scene class of the menu screen.
 * @class Scene_Menu
 * @extends {Scene_MenuBase}
 */
declare class Scene_Menu extends Scene_MenuBase {
    protected _commandWindow: Window_MenuCommand;
    protected _goldWindow: Window_Gold;
    protected _statusWindow: Window_MenuStatus;

    /**
     * Creates the main menu window on the 
     * menu scene; contains the commands for
     * menu usage.
     * @memberof Scene_Menu
     */
    createCommandWindow(): void;
    /**
     * Creates the gold window on the menu scene.
     * 
     * @memberof Scene_Menu
     */
    createGoldWindow(): void;
    /**
     * Creates the status window on the menu scene.
     * 
     * @memberof Scene_Menu
     */
    createStatusWindow(): void;
    /**
     * Handler for what to do when the 'item'
     * command is clicked.
     * @memberof Scene_Menu
     */
    commandItem(): void;
    commandPersonal(): void;
    commandFormation(): void;
    /**
     * Handler for what to do when the 'option'
     * command is clicked.
     * @memberof Scene_Menu
     */
    commandOptions(): void;
    /**
     * Handler for what to do when the 'save'
     * command is clicked.
     * @memberof Scene_Menu
     */
    commandSave(): void;
    /**
     * Handler for what to do when the 'game end'
     * command is clicked.
     * @memberof Scene_Menu
     */
    commandGameEnd(): void;
    onPersonalOk(): void;
    onPersonalCancel(): void;
    onFormationOk(): void;
    onFormationCancel(): void;
}

/**
 * -----------------------------------------------------------------------------
 * Scene_ItemBase
 *
 * The superclass of Scene_Item and Scene_Skill.
 * @class Scene_ItemBase
 * @extends {Scene_MenuBase}
 */
declare class Scene_ItemBase extends Scene_MenuBase {
    protected _actorWindow: Window_MenuActor;
    protected _itemWindow: Window_Selectable;

    /**
     * Creates the actor window within the base item scene.
     * 
     * @memberof Scene_ItemBase
     */
    createActorWindow(): void;
    /**
     * Returns the item attached to the item window within the base item scene.
     * 
     * @returns {*} 
     * @memberof Scene_ItemBase
     */
    item(): any;
    /**
     * Returns the current game actor.
     * 
     * @returns {Game_Actor} 
     * @memberof Scene_ItemBase
     */
    user(): Game_Actor;
    /**
     * Returns true if the cursor is left.
     * 
     * @returns {boolean} 
     * @memberof Scene_ItemBase
     */
    isCursorLeft(): boolean;
    /**
     * Shows the sub window.
     * 
     * @param {Window_Base} window 
     * @memberof Scene_ItemBase
     */
    showSubWindow(window: Window_Base): void;
    /**
     * Hides the sub window.
     * 
     * @param {Window_Base} window 
     * @memberof Scene_ItemBase
     */
    hideSubWindow(window: Window_Base): void;
    onActorOk(): void;
    onActorCancel(): void;
    determineItem(): void;
    /**
     * Uses the current item.
     * 
     * @memberof Scene_ItemBase
     */
    useItem(): void;
    /**
     * Activates the item window.
     * 
     * @memberof Scene_ItemBase
     */
    activateItemWindow(): void;
    itemTargetActors(): Game_Actor;
    /**
     * Returns true if the user (game actor) can use the item.
     * 
     * @returns {boolean} 
     * @memberof Scene_ItemBase
     */
    canUse(): boolean;
    /**
     * Returns true if the item effects are valid on the target(the user).
     * 
     * @returns {boolean} 
     * @memberof Scene_ItemBase
     */
    isItemEffectsValid(): boolean;
    applyItem(): void;
    /**
     * Checks the common event set on the item.
     * 
     * @memberof Scene_ItemBase
     */
    checkCommonEvent(): void;
}

/**
 * -----------------------------------------------------------------------------
 * Scene_Item
 *
 * The scene class of the item screen.
 * @class Scene_Item
 * @extends {Scene_ItemBase}
 */
declare class Scene_Item extends Scene_ItemBase {
    protected _categoryWindow: Window_ItemCategory;

    /**
     * Creates the category window on the
     * item scene.
     * @memberof Scene_Item
     */
    createCategoryWindow(): void;
    /**
     * Creates the item window on the item
     * scene.
     * @memberof Scene_Item
     */
    createItemWindow(): void;
    /**
     * Handler for when a category is selected
     * on the item scene.
     * @memberof Scene_Item
     */
    onCategoryOk(): void;
    /**
     * Handler for when an item is selected
     * on the item scene.
     * @memberof Scene_Item
     */
    onItemOk(): void;
    /**
     * Handler for when an item selection
     * is canceled on the item scene.
     * @memberof Scene_Item
     */
    onItemCancel(): void;
    /**
     * Plays a sound effect when the
     * item is confirmed.
     * @memberof Scene_Item
     */
    playSeForItem(): void;
}

/**
 * -----------------------------------------------------------------------------
 * Scene_Skill
 *
 * The scene class of the skill screen.
 * @class Scene_Skill
 * @extends {Scene_ItemBase}
 */
declare class Scene_Skill extends Scene_ItemBase {
    protected _skillTypeWindow: Window_SkillType;

    /**
     * Creates the window for skill types
     * within the skill scene.
     * @memberof Scene_Skill
     */
    createSkillTypeWindow(): void;
    /**
     * Creates the status window within
     * the skill scene.
     * @memberof Scene_Skill
     */
    createStatusWindow(): void;
    /**
     * Creates the item window
     * within the skill scene.
     * @memberof Scene_Skill
     */
    createItemWindow(): void;
    refreshActor(): void;
    /**
     * Handler for when a skill is
     * selected/confirmed within the skill scene.
     * @memberof Scene_Skill
     */
    commandSkill(): void;
    onItemCancel(): void;
    /**
     * Plays a sound effect on item
     * confirmation within the skill scene.
     * @memberof Scene_Skill
     */
    playSeForItem(): void;
    /**
     * Handler for when an an actor is
     * changed within the skill scene.
     * @memberof Scene_Skill
     */
    onActorChange(): void;
}

/**
 * -----------------------------------------------------------------------------
 * Scene_Equip
 *
 * The scene class of the equipment screen.
 * @class Scene_Equip
 * @extends Scene_MenuBase
 */
declare class Scene_Equip extends Scene_MenuBase {
    protected _statusWindow: Window_EquipStatus;
    protected _commandWindow: Window_EquipCommand;
    protected _slotWindow: Window_EquipSlot;
    protected _itemWindow: Window_EquipItem;

    /**
     * Creates the status window within the equip scene.
     * 
     * @memberof Scene_Equip
     */
    createStatusWindow(): void;
    /**
     * Creates the status window within the equip scene.
     * 
     * @memberof Scene_Equip
     */
    createCommandWindow(): void;
    /**
     * Creates the slot window within the  equip scene.
     * 
     * @memberof Scene_Equip
     */
    createSlotWindow(): void;
    /**
     * Creates the item window within the equip scene.
     * 
     * @memberof Scene_Equip
     */
    createItemWindow(): void;
    /**
     * Refreshes the actor within the equip scene.
     * 
     * @memberof Scene_Equip
     */
    refreshActor(): void;
    /**
     * Handler for the equip command.
     * 
     * @memberof Scene_Equip
     */
    commandEquip(): void;
    /**
     * Handler for the optimize command.
     * 
     * @memberof Scene_Equip
     */
    commandOptimize(): void;
    commandClear(): void;
    onSlotOk(): void;
    onSlotCancel(): void;
    onItemOk(): void;
    onItemCancel(): void;
    onActorChange(): void;
}

/**
 * -----------------------------------------------------------------------------
 * Scene_Status
 *
 * The scene class of the status screen.
 * @class Scene_Status
 * @extends {Scene_MenuBase}
 */
declare class Scene_Status extends Scene_MenuBase {
    protected _statusWindow: Window_Status;

    /**
     * Refreshes the actor within the status scene.
     * 
     * @memberof Scene_Status
     */
    refreshActor(): void;
    /**
     * Handler for when the actor is changed within the status scene.
     * 
     * @memberof Scene_Status
     */
    onActorChange(): void;
}

/**
 * -----------------------------------------------------------------------------
 * Scene_Options
 *
 * The scene class of the options screen.
 * @class Scene_Options
 * @extends {Scene_MenuBase}
 */
declare class Scene_Options extends Scene_MenuBase {
    protected _optionsWindow: Window_Options;

    createOptionsWindow(): void;
}

/**
 * -----------------------------------------------------------------------------
 * Scene_File
 *
 * The superclass of Scene_Save and Scene_Load.
 * @class Scene_File
 * @extends {Scene_MenuBase}
 */
declare class Scene_File extends Scene_MenuBase {
    protected _listWindow: Window_SavefileList;

    /**
     * Returns the current savefileId.
     * 
     * @memberof Scene_File
     */
    savefileId(): void;
    createHelpWindow(): void;
    createListWindow(): void;
    /**
     * The current mode of the scene;
     * the modes are 'save' or 'load'.
     * @memberof Scene_File
     */
    mode(): void;
    activateListWindow(): void;
    helpWindowText(): string;
    /**
     * Returns the index of the first
     * save file.
     * @returns {number} 
     * @memberof Scene_File
     */
    firstSavefileIndex(): number;
    /**
     * Handler for when a 
     * save file is selected within the file scene.
     * @memberof Scene_File
     */
    onSavefileOk(): void;
}

/**
 * -----------------------------------------------------------------------------
 * Scene_Save
 *
 * The scene class of the save screen.
 * @class Scene_Save
 * @extends {Scene_File}
 */
declare class Scene_Save extends Scene_File {
    /**
     * Returns the mode of the
     * save scene.
     * @returns {string} 
     * @memberof Scene_Save
     */
    mode(): string;
    helpWindowText(): string;
    /**
     * Returns the index of the first
     * save file within the save scene.
     * @returns {number} 
     * @memberof Scene_Save
     */
    firstSavefileIndex(): number;
    /**
     * Handler for when a save file
     * is confirmed within the save scene.
     * @memberof Scene_Save
     */
    onSavefileOk(): void;
    /**
     * Handler for when save is a success.
     * 
     * @memberof Scene_Save
     */
    onSaveSuccess(): void;
    /**
     * Handler for when save fails.
     * 
     * @memberof Scene_Save
     */
    onSaveFailure(): void;
}

/**
 * -----------------------------------------------------------------------------
 * Scene_Load
 *
 * The scene class of the load screen.
 * @class Scene_Load
 * @extends {Scene_File}
 */
declare class Scene_Load extends Scene_File {
    protected _loadSuccess: boolean;

    /**
     * Returns the mode of the
     * load scene.
     * @returns {string} 
     * @memberof Scene_Load
     */
    mode(): string;
    /**
     * Returns the help window text on the
     * game load scene.
     * @returns {string} 
     * @memberof Scene_Load
     */
    helpWindowText(): string;
    firstSavefileIndex(): number;
    onSavefileOk(): void;
    onLoadSuccess(): void;
    onLoadFailure(): void;
    reloadMapIfUpdated(): void;
}

/**
 * -----------------------------------------------------------------------------
 * Scene_GameEnd
 *
 * The scene class of the game end screen.
 * @class Scene_GameEnd
 * @extends {Scene_MenuBase}
 */
declare class Scene_GameEnd extends Scene_MenuBase {
    protected _commandWindow: Window_GameEnd;

    stop(): void;
    /**
     * Creates the background for
     * the game end scene.
     * @memberof Scene_GameEnd
     */
    createBackground(): void;
    /**
     * Creates the command window
     * for the game end screen.
     * @memberof Scene_GameEnd
     */
    createCommandWindow(): void;
    /**
     * Handler for when to title
     * is clicked within the game end screen.
     * @memberof Scene_GameEnd
     */
    commandToTitle(): void;
}

/**
 * -----------------------------------------------------------------------------
 * Scene_Shop
 *
 * The scene class of the shop screen.
 * @class Scene_Shop
 * @extends {Scene_MenuBase}
 */
declare class Scene_Shop extends Scene_MenuBase {
    protected _goods: Array<Array<any>>;
    protected _purchaseOnly: boolean;
    protected _item: RPG.BaseItem;

    protected _goldWindow: Window_Gold;
    protected _commandWindow: Window_ShopCommand;
    protected _dummyWindow: Window_Base;
    protected _numberWindow: Window_ShopNumber;
    protected _statusWindow: Window_ShopStatus;
    protected _buyWindow: Window_ShopBuy;
    protected _categoryWindow: Window_ItemCategory;
    protected _sellWindow: Window_ShopSell;
    protected _helpWindow: Window_Help;

    prepare(goods: Array<Array<any>>, purchaseOnly: boolean): void;
    /**
     * Creates the gold window on the shop scene.
     * 
     * @memberof Scene_Shop
     */
    createGoldWindow(): void;
    /**
     * Creates the command window for buying or selling.
     * 
     * @memberof Scene_Shop
     */
    createCommandWindow(): void;
    createDummyWindow(): void;
    /**
     * Creates the number input window on the shop scene.
     * 
     * @memberof Scene_Shop
     */
    createNumberWindow(): void;
    /**
     * Creates the status window.
     * 
     * @memberof Scene_Shop
     */
    createStatusWindow(): void;
    /**
     * Creates the buy window.
     * 
     * @memberof Scene_Shop
     */
    createBuyWindow(): void;
    /**
     * Creates the category window.
     * 
     * @memberof Scene_Shop
     */
    createCategoryWindow(): void;
    /**
     * Creates the sell window.
     * 
     * @memberof Scene_Shop
     */
    createSellWindow(): void;
    /**
     * Activates the buy window within the shop scene.
     * 
     * @memberof Scene_Shop
     */
    activateBuyWindow(): void;
    /**
     * Activates the sell window within the shop scene.
     * 
     * @memberof Scene_Shop
     */
    activateSellWindow(): void;
    /**
     * Handler for pressing buy within the shop scene.
     * 
     * @memberof Scene_Shop
     */
    commandBuy(): void;
    /**
     * Handler for pressing sell within the shop scene.
     * 
     * @memberof Scene_Shop
     */
    commandSell(): void;
    /**
     * Handler for when buying is confirmed.
     * 
     * @memberof Scene_Shop
     */
    onBuyOk(): void;
    /**
     * Handler for when buying is cancelled.
     * 
     * @memberof Scene_Shop
     */
    onBuyCancel(): void;
    onCategoryOk(): void;
    onCategoryCancel(): void;
    onSellOk(): void;
    onSellCancel(): void;
    onNumberOk(): void;
    onNumberCancel(): void;
    doBuy(number: number): void;
    doSell(number: number): void;
    endNumberInput(): void;
    /**
     * Returns the maximum number bought.
     * 
     * @returns {number} 
     * @memberof Scene_Shop
     */
    maxBuy(): number;
    /**
     * Returns the maximum number sold.
     * 
     * @returns {number} 
     * @memberof Scene_Shop
     */
    maxSell(): number;
    /**
     * Returns the player gold within
     * the shop scene.
     * @returns {number} 
     * @memberof Scene_Shop
     */
    money(): number;
    /**
     * Returns the currency unit of the
     * game within the shop scene.
     * @returns {string} 
     * @memberof Scene_Shop
     */
    currencyUnit(): string;
    /**
     * Returns the buying price for the current item.
     * 
     * @returns {number} 
     * @memberof Scene_Shop
     */
    buyingPrice(): number;
    /**
     * Returns the selling price for the current item.
     * 
     * @returns {number} 
     * @memberof Scene_Shop
     */
    sellingPrice(): number;
}

/**
 * -----------------------------------------------------------------------------
 * Scene_Name
 *
 * The scene class of the name input screen.
 * @class Scene_Name
 * @extends {Scene_MenuBase}
 */
declare class Scene_Name extends Scene_MenuBase {
    /**
     * Prepares the name input scene for giving the specified
     * actor at actorId a name with a maximum number of characters
     * given by maxLength.
     * @param {number} actorId 
     * @param {number} maxLength 
     * @memberof Scene_Name
     */
    prepare(actorId: number, maxLength: number): void;
    /**
     * Creates the edit window.
     * 
     * @memberof Scene_Name
     */
    createEditWindow(): void;
    /**
     * Creates the input window.
     * 
     * @memberof Scene_Name
     */
    createInputWindow(): void;
    /**
     * Handler for when ok is processed on the name input scene.
     * 
     * @memberof Scene_Name
     */
    onInputOk(): void;
}

/**
 * -----------------------------------------------------------------------------
 * Scene_Debug
 *
 * The scene class of the debug screen.
 * @class Scene_Debug
 * @extends {Scene_MenuBase}
 */
declare class Scene_Debug extends Scene_MenuBase {
    /**
     * Creates the range window.
     * 
     * @memberof Scene_Debug
     */
    createRangeWindow(): void;
    /**
     * Creates the edit window.
     * 
     * @memberof Scene_Debug
     */
    createEditWindow(): void;
    /**
     * Creates the debug help .window.
     * 
     * @memberof Scene_Debug
     */
    createDebugHelpWindow(): void;
    onRangeOk(): void;
    onEditCancel(): void;
    refreshHelpWindow(): void;
    /**
     * Returns the help text within the 
     * debug scene.
     * @returns {string} 
     * @memberof Scene_Debug
     */
    helpText(): string;
}

/**
 * -----------------------------------------------------------------------------
 * Scene_Battle
 *
 * The scene class of the battle screen.
 * @class Scene_Battle
 * @extends {Scene_Base}
 */
declare class Scene_Battle extends Scene_Base {
    protected _spriteset: Spriteset_Battle;
    protected _statusWindow: Window_BattleStatus;
    protected _partyCommandWindow: Window_PartyCommand;
    protected _actorCommandWindow: Window_ActorCommand;
    protected _skillWindow: Window_BattleSkill;
    protected _itemWindow: Window_BattleItem;
    protected _actorWindow: Window_BattleActor;
    protected _enemyWindow: Window_BattleEnemy;
    protected _logWindow: Window_BattleLog;
    protected _helpWindow: Window_Help;
    protected _messageWindow: Window_Message;
    protected _scrollTextWindow: Window_ScrollText;

    updateBattleProcess(): void;
    isAnyInputWindowActive(): boolean;
    changeInputWindow(): void;
    /**
     * Stops the battle scene.
     * 
     * @memberof Scene_Battle
     */
    stop(): void;
    /**
     * Returns true if the battle needs a slow fade out.
     * 
     * @returns {boolean} 
     * @memberof Scene_Battle
     */
    needsSlowFadeOut(): boolean;
    /**
     * Updates the status window on the battle scene.
     * 
     * @memberof Scene_Battle
     */
    updateStatusWindow(): void;
    /**
     * Updates the position of the battle scene windows.
     * 
     * @memberof Scene_Battle
     */
    updateWindowPositions(): void;
    /**
     * Creates all the display objects including:
     * the spritesheet, window layer, windows, and more.
     * 
     * @memberof Scene_Battle
     */
    createDisplayObjects(): void;
    /**
     * Creates the spriteset within
     * the battle scene. This includes
     * sprites for actors, enemies, etc.
     * @memberof Scene_Battle
     */
    createSpriteset(): void;
    /**
     * Creates all the windows within the
     * battle scene.
     * @memberof Scene_Battle
     */
    createAllWindows(): void;
    /**
     * Creates the log window.
     * 
     * @memberof Scene_Battle
     */
    createLogWindow(): void;
    createStatusWindow(): void;
    createPartyCommandWindow(): void;
    /**
     * Creates the actor command window.
     * 
     * @memberof Scene_Battle
     */
    createActorCommandWindow(): void;
    /**
     * Creates the help window.
     * 
     * @memberof Scene_Battle
     */
    createHelpWindow(): void;
    /**
     * Creates the skill window.
     * 
     * @memberof Scene_Battle
     */
    createSkillWindow(): void;
    /**
     * Creates the item window.
     * 
     * @memberof Scene_Battle
     */
    createItemWindow(): void;
    /**
     * Creates the actor window.
     * 
     * @memberof Scene_Battle
     */
    createActorWindow(): void;
    /**
     * Creates the enemy window.
     * 
     * @memberof Scene_Battle
     */
    createEnemyWindow(): void;
    /**
     * Creates the message window on the battle scene.
     * 
     * @memberof Scene_Battle
     */
    createMessageWindow(): void;
    /**
     * Creates the scroll text window.
     * 
     * @memberof Scene_Battle
     */
    createScrollTextWindow(): void;
    refreshStatus(): void;
    startPartyCommandSelection(): void;
    /**
     * Handler for the fight command on battle start..
     * 
     * @memberof Scene_Battle
     */
    commandFight(): void;
    /**
     * Handler for the escape command on battle start.
     * 
     * @memberof Scene_Battle
     */
    commandEscape(): void;
    startActorCommandSelection(): void;
    /**
     * Handler for the attack command.
     * 
     * @memberof Scene_Battle
     */
    commandAttack(): void;
    /**
     * Handler for the skill command.
     * 
     * @memberof Scene_Battle
     */
    commandSkill(): void;
    /**
     * Handler for the guard command.
     * 
     * @memberof Scene_Battle
     */
    commandGuard(): void;
    /**
     * Handler for the item command.
     * 
     * @memberof Scene_Battle
     */
    commandItem(): void;
    /**
     * Selects the next command in the battle scene.
     * 
     * @memberof Scene_Battle
     */
    selectNextCommand(): void;
    /**
     * Selects the previous command in the battle scene.
     * 
     * @memberof Scene_Battle
     */
    selectPreviousCommand(): void;
    selectActorSelection(): void;
    onActorOk(): void;
    onActorCancel(): void;
    selectEnemySelection(): void;
    /**
     * Handler for when an enemy is selected.
     * 
     * @memberof Scene_Battle
     */
    onEnemyOk(): void;
    onEnemyCancel(): void;
    /**
     * Handler for when a skill is selected.
     * 
     * @memberof Scene_Battle
     */
    onSkillOk(): void;
    onSkillCancel(): void;
    onItemOk(): void;
    onItemCancel(): void;
    onSelectAction(): void;
    endCommandSelection(): void;
}

/**
 * -----------------------------------------------------------------------------
 * Scene_Gameover
 *
 * The scene class of the game over screen.
 * @class Scene_Gameover
 * @extends {Scene_Base}
 */
declare class Scene_Gameover extends Scene_Base {
    protected _backSprite: Sprite;

    stop(): void;
    /**
     * Plays the game over music
     * within the game over scene.
     * @memberof Scene_Gameover
     */
    playGameoverMusic(): void;
    /**
     * Creates the background of
     * the game over scene.
     * @memberof Scene_Gameover
     */
    createBackground(): void;
    isTriggered(): boolean;
    /**
     * Returns to the title scene (Scene_Title).
     * @memberof Scene_Gameover
     */
    gotoTitle(): void;
}
/**
 * -----------------------------------------------------------------------------
 * Sprite_Base
 *
 * The sprite class with a feature which displays animations.
 */
declare class Sprite_Base extends Sprite {
    /**
     * The animation sprites assigned to the
     * sprite object.
     * @protected
     * @type {Array<Sprite_Animation>}
     * @memberof Sprite_Base
     */
    protected _animationSprites: Array<Sprite_Animation>;
    /**
     * The target that will have the animations applied
     * to it.
     * @protected
     * @type {Sprite_Base}
     * @memberof Sprite_Base
     */
    protected _effectTarget: Sprite_Base;
    /**
     * Property determining the sprite's visibility.
     *
     * @protected
     * @type {boolean}
     * @memberof Sprite_Base
     */
    protected _hiding: boolean;

    /**
     * Creates an instance of Sprite_Base.
     * @memberof Sprite_Base
     */
    constructor();

    /**
     * Hides the sprite.
     *
     * @memberof Sprite_Base
     */
    hide(): void;
    /**
     * Shows the sprite.
     *
     * @memberof Sprite_Base
     */
    show(): void;
    /**
     * Updates the visibility of the sprite based
     * on the _hiding property.
     * @memberof Sprite_Base
     */
    updateVisibility(): void;
    /**
     * Updates the animation sprites, cloning them;
     * if the sprite is playing, pushes the sprites into
     * animation sprites, otherwise the sprite is removed.
     * @memberof Sprite_Base
     */
    updateAnimationSprites(): void;
    /**
     * Starts a new animation on the current
     * sprite by assigning a new Sprite_Animation object to the
     * sprite's parent.
     * @param {RPG.Animation} animation
     * @param {boolean} mirror
     * @param {number} delay
     * @memberof Sprite_Base
     */
    startAnimation(animation: RPG.Animation, mirror: boolean, delay: number): void;
    /**
     * Returns true if an animation is currently playing.
     * @returns {boolean}
     * @memberof Sprite_Base
     */
    isAnimationPlaying(): boolean;
}

/**
 * -----------------------------------------------------------------------------
 * Sprite_Button
 *
 * The sprite for displaying a button.
 */
declare class Sprite_Button extends Sprite {
    protected _touching: boolean;
    protected _coldFrame: Rectangle;
    protected _hotFrame: Rectangle;
    protected _clickHandler: () => void;

    /**
     * Update method, which checks if the sprite is being touched and updates
     * the current frame.
     *
     * @memberof Sprite_Button
     */
    updateFrame(): void;
    /**
     * Set the button sprites cold frame.
     *
     * @param {number} x
     * @param {number} y
     * @param {number} width
     * @param {number} height
     *
     * @memberof Sprite_Button
     *
     */
    setColdFrame(x: number, y: number, width: number, height: number): void;
    /**
     * Set the button sprites hot frame
     *
     * @param {number} x
     * @param {number} y
     * @param {number} width
     * @param {number} height
     *
     * @memberof Sprite_Button
     *
     */
    setHotFrame(x: number, y: number, width: number, height: number): void;
    /**
     * Creates a new handler and binds it to the button.
     *
     * @param {function} height
     * @memberof Sprite_Button
     */
    setClickHandler(method: () => void): void;
    /**
     * Calls the handler method bound to the button.
     *
     * @param {function} height
     * @memberof Sprite_Button
     */
    callClickHandler(): void;
    /**
     * Processes weather or not the button is being touched and calls the handler
     * bound to the button.
     * @memberof Sprite_Button
     */
    processTouch(): void;
    /**
     * Returns true if the sprite button is currently active.
     * @returns {boolean}
     * @memberof Sprite_Button
     */
    isActive(): boolean;
    /**
     * Returns true is the button is presently being touched.
     * @returns {boolean}
     * @memberof Sprite_Button
     */
    isButtonTouched(): boolean;
    /**
     * Changes the x coordinate of the screen to local sprite x coordinate.
     * @param {number} x
     * @returns {number}
     * @memberof Sprite_Button
     */
    canvasToLocalX(x: number): number;
    /**
     * Changes the y coordinate of the screen
     * to local sprite y coordinate.
     * @param {number} y
     * @returns {number}
     * @memberof Sprite_Button
     */
    canvasToLocalY(y: number): number;
}

/**
 * -----------------------------------------------------------------------------
 * Sprite_Character
 *
 * The sprite for displaying a character.
 */
declare class Sprite_Character extends Sprite_Base {
    /**
     * The Game_Character object assigned
     * to the sprite.
     * @protected
     * @type {Game_Character}
     * @memberof Sprite_Character
     */
    protected _character: Game_Character;
    protected _balloonDuration: number;
    protected _tilesetId: number;
    protected _upperBody: Sprite;
    protected _lowerBody: Sprite;
    protected _bushDepth: number;
    /**
     * The current balloon sprite
     * assigned to the sprite.
     * @protected
     * @type {Sprite_Balloon}
     * @memberof Sprite_Character
     */
    protected _balloonSprite: Sprite_Balloon;

    /**
     * Creates an instance of Sprite_Character.
     * @param {Game_Character} character
     * @memberof Sprite_Character
     */
    constructor(character: Game_Character);

    initMembers(): void;
    /**
     * Sets the current Game_Character object
     * attached to the sprite.
     * @param {Game_Character} character
     * @memberof Sprite_Character
     */
    setCharacter(character: Game_Character): void;
    /**
     * Returns true if the Game_Character object
     * tileId is greater than 0.
     * @returns {boolean}
     * @memberof Sprite_Character
     */
    isTile(): boolean;
    tilesetBitmap(tileId: number): Bitmap;
    /**
     * Updates the bitmap of the sprite character.
     * 
     * @memberof Sprite_Character
     */
    updateBitmap(): void;
    /**
     * Returns true if the sprite character image has changed.
     * 
     * @returns {boolean} 
     * @memberof Sprite_Character
     */
    isImageChanged(): boolean;
    setTileBitmap(): void;
    /**
     * Sets the sprite character bitmap.
     * 
     * @memberof Sprite_Character
     */
    setCharacterBitmap(): void;
    /**
     * Updates the sprite character frame.
     * 
     * @memberof Sprite_Character
     */
    updateFrame(): void;
    /**
     * Updates the sprite character tile frame.
     * 
     * @memberof Sprite_Character
     */
    updateTileFrame(): void;
    /**
     * Updates the sprite character -- character frame.
     * 
     * @memberof Sprite_Character
     */
    updateCharacterFrame(): void;
    characterBlockX(): number;
    characterBlockY(): number;
    /**
     * Returns the character x pattern.
     * 
     * @returns {number} 
     * @memberof Sprite_Character
     */
    characterPatternX(): number;
    /**
     * Returns the character y pattern.
     * 
     * @returns {number} 
     * @memberof Sprite_Character
     */
    characterPatternY(): number;
    /**
     * Returns the pattern width.
     * 
     * @returns {number} 
     * @memberof Sprite_Character
     */
    patternWidth(): number;
    /**
     * Returns the pattern height.
     * 
     * @returns {number} 
     * @memberof Sprite_Character
     */
    patternHeight(): number;
    updateHalfBodySprites(): void;
    createHalfBodySprites(): void;
    /**
     * Updates the position of the sprite character.
     * 
     * @memberof Sprite_Character
     */
    updatePosition(): void;
    updateAnimation(): void;
    updateOther(): void;
    setupAnimation(): void;
    /**
     * Sets up the Game_Character object
     * balloon sprite, and calls the startBalloon method.
     * @memberof Sprite_Character
     */
    setupBalloon(): void;
    /**
     * Starts the balloon sprite on the
     * Game_Character object.
     * @memberof Sprite_Character
     */
    startBalloon(): void;
    /**
     * Processes the balloon sprite, calls
     * the endBallon method if the balloon sprite is done playing.
     * @memberof Sprite_Character
     */
    updateBalloon(): void;
    /**
     * Ends the balloon sprite, removing it from
     * the Game_Character object sprite.
     * @memberof Sprite_Character
     */
    endBalloon(): void;
    /**
     * Returns true if a balloon animation
     * is playing on the character.
     * @returns {boolean}
     * @memberof Sprite_Character
     */
    isBalloonPlaying(): boolean;
}

/**
 * -----------------------------------------------------------------------------
 * Sprite_Battler
 *
 * The superclass of Sprite_Actor and Sprite_Enemy.
 */
declare class Sprite_Battler extends Sprite_Base {
    protected _battler: Game_Battler;
    protected _damages: Array<Sprite_Damage>;
    protected _homeX: number;
    protected _homeY: number;
    protected _offsetX: number;
    protected _offsetY: number;
    protected _targetOffsetX: number;
    protected _targetOffsetY: number;
    protected _movementDuration: number;
    protected _selectionEffectCount: number;

    constructor(battler?: Game_Battler);

    initMembers(): void;
    /**
     * Sets the game battler of the sprite battler.
     * 
     * @param {Game_Battler} battler 
     * @memberof Sprite_Battler
     */
    setBattler(battler: Game_Battler): void;
    /**
     * Sets the home position of the sprite battler to the given
     * x and y coordinates.
     * @param {number} x 
     * @param {number} y 
     * @memberof Sprite_Battler
     */
    setHome(x: number, y: number): void;
    /**
     * Updates the main loop of the sprite battler.
     * 
     * @memberof Sprite_Battler
     */
    updateMain(): void;
    /**
     * Updates the bitmap of the sprite battler.
     * 
     * @memberof Sprite_Battler
     */
    updateBitmap(): void;
    /**
     * Updates the sprite battler's current frame.
     * 
     * @memberof Sprite_Battler
     */
    updateFrame(): void;
    /**
     * Updates movement on the sprite battler.
     * 
     * @memberof Sprite_Battler
     */
    updateMove(): void;
    /**
     * Updates the position of the sprite battler.
     * 
     * @memberof Sprite_Battler
     */
    updatePosition(): void;
    /**
     * Updates the sprite battler animation.
     * 
     * @memberof Sprite_Battler
     */
    updateAnimation(): void;
    /**
     * Updates the damage pop up for the sprite battler.
     * 
     * @memberof Sprite_Battler
     */
    updateDamagePopup(): void;
    updateSelectionEffect(): void;
    /**
     * Sets up animation on the sprite battler.
     * 
     * @memberof Sprite_Battler
     */
    setupAnimation(): void;
    /**
     * Sets up damage popup on the sprite battler.
     * 
     * @memberof Sprite_Battler
     */
    setupDamagePopup(): void;
    damageOffsetX(): number;
    damageOffsetY(): number;
    startMove(x: number, y: number, duration: number): void;
    /**
     * Handler for when movement has ended.
     * 
     * @memberof Sprite_Battler
     */
    onMoveEnd(): void;
    /**
     * Returns false for sprite battler.
     * 
     * @returns {boolean} 
     * @memberof Sprite_Battler
     */
    isEffecting(): boolean;
    /**
     * Returns true if the sprite for the battler
     * is moving.
     * @returns {boolean}
     * @memberof Sprite_Battler
     */
    isMoving(): boolean;
    /**
     * Returns true if the sprite battler is in the home position.
     * 
     * @returns {boolean} 
     * @memberof Sprite_Battler
     */
    inHomePosition(): boolean;
}


/**
 * -----------------------------------------------------------------------------
 * Sprite_Actor
 *
 * The sprite for displaying an actor.
 */
declare class Sprite_Actor extends Sprite_Battler {
    static MOTIONS: {
        walk: MV.Motion,
        wait: MV.Motion,
        chant: MV.Motion,
        guard: MV.Motion,
        damage: MV.Motion,
        evade: MV.Motion,
        thrust: MV.Motion,
        swing: MV.Motion,
        missile: MV.Motion,
        skill: MV.Motion,
        spell: MV.Motion,
        item: MV.Motion,
        escape: MV.Motion,
        victory: MV.Motion,
        dying: MV.Motion,
        abnormal: MV.Motion,
        sleep: MV.Motion,
        dead: MV.Motion,
    };

    protected _battlerName: string;
    protected _motion: MV.Motion;
    protected _motionCount: number;
    protected _pattern: number;
    protected _mainSprite: Sprite_Base;
    protected _shadowSprite: Sprite;
    protected _weaponSprite: Sprite_Weapon;
    protected _stateSprite: Sprite_StateOverlay;
    protected _actor: Game_Actor;

    /**
     * Creates an instance of Sprite_Actor; can be passed
     * a battler on creation.
     * @param {Game_Actor} [battler] 
     * @memberof Sprite_Actor
     */
    constructor(battler?: Game_Actor);

    /**
     * Creates the main sprite of the sprite actor.
     * 
     * @memberof Sprite_Actor
     */
    createMainSprite(): void;
    /**
     * Creates the shadow sprite of the sprite actor.
     * 
     * @memberof Sprite_Actor
     */
    createShadowSprite(): void;
    /**
     * Sets the weapon sprite of the sprite actor.
     * 
     * @memberof Sprite_Actor
     */
    createWeaponSprite(): void;
    /**
     * Creates the state sprite of the sprite actor.
     * 
     * @memberof Sprite_Actor
     */
    createStateSprite(): void;
    /**
     * Sets the battler of the sprite actor.
     * 
     * @param {Game_Actor} battler 
     * @memberof Sprite_Actor
     */
    setBattler(battler: Game_Actor): void;
    /**
     * Moves the sprite actor to the start position.
     * 
     * @memberof Sprite_Actor
     */
    moveToStartPosition(): void;
    setActorHome(index: number): void;
    updateShadow(): void;
    /**
     * Sets up motion on the sprite actor.
     * 
     * @memberof Sprite_Actor
     */
    setupMotion(): void;
    /**
     * Sets up weapon animation on the sprite actor.
     * 
     * @memberof Sprite_Actor
     */
    setupWeaponAnimation(): void;
    /**
     * Starts the motion given the specified motion
     * type.
     * @param {string} motionType 
     * @memberof Sprite_Actor
     */
    startMotion(motionType: string): void;
    updateTargetPosition(): void;
    /**
     * Updates the sprite actor's movement.
     * 
     * @memberof Sprite_Actor
     */
    updateMove(): void;
    /**
     * Updates the sprite actor's motion.
     * 
     * @memberof Sprite_Actor
     */
    updateMotion(): void;
    updateMotionCount(): void;
    /**
     * Returns the speed of the motion for the sprite actor.
     * 
     * @returns {number} 
     * @memberof Sprite_Actor
     */
    motionSpeed(): number;
    /**
     * Refreshes the motion of the sprite actor.
     * 
     * @memberof Sprite_Actor
     */
    refreshMotion(): void;
    /**
     * Starts the entry motion of the sprite actor.
     * 
     * @memberof Sprite_Actor
     */
    startEntryMotion(): void;
    /**
     * Has the sprite actor step forward.
     * 
     * @memberof Sprite_Actor
     */
    stepForward(): void;
    /**
     * Has the sprite actor step back.
     * 
     * @memberof Sprite_Actor
     */
    stepBack(): void;
    /**
     * Has the sprite actor retreat.
     * 
     * @memberof Sprite_Actor
     */
    retreat(): void;
    damageOffsetX(): number;
    damageOffsetY(): number;
}

/**
 * -----------------------------------------------------------------------------
 * Sprite_Enemy
 *
 * The sprite for displaying an enemy.
 */
declare class Sprite_Enemy extends Sprite_Battler {
    protected _enemy: Game_Enemy;
    protected _appeared: boolean;
    protected _battlerName: string;
    protected _battlerHue: number;
    protected _effectType: string;
    protected _effectDuration: number;
    protected _shake: number;
    protected _stateIconSprite: Sprite_StateIcon;

    constructor(battler: Game_Enemy);

    createStateIconSprite(): void;
    /**
     * Sets the battler to an instance of game enemy.
     * 
     * @param {Game_Enemy} battler Instance of game enemy.
     * @memberof Sprite_Enemy
     */
    setBattler(battler: Game_Enemy): void;
    loadBitmap(name: string, hue: number): void;
    /**
     * Updates the state sprite on the sprite enemy.
     * 
     * @memberof Sprite_Enemy
     */
    updateStateSprite(): void;
    initVisibility(): void;
    setupEffect(): void;
    startEffect(effectType: string): void;
    /**
     * Starts the appearing effect on the sprite enemy.
     * 
     * @memberof Sprite_Enemy
     */
    startAppear(): void;
    /**
     * Starts the disappearing effect on the sprite enemy.
     * 
     * @memberof Sprite_Enemy
     */
    startDisappear(): void;
    /**
     * Starts the whiten effect on the sprite enemy.
     * 
     * @memberof Sprite_Enemy
     */
    startWhiten(): void;
    /**
     * Starts the blink effect on the sprite enemy.
     * 
     * @memberof Sprite_Enemy
     */
    startBlink(): void;
    /**
     * Starts the collapse effect of the sprite
     * enemy.
     * @memberof Sprite_Enemy
     */
    startCollapse(): void;
    /**
     * Starts the boss collapse effect of the sprite
     * enemy.
     * @memberof Sprite_Enemy
     */
    startBossCollapse(): void;
    /**
     * Starts the instant collapse effect of the sprite enemy.
     * 
     * @memberof Sprite_Enemy
     */
    startInstantCollapse(): void;
    updateEffect(): void;
    /**
     * Returns true if the effect type on the sprite enemy
     * is not null.
     * @returns {boolean} 
     * @memberof Sprite_Enemy
     */
    isEffecting(): boolean;
    /**
     * Revers the sprite enemy to a normal state.
     * 
     * @memberof Sprite_Enemy
     */
    revertToNormal(): void;
    /**
     * Updates the whiten effect on the sprite enemy.
     * 
     * @memberof Sprite_Enemy
     */
    updateWhiten(): void;
    /**
     * Updates the blink effect on the sprite enemy.
     * 
     * @memberof Sprite_Enemy
     */
    updateBlink(): void;
    /**
     * Updates the appear effect on the sprite enemy.
     * 
     * @memberof Sprite_Enemy
     */
    updateAppear(): void;
    updateDisappear(): void;
    /**
     * Updates the collapse effect.
     * 
     * @memberof Sprite_Enemy
     */
    updateCollapse(): void;
    /**
     * Updates the boss collapse effect.
     * 
     * @memberof Sprite_Enemy
     */
    updateBossCollapse(): void;
    /**
     * Updates the instant collapse effect.
     * 
     * @memberof Sprite_Enemy
     */
    updateInstantCollapse(): void;
    damageOffsetX(): number;
    damageOffsetY(): number;
}

/**
 * -----------------------------------------------------------------------------
 * Sprite_Animation
 *
 * The sprite for displaying an animation.
 */
declare class Sprite_Animation extends Sprite {
    protected static _checker1: { key: RPG.Animation };
    protected static _checker2: { key: RPG.Animation };

    protected _target: Sprite_Base;
    protected _animation: RPG.Animation;
    protected _mirror: boolean;
    protected _delay: number;
    protected _rate_: number;
    protected _duration: number;
    protected _flashColor: Array<number>;
    protected _flashDuration: number;
    protected _screenFlashDuration: number;
    protected _hidingDuration: number;
    protected _bitmap1: Bitmap;
    protected _bitmap2: Bitmap;
    protected _cellSprites: Array<Sprite>;
    protected _screenFlashSprite: ScreenSprite;
    protected _duplicated: boolean;
    protected _reduceArtifacts: boolean;

    initMembers(): void;
    setup(target: Sprite_Base, animation: RPG.Animation, mirror: boolean, delay: number): void;
    /**
     * Removes the sprite animation.
     * 
     * @memberof Sprite_Animation
     */
    remove(): void;
    setupRate(): void;
    setupDuration(): void;
    /**
     * Updates the flash animation of the sprite animation.
     * 
     * @memberof Sprite_Animation
     */
    updateFlash(): void;
    updateScreenFlash(): void;
    /**
     * Returns the absolute x position of the sprite animation.
     * 
     * @returns {number} 
     * @memberof Sprite_Animation
     */
    absoluteX(): number;
    /**
     * Returns the absolute y position of the sprite animation.
     * 
     * @returns {number} 
     * @memberof Sprite_Animation
     */
    absoluteY(): number;
    /**
     * Updates the hiding of the sprite animation.
     * 
     * @memberof Sprite_Animation
     */
    updateHiding(): void;
    /**
     * Returns true if the sprite animation is playing.
     * 
     * @returns {boolean} 
     * @memberof Sprite_Animation
     */
    isPlaying(): boolean;
    /**
     * Loads the bitmaps of the sprite animation.
     * 
     * @memberof Sprite_Animation
     */
    loadBitmaps(): void;
    /**
     * Returns true if the sprite animation is ready.
     * 
     * @returns {boolean} 
     * @memberof Sprite_Animation
     */
    isReady(): boolean;
    /**
     * Create the sprites of the sprite animation.
     * 
     * @memberof Sprite_Animation
     */
    createSprites(): void;
    /**
     * Create the cell sprites of the sprite animation.
     * 
     * @memberof Sprite_Animation
     */
    createCellSprites(): void;
    /**
     * Create the screen flash sprite of the sprite animation.
     * 
     * @memberof Sprite_Animation
     */
    createScreenFlashSprite(): void;
    /**
     * Updates the main loop of the sprite animation.
     * 
     * @memberof Sprite_Animation
     */
    updateMain(): void;
    /**
     * Updates the position of the sprite animation.
     * 
     * @memberof Sprite_Animation
     */
    updatePosition(): void;
    /**
     * Updates the frame of the sprite animation.
     * 
     * @memberof Sprite_Animation
     */
    updateFrame(): void;
    /**
     * Returns the current frame index of the sprite animation.
     * 
     * @returns {number} 
     * @memberof Sprite_Animation
     */
    currentFrameIndex(): number;
    updateAllCellSprites(frame: Array<Array<number>>): void;
    updateCellSprite(sprite: Sprite, cell: Array<number>): void;
    processTimingData(timing: RPG.Animation.Timing): void;
    startFlash(color: Array<number>, duration: number): void;
    startScreenFlash(color: Array<number>, duration: number): void;
    /**
     * Starts hiding the sprite animation.
     * 
     * @param {number} duration The duration of the hide.
     * @memberof Sprite_Animation
     */
    startHiding(duration: number): void;
}

/**
 * -----------------------------------------------------------------------------
 * Sprite_Damage
 *
 * The sprite for displaying a popup damage.
 */
declare class Sprite_Damage extends Sprite {
    protected _duration: number;
    protected _flashColor: Array<number>;
    protected _flashDuration: number;
    protected _damageBitmap: Bitmap;

    setup(target: Game_Actor): void;
    setupCriticalEffect(): void;
    /**
     * Returns the digit width of the sprite damage.
     * 
     * @returns {number} 
     * @memberof Sprite_Damage
     */
    digitWidth(): number;
    /**
     * Returns the digit height of the sprite damage.
     * 
     * @returns {number} 
     * @memberof Sprite_Damage
     */
    digitHeight(): number;
    /**
     * Creates the miss display of the damage sprite.
     * 
     * @memberof Sprite_Damage
     */
    createMiss(): void;
    createDigits(baseRow: number, value: number): void;
    /**
     * Creates the child sprite of the damage sprite for displaying damage.
     * 
     * @returns {Sprite} 
     * @memberof Sprite_Damage
     */
    createChildSprite(): Sprite;
    updateChild(sprite: Sprite): void;
    /**
     * Updates the flash of the damage sprite.
     * 
     * @memberof Sprite_Damage
     */
    updateFlash(): void;
    /**
     * Updates the opacity of the damage sprite.
     * 
     * @memberof Sprite_Damage
     */
    updateOpacity(): void;
    /**
     * Returns true if the damage sprite is playing.
     * 
     * @returns {boolean} 
     * @memberof Sprite_Damage
     */
    isPlaying(): boolean;
}

/**
 * -----------------------------------------------------------------------------
 * Sprite_StateIcon
 *
 * The sprite for displaying state icons.
 */
declare class Sprite_StateIcon extends Sprite {
    protected static _iconWidth: number;
    protected static _iconHeight: number;

    protected _battler: Game_Battler;
    protected _iconIndex: number;
    protected _animationCount: number;
    protected _animationIndex: number;

    /**
     * Initializes the sprite state icon properties.
     * 
     * @memberof Sprite_StateIcon
     */
    initMembers(): void;
    /**
     * Loads the bitmap of the sprite state icon.
     * 
     * @memberof Sprite_StateIcon
     */
    loadBitmap(): void;
    setup(battler: Game_Battler): void;
    animationWait(): number;
    /**
     * Updates the icon displayed in the icon sprite.
     * 
     * @memberof Sprite_StateIcon
     */
    updateIcon(): void;
    /**
     * Updates the state icon sprite frame.
     * 
     * @memberof Sprite_StateIcon
     */
    updateFrame(): void;
}

/**
 * -----------------------------------------------------------------------------
 * Sprite_StateOverlay
 *
 * The sprite for displaying an overlay image for a state.
 */
declare class Sprite_StateOverlay extends Sprite_Base {
    protected _battler: Game_Battler;
    protected _overlayIndex: number;
    protected _animationCount: number;
    protected _pattern: number;

    /**
     * Initialize the overlay sprite properties.
     * 
     * @memberof Sprite_StateOverlay
     */
    initMembers(): void;
    /**
     * Loads the bitmap of the overlay sprite.
     * 
     * @memberof Sprite_StateOverlay
     */
    loadBitmap(): void;
    setup(battler: Game_Battler): void;
    animationWait(): number;
    /**
     * Updates the overlay sprite pattern.
     * 
     * @memberof Sprite_StateOverlay
     */
    updatePattern(): void;
    /**
     * Updates the overlay sprite frame.
     * 
     * @memberof Sprite_StateOverlay
     */
    updateFrame(): void;
}

/**
 * -----------------------------------------------------------------------------
 * Sprite_Weapon
 *
 * The sprite for displaying a weapon image for attacking.
 */
declare class Sprite_Weapon extends Sprite_Base {
    protected _weaponImageId: number;
    protected _animationCount: number;
    protected _pattern: number;

    /**
     * Initializes the members of the weapon sprite object.
     * 
     * @memberof Sprite_Weapon
     */
    initMembers(): void;
    setup(weaponImageId: number): void;
    animationWait(): number;
    /**
     * Updates the pattern of the weapon sprite.
     * 
     * @memberof Sprite_Weapon
     */
    updatePattern(): void;
    /**
     * Loads the bitmap of the weapon sprite.
     * 
     * @memberof Sprite_Weapon
     */
    loadBitmap(): void;
    /**
     * Updates the weapon sprite frames.
     * 
     * @memberof Sprite_Weapon
     */
    updateFrame(): void;
    /**
     * Returns true if the weapon sprite is playing.
     * 
     * @returns {boolean} 
     * @memberof Sprite_Weapon
     */
    isPlaying(): boolean;
}

/**
 * -----------------------------------------------------------------------------
 * Sprite_Balloon
 *
 * The sprite for displaying a balloon icon.
 */
declare class Sprite_Balloon extends Sprite_Base {
    protected _balloonId: number;
    protected _duration: number;

    initMembers(): void;
    loadBitmap(): void;
    setup(balloonId: number): void;
    /**
     * Updates the balloon sprite.
     * 
     * @memberof Sprite_Balloon
     */
    update(): void;
    /**
     * Updates the balloon sprite frame.
     * 
     * @memberof Sprite_Balloon
     */
    updateFrame(): void;
    /**
     * Returns the speed of the balloon animation.
     * 
     * @returns {number} 
     * @memberof Sprite_Balloon
     */
    speed(): number;
    /**
     * Returns the wait time.
     * 
     * @returns {number} 
     * @memberof Sprite_Balloon
     */
    waitTime(): number;
    /**
     * Returns the frame index of the balloon animation.
     * 
     * @returns {number} 
     * @memberof Sprite_Balloon
     */
    frameIndex(): number;
    /**
     * Returns true if the balloon animation is playing.
     * 
     * @returns {boolean} 
     * @memberof Sprite_Balloon
     */
    isPlaying(): boolean;
}

/**
 * -----------------------------------------------------------------------------
 * Sprite_Picture
 *
 * The sprite for displaying a picture.
 */
declare class Sprite_Picture extends Sprite {
    protected _pictureId: number;
    protected _pictureName: string;
    protected _isPicture: boolean;

    constructor(pictureId: number);

    picture(): Game_Picture;
    updateBitmap(): void;
    updateOrigin(): void;
    updatePosition(): void;
    updateScale(): void;
    updateTone(): void;
    updateOther(): void;
    loadBitmap(): void;
}

/**
 * -----------------------------------------------------------------------------
 * Sprite_Timer
 *
 * The sprite for displaying the timer.
 */
declare class Sprite_Timer extends Sprite {
    protected _seconds: number;

    /**
     * Creates the bitmap of the sprite timer.
     * 
     * @memberof Sprite_Timer
     */
    createBitmap(): void;
    /**
     * Updates the bitmap of the sprite timer.
     * 
     * @memberof Sprite_Timer
     */
    updateBitmap(): void;
    /**
     * Redraws the sprite timer.
     * 
     * @memberof Sprite_Timer
     */
    redraw(): void;
    /**
     * Returns the text of the timer.
     * 
     * @returns {string} The text displayed on the timer.
     * @memberof Sprite_Timer
     */
    timerText(): string;
    /**
     * Updates the position of the sprite timer.
     * 
     * @memberof Sprite_Timer
     */
    updatePosition(): void;
    /**
     * Updates the visibility of the sprite timer.
     * 
     * @memberof Sprite_Timer
     */
    updateVisibility(): void;
}

/**
 * -----------------------------------------------------------------------------
 * Sprite_Destination
 *
 * The sprite for displaying the destination place of the touch input.
 */
declare class Sprite_Destination extends Sprite {
    protected _frameCount: number;

    /**
     * Creates the destination bitmap of the destination sprite.
     * 
     * @memberof Sprite_Destination
     */
    createBitmap(): void;
    /**
     * Updates the position of the destination sprite.
     * 
     * @memberof Sprite_Destination
     */
    updatePosition(): void;
    /**
     * Updates the destination sprite animation.
     * 
     * @memberof Sprite_Destination
     */
    updateAnimation(): void;
}

/**
 * -----------------------------------------------------------------------------
 * Spriteset_Base
 *
 * The superdeclare class of Spriteset_Map and Spriteset_Battle.
 */
declare class Spriteset_Base extends Sprite {
    protected _tone: Array<number>;
    protected _baseSprite: Sprite;
    protected _blackScreen: ScreenSprite;
    protected _toneFilter: ToneFilter;
    protected _toneSprite: ToneSprite;
    protected _pictureContainer: Sprite;
    protected _timerSprite: Sprite_Timer;
    protected _flashSprite: ScreenSprite;
    protected _fadeSprite: ScreenSprite;

    /**
     * Creates the lower layer including the base sprites.
     * 
     * @memberof Spriteset_Base
     */
    createLowerLayer(): void;
    /**
     * Creates the upper layer including the pictures,
     * timer, and screen sprites.
     * @memberof Spriteset_Base
     */
    createUpperLayer(): void;
    /**
     * Create the base sprite.
     * 
     * @memberof Spriteset_Base
     */
    createBaseSprite(): void;
    /**
     * Creates the tone changer sprite.
     * 
     * @memberof Spriteset_Base
     */
    createToneChanger(): void;
    /**
     * Creates the WebGL toner.
     * 
     * @memberof Spriteset_Base
     */
    createWebGLToneChanger(): void;
    /**
     * Creates the Canvas tone.
     * 
     * @memberof Spriteset_Base
     */
    createCanvasToneChanger(): void;
    /**
     * Creates a new sprite picture on the spriteset base.
     * 
     * @memberof Spriteset_Base
     */
    createPictures(): void;
    /**
     * Creates a new Sprite timer on the spriteset base.
     * 
     * @memberof Spriteset_Base
     */
    createTimer(): void;
    /**
     * Creates the screen sprite.
     * 
     * @memberof Spriteset_Base
     */
    createScreenSprites(): void;
    /**
     * Updates the screen sprites on the spriteset base.
     * 
     * @memberof Spriteset_Base
     */
    updateScreenSprites(): void;
    updateToneChanger(): void;
    /**
     * Updates the WebGL tone changer.
     * 
     * @memberof Spriteset_Base
     */
    updateWebGLToneChanger(): void;
    /**
     * Updates the Canvas tone changer.
     * 
     * @memberof Spriteset_Base
     */
    updateCanvasToneChanger(): void;
    /**
     * Updates the position of spriteset base.
     * 
     * @memberof Spriteset_Base
     */
    updatePosition(): void;
}

/**
 * -----------------------------------------------------------------------------
 * Spriteset_Map
 *
 * The set of sprites on the map screen.
 */
declare class Spriteset_Map extends Spriteset_Base {
    protected _parallax: TilingSprite;
    protected _tilemap: Tilemap | ShaderTilemap;
    protected _tileset: RPG.Tileset;
    protected _characterSprites: Array<Sprite_Character>;
    protected _shadowSprite: Sprite;
    protected _destinationSprite: Sprite_Destination;
    protected _weather: Weather;
    protected _parallaxName: string;

    /**
     * Hides the map spriteset character sprites.
     * 
     * @memberof Spriteset_Map
     */
    hideCharacters(): void;
    /**
     * Creates the map spriteset parallax.
     * 
     * @memberof Spriteset_Map
     */
    createParallax(): void;
    /**
     * Creates the map spriteset tile map.
     * 
     * @memberof Spriteset_Map
     */
    createTilemap(): void;
    /**
     * Loads the map spriteset tileset.
     * 
     * @memberof Spriteset_Map
     */
    loadTileset(): void;
    /**
     * Creates the map spriteset character sprite.
     * 
     * @memberof Spriteset_Map
     */
    createCharacters(): void;
    /**
     * Creates the map spriteset shadow sprite.
     * 
     * @memberof Spriteset_Map
     */
    createShadow(): void;
    /**
     * Creates the map spriteset destination sprite.
     * 
     * @memberof Spriteset_Map
     */
    createDestination(): void;
    /**
     * Creates the map spriteset weather.
     * 
     * @memberof Spriteset_Map
     */
    createWeather(): void;
    /**
     * Updates the map spriteset tileset.
     * 
     * @memberof Spriteset_Map
     */
    updateTileset(): void;
    /**
     * Simple fix for canvas parallax issue, destroy old parallax and readd to  the tree.
     */
    protected _canvasReAddParallax(): void;
    updateParallax(): void;
    /**
     * Updates the map spriteset tile map.
     * 
     * @memberof Spriteset_Map
     */
    updateTilemap(): void;
    /**
     * Updates the map spriteset shadow.
     * 
     * @memberof Spriteset_Map
     */
    updateShadow(): void;
    /**
     * Updates the map spriteset weather.
     * 
     * @memberof Spriteset_Map
     */
    updateWeather(): void;
}

/**
 * -----------------------------------------------------------------------------
 * Spriteset_Battle
 *
 * The set of sprites on the battle screen.
 */
declare class Spriteset_Battle extends Spriteset_Base {
    protected _battlebackLocated: boolean;
    protected _backgroundSprite: Sprite;
    protected _battleField: Sprite;
    protected _back1Sprite: TilingSprite;
    protected _back2Sprite: TilingSprite;
    protected _enemySprites: Array<Sprite_Enemy>;
    protected _actorSprites: Array<Sprite_Actor>;

    /**
     * Creates the background of the battle spriteset.
     * 
     * @memberof Spriteset_Battle
     */
    createBackground(): void;
    /**
     * Creates the battlefield of the battle spriteset.
     * 
     * @memberof Spriteset_Battle
     */
    createBattleField(): void;
    /**
     * Creates the battleback of the battle spriteset.
     * 
     * @memberof Spriteset_Battle
     */
    createBattleback(): void;
    /**
     * Updates the battleback of the battle spriteset.
     * 
     * @memberof Spriteset_Battle
     */
    updateBattleback(): void;
    /**
     * Locates the battleback and adjusts the coordinates of the
     * battleback.
     * @memberof Spriteset_Battle
     */
    locateBattleback(): void;
    /**
     * Returns battleback 2 of the battle spriteset.
     * 
     * @returns {Bitmap} Instance of the Bitmap class.
     * @memberof Spriteset_Battle
     */
    battleback1Bitmap(): Bitmap;
    /**
     * Returns battleback 2 of the battle spriteset.
     * 
     * @returns {Bitmap} Instance of the Bitmap class.
     * @memberof Spriteset_Battle
     */
    battleback2Bitmap(): Bitmap;
    /**
     * 
     * 
     * @returns {string} Name of battleback 1 bitmap.
     * @memberof Spriteset_Battle
     */
    battleback1Name(): string;
    /**
     * 
     * 
     * @returns {string} Name of battleback 2 bitmap.
     * @memberof Spriteset_Battle
     */
    battleback2Name(): string;
    /**
     * Returns the battleback 1 name as a string.
     * 
     * @returns {string} Name of overworld battleback 1 bitmap.
     * @memberof Spriteset_Battle
     */
    overworldBattleback1Name(): string;
    /**
     * Returns the battleback 2 name as a string.
     * 
     * @returns {string} Name of overworld battleback 2 bitmap.
     * @memberof Spriteset_Battle
     */
    overworldBattleback2Name(): string;
    /**
     * 
     * 
     * @returns {string} Name of the normal battleback 1 bitmap.
     * @memberof Spriteset_Battle
     */
    normalBattleback1Name(): string;
    /**
     * 
     * 
     * @returns {string} Name of the normal battleback 2 bitmap.
     * @memberof Spriteset_Battle
     */
    normalBattleback2Name(): string;
    /**
     * Given the specified terrtain type, return
     * the battleback 1 name.
     * @param {number} type Terrain type.
     * @returns {string} Name of the terrtain battleback 1 bitmap.
     * @memberof Spriteset_Battle
     */
    terrainBattleback1Name(type: number): string;
    /**
     * Given the specified terrain type, return
     * the battleback 2 name.
     * @param {number} type Terrain type.
     * @returns {string} Name of the terrain battleback 2 bitmap.
     * @memberof Spriteset_Battle
     */
    terrainBattleback2Name(type: number): string;
    /**
     * 
     * 
     * @returns {string} Name of the default battleback 1 name.
     * @memberof Spriteset_Battle
     */
    defaultBattleback1Name(): string;
    /**
     * 
     * 
     * @returns {string} Name of the default battleback 2 name.
     * @memberof Spriteset_Battle
     */
    defaultBattleback2Name(): string;
    /**
     * 
     * 
     * @returns {string} Name of the ship battleback 1  bitmap.
     * @memberof Spriteset_Battle
     */
    shipBattleback1Name(): string;
    /**
     * 
     * 
     * @returns {string} Name of the ship battleback 2 bitmap.
     * @memberof Spriteset_Battle
     */
    shipBattleback2Name(): string;
    autotileType(z: number): number;
    /**
     * Creates sprite enemies for the battle spriteset.
     * 
     * @memberof Spriteset_Battle
     */
    createEnemies(): void;
    compareEnemySprite(a: Sprite_Enemy, b: Sprite_Enemy): number;
    /**
     * Creates sprite actors for the battle spriteset.
     * 
     * @memberof Spriteset_Battle
     */
    createActors(): void;
    /**
     * Updates the actor sprites on the battle spriteset.
     * 
     * @memberof Spriteset_Battle
     */
    updateActors(): void;
    /**
     * Returns all battler sprites on the battle spriteset.
     * 
     * @returns {Array<Sprite_Battler>} 
     * @memberof Spriteset_Battle
     */
    battlerSprites(): Array<Sprite_Battler>;
    /**
     * Returns true if animation is playing on the battle spriteset.
     * 
     * @returns {boolean} 
     * @memberof Spriteset_Battle
     */
    isAnimationPlaying(): boolean;
    isEffecting(): boolean;
    /**
     * Returns true if any sprite actor or enemy is moving.
     * 
     * @returns {boolean} Representing whether any battle participants are moving.
     * @memberof Spriteset_Battle
     */
    isAnyoneMoving(): boolean;
    /**
     * Returns true if the battle spriteset is busy.
     * 
     * @returns {boolean} 
     * @memberof Spriteset_Battle
     */
    isBusy(): boolean;
}
//=============================================================================
// rpg_windows.js v1.5.0
//=============================================================================

//-----------------------------------------------------------------------------
// Window_Base
//
// The superclass of all windows within the game.

/**
 * Super class of all windows within the game.
 * Inherits from the Window class.
 * @class Window_Base
 * @extends {Window}
 */
declare class Window_Base {
    /**
     * The standard icon width;
     * default is 32.
     * @protected
     * @static
     * @type {number}
     * @memberof Window_Base
     */
    protected static _iconWidth: number;
    /**
     * The standard icon height;
     * default is 32.
     * @protected
     * @static
     * @type {number}
     * @memberof Window_Base
     */
    protected static _iconHeight: number;
    /**
     * The standard face width;
     * default is 144.
     * @protected
     * @static
     * @type {number}
     * @memberof Window_Base
     */
    protected static _faceWidth: number;
    /**
     * The standard face height;
     * default is 144.
     * @protected
     * @static
     * @type {number}
     * @memberof Window_Base
     */
    protected static _faceHeight: number;
    /**
     * The opening property; determines if
     * the window is opening.
     * @protected
     * @type {boolean}
     * @memberof Window_Base
     */
    protected _opening: boolean;
    /**
     * The closing property; determines if
     * the window is closing.
     * @protected
     * @type {boolean}
     * @memberof Window_Base
     */
    protected _closing: boolean;

    /**
     * Creates an instance of Window_Base.
     * @param {number} x 
     * @param {number} y 
     * @param {number} width 
     * @param {number} height 
     * @memberof Window_Base
     */
    constructor(x: number, y: number, width: number, height: number);

    /**
     * Returns the standard line height of the current window;
     * default is 36.
     * @returns {number} 
     * @memberof Window_Base
     */
    lineHeight(): number;
    /**
     * Returns the standard font face of the 
     * game based on what language the game is in.
     * @returns {string} 
     * @memberof Window_Base
     */
    standardFontFace(): string;
    /**
     * Returns the standard font size of the text
     * in window; default is 28.
     * @returns {number} 
     * @memberof Window_Base
     */
    standardFontSize(): number;
    /**
     * Returns the standard padding of the window;
     * default is 18.
     * @returns {number} 
     * @memberof Window_Base
     */
    standardPadding(): number;
    /**
     * Returns the text padding of the window;
     * default is 6.
     * @returns {number} 
     * @memberof Window_Base
     */
    textPadding(): number;
    /**
     * Returns the standard back opacity of the window; this is the
     * opacity of the area behind the window's text content.
     * Default is 192.
     * @returns {number} 
     * @memberof Window_Base
     */
    standardBackOpacity(): number;
    /**
     * Loads the window skin from the img/system directory.
     * 
     * @memberof Window_Base
     */
    loadWindowSkin(): void;
    /**
     * Updates the window padding based on the 
     * standardPadding method.
     * @memberof Window_Base
     */
    updatePadding(): void;
    /**
     * Updates the back opacity of the window
     * based on the standardBackOpacity method.
     * @memberof Window_Base
     */
    updateBackOpacity(): void;
    /**
     * Returns the inner content width of the window.
     * 
     * @returns {number} 
     * @memberof Window_Base
     */
    contentsWidth(): number;
    /**
     * Returns the inner content height of the window.
     * 
     * @returns {number} 
     * @memberof Window_Base
     */
    contentsHeight(): number;
    /**
     * Returns the fitting height given a number of lines based on
     * the line height plus standard padding of the window.
     * Default formula: numLines * lineHeight + standardPadding * 2
     *
     * @param {number} numLines 
     * @returns {number} 
     * @memberof Window_Base
     */
    fittingHeight(numLines: number): number;
    /**
     * Updates the tone of the window based on the
     * game system window tone defined in the database.
     * @memberof Window_Base
     */
    updateTone(): void;
    /**
     * Creates the contents of the window; this is the area
     * of the window which text is drawn to.
     * @memberof Window_Base
     */
    createContents(): void;
    /**
     * Resets the font settings of the window back to the
     * default.
     * @memberof Window_Base
     */
    resetFontSettings(): void;
    /**
     * Resets the text color of the window back to the
     * default.
     * @memberof Window_Base
     */
    resetTextColor(): void;
    /**
     * The update method of the window; this is
     * run every frame to do logic processing for the window.
     * @memberof Window_Base
     */
    update(): void;
    /**
     * Updates the openness of the window when the
     * _opening property is set to true.
     * Openness is increased.
     * @memberof Window_Base
     */
    updateOpen(): void;
    /**
     * Updates the openness of the window when the 
     * _closing property is set to true.
     * Openness is decreased.
     * @memberof Window_Base
     */
    updateClose(): void;
    /**
     * Opens the window.
     * 
     * @memberof Window_Base
     */
    open(): void;
    /**
     * Closes the window.
     * 
     * @memberof Window_Base
     */
    close(): void;
    /**
     * Returns true if the window is currently opening.
     *
     * @returns {boolean} 
     * @memberof Window_Base
     */
    isOpening(): boolean;
    /**
     * Returns true if the window is currently closing.
     * 
     * @returns {boolean} 
     * @memberof Window_Base
     */
    isClosing(): boolean;
    /**
     * Shows the window, making it visible.
     * 
     * @memberof Window_Base
     */
    show(): void;
    /**
     * Hides the window, making it invisible;
     * the window is not closed when hidden.
     * 
     * @memberof Window_Base
     */
    hide(): void;
    /**
     * Activates the window, allowing it to be processed
     * and to update.
     * @memberof Window_Base
     */
    activate(): void;
    /**
     * Deactivates the window, preventing further processing.
     * 
     * @memberof Window_Base
     */
    deactivate(): void;
    /**
     * Returns a text color given a numbered index
     * as a css color string; this index maps
     * directly to the img/system/window.png colors
     * by default.
     * @param {number} n 
     * @returns {*} 
     * @memberof Window_Base
     */
    textColor(n: number): string;
    /**
     * Returns the normal color as a css
     * color string.
     * @returns {string} 
     * @memberof Window_Base
     */
    normalColor(): string;
    /**
     * Returns the system color as a
     * css color string.
     * @returns {string} 
     * @memberof Window_Base
     */
    systemColor(): string;
    /**
     * Returns the crisis color as a 
     * css color string.
     * @returns {string} 
     * @memberof Window_Base
     */
    crisisColor(): string;
    /**
     * Returns the death color as a 
     * css color string.
     * @returns {string} 
     * @memberof Window_Base
     */
    deathColor(): string;
    /**
     * Returns the gauge back color as 
     * a css color string.
     * @returns {string} 
     * @memberof Window_Base
     */
    gaugeBackColor(): string;
    /**
     * Returns the hp gauge color 1 
     * as a css color string.
     * @returns {string} 
     * @memberof Window_Base
     */
    hpGaugeColor1(): string;
    /**
     * Returns the hp gauge color 2 
     * as a css color string.
     * @returns {string} 
     * @memberof Window_Base
     */
    hpGaugeColor2(): string;
    /**
     * Returns the mp gauge color 1
     * as a css color string.
     * @returns {string} 
     * @memberof Window_Base
     */
    mpGaugeColor1(): string;
    /**
     * Returns the mp gauge color 2
     * as a css color string.
     * @returns {string} 
     * @memberof Window_Base
     */
    mpGaugeColor2(): string;
    /**
     * Returns the mp cost color as a
     * css color string.
     * @returns {string} 
     * @memberof Window_Base
     */
    mpCostColor(): string;
    /**
     * Returns the power up color as a
     * css color string.
     * @returns {string} 
     * @memberof Window_Base
     */
    powerUpColor(): string;
    /**
     * Returns the power down color as a 
     * css color string.
     * @returns {string} 
     * @memberof Window_Base
     */
    powerDownColor(): string;
    /**
     * Returns the tp gauge color 1 as a 
     * css color string.
     * @returns {string} 
     * @memberof Window_Base
     */
    tpGaugeColor1(): string;
    /**
     * Returns tp gauge color 2 as a
     * css color string.
     * @returns {string} 
     * @memberof Window_Base
     */
    tpGaugeColor2(): string;
    /**
     * Returns the tp cost color as a 
     * css color string.
     * @returns {string} 
     * @memberof Window_Base
     */
    tpCostColor(): string;
    /**
     * Returns the pending color as a
     * css color string.
     * @returns {string} 
     * @memberof Window_Base
     */
    pendingColor(): string;
    /**
     * Returns the translucentOpacity for the window;
     * The default is 160.
     * 
     * @returns {number} 
     * @memberof Window_Base
     */
    translucentOpacity(): number;
    /**
     * Changes the text color property given a css color string.
     * 
     * @param {string} color 
     * @memberof Window_Base
     */
    changeTextColor(color: string): void;
    /**
     * Changes the paintOpacity (the opacity of the text drawn to the window);
     * if true the opacity is set to 255, otherwise the opacity is set to 160.
     * @param {boolean} enabled 
     * @memberof Window_Base
     */
    changePaintOpacity(enabled: boolean): void;
    /**
     * Given text or a number, draws the content to the window's contents
     * layer at the specified x and y coordinate within the max width.
     * The text content can also be aligned with the align property.
     * The possible alignments are: "left", "center", "right".
     * @param {(string | number)} text 
     * @param {number} x 
     * @param {number} y 
     * @param {number} maxWidth 
     * @param {string} align 
     * @memberof Window_Base
     */
    drawText(text: string | number, x: number, y: number, maxWidth: number, align: string): void;
    /**
     * Calculates the width of a text string and
     * returns a number.
     * @param {string} text 
     * @returns {number} 
     * @memberof Window_Base
     */
    textWidth(text: string): number;
    /**
     * Draws text with text codes included; this will draw
     * icons, increase text height, and more.
     * @param {string} text 
     * @param {number} x 
     * @param {number} y 
     * @returns {number} 
     * @memberof Window_Base
     */
    drawTextEx(text: string, x: number, y: number): number;
    /**
     * Converts the escape characters and returns the text content
     * after processing the characters.
     * @param {string} text 
     * @returns {string} 
     * @memberof Window_Base
     */
    convertEscapeCharacters(text: string): string;
    /**
     * Returns the actor name given an index;
     * the index starts from 1.
     * @param {number} actorIndex 
     * @returns {string} 
     * @memberof Window_Base
     */
    actorName(actorIndex: number): string;
    /**
     * Returns a party member name given an index;
     * the index starts from 1.
     * @param {number} partyMemberIndex 
     * @returns {string} 
     * @memberof Window_Base
     */
    partyMemberName(partyMemberIndex: number): string;
    /**
     * Process each character in the text when drawTextEx
     * is used to draw text.
     * @param {MV.TextState} textState 
     * @memberof Window_Base
     */
    processCharacter(textState: MV.TextState): void;
    /**
     * Processes the normal characters in the text
     * when drawTextEx is used to draw text.
     * Normal characters are letters and numbers.
     * @param {MV.TextState} textState 
     * @memberof Window_Base
     */
    processNormalCharacter(textState: MV.TextState): void;
    /**
     * Processes new line when drawTextEx is used to draw text.
     * 
     * @param {MV.TextState} textState 
     * @memberof Window_Base
     */
    processNewLine(textState: MV.TextState): void;
    /**
     * Processes new page when drawTexttEx is used to draw text.
     * 
     * @param {MV.TextState} textState 
     * @memberof Window_Base
     */
    processNewPage(textState: MV.TextState): void;
    obtainEscapeCode(textState: MV.TextState): string;
    /**
     * Obtains the escape parameters from text codes in the text state
     * when drawTextEx is used to draw text.
     * @param {MV.TextState} textState 
     * @returns {(number | string)} 
     * @memberof Window_Base
     */
    obtainEscapeParam(textState: MV.TextState): number | string;
    /**
     * Processes escape characters when drawTextEx is used 
     * for drawing text.
     * @param {string} code 
     * @param {MV.TextState} textState 
     * @memberof Window_Base
     */
    processEscapeCharacter(code: string, textState: MV.TextState): void;
    /**
     * Processes drawing an icon when drawTextEx is used for
     * drawing text.
     * @param {number} iconIndex 
     * @param {MV.TextState} textState 
     * @memberof Window_Base
     */
    processDrawIcon(iconIndex: number, textState: MV.TextState): void;
    /**
     * Makes the font bigger by a value of 12.
     * 
     * @memberof Window_Base
     */
    makeFontBigger(): void;
    /**
     * Makes the font smaller by a value of 12.
     * 
     * @memberof Window_Base
     */
    makeFontSmaller(): void;
    /**
     * Calculates the text height of the textState (when using drawTextEx);
     * if all is set to true, all lines of text are calculated, otherwise
     * only a single line is processed.
     * @param {MV.TextState} textState 
     * @param {boolean} all 
     * @returns {number} 
     * @memberof Window_Base
     */
    calcTextHeight(textState: any, all: boolean): number;
    /**
     * Draws an icon given the specified iconIndex at the specified
     * x and y coordinates. The Width and Height of the icon is based on the
     * _iconWidth and _iconHeight properties.
     * @param {number} iconIndex 
     * @param {number} x 
     * @param {number} y 
     * @memberof Window_Base
     */
    drawIcon(iconIndex: number, x: number, y: number): void;
    drawFace(faceName: string, faceIndex: number, x: number, y: number, width: number, height: number): void;
    /**
     * Draws a character (map sprites) at the specified x and y coordinate.
     * CharacterName refers to character spritesheet, and characterIndex refers
     * to the characterIndex on the spritesheet.
     * @param {string} characterName 
     * @param {number} characterIndex 
     * @param {number} x 
     * @param {number} y 
     * @memberof Window_Base
     */
    drawCharacter(characterName: string, characterIndex: number, x: number, y: number): void;
    /**
     * Draws a gauge at the specified x and y coordinates within the given width.
     * Color1 and Color2 represent the gradient as css color strings of the gauge.
     * 
     * @param {number} x 
     * @param {number} y 
     * @param {number} width 
     * @param {number} rate 
     * @param {string} color1 
     * @param {string} color2 
     * @memberof Window_Base
     */
    drawGauge(x: number, y: number, width: number, rate: number, color1: string, color2: string);
    /**
     * Returns the hp color as a css string.
     * 
     * @param {Game_Actor} actor 
     * @returns {string} 
     * @memberof Window_Base
     */
    hpColor(actor: Game_Actor): string;
    /**
     * Returns the mp color as a css color string.
     * 
     * @param {Game_Actor} actor 
     * @returns {string} 
     * @memberof Window_Base
     */
    mpColor(actor: Game_Actor): string;
    /**
     * Returns the tp color as a css color string.
     * 
     * @param {Game_Actor} actor 
     * @returns {string} 
     * @memberof Window_Base
     */
    tpColor(actor: Game_Actor): string;
    drawActorCharacter(actor: Game_Actor, x: number, y: number): void;
    /**
     * Draws the actor face at the specified x and y coordinates within
     * the given width.
     * @param {Game_Actor} actor 
     * @param {number} x 
     * @param {number} y 
     * @param {number} width 
     * @param {number} height 
     * @memberof Window_Base
     */
    drawActorFace(actor: Game_Actor, x: number, y: number, width: number, height: number): void;
    /**
     * Draws the actor name at the specified x and y coordinates within
     * the given width.
     * @param {Game_Actor} actor 
     * @param {number} x 
     * @param {number} y 
     * @param {number} width 
     * @memberof Window_Base
     */
    drawActorName(actor: Game_Actor, x: number, y: number, width: number): void;
    /**
     * Draws the actor class at the specified x and y coordinates
     * within the given width.
     * @param {Game_Actor} actor 
     * @param {number} x 
     * @param {number} y 
     * @param {number} width 
     * @memberof Window_Base
     */
    drawActorClass(actor: Game_Actor, x: number, y: number, width: number): void;
    /**
     * Draws the actor nickname at the specified x and y coordinates
     * within the given width.
     * @param {Game_Actor} actor 
     * @param {number} x 
     * @param {number} y 
     * @param {number} width 
     * @memberof Window_Base
     */
    drawActorNickname(actor: Game_Actor, x: number, y: number, width: number): void;
    /**
     * Draws the actor level at the specified x and y coordinates.
     * 
     * @param {Game_Actor} actor 
     * @param {number} x 
     * @param {number} y 
     * @memberof Window_Base
     */
    drawActorLevel(actor: Game_Actor, x: number, y: number);
    /**
     * Draws the actor icons at the specified x and y coordinates
     * within the given width.
     * @param {Game_Actor} actor 
     * @param {number} x 
     * @param {number} y 
     * @param {number} width 
     * @memberof Window_Base
     */
    drawActorIcons(actor: Game_Actor, x: number, y: number, width: number): void;
    /**
     * Draws the current and max number at the specified x and y coordinate
     * within the given width. Color1 represents the current number and color2
     * represents the max number when the text is drawn.
     * @param {number} current 
     * @param {number} max 
     * @param {number} x 
     * @param {number} y 
     * @param {number} width 
     * @param {string} color1 
     * @param {string} color2 
     * @memberof Window_Base
     */
    drawCurrentAndMax(current: number, max: number, x: number, y: number, width: number, color1: string, color2: string): void;
    /**
     * Draws the actor hp at the specified x and y coordinates within
     * the given width.
     * @param {Game_Actor} actor 
     * @param {number} x 
     * @param {number} y 
     * @param {number} width 
     * @memberof Window_Base
     */
    drawActorHp(actor: Game_Actor, x: number, y: number, width: number): void;
    /**
     * Draws the actor mp at the specified x and y coordinates within
     * the given width.
     * @param {Game_Actor} actor 
     * @param {number} x 
     * @param {number} y 
     * @param {number} width 
     * @memberof Window_Base
     */
    drawActorMp(actor: Game_Actor, x: number, y: number, width: number): void;
    /**
     * Draws the actor tp at the specified x and y coordinates within the
     * given width.
     * @param {Game_Actor} actor 
     * @param {number} x 
     * @param {number} y 
     * @param {number} width 
     * @memberof Window_Base
     */
    drawActorTp(actor: Game_Actor, x: number, y: number, width: number): void;
    /**
     * Draws a simple status for the game actor passed into the method at the
     * specified x and y coordinates within the given width.
     * 
     * @param {Game_Actor} actor 
     * @param {number} x 
     * @param {number} y 
     * @param {number} width 
     * @memberof Window_Base
     */
    drawActorSimpleStatus(actor: Game_Actor, x: number, y: number, width: number): void;
    /**
     * Draws the item name at the specified x and y coordinates within
     * the given width.
     * @param {RPG.BaseItem} item 
     * @param {number} x 
     * @param {number} y 
     * @param {number} width 
     * @memberof Window_Base
     */
    drawItemName(item: RPG.BaseItem, x: number, y: number, width: number): void;
    /**
     * Draws the currency value given at the specified x and y coordinates within
     * the width given. Useful if you want to write your own custom currency value.
     * @param {number} value 
     * @param {string} unit 
     * @param {number} x 
     * @param {number} y 
     * @param {number} width 
     * @memberof Window_Base
     */
    drawCurrencyValue(value: number, unit: string, x: number, y: number, width: number): void;
    /**
     * Changes the text color based on the powerUpColor, powerDownColor
     * and normal color. powerUpColor is any number greater than 0, powerDownColor
     * is any color less than 0, otherwise normal color is returned.
     * @param {number} change 
     * @memberof Window_Base
     */
    paramchangeTextColor(change: number): void;
    /**
     * Sets the background type of the window.
     * 0 is 255 window opacity (standard).
     * 1 is the window with background dimmer.
     * Any other number changes the opacity
     * to 0.
     * @param {number} type 
     * @memberof Window_Base
     */
    setBackgroundType(type: number): void;
    /**
     * Shows the background dimmer sprite.
     * 
     * @memberof Window_Base
     */
    showBackgroundDimmer(): void;
    /**
     * Hides the background dimmer sprite.
     * 
     * @memberof Window_Base
     */
    hideBackgroundDimmer(): void;
    /**
     * Updates the background dimmer sprite opacity based on the openness
     * of the window.
     * @memberof Window_Base
     */
    updateBackgroundDimmer(): void;
    /**
     * Refreshes the bitmap attached to the dimmer sprite
     * based on the window dimensions.
     * @memberof Window_Base
     */
    refreshDimmerBitmap(): void;
    /**
     * Color 1 of the dimmer sprite bitmap.
     * for the gradient.
     * @returns {string} 
     * @memberof Window_Base
     */
    dimColor1(): string;
    /**
     * Color 2 of the dimmer sprite bitmap
     * for the gradient.
     * @returns {string} 
     * @memberof Window_Base
     */
    dimColor2(): string;
    /**
     * Returns the x coordinate of the mouse to
     * a local window x coordinate.
     * @param {number} x 
     * @returns {number} 
     * @memberof Window_Base
     */
    canvasToLocalX(x: number): number;
    /**
     * Returns the y coordinate of the mouse
     * to a local window y coordinate.
     * @param {number} y 
     * @returns {number} 
     * @memberof Window_Base
     */
    canvasToLocalY(y: number): number;
    /**
     * Reverses the face images of the 
     * game party members.
     * @memberof Window_Base
     */
    reserveFaceImages(): void;
}

//-----------------------------------------------------------------------------
// Window_Selectable
//
// The window class with cursor movement and scroll functions.

declare class Window_Selectable extends Window_Base {
    /**
     * The index property of Window_Selectable; this is used
     * to select items from the list within the window.
     * @protected
     * @type {number}
     * @memberof Window_Selectable
     */
    protected _index: number;
    /**
     * The boolean property that determines if the cursor is
     * fixed(locked to a position).
     * @protected
     * @type {boolean}
     * @memberof Window_Selectable
     */
    protected _cursorFixed: boolean;
    protected _cursorAll: boolean;
    protected _stayCount: number;
    protected _helpWindow: any;
    protected _handlers: object;
    protected _touching: boolean;
    protected _scrollX: number;
    protected _scrollY: number;

    constructor(x: number, y: number, width: number, height: number);
    /**
     * Returns the current position of the _index property.
     * 
     * @returns {number} 
     * @memberof Window_Selectable
     */
    index(): number;
    /**
     * Returns true if the _cursorFixed property is true;
     * this means the cursor is locked to a position.
     * @returns {boolean} 
     * @memberof Window_Selectable
     */
    cursorFixed(): boolean;
    /**
     * Sets the _cursorFixed property of the
     * window.
     * @param {boolean} cursorFixed 
     * @memberof Window_Selectable
     */
    setCursorFixed(cursorFixed: boolean): void;
    cursorAll(): boolean;
    setCursorAll(cursorAll: boolean): void;
    /**
     * Returns the maximum number of columns
     * for the window.
     * @returns {number} 
     * @memberof Window_Selectable
     */
    maxCols(): number;
    /**
     * Returns the maximum number of items within the window;
     * useful to overwrite when creating a new window.
     * This method is used to calculate the number of rows and more.
     * @returns {number} 
     * @memberof Window_Selectable
     */
    maxItems(): number;
    spacing(): number;
    /**
     * Returns the width of an item within the window;
     * determines the width of a column.
     * @returns {number} 
     * @memberof Window_Selectable
     */
    itemWidth(): number;
    /**
     * Returns the height of an item within the window;
     * determines the height of a row.
     * @returns {number} 
     * @memberof Window_Selectable
     */
    itemHeight(): number;
    /**
     * Selects the current index within the window given a number.
     * 
     * @param {number} index 
     * @memberof Window_Selectable
     */
    select(index: number): void;
    /**
     * Deselects the currently selected index.
     * 
     * @memberof Window_Selectable
     */
    deselect(): void;

    /**
     * Reselects the index based on the window's _index property.
     * 
     * @memberof Window_Selectable
     */
    reselect(): void;
    row(): number;
    topRow(): number;
    maxTopRow(): number;
    /**
     * Sets the current top row of the given a number.
     * The top row will then be moved to an index
     * of the window.
     * @param {number} row 
     * @memberof Window_Selectable
     */
    setTopRow(row: number): void;
    resetScroll(): void;
    maxPageRows(): number;
    maxPageItems(): number;
    /**
     * Returns true if the window is horizontal;
     * means the window only has a single row.
     * @returns {boolean} 
     * @memberof Window_Selectable
     */
    isHorizontal(): boolean;
    bottomRow(): number;
    setBottomRow(row: number): void;
    /**
     * Creates a new rectangle based on itemWidth and itemHeight.
     * The rectangle is mainly used for positioning items within
     * the selectable window.
     * @param {number} index 
     * @returns {Rectangle} 
     * @memberof Window_Selectable
     */
    itemRect(index: number): Rectangle;
    /**
     * Creates a new rectangle based on itemWidth and itemHeight
     * The rectangle is used for positioning text within
     * the selectable window.
     * @param {number} index 
     * @returns {Rectangle} 
     * @memberof Window_Selectable
     */
    itemRectForText(index: number): Rectangle;
    setHelpWindow(helpWindow: Window_Help): void;
    /**
     * Shows the attached help window.
     * 
     * @memberof Window_Selectable
     */
    showHelpWindow(): void;
    /**
     * Hides the attached help window.
     * 
     * @memberof Window_Selectable
     */
    hideHelpWindow(): void;
    /**
     * Creates a new handler with the symbol as the handler name
     * and a method (JS function) bound to it.
     * @param {string} symbol 
     * @param {*} method 
     * @memberof Window_Selectable
     */
    setHandler(symbol: string, method: any): void;
    isHandled(symbol: string): boolean;
    callHandler(symbol: string): void;
    isOpenAndActive(): boolean;
    isCursorMovable(): boolean;
    /**
     * Moves the cursor down; if wrap is passed
     * as true, then it will return to the top when
     * at the end of the list.
     * @param {boolean} wrap 
     * @memberof Window_Selectable
     */
    cursorDown(wrap: boolean): void;
    /**
     * Moves the cursor up; if wrap is passed 
     * as true, then it will return to the bottom
     * when at the top of the list.
     * @param {boolean} wrap 
     * @memberof Window_Selectable
     */
    cursorUp(wrap: boolean): void;
    cursorRight(wrap: boolean): void;
    cursorLeft(wrap: boolean): void;
    cursorPagedown(): void;
    cursorPageup(): void;
    scrollDown(): void;
    scrollUp(): void;
    updateArrows(): void;
    /**
     * Handles the processing of cursor movement.
     * 
     * @memberof Window_Selectable
     */
    processCursorMove(): void;
    /**
     * Handles the process of attached handlers.
     * 
     * @memberof Window_Selectable
     */
    processHandling(): void;
    /**
     * Handles the processing of the scroll wheel within
     * the window.
     * @memberof Window_Selectable
     */
    processWheel(): void;
    /**
     * Handles the processing of touch input.
     * 
     * @memberof Window_Selectable
     */
    processTouch(): void;
    isTouchedInsideFrame(): boolean;
    onTouch(triggered: boolean): void;
    hitTest(x: number, y: number): number;
    isContentsArea(x: number, y: number): boolean;
    /**
     * Determines if touch ok is enabled as an option;
     * this means whether you can confirm the selection
     * of an item within the window with touch input.
     * @returns {boolean} 
     * @memberof Window_Selectable
     */
    isTouchOkEnabled(): boolean;
    /**
     * Determines if ok is enabled as an option;
     * this means whether you can confirm selection
     * of an item within the window.
     * @returns {boolean} 
     * @memberof Window_Selectable
     */
    isOkEnabled(): boolean;
    isCancelEnabled(): boolean;
    isOkTriggered(): boolean;
    isCancelTriggered(): boolean;
    processOk(): void;
    /**
     * Plays a sound effect when okay is processed.
     * 
     * @memberof Window_Selectable
     */
    playOkSound(): void;
    /**
     * Plays the buzzer sound effect when input is
     * incorrect.
     * @memberof Window_Selectable
     */
    playBuzzerSound(): void;
    /**
     * Calls the ok handler and begins processing
     * confirmation of selection.
     * @memberof Window_Selectable
     */
    callOkHandler(): void;
    processCancel(): void;
    callCancelHandler(): void;
    processPageup(): void;
    processPagedown(): void;
    updateInputData(): void;
    updateCursor(): void;
    /**
     * Determines if the cursor is visible within
     * the window.
     * @returns {boolean} 
     * @memberof Window_Selectable
     */
    isCursorVisible(): boolean;
    ensureCursorVisible(): void;
    callUpdateHelp(): void;
    updateHelp(): void;
    setHelpWindowItem(item: any): void;
    isCurrentItemEnabled(): boolean;
    /**
     * Draws all items within the window; this method
     * calls drawItem multiple times.
     * @memberof Window_Selectable
     */
    drawAllItems(): void;
    drawItem(index: number): void;
    clearItem(index: number): void;
    redrawItem(index: number): void;
    redrawCurrentItem(): void;
    /**
     * Refreshes the window contents.
     * 
     * @memberof Window_Selectable
     */
    refresh(): void;
}

/**
 * Super class of windows for selecting a command.
 * 
 * @class Window_Command
 * @extends {Window_Selectable}
 */
declare class Window_Command extends Window_Selectable {
    /**
     * Creates an instance of Window_Command.
     * @param {number} x 
     * @param {number} y 
     * @memberof Window_Command
     */
    constructor(x: number, y: number)
    /**
     * Returns the width of the window;
     * default is 240.
     * @returns {number} 
     * @memberof Window_Command
     */
    windowWidth(): number;
    /**
     * Returns the height of the window;
     * takes the visible rows and passes it to the fittingHeight method.
     * @returns {number} 
     * @memberof Window_Command
     */
    windowHeight(): number;
    /**
     * Returns the number of visible rows within the window.
     * 
     * @returns {number} 
     * @memberof Window_Command
     */
    numVisibleRows(): number;
    /**
     * Returns the maximum number of items within the window.
     * 
     * @returns {number} 
     * @memberof Window_Command
     */
    maxItems(): number;
    /**
     * Clears the list of commands from the window;
     * this is useful for refreshing changing commands.
     * @memberof Window_Command
     */
    clearCommandList(): void;

    /**
     * Convenient method for overwriting and adding
     * commands with the addCommand method.
     * @memberof Window_Command
     */
    makeCommandList(): void;
    /**
     * Adds commands to the window list with the specified
     * parameters. The actual command can be found as an object.
     * @param {string} name 
     * @param {string} symbol 
     * @param {boolean} enabled 
     * @param {(any | object)} ext 
     * @memberof Window_Command
     */
    addCommand(name: string, symbol: string, enabled: boolean, ext: any | object)
    /**
     * Returns the command name given an index.
     * 
     * @param {number} index 
     * @returns {string} 
     * @memberof Window_Command
     */
    commandName(index: number): string;
    /**
     * Returns the command symbol given an index.
     * 
     * @param {number} index 
     * @returns {string} 
     * @memberof Window_Command
     */
    commandSymbol(index: number): string;
    /**
     * Determines if the command is enabled;
     * checks the enabled property of the command.
     * @param {number} index 
     * @returns {boolean} 
     * @memberof Window_Command
     */
    isCommandEnabled(index: number): boolean;
    /**
     * Returns the command object at the current index.
     * 
     * @returns {object} 
     * @memberof Window_Command
     */
    currentData(): object;
    /**
     * Returns the command symbol at the current index.
     * 
     * @returns {string} 
     * @memberof Window_Command
     */
    currentSymbol(): string;
    /**
     * Returns the ext property of the command at the current index.
     * 
     * @returns {(any | object)} 
     * @memberof Window_Command
     */
    currentExt(): any | object;
    /**
     * Finds a command object and returns the index number based
     * on the symbol property.
     * @param {string} symbol 
     * @returns {number} 
     * @memberof Window_Command
     */
    findSymbol(symbol: string): number;
    /**
     * Selects a command object based on the symbol property.
     * 
     * @param {string} symbol 
     * @memberof Window_Command
     */
    selectSymbol(symbol: string): void;
    /**
     * Finds a command object and returns the index number
     * based on the ext property.
     * @param {(any | object)} ext 
     * @returns {number} 
     * @memberof Window_Command
     */
    findExt(ext: any | object): number;
    /**
     * Selects a command object based on the ext property.
     * 
     * @param {(any | object)} ext 
     * @memberof Window_Command
     */
    selectExt(ext: any | object): void;
    /**
     * Returns the text align of the commands;
     * possible values are: 'left', 'center', 'right'.
     * @returns {string} 
     * @memberof Window_Command
     */
    itemTextAlign(): string;
}

/**
 * The command window for horizontal selection format.
 * Same as Window_Command.
 * @class Window_HorzCommand
 * @extends {Window_Command}
 */
declare class Window_HorzCommand extends Window_Command {
    constructor(x: number, y: number)
}

/**
 * The window for display the description of the
 * selected item given an item or a text string.
 * @class Window_Help
 * @extends {Window_Base}
 */
declare class Window_Help extends Window_Base {
    /**
     * The text that is displayed within the window.
     * 
     * @protected
     * @type {string}
     * @memberof Window_Help
     */
    protected _text: string;
    /**
     * Creates an instance of Window_Help.
     * @param {number} numLines 
     * @memberof Window_Help
     */
    constructor(numLines: number);
    /**
     * Sets the _text property of the window;
     * this text will be displayed within the window.
     * @param {string} text 
     * @memberof Window_Help
     */
    setText(text: string): void;
    clear(): void;
    /**
     * Sets the current item of the help window.
     * 
     * @param {RPG.BaseItem} item 
     * @memberof Window_Help
     */
    setItem(item: RPG.BaseItem): void;
}

/**
 * Window for displaying game gold in RPGMakerMV.
 * 
 * @class Window_Gold
 * @extends {Window_Base}
 */
declare class Window_Gold extends Window_Base {
    constructor(x: number, y: number);
    /**
     * Returns the $gameParty gold as a number.
     * 
     * @returns {number} 
     * @memberof Window_Gold
     */
    value(): number;
    /**
     * Returns the RPGMakerMV database currency
     * as a string.
     * @returns {string} 
     * @memberof Window_Gold
     */
    currencyUnit(): string;
}

declare class Window_MenuCommand extends Window_Command {
    constructor(x: number, y: number);
    initCommandPosition(): void;
    /**
     * Adds the standard game commands to the
     * RPGMakerMV main menu.
     * @memberof Window_MenuCommand
     */
    addMainCommands(): void;
    /**
     * Adds the standard formation command to the
     * RPGMakerMV main menu.
     * @memberof Window_MenuCommand
     */
    addFormationCommand(): void;
    /**
     * Adds any user created commands to the 
     * RPGMakerMV main menu.
     * @memberof Window_MenuCommand
     */
    addOriginalCommands(): void;
    /**
     * Adds the save command to the 
     * RPGMakerMV main menu.
     * @memberof Window_MenuCommand
     */
    addSaveCommand(): void;
    addGameEndCommand(): void;
    /**
     * Checks if the standard game commands for the menu
     * are needed based on database system options.
     * @param {string} name 
     * @returns {boolean} 
     * @memberof Window_MenuCommand
     */
    needsCommand(name: string): boolean;
    /**
     * Determines if the main commands are enabled;
     * this is based on the settings in the database.
     * @returns {boolean} 
     * @memberof Window_MenuCommand
     */
    areMainCommandsEnabled(): boolean;
    /**
     * Determines if the option command is enabled;
     * based on the setting in the database.
     * @returns {boolean} 
     * @memberof Window_MenuCommand
     */
    isOptionsEnabled(): boolean;
    /**
     * Determines if the save command is enabled;
     * based on the setting in the database.
     * @returns {boolean} 
     * @memberof Window_MenuCommand
     */
    isSaveEnabled(): boolean;
    /**
     * Selects the last command in menu.
     * 
     * @memberof Window_MenuCommand
     */
    selectLast(): void;
}

/**
 * -----------------------------------------------------------------------------
 * Window_MenuStatus
 *
 * The window for displaying party member status on the menu screen.
 * @class Window_MenuStatus
 * @extends {Window_Selectable}
 */
declare class Window_MenuStatus extends Window_Selectable {
    protected _formationMode: boolean;
    protected _pendingIndex: number;

    /**
     * Creates an instance of Window_MenuStatus.
     * @param {number} x 
     * @param {number} y 
     * @memberof Window_MenuStatus
     */
    constructor(x: number, y: number);

    windowWidth(): number;
    windowHeight(): number;
    /**
     * Returns the height of each item (actor status) in the main menu
     * window.
     * @returns {number} 
     * @memberof Window_MenuStatus
     */
    itemHeight(): number;
    /**
     * Returns the number of visible rows in
     * menu status.
     * @returns {number} 
     * @memberof Window_MenuStatus
     */
    numVisibleRows(): number;
    /**
     * Loads the images for the main menu status window.
     * 
     * @memberof Window_MenuStatus
     */
    loadImages(): void;
    /**
     * Draws the item background at the given index.
     * 
     * @param {number} index 
     * @memberof Window_MenuStatus
     */
    drawItemBackground(index: number): void;
    drawItemImage(index: number): void;
    drawItemStatus(index: number): void;
    selectLast(): void;
    /**
     * Determines if the window is in formation mode;
     * if true, the player can select characters to swap
     * positions with.
     * @returns {boolean} 
     * @memberof Window_MenuStatus
     */
    formationMode(): boolean;
    /**
     * Sets the formation mode to true or false.
     * 
     * @param {boolean} formationMode 
     * @memberof Window_MenuStatus
     */
    setFormationMode(formationMode: boolean): void;
    pendingIndex(): number;
    setPendingIndex(index: number): void;
}

/**
 * -----------------------------------------------------------------------------
 * Window_MenuActor
 *
 * The window for selecting a target actor on the item and skill screens.
 * @class Window_MenuActor
 * @extends {Window_MenuStatus}
 */
declare class Window_MenuActor extends Window_MenuStatus {
    constructor();

    selectForItem(item: RPG.BaseItem): void;
}

/**
 * -----------------------------------------------------------------------------
 * Window_ItemCategory
 *
 * The window for selecting a category of items on the item and shop screens.
 * @class Window_ItemCategory
 */
declare class Window_ItemCategory extends Window_HorzCommand {
    protected _itemWindow: Window_ItemList;

    constructor();

    /**
     * Sets the item window on the item category window.
     * 
     * @param {Window_ItemList} itemWindow 
     * @memberof Window_ItemCategory
     */
    setItemWindow(itemWindow: Window_ItemList): void;
}

/**
 * -----------------------------------------------------------------------------
 * Window_ItemList
 *
 * The window for selecting an item on the item screen.
 * @class Window_ItemList
 */
declare class Window_ItemList extends Window_Selectable {
    protected _category: string;
    protected _data: Array<RPG.BaseItem>;

    constructor(x: number, y: number, width: number, height: number);

    setCategory(category: string): void;
    /**
     * Returns the current item.
     * 
     * @returns {RPG.BaseItem} 
     * @memberof Window_ItemList
     */
    item(): RPG.BaseItem;
    /**
     * Returns true if the given item is included.
     * 
     * @param {RPG.BaseItem} item 
     * @returns {boolean} 
     * @memberof Window_ItemList
     */
    includes(item: RPG.BaseItem): boolean;
    needsNumber(): boolean;
    /**
     * Returns true if the given item is enabled.
     * 
     * @param {RPG.BaseItem} item 
     * @returns {boolean} 
     * @memberof Window_ItemList
     */
    isEnabled(item: RPG.BaseItem): boolean;
    selectLast(): void;
    /**
     * Creates the item list.
     * 
     * @memberof Window_ItemList
     */
    makeItemList(): void;
    /**
     * Returns the width of the numbers.
     * 
     * @returns {number} 
     * @memberof Window_ItemList
     */
    numberWidth(): number;
    drawItemNumber(item: RPG.BaseItem, x: number, y: number, width: number): void;
}

/**
 * -----------------------------------------------------------------------------
 * Window_SkillType
 *
 * The window for selecting a skill type on the skill screen.
 * @class Window_SkillType
 */
declare class Window_SkillType extends Window_Command {
    /**
     * The current game actor attached to the window.
     * 
     * @protected
     * @type {Game_Actor}
     * @memberof Window_SkillType
     */
    protected _actor: Game_Actor;
    /**
     * The current skill window attached to the window.
     * 
     * @protected
     * @type {Window_SkillList}
     * @memberof Window_SkillType
     */
    protected _skillWindow: Window_SkillList;

    /**
     * Creates an instance of Window_SkillType.
     * @param {number} x 
     * @param {number} y 
     * @memberof Window_SkillType
     */
    constructor(x: number, y: number);

    /**
     * Sets the current actor for the skill type window.
     * 
     * @param {Game_Actor} actor 
     * @memberof Window_SkillType
     */
    setActor(actor: Game_Actor): void;
    /**
     * Sets the skill window for the current skill type.
     * 
     * @param {Window_SkillList} skillWindow 
     * @memberof Window_SkillType
     */
    setSkillWindow(skillWindow: Window_SkillList): void;
    /**
     * Selects the last command in the window.
     * 
     * @memberof Window_SkillType
     */
    selectLast(): void;
}

/**
 * -----------------------------------------------------------------------------
 * Window_SkillStatus
 *
 * The window for displaying the skill user's status on the skill screen.
 * @class Window_SkillStatus
 */
declare class Window_SkillStatus extends Window_Base {
    /**
     * The current game actor attached to the window.
     * 
     * @protected
     * @type {Game_Actor}
     * @memberof Window_SkillStatus
     */
    protected _actor: Game_Actor;

    /**
     * Creates an instance of Window_SkillStatus.
     * @param {number} x 
     * @param {number} y 
     * @param {number} width 
     * @param {number} height 
     * @memberof Window_SkillStatus
     */
    constructor(x: number, y: number, width: number, height: number);

    /**
     * Sets the current actor for the window.
     * 
     * @param {Game_Actor} actor 
     * @memberof Window_SkillStatus
     */
    setActor(actor: Game_Actor): void;
    /**
     * Refreshes the window contents.
     * 
     * @memberof Window_SkillStatus
     */
    refresh(): void;
}

/**
 * -----------------------------------------------------------------------------
 * Window_SkillList
 *
 * The window for selecting a skill on the skill screen.
 * @class Window_SkillList
 */
declare class Window_SkillList extends Window_Selectable {
    protected _actor: Game_Actor;
    protected _stypeId: number;
    protected _data: Array<RPG.Skill>;

    constructor(x: number, y: number, width: number, height: number);

    /**
     * Sets the current actor of the skill list window.
     * 
     * @param {Game_Actor} actor 
     * @memberof Window_SkillList
     */
    setActor(actor: Game_Actor): void;
    /**
     * Sets the skill type id of the skill list window.
     * 
     * @param {number} stypeId 
     * @memberof Window_SkillList
     */
    setStypeId(stypeId: number): void;
    /**
     * Returns the current skill from the database.
     * 
     * @returns {RPG.Skill} 
     * @memberof Window_SkillList
     */
    item(): RPG.Skill;
    /**
     * Returns true if the given skill is included.
     * 
     * @param {RPG.Skill} item 
     * @returns {boolean} 
     * @memberof Window_SkillList
     */
    includes(item: RPG.Skill): boolean;
    /**
     * Returns true if the given skill is enabled.
     * 
     * @param {RPG.Skill} item 
     * @returns {boolean} 
     * @memberof Window_SkillList
     */
    isEnabled(item: RPG.Skill): boolean;
    /**
     * Creates the item list.
     * 
     * @memberof Window_SkillList
     */
    makeItemList(): void;
    selectLast(): void;
    costWidth(): number;
    drawSkillCost(skill: RPG.Skill, x: number, y: number, width: number): void;
}

/**
 * -----------------------------------------------------------------------------
 * Window_EquipStatus
 *
 * The window for displaying parameter changes on the equipment screen.
 * @class Window_EquipStatus
 */
declare class Window_EquipStatus extends Window_Base {
    protected _actor: Game_Actor;
    protected _tempActor: Game_Actor;

    constructor(x: number, y: number);

    windowWidth(): number;
    windowHeight(): number;
    numVisibleRows(): number;
    setActor(actor: Game_Actor): void;
    refresh(): void;
    setTempActor(tempActor: Game_Actor): void;
    drawItem(x: number, y: number, paramId: number): void;
    drawParamName(x: number, y: number, paramId: number): void;
    drawCurrentParam(x: number, y: number, paramId: number): void;
    drawRightArrow(x: number, y: number): void;
    drawNewParam(x: number, y: number, paramId: number): void;
}

/**
 * -----------------------------------------------------------------------------
 * Window_EquipCommand
 *
 * The window for selecting a command on the equipment screen.
 * @class Window_EquipCommand
 */
declare class Window_EquipCommand extends Window_HorzCommand {
    protected _windowWidth: number;

    constructor(x: number, y: number, width: number);
}

/**
 * -----------------------------------------------------------------------------
 * Window_EquipSlot
 *
 * The window for selecting an equipment slot on the equipment screen.
 * @class Window_EquipSlot
 */
declare class Window_EquipSlot extends Window_Selectable {
    protected _actor: Game_Actor;
    protected _itemWindow: Window_EquipItem;
    protected _statusWindow: Window_EquipStatus;

    constructor(x: number, y: number, width: number, height: number);

    /**
     * Sets the current game actor.
     * 
     * @param {Game_Actor} actor 
     * @memberof Window_EquipSlot
     */
    setActor(actor: Game_Actor): void;
    /**
     * Returns the current equip item.
     * 
     * @returns {RPG.EquipItem} 
     * @memberof Window_EquipSlot
     */
    item(): RPG.EquipItem;
    /**
     * Returns the name of the slot at the specified index.
     * 
     * @param {number} index 
     * @returns {string} 
     * @memberof Window_EquipSlot
     */
    slotName(index: number): string;
    /**
     * Returns true if the current slot is enabled.
     * 
     * @param {number} index 
     * @returns {boolean} 
     * @memberof Window_EquipSlot
     */
    isEnabled(index: number): boolean;
    /**
     * Sets the status window within the equip slot window.
     * 
     * @param {Window_EquipStatus} statusWindow 
     * @memberof Window_EquipSlot
     */
    setStatusWindow(statusWindow: Window_EquipStatus): void;
    /**
     * Sets the item window within the equip slot window.
     * 
     * @param {Window_EquipItem} itemWindow 
     * @memberof Window_EquipSlot
     */
    setItemWindow(itemWindow: Window_EquipItem): void;
}

/**
 * -----------------------------------------------------------------------------
 * Window_EquipItem
 *
 * The window for selecting an equipment item on the equipment screen.
 * @class Window_EquipItem
 */
declare class Window_EquipItem extends Window_ItemList {
    protected _actor: Game_Actor;
    protected _slotId: number;
    protected _statusWindow: Window_EquipStatus;

    constructor(x: number, y: number, width: number, height: number);

    setActor(actor: Game_Actor): void;
    setSlotId(slotId: number): void;
    includes(item: RPG.EquipItem): boolean;
    isEnabled(item: RPG.EquipItem): boolean;
    setStatusWindow(statusWindow: Window_EquipStatus): void;
}

/**
 * -----------------------------------------------------------------------------
 * Window_Status
 *
 * The window for displaying full status on the status screen.
 * @class Window_Status
 */
declare class Window_Status extends Window_Selectable {
    protected _actor: Game_Actor;

    constructor();

    setActor(actor: Game_Actor): void;
    drawBlock1(y: number): void;
    drawBlock2(y: number): void;
    drawBlock3(y: number): void;
    drawBlock4(y: number): void;
    /**
     * Draws a horizontal line at the given y coordinate.
     * 
     * @param {number} y 
     * @memberof Window_Status
     */
    drawHorzLine(y: number): void;
    lineColor(): string;
    drawBasicInfo(x: number, y: number): void;
    drawParameters(x: number, y: number): void;
    drawExpInfo(x: number, y: number): void;
    drawEquipments(x: number, y: number): void;
    drawProfile(x: number, y: number): void;
    maxEquipmentLines(): number;
}

/**
 * -----------------------------------------------------------------------------
 * Window_Options
 *
 * The window for changing various settings on the options screen.
 * @class Window_Options
 */
declare class Window_Options extends Window_Command {
    constructor();

    updatePlacement(): void;
    addGeneralOptions(): void;
    addVolumeOptions(): void;
    statusWidth(): number;
    statusText(index: number): string;
    isVolumeSymbol(symbol: string): boolean;
    booleanStatusText(value: boolean): string;
    volumeStatusText(value: number): string;
    volumeOffset(): number;
    changeValue(symbol: string, value: boolean | number): void;
    getConfigValue(symbol: string): boolean;
    setConfigValue(symbol: string, volume: boolean | number): void;
}

/**
 * -----------------------------------------------------------------------------
 * Window_SavefileList
 *
 * The window for selecting a save file on the save and load screens.
 * @class Window_SavefileList
 */
declare class Window_SavefileList extends Window_Selectable {
    protected _mode: string;

    constructor(x: number, y: number, width: number, height: number);

    /**
     * Sets the mode of the save file window.
     * 
     * @param {string} mode 
     * @memberof Window_SavefileList
     */
    setMode(mode: string): void;
    /**
     * Returns the maximum number of visible items.
     * 
     * @returns {number} 
     * @memberof Window_SavefileList
     */
    maxVisibleItems(): number;
    itemHeight(): number;
    /**
     * Draws the file id at the specified x and y coordinates.
     * 
     * @param {number} id 
     * @param {number} x 
     * @param {number} y 
     * @memberof Window_SavefileList
     */
    drawFileId(id: number, x: number, y: number): void;
    drawContents(info: { key: string }, rect: Rectangle, valid: boolean): void;
    drawGameTitle(info: { key: string }, x: number, y: number, width: number): void;
    drawPartyCharacters(info: { key: string }, x: number, y: number): void;
    /**
     * Draws the current playtime at the specified x and y coordinates within the given
     * width.
     * @param {{key: string}} info 
     * @param {number} x 
     * @param {number} y 
     * @param {number} width 
     * @memberof Window_SavefileList
     */
    drawPlaytime(info: { key: string }, x: number, y: number, width: number): void;
}

/**
 * -----------------------------------------------------------------------------
 * Window_ShopCommand
 *
 * The window for selecting buy/sell on the shop screen.
 * @class Window_ShopCommand
 */
declare class Window_ShopCommand extends Window_HorzCommand {
    protected _windowWidth: number;
    /**
     * Determines if the shop is purchase only.
     * 
     * @protected
     * @type {boolean}
     * @memberof Window_ShopCommand
     */
    protected _purchaseOnly: boolean;

    /**
     * Determines the width of the shop buy/sell window;
     * also determines if the shop is purchase only.
     * @param {number} width 
     * @param {boolean} purchaseOnly 
     * @memberof Window_ShopCommand
     */
    initialize(width: number, purchaseOnly: boolean): void;
}

/**
 * -----------------------------------------------------------------------------
 * Window_ShopBuy
 *
 * The window for selecting an item to buy on the shop screen.
 * @class Window_ShopBuy
 */
declare class Window_ShopBuy extends Window_Selectable {
    protected _shopGoods: Array<Array<any>>;
    protected _money: number;
    protected _data: Array<RPG.BaseItem>;
    protected _price: Array<number>;
    protected _statusWindow: Window_ShopStatus;

    /**
     * Creates an instance of Window_ShopBuy.
     * @param {number} x 
     * @param {number} y 
     * @param {number} height 
     * @param {Array<Array<any>>} shopGoods 
     * @memberof Window_ShopBuy
     */
    constructor(x: number, y: number, height: number, shopGoods: Array<Array<any>>);

    /**
     * Returns the width of the window.
     * 
     * @returns {number} 
     * @memberof Window_ShopBuy
     */
    windowWidth(): number;
    /**
     * Returns the current item of the window.
     * 
     * @returns {RPG.BaseItem} 
     * @memberof Window_ShopBuy
     */
    item(): RPG.BaseItem;
    setMoney(money: number): void;
    price(item: RPG.BaseItem): number;
    /**
     * Checks if the current item is enabled (can be bought/sold).
     * 
     * @param {RPG.BaseItem} item 
     * @returns {boolean} 
     * @memberof Window_ShopBuy
     */
    isEnabled(item: RPG.BaseItem): boolean;
    /**
     * Creates a list of items for the shop window.
     * 
     * @memberof Window_ShopBuy
     */
    makeItemList(): void;
    setStatusWindow(statusWindow: Window_ShopStatus): void;
}

/**
 * -----------------------------------------------------------------------------
 * Window_ShopSell
 *
 * The window for selecting an item to sell on the shop screen.
 * @class Window_ShopSell
 */
declare class Window_ShopSell extends Window_ItemList {
    constructor(x: number, y: number, width: number, height: number);

    /**
     * Determines if the item is sellable, otherwise, greyed out.
     *
     * @param {RPG.BaseItem} item 
     * @returns {boolean} 
     * @memberof Window_ShopSell
     */
    isEnabled(item: RPG.BaseItem): boolean;
}

/**
 * -----------------------------------------------------------------------------
 * Window_ShopNumber
 *
 * The window for inputting quantity of items to buy or sell on the shop
 * screen.
 * @class Window_ShopNumber
 */
declare class Window_ShopNumber extends Window_Selectable {
    /**
     * The current item being bought/sold.
     * 
     * @protected
     * @type {RPG.BaseItem}
     * @memberof Window_ShopNumber
     */
    protected _item: RPG.BaseItem;
    /**
     * Returns the maximum number of the item
     * that can be bought/sold.
     * @protected
     * @type {number}
     * @memberof Window_ShopNumber
     */
    protected _max: number;
    /**
     * The current price of the items.
     * 
     * @protected
     * @type {number}
     * @memberof Window_ShopNumber
     */
    protected _price: number;
    protected _number: number;
    /**
     * Returns the currency unit of the game.
     * 
     * @protected
     * @type {string}
     * @memberof Window_ShopNumber
     */
    protected _currencyUnit: string;
    /**
     * The buttons to input quantity
     * for the quantity of the item to be bought/sold.
     * @protected
     * @type {Array<Sprite_Button>}
     * @memberof Window_ShopNumber
     */
    protected _buttons: Array<Sprite_Button>;

    /**
     * Creates an instance of Window_ShopNumber.
     * @param {number} x 
     * @param {number} y 
     * @param {number} height 
     * @memberof Window_ShopNumber
     */
    constructor(x: number, y: number, height: number);

    /**
     * Returns the width of the window.
     * 
     * @returns {number} 
     * @memberof Window_ShopNumber
     */
    windowWidth(): number;
    number(): number;
    setup(item: RPG.BaseItem, max: number, price: number): void;
    setCurrencyUnit(currencyUnit: string): void;
    createButtons(): void;
    placeButtons(): void;
    updateButtonsVisibility(): void;
    /**
     * Shows the quantity input buttons.
     * 
     * @memberof Window_ShopNumber
     */
    showButtons(): void;
    /**
     * Hides the quantity input buttons.
     * 
     * @memberof Window_ShopNumber
     */
    hideButtons(): void;
    drawMultiplicationSign(): void;
    drawNumber(): void;
    /**
     * Draws the total price of the selected
     * quantity of item.
     * @memberof Window_ShopNumber
     */
    drawTotalPrice(): void;
    itemY(): number;
    priceY(): number;
    buttonY(): number;
    /**
     * Returns the width of the cursor.
     * 
     * @returns {number} 
     * @memberof Window_ShopNumber
     */
    cursorWidth(): number;
    cursorX(): number;
    maxDigits(): number;
    /**
     * Processes the change in quantity.
     * 
     * @memberof Window_ShopNumber
     */
    processNumberChange(): void;
    /**
     * Changes the quantity, given a number.
     * 
     * @param {number} amount 
     * @memberof Window_ShopNumber
     */
    changeNumber(amount: number): void;
    onButtonUp(): void;
    onButtonUp2(): void;
    onButtonDown(): void;
    onButtonDown2(): void;
    onButtonOk(): void;
}

/**
 * -----------------------------------------------------------------------------
 * Window_ShopStatus
 *
 * The window for displaying number of items in possession and the actor's
 * equipment on the shop screen.
 * @class Window_ShopStatus
 */
declare class Window_ShopStatus extends Window_Base {
    protected _item: RPG.BaseItem;
    protected _pageIndex: number;

    /**
     * Creates an instance of Window_ShopStatus.
     * @param {number} x 
     * @param {number} y 
     * @param {number} width 
     * @param {number} height 
     * @memberof Window_ShopStatus
     */
    constructor(x: number, y: number, width: number, height: number);

    /**
     * Refreshes the window contents.
     * 
     * @memberof Window_ShopStatus
     */
    refresh(): void;
    setItem(item: RPG.BaseItem): void;
    isEquipItem(): boolean;
    drawPossession(x: number, y: number): void;
    drawEquipInfo(x: number, y: number): void;
    statusMembers(): Array<Game_Actor>;
    /**
     * Returns the page size.
     * 
     * @returns {number} 
     * @memberof Window_ShopStatus
     */
    pageSize(): number;
    /**
     * Returns the max number of pages.
     * 
     * @returns {number} 
     * @memberof Window_ShopStatus
     */
    maxPages(): number;
    drawActorEquipInfo(x: number, y: number, actor: Game_Actor): void;
    drawActorParamChange(x: number, y: number, actor: Game_Actor, item1: RPG.EquipItem): void;
    /**
     * Returns the parameter id.
     * 
     * @returns {number} 
     * @memberof Window_ShopStatus
     */
    paramId(): number;
    /**
     * Returns the current item equipped by the given actor when
     * the respective equipment Id is passed.
     * @param {Game_Actor} actor 
     * @param {number} etypeId 
     * @returns {RPG.EquipItem} 
     * @memberof Window_ShopStatus
     */
    currentEquippedItem(actor: Game_Actor, etypeId: number): RPG.EquipItem;
    /**
     * Updates the current page.
     * 
     * @memberof Window_ShopStatus
     */
    updatePage(): void;
    /**
     * Determines if page can be changed.
     * 
     * @returns {boolean} 
     * @memberof Window_ShopStatus
     */
    isPageChangeEnabled(): boolean;
    isPageChangeRequested(): boolean;
    /**
     * Determines if the window is touched within it's frame.
     * 
     * @returns {boolean} 
     * @memberof Window_ShopStatus
     */
    isTouchedInsideFrame(): boolean;
    /**
     * Changes the current page.
     * 
     * @memberof Window_ShopStatus
     */
    changePage(): void;
}

/**
 * -----------------------------------------------------------------------------
 * Window_NameEdit
 *
 * The window for editing an actor's name on the name input screen.
 * @class Window_NameEdit
 */
declare class Window_NameEdit extends Window_Base {
    protected _name: string;
    protected _index: number;

    /**
     * Creates an instance of Window_NameEdit.
     * @param {Game_Actor} actor 
     * @param {number} maxLength 
     * @memberof Window_NameEdit
     */
    constructor(actor: Game_Actor, maxLength: number);

    /**
     * Returns the window width.
     * 
     * @returns {number} 
     * @memberof Window_NameEdit
     */
    windowWidth(): number;
    /**
     * Returns the window height.
     * 
     * @returns {number} 
     * @memberof Window_NameEdit
     */
    windowHeight(): number;

    // "name" is defines already by superclass(PIXI.DisplayObject).
    // name(): string;

    restoreDefault(): boolean;
    add(ch: string): boolean;
    back(): boolean;
    /**
     * Returns the width of the character face.
     * 
     * @returns {number} 
     * @memberof Window_NameEdit
     */
    faceWidth(): number;
    /**
     * Returns the width of a character.
     * 
     * @returns {number} 
     * @memberof Window_NameEdit
     */
    charWidth(): number;
    left(): number;
    underlineRect(index: number): Rectangle;
    /**
     * Returns the color of the underline as a css color string.
     * 
     * @returns {string} 
     * @memberof Window_NameEdit
     */
    underlineColor(): string;
    /**
     * Draws the underline at the given index of the window.
     * 
     * @param {number} index 
     * @memberof Window_NameEdit
     */
    drawUnderline(index: number): void;
    /**
     * Draws a character within the window at the specified index.
     * 
     * @param {number} index 
     * @memberof Window_NameEdit
     */
    drawChar(index: number): void;
    /**
     * Refreshes the window contents.
     * 
     * @memberof Window_NameEdit
     */
    refresh(): void;
}

/**
 * -----------------------------------------------------------------------------
 * Window_NameInput
 *
 * The window for selecting text characters on the name input screen.
 * @class Window_NameInput
 */
declare class Window_NameInput extends Window_Selectable {
    static LATIN1: Array<string>;
    static LATIN2: Array<string>;
    static RUSSIA: Array<string>;
    static JAPAN1: Array<string>;
    static JAPAN2: Array<string>;
    static JAPAN3: Array<string>;

    protected _editWindow: Window_NameEdit;
    protected _page: number;
    protected _index: number;

    constructor(editWindow: Window_NameEdit);

    /**
     * Returns the window height.
     * 
     * @returns {number} 
     * @memberof Window_NameInput
     */
    windowHeight(): number;
    /**
     * Returns the table of characters to input.
     * 
     * @returns {Array<Array<string>>} 
     * @memberof Window_NameInput
     */
    table(): Array<Array<string>>;
    character(): string;
    isPageChange(): boolean;
    isOk(): boolean;
    processJump(): void;
    processBack(): void;
    onNameAdd(): void;
    onNameOk(): void;
}

/**
 * -----------------------------------------------------------------------------
 * Window_ChoiceList
 *
 * The window used for the event command [Show Choices].
 * @class Window_ChoiceList
 */
declare class Window_ChoiceList extends Window_Command {
    protected _messageWindow: Window_Message;
    protected _background: number;

    constructor(messageWindow: Window_Message);

    start(): void;
    selectDefault(): void;
    updatePlacement(): void;
    updateBackground(): void;
    maxChoiceWidth(): number;
    textWidthEx(text: string): number;
}

/**
 * -----------------------------------------------------------------------------
 * Window_NumberInput
 *
 * The window used for the event command [Input Number].
 * @class Window_NumberInput
 */
declare class Window_NumberInput extends Window_Selectable {
    protected _messageWindow: Window_Message;
    protected _number: number;
    protected _maxDigits: number;
    protected _buttons: Array<Sprite_Button>;

    constructor(messageWindow: Window_Message);

    start(): void;
    updatePlacement(): void;
    /**
     * Returns the window width.
     * 
     * @returns {number} 
     * @memberof Window_NumberInput
     */
    windowWidth(): number;
    /**
     * Returns the window height.
     * 
     * @returns {number} 
     * @memberof Window_NumberInput
     */
    windowHeight(): number;
    /**
     * Returns the item width.
     * 
     * @returns {number} 
     * @memberof Window_NumberInput
     */
    itemWidth(): number;
    /**
     * Creates the number input window buttons.
     * 
     * @memberof Window_NumberInput
     */
    createButtons(): void;
    /**
     * Places the number input window buttons.
     * 
     * @memberof Window_NumberInput
     */
    placeButtons(): void;
    updateButtonsVisibility(): void;
    showButtons(): void;
    hideButtons(): void;
    buttonY(): number;
    processDigitChange(): void;
    changeDigit(up: boolean): void;
    onButtonUp(): void;
    onButtonDown(): void;
    onButtonOk(): void;
}

/**
 * -----------------------------------------------------------------------------
 * Window_EventItem
 *
 * The window used for the event command [Select Item].
 * @class Window_EventItem
 */
declare class Window_EventItem extends Window_ItemList {
    protected _messageWindow: Window_Message;

    constructor(messageWindow: Window_Message);

    /**
     * Returns the height off the window.
     * 
     * @returns {number} 
     * @memberof Window_EventItem
     */
    windowHeight(): number;
    /**
     * Returns the number of visible rows.
     * 
     * @returns {number} 
     * @memberof Window_EventItem
     */
    numVisibleRows(): number;
    /**
     * Starts the event item window.
     * 
     * @memberof Window_EventItem
     */
    start(): void;
    updatePlacement(): void;
    includes(item: RPG.BaseItem): boolean;
    isEnabled(item: RPG.BaseItem): boolean;
    onOk(): void;
    onCancel(): void;
}

/**
 * -----------------------------------------------------------------------------
 * Window_Message
 *
 * The window for displaying text messages.
 * @class Window_Message
 */
declare class Window_Message extends Window_Base {
    protected _background: number;
    protected _positionType: number;
    protected _waitCount: number;
    protected _faceBitmap: Bitmap;
    protected _textState: MV.TextState;
    protected _pauseSkip: boolean;
    protected _showFast: boolean;
    protected _lineShowFast: boolean;

    protected _goldWindow: Window_Gold;
    protected _choiceWindow: Window_ChoiceList;
    protected _numberWindow: Window_NumberInput;
    protected _itemWindow: Window_EventItem;

    constructor();

    initMembers(): void;
    /**
     * Returns the sub windows attached to the message window.
     * 
     * @returns {Array<Window_Base>} 
     * @memberof Window_Message
     */
    subWindows(): Array<Window_Base>;
    /**
     * Creates the sub windows for the message window.
     * 
     * @memberof Window_Message
     */
    createSubWindows(): void;
    /**
     * Returns the width of the window.
     * 
     * @returns {number} 
     * @memberof Window_Message
     */
    windowWidth(): number;
    /**
     * Returns the height of the window.
     * 
     * @returns {number} 
     * @memberof Window_Message
     */
    windowHeight(): number;
    clearFlags(): void;
    /**
     * Returns the number of visible rows within the message window.
     * 
     * @returns {number} 
     * @memberof Window_Message
     */
    numVisibleRows(): number;
    checkToNotClose(): void;
    /**
     * Returns true if the message window can start.
     * 
     * @returns {boolean} 
     * @memberof Window_Message
     */
    canStart(): boolean;
    /**
     * Starts the displaying of the message within the message window.
     * 
     * @memberof Window_Message
     */
    startMessage(): void;
    /**
     * Updates the placement of the message window.
     * 
     * @memberof Window_Message
     */
    updatePlacement(): void;
    /**
     * Updates the background of the message window.
     * 
     * @memberof Window_Message
     */
    updateBackground(): void;
    /**
     * Terminates the message and closes the gold and message window.
     * 
     * @memberof Window_Message
     */
    terminateMessage(): void;
    /**
     * Updates the wait of the message window.
     * 
     * @returns {boolean} 
     * @memberof Window_Message
     */
    updateWait(): boolean;
    updateLoading(): boolean;
    /**
     * Updates input when the message window is processing.
     * 
     * @returns {boolean} 
     * @memberof Window_Message
     */
    updateInput(): boolean;
    /**
     * Returns true if any sub window is active.
     * 
     * @returns {boolean} 
     * @memberof Window_Message
     */
    isAnySubWindowActive(): boolean;
    /**
     * Updates the message.
     * 
     * @returns {boolean} 
     * @memberof Window_Message
     */
    updateMessage(): boolean;
    /**
     * Handler for when there is no text left to display within
     * the message window.
     * @memberof Window_Message
     */
    onEndOfText(): void;
    startInput(): boolean;
    /**
     * Returns true if the ok or cancel inputs have been triggered
     * multiple times.
     * @returns {boolean} 
     * @memberof Window_Message
     */
    isTriggered(): boolean;
    /**
     * Returns true if the message window still has text
     * and settings have not changed.
     * @returns {boolean} 
     * @memberof Window_Message
     */
    doesContinue(): boolean;
    /**
     * Returns true if the message window settings have been changed.
     * 
     * @returns {boolean} 
     * @memberof Window_Message
     */
    areSettingsChanged(): boolean;
    updateShowFast(): void;
    newPage(textState: MV.TextState): void;
    loadMessageFace(): void;
    drawMessageFace(): void;
    newLineX(): number;
    processNewLine(textState: MV.TextState): void;
    processNewPage(textState: MV.TextState): void;
    /**
     * Returns true if there is no text left to display in the message
     * window.
     * @param {MV.TextState} textState 
     * @returns {boolean} 
     * @memberof Window_Message
     */
    isEndOfText(textState: MV.TextState): boolean;
    /**
     * Returns true if the text state needs a new page to display text.
     * 
     * @param {MV.TextState} textState 
     * @returns {boolean} 
     * @memberof Window_Message
     */
    needsNewPage(textState: MV.TextState): boolean;
    processEscapeCharacter(code: string, textState: MV.TextState): void;
    /**
     * Starts a wait for the message window.
     * 
     * @param {number} count 
     * @memberof Window_Message
     */
    startWait(count: number): void;
    /**
     * Starts a pause for the message window; this will only be
     * lifted if the user presses a button.
     * @memberof Window_Message
     */
    startPause(): void;
}

/**
 * -----------------------------------------------------------------------------
 * Window_ScrollText
 *
 * The window for displaying scrolling text. No frame is displayed, but it
 * is handled as a window for convenience.
 * @class Window_ScrollText
 */
declare class Window_ScrollText extends Window_Base {
    protected _text: string;
    protected _allTextHeight: number;

    constructor();

    /**
     * Starts the displaying of a message in the scroll text window.
     * 
     * @memberof Window_ScrollText
     */
    startMessage(): void;
    refresh(): void;
    updateMessage(): void;
    scrollSpeed(): number;
    /**
     * Returns true if the scene is in fast forward mode.
     * 
     * @returns {boolean} 
     * @memberof Window_ScrollText
     */
    isFastForward(): boolean;
    /**
     * Returns the fast forward rate of the scroll text window.
     * 
     * @returns {number} 
     * @memberof Window_ScrollText
     */
    fastForwardRate(): number;
    /**
     * Terminates the message and the scroll text window is hidden.
     * 
     * @memberof Window_ScrollText
     */
    terminateMessage(): void;
}

/**
 * -----------------------------------------------------------------------------
 * Window_MapName
 *
 * The window for displaying the map name on the map screen.
 * @class Window_MapName
 */
declare class Window_MapName extends Window_Base {
    protected _showCount: number;

    constructor();

    /**
     * Returns the window width.
     * 
     * @returns {number} 
     * @memberof Window_MapName
     */
    windowWidth(): number;
    /**
     * Returns the window height.
     * 
     * @returns {number} 
     * @memberof Window_MapName
     */
    windowHeight(): number;
    updateFadeIn(): void;
    updateFadeOut(): void;
    /**
     * Windows the map name window.
     * 
     * @memberof Window_MapName
     */
    refresh(): void;
    /**
     * Draws the background of the map name window.
     * 
     * @param {number} x 
     * @param {number} y 
     * @param {number} width 
     * @param {number} height 
     * @memberof Window_MapName
     */
    drawBackground(x: number, y: number, width: number, height: number): void;
}


/**
 * -----------------------------------------------------------------------------
 * Window_BattleLog
 *
 * The window for displaying battle progress. No frame is displayed, but it is
 * handled as a window for convenience.
 * @class Window_BattleLog
 */
declare class Window_BattleLog extends Window_Selectable {
    protected _lines: Array<string>;
    protected _methods: Array<MV.BattleLogMethod>;
    protected _waitCount: number;
    protected _waitMode: string;
    protected _baseLineStack: Array<number>;
    protected _spriteset: Spriteset_Battle;

    constructor();

    setSpriteset(spriteset: Spriteset_Battle): void;
    windowWidth(): number;
    windowHeight(): number;
    maxLines(): number;
    createBackBitmap(): void;
    createBackSprite(): void;
    numLines(): number;
    messageSpeed(): number;
    isBusy(): boolean;
    updateWait(): boolean;
    updateWaitCount(): boolean;
    updateWaitMode(): boolean;
    setWaitMode(waitMode: string): void;
    callNextMethod(): void;
    isFastForward(): boolean;
    push(methodName: string, ...args: any[]): void;
    clear(): void;
    wait(): void;
    waitForEffect(): void;
    waitForMovement(): void;
    addText(text: string): void;
    pushBaseLine(): void;
    popBaseLine(): void;
    waitForNewLine(): void;
    popupDamage(target: Game_Battler): void;
    performActionStart(subject: Game_Battler, action: Game_Action): void;
    performAction(subject: Game_Battler, action: Game_Action): void;
    performActionEnd(subject: Game_Battler): void;
    performDamage(target: Game_Battler): void;
    performMiss(target: Game_Battler): void;
    performRecovery(target: Game_Battler): void;
    performEvasion(target: Game_Battler): void;
    performMagicEvasion(target: Game_Battler): void;
    performCounter(target: Game_Battler): void;
    performReflection(target: Game_Battler): void;
    performSubstitute(substitute: Game_Battler, target: Game_Battler): void;
    performCollapse(target: Game_Battler): void;
    showAnimation(subject: Game_Battler, targets: Game_Battler, animationId: number): void;
    showAttackAnimation(subject: Game_Battler, targets: Game_Battler): void;
    showActorAttackAnimation(subject: Game_Battler, targets: Game_Battler): void;
    showEnemyAttackAnimation(subject: Game_Battler, targets: Game_Battler): void;
    showNormalAnimation(targets: Game_Battler, animationId: number, mirror: boolean): void;
    animationBaseDelay(): number;
    animationNextDelay(): number;
    drawBackground(): void;
    backRect(): Rectangle;
    backColor(): string;
    backPaintOpacity(): number;
    drawLineText(index: number): void;
    startTurn(): void;
    startAction(subject: Game_Battler, action: Game_Action, targets: Array<Game_Battler>): void;
    endAction(subject: Game_Battler): void;
    displayCurrentState(subject: Game_Battler): void;
    displayRegeneration(subject: Game_Battler): void;
    displayAction(subject: Game_Battler, item: RPG.UsableItem): void;
    displayCounter(target: Game_Battler): void;
    displayReflection(target: Game_Battler): void;
    displaySubstitute(substitute: Game_Battler, target: Game_Battler): void;
    displayActionResults(subject: Game_Battler, targt: Game_Battler): void;
    displayFailure(target: Game_Battler): void;
    displayCritical(target: Game_Battler): void;
    displayDamage(target: Game_Battler): void;
    displayMiss(target: Game_Battler): void;
    displayEvasion(target: Game_Battler): void;
    displayHpDamage(target: Game_Battler): void;
    displayMpDamage(target: Game_Battler): void;
    displayTpDamage(target: Game_Battler): void;
    displayAffectedStatus(target: Game_Battler): void;
    displayAutoAffectedStatus(target: Game_Battler): void;
    displayChangedStates(target: Game_Battler): void;
    displayAddedStates(target: Game_Battler): void;
    displayRemovedStates(target: Game_Battler): void;
    displayChangedBuffs(target: Game_Battler): void;
    displayBuffs(target: Game_Battler, buffs: Array<number>, fmt: string): void;
    makeHpDamageText(target: Game_Battler): void;
    makeMpDamageText(target: Game_Battler): string;
    makeTpDamageText(target: Game_Battler): string;
}

/**
 * -----------------------------------------------------------------------------
 * Window_PartyCommand
 *
 * The window for selecting whether to fight or escape on the battle screen.
 * @class Window_PartyCommand
 */
declare class Window_PartyCommand extends Window_Command {
    constructor();

    setup(): void;
}

/**
 * -----------------------------------------------------------------------------
 * Window_ActorCommand
 *
 * The window for selecting an actor's action on the battle screen.
 * @class Window_ActorCommand
 */
declare class Window_ActorCommand extends Window_Command {
    protected _actor: Game_Actor;

    constructor();

    /**
     * Adds the attack command to the actor command window.
     * 
     * @memberof Window_ActorCommand
     */
    addAttackCommand(): void;
    /**
     * Adds the skill command to the actor command window.
     * 
     * @memberof Window_ActorCommand
     */
    addSkillCommands(): void;
    /**
     * Adds the guard command to the actor command window.
     * 
     * @memberof Window_ActorCommand
     */
    addGuardCommand(): void;
    /**
     * Adds the item command to the actor command window.
     * 
     * @memberof Window_ActorCommand
     */
    addItemCommand(): void;
    /**
     * Sets up the actor command window with a specified actor.
     * 
     * @param {Game_Actor} actor 
     * @memberof Window_ActorCommand
     */
    setup(actor: Game_Actor): void;
    selectLast(): void;
}

/**
 * -----------------------------------------------------------------------------
 * Window_BattleStatus
 *
 * The window for displaying the status of party members on the battle screen.
 * @class Window_BattleStatus
 */
declare class Window_BattleStatus extends Window_Selectable {
    constructor();

    /**
     * Returns the window width.
     * 
     * @returns {number} 
     * @memberof Window_BattleStatus
     */
    windowWidth(): number;
    /**
     * Returns the window height.
     * 
     * @returns {number} 
     * @memberof Window_BattleStatus
     */
    windowHeight(): number;
    /**
     * Returns the number of visible rows.
     * 
     * @returns {number} 
     * @memberof Window_BattleStatus
     */
    numVisibleRows(): number;
    basicAreaRect(index: number): Rectangle;
    /**
     * returns a rectangle for the gauges in the gauge area.
     * 
     * @param {number} index 
     * @returns {Rectangle} 
     * @memberof Window_BattleStatus
     */
    gaugeAreaRect(index: number): Rectangle;
    /**
     * Returns the width of the guage area.
     * 
     * @returns {number} 
     * @memberof Window_BattleStatus
     */
    gaugeAreaWidth(): number;
    /**
     * Draws the basic area for actors within the battle status window.
     * 
     * @param {Rectangle} rect 
     * @param {Game_Actor} actor 
     * @memberof Window_BattleStatus
     */
    drawBasicArea(rect: Rectangle, actor: Game_Actor): void;
    /**
     * Draws the gauge area for the actors within the battle status window.
     * 
     * @param {Rectangle} rect 
     * @param {Game_Actor} actor 
     * @memberof Window_BattleStatus
     */
    drawGaugeArea(rect: Rectangle, actor: Game_Actor): void;
    /**
     * Draws the gauges in the basic area with tp included.
     * 
     * @param {Rectangle} rect 
     * @param {Game_Actor} actor 
     * @memberof Window_BattleStatus
     */
    drawGaugeAreaWithTp(rect: Rectangle, actor: Game_Actor): void;
    /**
     * Draws the gauges in the basic area without tp included.
     * 
     * @param {Rectangle} rect 
     * @param {Game_Actor} actor 
     * @memberof Window_BattleStatus
     */
    drawGaugeAreaWithoutTp(rect: Rectangle, actor: Game_Actor): void;
}

/**
 * -----------------------------------------------------------------------------
 * Window_BattleActor
 *
 * The window for selecting a target actor on the battle screen.
 * @class Window_BattleActor
 */
declare class Window_BattleActor extends Window_BattleStatus {
    constructor(x: number, y: number);

    /**
     * Selects an actor within the battle actor window.
     * 
     * @param {number} index 
     * @memberof Window_BattleActor
     */
    select(index: number): void;
    /**
     * Returns the current selected actor.
     * 
     * @returns {Game_Actor} 
     * @memberof Window_BattleActor
     */
    actor(): Game_Actor;
}

/**
 * -----------------------------------------------------------------------------
 * Window_BattleEnemy
 *
 * The window for selecting a target enemy on the battle screen.
 * @class Window_BattleEnemy
 */
declare class Window_BattleEnemy extends Window_Selectable {
    protected _enemies: Array<Game_Enemy>;

    constructor(x: number, y: number);

    /**
     * Returns the window width.
     * 
     * @returns {number} 
     * @memberof Window_BattleEnemy
     */
    windowWidth(): number;
    /**
     * Returns the window height.
     * 
     * @returns {number} 
     * @memberof Window_BattleEnemy
     */
    windowHeight(): number;
    /**
     * Returns the number of visible rows.
     * 
     * @returns {number} 
     * @memberof Window_BattleEnemy
     */
    numVisibleRows(): number;
    /**
     * Returns the current enemy.
     * 
     * @returns {Game_Enemy} 
     * @memberof Window_BattleEnemy
     */
    enemy(): Game_Enemy;
    /**
     * Returns the current index selected.
     * 
     * @returns {number} 
     * @memberof Window_BattleEnemy
     */
    enemyIndex(): number;
    /**
     * Selects a specified enemy using the index.
     * 
     * @param {number} index 
     * @memberof Window_BattleEnemy
     */
    select(index: number): void;
}

/**
 * -----------------------------------------------------------------------------
 * Window_BattleSkill
 *
 * The window for selecting a skill to use on the battle screen.
 * @class Window_BattleSkill
 */
declare class Window_BattleSkill extends Window_SkillList {
    constructor(x: number, y: number, width: number, height: number);
}

/**
 * -----------------------------------------------------------------------------
 * Window_BattleItem
 *
 * The window for selecting an item to use on the battle screen.
 * @class Window_BattleItem
 */
declare class Window_BattleItem extends Window_ItemList {
    constructor(x: number, y: number, width: number, height: number);

    includes(item: RPG.UsableItem): boolean;
}

/**
 * -----------------------------------------------------------------------------
 * Window_TitleCommand
 *
 * The window for selecting New Game/Continue on the title screen.
 * @class Window_TitleCommand
 */
declare class Window_TitleCommand extends Window_Command {
    protected static _lastCommandSymbol: string;

    constructor();

    updatePlacement(): void;
    isContinueEnabled(): boolean;
    initCommandPosition(): void;
    selectLast(): void;
}

/**
 * -----------------------------------------------------------------------------
 * Window_GameEnd
 *
 * The window for selecting "Go to Title" on the game end screen.
 * @class Window_GameEnd
 */
declare class Window_GameEnd extends Window_Command {
    constructor();

    updatePlacement(): void;
}

/**
 * -----------------------------------------------------------------------------
 * Window_DebugRange
 *
 * The window for selecting a block of switches/variables on the debug screen.
 * @class Window_DebugRange
 */
declare class Window_DebugRange extends Window_Selectable {
    protected static lastTopRow: number;
    protected static lastIndex: number;

    protected _editWindow: Window_DebugEdit;

    constructor(x: number, y: number);

    windowWidth(): number;
    windowHeight(): number;
    mode(): string;
    topId(): number;
    setEditWindow(editWindow: Window_DebugEdit): void;
}

/**
 * -----------------------------------------------------------------------------
 * Window_DebugEdit
 *
 * The window for displaying switches and variables on the debug screen.
 * @class Window_DebugEdit
 */
declare class Window_DebugEdit extends Window_Selectable {
    protected _mode: string;
    protected _topId: number;

    constructor(x: number, y: number, width: number);

    itemName(dataId: number): string;
    itemStatus(dataId: number): string;
    setMode(mode: string): void;
    setTopId(id: number): void;
    currentId(): number;
    updateSwitch(): void;
    updateVariable(): void;
}
