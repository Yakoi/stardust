// D import file generated from 'gamelib\transition.d'
module gamelib.transition;
import gamelib.all;
class Transition
{
    Screen _screen;
    this(Screen screen)
{
this._screen = screen;
}
    abstract void draw(Drawer drawer, double par, Color bright = WHITE);

    void draw(Drawer drawer, int par, int max, Color bright = WHITE)
{
this.draw(drawer,cast(double)par / max,bright);
}
}
class TileDrawer
{
    abstract void draw(Drawer drawer, double par, Color color, Rect rect);

}
class FadeTileDrawer : TileDrawer
{
    override void draw(Drawer drawer, double par, Color color, Rect rect)
{
drawer.rect(color,rect,true,BlendMode.ALPHA,cast(int)(255 * par));
}

}
class UnboxTileDrawer : TileDrawer
{
    override void draw(Drawer drawer, double par, Color color, Rect rect)
{
drawer.rect(color,rect * par,true);
}

}
class BoxTileDrawer : TileDrawer
{
    override void draw(Drawer drawer, double par, Color color, Rect rect)
{
Rect r = rect * (1 - par);
drawer.box(color,rect.left,rect.top,r.left,rect.bottom,true);
drawer.box(color,r.right,rect.top,rect.right,rect.bottom,true);
drawer.box(color,r.left,rect.top,r.right,r.top,true);
drawer.box(color,r.left,rect.bottom,r.right,r.bottom,true);
}

}
class CircleTileDrawer : TileDrawer
{
    override void draw(Drawer drawer, double par, Color color, Rect rect)
{
double radius = sqrt(cast(double)(rect.width * rect.width + rect.height * rect.height)) * par / 2;
drawer.circle(color,rect.cx,rect.cy,cast(int)radius,true);
}

}
class DirectTileDrawer : TileDrawer
{
    Direction8 _dir8;
    this(Direction8 dir8)
{
this._dir8 = dir8;
}
    override void draw(Drawer drawer, double par, Color color, Rect rect);

}
class TriangleTileDrawer : TileDrawer
{
    override void draw(Drawer drawer, double par, Color color, Rect rect)
{
drawer.triangle(color,rect.left,rect.top,cast(int)(rect.left + rect.width * par),rect.top,rect.left,cast(int)(rect.top + rect.height * par),true);
drawer.triangle(color,rect.right,rect.bottom,cast(int)(rect.right - rect.width * par),rect.bottom,rect.right,cast(int)(rect.bottom - rect.height * par),true);
}

}
class CloseVerticalTileDrawer : TileDrawer
{
    override void draw(Drawer drawer, double par, Color color, Rect rect)
{
drawer.rect(color,rect.left,rect.top,cast(int)(rect.width * par / 2),rect.height,true);
drawer.rect(color,cast(int)(rect.right - rect.width * par / 2),rect.top,cast(int)(rect.width * par / 2 + 1),rect.height,true);
}

}
class OpenVerticalTileDrawer : TileDrawer
{
    override void draw(Drawer drawer, double par, Color color, Rect rect)
{
drawer.rect(color,cast(int)(rect.left + rect.width / 2 - rect.width * par / 2),rect.top,cast(int)(rect.width * par),rect.height,true);
}

}
class RollingTileDrawer : TileDrawer
{
    RotationDirection _rdir;
    int _num = 1;
    this(RotationDirection rdir, int num = 1)
{
this._rdir = rdir;
this._num = num;
}
    int DIV = 6;
    override void draw(Drawer drawer, double par, Color color, Rect rect);

}
class TileDiffusion
{
    abstract double diffusion(double p, int x, int y, int xMax, int yMax);

}
class DirectTileDiffusion : TileDiffusion
{
    Direction8 _dir8;
    double _n;
    this(Direction8 dir8, double n = 1)
{
this._dir8 = dir8;
this._n = n;
}
    override double diffusion(double p, int x, int y, int xMax, int yMax);

}
class Direct2_TileDiffusion : TileDiffusion
{
    Direction4 _dir4;
    this(Direction4 dir4)
{
this._dir4 = dir4;
}
    override double diffusion(double p, int x, int y, int xMax, int yMax);

}
class CircleOutTileDiffusion : TileDiffusion
{
    override double diffusion(double p, int x, int y, int xMax, int yMax)
{
int len2 = (x - xMax / 2) * (x - xMax / 2) + (y - yMax / 2) * (y - yMax / 2);
int len2Max = xMax / 2 * (xMax / 2) + yMax / 2 * (yMax / 2);
double d = 1 - cast(double)sqrt(cast(real)len2) / sqrt(cast(real)len2Max);
return -1 + p * 2 + d;
}

}
class CircleInTileDiffusion : TileDiffusion
{
    override double diffusion(double p, int x, int y, int xMax, int yMax)
{
int len2 = (x - xMax / 2) * (x - xMax / 2) + (y - yMax / 2) * (y - yMax / 2);
int len2Max = xMax / 2 * (xMax / 2) + yMax / 2 * (yMax / 2);
double d = cast(double)sqrt(cast(real)len2) / sqrt(cast(real)len2Max);
return -1 + p * 2 + d;
}

}
class PlainTileDiffusion : TileDiffusion
{
    override double diffusion(double p, int x, int y, int xMax, int yMax)
{
return p;
}

}
class TileWipeTransition : WipeTransition
{
    int _w;
    int _h;
    TileDrawer _tileDrawer1;
    TileDrawer _tileDrawer2;
    TileDiffusion _tileDiffusion;
    this(Screen screen, TileDrawer tileDrawer, TileDiffusion tileDiffusion, int w, int h, double waitTime, double turnTime)
{
this(screen,tileDrawer,tileDrawer,tileDiffusion,w,h,waitTime,turnTime);
}
    this(Screen screen, TileDrawer tileDrawer1, TileDrawer tileDrawer2, TileDiffusion tileDiffusion, int w, int h, double waitTime, double turnTime)
{
super(screen,waitTime,turnTime);
this._w = w;
this._h = h;
this._tileDrawer1 = tileDrawer1;
this._tileDrawer2 = tileDrawer2;
this._tileDiffusion = tileDiffusion;
}
    this(Screen screen, TileDrawer tileDrawer, double waitTime, double turnTime)
{
this(screen,tileDrawer,tileDrawer,new PlainTileDiffusion,screen.width,screen.width,waitTime,turnTime);
}
    override void _draw(Drawer drawer, double par, Color color = WHITE);

}
TileWipeTransition allWipeTransition(Screen screen, TileDrawer td, double waitTime, double turnTime)
{
return new TileWipeTransition(screen,td,waitTime,turnTime);
}
TileWipeTransition tileWipeTransition(Screen screen, TileDrawer td, TileDiffusion tdf, int w, int h, double waitTime, double turnTime)
{
return new TileWipeTransition(screen,td,tdf,w,h,waitTime,turnTime);
}
TileWipeTransition tile2WipeTransition(Screen screen, TileDrawer td1, TileDrawer td2, TileDiffusion tdf, int w, int h, double waitTime, double turnTime)
{
return new TileWipeTransition(screen,td1,td2,tdf,w,h,waitTime,turnTime);
}
TileWipeTransition horizonWipeTransition(Screen screen, TileDrawer td, TileDiffusion tdf, int h, double waitTime, double turnTime)
{
return new TileWipeTransition(screen,td,tdf,screen.width,h,waitTime,turnTime);
}
TileWipeTransition horizonWipeTransition(Screen screen, TileDrawer td1, TileDrawer td2, TileDiffusion tdf, int h, double waitTime, double turnTime)
{
return new TileWipeTransition(screen,td1,td2,tdf,screen.width,h,waitTime,turnTime);
}
TileWipeTransition verticalWipeTransition(Screen screen, TileDrawer td, TileDiffusion tdf, int w, double waitTime, double turnTime)
{
return new TileWipeTransition(screen,td,tdf,w,screen.height,waitTime,turnTime);
}
class WipeTransition : Transition
{
    double _turnTime = 0.5;
    double _waitTime = 0;
    this(Screen screen, double waitTime, double turnTime)
in
{
assert(0 <= turnTime);
assert(turnTime <= 1);
}
body
{
super(screen);
this._turnTime = turnTime;
this._waitTime = waitTime;
}
    protected abstract void _draw(Drawer drawer, double par, Color bright = WHITE);


