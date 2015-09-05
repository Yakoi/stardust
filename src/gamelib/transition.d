module gamelib.transition;

import gamelib.all;

/// トランジション
/// ベースクラス
class Transition{
    Screen _screen;
    this(Screen screen){
        this._screen = screen;
    }
    /// 描画
    /// Params:
    ///     drawer = いつもの
    ///     par = 割合 0で変化前，1で変化後の状態
    ///     bright = 色
    abstract void draw(Drawer drawer, double par, Color bright = WHITE);
    /// drawのparをintで指定
    void draw(Drawer drawer, int par, int max, Color bright = WHITE){
        this.draw(drawer, cast(double)par/max, bright);
    }
}

////////////////////////////////////////////////////
/// WipeTransition で使う，ひとつのタイル(ブロック)をどのように描画するかを表すクラス
class TileDrawer{
    /// 描画．0の時は元画像，1のときはcolorで塗りつぶされた状態になることが想定されている
    abstract void draw(Drawer drawer,double par, Color color,  Rect rect);
}
/// フェード
class FadeTileDrawer : TileDrawer{
    override void draw(Drawer drawer,double par, Color color,  Rect rect){
        drawer.rect(color, rect, true, BlendMode.ALPHA, cast(int)(255*par));
    }
}
/// 内側から広がる四角
class UnboxTileDrawer : TileDrawer{
    override void draw(Drawer drawer,double par, Color color,  Rect rect){
        drawer.rect(color, rect*par, true);
    }
}
/// 外側から広がる四角
class BoxTileDrawer : TileDrawer{
    override void draw(Drawer drawer,double par, Color color,  Rect rect){
        Rect r = rect*(1-par);
        drawer.box(color, rect.left, rect.top, r.left, rect.bottom, true);
        drawer.box(color, r.right, rect.top, rect.right, rect.bottom, true);
        drawer.box(color, r.left, rect.top, r.right, r.top, true);
        drawer.box(color, r.left, rect.bottom, r.right, r.bottom, true);
    }
}
/// 内側から広がる円
class CircleTileDrawer : TileDrawer{
    override void draw(Drawer drawer,double par, Color color,  Rect rect){
        double radius = sqrt(cast(double)(rect.width*rect.width + rect.height*rect.height))*par/2;
        drawer.circle(color, rect.cx, rect.cy, cast(int)radius, true);
    }
}
/// 上下左右に塗りつぶしていく
class DirectTileDrawer : TileDrawer{
    Direction8 _dir8;
    this(Direction8 dir8){
        this._dir8 = dir8;
    }
    override void draw(Drawer drawer,double par, Color color,  Rect rect){
        with(Direction8)final switch(this._dir8){
        case L:
            drawer.rect(color, rect.left+cast(int)(rect.width*(1-par)), rect.top, cast(int)(rect.width*par), rect.height, true);
            break;
        case R:
            drawer.rect(color, rect.left, rect.top, cast(int)(rect.width*par), rect.height, true);
            break;
        case T:
            drawer.rect(color, rect.left, rect.top+cast(int)(rect.height*(1-par)), rect.width, cast(int)(rect.height*par), true);
            break;
        case B:
            drawer.rect(color, rect.left, rect.top, rect.width, cast(int)(rect.height*par), true);
            break;
        case BR:
            Vector cp = vecpos(rect.left, rect.top);
            Vector p1 = cp + vecpos(rect.width, 0          )*par*2;
            Vector p2 = cp + vecpos(0         , rect.height)*par*2;
            drawer.triangle(color, cp, p1, p2, true);
            break;
        case TL:
            Vector cp = vecpos(rect.right, rect.bottom);
            Vector p1 = cp - vecpos(rect.width, 0          )*par*2;
            Vector p2 = cp - vecpos(0         , rect.height)*par*2;
            drawer.triangle(color, cp, p1, p2, true);
            break;
        case TR:
            Vector cp = vecpos(rect.left, rect.bottom);
            Vector p1 = cp + vecpos(rect.width, 0          )*par*2;
            Vector p2 = cp - vecpos(0         , rect.height)*par*2;
            drawer.triangle(color, cp, p1, p2, true);
            break;
        case BL:
            Vector cp = vecpos(rect.right, rect.top);
            Vector p1 = cp - vecpos(rect.width, 0          )*par*2;
            Vector p2 = cp + vecpos(0         , rect.height)*par*2;
            drawer.triangle(color, cp, p1, p2, true);
            break;
        }
    }
}

