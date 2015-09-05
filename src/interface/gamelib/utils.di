// D import file generated from 'gamelib\utils.d'
module gamelib.utils;
import gamelib.all;
public import mylib.utils;

import std.math;
import dxlib.all;
import std.stdio;
Vector move2Vel(Vector pos, Vector goal_pos, double velocity);
Vector move1(Vector pos, Vector goal_pos, int time);
double move1(double now, double fin, int time);
deprecated double travel3Vel(double pos0, double vel0, double pos1, int time)
{
return 2 * (pos1 - pos0 - vel0 * time) / (time * time) + vel0;
}

deprecated Vector travel3_acc(Vector pos0, Vector vel0, Vector pos1, int time)
{
double vx = travel3Vel(pos0.x,vel0.x,pos1.x,time);
double vy = travel3Vel(pos0.y,vel0.y,pos1.y,time);
return Vector(vx,vy);
}

deprecated double travel3Vel(double pos0, double vel0, double pos1, double vel1, int time);

void travel3VelRef(ref double pos0, ref double vel0, double pos1, double vel1, int time);
deprecated Vector travel3Vel(Vector pos0, Vector vel0, Vector pos1, Vector vel1, int time);

void travel3VelRef(ref Vector pos0, ref Vector vel0, Vector pos1, Vector vel1, int time);
struct TravelData
{
    Vector pos;
    Vector vel;
    int time;
    const int W = 320;

    const int H = 240;

    void lineSymmetryX()
{
this.pos.x = W - this.pos.x;
this.vel.x = -this.vel.x;
}
    void lineSymmetryY()
{
this.pos.y = H - this.pos.y;
this.vel.y = -this.vel.y;
}
    void pointSymmetry()
{
this.lineSymmetryX();
this.lineSymmetryY();
}
}
void lineSymmetryX(ref TravelData[] tds);
void lineSymmetryY(ref TravelData[] tds);
void pointSymmetry(ref TravelData[] tds);
void travel3VelRef(ref Vector pos0, ref Vector vel0, TravelData[] tdata_array, int time);
deprecated Vector travel3Vel(Vector pos0, Vector vel0, TravelData[] tdata_array, int time);

deprecated Vector travel3Vel(Vector pos0, Vector vel0, Vector[] pos_array, Vector[] vel_array, int[] time_array, int time);

Vector move2(Vector pos, Vector goal_pos, int time);
double move2(double now, double fin, int time);
void physicalMoveRef(ref Vector pos, Vector goal_pos, ref Vector vel, Vector acc = vecpos(0,0), double friction = 0, double air_resistance = 0, double movemin = 0.1);
pure Vector physicalMoveAcc(Vector vel, Vector acc = vecpos(0,0), double friction = 0, double air_resistance = 0)
in
{
assert(friction >= 0);
assert(air_resistance >= 0);
}
body
{
Vector vel1 = accMove(vel,acc);
Vector vel2 = airMove(vel1,air_resistance);
Vector vel3 = frictionMove(vel2,friction);
return vel3 - vel;
}

pure Vector physicalMoveVel(Vector vel, Vector acc = vecpos(0,0), double friction = 0, double air_resistance = 0)
in
{
assert(friction >= 0);
assert(air_resistance >= 0);
}
body
{
Vector vel1 = accMove(vel,acc);
Vector vel2 = airMove(vel1,air_resistance);
Vector vel3 = frictionMove(vel2,friction);
return vel3;
}

pure Vector accMove(Vector vel, Vector acc)
{
double vx1 = accMove(vel.x,acc.x);
double vy1 = accMove(vel.y,acc.y);
return vecpos(vx1,vy1);
}

pure double accMove(double velocity, double acceleration)
{
return velocity + acceleration;
}

pure Vector airMove(Vector vel, double air_resistance = 0)
in
{
assert(air_resistance >= 0);
assert(air_resistance <= 1);
}
body
{
double vx1 = airMove(vel.x,air_resistance);
double vy1 = airMove(vel.y,air_resistance);
return vecpos(vx1,vy1);
}

pure double airMove(double velocity, double air_resistance = 0)
in
{
assert(air_resistance >= 0);
assert(air_resistance <= 1);
}
body
{
return velocity * (1 - air_resistance);
}

pure Vector frictionMove(Vector vel, double friction = 0);

