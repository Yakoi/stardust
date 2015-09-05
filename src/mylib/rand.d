module mylib.rand;

import std.random;
import std.stdio;
import std.math;
import mylib.vector2d;

/// 使いやすくしたつもりのランダムクラス
class Rand{
    Random gen;
    int seed;
    this(){
        //this.gen = Random(unpredictableSeed);
        this(unpredictableSeed);
    }
    this(int seed){
        this.seed = seed;
        this.gen = Mt19937(seed);
    }
    /// ランダムに[0, 255]の値を返す
    ubyte randbyte(){
        return cast(ubyte)this.randi(0,255);
    }
    /// ランダムに[0, max]の値を返す
    int randi(int max){
        return this.randi(0,max);
    }
    /// ランダムに[min, max]の値を返す
    int randi(int min, int max){
        if(min == max+1){return min;}
        return uniform(min, max+1,gen);
    }
    alias randi i;
    /// ランダムに[0, 1]の値を返す
    real randf(){
        return this.randf(0,1);
    }
    /// ランダムに[0, max]の値を返す
    real randf(real max){
        return this.randf(0,max);
    }
    /// ランダムに[min, max]の値を返す
    real randf(real min, real max){
        if(min == max){return min;}
        return uniform(min, max, gen);
    }
    alias randf r;
    /// 1/2の確立でtrue, 1/2でfalse
    bool randb(){
        return this.randi(1)==0;
    }
    /// pの確立でtrue, 1-pでfalse
    bool randb(real p)
    in{
        assert(p>=0 && p<=1);
    }body{
        return this.randf()<=p;
    }
    alias randb b;
    /// 1/2の確立で1, 1/2で-1
    int randpm(){
        return this.randb() ? 1 : -1;
    }
    /// pの確立で1, 1-pで-1
    int randpm(double p)
    in{
        assert(isFinite(p));
    }body{
        return this.randb(p) ? 1 : -1;
    }
    alias randpm pm;
    /// ランダムに大きさがr以下のベクトルを返す
    Vector2d randv(double r)
    in{
        assert(isFinite(r));
    }out(res){
        assert(isFinite(res.x));
        assert(isFinite(res.y));
    }body{
        Vector2d v = vecpos(0,0);
        v.length = this.randf(r);
        v.dir    = this.randf(2*PI);
        return v;
    }

    /// ランダムにx座標が[-w/2, w/2], y座標が[-w/2, w/2]のベクトルを返す
    Vector2d randv(double w, double h)
    in{
        assert(isFinite(w));
        assert(isFinite(h));
    }out(res){
        assert(isFinite(res.x));
        assert(isFinite(res.y));
    }body{
        double x = this.randf(-w/2, w/2);
        double y = this.randf(-h/2, h/2);
        return vecpos(x,y);
    }
    alias randv v;
    


}

int main_(){
    auto rnd = new Rand();
    for(int i=0; i<5; i++){
        writeln(rnd.randi(4,10));
    }
    for(int i=0; i<5; i++){
        writeln(rnd.randf());
    }
    angou("majidesuka!?zzz\n\n\nohohoh32423424999あいうえお");
    return 0;
}


void angou(T)(T[] data){
    int key = 100;
    writeln("----data----");
    writeln(data);
    //エンコード
    T[] edata = proc(data, key);
    writeln("----encode----");
    writeln(edata);
    //デコード
    T[] ddata = proc(edata, key);
    writeln("----decode----");
    writeln(ddata);

}
version(none){
    T proc(T)(T data, int key){
        Rand rnd = new Rand(key);
        T res;
        res.length = data.length;
        for(int i=0; i<data.length; i++){
            res[i] = data[i] ^ rnd.randbyte();
        }
        return res;
    }
}
string proc(string data, int key){
    Rand rnd = new Rand(key);
    char[] res;
    res.length = data.length;
    for(int i=0; i<data.length; i++){
        res[i] = data[i] ^ rnd.randbyte();
    }
    return cast(string)(res);
}
