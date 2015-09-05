module gamelib.bullet;

import gamelib.all;

abstract class Bullet : MoverPlus{
    this(){}
    override abstract void update(T)(T scene);
    const pure override abstract bool outOfScreen(Rect rect);
    override abstract FigureSet[] figureSet();
    const pure abstract int offence();
    const pure override abstract Area area();
}

