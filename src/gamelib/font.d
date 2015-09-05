module gamelib.font;

import gamelib.all;
import dxlib.all;
//import std.c.windows.windows;

/// フォントのベースクラス
abstract class Font{
    /// フォントハンドル取得
    abstract int handle();
    /// 字間を変更する
    abstract void space(int val);
    /// 文字の最大幅を得る
    abstract int maxWidth();
    /// 文字列の幅を得る
    abstract int stringWidth(string str);
    /// 文字列の幅を得る
    abstract int stringWidth(char[] str);
    /// 文字列の幅を得る
    abstract int cstringWidth(char[] str);
    /// 縦文字列の幅を得る
    abstract int vstringWidth(string str);
    /// フォントの大きさを取得
    abstract int size();
    /// フォントの太さを取得
    abstract int thickness();

    abstract bool remake()out(res){assert(res);}body{return false;};
}
/// Dxlibのフォント
class DxlibFont : Font{
private:
    int _handle;
    string _name;
    int _size;
    int _thickness;
    this(int fontHandle, string name)
    in{
        assert(fontHandle > 0, to!(string)(fontHandle));
    }body{
        this._handle = fontHandle;
        this._name = name;
        this._size = this.size;
        this._thickness = this.thickness;
    }
    invariant(){
        assert(this._handle > 0);
    }
public:
    /// デストラクタ
    ~this(){
        dx_DeleteFontToHandle(this._handle);
    }
    /// フォントハンドル取得
    const pure override int handle(){return _handle;}
    /// 字間を変更する
    override void space(int val) {
        dx_SetFontSpaceToHandle( val, this.handle ) ;// 字間を変更する
    }
    /// 文字の最大幅を得る
    override int maxWidth(){
        return dx_GetFontMaxWidthToHandle( this.handle) ;  // 文字の最大幅を得る
    }
    /// 文字列の幅を得る
    override int stringWidth(string str){
        return this.cstringWidth(toCString(str));
    }
    /// 文字列の幅を得る
    override int stringWidth(char[] str){
        return this.cstringWidth(toCString(str));
    }
    /// 文字列の幅を得る
    int stringWidth(wchar[] str){
        return this.stringWidth(to!(wstring)(str));
    }
    /// 文字列の幅を得る
    int stringWidth(wstring str){
        wchar* cstr = toWStringz(cast(wchar[])str);
        return dx_GetDrawStringWidthToHandle( cstr, str.length, this.handle ) ;
    }
    /// 文字列の幅を得る
    override int cstringWidth(char[] str){
        return cstringWidth(to!(wchar[])(str));
    }
    /// 文字列の幅を得る
    int cstringWidth(wchar[] str){
        wchar* cstr = toWStringz(str);
        return dx_GetDrawStringWidthToHandle( cstr, str.length, this.handle ) ;
    }
    /// 縦文字列の幅を得る
    override int vstringWidth(string str){
        return this.vstringWidth(to!(wstring)(str));
    }
    /// 縦文字列の幅を得る
    int vstringWidth(wstring str){
        return dx_GetDrawStringWidthToHandle( toWStringz(cast(wchar[])str), str.length, this.handle, true ) ;
    }
    /// フォントの大きさを取得
    override int size(){ 
        int res;
        dx_GetFontStateToHandle( null, &res, null, this.handle) ;// フォントの情報を得る
        return res;
    }
    /// フォントの太さを取得
    override int thickness(){ 
        int res;
        dx_GetFontStateToHandle( null, null, &res, this.handle) ;// フォントの情報を得る
        return res;
    }
    override bool remake()out{}body{
        char[] n = toCString(this._name);
        this._handle = dx_CreateFontToHandle(toWStringz(n),
                this._size, this._thickness, FontType.NORMAL);
        return 0!=dx_CheckFontHandleValid(this._handle);
    }
}
/// システムフォント
package class SystemFont : Font{
    /// システムフォントを変更
    void path(string path){
        dx_ChangeFont(toWStringz(path));
    }
    void path(wstring path){
        this.path(to!(string)(path));
    }

    /// フォントハンドルを取得
    override int handle(){
        return dx_GetDefaultFontHandle() ;// デフォルトのフォントのハンドルを得る
    }
    /// システムフォントの大きさを変更
    void size(int val)
    in{
        assert(val>0);
    }body{
        dx_SetFontSize(val);
    }
    /// システムフォントの太さを変更
    void thickness(int val)
    in{
        assert(val>0);
    }body{
        dx_SetFontThickness(val);
    }
    /// ??????
    void type(int val){
        dx_ChangeFontType(val);
    }
    /// 字間を変更する
    override void space(int val){
        dx_SetFontSpace( val) ; // 字間を変更する
    }
    /// 文字の最大幅を得る
    override int maxWidth(){
        return dx_GetFontMaxWidth( ) ;  // 文字の最大幅を得る
    }
    /// 文字列の幅を得る
    override int stringWidth(string str){
        return this.stringWidth(to!(wstring)(str));
    }
    /// 文字列の幅を得る
    int stringWidth(wstring str){
        return dx_GetDrawStringWidth( toWStringz(cast(wchar[])str), str.length ) ;
    }
    /// 文字列の幅を得る
    override int stringWidth(char[] str){
        return dx_GetDrawStringWidth( toWStringz(str), str.length ) ;
    }
    /// 文字列の幅を得る
    override int cstringWidth(char[] str){
        //return dx_GetDrawStringWidth( str.ptr, str.length ) ;
        assert(false);
    }
    /// 縦文字列の幅を得る
    override int vstringWidth(string str){
        return this.vstringWidth(to!(wstring)(str));
    }
    /// 縦文字列の幅を得る
    int vstringWidth(wstring str){
        return dx_GetDrawStringWidth( str.ptr, str.length, true ) ;
    }
    /// フォントの大きさを取得
    override int size(){ 
        return dx_GetFontSize() ;// フォントの情報を得る
    }
    /// フォントの太さを取得
    override int thickness(){ 
        int res;
        dx_GetFontStateToHandle( null, null, &res, this.handle) ;// フォントの情報を得る
        return res;
    }
    void set(string name = null, int size = -1, int thickness = -1){
        dx_SetDefaultFontState( toWStringz(cast(char[])name), size, thickness ) ; // デフォルトフォントのステータスを一括設定する
    }
    void set(wstring name = null, int size = -1, int thickness = -1){
        dx_SetDefaultFontState( toWStringz(cast(wchar[])name), size, thickness ) ; // デフォルトフォントのステータスを一括設定する
    }
    override bool remake()out{}body{
        return true;
    }
}
/// フォントの描画タイプ
enum FontType{
    NORMAL            = DX_FONTTYPE_NORMAL,            /// ノーマルフォント
    EDGE              = DX_FONTTYPE_EDGE,              /// エッジつきフォント
    ANTIALIASING      = DX_FONTTYPE_ANTIALIASING,      /// アンチエイリアスフォント
    ANTIALIASING_EDGE = DX_FONTTYPE_ANTIALIASING_EDGE, /// アンチエイリアス＆エッジ付きフォント
}
enum FontResource{
    PVT,
    NOT_ENUM,
}
/// フォントをロードします
DxlibFont loadFont(string path, string name, int size=-1, int thinck = -1, FontType fonttype = FontType.NORMAL)
out(res){
    assert(0!=dx_CheckFontHandleValid(res.handle)) ;// 指定のフォントハンドルが有効か否か調べる
}body{
    if(!addFont(path)){return null;}
    char[] n = toCString(name);
    int handle = dx_CreateFontToHandle(toWStringz(n), size, thinck, fonttype);
    return new DxlibFont(handle, name);
}
/// フォントをロードします
DxlibFont loadFont2(string path, string name, int size=-1, int thinck = -1, FontType fonttype = FontType.NORMAL)
out(res){
    assert(0!=dx_CheckFontHandleValid(res.handle)) ;// 指定のフォントハンドルが有効か否か調べる
}body{
    if(!addFont2(path)){return null;}
    char[] n = toCString(name);
    int handle = dx_CreateFontToHandle(toWStringz(n), size, thinck, fonttype);
    return new DxlibFont(handle, name);
}
DxlibFont createFont(void[] data, string name, int size=-1, int thinck = -1, FontType fonttype = FontType.NORMAL)
out(res){
    assert(0!=dx_CheckFontHandleValid(res.handle)) ;// 指定のフォントハンドルが有効か否か調べる
}body{
    if(!addFontMem(data)){return null;}
    char[] n = toCString(name);
    int handle = dx_CreateFontToHandle(toWStringz(n), size, thinck, fonttype);
    return new DxlibFont(handle, name);
}

