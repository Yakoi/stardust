module bullettype;

import gamelib.all;
import gamestate;
import bulletplus;
import std.stdio;

/// 遠距離か近距離か
enum DistanceType{
    far, /// 遠距離
    close, /// 近距離
}
/// ノックダウンのタイプ
enum KnockdownType{
    none, /// ノックダウンさせない
    ugokanai, /// ひるませる
    back,  ///後ろ側に弾く
    strong, ///壁にぶつかるまで吹っ飛ばす
    high, /// 上のほうに打ち上げる
    up, /// 真上に打ち上げる
    hikikomi, /// 引き込む
    down, /// 下方向に弾く
}
/// 状態異常
enum BadState{
    none, ///状態異常を引き起こさない
    fire, /// 炎をつける
    freeze, /// 凍らせる
    shock, /// しびれさせる
}
/// 壁にぶつかった時の反応
enum WallType{
    pass, /// 貫通
    goout, /// 消える
    reflect, ///反射
}
/// 水に入った時の反応
enum WaterType{
    pass, ///通過
    speeddown, ///スピードが遅くなる
    goout, ///消える
}
/// 攻撃の属性
enum ElementType{
    physical, ///物理
    fire, ///炎
    ice, ///氷
    thunder, ///雷
    water, ///水
    earth, ///土
    wood, ///木
    wind, ///風
}
/// 動き方の種類
enum MoveType{
    fixed,      /// 固定
    direct,     /// 直進
    accelerate, /// 加速
}
    
/// bullet type
abstract class BulletTypeBase{
    /// 遠距離か近距離か
    abstract const pure DistanceType distance_type();
    /// ノックダウンのタイプ
    abstract const pure KnockdownType knockdown_type();
    /// ノックダウンする力
    abstract const pure int knockdown_power();
    /// 引き起こすバッドステータス
    abstract const pure BadState bad_state();
    /// 攻撃の属性
    abstract const pure ElementType element_type();
    /// 攻撃力
    abstract const pure int offence();
    ///
    abstract const pure WallType wall_type();
    ///
    abstract const pure WaterType water_type();


    abstract const pure Area area();
    abstract const pure FigureSet[] figureset();

    abstract const pure MoveType move_type();

}

/// bullet type
class BulletType : BulletTypeBase{
protected:
    Area          _area_lr;
    Area          _area_tb;
    FigureSet[]   _figureset;
    int           _offence;
    int           _time;
    int           _area_begin_time;
    int           _area_end_time;
    DistanceType  _distance_type;
    KnockdownType _knockdown_type;
    int           _knockdown_power;
    BadState      _bad_state;
    ElementType   _element_type;
    WallType      _wall_type;
    WaterType     _water_type;
    MoveType      _move_type;

public:

    this(Area area, FigureSet[] figureset, MoveType move_type, int offence, int time,
            int area_begin_time, int area_end_time,
            DistanceType dt, KnockdownType kt, int kp,
            BadState bt, ElementType et, WallType walltype, WaterType watertype)
    in{
        assert(area_begin_time <= area_end_time);
    }body{
        this(area, area, figureset, move_type, offence, time, area_begin_time, area_end_time,
                dt, kt, kp, bt, et, walltype, watertype);
    }
    this(Area area_lr, Area area_tb, FigureSet[] figureset, MoveType move_type,
            int offence, int time,
            int area_begin_time, int area_end_time,
            DistanceType dt, KnockdownType kt, int kp,
            BadState bt, ElementType et, WallType walltype, WaterType watertype){
        this._area_lr         = area_lr;
        this._area_tb         = area_tb;
        this._figureset       = figureset;
        this._offence         = offence;
        this._time            = time;
        this._move_type       = move_type;
        this._area_begin_time = area_begin_time;
        this._area_end_time   = area_end_time;
        this._distance_type   = dt;
        this._knockdown_type  = kt;
        this._knockdown_power = kp;
        this._bad_state       = bt;
        this._element_type    = et;
        this._wall_type       = walltype;
        this._water_type      = water_type;
    }
    const pure int time(){return this._time;}
    override const pure MoveType move_type(){return this._move_type;}
    const pure int area_begin_time(){return this._area_begin_time;}
    const pure int area_end_time(){return this._area_end_time;}
    /// 遠距離か近距離か
    override const pure DistanceType distance_type(){return this._distance_type;}
    /// ノックダウンのタイプ
    override const pure KnockdownType knockdown_type(){return this._knockdown_type;}
    /// ノックダウンする力
    override const pure int knockdown_power(){return this._knockdown_power;}
    /// 引き起こすバッドステータス
    override const pure BadState bad_state(){return this._bad_state;}
    /// 攻撃の属性
    override const pure ElementType element_type(){return this._element_type;}
    /// 攻撃力
    override const pure int offence(){return this._offence;}
    /// 壁に当たった時の処理の種類
    override const pure WallType wall_type(){return this._wall_type;}
    /// 水に入った時の処理の種類
    override const pure WaterType water_type(){return this._water_type;}


    override const pure Area area(){
        assert(false);
        //return this.area(Direction4.r);
    }
    const pure Area area(Direction4 dir){
        with(Direction4)final switch(dir){
        case r:
        case l:
            return cast(Area)this._area_lr;
        case t:
        case b:
            return cast(Area)this._area_tb;
        }
    }
    override const pure FigureSet[] figureset()
    out(res){
        assert(res !is null);
        foreach(f; res){
            assert(f.figure !is null);
        }
    }body{return cast(FigureSet[])this._figureset;}

    

}
class HammerYokoBullet : BulletType{
    this(){
        auto f = figset(new CircleFigure(white, 3));
        auto alr = new RectArea(24,30);
        auto atb = new RectArea(30,24);
        super(
                alr, // area
                atb,
                f, // figure
                MoveType.fixed,
                10, // offence
                50, // time
                5, //area_begin_time
                10, //area_end_time
                DistanceType.close, //distance type
                KnockdownType.back, //knockdown_type
                10, //knockdown_power
                BadState.none, //badstate
                ElementType.physical, //element type
                WallType.pass, //wall type
                WaterType.pass // water type
        );
    }
}
class HammerTateBullet : BulletType{
    this(){
        auto f = figset(new CircleFigure(white, 3));
        auto a = new CircleArea(10);
        super(
                a, // area
                f, // figure
                MoveType.fixed,
                10, // offence
                100, // time
                20, //area_begin_time
                23, //area_end_time
                DistanceType.close, //distance type
                KnockdownType.back, //knockdown_type
                10, //knockdown_power
                BadState.none, //badstate
                ElementType.physical, //element type
                WallType.pass, //wall type
                WaterType.pass // water type
        );
    }
}
BulletType myshot(){
    Area a = new CircleArea(4);
    FigureSet[] f = figset(new CircleFigure(red, 4));
    return new BulletType(
        a, // area
        f, // figure
        MoveType.direct, // mover type
        10, // offence
        100, // time
        0, //area_begin_time
        100, //area_end_time
        DistanceType.close, //distance type
        KnockdownType.back, //knockdown_type
        10, //knockdown_power
        BadState.none, //badstate
        ElementType.physical, //element type
        WallType.goout, //wall type
        WaterType.pass // water type
    );
}
