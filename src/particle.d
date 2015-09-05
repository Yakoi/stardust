module particle;
import gamelib.all;

class Particle{
    bool enable;
    Vector pos;
    void draw(Drawer drawer, Vector p = vecpos(0,0), double b = 1.0){
    }
    abstract void update();
    const pure bool out_of_screen(Rect rect){
        return false;
    }

}
class WaveFillParticle : Particle{
    double radius;
    double radiusV;
    Vector vel;
    Vector acc;
    double friction = 0.0;
    double air_resistance = 0.01;
    int count = 0;
    int bound_count = 0;
    int blend = 0;
    Color col;
    Rand rand;
    this(Vector pos, Rand rand){
        this.pos = pos + rand.v(3);
        radius = rand.r(0,1);
        radiusV = rand.r(2,2.2);
        vel = rand.v(0.1);
        acc = vecpos(0,0);
        blend = rand.i(130,180);
        this.enable = true;
        this.rand = rand;
        this.col = hsv(rand.i(0,359), rand.r(0.,1), rand.r(0.5,1));
    }
    override void update(){
        this.vel = physicalMoveVel(vel, acc, friction, air_resistance);
        this.pos = this.pos + this.vel;
        this.count ++ ;
        this.blend = max(0, this.blend - 1);
        this.radius += this.radiusV;
        if(this.radius >= 2000 || this.blend <= 0){
            this.enable = false;
        }
    }
    const pure override bool out_of_screen(Rect rect){
        return true;
    }
    override void draw(Drawer drawer, Vector p = vecpos(0,0), double b = 1.0){
        drawer.circle(this.col, pos+p, cast(int)radius, true, BlendMode.ADD, cast(int)(blend*b));
    }
}
class WaveParticle : Particle{
    double radius;
    double radiusV;
    Vector vel;
    Vector acc;
    double friction = 0.0;
    double air_resistance = 0.01;
    int count = 0;
    int bound_count = 0;
    int blend = 0;
    Color col;
    Rand rand;
    this(Vector pos, Rand rand){
        this.pos = pos + rand.v(3);
        radius = rand.r(0,1);
        radiusV = rand.r(2,2.2);
        vel = rand.v(0.1);
        acc = vecpos(0,0);
        blend = rand.i(30,80);
        this.enable = true;
        this.rand = rand;
        this.col = rgb(rand.r(0.1,1), rand.r(0.1,1), rand.r(0.1,1));
    }
    override void update(){
        this.vel = physicalMoveVel(vel, acc, friction, air_resistance);
        this.pos = this.pos + this.vel;
        this.count ++ ;
        this.blend = max(0, this.blend - rand.i(1,2));
        this.radius += this.radiusV;
        if(this.radius >= 2000 || this.blend <= 0){
            this.enable = false;
        }
    }
    const pure override bool out_of_screen(Rect rect){
        return true;
    }
    override void draw(Drawer drawer, Vector p = vecpos(0,0), double b = 1.0){
        drawer.circle(this.col, pos, cast(int)radius, !true, BlendMode.ADD, cast(int)(blend*b));
    }
}
class WaveParticle2 : WaveParticle{
    this(Vector pos, Rand rand){
        super(pos, rand);
        this.radiusV = rand.r(0.5,2);
    }
}
/// ロゴシーン
class FixedCircleParticle : Particle{
    int radius;
    int count = 0;
    int blend = 0;
    Color col;
    Rand rand;
    this(Vector pos, Rand rand){
        this.pos = pos;
        radius = rand.i(4,10);
        blend = rand.i(200,255)/2;
        this.enable = true;
        this.rand = rand;
        this.col = rgb(rand.r(0.1,1), rand.r(0.1,1), rand.r(0.1,1));
    }
    override void update(){
        this.count ++ ;
        this.blend = max(0, this.blend - rand.i(1,5));
        if(rand.b(0.002)){
            this.radius --;
        }
        if(this.radius <= 0 || this.blend <= 0){
            this.enable = false;
        }
    }
    const pure override bool out_of_screen(Rect rect){
        return true;
    }
    override void draw(Drawer drawer, Vector p = vecpos(0,0), double b = 1.0){
        drawer.circle(this.col, pos, radius, true, BlendMode.ADD, cast(int)(blend*b));
    }
}
class CircleParticle : Particle{
    int radius;
    Vector vel;
    Vector acc;
    double friction = 0.0;
    double air_resistance = 0.01;
    int count = 0;
    int bound_count = 0;
    int blend = 0;
    Color col;
    Rand rand;
    this(Vector pos, Rand rand){
        this.pos = pos;
        radius = rand.i(1,5);
        vel = rand.v(1)+vecpos(0,-0.7);
        acc = vecpos(0,0.01);
        blend = rand.i(100,200);
        this.enable = true;
        this.rand = rand;
        this.col = rgb(rand.r(0.1,1), rand.r(0.1,1), rand.r(0.1,1));
    }
    override void update(){
        this.vel = physicalMoveVel(vel, acc, friction, air_resistance);
        this.pos = this.pos + this.vel;
        this.count ++ ;
        this.blend = max(0, this.blend - rand.i(0,2));
        if(rand.b(0.02)){
            this.radius --;
        }
        if(this.radius <= 0 || this.blend <= 0){
            this.enable = false;
        }
    }
    const pure override bool out_of_screen(Rect rect){
        return true;
    }
    override void draw(Drawer drawer, Vector p = vecpos(0,0), double b = 1.0){
        drawer.circle(this.col, pos, radius, true, BlendMode.ADD, cast(int)(blend*b));
    }
}
class LineParticle : Particle{
    double radius;
    double radiusV;
    double len;
    Vector vel;
    Vector acc;
    double friction = 0.0;
    double air_resistance = 0.01;
    int count = 0;
    int blend = 0;
    Color col;
    Rand rand;
    double angle;
    int thickness;
    this(Vector pos, Rand rand){
        this.pos = pos;
        radius = rand.i(0,5);
        vel = vecpos(0,0);
        acc = vecpos(0,0);
        blend = rand.i(100,200);
        this.len = rand.i(10,60);
        this.enable = true;
        this.rand = rand;
        this.col = rgb(rand.r(0.1,1), rand.r(0.1,1), rand.r(0.1,1));
        this.angle = rand.r(0,2*PI);
        this.thickness = rand.i(1,3);
        this.radiusV = rand.r(1,3);
    }
    override void update(){
        //this.pos = this.pos + physicalMoveVel(vel, acc, friction, air_resistance);
        this.count ++ ;
        this.blend = max(0, this.blend - rand.i(0,2));
        this.radius += this.radiusV;
        if(this.radius >= 1000 || this.blend <= 0 || this.out_of_screen(rect(0,0,320,240))){
            this.enable = false;
        }
    }
    override void draw(Drawer drawer, Vector p = vecpos(0,0), double b = 1.0){
        assert(isFinite(angle));
        assert(isFinite(radius));
        assert(isFinite(pos.x));
        drawer.line(this.col, vecdir(angle, radius)+pos,
                vecdir(angle, max!(double)(0,radius-len))+pos, thickness, BlendMode.ADD, cast(int)(this.blend*b));
    }
    pure const override bool out_of_screen(Rect rect){
        return gamelib.utils.outOfRect(this.pos, rect*1.2);
    }
}
class InWaveParticle : Particle{
    double radius;
    double radius_max;
    double len;
    Vector vel;
    Vector acc;
    double friction = 0.0;
    double air_resistance = 0.01;
    int count = 0;
    int blend = 0;
    int blend_max = 0;
    double par;
    Color col;
    Rand rand;
    double angle;
    int thickness;
    this(Vector pos, Rand rand){
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
        this.col = rgb(rand.r(0.1,1), rand.r(0.1,1), rand.r(0.1,1));
        this.angle = rand.r(0,2*PI);
        this.thickness = rand.i(1,3);
        this.par = 0;
    }
    override void update(){
        //this.pos = this.pos + physicalMoveVel(vel, acc, friction, air_resistance);
        
        this.count ++ ;
        this.blend = between(0, cast(int)(blend_max * par), 255);
        this.radius = (1-par)*this.radius_max;
        this.par += rand.r(0.01,0.03);
        if(par >1){
            this.enable = false;

        }
    }
    override void draw(Drawer drawer, Vector p = vecpos(0,0), double b = 1.0){
        assert(isFinite(angle));
        assert(isFinite(radius));
        assert(isFinite(pos.x));
        drawer.circle(this.col, pos, radius, false, BlendMode.ADD, cast(int)(this.blend*b));
    }
    pure const override bool out_of_screen(Rect rect){
        return gamelib.utils.outOfRect(this.pos, rect*1.2);
    }
}
class InCircleParticle : Particle{
    double radius;
    double radius_max;
    double len;
    Vector vel;
    Vector acc;
    double friction = 0.0;
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
    this(Vector pos, Rand rand){
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
        this.col = rgb(rand.r(0.1,1), rand.r(0.1,1), rand.r(0.1,1));
        this.angle = rand.r(0,2*PI);
        this.thickness = rand.i(1,3);
        this.par = 0;
        this.size = 1;
    }
    override void update(){
        //this.pos = this.pos + physicalMoveVel(vel, acc, friction, air_resistance);
        
        this.par = this.par + rand.r(0.01,0.03);
        real par2 = min(this.par, 1.0);
        this.blend = between(0, cast(int)(blend_max * par2), 255);
        this.radius = (1-par2)*this.radius_max;
        this.size += this.rand.r(0,0.2);
        //this.thickness = cast(int)max(1.0, this.par*this.par*5);
        if(this.par > 1.2){
            this.enable = false;
        }
    }
    override void draw(Drawer drawer, Vector p = vecpos(0,0), double b = 1.0){
        assert(isFinite(angle));
        assert(isFinite(radius));
        assert(isFinite(pos.x));
        drawer.circle(this.col, vecdir(angle, radius)+pos, this.size,
                true, BlendMode.ADD, cast(int)(this.blend*b));
    }
    pure const override bool out_of_screen(Rect rect){
        return gamelib.utils.outOfRect(this.pos, rect*1.2);
    }
}
class InLineParticle : Particle{
    double radius;
    double radius_max;
    double len;
    Vector vel;
    Vector acc;
    double friction = 0.0;
    double air_resistance = 0.01;
    int count = 0;
    int blend = 0;
    int blend_max = 0;
    double par;
    Color col;
    Rand rand;
    double angle;
    int thickness;
    this(Vector pos, Rand rand){
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
        this.col = rgb(rand.r(0.1,1), rand.r(0.1,1), rand.r(0.1,1));
        this.angle = rand.r(0,2*PI);
        this.thickness = rand.i(1,3);
        this.par = 0;
    }
    override void update(){
        //this.pos = this.pos + physicalMoveVel(vel, acc, friction, air_resistance);
        
        this.par = cast(real)count / 50;
        this.blend = between(0, cast(int)(blend_max * par), 255);
        this.radius = (1-par)*this.radius_max;
        //this.thickness = cast(int)max(1.0, this.par*this.par*5);
        if(par >1){
            this.enable = false;
        }
        this.count ++ ;
    }
    override void draw(Drawer drawer, Vector p = vecpos(0,0), double b = 1.0){
        assert(isFinite(angle));
        assert(isFinite(radius));
        assert(isFinite(pos.x));
        drawer.line(this.col, vecdir(angle, radius)+pos,
                vecdir(angle, max!(double)(0,radius-len))+pos, thickness, BlendMode.ADD, cast(int)(this.blend*b));
    }
    pure const override bool out_of_screen(Rect rect){
        return gamelib.utils.outOfRect(this.pos, rect*1.2);
    }
}
class TriangleParticle : Particle{
    int radius;
    Vector vel;
    Vector acc;
    double friction = 0.0;
    double air_resistance = 0.01;
    int count = 0;
    int bound_count = 0;
    double blend = 0;
    Color col;
    Rand rand;
    double angle;
    double angle_v;
    this(Vector pos, Rand rand){
        this.pos = pos;
        radius = rand.i(10,20);
        vel = rand.v(1)+rand.v(1.5,0)+vecpos(0,-0.4);
        acc = rand.v(0,0.04)+vecpos(0,0.003);
        blend = rand.r(100,200);
        this.enable = true;
        this.rand = rand;
        this.col = hsv(rand.i(0,359), rand.r(0.8,1), rand.r(0.5,1));
        this.angle = rand.r(0,2*PI);
        this.angle_v = rand.r(-0.3,0.3);
    }
    override void update(){
        this.vel = physicalMoveVel(vel, acc, friction, air_resistance);
        this.pos = this.pos + this.vel;
        this.count ++ ;
        this.blend = max!(double)(0.0, this.blend - rand.r(0,1.5));
        this.angle += angle_v;
        if(rand.b(0.01)){
            this.radius --;
        }
        if(this.radius <= 0 || this.blend <= 0 || out_of_screen(rect(0,0,320,240))){
            this.enable = false;
        }
    }
    pure const override bool out_of_screen(Rect rect){
        return gamelib.utils.outOfRect(this.pos, rect*1.2);
    }
    override void draw(Drawer drawer, Vector p = vecpos(0,0), double b = 1.0){
        Vector p1 = vecdir(angle+ 2*PI/3 *0, radius)+pos;
        Vector p2 = vecdir(angle+ 2*PI/3 *1, radius)+pos;
        Vector p3 = vecdir(angle+ 2*PI/3 *2, radius)+pos;
        drawer.triangle(this.col, p1, p2, p3, true, BlendMode.ADD, cast(int)(blend*b));
    }
}

