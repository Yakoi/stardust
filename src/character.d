module character;

import gameall;


struct CharacterFigureSet{
    Figure left_walk;
    Figure right_walk;
    Figure top_walk;
    Figure bottom_walk;
    Figure left_dash;
    Figure right_dash;
    Figure top_dash;
    Figure bottom_dash;
    Figure damage;
    Figure guard;
    Figure shadow;
}
enum CharacterState{
    attacking,  /// 攻撃アクション中
    guarding,   /// ガード中
    normal, /// 通常状態

}
enum ActionType{
    attack,
    guard,
    other,
    normal,
}
///
class Action{
    CharacterState character_state;
    int _time;
    this(CharacterState cs, int t){
        this.character_state = cs;
        this._time = t;
    }
    this(in int t = -1){
        this._time = t;
    }
    const final Action update(ref GameState gs, ref Character chara, in int count){
        Action res = _update(gs, chara, count);
        if(this._time >= 0 && count >= this._time){
            res = null;
        }
        return res;
    }
    const protected abstract Action _update(ref GameState gs, ref Character chara, in int count);
    const abstract ActionType action_type();
}


/// コントローラによる移動や攻撃など
class MyCharaNormalAction : Action{
    this(){
        super();
    }
    const override Action _update(ref GameState gs, ref Character chara, in int count){
        Action res = this.normal(gs, chara);
        this.move(gs, chara);
        return res;
    }
    const void move(GameState gs, Character chara){
        auto ctrl = gs.controller1;
        final switch(ctrl.direction5){
        case Direction5.r:
            if(ctrl.attack.is_press){
                chara.walk_right(gs);
            }else{
                chara.dash_right(gs);
            }
            break;
        case Direction5.b:
            if(ctrl.attack.is_press){
                chara.walk_bottom(gs);
            }else{
                chara.dash_bottom(gs);
            }
            break;
        case Direction5.l:
            if(ctrl.attack.is_press){
                chara.walk_left(gs);
            }else{
                chara.dash_left(gs);
            }
            break;
        case Direction5.t:
            if(ctrl.attack.is_press){
                chara.walk_top(gs);
            }else{
                chara.dash_top(gs);
            }
            break;
        case Direction5.c:
            chara._velocity = 0;
            break;
        }
    }
    const Action normal(ref GameState gs, ref Character chara){
        auto ctrl = gs.controller1;
        
        /// attack ボタンについて
        if(ctrl.attack.is_down()){
            gs.game.dt.add_text("attack");
            int lc = ctrl.attack.last_count;
            bool is_long = (lc > 10); //長押しか
            RelativeDirection5 rd = relative_direction(chara.direction, ctrl.direction5);
            bool is_guard = ctrl.guard.is_press; //パワーボタンが押されているかどうか
            with(RelativeDirection5)final switch(rd){
                case forward:
                    if(is_guard){
                        writeln("fga");
                        return chara._action_data.fga;
                    }else{
                        if(chara.dashing){
                            writeln("da");
                            return chara._action_data.da;
                        }else{
                            writeln("fa");
                            return chara._action_data.fa;
                        }
                    }
                case righthand:
                    if(is_guard){
                        writeln("rga");
                        return chara._action_data.fga;
                    }else{
                        writeln("ra");
                    }
                    break;
                case back:
                    if(is_guard){
                        writeln("bga");
                        // chara._action_data.fga;
                    }else{
                        writeln("ba");
                    }
                    break;
                case lefthand:
                    if(is_guard){
                        writeln("lga");
                        // chara._action_data.fga;
                    }else{
                        writeln("la");
                    }
                    break;
                case none:
                    if(is_guard){
                        writeln("ga");
                        if(chara.z <= 1.0){
                            chara._z_velocity = 10;
                        }
                        // chara._action_data.fga;
                    }else{
                        writeln("a");
                        return chara._action_data.a;
                    }
                    break;
            }
        }
        /// shoot ボタンについて
        if(ctrl.shoot.is_up()){
            gs.game.dt.add_text("shoooooooooooooooooooooooooooooooooooooooooo\noooot");
            int lc = ctrl.shoot.last_count;
            bool is_long = (lc > 10); //長押しか
            RelativeDirection5 rd = relative_direction(chara.direction, ctrl.direction5);
            bool is_power = ctrl.power.is_press; //パワーボタンが押されているかどうか
            with(RelativeDirection5)final switch(rd){
                case forward:
                    if(is_power){
                        writeln("fps");
                        // chara._action_data.fps;
                    }else{
                        writeln("fs");
                    }
                    break;
                case righthand:
                    if(is_power){
                        writeln("rps");
                        // chara._action_data.fps;
                    }else{
                        writeln("rs");
                    }
                    break;
                case back:
                    if(is_power){
                        writeln("bps");
                        // chara._action_data.fps;
                    }else{
                        writeln("bs");
                    }
                    break;
                case lefthand:
                    if(is_power){
                        writeln("lps");
                        // chara._action_data.fps;
                    }else{
                        writeln("ls");
                    }
                    break;
                case none:
                    if(is_power){
                        writeln("ps");
                        // chara._action_data.fps;
                    }else{
                        writeln("s");
                        return chara._action_data.s;
                    }
                    break;
            }
        }
        return null;
    }
    const override ActionType action_type(){
        return ActionType.normal;
    }
}
class HammerYokoAction : Action{
    this(){
        super(10);
    }
    const override Action _update(ref GameState gs, ref Character chara, in int count){
        if(count == 0){
            gs.mbm.hammer_yoko(chara.pos + vecdir(dir_to_rad(chara.direction), 12), chara.direction, 2);
        }
        return this;
    }
    const override ActionType action_type(){
        return ActionType.attack;
    }
}
class HammerTateAction : Action{
    this(){
        super(30);
    }
    const override Action _update(ref GameState gs, ref Character chara, in int count){
        if(count == 0){
            gs.mbm.hammer_tate(chara.pos + vecdir(dir_to_rad(chara.direction), 30), chara.direction, 2);
        }
        return this;
    }
    const override ActionType action_type(){
        return ActionType.attack;
    }
}
class MyShotAction : Action{
    this(){
        super(4);
    }
    const override Action _update(ref GameState gs, ref Character chara, in int count){
        if(count == 2){
            gs.mbm.myshot(chara.pos + vecdir(dir_to_rad(chara.direction), 5), chara.direction, 5);
        }
        return this;
    }
    const override ActionType action_type(){
        return ActionType.attack;
    }
}
/// ボタンに対応したアクションを登録しておくための構造体
struct ActionData{
    Action a; /// attack
    Action s; /// shoot
    Action fa; /// forward + attack
    Action fs; /// forward + shoot
    Action da; /// dash + attack
    Action ds; /// dash + shot
    //Action ba; /// back + attack
    //Action bs; /// back + shoot
    //Action la; /// lefthand + attack
    //Action ls; /// lefthand + shoot
    //Action ra; /// righthand + attack
    //Action rs; /// righthand + shoot

