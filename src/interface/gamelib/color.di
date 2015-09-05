// D import file generated from 'gamelib\color.d'
module gamelib.color;
import std.conv;
import dxlib.all;
import std.stdio;
import std.math;
template ColorAlphaTemplate(C,T,T MAX)
{
private 
{
    T a = 0;
    public const nothrow pure T alpha()
{
return this.a;
}


}
}
template ColorRGBTemplate(C,T,T MAX)
{
private 
{
    private T r = 0;

    private T g = 0;

    private T b = 0;

    const nothrow pure T bet(in T v)
out(res)
{
assert(0 <= res);
assert(res <= MAX);
}
body
{
return v < 0 ? 0 : MAX < v ? MAX : v;
}

    const nothrow pure C gen(in T r, in T g, in T b)
{
return C(bet(r),bet(g),bet(b));
}

    public 
{
    static assert(0 < MAX);
        const nothrow pure T red()
{
return this.r;
}

    const nothrow pure T green()
{
return this.g;
}

    const nothrow pure T blue()
{
return this.b;
}

    const nothrow pure C opAdd(in C color)
{
T r = this.red + color.red;
T g = this.green + color.green;
T b = this.blue + color.blue;
return gen(r,g,b);
}

    const nothrow pure C opSub(in C color)
{
T r = this.red - color.red;
T g = this.green - color.green;
T b = this.blue - color.blue;
return gen(r,g,b);
}

    const nothrow pure template opMul(X)
{
C opMul(in X f)
{
static if(is(X : Color))
{
T r = this.red * color.red / MAX;
T g = this.green * color.green / MAX;
T b = this.blue * color.blue / MAX;
return gen(r,g,b);
}
else
{
T r = cast(T)(this.red * f);
T g = cast(T)(this.green * f);
T b = cast(T)(this.blue * f);
return gen(r,g,b);
}

}
}

    const nothrow pure template opMul_r(X)
{
C opMul_r(in X f)
{
return this * f;
}
}

    const nothrow pure template opDiv(X)
{
C opDiv(in X f)
{
T r = cast(T)(this.red / f);
T g = cast(T)(this.green / f);
T b = cast(T)(this.blue / f);
return gen(r,g,b);
}
}

    const pure Color negative()
{
return gen(MAX - r,MAX - g,MAX - b);
}

    const string toString()
{
string rstr = to!(string)(this.red);
string gstr = to!(string)(this.green);
string bstr = to!(string)(this.blue);
return "Color(" ~ rstr ~ ", " ~ gstr ~ ", " ~ bstr ~ ")";
}

}
}
}
struct Color
{
    const MAX = 255;
    mixin ColorRGBTemplate!(Color,int,MAX);
    mixin ColorAlphaTemplate!(Color,int,MAX);
    const int dxColor()
{
return dx_GetColor(this.red256,this.green256,this.blue256);
}

    const nothrow pure ubyte red256()
{
return cast(ubyte)this.red;
}

    const nothrow pure ubyte green256()
{
return cast(ubyte)this.green;
}

    const nothrow pure ubyte blue256()
{
return cast(ubyte)this.blue;
}

    const nothrow pure ubyte alpha256()
{
return cast(ubyte)this.alpha;
}

    const nothrow pure double redReal()
{
return cast(double)this.red / Color.MAX;
}

    const nothrow pure double greenReal()
{
return cast(double)this.green / Color.MAX;
}

    const nothrow pure double blueReal()
{
return cast(double)this.blue / Color.MAX;
}

    const nothrow pure double alphaReal()
{
return cast(double)this.alpha / Color.MAX;
}

}
pure Color col(in int red, in int green, in int blue, in int alpha = 255);

alias col createColor;
immutable Color RED = col(255,0,0);

immutable Color GREEN = col(0,255,0);

immutable Color BLUE = col(0,0,255);

immutable Color WHITE = col(255,255,255);

immutable Color BLACK = col(0,0,0);

immutable Color GRAY = col(127,127,127);

immutable Color CYAN = col(0,255,255);

immutable Color MAGENTA = col(255,0,255);

immutable Color ORANGE = col(255,200,0);

immutable Color YELLOW = col(255,255,0);

immutable Color PINK = col(255,175,175);

pure Color hls(real h, real l, real s);

Color hsl(real h, real s, real l)
{
return hls(h,l,s);
}
alias hsl hsi;
pure Color rgb(real r, real g, real b)
{
return Color(cast(int)(r * 255),cast(int)(g * 255),cast(int)(b * 255));
}

Color hsv(real h, real s, real v);
pure Color cmy(real c, real m, real y)
{
return rgb(1 - c,1 - m,1 - y);
}

