// D import file generated from 'gameobj.d'
module gameobj;
import all;
class Field
{
    Rect rect;
    Area leftwall;
    Area rightwall;
    Area bottomwall;
    Area topwall;
    this(int width, int height, int cx, int bottom)
{
int b = 240 - bottom;
rect = box(cx - width / 2,b - height,cx + width / 2,b);
leftwall = new RectArea(rect.left,rect.top,1,rect.height);
rightwall = new RectArea(rect.right,rect.top,1,rect.height);
bottomwall = new RectArea(rect.left,rect.bottom,rect.width,1);
topwall = new RectArea(rect.left,rect.top,rect.width,1);
}
    this()
{
this(200,200,160,20);
}
}
class ShadowBar : Bar
{
    int maxCount;
    int count = 0;
    bool enable;
    this(Vector center, int maxCount, bool isBig)
{
this.pos = center;
this.maxCount = maxCount;
this.isBig = isBig;
this.enable = true;
}
    override void update();

    override bool draw(Drawer drawer, Vector pos = zerovec, double blend = 1);

}
class Bar : MoverPlus
{
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
    this()
{
pos = vecpos(160,200);
rect = mylib.rect.rect(40,4);
bigRect = mylib.rect.rect(80,6);
_area = new RectArea(rect);
_bigArea = new RectArea(bigRect);
tapArea = new RectArea(rect.width,200);
}
    const override pure Area area()
{
return cast(Area)_area;
}

    const pure Area bigArea()
{
return cast(Area)this._bigArea;
}

    override FigureSet[] figureSet()
{
return null;
}

    const override pure bool outOfScreen(Rect rect)
{
return true;
}

    void update()
{
this.tappingCount--;
}
    override bool draw(Drawer drawer, Vector p = vecpos(0,0), double blend = 1);

}
class Ball : MoverPlus
{
    bool enable;
    bool gosky = false;
    int radius;
    Vector vel;
    Vector acc;
    Area _area;
    int boundCount = 0;
    int count = 0;
    int finishCount = 0;
    this(Vector pos)
{
this.pos = pos;
radius = 4;
vel = vecpos(0,0);
acc = vecpos(0,0.02);
this._area = new CircleArea(radius);
this.enable = true;
this.gosky = false;
}
    void update()
{
pos = pos + vel;
vel = vel + acc;
this.count++;
}
    const override pure Area area()
{
return cast(Area)_area;
}

    override FigureSet[] figureSet()
{
return null;
}

    const override pure bool outOfScreen(Rect rect)
{
return true;
}

    void draw(State st, Drawer drawer, Vector pos = vecpos(0,0), double blend = 1);
}
version (none)
{
    final class Star
{
    bool enable;
    Vector pos;
    int level;
    this(Vector pos, int level)
in
{
assert(level > 0);
assert(level <= 5);
}
body
{
this.pos = pos;
this.level = level;
}
    void draw(Drawer drawer, Vector p = vecpos(0,0))
{
}
    void update(State st, GameScene gs)
{
}
}

}