///雷
class ThunderLineParticle : Particle{
    ThunderLineFigure figure;
    int blendParam = 255;
    Rand rand;
    this(Vector pos1, Vector pos2, Rand rand){
        this.figure = new ThunderLineFigure(
                rand,
                pos1,
                pos2,
                hsv(rand.i(0,359), rand.r(0.,0.3), rand.r(0.5,1)),
                rand.randi(2,5),
                8,
                rand.randi(1,5)
                );
        this.rand = rand;
        this.blendParam = rand.randi(150,255);
        this.enable = true;
    }
    override void update(){
        this.blendParam -= this.rand.randi(1,10);
        if(this.blendParam<=0){
            this.enable = false;
        }
    }
    pure const override bool out_of_screen(Rect rect){
        return false;
    }
    override void draw(Drawer drawer, Vector p = vecpos(0,0), double b = 1.0){
        this.figure.draw(drawer, p, 0, 0, BlendMode.ADD, cast(int)(this.blendParam*b), WHITE, false, 0);
    }
}


/// 背景の星
class StarParticle : Particle{
    const Color color;
    double arg;
    Rand rand;
    List!(Vector) diffList;
    const int brightMax;
    const int size;
    this(in Vector pos, in Color col, in int size, in int power, Rand rand){
        this.enable = true;
        this.pos = pos;
        this.rand = rand;
        this.color = col;
        this.brightMax = power;
        this.size = size;
        /// ランダム要素ありの初期設定
        this.diffList = new LinkedList!(Vector);
        foreach(i; 0..rand.i(2*2,5*2)){
            this.diffList.pushBack(rand.v(4));
        }
        this.arg = rand.r(0,100);
    }
    this(Vector pos, Rand rand){
        int size=3;
        int power = rand.i(40,100);
        Color col = hsv(rand.i(0,359), rand.r(0.,0.3), rand.r(0.5,1));
        this(pos,col,size,power,rand);
    }
    override void draw(Drawer drawer, Vector p = vecpos(0,0), double b = 1.0){
        int brightPower = cast(int)((sin(this.arg)+1)/2*brightMax * b);
        foreach(d; this.diffList){
            drawer.circle(this.color, p+pos+d, size, true, BlendMode.ADD, brightPower/2);
        }
        drawer.box(this.color, p+pos-vecpos(0,size*2), p+pos+vecpos(1,size*2), true, BlendMode.ADD, brightPower*2);
        drawer.box(this.color, p+pos-vecpos(size*2,0), p+pos+vecpos(size*2,1), true, BlendMode.ADD, brightPower*2);
        drawer.box(this.color, p+pos-vecpos(0,size)+vecpos(1,0), p+pos+vecpos(0,size)+vecpos(1,1), true, BlendMode.ADD, brightPower);
        drawer.box(this.color, p+pos-vecpos(0,size)-vecpos(1,0), p+pos+vecpos(0,size)-vecpos(1,1), true, BlendMode.ADD, brightPower);
        drawer.box(this.color, p+pos-vecpos(size,0)+vecpos(0,1), p+pos+vecpos(size,0)+vecpos(1,1), true, BlendMode.ADD, brightPower);
        drawer.box(this.color, p+pos-vecpos(size,0)-vecpos(0,1), p+pos+vecpos(size,0)-vecpos(1,1), true, BlendMode.ADD, brightPower);
    }
    override void update(){
        this.arg = this.arg + this.rand.r(0,0.03);
    }
}
