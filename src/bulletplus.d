module bulletplus;

import gameall;
/// Bullet一つ一つ固有の値
typedef int BulletId;


class BulletPlus : MoverH{
    BulletId id;
    BulletType _type;
    Direction4 _dir4;
    double _velocity;
    this(Figure shadow){
        super(shadow);
    }

    const pure BulletType type()
    out(res){assert(res !is null);}
    body{return cast(BulletType)this._type;}

    void type(in BulletType val) {this._type = cast(BulletType)val;}

    const pure override Area area()
    out(res){
        assert(res !is null);
    }body{
        if(this.type.area_begin_time <= this.count
                && this.count <= this.type.area_end_time){
            return type.area(this._dir4);
        }else{
            return new NoArea;
        }
    }
    //void area(Area val){this._area = val;}
    //void figureset(FigureSet[] val){this._figureset = val;}
    const pure double velocity(){return this._velocity;}
    void velocity(double val){this._velocity = val;}
    void update(GameState gs){
        if(this.count >= this.type.time){
            this.is_enable = false;
            return;
        }
        with(MoveType)final switch(this.type.move_type){
        case fixed:
            // do nothing
            break;
        case direct:
            this.pos = this.pos + vecdir(this.dir, this.velocity);
            break;
        case accelerate:
            break;
        }
        with(WallType)final switch(this.type.wall_type){
        case pass:
            break;
        case goout:
            assert(gs !is null);
            assert(gs.cd !is null);
            assert(gs.map !is null);
            assert(this.area !is null);
            assert(gs.block_chip !is null);
            if(gs.cd.map_rect(gs.map[0], gs.block_chip, 
                    this.area, vecpos(0,0), vecpos(this.x,this.y))){
                this.is_enable = false;
            }
            break;
        case reflect:
            assert(false);
            //break;

        }
        this.count = this.count + 1;
    }
    const pure int offence()
    out(res){
        assert(res>=0);
    } body {
        return 0;
    }
    override FigureSet[] figureset()
    out(res){
        assert(res !is null);
        foreach(f; res){
            assert(f.figure !is null);
        }
    }body{
        return type.figureset;
    }
    const pure override bool out_of_screen(Rect rect){
        return false;
    }
    void init(BulletType type, Vector pos, Direction4 dir4, double dir, double velocity,
                bool is_visible, bool is_enable){
        this.type = type;
        this.id = fresh_bullet_id();
        this.pos = pos;
        this._dir4= dir4;
        this.dir = dir;
        this.velocity = velocity;
        this.is_enable = is_enable;
        this.is_visible = is_visible;
        this.count = 0;
    }

}


/// 新しい値を返す関数
BulletId fresh_bullet_id()
out(res){
    //assert(res>0, to!(string)(res));
}body{
    static BulletId i = 0;
    i++;
    return i;
}
