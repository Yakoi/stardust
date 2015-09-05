// D import file generated from 'gamelib\collision.d'
module gamelib.collision;
import gamelib.all;
enum DamageType 
{
FIRE,
PHISICAL,
MAGICAL,
WATER,
}
enum BadState 
{
NONE,
PANIC,
SLOW,
PINSPOT,
}
class Collision
{
    private 
{
    Vector _pos;
    double _dir;
    int _offence;
    Mover _mover;
    BadState _badState;
    DamageType _type;
    bool _isKnockback;
    bool _isMybullet;
    public 
{
    this()
{
}
    void init(Vector pos, double dir, int offence, DamageType type, BadState badState, Mover mover, bool isKnockback, bool isMybullet)
{
this._pos = pos;
this._dir = dir;
this._offence = offence;
this._type = type;
this._badState = badState;
this._mover = mover;
this._isKnockback = isKnockback;
this._isMybullet = isMybullet;
}
    Vector pos()
{
return _pos;
}
    double dir()
{
return _dir;
}
    int offence()
{
return _offence;
}
    Mover mover()
{
return _mover;
}
    DamageType type()
{
return _type;
}
    bool isEnable()
{
return true;
}
    BadState badState()
{
return _badState;
}
    bool isKnockback()
{
return _isKnockback;
}
    bool isMybullet()
{
return _isMybullet;
}
}
}
}
