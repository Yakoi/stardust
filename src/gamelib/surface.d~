module gamelib.surface;

import gamelib.all;
import std.string;
import std.stdio;
import dxlib.all;
import std.file;


/// サーフェイスのinterface
interface SurfaceBaseInterface{
    /// サーフェイスの範囲
    abstract Rect rect();
    /// サーフェイスの横幅
    abstract uint width();
    /// サーフェイスの高さ
    abstract uint height();
    /// 透過処理をするかどうか取得
    final bool isTranslate();
}
/// サーフェイスのベースクラス
class SurfaceBase{
private:
    bool _isTranslate;
protected:
    this(bool isTranslate){
        _isTranslate = isTranslate;
    }
public:
    /// サーフェイスの範囲
    abstract Rect rect();
    /// サーフェイスの横幅
    abstract uint width();
    /// サーフェイスの高さ
    abstract uint height();
    /// 透過処理をするかどうか取得
    final bool isTranslate(){ return _isTranslate; }
    /// 透過処理をするかどうか設定
    final void isTranslate(bool val){ this._isTranslate = val; }
}

interface DrawableSurfaceInterface : SurfaceBaseInterface{
    int dxhandle();
}

/// 描画可能なサーフェイス
class DrawableSurface : Surface, DrawableSurfaceInterface{
    static VERTEX2DSHADER[ 6 ] vertShader ;   // 頂点データの準備
    static VERTEX2D[ 6 ] vert ;   // 頂点データの準備
                                                                        
/// サイズを指定して作成
    this(int w, int h){
        int w2=512 ;int h2=256;

        // 画面比
        float aspect = 1;

        // 頂点データの準備(画面と同じサイズ)
        vert[ 0 ].pos = VGet(   0.0f,   0.0f, 0.0f ) ;
        vert[ 1 ].pos = VGet(     w2,   0.0f, 0.0f ) ;
        vert[ 2 ].pos = VGet(   0.0f,     h2, 0.0f ) ;
        vert[ 3 ].pos = VGet(     w2,     h2, 0.0f ) ;
        vert[ 0 ].dif = GetColorU8( 255,255,255,255 ) ;
        vert[ 1 ].dif = GetColorU8( 255,255,255,255 ) ;
        vert[ 2 ].dif = GetColorU8( 255,255,255,255 ) ;
        vert[ 3 ].dif = GetColorU8( 255,255,255,255 ) ;
        vert[ 0 ].u = 0.0f ; vert[ 0 ].v = 0.0f ;
        vert[ 1 ].u = 1.0f ; vert[ 1 ].v = 0.0f ;
        vert[ 2 ].u = 0.0f; vert[2].v = 1.0f * aspect;	// ※なぜか比率を掛けないと正しい結果が得られない
        vert[ 3 ].u = 1.0f; vert[3].v = 1.0f * aspect;	// 　書き込み先が1024x1024で作成されている？
        vert[ 0 ].rhw = 1.0f ;
        vert[ 1 ].rhw = 1.0f ;
        vert[ 2 ].rhw = 1.0f ;
        vert[ 3 ].rhw = 1.0f ;
        vert[ 4 ] = vert[ 2 ] ;
        vert[ 5 ] = vert[ 1 ] ;

        vertShader[ 0 ].pos = VGet(   0.0f,   0.0f, 0.0f ) ;
        vertShader[ 1 ].pos = VGet(     w2,   0.0f, 0.0f ) ;
        vertShader[ 2 ].pos = VGet(   0.0f,     h2, 0.0f ) ;
        vertShader[ 3 ].pos = VGet(     w2,     h2, 0.0f ) ;
        vertShader[ 0 ].dif = GetColorU8( 255,255,255,255 ) ;
        vertShader[ 0 ].spc = GetColorU8( 0,0,0,0 ) ;
        vertShader[ 1 ].dif = GetColorU8( 255,255,255,255 ) ;
        vertShader[ 1 ].spc = GetColorU8( 0,0,0,0 ) ;
        vertShader[ 2 ].dif = GetColorU8( 255,255,255,255 ) ;
        vertShader[ 2 ].spc = GetColorU8( 0,0,0,0 ) ;
        vertShader[ 3 ].dif = GetColorU8( 255,255,255,255 ) ;
        vertShader[ 3 ].spc = GetColorU8( 0,0,0,0 ) ;
        vertShader[ 0 ].u = 0.0f ; vertShader[ 0 ].v = 0.0f ;
        vertShader[ 1 ].u = 1.0f ; vertShader[ 1 ].v = 0.0f ;
        vertShader[ 2 ].u = 0.0f; vertShader[2].v = 1.0f * aspect;	// ※なぜか比率を掛けないと正しい結果が得られない
        vertShader[ 3 ].u = 1.0f; vertShader[3].v = 1.0f * aspect;	// 　書き込み先が1024x1024で作成されている？
        vertShader[ 0 ].su = 0.0f ; vertShader[ 0 ].sv = 0.0f ;
        vertShader[ 1 ].su = 1.0f ; vertShader[ 1 ].sv = 0.0f ;
        vertShader[ 2 ].su = 0.0f ; vertShader[ 2 ].sv = 1.0f ;
        vertShader[ 3 ].su = 1.0f ; vertShader[ 3 ].sv = 1.0f ;
        vertShader[ 0 ].rhw = 1.0f ;
        vertShader[ 1 ].rhw = 1.0f ;
        vertShader[ 2 ].rhw = 1.0f ;
        vertShader[ 3 ].rhw = 1.0f ;
        vertShader[ 4 ] = vertShader[ 2 ] ;
        vertShader[ 5 ] = vertShader[ 1 ] ;

        SetDrawValidAlphaChannelGraphCreateFlag( true );
        int handle = MakeScreen( w2, h2 ) ;// 描画可能な画面を作成
        SetDrawValidAlphaChannelGraphCreateFlag( false );
        super(handle, false);
    }
    /// サイズを指定して作成
    this(Rect rect){
        this(rect.width, rect.height);
    }
    int dxhandle(){return super.dxhandle();}
}
/// 一枚のサーフェイス
class Surface : SurfaceBase{
private:
    int _dxhandle;
    string _path = null;
package:
    this(int dxhandle, bool isTranslate){
        _dxhandle = dxhandle;
        super(isTranslate);
    }
    this(string path, bool isTranslate){
        this._path = path;
        this._dxhandle = dx_LoadGraph(toWStringz(path));
        if(dxhandle == -1){throw new Exception("Surface Load Error : " ~ path);}
        super(isTranslate);
    }
    /// DxLibのグラフィックハンドル
    int dxhandle(){return _dxhandle;}
public:
    this(int w, int h){
        int handle = dx_MakeGraph( w, h, false) ;// 空のグラフィックを作成
        this(handle, false);
    }
    this(Rect rect){
        this(rect.width, rect.height);
    }
    ~this(){
        dx_DeleteGraph(_dxhandle);
    }
    /// サーフェイスの範囲
    override Rect rect(){
        int w,h;
        dx_GetGraphSize(_dxhandle, &w, &h);
        return Rect(0,0,w,h);
    }
    /// サーフェイスの高さ
    override uint width(){
        int w,h;
        dx_GetGraphSize(_dxhandle, &w, &h);
        return w;
    }
    /// サーフェイスの横幅
    override uint height(){
        int w,h;
        dx_GetGraphSize(_dxhandle, &w, &h);
        return h;
    }
    //bool draw(Drawer drawer, Vector pos, double dir, 
    //        BlendMode blend_mode, ubyte blend_param, bool is_rotate){
    //    return drawer.surface(this, pos, dir, _isTranslate, blend_mode, blend_param);
    //}
    void remake(){
        assert(_path !is null);
        this._dxhandle = dx_LoadGraph(toWStringz(this._path));
        assert(this._dxhandle > 0);
    }
}
/// 分割されたサーフェイスを扱う
class DividedSurface_old : SurfaceBase{
private:
    int* _dxhandle_p;
package:
    this(int* dxhandle_p, bool isTranslate){
        this._dxhandle_p = dxhandle_p;
        super(isTranslate);
    }
    /// DxLibのグラフィックハンドル
    int* dxhandle_p(){
        return _dxhandle_p;
    }
public:
    /// サーフェイスの範囲
    override Rect rect(){
        int w,h;
        dx_GetGraphSize(*this._dxhandle_p, &w, &h);
        return Rect(0,0,w,h);
    }
    /// サーフェイスの横幅
    override uint width(){
        int w,h;
        dx_GetGraphSize(*this._dxhandle_p, &w, &h);
        return w;
    }
    /// サーフェイスの高さ
    override uint height(){
        int w,h;
        dx_GetGraphSize(*this._dxhandle_p, &w, &h);
        return h;
    }
}
unittest{

}

