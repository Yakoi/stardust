// D import file generated from 'gamelib\map.d'
module gamelib.map;
import gamelib.all;
import mylib.utils;
import std.stdio;
import fmf.fmfmap;
import std.conv;
import dxlib.all;
abstract template MapLayerBase(T)
{
class MapLayerBase
{
    this()
{
}
    const abstract nothrow pure T chipId(int xChipNum, int yChipNum);

    const abstract nothrow pure T getChip(int x, int y);

    const nothrow pure T getChip(Vector p)
{
return this.getChip(cast(int)p.x,cast(int)p.y);
}

    const final nothrow pure T getChip(IntVector p)
{
return this.getChip(p.x,p.y);
}

    abstract void setChip(int x, int y, T chip);

    abstract void draw(Drawer drawer, Rect dest, int x, int y, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255));

    final void draw(Drawer drawer, int x, int y, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255))
{
Rect r = rect(0,0,drawer.screen.width,drawer.screen.height);
this.draw(drawer,r,x,y,blendMode,blendParam,bright);
}

}
}

abstract template MapLayer(T)
{
class MapLayer : MapLayerBase!(T)
{
    private 
{
    int _chipWidth;
    int _chipHeight;
    int _mapWidthChipNum;
    int _mapHeightChipNum;
    int _paletteWidthChipNum;
    int _paletteHeightChipNum;
    public 
{
    this(int chipWidth, int chipHeight, int mapWidthChipNum, int mapHeightChipNum, int paletteWidthChipNum, int paletteHeightChipNum)
{
this._chipWidth = chipWidth;
this._chipHeight = chipHeight;
this._mapWidthChipNum = mapWidthChipNum;
this._mapHeightChipNum = mapHeightChipNum;
this._paletteWidthChipNum = paletteWidthChipNum;
this._paletteHeightChipNum = paletteHeightChipNum;
}
    const final nothrow pure int chipWidth()
{
return this._chipWidth;
}

    const final nothrow pure int chipHeight()
{
return this._chipHeight;
}

    const final nothrow pure int mapWidthChipNum()
{
return this._mapWidthChipNum;
}

    const final nothrow pure int mapHeightChipNum()
{
return this._mapHeightChipNum;
}

    const final nothrow pure int paletteWidthChipNum()
{
return this._paletteWidthChipNum;
}

    const final nothrow pure int paletteHeightChipNum()
{
return this._paletteHeightChipNum;
}

    const final nothrow pure int paletteWidth()
{
return this.paletteWidthChipNum * this.chipWidth;
}

    const final nothrow pure int paletteHeight()
{
return this.paletteHeightChipNum * this.chipHeight;
}

    const final nothrow pure int chipNoMax()
{
return this.paletteHeightChipNum * this.paletteWidthChipNum;
}

    const final nothrow pure int map_width()
{
return this.chipWidth * this.mapWidthChipNum;
}

    const final nothrow pure int map_height()
{
return this.chipHeight * this.mapHeightChipNum;
}

    const abstract override nothrow pure T chipId(int xChipNum, int yChipNum);

    abstract override void setChip(int x, int y, T chip);

    abstract override void draw(Drawer drawer, Rect dest, int x, int y, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255));

    const final override nothrow pure T getChip(int x, int y)
{
return this.chipId(x / this.chipWidth,y / this.chipHeight);
}

    const final override nothrow pure T getChip(Vector p)
{
return this.getChip(cast(int)p.x,cast(int)p.y);
}

    const final nothrow pure bool inMapPos(int x, int y)
{
bool bx = 0 <= x && x < this.map_width;
bool by = 0 <= y && y < this.map_height;
return bx && by;
}

    const final nothrow pure bool inMapPos(Vector p)
{
return inMapPos(cast(int)p.x,cast(int)p.y);
}

    const final nothrow pure bool inMapPos(IntVector p)
{
return inMapPos(p.x,p.y);
}

    const final nothrow pure bool inMapChipNum(int xChipNum, int yChipNum)
{
bool bx = 0 <= xChipNum && xChipNum < this.mapWidthChipNum;
bool by = 0 <= yChipNum && yChipNum < this.mapHeightChipNum;
return bx && by;
}

    const final nothrow pure bool inPaletteChipNum(int xChipNum, int yChipNum)
{
bool bx = 0 <= xChipNum && xChipNum < this.paletteWidthChipNum;
bool by = 0 <= yChipNum && yChipNum < this.paletteHeightChipNum;
return bx && by;
}

    const final nothrow pure bool in_palette_chipNo(int chipNo)
{
return 0 <= chipNo && chipNo < chipNoMax;
}

    const final nothrow pure int chipNo2PaletteXChipNum(int chipNo)
in
{
static if(true)
{
assert(0 <= chipNo && chipNo < this.paletteWidthChipNum * this.paletteHeightChipNum);
}
else
{
assert(0 <= chipNo && chipNo < this.paletteWidthChipNum * this.paletteHeightChipNum,to!(string)(chipNo));
}

}
body
{
return chipNo % this.paletteWidthChipNum;
}

    const final nothrow pure int chipNo2PaletteYChipNum(int chipNo)
in
{
static if(true)
{
assert(0 <= chipNo && chipNo < this.paletteWidthChipNum * this.paletteHeightChipNum);
}
else
{
assert(0 <= chipNo && chipNo < this.paletteWidthChipNum * this.paletteHeightChipNum,to!(string)(chipNo));
}

}
body
{
return chipNo / this.paletteWidthChipNum;
}

    const final nothrow pure int chipNo2PaletteX(int chipNo)
in
{
static if(true)
{
assert(0 <= chipNo && chipNo < this.paletteWidthChipNum * this.paletteHeightChipNum);
}
else
{
assert(0 <= chipNo && chipNo < this.paletteWidthChipNum * this.paletteHeightChipNum,to!(string)(chipNo));
}

}
body
{
return this.chipNo2PaletteXChipNum(chipNo) * this.chipWidth;
}

    const final nothrow pure int chipNo2PaletteY(int chipNo)
in
{
static if(true)
{
assert(0 <= chipNo && chipNo < this.paletteWidthChipNum * this.paletteHeightChipNum);
}
else
{
assert(0 <= chipNo && chipNo < this.paletteWidthChipNum * this.paletteHeightChipNum,to!(string)(chipNo));
}

}
body
{
return this.chipNo2PaletteYChipNum(chipNo) * this.chipHeight;
}

    const final nothrow pure IntVector chipNo2palette_pos(int chipNo)
in
{
static if(true)
{
assert(0 <= chipNo && chipNo < this.paletteWidthChipNum * this.paletteHeightChipNum);
}
else
{
assert(0 <= chipNo && chipNo < this.paletteWidthChipNum * this.paletteHeightChipNum,to!(string)(chipNo));
}

}
body
{
return IntVector(this.chipNo2PaletteX(chipNo),this.chipNo2PaletteY(chipNo));
}

    const final nothrow pure int paletteXYChipNum2ChipNo(int xChipNum, int yChipNum)
in
{
assert(this.inPaletteChipNum(xChipNum,yChipNum));
}
out(res)
{
auto xx = this.chipNo2PaletteXChipNum(res);
static if(true)
{
assert(xx == xChipNum);
}
else
{
assert(xx == xChipNum,"x  " ~ to!(string)(xx) ~ " and " ~ to!(string)(xChipNum));
}

auto yy = this.chipNo2PaletteYChipNum(res);
static if(true)
{
assert(yy == yChipNum);
}
else
{
assert(yy == yChipNum,"y  " ~ to!(string)(yy) ~ " and " ~ to!(string)(yChipNum));
}

}
body
{
return xChipNum + yChipNum * this.paletteWidthChipNum;
}

    int opApply(int delegate(ref int, ref int, T) dg)
{
int result = 0;
{
for (int iycn = 0;
 iycn < this.mapHeightChipNum; iycn++)
{
{
{
for (int ixcn = 0;
 ixcn < this.mapWidthChipNum; ixcn++)
{
{
result = dg(ixcn,iycn,this.chipId(ixcn,iycn));
if (result)
{
break;
}
}
}
}
}
}
}
return result;
}
    int opApplyReverse(int delegate(ref int, ref int, T) dg)
{
int result = 0;
{
for (int iycn = 0;
 iycn < this.mapHeightChipNum; iycn++)
{
{
{
for (int ixcn = 0;
 ixcn < this.mapWidthChipNum; ixcn++)
{
{
result = dg(ixcn,iycn,this.chipId(this.mapWidthChipNum - ixcn - 1,this.mapHeightChipNum - iycn - 1));
if (result)
{
break;
}
}
}
}
}
}
}
return result;
}
}
}
}
}