///////////////////////////////////////////////

import mylib.utils;
import core.sys.windows.windows;
pragma(lib, "gdi32.lib");
alias void DESIGNVECTOR;
alias char* LPCTSTR;
//alias int HANDLE;
//alias void LPVOID;
extern(Windows)int AddFontResourceExA(
  LPCTSTR lpszFilename,   // フォントリソースファイル名
  core.sys.windows.windows.DWORD fl,               // フラグ
  DESIGNVECTOR *pdv       // Multiple Master フォントを指定する
                      // 軸値の組へのポインタ
);

extern(Windows)HANDLE AddFontMemResourceEx(
  LPVOID pbFont,       // フォントリソースへのポインタ
  DWORD cbFont,        // フォントリソースのバイト数
  DESIGNVECTOR *pdv,   // Multiple Master フォントに対する軸値へのポインタ
  DWORD *pcFonts,      // インストールされているフォント数
);
bool addFont(string path){
    void[] data;
    try{
        data = dxread(path);
    }catch(Exception e){
        writeln(e.msg);
        return false;
    }
    addFontMem(data);
    return true;
}
bool addFont2(string path){
    char[] p = toCString(path);
    return 0<AddFontResourceExA(cast(char*)toStringz(p),0,null);
}
bool addFontMem(void[] data){
    AddFontMemResourceEx(data.ptr, data.length, null, null);
    return true;
}