/// 分割されたサーフェイスを扱う
class DividedSurface : SurfaceBase{
private:
    Surface _baseSurface;
    Surface[] _surfaceArray;
    Rect _rect;
package:
    this(Surface baseSurface, int div_w, int div_h){
        this._rect = mylib.rect.rect(0,0,div_w, div_h);
        this._baseSurface = baseSurface;
        this.div();
        super(true);
    }
    private void div(){
        Surface surface = this._baseSurface;
        uint w = surface.rect.width;
        uint h = surface.rect.height;
        int div_w = this.rect.width;
        int div_h = this.rect.height;

        uint xmax = w/div_w;
        uint ymax = h/div_h;

        this._surfaceArray.length = xmax*ymax;

        for(uint yidx=0; yidx<ymax; yidx++){
            for(uint xidx=0; xidx<xmax; xidx++){
                uint l = xidx * div_w;
                uint t = yidx * div_h;
                uint residx = xidx + yidx * xmax;
                int dxhandle = dx_DerivationGraph(
                        cast(int)l,cast(int)t,cast(int)div_w,cast(int)div_h,surface.dxhandle);
                this._surfaceArray[residx] = new Surface(dxhandle, true);
            }
        }
    }
public:

    /// サーフェイスの範囲
    override Rect rect(){
        return this._rect;
    }
    /// サーフェイスの横幅
    override uint width(){
        return this.rect.width;
    }
    /// サーフェイスの高さ
    override uint height(){
        return this.rect.height;
    }
    ///
    void remake(){
        foreach(i,s;this.surfaceArray){
            uint xidx = i%6;
            uint yidx = i/6;
            uint l = xidx * this.width;
            uint t = yidx * this.height;
            int newDxhandle = dx_DerivationGraph(
                    cast(int)l,cast(int)t,this.width,this.height,this._baseSurface.dxhandle);
            s._dxhandle = newDxhandle;
        }
    }
    ///
    Surface opIndex(int i){
        return _surfaceArray[i];
    }
    ///
    int length(){
        return _surfaceArray.length;
    }

