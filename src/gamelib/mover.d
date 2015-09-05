module gamelib.mover;

//import message;
import gamelib.all;
import mylib.list;
import std.stdio;

/// 物体 ベースクラス
abstract class Mover : Position, Direction{
    /// コンストラクタ
    this(){}
    /// x座標取得
    pure const override abstract double x();
    /// y座標取得
    pure const override abstract double y();
    /// x座標設定
    abstract void x(double);
    /// y座標設定
    abstract void y(double);
    /// 位置取得
    pure const override abstract Vector pos();
    /// 位置設定
    abstract void pos(Vector pos);
    /// 方向取得
    const pure override abstract double dir();
    /// 方向設定
    abstract void dir(double);

    /// 位置の履歴
    abstract Vector posLog(int n);
    /// 方向の履歴
    abstract double dirLog(int n);

    /// 有効かどうか取得
    const pure abstract bool isEnable();
    /// 有効かどうか設定
    abstract void isEnable(bool val);
    /// 描画するかどうか取得
    const pure abstract bool isVisible();
    /// 描画するかどうか設定
    abstract void isVisible(bool val);
    /// 描画するとき回転するかどうか取得
    const pure abstract bool isRotatable();
    /// 描画するとき回転するかどうか設定
    abstract void isRotatable(bool val);
    /// 当たり判定取得
    const pure abstract Area area();
//    abstract Figure figure();
    /// 内部カウント取得
    const pure abstract uint count();
    /// 更新 毎フレーム呼ぶ
    //abstract void update(T)(T scene);
    /// 描画時の拡大率取得
    const pure abstract double scale();
    /// 当たり判定の拡大率取得
    const pure abstract double areaScale();
    /// 描画時のBlendMode取得
    const pure abstract BlendMode blendMode();
    /// 描画時のBlendParam取得
    const pure abstract int blendParam();
    /// 描画時のbright取得
    const pure abstract Color bright();
    /// 描画
    abstract bool draw(Drawer drawer, Vector, double blend = 1.0);
    /// 当たり判定を描画
    abstract bool drawArea(Drawer drawer, Color color, Vector pos = Vector(0,0));
    /// collision managerにCollisionオブジェクトを追加
    abstract void add_collision(Vector pos, double dir, int offence, DamageType type,
            BadState, Mover mover, bool is_knockback, bool is_mybullet);
    //abstract bool detectCollision(CollisionDetector cd, Mover mover);
    /// collision managerをクリアする
    const pure abstract bool detectCollision(in CollisionDetector cd, in Mover mover);
}
/// Moverを具体的にする
abstract class MoverPlus : Mover{
private{
    Vector _pos = Vector(0,0);
    double _dir = 0;
    bool _isEnable = true;
    bool _isVisible = true;
    bool _isRotatable = true;
    uint _count      = 0;
    double _scale    = 1.0;
    double _areaScale    = 1.0;
    BlendMode _blendMode;
    int _blendParam = 255;
    immutable int _logNum = 30;
    int _currentLogIndex = 0;
    Vector[_logNum-1] _posLog;
    double[_logNum-1] _dirLog;
    Color _bright = Color(255,255,255);
    CollisionManager _collisionManager;
}
    invariant(){
        assert(_blendParam >= 0);
        assert(_blendParam < 256);
    }
    this(){
        _pos = Vector(0,0);
        _dir = 0;
        _scale = 1.0;
        _blendParam = 255;
        _isVisible = true;
        _isEnable = true;
        _collisionManager = new CollisionManager(10);
        _blendMode = BlendMode.NOBLEND;
        _currentLogIndex = 0;
        _isRotatable = true;
        super();
    }
    override Vector posLog(int n)
    in{
        assert(n<_logNum);
    }body{
        if(n==0){
            return this.pos;
        }else{
            return this._posLog[(_currentLogIndex-n+_logNum-1)%(_logNum-1)];
        }
    }
    override double dirLog(int n)
    in{
        assert(n<_logNum);
    }body{
        if(n==0){
            return this.dir;
        }else{
            return _dirLog[(_currentLogIndex-n+_logNum-1)%(_logNum-1)];
        }
    }
    pure const final override double x(){return this._pos.x; }
    pure const final override double y(){return this._pos.y; }
    final override void x(double val){this._pos.x = val; }
    final override void y(double val){this._pos.y = val; }
    pure const final override Vector pos(){return this._pos;}
    final override void pos(Vector pos){this._pos = pos; }
    const pure final override double dir(){return this._dir;}
    final override void dir(double val){this._dir = val; }

    const pure final override bool isEnable()         {return this._isEnable;}
    final override void isEnable(bool val) {this._isEnable = val;}
    const pure final override bool isVisible()        {return this._isVisible;}
    final override void isVisible(bool val){this._isVisible = val;}
    const pure final override bool isRotatable()        {return this._isRotatable;}
    final override void isRotatable(bool val){this._isRotatable = val;}
    const pure final override uint count()             {return _count;}
    final void count(uint val)              {this._count = val;}
    const pure final override double scale()           {return this._scale;}
    final void scale(double val)           {this._scale = val;}
    const pure final override double areaScale()           {return this._areaScale;}
    final void areaScale(double val)           {this._areaScale = val;}
    const pure final override Color bright()           {return this._bright;}
    final void bright(Color val)            {this._bright = val;}
    const pure final override BlendMode blendMode()   {return this._blendMode;}
    final void blendMode(BlendMode val)    {this._blendMode = val;}
    const pure final override int blendParam()      {return this._blendParam;}
    final void blendParam(int val)      {this._blendParam = val;}
    const pure final CollisionManager collisionManager()                {return cast(CollisionManager)this._collisionManager;}
    final override void add_collision(Vector pos, double dir, int offence, 
            DamageType type, BadState bad_state, Mover mover, bool is_knockback, bool is_mybullet){
        try{
            _collisionManager.collision(pos, dir, offence, type, bad_state, mover, is_knockback, is_mybullet);
        }catch(Exception e){}
    }
    abstract FigureSet[] figureSet();
    const pure override abstract Area area();
    /// 更新 毎フレーム呼ぶ
    //abstract void update(T)(T scene);
    override bool draw(Drawer drawer, Vector pos = Vector(0,0), double blend=1.0){
        bool res = true;
        foreach(fp; this.figureSet){
            auto fpfig = fp.figure;
            auto fppos = fp.pos;
            assert(fpfig !is null);
            res = res && fpfig.draw(drawer, this.pos+pos+fppos, this.dir, this.scale,
                this.blendMode, cast(int)(this.blendParam*blend), this.bright, this.isRotatable, this.count);
        }
        return res;
    }
    final override bool drawArea(Drawer drawer, Color color, Vector pos = Vector(0,0)){
        return this.area.draw(drawer, this.pos + pos, this.dir, this.areaScale, color);
    }
    const pure abstract bool outOfScreen(Rect rect);
    final void addLog(){
        _posLog[_currentLogIndex] = this.pos;
        _dirLog[_currentLogIndex] = this.dir;
        _currentLogIndex = (_currentLogIndex + 1) % (_logNum-1);
    }
    const pure final override bool detectCollision(in CollisionDetector cd, in Mover mover)
    in{
        assert(cd !is null);
        assert(mover !is null);
    }body{
        return cd.detect(this.area, mover.area, this.pos, mover.pos, this.dir, mover.dir, this.areaScale, mover.areaScale);
    }
}