/// ボツ
class TriangleTileDrawer : TileDrawer{
    override void draw(Drawer drawer,double par, Color color,  Rect rect){
        drawer.triangle(color, rect.left, rect.top,
                cast(int)(rect.left + rect.width*par), rect.top,
                rect.left, cast(int)(rect.top + rect.height*par), true);
        drawer.triangle(color, rect.right, rect.bottom,
                cast(int)(rect.right - rect.width*par), rect.bottom,
                rect.right, cast(int)(rect.bottom - rect.height*par), true);
    }
}
/// 
class CloseVerticalTileDrawer : TileDrawer{
    override void draw(Drawer drawer,double par, Color color,  Rect rect){
        drawer.rect(color, rect.left,
                rect.top, cast(int)(rect.width*par/2), rect.height, true);
        drawer.rect(color, cast(int)(rect.right-rect.width*par/2), rect.top,
                cast(int)(rect.width*par/2+1), rect.height, true);
    }
}
///
class OpenVerticalTileDrawer : TileDrawer{
    override void draw(Drawer drawer,double par, Color color,  Rect rect){
        drawer.rect(color, cast(int)(rect.left+rect.width/2 - rect.width*par/2), rect.top, cast(int)(rect.width*par), rect.height, true);
    }
}
/// 時計のようにくるりと回転
class RollingTileDrawer : TileDrawer{
    RotationDirection _rdir;
    int _num = 1;
    /// Params:
    ///     rdir = 回転方向
    ///     num  = 角度をいくつに分割するか
    this(RotationDirection rdir, int num=1){
        this._rdir = rdir;
        this._num = num;
    }
    int DIV = 6;
    override void draw(Drawer drawer,double par, Color color,  Rect rect){
        with(RotationDirection)final switch(this._rdir){
        case right:
            double angle = par*2*PI - PI/2;
            Vector c = vecpos(rect.cx, rect.cy);
            for(double a = - PI/2; a<angle; a+=PI/DIV){
                Vector pos1 = c + vecdir(min(a,angle), rect.width);
                Vector pos2 = c + vecdir(min(cast(double)(a+PI/DIV),angle), rect.width);
                drawer.triangle(color, c, pos1, pos2, true);
            }
            break;
        case left:
            Vector c = vecpos(rect.cx, rect.cy);
            for(int i=0; i<this._num; i++){
                double startAngle = -PI/2 - (2*PI/this._num)*i;
                double goalAngle = -PI/2 - (2*PI/this._num)*(i+par);
                for(double a = startAngle; a>goalAngle; a-=PI/DIV*this._num){
                    int l = (rect.width+rect.height)*100;
                    Vector pos1 = c + vecdir(max(a,goalAngle), l);
                    Vector pos2 = c + vecdir(max(cast(double)(a-PI/DIV*this._num*2),goalAngle), l);
                    drawer.triangle(color, c, pos1, pos2, true);
                }
            }
            break;
        }
    }
}

///////////////////////////////////////////////////////////////////////////////

