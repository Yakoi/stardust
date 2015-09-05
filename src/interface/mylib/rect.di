// D import file generated from 'mylib\rect.d'
module mylib.rect;
import mylib.vector2d;
import std.conv;
import mylib.utils;
template RectTemplate(R,T)
{
private 
{
    T l;
    T t;
    T w;
    T h;
    public 
{
        const pure T left()
{
return this.l;
}

    const pure T top()
{
return this.t;
}

    const pure T width()
{
return this.w;
}

    const pure T height()
{
return this.h;
}

    const pure T right()
{
return this.l + this.w;
}

    const pure T bottom()
{
return this.t + this.h;
}

    const pure T cx()
{
return this.l + this.w / 2;
}

    const pure T cy()
{
return this.t + this.h / 2;
}

    const pure template opAdd(V)
{
Rect opAdd(in V v)
{
return R(cast(T)(this.l + v.x),cast(T)(this.t + v.y),this.w,this.h);
}
}

    const pure template opSub(V)
{
Rect opSub(in V v)
{
return this + -v;
}
}

    const pure Rect opMul(in real d)
{
T ll = cast(T)(this.l + (this.w - this.w * d) / 2);
T tt = cast(T)(this.t + (this.h - this.h * d) / 2);
if (d < 0)
{
return R(ll,tt,0,0);
}
else
{
return R(ll,tt,cast(T)(this.w * d),cast(T)(this.h * d));
}
}

    const pure Rect opMul_r(in real d)
{
return this * d;
}

    const pure Rect opDiv(in real d)
{
return this * (1 / d);
}

    string toString()
{
string str_begin = "Rect[";
string str_sep = ",";
string str_left = to!(string)(this.left);
string str_top = to!(string)(this.top);
string str_width = to!(string)(this.width);
string str_height = to!(string)(this.height);
string str_end = "]";
return str_begin ~ str_left ~ str_sep ~ str_top ~ str_sep ~ str_width ~ str_sep ~ str_height ~ str_end;
}
}
}
}
struct Rect
{
    mixin RectTemplate!(Rect,int);
    const pure IntVector2d top_left()
{
return IntVector2d(l,t);
}

    const pure IntVector2d center_left()
{
return IntVector2d(l,t + h / 2);
}

    const pure IntVector2d bottom_left()
{
return IntVector2d(l,t + h);
}

    const pure IntVector2d top_right()
{
return IntVector2d(l + w,t);
}

    const pure IntVector2d center_right()
{
return IntVector2d(l + w,t + h / 2);
}

    const pure IntVector2d bottom_right()
{
return IntVector2d(l + w,t + h);
}

    const pure IntVector2d top_center()
{
return IntVector2d(l + w / 2,t);
}

    const pure IntVector2d center()
{
return IntVector2d(l + w / 2,t + h / 2);
}

    const pure IntVector2d bottom_center()
{
return IntVector2d(l + w / 2,t + h);
}

}
pure template rect(X,Y,Z,W)
{
Rect rect(in X l, in Y t, in Z w, in W h)
{
return Rect(cast(int)l,cast(int)t,cast(int)w,cast(int)h);
}
}

pure template rect(X,Y)
{
Rect rect(in X w, in Y h)
{
return Rect(cast(int)(-w / 2),cast(int)(-h / 2),cast(int)w,cast(int)h);
}
}

pure template box(X,Y,Z,W)
{
Rect box(in X l, in Y t, in Z r, in W b)
{
return Rect(min(cast(int)l,cast(int)r),min(cast(int)t,cast(int)b),abs(cast(int)(r - l)),abs(cast(int)(b - t)));
}
}

alias rect create_rect;
alias rect rct;
