module gamelib.color;

import std.conv;
import dxlib.all;
import std.stdio;
import std.math;

/// alphaのタメのテンプレート
template ColorAlphaTemplate(C,T,T MAX){
private:
    T a = 0;
public:
    const pure nothrow T alpha(){
        return this.a;
    }

}
/// 色構造体のためのテンプレート
template ColorRGBTemplate(C,T,T MAX){
private:
    private T r = 0;
    private T g = 0;
    private T b = 0;
    // genのための関数
    const pure nothrow T bet(in T v)
    out(res){
        assert(0<=res);
        assert(res<=MAX);
    }body{
        return (v<0) ? 0 : ((MAX<v) ? MAX : v);
    }
    const nothrow pure C gen(in T r, in T g, in T b){
        return C(bet(r), bet(g), bet(b));
    }
public:

    static assert(0<MAX);

    //void r(T val){this.red   = val;}
    //void g(T val){this.green = val;}
    //void b(T val){this.blue  = val;}
    invariant(){
        assert(0<=r && r<=MAX, to!(string)(this.r)); 
        assert(0<=g && g<=MAX, to!(string)(this.g)); 
        assert(0<=b && b<=MAX, to!(string)(this.b)); 
    }
    /// 赤成分を取得
    /+@property+/const pure nothrow T red  (){return this.r;}
    /// 緑成分を取得
    /+@property+/const pure nothrow T green(){return this.g;}
    /// 青成分を取得
    /+@property+/const pure nothrow T blue (){return this.b;}
    /// c1 + c2
    const pure nothrow C opAdd(in C color){
        T r = this.red   + color.red  ;
        T g = this.green + color.green;
        T b = this.blue  + color.blue ;
        return gen(r,g,b);
    }
    /// c1 - c2
    const pure nothrow C opSub(in C color){
        T r = this.red   - color.red;
        T g = this.green - color.green;
        T b = this.blue  - color.blue;
        return gen(r,g,b);
    }
    /+
    const pure C opMul(in C color){
        int red   = this.red   * color.red   / MAX;
        int green = this.green * color.green / MAX;
        int blue  = this.blue  * color.blue  / MAX;
        return C(red,green,blue);
    }+/
    /// c1 * f
    const pure nothrow C opMul(X)(in X f){
        static if(is(X : Color)){
            T r = this.red   * color.red   / MAX;
            T g = this.green * color.green / MAX;
            T b = this.blue  * color.blue  / MAX;
            return gen(r,g,b);
        }else{
            T r = cast(T)(this.red   * f);
            T g = cast(T)(this.green * f);
            T b = cast(T)(this.blue  * f);
            return gen(r,g,b);
        }
    }
    /// f * c1 
    const pure nothrow C opMul_r(X)(in X f){
        return this * f;
    }
    /// c / f
    const pure nothrow C opDiv(X)(in X f){
        T r = cast(T)(this.red   / f);
        T g = cast(T)(this.green / f);
        T b = cast(T)(this.blue  / f);
        return gen(r,g,b);
    }
    const pure Color negative(){
        return gen(MAX-r, MAX-g, MAX-b);
    }
    const string toString(){
        string rstr = to!(string)(this.red  );
        string gstr = to!(string)(this.green);
        string bstr = to!(string)(this.blue );
        return "Color(" ~ rstr ~ ", " ~ gstr ~ ", " ~ bstr ~ ")";
    }
}

/// 色の構造体の本体
struct Color{
    const MAX = 255;
    mixin ColorRGBTemplate!(Color, int, MAX);
    mixin ColorAlphaTemplate!(Color, int, MAX);

    const int dxColor(){
        return dx_GetColor(this.red256, this.green256, this.blue256);
    }

    /// ubyteで値を取得(赤)
    const pure nothrow ubyte red256  (){return cast(ubyte)this.red;}
    /// ubyteで値を取得(緑)
    const pure nothrow ubyte green256(){return cast(ubyte)this.green;}
    /// ubyteで値を取得(青)
    const pure nothrow ubyte blue256 (){return cast(ubyte)this.blue;}
    /// ubyteで値を取得(alpha)
    const pure nothrow ubyte alpha256 (){return cast(ubyte)this.alpha;}
    /// doubleで値を取得(赤)
    const pure nothrow double redReal  (){return cast(double)this.red  /Color.MAX;}
    /// doubleで値を取得(緑)
    const pure nothrow double greenReal(){return cast(double)this.green/Color.MAX;}
    /// doubleで値を取得(青)
    const pure nothrow double blueReal (){return cast(double)this.blue /Color.MAX;}
    /// doubleで値を取得(青)
    const pure nothrow double alphaReal (){return cast(double)this.alpha /Color.MAX;}
}
/// 色を作ります
pure Color col(in int red, in int green, in int blue, in int alpha = 255){
    int r = red;
    int g = green;
    int b = blue;
    int a = alpha;
    if(r >255){ r =255; }
    if(g >255){ g =255; }
    if(b >255){ b =255; }
    if(a >255){ a =255; }
    if(r <  0){ r =  0; }
    if(g <  0){ g =  0; }
    if(b <  0){ b =  0; }
    if(a <  0){ a =  0; }
    assert(0<=r && r<=255); 
    assert(0<=g && g<=255); 
    assert(0<=b && b<=255); 
    assert(0<=a && a<=255); 
    return Color(r,g,b,a);
    //return Color(between(0,red,255) ,between(0,green,255), between(0,blue,255));
}
/// 色を作ります
alias col createColor;

