module bulletmanager;


import bulletplus;
import gamelib.all;
import bullettype;
import gamestate;
import std.stdio;
import std.math;

///面倒
///数の制限がある
///メモリを最初にまとめて取得するため、速い
class BulletManager : PoolManager!(BulletPlus){
    BulletTypeTable bullet_table;
    this(uint max, Figure shadow){
        super(max, {return new BulletPlus(shadow);});
        bullet_table = new BulletTypeTable;
    }
    //ココからGenerate関数
    BulletPlus bullet(BulletType bullet_type, Vector pos, Direction4 dir4, double dir, double velocity,
            bool is_visible = true, bool is_enable = true)
    in{
        _check_len();
        assert(bullet_type !is null);
    }out{
        _check_len();
    }body{
        BulletPlus res = push_list_from_pool();
        res.init(bullet_type, pos, dir4, dir, velocity,
            is_visible, is_enable);
        return res;
    }
    BulletPlus bullet(BulletType bullet_type, Vector pos, Direction4 dir4, double velocity,
            bool is_visible = true, bool is_enable = true)
    in{
        _check_len();
    }out{
        _check_len();
    }body{
        return this.bullet(bullet_type, pos, dir4, dir_to_rad(dir4), velocity, is_visible, is_enable);
    }


    BulletPlus hammer_yoko(Vector pos, Direction4 dir, double velocity){
        return bullet(bullet_table.hammer_yoko, pos, dir, velocity);
    }
    BulletPlus hammer_tate(Vector pos, Direction4 dir, double velocity){
        return bullet(bullet_table.hammer_tate, pos, dir, velocity);
    }
    BulletPlus myshot(Vector pos, Direction4 dir, double velocity){
        return bullet(bullet_table.myshot, pos, dir, velocity);
    }

}

class BulletTypeTable : Table!(BulletType){
public:
    HammerYokoBullet hammer_yoko;
    HammerTateBullet hammer_tate;
    BulletType       myshot;
    this(){
        hammer_yoko = new HammerYokoBullet();
        hammer_tate = new HammerTateBullet();
        myshot = bullettype.myshot;
    }
}
