module gamelib.effect;

import gamelib.all;

abstract class Effect : MoverPlus{
    this(){}
    override abstract void update(T)(T scene);
}

