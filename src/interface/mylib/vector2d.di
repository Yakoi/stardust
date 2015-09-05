// D import file generated from 'mylib\vector2d.d'
module mylib.vector2d;
import std.conv;
import std.stdio;
static if(false)
{
    import mylib.sincos;
    import std.math;
}
else
{
    import std.math;
}
template Vector2dTemplate(V,T,S)
{
T x = 0;
T y = 0;
const S dir()
{
return atan2(cast(S)y,cast(S)x);
}

void dir(S val)
in
{
assert(isFinite(val),to!(string)(val));
}
body
{
S l = this.length;
this.x = cast(T)(l * cos(val));
this.y = cast(T)(l * sin(val));
}
const pure S length()
out(res)
{
}
body
{
return sqrt(this.length2);
}

void length(S val)
in
{
assert(isFinite(val),to!(string)(val));
}
body
{
if (this.x == 0 && this.y == 0)
{
this.x = 1;
}
double l = this.length;
this.x = cast(T)(this.x * val / l);
this.y = cast(T)(this.y * val / l);
}
const nothrow pure S length2()
out(res)
{
static if(true)
{
}
else
{
assert(res >= 0,to!(string)(res));
assert(isFinite(res),to!(string)(res));
}

}
body
{
assert(isFinite(this.x));
assert(isFinite(this.y));
return cast(S)(this.x * this.x + this.y * this.y);
}

const pure V unit()
{
S l = this.length;
return V(cast(T)(this.x / this.length),cast(T)(this.y / this.length));
}

const pure V rotate(S rad)
{
T _x = cast(T)(cos(rad) - sin(rad));
T _y = cast(T)(sin(rad) + cos(rad));
return V(_x,_y);
}

const pure V opNeg()
{
return V(-this.x,-this.y);
}

const pure template opAdd(X)
{
V opAdd(X v2)
{
V v1 = this;
V res = V(cast(T)(v1.x + v2.x),cast(T)(v1.y + v2.y));
return res;
}
}

const pure template opSub(X)
{
V opSub(X v2)
{
V v1 = this;
V res = V(cast(T)(v1.x - v2.x),cast(T)(v1.y - v2.y));
return res;
}
}

const pure template opMul(X)
{
V opMul(X d)
{
return V(x * d,y * d);
}
}

const pure V opMul_r(real d)
{
return V(cast(T)(x * d),cast(T)(y * d));
}

const pure template opDiv(S)
{
V opDiv(S d)
{
return V(x / d,y / d);
}
}

const pure S inner(V v2)
{
return cast(S)(this.x * v2.x + this.y * v2.y);
}

const pure S outerZ(V v2)
{
return cast(S)(this.x * v2.y - this.y * v2.x);
}

const string toString()
{
return "Vector(" ~ to!(string)(x) ~ ", " ~ to!(string)(y) ~ ")";
}

}
template Vector2dTemplate_(V,T,S)
{
T x = 0;
T y = 0;
const S dir()
{
return atan2(cast(S)y,cast(S)x);
}

void dir(S val)
in
{
assert(isFinite(val),to!(string)(val));
}
body
{
S l = this.length;
this.x = cast(T)(l * cos(val));
this.y = cast(T)(l * sin(val));
}
const pure S length()
out(res)
{
assert(res >= 0);
assert(isFinite(res));
}
body
{
return sqrt(this.length2);
}

void length(S val)
in
{
assert(isFinite(val),to!(string)(val));
}
body
{
if (this.x == 0 && this.y == 0)
{
this.x = 1;
}
double l = this.length;
this.x = cast(T)(this.x * val / l);
this.y = cast(T)(this.y * val / l);
}
const pure S length2()
out(res)
{
static if(true)
{
assert(isFinite(res));
assert(res >= 0);
}
else
{
assert(res >= 0,to!(string)(res));
assert(isFinite(res),to!(string)(res));
}

}
body
{
assert(isFinite(x));
assert(isFinite(y));
return cast(S)(this.x * this.x + this.y * this.y);
}

const pure V unit()
{
S l = this.length;
return V(cast(T)(this.x / this.length),cast(T)(this.y / this.length));
}

const pure V rotate(S rad)
{
T _x = cast(T)(cos(rad) - sin(rad));
T _y = cast(T)(sin(rad) + cos(rad));
return V(_x,_y);
}

const pure V opNeg()
{
return V(-this.x,-this.y);
}

const pure template opAdd(X)
{
V opAdd(X v2)
{
V v1 = this;
V res = V(cast(T)(v1.x + v2.x),cast(T)(v1.y + v2.y));
return res;
}
}

const pure template opSub(X)
{
V opSub(X v2)
{
V v1 = this;
V res = V(cast(T)(v1.x - v2.x),cast(T)(v1.y - v2.y));
return res;
}
}

const pure template opMul(X)
{
V opMul(X d)
{
return V(x * d,y * d);
}
}

const pure template opMul_r(S)
{
V opMul_r(S d)
{
return V(x * d,y * d);
}
}

const pure template opDiv(S)
{
V opDiv(S d)
{
return V(x / d,y / d);
}
}

const pure S inner(V v2)
{
return cast(S)(this.x * v2.x + this.y * v2.y);
}

const pure S outerZ(V v2)
{
return cast(S)(this.x * v2.y - this.y * v2.x);
}

const string toString()
{
return "Vector(" ~ to!(string)(x) ~ ", " ~ to!(string)(y) ~ ")";
}

}
struct Vector2d
{
    mixin Vector2dTemplate!(Vector2d,double,double);
        const pure IntVector2d toIntVector()
{
return IntVector2d(cast(int)x,cast(int)y);
}

}
pure Vector2d vecpos(in double x, in double y)
in
{
}
body
{
return Vector2d(x,y);
}

pure Vector2d vecdir(in double d, in double l)
in
{
}
body
{
return vecpos(l * cos(d),l * sin(d));
}

struct IntVector2d
{
    mixin Vector2dTemplate!(IntVector2d,int,double);
    const pure Vector2d toVector()
{
return vecpos(x,y);
}

}
pure IntVector2d vecipos(int x, int y)
in
{
assert(isFinite(x));
assert(isFinite(y));
}
body
{
return IntVector2d(x,y);
}

pure IntVector2d vecidir(double d, double l)
in
{
assert(isFinite(d));
assert(isFinite(l));
}
body
{
return IntVector2d(cast(int)(l * cos(d)),cast(int)(l * sin(d)));
}

const Vector2d zerovec = vecpos(0,0);

