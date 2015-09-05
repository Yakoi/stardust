module mylib.physics;

import chipmunk4.all;
import std.stdio;
import std.conv;
import mylib.list;
import mylib.vector2d;
//public import chipmunk4.cpVect : cpVect;

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
    VariableList!(Body) _body_list; //GC回避用
    VariableList!(Joint) _joint_list; //GC回避用
    VariableList!(P1) _p1_list;
public:
    this(){
        this._space = cpSpaceNew();
        this._shape_list = new VariableList!(Shape);
        this._body_list = new VariableList!(Body);
        this._joint_list = new VariableList!(Joint);
        cpSpaceResizeStaticHash(this._space, 40.0, 999); //何かの大きさ設定？
        cpSpaceResizeActiveHash(this._space, 30.0, 2999); //何かの大きさ設定？
        this._space.iterations = 95; //???
        this._space.elasticIterations = this._space.iterations; //弾性物体の反復処理、デフォルトを使う
        list = new VariableList!(bool delegate());
        list2 = new VariableList!(P);
        _p1_list = new VariableList!(P1);
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
    void add_static_shape(Shape sh){
        assert(this._shape_list !is null);
        this._shape_list.push_front(sh);
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
    class P1{
        bool delegate(cpShape *a, cpShape *b, cpContact *contacts, int numContacts, cpFloat normal_coef, void *data) f;
    }
    alias bool delegate(cpShape *a, cpShape *b, cpContact *contacts, int numContacts, cpFloat normal_coef, void *data) p1func;
    /// 当たり判定の種類2つを指定し，その2つの物質が当たった時の動作を登録する
    void add_collision_func(int collision_type1, int collision_type2, p1func f){
        static extern(Windows) int func(cpShape *a, cpShape *b, cpContact *contacts,
                    int numContacts, cpFloat normal_coef, void *data){
            p1func f = (cast(P1)data).f;
            return f(a,b,contacts, numContacts, normal_coef, data) ? 1 : 0;
        }
        P1 p = new P1;
        p.f = f;
        _p1_list.push_front(p);
        cpSpaceAddCollisionPairFunc(this._space, collision_type1, collision_type2, &func, cast(void*)p);
    }
    void add_collision_func(int collision_type1, int collision_type2, bool delegate(Shape, Shape) f){
        bool fun(cpShape *a, cpShape *b, cpContact *contacts, int numContacts, cpFloat normal_coef, void *data){
            return f(cast(Shape)a.data, cast(Shape)b.data);
        }
        this.add_collision_func(collision_type1, collision_type2, &fun);
    }
    /// 当たり判定の種類2つを指定し，その2つの物質が当たった時の動作を登録する
    void add_collision_func(int collision_type1, int collision_type2, bool delegate(cpShape*, cpShape*) f){
        static extern(Windows) int func(cpShape *a, cpShape *b, cpContact *contacts,
                    int numContacts, cpFloat normal_coef, void *data){
            bool delegate(cpShape*, cpShape*) f = *(cast(bool delegate(cpShape*, cpShape*)*)data);
            return f(a,b) ? 1 : 0;
        }
        cpSpaceAddCollisionPairFunc(this._space, collision_type1, collision_type2, &func, cast(void*)&f);
    }
    class P{
        bool delegate() f;
    }
    void add_collision_func(int collision_type1, int collision_type2, bool delegate() ff){
        static extern(Windows) int func(cpShape *a, cpShape *b, cpContact *contacts,
                    int numContacts, cpFloat normal_coef, void *data){
            P f = (cast(P)data);
            return f.f() ? 0 : 1;
        }
        P p = new P;
        p.f = ff;
        list2.push_front(p);

        cpSpaceAddCollisionPairFunc(this._space, collision_type1, collision_type2, &func, cast(void*)p);
    }
    VariableList!(bool delegate()) list;
    VariableList!(P) list2;
    void add_collision_func(int collision_type1, int collision_type2, bool function() ff){
        extern(Windows) static int func(cpShape *a, cpShape *b, cpContact *contacts,
                    int numContacts, cpFloat normal_coef, void *data){
            bool function() f = (cast(bool function())data);
            return f() ? 1 : 0;
        }
        cpSpaceAddCollisionPairFunc(this._space, collision_type1, collision_type2, &func, cast(void*)ff);
    }
    void remove_shape(Shape sh){
        cpSpaceRemoveShape(this._space, sh._shape);
    }
    void remove_static_shape(Shape sh){
        cpSpaceRemoveStaticShape(this._space, sh._shape);
    }
    void remove_body(Body bd){
        cpSpaceRemoveBody(this._space, bd._body);
    }
    void remove_joint(Joint joint){
        cpSpaceRemoveJoint(this._space, joint._joint);
    }
    /// dt時間だけステップ
    void step(double dt){
        cpSpaceStep(this._space, dt);
    }
    /// foreach用
    int opApply(int delegate(ref cpShape*) dg){
        extern(Windows) static void func(void* ptr, void* data) {
            int delegate(cpShape*) dg = *(cast(int delegate(cpShape*)*)data);
            int res = dg(cast(cpShape*)ptr);
            if(res !=0){throw new ForeachException("error", res);}
        }
        try{
            cpSpaceHashEach(this._space.activeShapes, &func, cast(void*)&dg);
            cpSpaceHashEach(this._space.staticShapes, &func, cast(void*)&dg);
        }catch(ForeachException e){
            return e.res;
        }
        return 0;
    }
    /// foreach用
    int opApply(int delegate(ref Shape) dg){
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
public:
    this(){
        this(cpFloat.infinity,cpFloat.infinity); //static body
    }
    /// Params:
    ///     m = 質量
    ///     km = 慣性モーメント
    this(double m, double km){
        this._body = cpBodyNew(m, km); //body
        this._body.data = cast(void*)this;
    }
    ~this(){
        cpBodyFree(this._body);
    }
    /// CircleShapeの追加
    Shape add_circle(double radius, double x, double y,
            double elasticity, double friction){
        cpShape* sh = cpCircleShapeNew(this._body, radius, cpv(x,y));
        return new Shape(sh, elasticity, friction);
    }
    /// PolyShapeの追加
    Shape add_poly(cpVect[] verts, double cx, double cy,
            double elasticity, double friction){
        cpShape* sh = cpPolyShapeNew(this._body, verts.length, verts.ptr, cpv(cx,cy));
        auto res = new Shape(sh, elasticity, friction);
        return res;
    }
    /// SegmentShapeの追加
    Shape add_segment(double x1, double y1, double y2, double x2,
            double elasticity, double friction){
        cpShape* sh = cpSegmentShapeNew(this._body, cpv(x1,y1), cpv(x2,y2), 0.0f);
        return new Shape(sh, elasticity, friction);
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
}

protected class Joint{
    cpJoint* _joint;
    this(cpJoint* joint){
        this._joint = joint;
    }
    ~this(){
        cpJointFree(this._joint);
    }
}

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
class PivotJoint : Joint{
    this(Body bd1, Body bd2, Vector2d pivot = vecpos(0,0)){
        cpJoint* joint = cpPivotJointNew(bd1._body, bd2._body, vector_to_cpvect(pivot));
        super(joint);
    }
}
class GrooveJoint : Joint{
    this(Body bd1, Body bd2, Vector2d groove_a, Vector2d groove_b, Vector2d anchr2){
        cpJoint* joint = cpGrooveJointNew(bd1._body, bd2._body,
                vector_to_cpvect(groove_a), vector_to_cpvect(groove_b),
                vector_to_cpvect(anchr2));
        super(joint);
    }
}
    cpJoint *cpGrooveJointNew(cpBody *a, cpBody *b, cpVect groove_a, cpVect groove_b, cpVect anchr2);

private cpVect vector_to_cpvect(Vector2d v){
    return cpv(v.x, v.y);
}
private Vector2d cpvect_to_vector(cpVect v){
    return vecpos(v.x, v.y);
}
