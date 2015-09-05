module mylib.vector2d;
import std.conv;
import std.stdio;
static if(false){
    import mylib.sincos;
    import std.math : atan2, isFinite, sqrt;
}else{
    import std.math;
}


/// Vector2dのテンプレート
/// mixinして使う
/// Params:
///     T = x,yの型
///     S = 長さや角度を求めたときに返す型(float|double|real)
///     V = mixinするVectorの型を指定
/// out(res)が上手くいかないので，コメントアウトした
template Vector2dTemplate(V,T,S){
    T x=0; ///x座標
    T y=0; ///y座標
    /// 角度をラジアンで返す
    const S dir(){return atan2(cast(S)y,cast(S)x);}
    /// 長さをそのままにして角度を変える
    void dir(S val)
    in{
        assert(isFinite(val), to!(string)(val));
    }body{
        S l = this.length;
        this.x = cast(T)(l*cos(val));
        this.y = cast(T)(l*sin(val));
    }
    /// 長さを返す
    const pure S length()
    out(res){
        //assert(res>=0);
        //assert(isFinite(res));
    } body{
        return sqrt(this.length2);
    }
    /// 角度をそのままに長さを変える
    void length(S val)
    in{
        assert(isFinite(val), to!(string)(val));
    }body{
        if(this.x==0 && this.y==0){this.x=1;}
        double l = this.length;
        this.x = cast(T)(this.x*val/l);
        this.y = cast(T)(this.y*val/l);
    }
    /// 長さの二乗を返す
    /// lengthより高速
    const pure nothrow S length2()
    out(res){
        static if(true){
            //assert(isFinite(res));
            //assert(res>=0);
        }else{
            assert(res>=0, to!(string)(res));
            assert(isFinite(res), to!(string)(res));
        }
    } body {
        assert(isFinite(this.x));
        assert(isFinite(this.y));
        return cast(S)(this.x*this.x+this.y*this.y);
    }
    /// 角度をそのままに長さを1にする
    const pure V unit(){
        S l = this.length;
        return V(cast(T)(this.x/this.length), cast(T)(this.y/this.length));
    }
    /// 長さをそのままにして、角度をradだけ足す
    const pure V rotate(S rad){
        T _x = cast(T)(cos(rad) - sin(rad));
        T _y = cast(T)(sin(rad) + cos(rad));
        return V(_x, _y);
    }
    /// -v1
    const pure V opNeg(){
        return V(-this.x,-this.y);
    }
    /// v1+v2
    const pure V opAdd(X)(X v2){
        V v1 = this;
        V res = V(cast(T)(v1.x + v2.x), cast(T)(v1.y + v2.y));
        return res;
    }
    /// v1-v2
    const pure V opSub(X)(X v2){
        V v1 = this;
        V res = V(cast(T)(v1.x - v2.x), cast(T)(v1.y - v2.y));
        return res;
    }
    /// v1*d
    const pure V opMul(X)(X d){
        return V((x*d), (y*d));
    }
    /// d*v1
    const pure V opMul_r(real d){
        return V(cast(T)(x*d), cast(T)(y*d));
    }
    /// v1/d
    const pure V opDiv(S)(S d){
        return V((x/d), (y/d));
    }
    /// 内積を求める
    const pure S inner(V v2){
        return cast(S)(this.x * v2.x + this.y * v2.y);
    }
    /// 外積のz座標を求める
    const pure S outerZ(V v2){
        return cast(S)(this.x * v2.y - this.y * v2.x);
    }
    /// 文字列で返す
    const string toString(){
        return "Vector(" ~ to!(string)(x) ~ ", " ~ to!(string)(y) ~ ")";
    }
}
/// Vector2dのテンプレート
/// mixinして使う
/// Params:
///     T = x,yの型
///     S = 長さや角度を求めたときに返す型(float|double|real)
///     V = mixinするVectorの型を指定
template Vector2dTemplate_(V,T,S){
    T x=0; ///x座標
    T y=0; ///y座標
    /// 角度をラジアンで返す
    const S dir(){return atan2(cast(S)y,cast(S)x);}
    /// 長さをそのままにして角度を変える
    void dir(S val)
    in{
        assert(isFinite(val), to!(string)(val));
    }body{
        S l = this.length;
        this.x = cast(T)(l*cos(val));
        this.y = cast(T)(l*sin(val));
    }
    /// 長さを返す
    const pure S length()
    out(res){
        assert(res>=0);
        assert(isFinite(res));
    } body{
        return sqrt(this.length2);
    }
    /// 角度をそのままに長さを変える
    void length(S val)
    in{
        assert(isFinite(val), to!(string)(val));
    }body{
        if(this.x==0 && this.y==0){this.x=1;}
        double l = this.length;
        this.x = cast(T)(this.x*val/l);
        this.y = cast(T)(this.y*val/l);
    }
    /// 長さの二乗を返す
    /// lengthより高速
    const pure S length2()
    out(res){
        static if(true){
            assert(isFinite(res));
            assert(res>=0);
        }else{
            assert(res>=0, to!(string)(res));
            assert(isFinite(res), to!(string)(res));
        }
    } body {
        assert(isFinite(x));
        assert(isFinite(y));
        return cast(S)(this.x*this.x+this.y*this.y);
    }
    /// 角度をそのままに長さを1にする
    const pure V unit(){
        S l = this.length;
        return V(cast(T)(this.x/this.length), cast(T)(this.y/this.length));
    }
    /// 長さをそのままにして、角度をradだけ足す
    const pure V rotate(S rad){
        T _x = cast(T)(cos(rad) - sin(rad));
        T _y = cast(T)(sin(rad) + cos(rad));
        return V(_x, _y);
    }
    /// -v1
    const pure V opNeg(){
        return V(-this.x,-this.y);
    }
    /// v1+v2
    const pure V opAdd(X)(X v2){
        V v1 = this;
        V res = V(cast(T)(v1.x + v2.x), cast(T)(v1.y + v2.y));
        return res;
    }
    /// v1-v2
    const pure V opSub(X)(X v2){
        V v1 = this;
        V res = V(cast(T)(v1.x - v2.x), cast(T)(v1.y - v2.y));
        return res;
    }
    /// v1*d
    const pure V opMul(X)(X d){
        return V((x*d), (y*d));
    }
    /// d*v1
    const pure V opMul_r(S)(S d){
        return V((x*d), (y*d));
    }
    /// v1/d
    const pure V opDiv(S)(S d){
        return V((x/d), (y/d));
    }
    /// 内積を求める
    const pure S inner(V v2){
        return cast(S)(this.x * v2.x + this.y * v2.y);
    }
    /// 外積のz座標を求める
    const pure S outerZ(V v2){
        return cast(S)(this.x * v2.y - this.y * v2.x);
    }
    /// 文字列で返す
    const string toString(){
        return "Vector(" ~ to!(string)(x) ~ ", " ~ to!(string)(y) ~ ")";
    }
}
/// ベクトル
struct Vector2d{
    /// テンプレートをミックスイン！
    mixin Vector2dTemplate!(Vector2d, double, double);
    invariant(){
        assert(isFinite(this.x), to!(string)(this.x));
        assert(isFinite(this.y), to!(string)(this.y));
    }
    /// IntVectorにする
    const pure IntVector2d toIntVector(){
        return IntVector2d(cast(int)x, cast(int)y);
    }
}
/// ゼロベクトル
const Vector2d veczero = vecpos(0,0);
/// 初期値が(x,y)のベクトルを返す。
pure Vector2d vecpos(in double x, in double y)
in{
    //assert(isFinite(x));
    //assert(isFinite(y));
}body{
    return Vector2d(x,y);
}
/// 初期値が(l*cos(d),l*sin(d))のベクトルを返す。
pure Vector2d vecdir(in double d, in double l)
in{
    //assert(isFinite(d));
    //assert(isFinite(l));
}body{
    return  vecpos(l*cos(d),l*sin(d));
}
/// データがintの2次元ベクトル
struct IntVector2d{
    mixin Vector2dTemplate!(IntVector2d, int, double);
    const pure Vector2d toVector(){
        return vecpos(x, y);
    }
}
/// 初期値が(x,y)のベクトルを返す。
pure IntVector2d vecipos(int x, int y)
in{
    assert(isFinite(x));
    assert(isFinite(y));
}body{
    return IntVector2d(x,y);
}
/// 初期値が(l*cos(d),l*sin(d))のベクトルを返す。
pure IntVector2d vecidir(double d, double l)
in{
    assert(isFinite(d));
    assert(isFinite(l));
}body{
    return  IntVector2d(cast(int)(l*cos(d)),cast(int)(l*sin(d)));
}

const Vector2d zerovec = vecpos(0,0);
