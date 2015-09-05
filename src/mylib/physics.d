module mylib.physics;

import chipmunk4.all;
import std.stdio;
import std.conv;
import mylib.list;
import mylib.vector2d;
//public import chipmunk4.cpVect : cpVect;

template Phy(T){

class Physics{
    this(){
        cpInitChipmunk();
    }
}
/// 空間
class Space{
    cpSpace* _space;
package:
    VariableList!(Shape) _shape_list; //GC回避用
    //VariableList!(Shape) _static_shape_list; //GC回避用
    VariableList!(Body) _body_list; //GC回避用
    VariableList!(Joint) _joint_list; //GC回避用
    VariableList!(Collision) _collision_list;
public:
    this(){
        this._space = cpSpaceNew();
        this._shape_list     = new VariableList!(Shape);
        this._body_list      = new VariableList!(Body);
        this._joint_list     = new VariableList!(Joint);
        this._collision_list = new VariableList!(Collision);
        cpSpaceResizeStaticHash(this._space, 40.0, 999); //何かの大きさ設定？
        cpSpaceResizeActiveHash(this._space, 30.0, 2999); //何かの大きさ設定？
        //this._space.iterations = 95; //???
        this._space.elasticIterations = this._space.iterations; //弾性物体の反復処理、デフォルトを使う
    }
    ~this(){
        cpSpaceFree(this._space);
    }
    /// 重力
    void gravity(double x, double y){
        this._space.gravity = cpv(x, y);
    }
    ///空間に物質を追加
    void add_shape(Shape sh){
        assert(this._shape_list !is null);
        this._shape_list.push_front(sh);
        cpSpaceAddShape(this._space, sh._shape);
    }
    ///空間に物質を追加
    version(none)void add_static_shape(Shape sh){
        assert(this._shape_list !is null);
        this._static_shape_list.push_front(sh);
        cpSpaceAddStaticShape(this._space, sh._shape);
    }
    /// 空間にBodyを追加
    void add_body(Body bd){
        this._body_list.push_front(bd);
        cpSpaceAddBody(this._space, bd._body);
    }
    /// 空間にJointを追加
    void add_joint(Joint joint){
        this._joint_list.push_front(joint);
        cpSpaceAddJoint(this._space, joint._joint);
    }
    /// 当たり判定の種類2つを指定し，その2つの物質が当たった時の動作を登録する
    void add_collision(int collision_type1, int collision_type2, Collision col){
        static extern(Windows) int func(cpShape *a, cpShape *b, cpContact *contacts,
                    int numContacts, cpFloat normal_coef, void *data){
            collision_func f = (cast(Collision)data).get_func;
            return f(a,b,contacts, numContacts, normal_coef, data) ? 1 : 0;
        }
        _collision_list.push_front(col);
        cpSpaceAddCollisionPairFunc(this._space, collision_type1, collision_type2, &func, cast(void*)col);
    }
    void remove_shape(Shape sh){
        cpSpaceRemoveShape(this._space, sh._shape);
        sh._enable = false;
        this._shape_list.leave((Shape s){return s._enable;});
    }
    version(none)void remove_static_shape(Shape sh){
        cpSpaceRemoveStaticShape(this._space, sh._shape);
        sh._enable = false;
        this._static_shape_list.leave((Shape s){return s._enable;});
    }
    void remove_body(Body bd){
        foreach(Shape s; bd){
            assert(s !is null);
            assert(s._enable);
            this.remove_shape(s);
            //s._enable = false;
            assert(!s._enable);
        }
        cpSpaceRemoveBody(this._space, bd._body);
        bd  ._shape_list.leave((Shape s){return s._enable;});
        this._shape_list.leave((Shape s){return s._enable;});
        this._body_list .leave((Body  b){return b._enable;});
        bd._enable = false;
    }
    void remove_joint(Joint joint){
        cpSpaceRemoveJoint(this._space, joint._joint);
        joint._enable = false;
        this._joint_list.leave((Joint j){return j._enable;});
    }
    /// dt時間だけステップ
    void step(double dt){
        cpSpaceStep(this._space, dt);
    }
    /// foreach用
    int opApply(int delegate(ref cpShape*) dg){
        assert(dg !is null);
        extern(Windows) static void func(void* ptr, void* data) {
            int delegate(cpShape*) dg = *(cast(int delegate(cpShape*)*)data);
            int res = dg(cast(cpShape*)ptr);
            if(res !=0){throw new ForeachException("error", res);}
        }
        try{
            cpSpaceHashEach(this._space.activeShapes, &func, cast(void*)&dg);
            //cpSpaceHashEach(this._space.staticShapes, &func, cast(void*)&dg);
        }catch(ForeachException e){
            return e.res;
        }
        return 0;
    }
    /// foreach用
    int opApply(int delegate(ref Shape) dg){
        assert(dg !is null);
        assert(this._shape_list !is null);
        foreach(s; this._shape_list){
            assert(s !is null);
            if(s._enable){
                int res = dg(s);
                if(res != 0){return res;}
            }
        }
        return 0;
        /+

        extern(Windows) static void func(void* ptr, void* data) {
            int delegate(ref Shape) dg = *(cast(int delegate(ref Shape)*)data);
            if(ptr is null){return;}
            cpShape* cps = cast(cpShape*)ptr;
            if(cps is null){return;}
            if(cps.data is null){return;}
            auto cpd = cps.data;
            Shape sp = cast(Shape)cpd;
            if(sp is null){return;}

            int res = dg(sp);
            if(res !=0){throw new ForeachException("error", res);}
        }
        try{
            cpSpaceHashEach(this._space.activeShapes, &func, cast(void*)&dg);
            cpSpaceHashEach(this._space.staticShapes, &func, cast(void*)&dg);
        }catch(ForeachException e){
            return e.res;
        }
        return 0;
        +/
    }
    int opApply(int delegate(ref Body) dg){
        assert(dg !is null);
        assert(this._body_list !is null);
        foreach(b; this._body_list){
            assert(b !is null);
            if(b._enable){
                int res = dg(b);
                if(res != 0){return res;}
            }
        }
        return 0;
    }
    int opApply(int delegate(ref T) dg){
        assert(dg !is null);
        assert(this._body_list !is null);
        foreach(b; this._body_list){
            assert(b !is null);
            if(b._enable){
                int res = dg(b._data);
                if(res != 0){return res;}
            }
        }
        return 0;
    }
}
/// foreach中の例外
class ForeachException : Exception{
    int res;
    this(string msg, int res){
        this.res = res;
        super(msg);
    }
}
/// Spaceのforeachの実装のために必要
/// 物質の構成要素
/// Bodyの構成要素
class Shape{
//package:
    cpShape* _shape;
    bool _enable = true;
public:
    this(cpShape* sh, double elasticity, double friction)
    in{
        assert(sh !is null);
    }body{
        this._shape = sh;
        this.elasticity = elasticity; //弾性係数
        this.friction = friction; //摩擦係数
        this._shape.data = cast(void*)this;
        //this.collision_type = 0;
    }
    ~this(){
        cpShapeFree(this._shape);
    }
    ///弾性係数
    @property void elasticity(double val){
        this._shape.e = val;
    }
    ///弾性係数
    @property const pure double elasticity(){
        return this._shape.e;
    }
    ///摩擦力
    @property void friction(double val){
        this._shape.u = val;
    }
    ///摩擦力
    @property const pure double friction(){
        return this._shape.u;
    }
    /// ユーザーデータ
    @property void data(void* val){
        this._shape.data = data;
    }
    /// ユーザーデータ
    @property const pure void* data(){
        return cast(void*)this._shape.data;
    }
    @property const pure int type(){
        return this._shape.klass.type;
    }
    /// 当たり判定タイプ
    /// See_also: add_collision_func
    @property void collision_type(int val){
        this._shape.collision_type = val;
    }
    @property Body parent_body(){
        return cast(Body)this._shape.bd.data;
    }
}
/// 物質本体
/// Shapeの集合体
class Body{
protected:
    cpBody* _body;
    VariableList!(Shape) _shape_list;
    T _data;
    bool _enable = true;
public:
    void remove(Space sp){
    }
    int opApply(int delegate(ref Shape) dg){
        foreach(s; this._shape_list){
            if(s._enable){
                int res = dg(s);
                if(res != 0){return res;}
            }
        }
        return 0;
    }
    this(T data){
        this(cpFloat.infinity,cpFloat.infinity,data); //static body
    }
    /// Params:
    ///     m = 質量
    ///     km = 慣性モーメント
    this(double m, double km, T data){
        this._body = cpBodyNew(m, km); //body
        this._body.data = cast(void*)this;
        this._data = data;
        this._shape_list = new VariableList!(Shape);
    }
    ~this(){
        cpBodyFree(this._body);
    }
    /// CircleShapeの追加
    Shape add_circle(double radius, cpVect v,
            double elasticity, double friction){
        cpShape* sh = cpCircleShapeNew(this._body, radius, v);
        Shape res = new Shape(sh, elasticity, friction);
        this._shape_list.push_front(res);
        return res;
    }
    /// CircleShapeの追加
    Shape add_circle(double radius, double x, double y,
            double elasticity, double friction){
        return this.add_circle(radius, cpv(x,y), elasticity, friction);
    }
    /// CircleShapeの追加
    Shape add_circle(double radius, Vector2d v,
            double elasticity, double friction){
        return this.add_circle(radius, vector_to_cpvect(v), elasticity, friction);
    }
    /// PolyShapeの追加
    Shape add_poly(cpVect[] verts, cpVect v,
            double elasticity, double friction){
        cpShape* sh = cpPolyShapeNew(this._body, verts.length, verts.ptr, v);
        Shape res = new Shape(sh, elasticity, friction);
        this._shape_list.push_front(res);
        return res;
    }
    /// PolyShapeの追加
    Shape add_poly(cpVect[] verts, double cx, double cy,
            double elasticity, double friction){
        return this.add_poly(verts, cpv(cx,cy), elasticity, friction);
    }
    /// PolyShapeの追加
    Shape add_poly(Vector2d[] vecs, Vector2d v,
            double elasticity, double friction){
        return add_poly(vecs, v.x, v.y, elasticity, friction);
    }
    /// PolyShapeの追加
    Shape add_poly(Vector2d[] vecs, double cx, double cy,
            double elasticity, double friction){
        cpVect[] cv;
        cv.length = vecs.length;
        foreach(i,v; vecs){
            cv[i] = vector_to_cpvect(v);
        }
        return this.add_poly(cv, cx, cy, elasticity, friction);
    }
    /// SegmentShapeの追加
    Shape add_segment(cpVect v1, cpVect v2, double elasticity, double friction){
        cpShape* sh = cpSegmentShapeNew(this._body, v1, v2, 0.0f);
        Shape res = new Shape(sh, elasticity, friction);
        this._shape_list.push_front(res);
        return res;
    }
    /// SegmentShapeの追加
    Shape add_segment(double x1, double y1, double x2, double y2,
            double elasticity, double friction){
        return this.add_segment(cpv(x1,y1),cpv(x2,y2), elasticity, friction);
    }
    /// SegmentShapeの追加
    Shape add_segment(Vector2d v1, Vector2d v2,
            double elasticity, double friction){
        return this.add_segment( vector_to_cpvect(v1), vector_to_cpvect(v2),
                elasticity, friction);
    }
    /// 位置x
    @property void x(double val){
        this._body.p = cpv(val, this.y);
    }
    /// 位置x
    @property const pure double x(){
        return this._body.p.x;
    }
    /// 位置y
    @property void y(double val){
        this._body.p = cpv(this.x, val);
    }
    /// 位置y
    @property const pure double y(){
        return this._body.p.y;
    }
    /// 速度x
    @property void vx(double val){
        this._body.v = cpv(val, this._body.v.y);
    }
    /// 速度x
    @property const pure double vx(){
        return this._body.v.x;
    }
    /// 速度y
    @property void vy(double val){
        this._body.v = cpv(this._body.v.x, val);
    }
    /// 速度y
    @property const pure double vy(){
        return this._body.v.y;
    }
    /// 位置
    void set_pos(double x, double y){
        this._body.p = cpv(x,y);
    }
    /// 位置
    @property void pos(Vector2d val){
        this.set_pos(val.x, val.y);
    }
    /// 位置
    @property const pure Vector2d pos(){
        return vecpos(this.x, this.y);
    }
    /// 速度
    void vel(double x, double y){
        this._body.v = cpv(x,y);
    }
    /// 速度
    void vel(Vector2d val){
        this.vel(val.x, val.y);
    }
    /// 速度
    const pure Vector2d vel(){
        return vecpos(this.vx, this.vy);
    }
    /// 角度
    @property void angle(double val){
        cpBodySetAngle(this._body, val);
    }
    /// 角度
    @property const pure double angle(){
        return this._body.a;
    }
    /// 回転速度
    @property void angular_velocity(double val){
        this._body.w = val;
    }
    /// 回転速度
    @property const pure double angular_velocity(){
        return this._body.w;
    }
    /// 慣性の力のモーメント
    @property void moment(double val){
        cpBodySetMoment(this._body, val);
    }
    /// 慣性の力のモーメント
    @property const pure double moment(){
        return this._body.i;
    }
    /// 質量
    @property void mass(double val){
        cpBodySetMass(this._body, val);
    }
    /// 質量
    @property const pure double mass(){
        return this._body.m;
    }
    /// 力
    @property const pure Vector2d force(){
        return vecpos(this._body.f.x, this._body.f.y);
    }
    /// 力
    void set_force(double x, double y){
        this._body.f = cpv(x,y);
    }
    /// 力
    @property void force(Vector2d val){
        this.set_force(val.x, val.y);
    }
    /// 力x
    @property const pure double fx(){
        return this._body.f.x;
    }
    /// 力y
    @property const pure double fy(){
        return this._body.f.y;
    }
    /// 力x
    @property void fx(double val){
        this.set_force(val, this.fy);
    }
    /// 力x
    @property void fy(double val){
        this.set_force(this.fx, val);
    }
    /// トルク，回転モーメント
    @property void torque(double val){
        this._body.t = val;
    }
    /// トルク，回転モーメント
    @property const pure double torque(){
        return this._body.t;
    }
    /// テンプレートで指定したデータ
    @property const pure T data(){
        return cast(T)this._data;
    }
}

/// ジョイントベースクラス
protected class Joint{
    cpJoint* _joint;
    bool _enable = true;
    this(cpJoint* joint){
        this._joint = joint;
    }
    ~this(){
        cpJointFree(this._joint);
    }
}

/// ピンジョイント
/// 指定した点同士が一定距離を保つ
class PinJoint : Joint{
    this(Body bd1, Body bd2, Vector2d vec1, Vector2d vec2){
        cpJoint* joint = cpPinJointNew(bd1._body, bd2._body, 
                vector_to_cpvect(vec1), vector_to_cpvect(vec2));
        super(joint);
    }
    this(Body bd1, Body bd2){
        this(bd1, bd2, vecpos(0,0), vecpos(0,0));
    }
}
/// スライドジョイント
/// 指定した点同士がmin以上max以下の距離を保つ
class SlideJoint : Joint{
    this(Body bd1, Body bd2, Vector2d vec1, Vector2d vec2,
            double min = 0, double max = double.infinity){
        cpJoint* joint = cpSlideJointNew(bd1._body, bd2._body,
                vector_to_cpvect(vec1), vector_to_cpvect(vec2),
                min, max);
        super(joint);
    }
    this(Body bd1, Body bd2, double min = 0, double max = double.infinity){
        this(bd1, bd2, vecpos(0,0), vecpos(0,0), min, max);
    }
}
/// ピボットジョイント
/// 指定した点からBodyまでの距離が一定
class PivotJoint : Joint{
    this(Body bd1, Body bd2, Vector2d pivot = vecpos(0,0)){
        cpJoint* joint = cpPivotJointNew(bd1._body, bd2._body, vector_to_cpvect(pivot));
        super(joint);
    }
}
/// よく解らんジョイント
class GrooveJoint : Joint{
    this(Body bd1, Body bd2, Vector2d groove_a, Vector2d groove_b, Vector2d anchr2){
        cpJoint* joint = cpGrooveJointNew(bd1._body, bd2._body,
                vector_to_cpvect(groove_a), vector_to_cpvect(groove_b),
                vector_to_cpvect(anchr2));
        super(joint);
    }
}

private cpVect vector_to_cpvect(Vector2d v){
    return cpv(v.x, v.y);
}
private Vector2d cpvect_to_vector(cpVect v){
    return vecpos(v.x, v.y);
}

alias bool delegate(cpShape *a, cpShape *b, cpContact *contacts, int numContacts, cpFloat normal_coef, void *data) collision_func;
/// 衝突時に呼ばれるクラス
/// コールバック関数の代わり
class Collision{
    this(){
    }
    abstract bool func(Shape sh1, Shape sh2);
    private collision_func get_func(){
        return (cpShape *a, cpShape *b, cpContact *contacts,
                int numContacts, cpFloat normal_coef, void *data)
        {
            return func(cast(Shape)a.data, cast(Shape)b.data);
        };
    }
}
/// 衝突しても何もしない
class NoCollision : Collision{
    override bool func(Shape sh1, Shape sh2){
        return false;
    }
}
/// 衝突したら普通の反応
class NormalCollision : Collision{
    override bool func(Shape sh1, Shape sh2){
        return true;
    }
}
/// 衝突したら関数を呼び出す
class FunctionCollision : Collision{
private:
    bool delegate() _dg0 = null;
    bool delegate(Shape, Shape) _dg2 = null;
    bool function() _func0 = null;
public:
    this(bool delegate() dg){
        this._dg0 = dg;
    }
    this(bool delegate(Shape, Shape) dg){
        this._dg2 = dg;
    }
    this(bool function() func){
        this._func0 = func;
    }
    override bool func(Shape sh1, Shape sh2){
        if(this._dg0){
            return this._dg0();
        }else if(this._dg2){
            return this._dg2(sh1, sh2);
        }else if(this._func0){
            return this._func0();
        }else{
            assert(false);
        }
    }
}

}
