module gameobj;

import all;

class Field{
    Rect rect;
    Area leftwall;
    Area rightwall;
    Area bottomwall;
    Area topwall;
    this(int width, int height, int cx, int bottom){
        int b = 240-bottom;
        rect = box(cx-width/2, b-height, cx+width/2, b );
        leftwall = new RectArea(rect.left, rect.top, 1, rect.height);
        rightwall = new RectArea(rect.right, rect.top, 1, rect.height);
        bottomwall = new RectArea(rect.left, rect.bottom, rect.width, 1);
        topwall = new RectArea(rect.left, rect.top, rect.width, 1);
    }
    this(){
        this(200, 200, 160, 20);
    }
}
class ShadowBar : Bar{
    int maxCount;
    int count = 0;
    bool enable;
    this(Vector center, int maxCount, bool isBig){
        this.pos = center;
        this.maxCount = maxCount;
        this.isBig = isBig;
        this.enable = true;
    }
    override void update(){
        if(this.count >= this.maxCount){
            this.enable = false;
        }
        this.count ++;
    }
    override bool draw(Drawer drawer, Vector pos = zerovec, double blend = 1.0){
        if(this.isBig){
            drawer.rect(WHITE, this.bigRect+this.pos, true , BlendMode.ALPHA, cast(int)(255*(maxCount-count)*blend/maxCount));
            drawer.rect(BLACK, this.bigRect+this.pos, false, BlendMode.ALPHA, cast(int)(255*(maxCount-count)*blend/maxCount));
        }else{
            drawer.rect(WHITE, this.rect+this.pos, true , BlendMode.ALPHA, cast(int)(255*(maxCount-count)*blend/maxCount));
            drawer.rect(BLACK, this.rect+this.pos, false, BlendMode.ALPHA, cast(int)(255*(maxCount-count)*blend/maxCount));
        }
        return true;
    }
}
class Bar : MoverPlus{
    Rect rect;
    Rect bigRect;
    Area _area;
    Area _bigArea;
    Area tapArea;
    bool visible = true;
    bool isBig = false;
    int tappingCount = 0;
    const int tappingCountMax = 60;
    int doubleDashNum = 0;
    this(){
        pos = vecpos(160,200);
        rect = mylib.rect.rect(40, 4);
        bigRect = mylib.rect.rect(80,6);
        _area = new RectArea(rect);
        _bigArea = new RectArea(bigRect);
        tapArea = new RectArea(rect.width, 200);
    }
    const pure override Area area(){
        return cast(Area)_area;
    }
    const pure Area bigArea(){
        return cast(Area)this._bigArea;
    }
    override FigureSet[] figureSet(){
        return null;
    }
    const pure override bool outOfScreen(Rect rect){
        return true;
    }
    void update(){
        this.tappingCount--;
    }
    override bool draw(Drawer drawer, Vector p = vecpos(0,0), double blend = 1.0){
        if(this.isBig){
            //巨大化時 未実装
            drawer.rect(WHITE, this.bigRect+this.pos, true, BlendMode.ALPHA, cast(int)(blend*255));
            drawer.rect(BLACK, this.bigRect+this.pos, false, BlendMode.ALPHA, cast(int)(blend*255));
            drawer.line(WHITE, this.bigRect.left , this.bigRect.top, this.bigRect.left , this.bigRect.top-100, 1, BlendMode.ALPHA, cast(int)(blend*255));
            drawer.line(WHITE, this.bigRect.right, this.bigRect.top, this.bigRect.right, this.bigRect.top-100, 1, BlendMode.ALPHA, cast(int)(blend*255));
        }else{
            if(doubleDashNum == 0){
                drawer.rect(WHITE, this.rect+this.pos, true, BlendMode.ALPHA, cast(int)(blend*255));
                drawer.rect(BLACK, this.rect+this.pos, false, BlendMode.ALPHA, cast(int)(blend*255));
            }else{
                drawer.rect(WHITE, this.rect+this.pos, true,  BlendMode.ALPHA, cast(int)(blend*255*0.5));
                drawer.rect(BLACK, this.rect+this.pos, false, BlendMode.ALPHA, cast(int)(blend*255*0.5));
            }
            int b = 100;
            int mx = 20;
            int l = 100;
            foreach(i; 0..mx){
                drawer.rect(WHITE,
                        box(this.rect.left +pos.x+1, this.rect.top+pos.y-(i+0)*l/mx,
                        this.rect.left +pos.x+1+1,   this.rect.top+pos.y-(i+1)*l/mx),
                        true, BlendMode.ADD, cast(int)(b*(mx-i)*blend/mx));
                drawer.rect(BLACK,
                        box(this.rect.left +pos.x, this.rect.top+pos.y-(i+0)*l/mx,
                        this.rect.left +pos.x+1,   this.rect.top+pos.y-(i+1)*l/mx),
                        true, BlendMode.MUL, cast(int)(b*(mx-i)*blend/mx));
                drawer.rect(WHITE,
                        box(this.rect.right +pos.x -2, this.rect.top+pos.y-(i+0)*l/mx,
                        this.rect.right +pos.x -2+1, this.rect.top+pos.y-(i+1)*l/mx),
                        true, BlendMode.ADD, cast(int)(b*(mx-i)*blend/mx));
                drawer.rect(BLACK,
                        box(this.rect.right +pos.x -1, this.rect.top+pos.y-(i+0)*l/mx,
                        this.rect.right +pos.x -1+1, this.rect.top+pos.y-(i+1)*l/mx),
                        true, BlendMode.MUL, cast(int)(b*(mx-i)*blend/mx));
            }
            if(this.tappingCount>0){
                foreach(i; 0..mx){
                    drawer.rect(WHITE,
                            box(this.rect.left +pos.x+1, this.rect.top+pos.y-(i+0)*l/mx,
                            this.rect.right +pos.x-2+1,   this.rect.top+pos.y-(i+1)*l/mx),
                            true, BlendMode.ADD, cast(int)(b*(mx-i)*blend/mx)*tappingCount/tappingCountMax);
                }
                drawer.rect(WHITE,
                        box(this.rect.left +pos.x+1, this.rect.top+pos.y,
                        this.rect.right +pos.x-2+1,   this.rect.top+pos.y-(tappingCountMax*6-tappingCount*6)*l/tappingCountMax),
                        true, BlendMode.ADD, max(cast(int)(b*blend)*(tappingCount-tappingCountMax*5/6)/tappingCountMax,0));
            }
        }
        return true;
    }
}
class Ball : MoverPlus{
    bool enable;
    bool gosky = false;
    int radius;
    Vector vel;
    Vector acc;
    Area _area;
    int boundCount = 0;
    int count = 0;
	int finishCount = 0;
    this(Vector pos){
        this.pos = pos;
        radius = 4;
        vel = vecpos(0,0);
        acc = vecpos(0,0.02);
        this._area = new CircleArea(radius);
        this.enable = true;
        this.gosky = false;
    }
    void update(){
        pos = pos + vel;
        vel = vel + acc;
        this.count++;
    }
    const pure override Area area(){
        return cast(Area)_area;
    }
    override FigureSet[] figureSet(){
        return null;
    }
    const pure override bool outOfScreen(Rect rect){
        return true;
    }
    void draw(State st, Drawer drawer, Vector pos=vecpos(0,0), double blend = 1.0){
        auto srand = new Rand(count);
        if(this.boundCount < 10){
            foreach(i; 0..5){
                drawer.circle(hsv(srand.i(0,360-1),srand.r(0.3,0.8), srand.r(0.9,1)),
                        this.pos+srand.v(1)+vecpos(0,srand.r(0,1)), this.radius-srand.i(0,1), true, BlendMode.SUB, cast(int)(32*3*blend));
            }
            foreach(i; 0..5){
                drawer.circle(hsv(srand.i(0,360-1),srand.r(0.3,0.8), srand.r(0.9,1)),
                        this.pos+srand.v(1)+vecpos(0,-srand.r(0,1)), this.radius-1, true, BlendMode.ADD, cast(int)(32*3*blend));
            }
                //drawer.circle(hsv(srand.i(50,60),srand.r(0,1), srand.r(0.4,0.5)),
                    //this.pos, this.radius, false, BlendMode.MUL, srand.i(130,150));
        }else{
            foreach(i; 0..5){
                drawer.circle(hsv(srand.i(0,360-1),srand.r(0.9,1), srand.r(0.9,1)),
                        this.pos+srand.v(2)+vecpos(0,srand.r(0,1)), this.radius, true, BlendMode.SUB, cast(int)(32*3*blend));
            }
            foreach(i; 0..5){
                drawer.circle(hsv(srand.i(0,360-1),srand.r(0.9,1), srand.r(0.9,1)),
                        this.pos+srand.v(2)+vecpos(0,-srand.r(0,1)), this.radius, true, BlendMode.ADD, cast(int)(32*3*blend));
            }
            //drawer.circle(WHITE, this.pos, this.radius-1, true);
            //drawer.circle(RED, this.pos, this.radius);
            //drawer.circle(BLACK, this.pos, this.radius+1);
        }
    }
}
version(none)final class Star{
    bool enable;
    Vector pos;
    int level;
    this(Vector pos, int level)
    in{
        assert(level > 0);
        assert(level <=5);
    }body{
        this.pos = pos;
        this.level = level;
    }
    void draw(Drawer drawer, Vector p = vecpos(0,0)){
    }
    void update(State st, GameScene gs){
    }
}