    //Action ca; /// charge attack
    //Action cs; /// charge shoot
    Action fga; /// forward + guard + attack
    Action fgs; /// forward + guard + shoot
    Action bga; /// back + guard + attack
    Action bgs; /// back + guard + shoot
    Action lga; /// lefthand + guard + attack
    Action lgs; /// lefthand + guard + shoot
    Action rga; /// righthand + guard + attack
    Action rgs; /// righthand + guard + shoot

    Action a_; /// attack(long)
    Action s_; /// shoot(long)
}

///
class Character : MoverH{
private:
    Direction4 direction = Direction4.b;
    CharacterFigureSet character_figure_set;
    Area _area;
    ActionData _action_data;
    double _velocity = 0;
    bool _slide_par_chip = true;
    double _walk_speed = 1*1.5;
    double _dash_speed = 2*1.5;
    Action _action = null;
    int _action_count = 0;
public:
    this(CharacterFigureSet cfs){
        this.character_figure_set = cfs;
        super(cfs.shadow);
        this._area = new RectArea(8,8);
        this.x = 100;
        this.y = 600+320;
        this._action_count = 0;
    }
    const pure int action_count(){return this._action_count;}
    void action_count(int val){this._action_count = val;}
    abstract Action default_action();
    const pure override bool out_of_screen(Rect){return false;}
    override FigureSet[] figureset(){
        final switch(this.direction){
        case Direction4.t:
            return figset(character_figure_set.top_walk);
        case Direction4.l:
            return figset(character_figure_set.left_walk);
        case Direction4.r:
            return figset(character_figure_set.right_walk);
        case Direction4.b:
            return figset(character_figure_set.bottom_walk);
        }
    }
    CharacterFigureSet figure_set(){assert(false);}
    final void update(GameState gs){
        if(this._action is null){
            this._action = this.default_action();
        }

        Action new_action = this._action.update(gs, this, this.action_count);
        if(new_action is null){
            new_action = this.default_action();
        }
        this.count = this.count + 1;
        if(new_action is this._action){
            this.action_count = this.action_count + 1;
        }else{
            this._action = new_action;
            this._action_count = 0;
        }
        /// z軸処理
        this._z += this._z_velocity;
        if(this._z > 0){ //空中にいるとき
            this._z_velocity += this._gravity;
        }else{ //地上にいるとき
            if(this._z_velocity < 0){ //今着地したとき
                assert(this._bound_k >= 0);
                this._z_velocity = - this._bound_k * this._z_velocity; //バウンド
                assert(this._z_velocity >= 0);
                if(this._z_velocity < this._bound_limit){ // バウンド速度が十分に小さいとき
                    this._z_velocity = 0; //バウンドしない
                }
            }
            this._z = 0;
        }
    }
    const pure override Area area(){return cast(Area)this._area;}
    const pure bool dashing(){
        return this._velocity >= this._dash_speed;
    }
    const pure bool walking(){
        return !this.dashing && this._velocity >= this._walk_speed;
    }
    void dash_right(GameState gs){
        this.direction = Direction4.r;
        move_right(gs, this._dash_speed);
    }
    void dash_bottom(GameState gs){
        this.direction = Direction4.b;
        move_bottom(gs, this._dash_speed);
    }
    void dash_left(GameState gs){
        this.direction = Direction4.l;
        move_left(gs, this._dash_speed);
    }
    void dash_top(GameState gs){
        this.direction = Direction4.t;
        move_top(gs, this._dash_speed);
    }
    void walk_right(GameState gs){
        move_right(gs, this._walk_speed);
    }
    void walk_bottom(GameState gs){
        move_bottom(gs, this._walk_speed);
    }
    void walk_left(GameState gs){
        move_left(gs, this._walk_speed);
    }
    void walk_top(GameState gs){
        move_top(gs, this._walk_speed);
    }
    protected void move_right(GameState gs, double val = 1.0){
        double newx = this.x + val;
        if(!gs.cd.map_rect(gs.map[0], gs.block_chip, 
                    this.area, vecpos(0,0), vecpos(newx,this.y)))
        {
            this.x = newx;
        }else{ // 移動先がブロックの場合
            this.x = floor(this.x/gs.map[0].chip_width+1)*gs.map[0].chip_width
                - this.area.width/2 -1; // 位置調整

            /// ブロックの角にぶつかった場合
            bool tr = gs.block_chip.contain(
                    gs.map[0].get_chip(this.area.top_right+this.pos+vecpos(1,0)));
            bool br = gs.block_chip.contain(
                    gs.map[0].get_chip(this.area.bottom_right+this.pos+vecpos(1,0)));
            if(tr && !br){
                if(this._slide_par_chip){
                    this.y = floor((this.area.bottom+this.y)/gs.map[0].chip_height)
                        *gs.map[0].chip_height + this.area.height/2; // 位置調整
                }else{
                    this.y = this.y + 1;
                }
            }else if(!tr && br){
                if(this._slide_par_chip){
                    this.y = floor((this.area.top+this.y)/gs.map[0].chip_height + 1)*gs.map[0].chip_height
                        - this.area.height/2 - 1; // 位置調整
                }else{
                    this.y = this.y - 1;
                }
            }
        }
    }
    ///
    protected void move_bottom(GameState gs, double val = 1.0){
        double newy = this.y + val;
        if(!gs.cd.map_rect(gs.map[0], gs.block_chip, 
                    this.area, vecpos(0,0), vecpos(this.x,newy)))
        {
            this.y = newy;
        }else{ // 移動先がブロックの場合
            this.y = floor(this.y/gs.map[0].chip_height+1)*gs.map[0].chip_height
                - this.area.height/2-1; // 位置調整

            /// ブロックの角にぶつかった場合
            bool br = gs.block_chip.contain(
                    gs.map[0].get_chip(this.area.bottom_right+this.pos+vecpos(0,1)));
            bool bl = gs.block_chip.contain(
                    gs.map[0].get_chip(this.area.bottom_left+this.pos+vecpos(0,1)));
            if(br && !bl){
                if(this._slide_par_chip){
                    this.x = floor((this.area.left+this.x)/gs.map[0].chip_width + 1)*gs.map[0].chip_width
                        - this.area.width/2 - 1; // 位置調整
                }else{
                    this.x = this.x - 1;
                }
            }else if(!br && bl){
                if(this._slide_par_chip){
                    this.x = floor((this.area.right+this.x)/gs.map[0].chip_width)
                        *gs.map[0].chip_width + this.area.width/2; // 位置調整
                }else{
                    this.x = this.x + 1;
                }
            }
        }
    }
    protected void move_left(GameState gs, double val = 1.0){
        double newx = this.x - val;
        if(!gs.cd.map_rect(gs.map[0], gs.block_chip, 
                    this.area, vecpos(0,0), vecpos(newx,this.y)))
        {
            this.x = newx;
        }else{ // 移動先がブロックの場合
            this.x = floor(this.x/gs.map[0].chip_width)*gs.map[0].chip_width
                + this.area.width/2; // 位置調整

            /// ブロックの角にぶつかった場合
            bool tl = gs.block_chip.contain(
                    gs.map[0].get_chip(this.area.top_left+this.pos+vecpos(-1,0)));
            bool bl = gs.block_chip.contain(
                    gs.map[0].get_chip(this.area.bottom_left+this.pos+vecpos(-1,0)));
            if(tl && !bl){
                if(this._slide_par_chip){
                    this.y = floor((this.area.bottom+this.y)/gs.map[0].chip_height)
                        *gs.map[0].chip_height + this.area.height/2; // 位置調整
                }else{
                    this.y = this.y + 1;
                }
            }else if(!tl && bl){
                if(this._slide_par_chip){
                    this.y = floor((this.area.top+this.y)/gs.map[0].chip_height + 1)*gs.map[0].chip_height
                        - this.area.height/2 - 1; // 位置調整
                }else{
                    this.y = this.y - 1;
                }
            }
        }
    }
    protected void move_top(GameState gs, double val = 1.0){
        double newy = this.y - val;
        if(!gs.cd.map_rect(gs.map[0], gs.block_chip, 
                    this.area, vecpos(0,0), vecpos(this.x,newy)))
        {
            this.y = newy;
        }else{ // 移動先がブロックの場合
            this.y = floor(this.y/gs.map[0].chip_height)*gs.map[0].chip_height
                + this.area.height/2; // 位置調整

            /// ブロックの角にぶつかった場合
            bool tl = gs.block_chip.contain(
                    gs.map[0].get_chip(this.area.top_left+this.pos+vecpos(0,-1)));
            bool tr = gs.block_chip.contain(
                    gs.map[0].get_chip(this.area.top_right+this.pos+vecpos(0,-1)));
            if(tl && !tr){
                if(this._slide_par_chip){
                    this.x = floor((this.area.right+this.x)/gs.map[0].chip_width)*gs.map[0].chip_width
                        + this.area.width/2; // 位置調整
                }else{
                    this.x = this.x + 1;
                }
            }else if(!tl && tr){
                if(this._slide_par_chip){
                    this.x = floor((this.area.left+this.x)/gs.map[0].chip_width + 1)*gs.map[0].chip_width
                        - this.area.width/2 - 1; // 位置調整
                }else{
                    this.x = this.x - 1;
                }
            }
        }
    }
    
}

