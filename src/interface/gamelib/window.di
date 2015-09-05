// D import file generated from 'gamelib\window.d'
module gamelib.window;
import gamelib.all;
import dxlib.all;
import std.stdio;
import std.conv;
class Window
{
    protected 
{
    bool _changeScreen = false;
    GameSystem _game;
    package 
{
    void changeScreen(bool val)
{
this._changeScreen = val;
}
    this(GameSystem game)
{
this._game = game;
}
    public 
{
    const void iconId(int val)
{
dx_SetWindowIconID(val);
}

    const void caption(string val)
{
dx_SetWindowText(toWStringz(val));
}

    const void caption(wstring val)
{
dx_SetWindowText(toWStringz(val));
}

    void fullScreen(bool val);
    const bool fullScreen()
{
return 0 != dx_GetChangeDisplayFlag();
}

    bool changeScreen();
    const void screenRate(double val)
in
{
assert(val > 0);
}
body
{
dx_SetWindowSizeExtendRate(val);
}

    void position(int x, int y)
{
dx_SetWindowInitPosition(x,y);
}
    const double screenRate()
{
return dx_GetWindowSizeExtendRate();
}

    const void dragFileValid(bool val)
{
dx_SetDragFileValidFlag(val);
}

    const void clearDragFileInfo()
{
dx_DragFileInfoClear();
}

    const wstring dragFilePath();

    const int dragFileNum()
{
return dx_GetDragFileNum();
}

    const bool active()
{
return 0 != dx_GetWindowActiveFlag();
}

    void changeWindowSizeButton(bool val);
    int x()
{
int x,y;
dx_GetWindowPosition(&x,&y);
return x;
}
    void x(int val)
{
dx_SetWindowPosition(val,this.y);
}
    int y()
{
int x,y;
dx_GetWindowPosition(&x,&y);
return y;
}
    void y(int val)
{
dx_SetWindowPosition(this.x,val);
}
    IntVector pos()
{
int x,y;
dx_GetWindowPosition(&x,&y);
return IntVector(x,y);
}
    void pos(int x, int y)
{
dx_SetWindowPosition(x,y);
}
    void pos(Vector val)
{
this.pos(cast(int)val.x,cast(int)val.y);
}
    void pos(IntVector val)
{
this.pos(val.x,val.y);
}
}
}
}
}