    double par(double p);
    double par(int p, int pmax)
{
return par(cast(double)p / pmax);
}
    override void draw(Drawer drawer, double par, Color bright = WHITE);

    override void draw(Drawer drawer, int par, int max, Color bright = WHITE)
{
this.draw(drawer,cast(double)par / max,bright);
}

    bool waiting(int par, int max)
{
return par == cast(int)(max * this._turnTime);
}
    bool fading(int par, int max)
{
return 0 <= par && par <= max;
}
    double turnTime()
{
return this._turnTime;
}
    double waitTime()
{
return this._waitTime;
}
    WipeTransition opAdd(WipeTransition f)
{
assert(f.waitTime == this.waitTime);
assert(f.turnTime == this.turnTime);
return new AddTransition(this._screen,this,f,this.waitTime,this.turnTime);
}
    WipeTransition opMul(WipeTransition f)
{
return new MulTransition(this._screen,this,f,this.waitTime,this.turnTime);
}
}
class AddTransition : WipeTransition
{
    WipeTransition _fade1;
    WipeTransition _fade2;
    this(Screen screen, WipeTransition fade1, WipeTransition fade2, double waitTime = 0, double turnTime = 0.5)
{
super(screen,waitTime,turnTime);
this._fade1 = fade1;
this._fade2 = fade2;
}
    override void draw(Drawer drawer, double par, Color bright = WHITE);