class TileDiffusion{
    abstract double diffusion(double p, int x, int y, int xMax, int yMax);
}
class DirectTileDiffusion : TileDiffusion{
    Direction8 _dir8;
    double _n;
    this(Direction8 dir8, double n = 1){
        this._dir8 = dir8;
        this._n    = n;
    }
    override double diffusion(double p, int x, int y, int xMax, int yMax){
        with(Direction8)final switch(this._dir8){
        case L:
            double d = cast(double)(x)/xMax;
            return -1 + p*2 + d^^this._n;
        case R:
            double d = cast(double)(xMax-x)/xMax;
            return -1 + p*2 + d^^this._n;
        case T:
            double d = cast(double)(y)/yMax;
            return -1 + p*2 + d^^this._n;
        case B:
            double d = cast(double)(yMax-y)/yMax;
            return -1 + p*2 + d^^this._n;
        case TL:
            double d = cast(double)(x+y)/(xMax+yMax);
            return -1 + p*2 + d^^this._n;
        case TR:
            double d = cast(double)(xMax-x+y)/(xMax+yMax);
            return -1 + p*2 + d^^this._n;
        case BR:
            double d = cast(double)(xMax-x+yMax-y)/(xMax+yMax);
            return -1 + p*2 + d^^this._n;
        case BL:
            double d = cast(double)(x+yMax-y)/(xMax+yMax);
            return -1 + p*2 + d^^this._n;
        }
    }
}
class Direct2_TileDiffusion : TileDiffusion{
    Direction4 _dir4;
    this(Direction4 dir4){
        this._dir4 = dir4;
    }
    override double diffusion(double p, int x, int y, int xMax, int yMax){
        with(Direction4)final switch(this._dir4){
        case R:
            Vector cpos = vecpos(0, yMax/2);
            double len     = (vecpos(x,y)-cpos).length;
            double lenMax = sqrt(cast(double)(xMax)*(xMax) + (yMax/2)*(yMax/2));
            double d = 1-len/lenMax;
            return -1 + p*2 + d;
        case L:
            Vector cpos = vecpos(xMax, yMax/2);
            double len     = (vecpos(x,y)-cpos).length;
            double lenMax = sqrt(cast(double)(xMax)*(xMax) + (yMax/2)*(yMax/2));
            double d = 1-len/lenMax;
            return -1 + p*2 + d;
        case T:
            Vector cpos = vecpos(xMax/2, 0);
            double len     = (vecpos(x,y)-cpos).length;
            double lenMax = sqrt(cast(double)(xMax/2)*(xMax/2) + (yMax)*(yMax));
            double d = 1-len/lenMax;
            return -1 + p*2 + d;
        case B:
            Vector cpos = vecpos(xMax/2, yMax);
            double len     = (vecpos(x,y)-cpos).length;
            double lenMax = sqrt(cast(double)(xMax/2)*(xMax/2) + (yMax)*(yMax));
            double d = 1-len/lenMax;
            return -1 + p*2 + d;
        }
    }
}
/// 外側に向かっていく円
class CircleOutTileDiffusion : TileDiffusion{
    override double diffusion(double p, int x, int y, int xMax, int yMax){
        int len2     = (x-xMax/2)*(x-xMax/2) + (y-yMax/2)*(y-yMax/2);
        int len2Max = (xMax/2)*(xMax/2)   + (yMax/2)*(yMax/2);
        double d = 1-cast(double)(sqrt(cast(real)len2))/sqrt(cast(real)len2Max);
        return -1 + p*2 + d;
    }
}
/// 内側に向かっていく円
class CircleInTileDiffusion : TileDiffusion{
    override double diffusion(double p, int x, int y, int xMax, int yMax){
        int len2     = (x-xMax/2)*(x-xMax/2) + (y-yMax/2)*(y-yMax/2);
        int len2Max = (xMax/2)*(xMax/2)   + (yMax/2)*(yMax/2);
        double d = cast(double)(sqrt(cast(real)len2))/sqrt(cast(real)len2Max);
        return -1 + p*2 + d;
    }
}
/// プレーン
class PlainTileDiffusion : TileDiffusion{
    override double diffusion(double p, int x, int y, int xMax, int yMax){
        return p;
    }
}


