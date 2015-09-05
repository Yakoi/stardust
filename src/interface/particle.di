// D import file generated from 'particle.d'
module particle;
import gamelib.all;
class Particle
{
    bool enable;
    Vector pos;
    void draw(Drawer drawer, Vector p = vecpos(0,0), double b = 1)
{
}
    abstract void update();

    const pure bool out_of_screen(Rect rect)
{
return false;
}

}
class WaveFillParticle : Particle
{
    double radius;
    double radiusV;
    Vector vel;
    Vector acc;
    double friction = 0;
    double air_resistance = 0.01;
    int count = 0;
    int bound_count = 0;
    int blend = 0;
    Color col;
    Rand rand;
    this(Vector pos, Rand rand)
{
this.pos = pos + rand.v(3);
radius = rand.r(0,1);
radiusV = rand.r(2,2.2);
vel = rand.v(0.1);
acc = vecpos(0,0);
blend = rand.i(130,180);
this.enable = true;
this.rand = rand;
this.col = hsv(rand.i(0,359),rand.r(0,1),rand.r(0.5,1));
}
    override void update();

    const override pure bool out_of_screen(Rect rect)
{
return true;
}

    override void draw(Drawer drawer, Vector p = vecpos(0,0), double b = 1)
{
drawer.circle(this.col,pos + p,cast(int)radius,true,BlendMode.ADD,cast(int)(blend * b));
}

}
class WaveParticle : Particle
{
    double radius;
    double radiusV;
    Vector vel;
    Vector acc;
    double friction = 0;
    double air_resistance = 0.01;
    int count = 0;
    int bound_count = 0;
    int blend = 0;
    Color col;
    Rand rand;
    this(Vector pos, Rand rand)
{
this.pos = pos + rand.v(3);
radius = rand.r(0,1);
radiusV = rand.r(2,2.2);
vel = rand.v(0.1);
acc = vecpos(0,0);
blend = rand.i(30,80);
this.enable = true;
this.rand = rand;
this.col = rgb(rand.r(0.1,1),rand.r(0.1,1),rand.r(0.1,1));
}
    override void update();

    const override pure bool out_of_screen(Rect rect)
{
return true;
}

    override void draw(Drawer drawer, Vector p = vecpos(0,0), double b = 1)
{
drawer.circle(this.col,pos,cast(int)radius,!true,BlendMode.ADD,cast(int)(blend * b));
}

}
class WaveParticle2 : WaveParticle
{
    this(Vector pos, Rand rand)
{
super(pos,rand);
this.radiusV = rand.r(0.5,2);
}
}
class FixedCircleParticle : Particle
{
    int radius;
    int count = 0;
    int blend = 0;
    Color col;
    Rand rand;
    this(Vector pos, Rand rand)
{
this.pos = pos;
radius = rand.i(4,10);
blend = rand.i(200,255) / 2;
this.enable = true;
this.rand = rand;
this.col = rgb(rand.r(0.1,1),rand.r(0.1,1),rand.r(0.1,1));
}
    override void update();

    const override pure bool out_of_screen(Rect rect)
{
return true;
}

    override void draw(Drawer drawer, Vector p = vecpos(0,0), double b = 1)
{
drawer.circle(this.col,pos,radius,true,BlendMode.ADD,cast(int)(blend * b));
}

}
class CircleParticle : Particle
{
    int radius;
    Vector vel;
    Vector acc;
    double friction = 0;
    double air_resistance = 0.01;
    int count = 0;
    int bound_count = 0;
    int blend = 0;
    Color col;
    Rand rand;
    this(Vector pos, Rand rand)
{
this.pos = pos;
radius = rand.i(1,5);
vel = rand.v(1) + vecpos(0,-0.7);
acc = vecpos(0,0.01);
blend = rand.i(100,200);
this.enable = true;
this.rand = rand;
this.col = rgb(rand.r(0.1,1),rand.r(0.1,1),rand.r(0.1,1));
}
    override void update();

    const override pure bool out_of_screen(Rect rect)
{
return true;
}

