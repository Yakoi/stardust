module gamelib.utils;

import gamelib.all;
public import mylib.utils;
import std.math;
import dxlib.all;
import std.stdio;


/// 加速度的移動
Vector move2Vel(Vector pos, Vector goal_pos, double velocity){
    Vector dpos = goal_pos - pos;
    Vector vel  = dpos.unit()*velocity;
    Vector res;
    if(dpos.length2 <= velocity*velocity){ //とても近い場合
        return dpos;
    }
    if(dpos.x==0 || vel.x==0){
        res.x = 0;
    }else{
        res.x = (vel.x*vel.x*vel.x)/(9*dpos.x*dpos.x)*(1-(3*dpos.x/vel.x))*(1-(3*dpos.x/vel.x));
    }
    if(dpos.y==0 || vel.y==0){
        res.y = 0;
    }else{
        res.y = (vel.y*vel.y*vel.y)/(9*dpos.y*dpos.y)*(1-(3*dpos.y/vel.y))*(1-(3*dpos.y/vel.y));
    }
    return res;
}
/// 等速で移動
Vector move1(Vector pos, Vector goal_pos, int time){
    if(time<=0){
        return goal_pos;
    }
    Vector dpos = goal_pos - pos;
    double dlen = dpos.length;
    double velocity = dlen/time;
    if(dlen <= velocity){
        return goal_pos;
    }
    Vector vel = dpos.unit()*velocity;
    return pos + vel;
}
/// 等速で移動(一次元)
double move1(double now, double fin, int time){
    if(time<=0){
        return fin;
    }
    double dist = fin - now;
    double velocity = dist/time;
    if(mylib.utils.abs(dist) <= mylib.utils.abs(velocity)){
        return fin;
    }
    return now + velocity;
}
/// 三次関数的に移動(一次元)
/// 内部で呼び出す
deprecated double travel3Vel(double pos0, double vel0, double pos1, int time){
    return 2*(pos1-pos0-vel0*time)/(time*time)+vel0;
}
deprecated Vector travel3_acc(Vector pos0, Vector vel0, Vector pos1, int time){
    double vx = travel3Vel(pos0.x, vel0.x, pos1.x, time);
    double vy = travel3Vel(pos0.y, vel0.y, pos1.y, time);
    return Vector(vx,vy);
}
deprecated double travel3Vel(double pos0, double vel0, double pos1, double vel1, int time){
    if(time <= 0){
        return pos1-pos0;
    }
    double c = vel0;
    double d = pos0;
    double a = ((vel1+c)*time+2*d-2*pos1)/(time*time*time);
    double b = (vel1 - 2*a*time*time - c)/(2*time);
    return vel0+(6*a + 2*b);
    /+
    double c = 6*(vel0*time + vel1*time - 2*pos1 + 2*pos0)/(time*time*time);
    double a = (6*pos1 - 6*pos0 - 4*vel0*time - 2*vel1*time)/(time*time);
    return a+c;
    +/
        /+
    double a = (vel0*time + vel1*time + 2*pos0 - 2*pos1)/(time*time*time);
    double b = (vel1 - vel0 - 3*a*time*time)/(2*time);
    return 6*a+2*b;
    +/
}
void travel3VelRef(ref double pos0, ref double vel0, double pos1, double vel1, int time){
    if(time <= 0){
        pos0 = pos1;
        vel0 = vel1;
        return;
    }
    double c = vel0;
    double d = pos0;
    double a = ((vel1+c)*time+2*d-2*pos1)/(time*time*time);
    double b = (vel1 - 2*a*time*time - c)/(2*time);
    vel0 = vel0+(6*a + 2*b);
    pos0 = pos0 + vel0;
}
deprecated Vector travel3Vel(Vector pos0, Vector vel0, Vector pos1, Vector vel1, int time){
    if(time <= 0){
        return pos1 - pos0;
    }
    double vx = travel3Vel(pos0.x, vel0.x, pos1.x, vel1.x, time);
    double vy = travel3Vel(pos0.y, vel0.y, pos1.y, vel1.y, time);
    //writeln(vx," ",vy, " ",pos0," ",pos1," ", time);
    Vector res = Vector(vx,vy);
    if(time <= 2){
        if(res.length2 > (pos1 - pos0).length2){
            //writeln("oh!");
            return pos1 - pos0;//vel1;//pos1 - pos0;
        }
    }
    return res;
}
/// 三次関数的に移動 メインに使う
void travel3VelRef(ref Vector pos0, ref Vector vel0, Vector pos1, Vector vel1, int time){
    if(time <= 1){
        pos0 = pos1;
        vel0 = vel1;
        return;
    }
    double dif = (pos1 - pos0).length2;
    travel3VelRef(pos0.x, vel0.x, pos1.x, vel1.x, time);
    travel3VelRef(pos0.y, vel0.y, pos1.y, vel1.y, time);
    //writeln(vx," ",vy, " ",pos0," ",pos1," ", time);
    if(time <= 2){
        if(vel0.length2 > dif){
            pos0 = pos1;
            vel0 = vel1;
            return;
        }
    }
}
/// ある時間に移動するポイントとその時の速度を指定するための構造体
/// See_Also: travel3VelRef, lineSymmetryX, lineSymmetryY, pointSymmetry
struct TravelData{
    Vector pos; ///位置
    Vector vel; ///速度
    int time;   ///時間
    const int W = 320;
    const int H = 240;
    ///位置のx座標を画面半分の点で折り返す
    void lineSymmetryX(){
        this.pos.x = W - this.pos.x;
        this.vel.x = -this.vel.x;
    }
    ///位置のy座標を画面半分の点で折り返す
    void lineSymmetryY(){
        this.pos.y = H - this.pos.y;
        this.vel.y = -this.vel.y;
    }
    ///位置のx,y座標を画面半分の点で折り返す
    void pointSymmetry(){
        this.lineSymmetryX();
        this.lineSymmetryY();
    }
}
void lineSymmetryX(ref TravelData[] tds){
    foreach(ref td; tds){
        td.lineSymmetryX();
    }
}
void lineSymmetryY(ref TravelData[] tds){
    foreach(ref td; tds){
        td.lineSymmetryY();
    }
}
void pointSymmetry(ref TravelData[] tds){
    foreach(ref td; tds){
        td.pointSymmetry();
    }
}

