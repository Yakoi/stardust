// D import file generated from 'gamelib\bullet.d'
module gamelib.bullet;
import gamelib.all;
abstract class Bullet : MoverPlus
{
    this()
{
}
    abstract override template update(T)
{
void update(T scene);
}

    const abstract override pure bool outOfScreen(Rect rect);

    abstract override FigureSet[] figureSet();

    const abstract pure int offence();

    const abstract override pure Area area();

}