    override void draw(Drawer drawer, int par, int max, Color bright = WHITE)
{
this.draw(drawer,cast(double)par / max,bright);
}

    override void _draw(Drawer drawer, double par, Color color = WHITE)
{
assert(false);
}

}
class MulTransition : WipeTransition
{
    WipeTransition _fade1;
    WipeTransition _fade2;
    this(Screen screen, WipeTransition fade1, WipeTransition fade2, double waitTime = 0, double turnTime = 0.5)
{
super(screen,waitTime,turnTime);
this._fade1 = fade1;
this._fade2 = fade2;
}
    override void draw(Drawer drawer, double par, Color bright = WHITE)
{
this._fade1.draw(drawer,par,bright);
this._fade2.draw(drawer,par,bright);
}

    override void draw(Drawer drawer, int par, int max, Color bright = WHITE)
{
this.draw(drawer,cast(double)par / max,bright);
}

    override void _draw(Drawer drawer, double par, Color color = WHITE)
{
assert(false);
}

}
class RollingTransition : WipeTransition
{
    int y_diff = 2;
    int _num = 20;
    RotationDirection _rotationDirection;
    this(Screen screen, RotationDirection rd, double waitTime = 0, double turnTime = 0.5)
{
super(screen,waitTime,turnTime);
this._rotationDirection = rd;
}
    override void _draw(Drawer drawer, double par, Color color = WHITE);

}
class SurfaceTransition : Transition
{
    static Surface _preSurface = null;

    this(Screen screen);
    void copyScreen()
{
this._screen.copyScreen(this._preSurface);
}
    abstract override void draw(Drawer drawer, double par, Color bright = WHITE);

}
class CrossFade : SurfaceTransition
{
    this(Screen screen)
{
super(screen);
}
    override void draw(Drawer drawer, double par, Color bright = WHITE);

}
class BlendTransition : SurfaceTransition
{
    BlendSurface _blendSurface;
    BorderRange _borderRange;
    this(Screen screen, BlendSurface bs, BorderRange borderRange = BorderRange.BORDER64)
{
super(screen);
this._blendSurface = bs;
this._borderRange = borderRange;
}
    override void draw(Drawer drawer, double par, Color bright = WHITE);

}
class FadeTable
{
}
