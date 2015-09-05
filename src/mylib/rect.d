
module mylib.rect;
import mylib.vector2d;
import std.conv;
import mylib.utils;

/// Rectのテンプレート
/// mixinして使う
/// Params:
///     T = l,t,w,hの型
///     R = mixinするRectの型を指定
template RectTemplate(R,T){
private:
    T l, t, w, h;
public:
    invariant(){
        assert(w>=0);
        assert(h>=0);
    }
    /// 左
    const pure T left(){return this.l;}
    /// 上
    const pure T top(){return this.t;}
    /// 幅
    const pure T width(){return this.w;}
    /// 高さ
    const pure T height(){return this.h;}
    /// 右
    const pure T right(){return this.l+this.w;}
    /// 下
    const pure T bottom(){return this.t+this.h;}
    /// 中心x
    const pure T cx(){return this.l+this.w/2;}
    /// 中心y
    const pure T cy(){return this.t+this.h/2;}
    /// r1 + r2
    const pure Rect opAdd(V)(in V v){
        return R(cast(T)(this.l+v.x), cast(T)(this.t+v.y), this.w, this.h);
    }
    /// r1 - r2
    const pure Rect opSub(V)(in V v){
        return this + (-v);
        //return R(cast(T)(this.l-v.x), cast(T)(this.t-v.y), this.w, this.h);
    }
    /// d * r
    const pure Rect opMul(in real d){
        T ll = cast(T)(this.l + (this.w - this.w*d)/2);
        T tt = cast(T)(this.t + (this.h - this.h*d)/2);
        if(d<0){
            return R(ll, tt, 0, 0);
        }else{
            return R(ll, tt, cast(T)(this.w*d), cast(T)(this.h*d));
        }
    }
    /// d * r
    const pure Rect opMul_r(in real d){
        return this * d;
    }
    /// d / r
    const pure Rect opDiv(in real d){
        return this * (1.0/d);
    }
    /// 文字列にする
    string toString(){
        string str_begin = "Rect[";
        string str_sep = ",";
        string str_left = to!(string)(this.left);
        string str_top =  to!(string)(this.top);
        string str_width = to!(string)(this.width);
        string str_height = to!(string)(this.height);
        string str_end = "]";
        return str_begin ~ str_left ~ str_sep ~ str_top ~ str_sep
            ~ str_width ~ str_sep ~str_height ~ str_end;
    }
}
/// データがintの長方形
struct Rect{
    mixin RectTemplate!(Rect, int);
    /// 左上座標
    const pure IntVector2d top_left()     {return IntVector2d(l    , t    );}
    /// 中央左座標
    const pure IntVector2d center_left()  {return IntVector2d(l    , t+h/2);}
    /// 左下座標
    const pure IntVector2d bottom_left()  {return IntVector2d(l    , t+h  );}
    /// 右上座標
    const pure IntVector2d top_right()    {return IntVector2d(l+w  , t    );}
    /// 中央右座標
    const pure IntVector2d center_right() {return IntVector2d(l+w  , t+h/2);}
    /// 右下座標
    const pure IntVector2d bottom_right() {return IntVector2d(l+w  , t+h  );}
    /// 中央上座標
    const pure IntVector2d top_center()   {return IntVector2d(l+w/2, t    );}
    /// 中心座標
    const pure IntVector2d center()       {return IntVector2d(l+w/2, t+h/2);}
    /// 中央下座標
    const pure IntVector2d bottom_center(){return IntVector2d(l+w/2, t+h  );}
}
/// データをセット
pure Rect rect(X,Y,Z,W)(in X l, in Y t, in Z w, in W h){
    return Rect(cast(int)l, cast(int)t, cast(int)w,  cast(int)h);
}
/// データをセット(-w/2, -h/2, w/2, h/2)
pure Rect rect(X,Y)(in X w, in Y h){
    return Rect(cast(int)(-w/2), cast(int)(-h/2), cast(int)(w),  cast(int)(h));
}
///
pure Rect box(X,Y,Z,W)(in X l, in Y t, in Z r, in W b){
    return Rect(min(cast(int)l, cast(int)r), min(cast(int)t, cast(int)b), 
            abs(cast(int)(r-l)),  abs(cast(int)(b-t)));
}
/// alias
alias rect createRect;
alias rect rct;