///////////////////////////////////////////////////////////////////////////////


class TileWipeTransition : WipeTransition{
    int _w,_h;
    TileDrawer _tileDrawer1;
    TileDrawer _tileDrawer2;
    TileDiffusion _tileDiffusion;
    this(Screen screen,TileDrawer tileDrawer, TileDiffusion tileDiffusion,
            int w, int h,  double waitTime, double turnTime){
        this(screen, tileDrawer, tileDrawer, tileDiffusion, w, h, waitTime, turnTime);
    }
    this(Screen screen, TileDrawer tileDrawer1, TileDrawer tileDrawer2, TileDiffusion tileDiffusion,
            int w, int h,  double waitTime, double turnTime){
        super(screen, waitTime, turnTime);
        this._w = w;
        this._h = h;
        this._tileDrawer1 = tileDrawer1;
        this._tileDrawer2 = tileDrawer2;
        this._tileDiffusion = tileDiffusion;
    }
    this(Screen screen,TileDrawer tileDrawer, double waitTime, double turnTime){
        this(screen, tileDrawer, tileDrawer, new PlainTileDiffusion, screen.width, screen.width, waitTime, turnTime);
    }
    override void _draw(Drawer drawer, double par, Color color = WHITE)
    in{
        assert(0<=par);
        assert(par<=1);
    }body{
        int xMax = this._screen.width/this._w+1;
        int yMax = this._screen.height/this._h+1;
        for(int ix=0; ix<xMax; ix++){
            for(int iy=0; iy<yMax; iy++){
                double p = this._tileDiffusion.diffusion(par, ix, iy, xMax, yMax);
                if(p<0){continue;}
                Rect r = rect(ix*this._w, iy*this._h, this._w, this._h);
                drawer.drawArea(r);
                if(p>1){drawer.rect(color, r, true);continue;}
                if((ix+iy)%2==0){
                    this._tileDrawer1.draw(drawer, p, color, r);
                }else{
                    this._tileDrawer2.draw(drawer, p, color, r);
                }
            }
        }
        drawer.clearDrawArea();
    }
}

TileWipeTransition allWipeTransition(Screen screen, TileDrawer td,
        double waitTime, double turnTime){
    return new TileWipeTransition(screen,  td, waitTime, turnTime);
}
TileWipeTransition tileWipeTransition(Screen screen, TileDrawer td, TileDiffusion tdf,
        int w, int h, double waitTime, double turnTime){
    return new TileWipeTransition(screen,  td, tdf, w, h, waitTime, turnTime);
}
TileWipeTransition tile2WipeTransition(Screen screen, TileDrawer td1, TileDrawer td2, TileDiffusion tdf,
        int w, int h, double waitTime, double turnTime){
    return new TileWipeTransition(screen, td1, td2, tdf, w, h, waitTime, turnTime);
}
TileWipeTransition horizonWipeTransition(Screen screen, TileDrawer td, TileDiffusion tdf,
        int h, double waitTime, double turnTime){
    return new TileWipeTransition(screen, td, tdf, screen.width, h, waitTime, turnTime);
}
TileWipeTransition horizonWipeTransition(Screen screen,
        TileDrawer td1, TileDrawer td2, TileDiffusion tdf,
        int h, double waitTime, double turnTime){
    return new TileWipeTransition(screen, td1, td2, tdf, screen.width, h, waitTime, turnTime);
}
TileWipeTransition verticalWipeTransition(Screen screen, TileDrawer td, TileDiffusion tdf,
        int w, double waitTime, double turnTime){
    return new TileWipeTransition(screen, td, tdf, w, screen.height, waitTime, turnTime);
}














