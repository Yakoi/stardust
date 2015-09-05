// D import file generated from 'gamelib\mover.d'
module gamelib.mover;
import gamelib.all;
import mylib.list;
import std.stdio;
abstract class Mover : Position,Direction
{
    this()
{
}
    const abstract override pure double x();

    const abstract override pure double y();

    abstract void x(double);

    abstract void y(double);

    const abstract override pure Vector pos();

    abstract void pos(Vector pos);

    const abstract override pure double dir();

    abstract void dir(double);

    abstract Vector posLog(int n);

    abstract double dirLog(int n);

    const abstract pure bool isEnable();

    abstract void isEnable(bool val);

    const abstract pure bool isVisible();

    abstract void isVisible(bool val);

    const abstract pure bool isRotatable();

    abstract void isRotatable(bool val);

    const abstract pure Area area();

    const abstract pure uint count();

    const abstract pure double scale();

    const abstract pure double areaScale();

    const abstract pure BlendMode blendMode();

    const abstract pure int blendParam();

    const abstract pure Color bright();

    abstract bool draw(Drawer drawer, Vector, double blend = 1);

    abstract bool drawArea(Drawer drawer, Color color, Vector pos = Vector(0,0));

    abstract void add_collision(Vector pos, double dir, int offence, DamageType type, BadState, Mover mover, bool is_knockback, bool is_mybullet);

    const abstract pure bool detectCollision(in CollisionDetector cd, in Mover mover);

}

abstract class MoverPlus : Mover
{
    private 
{
    Vector _pos = Vector(0,0);
    double _dir = 0;
    bool _isEnable = true;
    bool _isVisible = true;
    bool _isRotatable = true;
    uint _count = 0;
    double _scale = 1;
    double _areaScale = 1;
    BlendMode _blendMode;
    int _blendParam = 255;
    immutable int _logNum = 30;

    int _currentLogIndex = 0;
    Vector[_logNum - 1] _posLog;
    double[_logNum - 1] _dirLog;
    Color _bright = Color(255,255,255);
    CollisionManager _collisionManager;
}
        this()
{
_pos = Vector(0,0);
_dir = 0;
_scale = 1;
_blendParam = 255;
_isVisible = true;
_isEnable = true;
_collisionManager = new CollisionManager(10);
_blendMode = BlendMode.NOBLEND;
_currentLogIndex = 0;
_isRotatable = true;
super();
}
    override Vector posLog(int n);

    override double dirLog(int n);

    const final override pure double x()
{
return this._pos.x;
}

    const final override pure double y()
{
return this._pos.y;
}

    final override void x(double val)
{
this._pos.x = val;
}

    final override void y(double val)
{
this._pos.y = val;
}

    const final override pure Vector pos()
{
return this._pos;
}

    final override void pos(Vector pos)
{
this._pos = pos;
}

    const final override pure double dir()
{
return this._dir;
}

    final override void dir(double val)
{
this._dir = val;
}

    const final override pure bool isEnable()
{
return this._isEnable;
}

    final override void isEnable(bool val)
{
this._isEnable = val;
}

    const final override pure bool isVisible()
{
return this._isVisible;
}

    final override void isVisible(bool val)
{
this._isVisible = val;
}

    const final override pure bool isRotatable()
{
return this._isRotatable;
}

    final override void isRotatable(bool val)
{
this._isRotatable = val;
}

    const final override pure uint count()
{
return _count;
}

    final void count(uint val)
{
this._count = val;
}

    const final override pure double scale()
{
return this._scale;
}

    final void scale(double val)
{
this._scale = val;
}

    const final override pure double areaScale()
{
return this._areaScale;
}

    final void areaScale(double val)
{
this._areaScale = val;
}

    const final override pure Color bright()
{
return this._bright;
}

    final void bright(Color val)
{
this._bright = val;
}

    const final override pure BlendMode blendMode()
{
return this._blendMode;
}

    final void blendMode(BlendMode val)
{
this._blendMode = val;
}

    const final override pure int blendParam()
{
return this._blendParam;
}

    final void blendParam(int val)
{
this._blendParam = val;
}

    const final pure CollisionManager collisionManager()
{
return cast(CollisionManager)this._collisionManager;
}

    final override void add_collision(Vector pos, double dir, int offence, DamageType type, BadState bad_state, Mover mover, bool is_knockback, bool is_mybullet);

    abstract FigureSet[] figureSet();

    const abstract override pure Area area();

    override bool draw(Drawer drawer, Vector pos = Vector(0,0), double blend = 1);

    final override bool drawArea(Drawer drawer, Color color, Vector pos = Vector(0,0))
{
return this.area.draw(drawer,this.pos + pos,this.dir,this.areaScale,color);
}

    const abstract pure bool outOfScreen(Rect rect);

    final void addLog()
{
_posLog[_currentLogIndex] = this.pos;
_dirLog[_currentLogIndex] = this.dir;
_currentLogIndex = (_currentLogIndex + 1) % (_logNum - 1);
}

    const final override pure bool detectCollision(in CollisionDetector cd, in Mover mover)
in
{
assert(cd !is null);
assert(mover !is null);
}
body
{
return cd.detect(this.area,mover.area,this.pos,mover.pos,this.dir,mover.dir,this.areaScale,mover.areaScale);
}

}