typedef uint ChipId;
class FmfMapLayer : MapLayer!(ChipId)
{
    private 
{
    CFmfMap fm;
    ubyte layer;
    Surface _chipSurface;
    ChipId _defaultChip;
    bool _drawDefaultChip;
    public 
{
    this(CFmfMap fm, Surface chipSurface, ubyte layer)
{
auto bc = fm.GetLayerBitCount;
auto chip_size = bc == 8 ? 16 : bc == 16 ? 256 : 0;
super(fm.GetChipWidth,fm.GetChipHeight,fm.GetMapWidth,fm.GetMapHeight,chip_size,chip_size);
this.fm = fm;
this.layer = layer;
this._chipSurface = chipSurface;
this.defaultChip = 0;
this.drawDefaultChip = true;
}
    void defaultChip(ChipId val)
{
this._defaultChip = val;
}
    const nothrow pure ChipId defaultChip()
{
return this._defaultChip;
}

    const nothrow pure bool drawDefaultChip()
{
return this._drawDefaultChip;
}

    void drawDefaultChip(bool val)
{
this._drawDefaultChip = val;
}
    const override nothrow pure ChipId chipId(int xChipNum, int yChipNum);

    const nothrow pure uint chip(int xChipNum, int yChipNum);

    override void setChip(int x, int y, ChipId chip)
{
;
}

    override void draw(Drawer drawer, Rect dest, int x, int y, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255));

    void draw(Drawer drawer, int x, int y, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255))
{
Rect r = rect(0,0,drawer.screen.width,drawer.screen.height);
this.draw(drawer,r,x,y,blendMode,blendParam,bright);
}
    void drawLine(Drawer drawer, Color color, Rect dest, int x, int y, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255));
    void drawLine(Drawer drawer, Color color, int x, int y, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255))
{
Rect r = rect(0,0,drawer.screen.width,drawer.screen.height);
this.drawLine(drawer,color,r,x,y,blendMode,blendParam,bright);
}
    const nothrow pure Surface chipSurface()
{
return cast(Surface)this._chipSurface;
}

}
}
}
FmfMapLayer loadFmfMapLayer(string path, string surface_path, ubyte layer)
{
byte[] buf;
int dxfp = dx_FileRead_open(toWStringz(path));
int size = dx_FileRead_size(toWStringz(path));
buf.length = size;
dx_FileRead_read(buf.ptr,size,dxfp);
dx_FileRead_close(dxfp);
auto fm = new CFmfMap(buf);
auto sur = loadSurface(surface_path);
auto res = new FmfMapLayer(fm,sur,layer);
return res;
}
FmfMapLayer[] loadFmfMapLayers(string path, string surface_path);
version (none)
{
    template TestMapLayerBase(T)
{
class TestMapLayerBase : MapLayer!(T)
{
    this()
{
super(16,16,20,20,16,16);
}
}
}
    class TestMapLayer : TestMapLayerBase!(int)
{
    this()
{
super();
}
    override int chip(int x, int y)
{
return 0;
}

    override void setChip(int x, int y, int chip)
{
writeln("set chip");
}

    override void draw(Drawer drawer, Rect dest, int x, int y)
{
}

}
    class TestMapThroughLayer : TestMapLayerBase!(bool)
{
    this()
{
super();
}
    const override nothrow pure bool chip(int x, int y)
{
return true;
}

    override void setChip(int x, int y, bool chip)
{
writeln("set chip");
}

    override void draw(Drawer drawer, Rect dest, int x, int y)
{
}

}
}