/// 色一食になるフェード
/// 処理はフェード前の場面
class WipeTransition : Transition{
    double _turnTime = 0.5;
    double _waitTime = 0.0;
    this(Screen screen, double waitTime, double turnTime)
    in{
        assert(0.0 <= turnTime);
        assert(turnTime <= 1.0);
    }body{
        super(screen);
        this._turnTime = turnTime;
        this._waitTime = waitTime;
    }
    protected abstract void _draw(Drawer drawer, double par, Color bright = WHITE);
    double par(double p){
        if(p < 0.0 || p >= 1.0){
            return 0;
        } else if(p < turnTime - waitTime/2){
            double len = turnTime - waitTime/2;
            return 1-(len - p)/len;
        } else if(p < turnTime + waitTime/2){
            return 1;
        } else{
            double len = 1-(turnTime + waitTime/2);
            return 1-(p-(turnTime + waitTime/2))/len;
        }
    }
    double par(int p, int pmax){
        return par(cast(double)p/pmax);
    }
    override void draw(Drawer drawer, double par, Color bright = WHITE){
        if(par < 0.0 || par >= 1.0){return;}
        if(par < turnTime - waitTime/2){
            double len = turnTime - waitTime/2;
            this._draw(drawer, 1-(len - par)/len, bright);
        }else if(par < turnTime + waitTime/2){
            this._draw(drawer, 1, bright);
        }else{
            double len = 1-(turnTime + waitTime/2);
            this._draw(drawer, 1-(par-(turnTime + waitTime/2))/len, bright);
        }
    }
    override void draw(Drawer drawer, int par, int max, Color bright = WHITE){
        this.draw(drawer, cast(double)par/max, bright);
    }
    /+
    final void draw(Drawer drawer, int par, int mid, int max, Color bright = WHITE){
        if(par < max*this.turnTime){
            this.draw(drawer, cast(double)par/max, bright);
        }else if(par < max*this.turnTime + mid){
            this.draw(drawer, this.turnTime, bright);
        }else{
            this.draw(drawer, cast(double)(par-mid)/max, bright);
        }
    }
    +/
    bool waiting(int par, int max){
        return par == cast(int)(max * this._turnTime);
    }
    bool fading(int par, int max){
        return 0<=par && par <= max;
    }
    /+
    bool is_turnTime(int par, int mid, int max){
        if(par < max*this.turnTime){
            return par == cast(int)(max * this._turnTime);
        }else if(par < max*this.turnTime + mid){
            return true;
        }else{
            return par-mid == cast(int)(max * this._turnTime);
        }
    }
    +/
    double turnTime(){
        return this._turnTime;
    }
    double waitTime(){
        return this._waitTime;
    }
    WipeTransition opAdd(WipeTransition f){
        assert(f.waitTime == this.waitTime);
        assert(f.turnTime == this.turnTime);
        return new AddTransition(this._screen, this, f, this.waitTime, this.turnTime);
    }
    WipeTransition opMul(WipeTransition f){
        return new MulTransition(this._screen, this, f, this.waitTime, this.turnTime);
    }
}
class AddTransition : WipeTransition{
    WipeTransition _fade1, _fade2;
    this(Screen screen, WipeTransition fade1, WipeTransition fade2,
            double waitTime=0.0, double turnTime=0.5){
        super(screen, waitTime, turnTime);
        this._fade1 = fade1;
        this._fade2 = fade2;
    }
    override void draw(Drawer drawer, double par, Color bright = WHITE){
        if(par < this.turnTime){
            this._fade1.draw(drawer,par,bright);
        }else{
            this._fade2.draw(drawer,par,bright);
        }
    }
    override void draw(Drawer drawer, int par, int max, Color bright = WHITE){
        this.draw(drawer, cast(double)par/max, bright);
    }
    override void _draw(Drawer drawer, double par, Color color = WHITE){
        assert(false);
    }
}
class MulTransition : WipeTransition{
    WipeTransition _fade1, _fade2;
    this(Screen screen, WipeTransition fade1, WipeTransition fade2,
            double waitTime=0.0, double turnTime=0.5){
        super(screen, waitTime, turnTime);
        this._fade1 = fade1;
        this._fade2 = fade2;
    }
    override void draw(Drawer drawer, double par, Color bright = WHITE){
        this._fade1.draw(drawer,par,bright);
        this._fade2.draw(drawer,par,bright);
    }
    override void draw(Drawer drawer, int par, int max, Color bright = WHITE){
        this.draw(drawer, cast(double)par/max, bright);
    }
    override void _draw(Drawer drawer, double par, Color color = WHITE){
        assert(false);
    }
}