    override void draw(Drawer drawer, Vector p = vecpos(0,0), double b = 1)
{
drawer.circle(this.col,pos,radius,true,BlendMode.ADD,cast(int)(blend * b));
}

}
class LineParticle : Particle
{
    double radius;
    double radiusV;
    double len;
    Vector vel;
    Vector acc;
    double friction = 0;
    double air_resistance = 0.01;
    int count = 0;
    int blend = 0;
    Color col;
    Rand rand;
    double angle;
    int thickness;
    this(Vector pos, Rand rand)
{
this.pos = pos;
radius = rand.i(0,5);
vel = vecpos(0,0);
acc = vecpos(0,0);
blend = rand.i(100,200);
this.len = rand.i(10,60);
this.enable = true;
this.rand = rand;
this.col = rgb(rand.r(0.1,1),rand.r(0.1,1),rand.r(0.1,1));
this.angle = rand.r(0,2 * PI);
this.thickness = rand.i(1,3);
this.radiusV = rand.r(1,3);
}
    override void update();

    override void draw(Drawer drawer, Vector p = vecpos(0,0), double b = 1)
{
assert(isFinite(angle));
assert(isFinite(radius));
assert(isFinite(pos.x));
drawer.line(this.col,vecdir(angle,radius) + pos,vecdir(angle,max!(double)(0,radius - len)) + pos,thickness,BlendMode.ADD,cast(int)(this.blend * b));
}

    const override pure bool out_of_screen(Rect rect)
{
return gamelib.utils.outOfRect(this.pos,rect * 1.2);
}

}
class InWaveParticle : Particle
{
    double radius;
    double radius_max;
    double len;
    Vector vel;
    Vector acc;
    double friction = 0;
    double air_resistance = 0.01;
    int count = 0;
    int blend = 0;
    int blend_max = 0;
    double par;
    Color col;
    Rand rand;
    double angle;
    int thickness;
    this(Vector pos, Rand rand)
{
this.pos = pos;
radius = rand.i(100,203);
radius_max = radius;
vel = vecpos(0,0);
acc = vecpos(0,0);
this.blend = 0;
this.blend_max = rand.i(40,200);
this.len = rand.i(10,60);
this.enable = true;
this.rand = rand;
this.col = rgb(rand.r(0.1,1),rand.r(0.1,1),rand.r(0.1,1));
this.angle = rand.r(0,2 * PI);
this.thickness = rand.i(1,3);
this.par = 0;
}
    override void update();

    override void draw(Drawer drawer, Vector p = vecpos(0,0), double b = 1)
{
assert(isFinite(angle));
assert(isFinite(radius));
assert(isFinite(pos.x));
drawer.circle(this.col,pos,radius,false,BlendMode.ADD,cast(int)(this.blend * b));
}

    const override pure bool out_of_screen(Rect rect)
{
return gamelib.utils.outOfRect(this.pos,rect * 1.2);
}

}
class InCircleParticle : Particle
{
    double radius;
    double radius_max;
    double len;
    Vector vel;
    Vector acc;
    double friction = 0;
    double air_resistance = 0.01;
    int count = 0;
    int blend = 0;
    int blend_max = 0;
    double par;
    Color col;
    Rand rand;
    double angle;
    int thickness;
    double size;
    this(Vector pos, Rand rand)
{
this.pos = pos;
radius = rand.i(100,503);
radius_max = radius;
vel = vecpos(0,0);
acc = vecpos(0,0);
this.blend = 0;
this.blend_max = rand.i(100,200);
this.len = rand.i(10,120);
this.enable = true;
this.rand = rand;
this.col = rgb(rand.r(0.1,1),rand.r(0.1,1),rand.r(0.1,1));
this.angle = rand.r(0,2 * PI);
this.thickness = rand.i(1,3);
this.par = 0;
this.size = 1;
}
    override void update();

    override void draw(Drawer drawer, Vector p = vecpos(0,0), double b = 1)
{
assert(isFinite(angle));
assert(isFinite(radius));
assert(isFinite(pos.x));
drawer.circle(this.col,vecdir(angle,radius) + pos,this.size,true,BlendMode.ADD,cast(int)(this.blend * b));
}

