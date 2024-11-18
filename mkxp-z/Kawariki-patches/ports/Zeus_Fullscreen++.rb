# Zeus81 Fullscreen++ MKXP API Shim
# Authors: Taeyeon Mori

Preload.require 'PreloadIni.rb'

# Fullscreen++ v2.2 for VX and VXace by Zeus81
# Free for non commercial and commercial use
# Licence : http://creativecommons.org/licenses/by-sa/3.0/
# Contact : zeusex81@gmail.com
# (fr) Manuel d'utilisation : http://pastebin.com/raw.php?i=1TQfMnVJ
# (en) User Guide           : http://pastebin.com/raw.php?i=EgnWt9ur

$imported ||= {}
$imported[:Zeus_Fullscreen] = __FILE__

class << Graphics
  Disable_VX_Fullscreen = true

  unless method_defined?(:zeus_fullscreen_update)
    alias zeus_fullscreen_update        update
  end

  def load_fullscreen_settings
    fullscreen = (Preload::Ini.readIniString('./Game.ini', 'Fullscreen++', 'Fullscreen') || '0') == '1'
  end
  def save_fullscreen_settings
    Preload::Ini.writeIniString('./Game.ini', 'Fullscreen++', 'Fullscreen', fullscreen ? '1' : '0')
  end

  def fullscreen?
    fullscreen
  end
  def vx_fullscreen?
    false
  end
  def toggle_fullscreen
    fullscreen = !fullscreen
  end
  def toggle_vx_fullscreen
  end
  def vx_fullscreen_mode
  end
  def fullscreen_mode
    fullscreen = true
  end
  def windowed_mode
    fullscreen = false
  end
  def toggle_ratio
  end
  def ratio
    1
  end
  def ratio=(r)
  end
  def update
    zeus_fullscreen_update
    toggle_fullscreen if Input.trigger?(Input::F5)
  end
end
Graphics.load_fullscreen_settings