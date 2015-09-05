// D import file generated from 'gamelib\screen.d'
module gamelib.screen;
import gamelib.all;
import dxlib.all;
import std.stdio;
import std.conv;
package class Screen
{
    protected 
{
    GameSystem _game;
    package 
{
    this(GameSystem game)
{
this._game = game;
}
    bool _emulation320x240 = false;
    public 
{
    package const void waitVsync(bool val)
{
dx_SetWaitVSyncFlag(val);
}


    const int width();

    const int height();

    const Rect rect()
{
return mylib.rect.rect(0,0,this.width,this.height);
}

    const int bitDepth()
{
return dx_GetScreenBitDepth();
}

    const bool waitVsync()
{
return 0 != dx_GetWaitVSyncFlag();
}

    const int colorBitDepth()
{
return dx_GetColorBitDepth();
}

    void graphMode(int width, int height, int depth = 32, int n = 60)
in
{
assert(width > 0);
assert(height > 0);
assert(depth > 0);
assert(n > 0);
}
body
{
dx_SetGraphMode(width,height,depth,n);
}
    void emulation320x240(bool val)
{
dx_SetEmulation320x240(val);
this._emulation320x240 = val;
}
    const pure bool emulation320x240()
{
return this._emulation320x240;
}

    void saveToBmp(string path, Rect rect)
{
dx_SaveDrawScreenToBMP(rect.left,rect.top,rect.right,rect.bottom,toWStringz(path));
}
    void saveToBmp(string path)
{
this.saveToBmp(path,this.rect);
}
    void saveToPng(string path, Rect rect, int compressionLevel = -1)
{
dx_SaveDrawScreenToPNG(rect.left,rect.top,rect.right,rect.bottom,toWStringz(path),compressionLevel);
}
    void saveToPng(string path, int compressionLevel = -1)
{
this.saveToPng(path,this.rect,compressionLevel);
}
    void saveToJpg(string path, Rect rect, int quality = 80, bool sample2x1 = true)
{
dx_SaveDrawScreenToJPEG(rect.left,rect.top,rect.right,rect.bottom,toWStringz(path),quality,sample2x1);
}
    void saveToJpg(string path, int quality = 80, bool sample2x1 = true)
{
this.saveToJpg(path,this.rect,quality,sample2x1);
}
    alias saveToJpg saveToJpeg;
    Color pixel(int x, int y)
{
int dxcol = dx_GetPixel(x,y);
int r,g,b;
dx_GetColor2(dxcol,&r,&g,&b);
return col(r,g,b);
}
    Color pixel(IntVector pos)
{
return pixel(pos.x,pos.y);
}
    Color pixel(Vector pos)
{
return pixel(cast(int)pos.x,cast(int)pos.y);
}
    Color opIndex(int x, int y)
{
return this.pixel(x,y);
}
    const pure int left()
{
return 0;
}

    const pure int top()
{
return 0;
}

    const int right()
{
return this.width;
}

    const int bottom()
{
return this.height;
}

    const int cx()
{
return this.width / 2;
}

    const int cy()
{
return this.height / 2;
}

    bool checkDisplayMode(int width, int height);
    bool checkDisplayMode();
    void copyScreen(Rect rect, ref Surface dest)
{
dx_GetDrawScreenGraph(rect.left,rect.top,rect.right,rect.bottom,dest.dxhandle,true);
}
    void copyScreen(ref Surface dest)
{
this.copyScreen(this.rect,dest);
}
}
}
}
}