/// 三次関数的に移動 複数点指定できるスグレモノ
void travel3VelRef(ref Vector pos0, ref Vector vel0, TravelData[] tdata_array, int time){
    int idx=-1;
    int timer = 0;
    foreach_reverse(i, td; tdata_array){
        timer += td.time;
        if(time <= timer){
            idx = i;
            break;
        }
    }
    if(idx>=0){
        travel3VelRef(pos0, vel0, tdata_array[idx].pos,
                tdata_array[idx].vel, time-timer+tdata_array[idx].time);
    }else{
        vel0 = tdata_array[$-1].vel;
        pos0 = tdata_array[$-1].pos;
    }
}
deprecated Vector travel3Vel(Vector pos0, Vector vel0, TravelData[] tdata_array, int time){
    int idx=-1;
    int timer = 0;
    foreach_reverse(i, td; tdata_array){
        timer += td.time;
        if(time <= timer){
            idx = i;
            break;
        }
    }
    if(idx!=-1){
        return travel3Vel(pos0, vel0, tdata_array[idx].pos,
                tdata_array[idx].vel, time-timer+tdata_array[idx].time);
    }else{
        return tdata_array[$-1].vel;
    }
}

deprecated Vector travel3Vel(Vector pos0, Vector vel0, Vector[] pos_array, Vector[] vel_array, int[] time_array, int time)
in{
    assert(pos_array.length == vel_array.length);
    assert(pos_array.length == time_array.length);

}body{
    int idx=-1;
    int timer = 0;
    foreach_reverse(uint i, int t; time_array){
        timer += t;
        if(time <= timer){
            idx = i;
            break;
        }
    }
    if(idx!=-1){
        return travel3Vel(pos0, vel0, pos_array[idx],
                vel_array[idx], time-timer+time_array[idx]-1);
    }else{
        return vel_array[$-1];
    }
}



