module dxlib.all;
pragma(lib, "DxLib.lib");

const bool EXTERN_WINDOWS = true;
const bool OLD_VERSION = true;


alias long LONGLONG;
alias ulong ULONGLONG;
//alias bool BOOL;
//alias ushort WORD;
//alias uint DWORD;

//alias int HWND;
//alias int HINSTANCE;
//alias int WNDPROC;
alias int IPDATA;
//alias int HRGN;
alias int GUID;
//alias int HDC;
//alias int BITMAPINFO;
alias int BASEIMAGE;
alias int SIZE;
//alias int HBITMAP;
//alias int RECT;
alias int D_IDirect3DDevice7;
//alias int POINT;
alias int WAVEFORMATEX;
//const bool TRUE = true;
//const bool FALSE = false;

public{
    import dxlib.dxlib;
    import dxlib.dxdirectx;
    import dxlib.dxwin;
    import dxlib.dxinput;
    import dxlib.dxdraw;
    import dxlib.dx3d;
    import dxlib.dxsound;
    import dxlib.dxarchive;
    import dxlib.dxmodel;
}