class RollingTransition : WipeTransition{
    int y_diff = 2;
    int _num = 20;
    RotationDirection _rotationDirection;
    this(Screen screen, RotationDirection rd, double waitTime=0.0, double turnTime=0.5){
        super(screen, waitTime, turnTime);
        this._rotationDirection = rd;
    }
    override void _draw(Drawer drawer, double par, Color color = WHITE)
    in{
        assert(0<=par);
        assert(par<=1);
    }body{
        if(par >= 1.0){
            drawer.fill(color);
            return;
        }
        with(RotationDirection)final switch(this._rotationDirection){
        case right:
            double angle = par*2*PI - PI/2;
            Screen sc = this._screen;
            Vector c = vecpos(sc.cx, sc.cy);
            for(double a = - PI/2; a<angle; a+=PI/10){
                Vector pos1 = c + vecdir(min(a,angle), sc.width);
                Vector pos2 = c + vecdir(min(cast(double)(a+PI/10),angle), sc.width);
                drawer.triangle(color, c, pos1, pos2, true);
            }
            break;
        case left:
            Screen sc = this._screen;
            Vector c = vecpos(sc.cx, sc.cy);
            for(int i=0; i<this._num; i++){
                double startAngle = -PI/2 - (2*PI/this._num)*i;
                double goalAngle = -PI/2 - (2*PI/this._num)*(i+par);
                for(double a = startAngle; a>goalAngle; a-=PI/10){
                    Vector pos1 = c + vecdir(max(a,goalAngle), sc.width+sc.height);
                    Vector pos2 = c + vecdir(max(cast(double)(a-PI/10*2),goalAngle), sc.width);
                    drawer.triangle(color, c, pos1, pos2, true);
                }
            }
            break;
        }
    }
}
///////////////////////////////////////////////////////////////////////////////////////////
/// 古いサーフェイスを指定してフェード
/// 処理はフェード後の場面
class SurfaceTransition : Transition{
    static Surface _preSurface = null;
    this(Screen screen){
        super(screen);
        if(_preSurface is null){
            this._preSurface = new Surface(screen.rect);
        }
    }
    void copyScreen(){
        this._screen.copyScreen(this._preSurface);
    }
    override abstract void draw(Drawer drawer, double par, Color bright = WHITE);
}

class CrossFade : SurfaceTransition{
    this(Screen screen){
        super(screen);
    }
    override void draw(Drawer drawer, double par, Color bright = WHITE){
        if(par>=1.0){return;}
        par = max(0.0, par);
        drawer.surface(this._preSurface, vecpos(0,0),
                BlendMode.ALPHA, cast(int)((1-par)*255), bright);
    }
}
class BlendTransition : SurfaceTransition{
    BlendSurface _blendSurface;
    BorderRange _borderRange;
    this(Screen screen, BlendSurface bs, BorderRange borderRange = BorderRange.BORDER64){
        super(screen);
        this._blendSurface = bs;
        this._borderRange = borderRange;
    }
    override void draw(Drawer drawer, double par, Color bright = WHITE){
        if(par>=1.0){return;}
        par = max(0.0, par);
        //drawer.blendSurface(this._blendSurface, (1-par));
        //drawer.surface(this._preSurface, vecpos(0,0));
        //drawer.clear_blendSurface();
        drawer.blend(0,0,this._preSurface,false,this._blendSurface,par, this._borderRange);
    }
}


class FadeTable{

}