Vector move2(Vector pos, Vector goal_pos, int time){
    Vector get_vel(Vector pos0, Vector pos1, int time){
        double f(double p0,double p1,int t){
            if(t==0){
                return 0;
            }else{
                return (2*(p1-p0))/(t);
            }
        }
        double nx = f(pos0.x, pos1.x, time);
        double ny = f(pos0.y, pos1.y, time);
        return Vector(nx,ny);
    }
    if(time<=0){return goal_pos;}
    Vector new_vel = 2*(goal_pos-pos)/time;
    Vector pos1 = pos + new_vel;
    return pos1;
}
/// time回呼ばれたときにfinになるよう値を返す
/// Params:
///     now = 変化前の値
///     fin = timeが0になったときになる目標値
///     time = 残り時間
/// Return: 変化後の値
double move2(double now, double fin, int time){
    /+
    Vector get_vel(Vector pos0, Vector pos1, int time){
        double f(double p0,double p1,int t){
            if(t==0){
                return 0;
            }else{
                return (2*(p1-p0))/(t);
            }
        }
        double nx = f(pos0.x, pos1.x, time);
        double ny = f(pos0.y, pos1.y, time);
        return Vector(nx,ny);
    }
    +/
    if(time<=0){return fin;}
    double velocity = 2*(fin-now)/time;
    double res = now + velocity;
    if(mylib.utils.abs(fin-now) <= mylib.utils.abs(velocity)){
        return fin;
    }
    return res;
}
/// 物理現象を考慮して動かす
/// Params:
///     pos = pos
///     vel = 移動前の速度
///     acc = 加速度
///     friction = 摩擦係数
///     air_resistance = 空気抵抗
/// Return: 次の速度
void physicalMoveRef(ref Vector pos, Vector goal_pos, ref Vector vel, Vector acc=vecpos(0,0),
        double friction=0, double air_resistance=0, double movemin = 0.1)
in{
    assert(friction>=0);
    assert(air_resistance >= 0);
}body{
    vel = physicalMoveVel(vel, acc, friction, air_resistance);
    pos = pos + vel;
    if((pos - goal_pos).length2 < movemin){
        pos = goal_pos;
    }
}
/// 物理現象を考慮して動かす
/// Params:
///     vel = 移動前の速度
///     acc = 加速度
///     friction = 摩擦係数
///     air_resistance = 空気抵抗
/// Return: 次の速度
pure Vector physicalMoveAcc(Vector vel, Vector acc=vecpos(0,0),
        double friction=0, double air_resistance=0)
in{
    assert(friction>=0);
    assert(air_resistance >= 0);
}body{
    Vector vel1 = accMove(vel, acc);
    Vector vel2 = airMove(vel1, air_resistance);
    Vector vel3 = frictionMove(vel2, friction);
    return vel3-vel;
}
/// 物理現象を考慮して動かす
/// Params:
///     vel = 移動前の速度
///     acc = 加速度
///     friction = 摩擦係数
///     air_resistance = 空気抵抗
/// Return: 次の速度
pure Vector physicalMoveVel(Vector vel, Vector acc=vecpos(0,0),
        double friction=0, double air_resistance=0)
in{
    assert(friction>=0);
    assert(air_resistance >= 0);
}body{
    Vector vel1 = accMove(vel, acc);
    Vector vel2 = airMove(vel1, air_resistance);
    Vector vel3 = frictionMove(vel2, friction);
    return vel3;
}

/// 加速度を速度に足すだけ
pure Vector accMove(Vector vel, Vector acc){
    double vx1 = accMove(vel.x, acc.x);
    double vy1 = accMove(vel.y, acc.y);
    return vecpos(vx1, vy1);
}
/// 加速度を速度に足すだけ スカラー版
pure double accMove(double velocity, double acceleration){
    return velocity+acceleration;
}

/// 空気抵抗を考慮した速度を返す
/// 速度に比例した加速度がかかる
/// Params:
///     vel = 前の速度
///     air_resistance = 空気抵抗
/// Return: 次の速度
pure Vector airMove(Vector vel, double air_resistance=0)
in{
    assert(air_resistance >= 0.0);
    assert(air_resistance <= 1.0);
}body{
    double vx1 = airMove(vel.x, air_resistance);
    double vy1 = airMove(vel.y, air_resistance);
    return vecpos(vx1,vy1);
}

/// 空気抵抗を考慮した速度を返す スカラー版
pure double airMove(double velocity, double air_resistance=0)
in{
    assert(air_resistance >= 0.0);
    assert(air_resistance <= 1.0);
}body{
    return velocity*(1-air_resistance);
}

/// 摩擦を考慮した速度を返す
/// 速度の逆向きに一定の加速度がかかる
/// Params:
///     vel = 前の速度
///     friction = 摩擦係数
/// Return: 次の速度
pure Vector frictionMove(Vector vel, double friction=0)
in{
    assert(friction >= 0);
}body{
    if(friction*friction > vel.length2){return vecpos(0,0);} //摩擦が十分に大きい時は0にする
    Vector fri = -friction*vel.unit();
    return vel + fri;
    //double vx1 = accMove(vel.x, fri.x);
    //double vy1 = accMove(vel.y, fri.y);
    //return vecpos(vx1, vy1);
}