///
class MyCharacter : Character{
    CharacterState _character_state = CharacterState.normal;
    int _action_count = 0;
    double _dash_acceleration = 0.05;
    Action _default_action;
    this(CharacterFigureSet cfs){
        super(cfs);
        this._action_data.a = new HammerYokoAction();
        this._action_data.fa = this._action_data.a;
        this._action_data.da = new HammerTateAction();
        this._action_data.s  = new MyShotAction();
        this._default_action = new MyCharaNormalAction();
        
    }
    const pure override Action default_action(){
        return cast(Action)this._default_action;
    }
    override void dash_right(GameState gs){
        final switch(this.direction){
            case Direction4.r: //加速
            case Direction4.b:
            case Direction4.t:
                if(this._velocity < this._walk_speed){
                    this._velocity = this._walk_speed;
                }else{
                    this._velocity += this._dash_acceleration;
                }
                break;
            //方向転換
            case Direction4.l:
                this._velocity = this._walk_speed;
        }
        if(this._velocity > this._dash_speed){
            this._velocity = this._dash_speed;
        }

        this.direction = Direction4.r;
        move_right(gs, this._velocity);
    }
    override void dash_bottom(GameState gs){
        final switch(this.direction){
            case Direction4.b: //加速
            case Direction4.l:
            case Direction4.r:
                if(this._velocity < this._walk_speed){
                    this._velocity = this._walk_speed;
                }else{
                    this._velocity += this._dash_acceleration;
                }
                break;
            //方向転換
            case Direction4.t:
                this._velocity = this._walk_speed;
        }
        if(this._velocity > this._dash_speed){
            this._velocity = this._dash_speed;
        }

        this.direction = Direction4.b;
        move_bottom(gs, this._velocity);
    }
    override void dash_left(GameState gs){
        final switch(this.direction){
            case Direction4.l: //加速
            case Direction4.b:
            case Direction4.t:
                if(this._velocity < this._walk_speed){
                    this._velocity = this._walk_speed;
                }else{
                    this._velocity += this._dash_acceleration;
                }
                break;
            //方向転換
            case Direction4.r:
                this._velocity = this._walk_speed;
        }
        if(this._velocity > this._dash_speed){
            this._velocity = this._dash_speed;
        }

        this.direction = Direction4.l;
        move_left(gs, this._velocity);
    }
    override void dash_top(GameState gs){
        final switch(this.direction){
            case Direction4.t: //加速
            case Direction4.l:
            case Direction4.r:
                if(this._velocity < this._walk_speed){
                    this._velocity = this._walk_speed;
                }else{
                    this._velocity += this._dash_acceleration;
                }
                break;
            //方向転換
            case Direction4.b:
                this._velocity = this._walk_speed;
        }
        if(this._velocity > this._dash_speed){
            this._velocity = this._dash_speed;
        }

        this.direction = Direction4.t;
        move_top(gs, this._velocity);
    }
    override void walk_right(GameState gs){
        this._velocity = this._walk_speed;
        move_right(gs, this._velocity);
    }
    override void walk_bottom(GameState gs){
        this._velocity = this._walk_speed;
        move_bottom(gs, this._velocity);
    }
    override void walk_left(GameState gs){
        this._velocity = this._walk_speed;
        move_left(gs, this._velocity);
    }
    override void walk_top(GameState gs){
        this._velocity = this._walk_speed;
        move_top(gs, this._velocity);
    }
}

