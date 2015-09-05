// D import file generated from 'gamelib\surface.d'
module gamelib.surface;
import gamelib.all;
import std.string;
import std.stdio;
import dxlib.all;
import std.file;
class SurfaceBase
{
    private 
{
    bool _isTranslate;
    this(bool isTranslate)
{
_isTranslate = isTranslate;
}
    public 
{
    abstract Rect rect();

    abstract uint width();

    abstract uint height();

    final bool isTranslate()
{
return _isTranslate;
}

    final void isTranslate(bool val)
{
this._isTranslate = val;
}

}
}
}
class DrawableSurface : Surface
{
    this(int w, int h)
{
dx_SetDrawValidGraphCreateFlag(true);
dx_SetDrawValidAlphaChannelGraphCreateFlag(true);
super(w,h);
dx_SetDrawValidGraphCreateFlag(false);
}
    this(Rect rect)
{
this(rect.width,rect.height);
}
}
class Surface : SurfaceBase
{
    private 
{
    int _dxhandle;
    string _path = null;
    package 
{
    this(int dxhandle, bool isTranslate)
{
_dxhandle = dxhandle;
super(isTranslate);
}
    this(string path, bool isTranslate);
    int dxhandle()
{
return _dxhandle;
}
    public 
{
    this(int w, int h)
{
int handle = dx_MakeGraph(w,h,false);
this(handle,false);
}
    this(Rect rect)
{
this(rect.width,rect.height);
}
    ~this()
{
dx_DeleteGraph(_dxhandle);
}
    override Rect rect()
{
int w,h;
dx_GetGraphSize(_dxhandle,&w,&h);
return Rect(0,0,w,h);
}

    override uint width()
{
int w,h;
dx_GetGraphSize(_dxhandle,&w,&h);
return w;
}

    override uint height()
{
int w,h;
dx_GetGraphSize(_dxhandle,&w,&h);
return h;
}

    void remake()
{
assert(_path !is null);
this._dxhandle = dx_LoadGraph(toWStringz(this._path));
assert(this._dxhandle > 0);
}
}
}
}
}
class DividedSurface_old : SurfaceBase
{
    private 
{
    int* _dxhandle_p;
    package 
{
    this(int* dxhandle_p, bool isTranslate)
{
this._dxhandle_p = dxhandle_p;
super(isTranslate);
}
    int* dxhandle_p()
{
return _dxhandle_p;
}
    public 
{
    override Rect rect()
{
int w,h;
dx_GetGraphSize(*this._dxhandle_p,&w,&h);
return Rect(0,0,w,h);
}

    override uint width()
{
int w,h;
dx_GetGraphSize(*this._dxhandle_p,&w,&h);
return w;
}

    override uint height()
{
int w,h;
dx_GetGraphSize(*this._dxhandle_p,&w,&h);
return h;
}

}
}
}
}
class DividedSurface : SurfaceBase
{
    private 
{
    Surface _baseSurface;
    Surface[] _surfaceArray;
    Rect _rect;
    package 
{
    this(Surface baseSurface, int div_w, int div_h)
{
this._rect = mylib.rect.rect(0,0,div_w,div_h);
this._baseSurface = baseSurface;
this.div();
super(true);
}
    private void div();

    public 
{
    override Rect rect()
{
return this._rect;
}

    override uint width()
{
return this.rect.width;
}

    override uint height()
{
return this.rect.height;
}

    void remake();
    Surface opIndex(int i)
{
return _surfaceArray[i];
}
    int length()
{
return _surfaceArray.length;
}
    Surface[] surfaceArray()
{
return this._surfaceArray;
}
}
}
}
}
class BlendSurface
{
    private 
{
    int _dxhandle;
    string _path = null;
    package 
{
    this(int dxhandle)
{
_dxhandle = dxhandle;
}
    this(string path);
    int dxhandle()
{
return _dxhandle;
}
    public void remake()
{
assert(_path !is null);
this._dxhandle = dx_LoadBlendGraph(toWStringz(this._path));
assert(this._dxhandle > 0);
}

}
}
}
Surface loadSurface(string path, bool isTranslate = true)
{
return new Surface(path,isTranslate);
}
Surface loadSurfaceOld(string path, bool isTranslate = true);
BlendSurface loadBlendSurface(string path)
{
return new BlendSurface(path);
}
DividedSurface divSurfaceSize(Surface surface, int div_w, int div_h);
DividedSurface divSurfaceNum(Surface surface, int x, int y)
{
return divSurfaceSize(surface,surface.width / x,surface.height / y);
}
version (none)
{
    template divSurfaceNum(int X,int Y)
{
Surface[X * Y] divSurfaceNum(Surface surface)
{
static assert(X > 0);
static assert(Y > 0);
uint w = surface.rect.width;
uint h = surface.rect.height;
uint xmax = X;
uint ymax = Y;
int div_w = surface.width / X;
int div_h = surface.height / Y;
Surface[X * Y] res;
{
for (uint yidx = 0;
 yidx < ymax; yidx++)
{
{
{
for (uint xidx = 0;
 xidx < xmax; xidx++)
{
{
uint l = xidx * div_w;
uint t = yidx * div_h;
uint residx = xidx + yidx * xmax;
int dxhandle = dx_DerivationGraph(cast(int)l,cast(int)t,cast(int)div_w,cast(int)div_h,surface.dxhandle);
res[residx] = new Surface(dxhandle,true);
}
}
}
}
}
}
return res;
}
}
}
DividedSurface loadDivSurfaceNum(string path, int x, int y, bool isTranslate = true)
{
Surface sur = loadSurface(path,isTranslate);
return divSurfaceNum(sur,x,y);
}
