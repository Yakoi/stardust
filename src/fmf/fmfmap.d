module fmf.fmfmap;
///-----------------------------------------------------------------------------
/// Platinumが出力する*.fmfファイルを読み出すクラス
/// 可読性重視に書いてあるので効率を重視したい場合は書き換えて使用してください。
///-----------------------------------------------------------------------------
//#ifndef __CLASS_FMFMAP_H__
//#define __CLASS_FMFMAP_H__
//#pragma once

import std.c.windows.windows;
import std.file;
import std.conv;

/// FMFファイルヘッダ (20 bytes)
struct FMFHEADER
{
    DWORD    dwIdentifier;    // ファイル識別子 'FMF_'
    DWORD    dwSize;            // ヘッダを除いたデータサイズ
    DWORD    dwWidth;        // マップの横幅
    DWORD    dwHeight;        // マップの高さ
    BYTE    byChipWidth;    // マップチップ1つの幅(pixel)
    BYTE    byChipHeight;    // マップチップ１つの高さ(pixel)
    BYTE    byLayerCount;    // レイヤーの数
    BYTE    byBitCount;        // レイヤデータのビットカウント
}
///-----------------------------------------------------------------------------
/// Platinumが出力する*.fmfファイルを読み出すクラス
/// 可読性重視に書いてあるので効率を重視したい場合は書き換えて使用してください。
///-----------------------------------------------------------------------------
/// FMFマップ
class CFmfMap
{
public:
    // 構築/消滅
    this(){}
    this(byte[] tmp){
        this.Load(tmp);
    }
    ~this() {
        Close();
    }


    /// マップを開いてデータを読み込む
    /// Params:
    ///     szFilePath  = マップファイルのパス
    /// Returns:
    ///     正常終了    = TRUE
    ///     エラー      = FALSE
    BOOL Open(const char *szFilePath)
    {
        byte[] tmp = cast(byte[])std.file.read(std.conv.to!(string)(szFilePath));
        Load(tmp);
        return TRUE;
    }
    void Load(byte[] tmp){
        Close();
        uint p4(int n){
            return tmp[n] + tmp[n+1]*256 + tmp[n+2]*256*256 + tmp[n+3]*256*256*256;
        }
        m_fmfHeader.dwIdentifier = p4(0);    // ファイル識別子 'FMF_'
        m_fmfHeader.dwSize       = p4(4);            // ヘッダを除いたデータサイズ
        m_fmfHeader.dwWidth      = p4(8);        // マップの横幅
        m_fmfHeader.dwHeight     = p4(12);        // マップの高さ
        m_fmfHeader.byChipWidth  = tmp[16];    // マップチップ1つの幅(pixel)
        m_fmfHeader.byChipHeight = tmp[17];    // マップチップ１つの高さ(pixel)
        m_fmfHeader.byLayerCount = tmp[18];    // レイヤーの数
        m_fmfHeader.byBitCount   = tmp[19];        // レイヤデータのビットカウント

        m_pLayerAddr = cast(ubyte*)(&(tmp[20]));
    }

    ///-----------------------------------------------------------------------------
    /// マップが開かれているか
    ///-----------------------------------------------------------------------------
    const pure nothrow BOOL IsOpen() const
    {
        return m_pLayerAddr != null;
    }

    ///-----------------------------------------------------------------------------
    ///    マップメモリを開放
    ///-----------------------------------------------------------------------------
    void Close()
    {
        if (m_pLayerAddr != null)
        {
            delete /+[]+/ m_pLayerAddr;
            m_pLayerAddr = null;
        }
    }
        
    ///-----------------------------------------------------------------------------
    /// 指定レイヤの先頭アドレスを得る
    /// Params:
    ///     byLayerIndex      = レイヤ番号
    /// Returns:
    ///         正常終了      = レイヤデータのアドレス
    ///         エラー        = null
    /// 各レイヤデータは連続したメモリ領域に配置されてるので
    /// 指定レイヤデータのアドレスを計算で求める。
    ///-----------------------------------------------------------------------------
    const pure nothrow void* GetLayerAddr(BYTE byLayerIndex) const
    {
        // メモリチェック、範囲チェック
        if ((m_pLayerAddr == null) || (byLayerIndex >= m_fmfHeader.byLayerCount))
            return null;

        BYTE bySize = cast(byte)(m_fmfHeader.byBitCount / 8);
        return cast(void*)(m_pLayerAddr + m_fmfHeader.dwWidth * m_fmfHeader.dwHeight * bySize * byLayerIndex);
    }
    
    ///-----------------------------------------------------------------------------
    /// レイヤ番号と座標を指定して直接データを貰う
    /// Params:
    ///     byLayerIndex       = レイヤ番号
    ///     dwX                = X座標（0～m_fmfHeader.dwWidth - 1）
    ///     dwY                = Y座標（0～m_fmfHeader.dwHeight - 1）
    /// Returns:
    ///     正常終了    = 座標の値
    ///     エラー        = -1
    ///-----------------------------------------------------------------------------
    const pure nothrow int GetValue(BYTE byLayerIndex, DWORD dwX, DWORD dwY) const
    {
        int nIndex = -1;

        // 範囲チェック
        if (byLayerIndex >= m_fmfHeader.byLayerCount ||
            dwX >= m_fmfHeader.dwWidth ||
            dwY >= m_fmfHeader.dwHeight)
            return nIndex;

        if (m_fmfHeader.byBitCount == 8)
        {
            // 8bit layer
            BYTE* pLayer = cast(BYTE*)GetLayerAddr(byLayerIndex);
            nIndex = *(pLayer + dwY * m_fmfHeader.dwWidth + dwX);
        }
        else
        {
            // 16bit layer    
            WORD* pLayer = cast(WORD*)GetLayerAddr(byLayerIndex);
            nIndex = *(pLayer + dwY * m_fmfHeader.dwWidth + dwX);
        }

        return nIndex;
    }