CharacterFigureSet create_character_figure(in Figure[] figs, int X, int Y){
    CharacterFigureSet res;
    //alias create_animationfigure_from_surface af;
    double t = 0.15;
    Figure[] fig0121(Figure[] figs){
        return [figs[0], figs[1], figs[2], figs[1]];
    }
    res.bottom_walk = new AnimationFigure(fig0121(cast(Figure[])figs[X*0..X*0+3]), t, true, vecpos(0,0), 0);
    res.left_walk   = new AnimationFigure(fig0121(cast(Figure[])figs[X*1..X*1+3]), t, true, vecpos(0,0), 0);
    res.right_walk  = new AnimationFigure(fig0121(cast(Figure[])figs[X*2..X*2+3]), t, true, vecpos(0,0), 0);
    res.top_walk    = new AnimationFigure(fig0121(cast(Figure[])figs[X*3..X*3+3]), t, true, vecpos(0,0), 0);
    return res;
}
CharacterFigureSet create_character_figure(in Surface[] surs, int X, int Y){
    Figure[] figs;
    figs.length = surs.length;
    foreach(i,s; surs){
        figs[i] = new SurfaceFigure(cast(Surface)s);
    }
    return create_character_figure(figs, X, Y);
}
CharacterFigureSet create_character_figure(in Surface sur, int X, int Y){
    DividedSurface surs = div_surface_num(cast(Surface)sur, 6,4);
    return create_character_figure(surs.surface_array, X, Y);
}
CharacterFigureSet load_character_figure(string path, int X, int Y){
    Surface sur = load_surface(path);
    return create_character_figure(sur, X, Y);
}
//alias load_character_figure load_character_figure6x4;
