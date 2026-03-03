//=============================================================================

// Libellule Text extractor to clipboard plugin 

// Clipboard_llule.js

//=============================================================================

/* 

 * Install and configure with the patcher here : 

 * https://www.dropbox.com/sh/p83yxde8e8nrz35/AADkJzbz7VuM7HqwiwhhfhHTa?dl=0

 * Help : http://www.ulmf.org/bbs/showthread.php?t=29359

 */

//=============================================================================
TimerMil = 200;
WantCmdItemSeparator = true;
CmdItemSeparator = "。\r\n";
ShowCodeColor = false;
ForceNameSeparator = false;
TextSeparatorLeft = String.fromCharCode(12300);
TextSeparatorRight = String.fromCharCode(12301);
NameCodeColor = ["#ffffa0", "#40c0f0", "#ff80ff", "#80ff80", "#66cc40"];

IgnoreRepeatableItem = true;
BloctextSeparator = true;
IgnoreRepeatablebloc = true;
var IgnoreRegExtextbloc = [/^\d\d:\d\d($|.$|。$)/, /(^([,.\d]+)([,.]\d+)?)(\uFF27($|。$)|G($|。$)|$|。$)/, /^(\uFF27($|。$)|G($|。$))/];
ClipLogerOnStart = true;
WantChoiceSeparator = true;
ChoiceSeparator = "。\r\n";
TextWaitingTimeOFF = true;
var ClipLoger = "";
LastItem = "";
ColorEnCour = "";
ActualThis = "";
StarTextNamefound = false;
EndTextNamefound = false;
BlocSeparatorLeft = String.fromCharCode(12300);
BlocSeparatorRight = String.fromCharCode(12301);
LastColor = "";
MemText = "";
LastMemTextSend = "";
ClipTimerOn = false;
SaveOrgDrawText = Bitmap.prototype.drawText;
var gui = require('nw.gui');
var clipboard = gui.Clipboard.get();
var win = gui.Window.get();
var SaveoldInput_onKeyDown = Input._onKeyDown;
var Savewindowonload = window.onload;
var choices_encour = [];
Bitmap.prototype.drawText = function(text, x, y, maxWidth, lineHeight, align) {
    OptionalText = "";
    pass = true;
    if (text) {

        if (text.length == 1 && y >= this.height) {
            pass = false;
        }

        if (IgnoreRepeatableItem && text.length > 1) {
            if (text == LastItem) {
                pass = false;
            }
            LastItem = text;
        }
        if (pass) {
            if (ShowCodeColor) {
                if (this.textColor != LastColor) {
                    OptionalText = "<" + this.textColor + ">";
                    LastColor = this.textColor;
                }
            }
            if (ForceNameSeparator && text.length == 1) {
                if (!ClipTimerOn && (NameCodeColor.indexOf(this.textColor) > -1)) {
                    LastColor = this.textColor;
                    StarTextNamefound = true;
                    ColorNameEnCour = this.textColor;
                }
                if (ClipTimerOn && StarTextNamefound && (this.textColor != ColorNameEnCour)) {
                    OptionalText = OptionalText + TextSeparatorLeft;
                    StarTextNamefound = false;
                    EndTextNamefound = true;
                }
            }
            if (BloctextSeparator) {
                if (ActualThis == "") {
                    ActualThis = this;
                    OptionalText = OptionalText + BlocSeparatorLeft;
                } else {
                    if (ActualThis != this) {
                        OptionalText = OptionalText + BlocSeparatorRight + "\r\n" + BlocSeparatorLeft;
                        ActualThis = this;
                    }
                }
                if ($gameMessage != null) {
                    if ($gameMessage.isChoice() && !choices_encour.length) {
                        choices_encour = $gameMessage._choices;
                    }
                }
            }
            if (ClipTimerOn) {
                if (text.length > 1 && WantCmdItemSeparator) {
                    MemText = MemText + OptionalText + text + CmdItemSeparator;
                } else {
                    MemText = MemText + OptionalText + text;
                }
            } else {
                if (text.length > 1 && WantCmdItemSeparator) {
                    MemText = OptionalText + text + CmdItemSeparator;
                } else {
                    MemText = OptionalText + text;
                }
                ClipTimerOn = true;
                ClipTimer = setTimeout(ClipTimerSend, TimerMil);
            }
        }
    }
    SaveOrgDrawText.call(this, text, x, y, maxWidth, lineHeight, align);
};