    ///-----------------------------------------------------------------------------
    /// レイヤ番号と座標を指定してデータをセット
    ///-----------------------------------------------------------------------------
    void SetValue(BYTE byLayerIndex, DWORD dwX, DWORD dwY, int nValue)
    {
        // 範囲チェック
        if (byLayerIndex >= m_fmfHeader.byLayerCount ||
            dwX >= m_fmfHeader.dwWidth ||
            dwY >= m_fmfHeader.dwHeight)
            return;

        if (m_fmfHeader.byBitCount == 8)
        {
            // 8bit layer
            BYTE* pLayer = cast(BYTE*)GetLayerAddr(byLayerIndex);
            *(pLayer + dwY * m_fmfHeader.dwWidth + dwX) = cast(BYTE)nValue;
        }
        else
        {
            // 16bit layer    
            WORD* pLayer = cast(WORD*)GetLayerAddr(byLayerIndex);
            *(pLayer + dwY * m_fmfHeader.dwWidth + dwX) = cast(WORD)nValue;
        }
    }

    ///-----------------------------------------------------------------------------
    /// マップの横幅を得る
    /// Returns:マップの横幅
    ///-----------------------------------------------------------------------------
    DWORD GetMapWidth() const
    {
        return m_fmfHeader.dwWidth;
    }
    ///-----------------------------------------------------------------------------
    /// マップの高さを得る
    /// Returns:マップの高さ
    ///-----------------------------------------------------------------------------
    DWORD GetMapHeight() const
    {
        return m_fmfHeader.dwHeight;
    }
    ///-----------------------------------------------------------------------------
    /// チップの横幅を得る
    ///-----------------------------------------------------------------------------
    BYTE GetChipWidth() const
    {
        return m_fmfHeader.byChipWidth;
    }
    ///-----------------------------------------------------------------------------
    /// チップの高さを得る
    ///-----------------------------------------------------------------------------
    BYTE GetChipHeight() const
    {
        return m_fmfHeader.byChipHeight;
    }
    ///-----------------------------------------------------------------------------
    /// レイヤー数を得る
    ///-----------------------------------------------------------------------------
    BYTE GetLayerCount() const
    {
        return m_fmfHeader.byLayerCount;
    }
    ///-----------------------------------------------------------------------------
    /// レイヤーデータのビットカウントを得る
    ///-----------------------------------------------------------------------------
    BYTE GetLayerBitCount() const
    {
        return m_fmfHeader.byBitCount;
    }
protected:
    // FMFファイルヘッダ構造体
    FMFHEADER    m_fmfHeader;
    // レイヤーデータへのポインタ
    BYTE*         m_pLayerAddr;
};
    import std.stdio;
unittest{
    /+
    CFmfMap fm = new CFmfMap;
    fm.Open("sample.fmf");
    writeln("map width = ", fm.GetMapWidth());
    writeln("map height = ", fm.GetMapHeight());
    writeln("map layercount = ", fm.GetLayerCount());
version(none){
    for(uint l=0; l<fm.GetLayerCount(); l++){
        for(uint y=0; y<fm.GetMapHeight(); y++){
            for(uint x=0; x<fm.GetMapWidth(); x++){
                auto v = fm.GetValue(0, x, y);
                write(v," ");
            }
            write("\n");
        }
        write("\n");
        write("\n");
    }
}
    +/
}

/*    サンプル
int Hoge(const char *filePath)
{
    CFmfMap map;
    BYTE* pLayer;

    if (!map.Open(filePath))
    {
        // マップが開けない。
        return 1;
    }

    // 0番（一番下のレイヤー）のアドレスを貰う
    pLayer = (BYTE*)map.GetLayerAddr(0)
    if (lpLayer == null)
    {
        map.Close();
        return 1;
    }

    DWORD width = map.GetMapWidth();
    DWORD height = map.GetMapHeight();
    DWORD cWidth = map.GetChipWidth();
    DWORD cHeight = map.GetChipHeight();
    int srcX, srcY;
    BYTE index;    
    
    // マップの描画
    for (DWORD y = 0; y < height; y++)
    {
        for (DWORD x = 0; x < width ; x++)
        {
            index = *(pLayer + y * width + x);
            // または
            index = map.GetValue(0, x, y);
            
            // indexにはマップ座標(x, y)のマップデータが入ってるので
            // パーツ画像(srcHDC)からvalueに見合う矩形を算出して描画処理を行う。
            // マップが8bitの場合パーツのアラインメントは16、16bitなら256。
            srcX = (index % 16) * cWidth;
            srcY = (index / 16) * cHeight;
            BitBlt(    dstHDC, x * cWidth, y * cHeight, cWidth, cHeight,
                    srcHDC, srcX, srcY, SRCCOPY);
        }
    }

    // 座標(15,10)のデータを取り出す場合
    value = *(pLayer + 10 * width + 15);
    
    // 閉じる
    map.Close();
    
    return 0;
}
*/

//#endif

