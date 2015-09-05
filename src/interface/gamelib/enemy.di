// D import file generated from 'gamelib\enemy.d'
module gamelib.enemy;
import gamelib.all;
abstract class Enemy : MoverPlus
{
    this()
{
}
    abstract override template update(T)
{
void update(T scene);
}

    final int damage()
{
return this.life_max - this.life;
}

    abstract void life(int val);

    abstract int life();

    abstract int life_max();

    abstract int offence();

    abstract int level();

}