immutable Color RED     = col(255,  0,  0); ///赤色
immutable Color GREEN   = col(  0,255,  0); ///緑色
immutable Color BLUE    = col(  0,  0,255); ///青色
immutable Color WHITE   = col(255,255,255); ///白色
immutable Color BLACK   = col(  0,  0,  0); ///黒色
immutable Color GRAY    = col(127,127,127); ///灰色
immutable Color CYAN    = col(  0,255,255); ///シアン
immutable Color MAGENTA = col(255,  0,255); ///マゼンタ
immutable Color ORANGE  = col(255,200,  0); ///オレンジ
immutable Color YELLOW  = col(255,255,  0); ///黄色
immutable Color PINK    = col(255,175,175); ///ピンク

/// hls to color
/// http://image-d.isp.jp/commentary/color_cformula/HLS.html
/// Params:
///     h = 色相[0,360]
///     l = 彩度[0,1]
///     s = 輝度[0,1]
pure Color hls(real h, real l, real s)
in{
    assert(0<=l);
    assert(l<=1);
    assert(0<=s);
    assert(s<=1);
}body{
    real r;
    real g;
    real b;
    real h_ = (h)%360;
    real max = l<= 0.5 ? l*(1+s) : l*(1-s)+s;
    real min = 2*l - max;
    if(s==0){
        r=l; g=l; b=l;
    }else{
        real rh= (h_+120)%360;
        if(0<=rh && rh < 60) {r = min+(max-min)*rh/60;}
        else if(rh<180)      {r = max;}
        else if(rh<240)      {r = min+(max-min)*(240-rh)/60;}
        else if(rh<360)      {r = min;}
        else{assert(false);}

        real gh = h_;
        if(0<=gh  && gh< 60) {g = min+(max-min)*gh/60;}
        else if(gh<180)      {g = max;}
        else if(gh<240)      {g = min+(max-min)*(240-gh)/60;}
        else if(gh<360)      {g = min;}
        else{assert(false);}

        real bh = h_-120;
        if(bh<0){bh += 360;}
        if(0<=bh && bh < 60) {b = min+(max-min)*bh/60;}
        else if(bh<180)      {b = max;}
        else if(bh<240)      {b = min+(max-min)*(240-bh)/60;}
        else if(bh<360)      {b = min;}
        else{assert(false);}
    }
    //writeln(r," ",g," ",b);
    return rgb(r,g,b);
}
Color hsl(real h, real s, real l){
    return hls(h,l,s);
}
alias hsl hsi;

///
pure Color rgb(real r, real g, real b){
    return Color(cast(int)(r*255),cast(int)(g*255),cast(int)(b*255));
}

///
/// Params:
///     h = 色相[0,360]
///     s = 彩度[0,1]
///     v = 明度[0,1]
Color hsv(real h, real s, real v)
in{
    assert(0<=s);
    assert(s<=1);
    assert(0<=v);
    assert(v<=1);
}out(res){
    //writeln(res);
}body{
    h = h%360;
    if(s==0){return rgb(v,v,v);}
    int hi = cast(int)floor(cast(real)h/60.0);
    real f = (cast(real)h)/60.0 - hi;
    real m = v * (1-s);
    real n = v * (1-s*f);
    real k = v * (1-(1-f)*s);
    switch(hi){
    case 0:
        return rgb(v,k,m);
    case 1:
        return rgb(n,v,m);
    case 2:
        return rgb(m,v,k);
    case 3:
        return rgb(m,n,v);
    case 4:
        return rgb(k,m,v);
    case 5:
        return rgb(v,m,n);
    default:
        assert(false);
    }
}

/// 減法混色
pure Color cmy(real c, real m, real y){
    return rgb(1-c, 1-m, 1-y);
}