/// ----
version(none){
    /// バイブレーション！ぶるぶる震えるよ！
    void vibration(int power, int time)
    in{
        assert(0<=power);
        assert(power<=1000);
    }body{
        if(System.is_use_vibration){
            dx_StartJoypadVibration(DX_INPUT_PAD1, power, time );
        }
    }
}

version(none){
/// 1/2の確立でtrue, 1/2でfalse
bool randb(){
    return randi(1)==0;
}
/// pの確立でtrue, 1-pでfalse
bool randb(double p)
in{
    assert(p>=0 && p<=1);
}body{
    return randf()<=p;
}
/// ランダムに[0, max]の値を返す
int randi(int max){
    return randi(0,max);
}
/// ランダムに[min, max]の値を返す
int randi(int min, int max){
    return dx_GetRand(max-min)+min;
}
/// 1/2の確立で1, 1/2で-1
int randpm(){
    return randb() ? 1 : -1;
}
/// pの確立で1, 1-pで-1
int randpm(double p)
in{
    assert(isFinite(p));
}body{
    return randb(p) ? 1 : -1;
}

/// ランダムに[0, 1]の値を返す
double randf()
out(res){
    assert(isFinite(res));
}body{
    return randf(0,1);
}

/// ランダムに[0, max]の値を返す
double randf(double max)
in{
    assert(isFinite(max));
}out(res){
    //assert(isFinite(res));
}body{
    return randf(0,max);
}

/// ランダムに[min, max]の値を返す
double randf(double min, double max)
in{
    assert(isFinite(min));
    assert(isFinite(max));
}out(res){
    //assert(isFinite(res));
}body{
    const int d = 1000;
    return cast(double)randi(d)/d*(max-min)+min;
}

/// ランダムに大きさがr以下のベクトルを返す
Vector randv(double r)
in{
    assert(isFinite(r));
}out(res){
    assert(isFinite(res.x));
    assert(isFinite(res.y));
}body{
    Vector v = Vector(0,0);
    v.length = randf(r);
    v.dir    = randf(2*PI);
    return v;
}

/// ランダムにx座標が[-w/2, w/2], y座標が[-w/2, w/2]のベクトルを返す
Vector randv(in double w, in double h)
in{
    assert(isFinite(w));
    assert(isFinite(h));
}out(res){
    assert(isFinite(res.x));
    assert(isFinite(res.y));
}body{
    double x = randf(-w/2, w/2);
    double y = randf(-h/2, h/2);
    return Vector(x,y);
}
pure Vector vector_in(in Vector v, Rect r)
out(res){
    assert(isFinite(res.x));
    assert(isFinite(res.y));
}body{
    double x = v.x;
    double y = v.y;
    if(v.x < r.left)  {x = r.left;}
    if(v.y < r.top)   {y = r.top;}
    if(v.x > r.right) {x = r.right;}
    if(v.y > r.bottom){y = r.bottom;}
    return Vector(x,y);
}
}

/+

        x0, y0 = pos
        gx, gy = self._goal_pos
        dx1, dy1 = gx-x0, gy-y0
        dx2, dy2 = gx-x1, gy-y1
        if dx1*dx2<0 or dy1*dy2<0:
            x1, y1 = (gx,gy)

        self._count -= 1
        return (x1, y1)
    +/
/// posがrectの外に出ているかどうか
/// rectの外ならtrue,中ならfalse
pure bool outOfRect(T)(T pos, in Rect rect){
    if(pos.x < rect.left){return true;}
    if(pos.x > rect.right){return true;}
    if(pos.y > rect.bottom){return true;}
    if(pos.y < rect.top){return true;}
    return false;
}