version (none)
{
    void vibration(int power, int time);
}
version (none)
{
    bool randb()
{
return randi(1) == 0;
}
    bool randb(double p)
in
{
assert(p >= 0 && p <= 1);
}
body
{
return randf() <= p;
}
    int randi(int max)
{
return randi(0,max);
}
    int randi(int min, int max)
{
return dx_GetRand(max - min) + min;
}
    int randpm()
{
return randb() ? 1 : -1;
}
    int randpm(double p)
in
{
assert(isFinite(p));
}
body
{
return randb(p) ? 1 : -1;
}
    double randf()
out(res)
{
assert(isFinite(res));
}
body
{
return randf(0,1);
}
    double randf(double max)
in
{
assert(isFinite(max));
}
out(res)
{
}
body
{
return randf(0,max);
}
    double randf(double min, double max)
in
{
assert(isFinite(min));
assert(isFinite(max));
}
out(res)
{
}
body
{
const int d = 1000;
return cast(double)randi(d) / d * (max - min) + min;
}
    Vector randv(double r)
in
{
assert(isFinite(r));
}
out(res)
{
assert(isFinite(res.x));
assert(isFinite(res.y));
}
body
{
Vector v = Vector(0,0);
v.length = randf(r);
v.dir = randf(2 * PI);
return v;
}
    Vector randv(in double w, in double h)
in
{
assert(isFinite(w));
assert(isFinite(h));
}
out(res)
{
assert(isFinite(res.x));
assert(isFinite(res.y));
}
body
{
double x = randf(-w / 2,w / 2);
double y = randf(-h / 2,h / 2);
return Vector(x,y);
}
    pure Vector vector_in(in Vector v, Rect r);

}
pure template outOfRect(T)
{
bool outOfRect(T pos, in Rect rect)
{
if (pos.x < rect.left)
{
return true;
}
if (pos.x > rect.right)
{
return true;
}
if (pos.y > rect.bottom)
{
return true;
}
if (pos.y < rect.top)
{
return true;
}
return false;
}
}

static if(false)
{
    double distancePosToLine(Vector pos, Vector l_start, double l_dir)
{
double angle = l_dir - (l_start - pos).dir;
return sin(angle);
}
    double distance2PosToLine(Vector pos, Vector l_start, double l_dir)
{
auto a = distancePosToLine(pos,l_start,l_dir);
return a * a;
}
}
else
{
    static if(true)
{
    pure double distance2PosToLine(in Vector pos, in Vector l_start, in double l_dir)
in
{
assert(isFinite(l_dir));
}
body
{
double xx = pos.x;
double yy = pos.y;
double x1 = l_start.x;
double y1 = l_start.y;
Vector tmp = l_start + vecdir(l_dir,100);
double x2 = tmp.x;
double y2 = tmp.y;
auto dx = x2 - x1;
auto dy = y2 - y1;
auto a = dx * dx + dy * dy;
auto b = dx * (x1 - xx) + dy * (y1 - yy);
auto t = -b / a;
auto tx = x1 + dx * t;
auto ty = y1 + dy * t;
return (xx - tx) * (xx - tx) + (yy - ty) * (yy - ty);
}

    double distancePosToLine(Vector pos, Vector l_start, double l_dir)
{
return sqrt(distance2PosToLine(pos,l_start,l_dir));
}
}
else
{
    double distance2PosToLine(Vector pos, Vector l_start, double l_dir);
}
}
VERTEX vertex(Vector pos, Color col, int u = 0, int v = 0)
{
VERTEX res;
res.x = pos.x;
res.y = pos.y;
res.r = col.red256;
res.b = col.blue256;
res.g = col.green256;
res.a = col.alpha256;
res.u = u;
res.v = v;
return res;
}
bool checkDxFile(string path, string dxa);
import std.path;
import std.string;
import std.file;
void[] dxread(string path, string dxa = "dxa");
bool checkDxFile_(string dx_path, string path, string dxa);
int getFontSize(Font font)
{
return font is null ? dx_GetFontSize() : font.size;
}
string nowTimeStr()
{
DATEDATA dd;
dx_GetDateTime(&dd);
char[100] p;
string name = format("%04d-%02d-%02d-%02d-%02d-%02d",dd.Year,dd.Mon,dd.Day,dd.Hour,dd.Min,dd.Sec);
return name;
}
string nowDateStr()
{
DATEDATA dd;
dx_GetDateTime(&dd);
char[100] p;
string name = format("%04d-%02d-%02d",dd.Year,dd.Mon,dd.Day);
return name;
}
string count2time(int count, int fps);
