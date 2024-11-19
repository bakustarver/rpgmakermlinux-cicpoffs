# coding: utf-8
=begin
= Bitmapクラスの拡張 (DLL版)
RPGツクールXP/VX共用
Bitmapクラスに機能を追加します。
- Marshaldump可能に
- PNGファイルとして保存
- 色調変更
- モザイク効果
- 色の反転
- ぼかし効果
- マスクを用いた切り抜き
- ブレンディング

■ 注意
 このスクリプトの他に"tktk_bitmap.dll"(ver0.1.2.6以上)が必要になります。

Author::    半生
Date::      2010/12/13
Version::   0.1.2.6
URL::       http://www.tktkgame.com/

############################################
 2010/12/13 ver 0.1.2.6
　dllの名称を"hn_rg_bitmap.dll"から"tktk_bitmap.dll"に変更
　LARGE_BITMAP機能でメモリを確保できなかった場合の処理を追加
 2010/10/12 ver 0.1.2.5(デンジャラスベータ版)
　大きいサイズのBitmapオブジェクトを機能を試験的に実装（危険）
 2010/03/24 ver 0.1.2.2
　ブレンディング機能関連の軽量化。
　画像連結系メソッドの分離。
 2010/03/24 ver 0.1.2.1
　ブレンディング機能関連のバグフィックス
 2010/03/22 ver 0.1.2.0
　加算合成等のブレンディング機能の追加
2010/02/07 ver 0.1.1.0
　マーシャル化の処理の一部をDLLに移動
2010/01/17 ver 0.1.0.0
　dllの名称を"hn_rx_bitmap.dll"から"hn_rg_bitmap.dll"に変更
　モザイク効果・色反転・ぼかし効果の追加
############################################
=end

module TKTK_Bitmap
  LARGE_BITMAP = true # 大容量のBitmap作成機能を使うかどうか
  DLL_NAME = 'tktk_bitmap'

  ERROR_ALLOCATE_FAILED = -110002

  @@png_save = Win32API.new(DLL_NAME, 'PngSaveA', 'p n i i', 'i')
  @@blur = Win32API.new(DLL_NAME, 'Blur', 'n i', 'i')
  @@change_tone = Win32API.new(DLL_NAME, 'ChangeTone', 'n i i i i', 'i')
  @@clip_mask = Win32API.new(DLL_NAME, 'ClipMask', 'n n i i i', 'i')
  @@invert = Win32API.new(DLL_NAME, 'InvertColor', 'n', 'i')
  @@mosaic = Win32API.new(DLL_NAME, 'Mosaic', 'n i i i i i i', 'i')
  @@address = Win32API.new(DLL_NAME, 'GetAddress', 'n', 'n')
  @@get_pixel_data = Win32API.new(DLL_NAME, 'GetPixelData', 'n p i', 'i')
  @@set_pixel_data = Win32API.new(DLL_NAME, 'SetPixelData', 'n p i', 'i')
  @@blend_blt = Win32API.new(DLL_NAME, 'BlendBlt', 'n i i n i i i i i i', 'i')
  #@@get_hwnd = Win32API.new(DLL_NAME, 'GetGameHWND', 'v', 'l')
  @@change_size = Win32API.new(DLL_NAME, 'ChangeSize', 'n i i', 'i')
  module_function

  # PNG形式で保存
  def png_save(bitmap,file_name,compression_level,filter)
    return file_name, bitmap.object_id, compression_level, filter
  end

  # ぼかし効果
  def blur(bitmap, r = 1)
    return bitmap.object_id, r
  end
  
  # カラーバランス変更？
  def change_tone(bitmap, red = 0, green = 0, blue = 0, simplify = 1)
    return bitmap.object_id, red, green, blue, simplify
  end

  # マスクによる画像の切り抜き（アルファとの乗算）
  def clip_mask(g_bitmap, m_bitmap, x=0, y=0, outer=0)
    return g_bitmap.object_id, m_bitmap.object_id, x, y, outer
  end

  # 色の反転
  def invert(bitmap)
    return bitmap.object_id
  end

  # モザイク効果
  def mosaic(bitmap, msw=5, msh=5)
    return bitmap, bitmap.rect, msw, msh
  end

  # モザイク効果（範囲指定）
  def mosaic_rect(bitmap, rect, msw=5, msh=5)
    return bitmap.object_id, rect.x, rect.y, rect.width, rect.height, msw, msh
  end

  # ビットマップデータのアドレスを取得
  def address(bitmap)
    return bitmap.object_id
  end
  
  # ビットマップのバイナリデータを取得
  def get_pixel_data(bitmap)
    buffer = "bgra" * bitmap.width * bitmap.height
    @@get_pixel_data.call(bitmap.object_id, buffer, buffer.size)
    return buffer
  end
  
  # ビットマップのバイナリデータを置き換え
  def set_pixel_data(bitmap, data)
    return bitmap.object_id, data, data.size
  end
  
  def blend_blt(dest_bmp, x, y, src_bmp, rect, blend_type=0, opacity=255)
    dest_bmp.object_id, x, y, src_bmp.object_id,
                rect.x, rect.y, rect.width, rect.height,
                blend_type, opacity
  end

  # ビットマップのサイズを変更（危険）
  def change_size(bitmap, new_width, new_height)
    return -1 if (new_width <=0 or new_height <= 0)
    result = @@change_size.call(bitmap.object_id, new_width, new_height)
    if result == ERROR_ALLOCATE_FAILED
      raise("tktk_bitmap:ERROR ALLOCATE FAILED")
    end
    return result
  end
  
