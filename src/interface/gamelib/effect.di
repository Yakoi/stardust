// D import file generated from 'gamelib\effect.d'
module gamelib.effect;
import gamelib.all;
abstract class Effect : MoverPlus
{
    this()
{
}
    abstract override template update(T)
{
void update(T scene);
}

}