/// 点と(太さを持たない)直線の距離を求める
/// params:
/// pos = 点の位置
/// l_start = 線の位置ベクトル
/// l_dir = 線の方向ベクトルの角度
/// returns:
/// 距離。符合は適当になるかも
static if(false){
    double distancePosToLine(Vector pos, Vector l_start, double l_dir){
        double angle = l_dir - (l_start - pos).dir;
        return sin(angle);
    }
    double distance2PosToLine(Vector pos, Vector l_start, double l_dir){
        auto a = distancePosToLine(pos, l_start, l_dir);
        return a*a;
    }
}else static if(true){
    pure double distance2PosToLine(in Vector pos, in Vector l_start, in double l_dir)
    in{
        assert(isFinite(l_dir));
    }body{
        double xx = pos.x;
        double yy = pos.y;
        double x1 = l_start.x;
        double y1 = l_start.y;
        Vector tmp = l_start+vecdir(l_dir,100);
        double x2 = tmp.x;
        double y2 = tmp.y;
        auto dx = (x2 - x1);
        auto dy = (y2 - y1);
        auto a = dx*dx + dy*dy;
        auto b = dx * (x1 - xx) + dy * (y1 - yy);
        auto t = -b / a;
        auto tx = x1 + dx * t;
        auto ty = y1 + dy * t;
        return (xx - tx)*(xx - tx) + (yy - ty)*(yy - ty);
    }
    double distancePosToLine(Vector pos, Vector l_start, double l_dir){
        return sqrt(distance2PosToLine(pos, l_start, l_dir));
    }
}else{
    double distance2PosToLine(Vector pos, Vector l_start, double l_dir){
        double px = pos.x;
        double py = pos.y;
        double x0 = l_start.x;
        double y0 = l_start.y;
        Vector tmp = l_start+vecdir(l_dir,1);
        double x1 = tmp.x;
        double y1 = tmp.y;
        auto dx = x1 - x0;
        auto dy = y1 - y0;
        auto a = dx * dx + dy * dy;
        if(a==0.0){return ( (x0-px)*(x0-px) + (y0-py)*(y0-py));}
        auto b = dx * (x0-px) + dy * (y0-py);
        auto t =  - (b / a);
        auto x = t * dx + x0;
        auto y = t * dy + y0;
        return ( (x-px)*(x-px) + (y-py)*(y-py)) ;
    }
}
VERTEX vertex(Vector pos, Color col, int u=0, int v=0){
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


bool checkDxFile(string path, string dxa){
    string path2 = absolutePath(path);
    if(exists(path2)){
        if(isFile(path2)){
            return true;
        }
    }
    return checkDxFile_(path2, "", dxa);
}
import std.path;
import std.string;
import std.file;
void[] dxread(string path, string dxa = "dxa"){
    wchar* cpath = toWStringz(toCString(path));
    if(!checkDxFile(path, dxa)){throw new Exception("dxread Load Error : " ~ path);}
    // ファイルのサイズを得る
    int FileSize = dx_FileRead_size( cpath ) ;
    // ファイルを格納するメモリ領域の確保
    void[] Buffer;
    Buffer.length = FileSize;
    // test1.bmp を開く
    int FileHandle = dx_FileRead_open( cpath ) ;
    // ファイルを丸ごとメモリに読み込む
    dx_FileRead_read( Buffer.ptr, FileSize, FileHandle ) ;
    // ファイルを閉じる
    dx_FileRead_close( FileHandle ) ;
    return Buffer;
}
bool checkDxFile_(string dx_path, string path, string dxa){
    if(dx_path is null || path is null || dxa is null){return false;}
    //string dx_path2 = getName(dx_path) ~ "." ~ dxa;
    //writeln(dx_path);
    //writeln(path);
    if(exists(dx_path)){
        if(isFile(dx_path)){
            return 0!=dx_DXArchiveCheckFile(toWStringz(dx_path), toWStringz(path));
        }
    }
    string new_dx_path = dirName(dx_path);
    string new_path;
    if(path.length == 0){
        new_path = baseName(dx_path);
    }else{
        new_path = std.conv.to!string(baseName(dx_path) ~ std.path.dirSeparator ~ path);
    }
    //writeln(baseName(dx_path));
    if(baseName(dx_path) is null){return false;}
    if(baseName(dx_path) == ""){return false;}
    return checkDxFile_(new_dx_path, new_path, dxa);
}
/// フォントのサイズを取得
int getFontSize(Font font){
    return (font is null ? dx_GetFontSize() : font.size);
}

/// 現在日時を元にした文字列を得る
string nowTimeStr(){
    DATEDATA dd;
    dx_GetDateTime(&dd);
    char[100] p;
    string name = format("%04d-%02d-%02d-%02d-%02d-%02d", 
            dd.Year, dd.Mon, dd.Day, dd.Hour, dd.Min, dd.Sec);
    return name;
}
/// 現在日付を元にした文字列を得る
string nowDateStr(){
    DATEDATA dd;
    dx_GetDateTime(&dd);
    char[100] p;
    string name = format("%04d-%02d-%02d", 
            dd.Year, dd.Mon, dd.Day);
    return name;
}


string count2time(int count, int fps){
    int all_sec = count / fps;
    int dsec = count % fps;
    int sec = all_sec % 60;
    int min = all_sec / 60;
    if(dsec < fps/2){
        return format("%02d:%02d", min, sec);
    }else{
        return format("%02d %02d", min, sec);
    }
}
