// D import file generated from 'fmf\fmfmap.d'
module fmf.fmfmap;
import std.c.windows.windows;
import std.file;
import std.conv;
struct FMFHEADER
{
    DWORD dwIdentifier;
    DWORD dwSize;
    DWORD dwWidth;
    DWORD dwHeight;
    BYTE byChipWidth;
    BYTE byChipHeight;
    BYTE byLayerCount;
    BYTE byBitCount;
}
class CFmfMap
{
    public 
{
    this()
{
}
    this(byte[] tmp)
{
this.Load(tmp);
}
    ~this()
{
Close();
}
    BOOL Open(const char* szFilePath)
{
byte[] tmp = cast(byte[])std.file.read(std.conv.to!(string)(szFilePath));
Load(tmp);
return TRUE;
}
    void Load(byte[] tmp);
    const nothrow pure const BOOL IsOpen()
{
return m_pLayerAddr != null;
}

    void Close();
    const nothrow pure const void* GetLayerAddr(BYTE byLayerIndex);

    const nothrow pure const int GetValue(BYTE byLayerIndex, DWORD dwX, DWORD dwY);

    void SetValue(BYTE byLayerIndex, DWORD dwX, DWORD dwY, int nValue);
    const DWORD GetMapWidth()
{
return m_fmfHeader.dwWidth;
}
    const DWORD GetMapHeight()
{
return m_fmfHeader.dwHeight;
}
    const BYTE GetChipWidth()
{
return m_fmfHeader.byChipWidth;
}
    const BYTE GetChipHeight()
{
return m_fmfHeader.byChipHeight;
}
    const BYTE GetLayerCount()
{
return m_fmfHeader.byLayerCount;
}
    const BYTE GetLayerBitCount()
{
return m_fmfHeader.byBitCount;
}
    protected 
{
    FMFHEADER m_fmfHeader;
    BYTE* m_pLayerAddr;
}
}
}
import std.stdio;
