// D import file generated from 'gamelib\font.d'
module gamelib.font;
import gamelib.all;
import dxlib.all;
abstract class Font
{
    abstract int handle();

    abstract void space(int val);

    abstract int maxWidth();

    abstract int stringWidth(string str);

    abstract int stringWidth(char[] str);

    abstract int cstringWidth(char[] str);

    abstract int vstringWidth(string str);

    abstract int size();

    abstract int thickness();

    abstract bool remake()
out(res)
{
assert(res);
}
body
{
return false;
}

}

class DxlibFont : Font
{
    private 
{
    int _handle;
    string _name;
    int _size;
    int _thickness;
    this(int fontHandle, string name)
in
{
assert(fontHandle > 0,to!(string)(fontHandle));
}
body
{
this._handle = fontHandle;
this._name = name;
this._size = this.size;
this._thickness = this.thickness;
}
        public 
{
    ~this()
{
dx_DeleteFontToHandle(this._handle);
}
    const override pure int handle()
{
return _handle;
}

    override void space(int val)
{
dx_SetFontSpaceToHandle(val,this.handle);
}

    override int maxWidth()
{
return dx_GetFontMaxWidthToHandle(this.handle);
}

    override int stringWidth(string str)
{
return this.cstringWidth(toCString(str));
}

    override int stringWidth(char[] str)
{
return this.cstringWidth(toCString(str));
}

    int stringWidth(wchar[] str)
{
return this.stringWidth(to!(wstring)(str));
}
    int stringWidth(wstring str)
{
wchar* cstr = toWStringz(cast(wchar[])str);
return dx_GetDrawStringWidthToHandle(cstr,str.length,this.handle);
}
    override int cstringWidth(char[] str)
{
return cstringWidth(to!(wchar[])(str));
}

    int cstringWidth(wchar[] str)
{
wchar* cstr = toWStringz(str);
return dx_GetDrawStringWidthToHandle(cstr,str.length,this.handle);
}
    override int vstringWidth(string str)
{
return this.vstringWidth(to!(wstring)(str));
}

    int vstringWidth(wstring str)
{
return dx_GetDrawStringWidthToHandle(toWStringz(cast(wchar[])str),str.length,this.handle,true);
}
    override int size()
{
int res;
dx_GetFontStateToHandle(null,&res,null,this.handle);
return res;
}

    override int thickness()
{
int res;
dx_GetFontStateToHandle(null,null,&res,this.handle);
return res;
}

    override bool remake()
out
{
}
body
{
char[] n = toCString(this._name);
this._handle = dx_CreateFontToHandle(toWStringz(n),this._size,this._thickness,FontType.NORMAL);
return 0 != dx_CheckFontHandleValid(this._handle);
}

}
}
}
package class SystemFont : Font
{
    void path(string path)
{
dx_ChangeFont(toWStringz(path));
}
    void path(wstring path)
{
this.path(to!(string)(path));
}
    override int handle()
{
return dx_GetDefaultFontHandle();
}

    void size(int val)
in
{
assert(val > 0);
}
body
{
dx_SetFontSize(val);
}
    void thickness(int val)
in
{
assert(val > 0);
}
body
{
dx_SetFontThickness(val);
}
    void type(int val)
{
dx_ChangeFontType(val);
}
    override void space(int val)
{
dx_SetFontSpace(val);
}

    override int maxWidth()
{
return dx_GetFontMaxWidth();
}

    override int stringWidth(string str)
{
return this.stringWidth(to!(wstring)(str));
}

    int stringWidth(wstring str)
{
return dx_GetDrawStringWidth(toWStringz(cast(wchar[])str),str.length);
}
    override int stringWidth(char[] str)
{
return dx_GetDrawStringWidth(toWStringz(str),str.length);
}

    override int cstringWidth(char[] str)
{
assert(false);
}

    override int vstringWidth(string str)
{
return this.vstringWidth(to!(wstring)(str));
}

    int vstringWidth(wstring str)
{
return dx_GetDrawStringWidth(str.ptr,str.length,true);
}
    override int size()
{
return dx_GetFontSize();
}

    override int thickness()
{
int res;
dx_GetFontStateToHandle(null,null,&res,this.handle);
return res;
}

    void set(string name = null, int size = -1, int thickness = -1)
{
dx_SetDefaultFontState(toWStringz(cast(char[])name),size,thickness);
}
    void set(wstring name = null, int size = -1, int thickness = -1)
{
dx_SetDefaultFontState(toWStringz(cast(wchar[])name),size,thickness);
}
    override bool remake()
out
{
}
body
{
return true;
}

}

enum FontType 
{
NORMAL = DX_FONTTYPE_NORMAL,
EDGE = DX_FONTTYPE_EDGE,
ANTIALIASING = DX_FONTTYPE_ANTIALIASING,
ANTIALIASING_EDGE = DX_FONTTYPE_ANTIALIASING_EDGE,
}
enum FontResource 
{
PVT,
NOT_ENUM,
}
DxlibFont loadFont(string path, string name, int size = -1, int thinck = -1, FontType fonttype = FontType.NORMAL);
DxlibFont loadFont2(string path, string name, int size = -1, int thinck = -1, FontType fonttype = FontType.NORMAL);
DxlibFont createFont(void[] data, string name, int size = -1, int thinck = -1, FontType fonttype = FontType.NORMAL);
import mylib.utils;
import core.sys.windows.windows;
pragma (lib, "gdi32.lib");
alias void DESIGNVECTOR;
alias char* LPCTSTR;
extern (Windows) int AddFontResourceExA(LPCTSTR lpszFilename, core.sys.windows.windows.DWORD fl, DESIGNVECTOR* pdv);

extern (Windows) HANDLE AddFontMemResourceEx(LPVOID pbFont, DWORD cbFont, DESIGNVECTOR* pdv, DWORD* pcFonts);

bool addFont(string path);
bool addFont2(string path)
{
char[] p = toCString(path);
return 0 < AddFontResourceExA(cast(char*)toStringz(p),0,null);
}
bool addFontMem(void[] data)
{
AddFontMemResourceEx(data.ptr,data.length,null,null);
return true;
}