end

class Font
  def marshal_dump;end
  def marshal_load(obj);end
end
class Bitmap
  # PNG圧縮用フィルタ
  PNG_NO_FILTERS   = 0x00
  PNG_FILTER_NONE  = 0x08
  PNG_FILTER_SUB   = 0x10
  PNG_FILTER_UP    = 0x20
  PNG_FILTER_AVG   = 0x40
  PNG_FILTER_PAETH = 0x80
  PNG_ALL_FILTERS  = (PNG_FILTER_NONE | PNG_FILTER_SUB | PNG_FILTER_UP |
                      PNG_FILTER_AVG | PNG_FILTER_PAETH)

  # Marshal_dump
  def _dump(limit)
    return "" if self.disposed?
    data = TKTK_Bitmap.get_pixel_data(self)
    [width, height, Zlib::Deflate.deflate(data)].pack("LLa*") # ついでに圧縮
  end
  
  # Marshal_load
  def self._load(str)
    if str == ""
      b = Bitmap.new(1,1)
      b.dispose
      return b
    end
    w, h, zdata = str.unpack("LLa*"); b = new(w, h)
    TKTK_Bitmap.set_pixel_data(b, Zlib::Inflate.inflate(zdata))
    return b
  end  
  
  def address
    TKTK_Bitmap.address(self)
  end

  # ぼかし効果
  def blur2(r=1)
    TKTK_Bitmap.blur(self, r)
  end

  # 色調変更
  def change_tone(red, green, blue, simplify = 1)
    TKTK_Bitmap.change_tone(self, red, green, blue, simplify)
  end
  
  # クリッピング
  def clip_mask(bitmap, x=0, y=0, outer=0)
    TKTK_Bitmap.clip_mask(self, bitmap, x, y, outer)
  end

  # 色の反転
  def invert
    TKTK_Bitmap.invert(self)
  end

  # モザイク効果
  def mosaic(msw=5, msh=5)
    TKTK_Bitmap.mosaic(self, msw, msh)
  end

  # モザイク効果(領域指定)
  def mosaic_rect(rect=self.rect, msw=5, msh=5)
    TKTK_Bitmap.mosaic_rect(self, rect, msw, msh)
  end

  # ブレンディング
  def blend_blt(x, y, src_bmp, rect, blend_type=0, opacity=255)
    return if opacity <= 0
    TKTK_Bitmap.blend_blt(self, x, y, src_bmp, rect, blend_type, opacity)
  end

  #png形式で保存
  def png_save(outp, level = 9, filter = PNG_NO_FILTERS)
    if (TKTK_Bitmap.png_save(self, outp, level, filter) != 0)
      raise("Bitmap\#png_save failed")
    end
  end

  # 大きいサイズのBitmap.newを可能に(危険)
  # width * height が大体1073741823位まで
  if TKTK_Bitmap::LARGE_BITMAP
    class << self
      unless method_defined?(:_hn_large_bm__new)
        alias :_hn_large_bm__new :new
      end
      def new(*args)
        if args.size == 2 && args[0] * args[1] >= 4194304
          new_width = args[0]
          new_height = args[1]
          # とりあえず小さなサイズで作成
          bitmap = _hn_large_bm__new(16, 16)
          TKTK_Bitmap.change_size(bitmap, new_width, new_height)
          return bitmap
        else
          _hn_large_bm__new(*args)
        end
      end
    end # Bitmap.new
  end
end # CLASS Bitmap
