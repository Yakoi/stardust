module gamelib.collisionmanager;


import gamelib.all;

class CollisionManager : PoolManager!(Collision) {
    this(uint max){
        super(max, {return new Collision();});
    }
    //ココからGenerate関数
    Collision collision(Vector pos, double dir, int offence, DamageType type,
            BadState badState, Mover mover, bool isKnockBack, bool isMyBullet)
        in{
            _checkLen();
        }out{
            _checkLen();
        }body{
            Collision res = pushListFromPool();
            res.init(pos, dir, offence, type, badState, mover, isKnockBack, isMyBullet);
            return res;
        }
    void test(Vector pos, double dir, double velocity, double acceleration){
    }
}
