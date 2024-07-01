/* main.js - TyranoScript translation plugin entry point
 * Copyright (C) 2016 Jaypee
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 */
(function (main) {

  main.pluginDir = 'data/others/translate/';
  main.assetsDir = main.pluginDir + 'assets/';

  main.init = function () {
    $.loadText(this.assetsDir + 'config.json', (function (text) {
      this.config = (typeof text !== "object") ? JSON.parse(text) : text;
      var filename = this.assetsDir + this.config.translate.file;
      $.loadText(filename, (function (text) {
        var json = (typeof text !== "object") ? JSON.parse(text) : text;

        var memory = Object.create(TranslationMemory);
        memory.init(json, this.config.translate.langs);

        TYRANO.kag.detour = TYRANO.kag.detour || Object.create(TyranoDetour);
        TYRANO.kag.detour.init(TYRANO.kag);

        var reduce = Object.create(TyranoTranslate.reduce);
        reduce.addUnitTags(this.config.translate.macro);

        if (this.config.update && this.config.update.file) {
          var update = Object.create(TyranoTranslate.update);
          memory.setUpdateLangs(this.config.update.langs);
          memory.setUpdateMethod(this.config.update.method);
          memory.setUpdatePrune(this.config.update.prune);
          update.init(TYRANO.kag, reduce, memory, this.config.update);
          update.writeDict();
        }

        var translate = Object.create(TyranoTranslate.translate);
        translate.init(TYRANO.kag.detour, reduce, memory);
        TYRANO.kag.translate = translate;
        TYRANO.kag.stat.is_strong_stop = false;
        TYRANO.kag.ftag.nextOrder();
      }).bind(this));
    }).bind(this));
  }

})(window.TranslateMain = window.TranslateMain || {})
Object.create(TranslateMain).init();