    const override pure bool out_of_screen(Rect rect)
{
return gamelib.utils.outOfRect(this.pos,rect * 1.2);
}

}
class InLineParticle : Particle
{
    double radius;
    double radius_max;
    double len;
    Vector vel;
    Vector acc;
    double friction = 0;
    double air_resistance = 0.01;
    int count = 0;
    int blend = 0;
    int blend_max = 0;
    double par;
    Color col;
    Rand rand;
    double angle;
    int thickness;
    this(Vector pos, Rand rand)
{
this.pos = pos;
radius = rand.i(100,503);
radius_max = radius;
vel = vecpos(0,0);
acc = vecpos(0,0);
this.blend = 0;
this.blend_max = rand.i(100,200);
this.len = rand.i(10,120);
this.enable = true;
this.rand = rand;
this.col = rgb(rand.r(0.1,1),rand.r(0.1,1),rand.r(0.1,1));
this.angle = rand.r(0,2 * PI);
this.thickness = rand.i(1,3);
this.par = 0;
}
    override void update();

    override void draw(Drawer drawer, Vector p = vecpos(0,0), double b = 1)
{
assert(isFinite(angle));
assert(isFinite(radius));
assert(isFinite(pos.x));
drawer.line(this.col,vecdir(angle,radius) + pos,vecdir(angle,max!(double)(0,radius - len)) + pos,thickness,BlendMode.ADD,cast(int)(this.blend * b));
}

    const override pure bool out_of_screen(Rect rect)
{
return gamelib.utils.outOfRect(this.pos,rect * 1.2);
}

}
class TriangleParticle : Particle
{
    int radius;
    Vector vel;
    Vector acc;
    double friction = 0;
    double air_resistance = 0.01;
    int count = 0;
    int bound_count = 0;
    double blend = 0;
    Color col;
    Rand rand;
    double angle;
    double angle_v;
    this(Vector pos, Rand rand)
{
this.pos = pos;
radius = rand.i(10,20);
vel = rand.v(1) + rand.v(1.5,0) + vecpos(0,-0.4);
acc = rand.v(0,0.04) + vecpos(0,0.003);
blend = rand.r(100,200);
this.enable = true;
this.rand = rand;
this.col = hsv(rand.i(0,359),rand.r(0.8,1),rand.r(0.5,1));
this.angle = rand.r(0,2 * PI);
this.angle_v = rand.r(-0.3,0.3);
}
    override void update();

    const override pure bool out_of_screen(Rect rect)
{
return gamelib.utils.outOfRect(this.pos,rect * 1.2);
}

    override void draw(Drawer drawer, Vector p = vecpos(0,0), double b = 1)
{
Vector p1 = vecdir(angle + 2 * PI / 3 * 0,radius) + pos;
Vector p2 = vecdir(angle + 2 * PI / 3 * 1,radius) + pos;
Vector p3 = vecdir(angle + 2 * PI / 3 * 2,radius) + pos;
drawer.triangle(this.col,p1,p2,p3,true,BlendMode.ADD,cast(int)(blend * b));
}

}
class ThunderLineParticle : Particle
{
    ThunderLineFigure figure;
    int blendParam = 255;
    Rand rand;
    this(Vector pos1, Vector pos2, Rand rand)
{
this.figure = new ThunderLineFigure(rand,pos1,pos2,hsv(rand.i(0,359),rand.r(0,0.3),rand.r(0.5,1)),rand.randi(2,5),8,rand.randi(1,5));
this.rand = rand;
this.blendParam = rand.randi(150,255);
this.enable = true;
}
    override void update();

    const override pure bool out_of_screen(Rect rect)
{
return false;
}

    override void draw(Drawer drawer, Vector p = vecpos(0,0), double b = 1)
{
this.figure.draw(drawer,p,0,0,BlendMode.ADD,cast(int)(this.blendParam * b),WHITE,false,0);
}

}
class StarParticle : Particle
{
    const Color color;

    double arg;
    Rand rand;
    List!(Vector) diffList;
    const int brightMax;

    const int size;

    this(in Vector pos, in Color col, in int size, in int power, Rand rand);
    this(Vector pos, Rand rand);
    override void draw(Drawer drawer, Vector p = vecpos(0,0), double b = 1);

    override void update()
{
this.arg = this.arg + this.rand.r(0,0.03);
}

}