function ClipTimerSend() {
    if (BloctextSeparator) {
        MemText = MemText + BlocSeparatorRight;
        KickOutDuplicateBloc();
    }
    if (EndTextNamefound) {
        MemText = MemText + TextSeparatorRight;
        StarTextNamefound = false;
        EndTextNamefound = false;
        if (BloctextSeparator) {
            KickOutDuplicateBloc();
        }
    }
    if (MemText != "") {
        clipboard.set(MemText, 'text');
        LastMemTextSend = MemText;
    }
    ClipTimerOn = false;
    ActualThis = "";
    LastColor = "";
    ColorNameEnCour = "";
};
var LibWindow_Message_prototype_clearFlags = Window_Message.prototype.clearFlags;
Window_Message.prototype.clearFlags = function() {
    LibWindow_Message_prototype_clearFlags.call(this);
    this._showFast = true;
    this._lineShowFast = true;
    this._pauseSkip = false;
};

function LaunchCliploger() {
    /*Path = process.cwd() + "\\www\\js\\plugins";
    var execFile = require('child_process').execFile;
    ClipLoger = execFile(Path + "\\ClipLoger.exe", function(error, stdout, stderr) {
        ClipLoger = "";
    });
    if (!ClipLoger.pid) {
        alert(Msg1);
        return;
    }
    setTimeout(Focus, 500);*/
};

function Focus() {
    if (ClipLoger.pid) {
        win.focus();
    } else {
        setTimeout(Focus, 500);
    }
};
Input._onKeyDown = function(event) {
    if (event.keyCode == 118) {
        clipboard.set(LastMemTextSend, 'text');
    }
    if (event.keyCode == 117) {
        if (ClipLoger.pid) {
            ClipLoger.kill();
        } else {
            LaunchCliploger();
        }
    }
    if (event.keyCode == 116) {
        if (ClipLoger.pid) {
            ClipLoger.kill();
        }
    }
    SaveoldInput_onKeyDown.call(this, event);
};
window.onload = function() {
    if (ClipLogerOnStart) {
        LaunchCliploger();
    }
    Savewindowonload.call(this);
};

function KickOutDuplicateBloc() {
    var Bloc = MemText.split("\r\n");
    var output = [];
    var Deleteone = "";
    if (choices_encour.length && WantChoiceSeparator) {
        var temps = choices_encour[0].replace(/\\C\[\d+\]/gi, "");
        var With = BlocSeparatorLeft + temps;
        var Deleteone = With;
        for (i = 1; i < choices_encour.length; i++) {
            temps = choices_encour[i].replace(/\\C\[\d+\]/gi, "");
            With = With + ChoiceSeparator + temps;
            Deleteone = Deleteone + temps;
        }
        With += BlocSeparatorRight;
        output.push(With);
        Deleteone += BlocSeparatorRight;
        choices_encour = [];
    }
    for (var i = 0; i < Bloc.length; i++) {
        if (output.indexOf(Bloc[i]) < 0) {
            if (RegEXspeIgnore(Bloc[i]) && Deleteone != Bloc[i]) {
                output.push(EraseDoubleSeparator(Bloc[i]));
            }
        }
    }
    MemText = output.join("\r\n");
};

function RegEXspeIgnore(Bloc) {
    BlocS = Bloc.slice(1, Bloc.length - 1);
    if (IgnoreRegExtextbloc.length != 0) {
        for (var i = 0; i < IgnoreRegExtextbloc.length; i++) {
            if (BlocS.search(IgnoreRegExtextbloc[i]) != -1) {
                return false;
            }
        }
        return true;
    } else {
        return true;
    }
};

function EraseDoubleSeparator(Bloc) {
    if ((Bloc.split(BlocSeparatorLeft).length) == 3) {
        if ((Bloc.split(BlocSeparatorRight).length) == 3) {
            return Bloc.slice(1, Bloc.length - 1);
        }
    }
    return Bloc;
};
Msg1 = "ClipLoger.exe not found\r\nReinstal the plugin from the patcher\r\n";
var Save_Window_Message_prototype_updateWait = Window_Message.prototype.updateWait;
Window_Message.prototype.updateWait = function() {
    if (ClipTimerOn && TextWaitingTimeOFF) {
        this._waitCount = 0;
    }
    return Save_Window_Message_prototype_updateWait.call(this);
};