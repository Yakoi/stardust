module gamelib.generator;
import mylib.pool;
import std.stdio;
import std.conv;

abstract class Generator{

}


/// Poolを使ったGenerator
/// 固定長
/// T型の資源をPoolから取り出してくれる
/// 使われなくなった資源は
class PoolGenerator(T) : Generator{
    Pool!(T) _pool;
    this(Pool!(T) pool){
        this._pool = pool;
    }
    this(uint max, T delegate() create){
        _pool = new Pool!(T)(max, create());
    }
    bool full()  { return _pool.full; }
    bool empty() { return _pool.empty; }
    uint max()   { return _pool.max; }
    uint length(){ return _pool.length; }
    uint using() { return _pool.using; }
    uint rest()  { return _pool.rest; }
    //Pool!(T) pool(){return _pool;}
}
/+class GeneratorNew(T) : Generator{
    this();
}+/

alias PoolGenerator!(int) intgen;

/+
void _main(){
    auto ap = new APool(5, {return new A(2);});
    writefln(ap.toString());
    auto a = ap.pop();
    auto b = ap.pop();
    auto c = ap.pop();
    auto d = ap.pop();
    auto e = ap.pop();
    writefln(to!(string)(ap.using));
    writefln(ap.toString());

    intgen q = new intgen(100, {return 3;});
}
+/