    ///
    Surface[] surfaceArray(){return this._surfaceArray;}
}
/// blendのための
class BlendSurface{
private:
    int _dxhandle;
    string _path = null;
package:
    this(int dxhandle){
        _dxhandle = dxhandle;
    }
    this(string path){
        this._path = path;
        this._dxhandle = dx_LoadBlendGraph(toWStringz(path));
        if(dxhandle == -1){throw new Exception("Blend Surface Load Error : " ~ path);}
    }
    /// DxLibのグラフィックハンドル
    int dxhandle(){return _dxhandle;}
public:
    //bool draw(Drawer drawer, Vector pos, double dir, 
    //        BlendMode blend_mode, ubyte blend_param, bool is_rotate){
    //    return drawer.surface(this, pos, dir, _isTranslate, blend_mode, blend_param);
    //}
    void remake(){
        assert(_path !is null);
        this._dxhandle = dx_LoadBlendGraph(toWStringz(this._path));
        assert(this._dxhandle > 0);
    }
}

/// ファイルからサーフェイスをロードする
/// ロード時にエラーが起きたら例外を投げる
Surface loadSurface(string path, bool isTranslate = true){
    //if(!exists(path)){throw new Exception("surface.loadSurface Load Error : " ~ path);}
    //if(!isfile(path)){throw new Exception("surface.loadSurface Load Error : " ~ path);}
    return new Surface(path, isTranslate);
}
/// ファイルからサーフェイスをロードする
/// ロード時にエラーが起きたら例外を投げる
Surface loadSurfaceOld(string path, bool isTranslate = true){
    //if(!exists(path)){throw new Exception("surface.loadSurfaceOld Load Error : " ~ path);}
    //if(!isfile(path)){throw new Exception("surface.loadSurfaceOld Load Error : " ~ path);}
    int dxhandle = dx_LoadGraph(toWStringz(path));
    if(dxhandle == -1){throw new Exception("Surface Load Error : " ~ path);}
    return new Surface(dxhandle, isTranslate);
}

