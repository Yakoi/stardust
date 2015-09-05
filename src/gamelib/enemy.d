
module gamelib.enemy;

import gamelib.all;



/+
final class Enemy : Mover{
    Vector    _pos;
    Area      _area;
    Figure    _figure;
    bool      _is_enable;
    bool      _is_visible;
    EnemyType _type;
    double    _dir;
    int       _life;
    int       _life_max;
    int       _offence;
    int       _level;
    this(){}
    final void init(Vector pos, double dir, Area area, Figure figure,
            int life, int life_max, 
            bool is_visible, bool is_enable, EnemyType type)
    {
        _figure    = figure;
        _area      = area;
        _is_enable = is_enable;
        _is_visible = is_visible;
        _type      = type;
        _life      = life;
        _life_max  = life_max;
    }
    final override double x()   {return pos.x;}
    final override double y()   {return pos.y;}
    final override Vector pos() {return _pos;}
    final override double dir() {return _dir;}
    final override bool is_enable()         {return _is_enable;}
    final override void is_enable(bool val) {_is_enable = val;}
    final override bool is_visible()        {return _is_visible;}
    final override void is_visible(bool val){_is_visible = val;}
    final override Area area()              {return _area;}
    final override Figure figure()          {return _figure;}
    final override MessageList update(GameScene scene){
        return type._update(this, scene);
    }

    void damage(int val){}
    void life(int val){_life = val;}
    int life(){return _life;}
    int life_max(){return _life_max;}
    int offence(){return _offence;}
    int level(){return _level;}
    EnemyType type(){return _type;}
}
+/
abstract class Enemy : MoverPlus{
    this(){}
    //override abstract double x();
    //override abstract double y();
    //override abstract Vector pos();
    //override abstract double dir();
    //override abstract bool is_enable();
    //override abstract void is_enable(bool val);
    //override abstract bool is_visible();
    //override abstract void is_visible(bool val);
    //override abstract Area area();
    //override abstract Figure figure();
    override abstract void update(T)(T scene);

    final int damage(){return this.life_max - this.life;}
    abstract void life(int val);
    abstract int life();
    abstract int life_max();
    abstract int offence();
    abstract int level();
    //override abstract bool draw(Drawer drawer);
    //abstract EnemyType type();
}

