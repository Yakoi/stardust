// D import file generated from 'mylib\matrix.d'
module mylib.matrix;
import mylib.vector2d;
import std.stdio;
import std.conv;
import std.math;
template Matrix2dTemplate(M,T)
{
T a;
T b;
T c;
T d;
T get(int i, int j)
in
{
assert(0 <= i && i <= 1);
assert(0 <= j && j <= 1);
}
body
{
if (i == 0)
{
if (j == 0)
{
return this.a;
}
else
{
return this.b;
}
}
else
{
if (j == 0)
{
return this.c;
}
else
{
return this.d;
}
}
}
void set(int i, int j, T val)
in
{
assert(0 <= i && i <= 1);
assert(0 <= j && j <= 1);
}
body
{
if (i == 0)
{
if (j == 0)
{
this.a = val;
}
else
{
this.b = val;
}
}
else
{
if (j == 0)
{
this.c = val;
}
else
{
this.d = val;
}
}
}
T opIndex(int i, int j)
in
{
assert(0 <= i && i <= 1);
assert(0 <= j && j <= 1);
}
body
{
return this.get(i,j);
}
M opMul(M mat2)
{
M res;
M mat1 = this;
res.set(0,0,mat1[0,0] * mat2[0,0] + mat1[0,1] * mat2[1,0]);
res.set(0,1,mat1[0,0] * mat2[0,1] + mat1[0,1] * mat2[1,1]);
res.set(1,0,mat1[1,0] * mat2[0,0] + mat1[1,1] * mat2[1,0]);
res.set(1,1,mat1[1,0] * mat2[0,1] + mat1[1,1] * mat2[1,1]);
return res;
}
M opMul(real val)
{
M res;
M mat1 = this;
res.set(0,0,mat1[0,0] * val);
res.set(0,1,mat1[0,1] * val);
res.set(1,0,mat1[1,0] * val);
res.set(1,1,mat1[1,1] * val);
return res;
}
M opMul_r(real val)
{
return this * val;
}
Vector2d opMul(Vector2d v)
{
Vector2d res;
res.x = this[0,0] * v.x + this[0,1] * v.y;
res.y = this[1,0] * v.x + this[1,1] * v.y;
return res;
}
string toString()
{
return text("[",a,",",b,"]","\x0a","[",c,",",d,"]");
}
}
pure Matrix2d mat(double a, double b, double c, double d)
{
return Matrix2d(a,b,c,d);
}

Matrix2d matrot(double a)
{
return mat(cos(a),-sin(a),sin(a),cos(a));
}
pure Matrix2d matscale(double s)
{
return mat(s,0,0,s);
}

void _test()
{
Matrix2d mat1 = mat(1,1,2,3);
Matrix2d mat2 = mat(4,3,2,1);
Vector2d v = vecpos(3,1);
writeln(mat1);
writeln(mat2);
writeln(mat1 * mat2);
writeln(mat1 * mat2);
writeln(mat1 * v);
}
struct Matrix2d
{
    mixin Matrix2dTemplate!(Matrix2d,double);
}