BlendSurface loadBlendSurface(string path){
    return new BlendSurface(path);
}
/+
/// ファイルからサーフェイスを分割してロードする
DividedSurface load_divsurface(string path, int all_num,
        int xnum, int ynum, int xsize, int ysize,
        bool isTranslate = true){
    int* dxhandle_p;
    dx_LoadDivGraph( toWStringz(path) , all_num ,
            xnum , ynum , xsize , ysize , dxhandle_p) ;
    return new DividedSurface(dxhandle_p, isTranslate);
}
+/
/// サーフェイスのロード後に分割する
DividedSurface divSurfaceSize(Surface surface, int div_w, int div_h)
in{
    assert(surface !is null);
    assert(div_w > 0);
    assert(div_h > 0);
}body{
    return new DividedSurface(surface, div_w, div_h);
    version(none){
    uint w = surface.rect.width;
    uint h = surface.rect.height;

    uint xmax = w/div_w;
    uint ymax = h/div_h;

    Surface[] res;
    res.length = xmax*ymax;

    for(uint yidx=0; yidx<ymax; yidx++){
        for(uint xidx=0; xidx<xmax; xidx++){
            uint l = xidx * div_w;
            uint t = yidx * div_h;
            uint residx = xidx + yidx * xmax;
            int dxhandle = dx_DerivationGraph(
                    cast(int)l,cast(int)t,cast(int)div_w,cast(int)div_h,surface.dxhandle);
            res[residx] = new Surface(dxhandle, true);
        }
    }
    //writefln(res);
    return res;
    }
}
DividedSurface divSurfaceNum(Surface surface, int x,int y){
    return divSurfaceSize(surface, surface.width/x, surface.height/y);
}
version (none)
Surface[X*Y] divSurfaceNum(int X,int Y)(Surface surface){
    static assert(X>0);
    static assert(Y>0);
    uint w = surface.rect.width;
    uint h = surface.rect.height;

    uint xmax = X;
    uint ymax = Y;
    int div_w = surface.width / X;
    int div_h = surface.height/ Y;

    Surface[X*Y] res;

    for(uint yidx=0; yidx<ymax; yidx++){
        for(uint xidx=0; xidx<xmax; xidx++){
            uint l = xidx * div_w;
            uint t = yidx * div_h;
            uint residx = xidx + yidx * xmax;
            int dxhandle = dx_DerivationGraph(
                    cast(int)l,cast(int)t,cast(int)div_w,cast(int)div_h,surface.dxhandle);
            res[residx] = new Surface(dxhandle, true);
        }
    }
    return res;
}
DividedSurface loadDivSurfaceNum(string path, int x, int y, bool isTranslate = true){
    //if(!exists(path)){throw new Exception("surface.loadDivSurfaceNum Load Error : " ~ path);}
    //if(!isfile(path)){throw new Exception("surface.loadDivSurfaceNum Load Error : " ~ path);}
    Surface sur = loadSurface(path, isTranslate);
    return divSurfaceNum(sur, x, y);
}

/+
class AnimationSurface:
    def __init__(self, surface_list, interval):
        self._surface_list = surface_list
        self._interval = interval
    def get_surface_list(self):
        return self._surface_list
    def get_interval(self):
        return self._interval

class RotatableSurface:
    def __init__(self, surface_list):
        self._surface_list = surface_list
    def get_surface_list(self):
        return self._surface_list

class RotatableAnimationSurface:
    def __init__(self, surface_list_list, interval):
        self._surface_list_list = surface_list_list
        self._interval = interval
    def get_surface_list_list(self):
        return self._surface_list_list
    def get_interval(self):
        return self._interval

+/
