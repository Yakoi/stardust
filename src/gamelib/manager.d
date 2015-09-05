module gamelib.manager;
import gamelib.generator;
import mylib.list;
import std.stdio;
import std.conv;

/// Managerベースクラス
/// Generatorをうまく扱うためのクラス
/// 内部にListを持っており、自動で管理してくれる
abstract class Manager(T){
    List!(T) _usingList;
    //Generator _generator;
    this(List!(T) list){
        //this._generator = generator;
        this._usingList = list;
    }
    abstract void removeDisenable();
    abstract void clear();
    int opApply(int delegate(ref T) dg){
        return _usingList.opApply(dg);
    }
    int opApply(int delegate(ref uint, ref T) dg){
        return _usingList.opApply(dg);
    }
    int opApplyReverse(int delegate(ref T) dg){
        return _usingList.opApplyReverse(dg);
    }
    int opApplyReverse(int delegate(ref uint, ref T) dg){
        return _usingList.opApplyReverse(dg);
    }
    override string toString(){
        return _usingList.toString();
    }
    protected void pushList(T t){
        _usingList.pushBack(t);
    }
    uint list_length(){
        return _usingList.length;
    }
}
/// Generatorを楽に扱うためのクラス
/// 内部ではPoolGeneratorを使う
/// 面倒
/// 数の制限がある
/// メモリを最初にまとめて取得するため、速い
/// バグがあるかも
class PoolManager(T) : Manager!(T){
    PoolGenerator!(T) _generator;
    /+
    this(PoolGenerator!(T) generator){
        this._generator = generator;
        super();
        this._usingList = new FixedList!(T)(100);
    }
    +/
    this(int max, T delegate() create){
        this._generator = new PoolGenerator!(T)(max, create);
        super(new FixedList!(T)(max));
        //this._usingList = new VariableList!(T)();
    }
    protected void _checkLen(){
        //writefln(_usingList.length ," ", _generator.rest ," ", _generator.length);
        assert(_usingList.length + _generator.rest == _generator.length);
    }
    /+invariant(){
        //writefln(_usingList.length ," ", _generator.rest ," ", _generator.length);
        assert(_usingList.length + _generator.rest == _generator.length);
    }+/
    override void removeDisenable(){
        foreach(t; _usingList){  //poolに返す
            if(!t.isEnable()){
                _generator._pool.push(t);
            }
        }
        _usingList.remove((T t){return !t.isEnable();});
    }
    override void clear(){
        foreach(t; _usingList){  //poolに返す
            _generator._pool.push(t);
        }
        _usingList.clear();
    }
    uint rest(){
        return _generator.rest;
    }
    uint max(){
        return _generator.max;
    }
    uint using(){
        return _generator.using;
    }
    protected T pushListFromPool(){
        T res = _generator._pool.pop();
        pushList(res);
        return res;
    }

}
///楽
///数の制限が無い
///メモリの取得解放を行うため、遅い
class NewManager(T) : Manager!(T){
    //GeneratorNew!(T) _generator;
    this(){
        //this._generator = generator;
        super(new VariableList!(T)());
    }
    override void removeDisenable(){
        _usingList.remove((T t){return !t.isEnable();});
    }
    override void clear(){
        _usingList.clear();
    }
}
///実際書くのはココより下
///template
class Test{
    int x;
    this(int x){this.x=x;}
    override string toString(){
        return to!(string)(x);
    }
    bool isEnable(){
        return !x==0;
    }
}


/// 面倒
/// 数の制限がある
/// メモリを最初にまとめて取得するため、速い
class TestManagerPool : PoolManager!(Test){
    this(uint max){
        super(5, {return new Test(5);});
    }
    //ココからGenerate関数
    void test3()
        in{
            _checkLen();
        }out{
            _checkLen();
        }body{
            Test res = pushListFromPool();
            res.x = 3;
        }
    void test10()
        in{
            _checkLen();
        }out{
            _checkLen();
        }body{
            Test res = pushListFromPool();
            res.x = 10;
        }
    void test0()
        in{
            _checkLen();
        }out{
            _checkLen();
        }body{
            Test res = pushListFromPool();
            res.x = 0;
        }
}
//楽
//数の制限が無い
//メモリの取得解放を行うため、遅い
class TestManagerNew : NewManager!(Test){
    this(){
        super();
    }
    //ココからGenerate関数
    void test3(){
        Test res = new Test(3);
        pushList(res);
    }
    void test10(){
        Test res = new Test(10);
        pushList(res);
    }
    void test0(){
        Test res = new Test(0);
        pushList(res);
    }
}

const bool USE_POOL = !false;
void _main(){
    static if(USE_POOL){
        auto tm = new TestManagerPool(100);
    }else{
        auto tm = new TestManagerNew();
    }
    tm.test3();
    tm.test10();
    tm.test3();
    tm.test0();
    tm.test10();
    //writefln(tm);
    foreach(t;tm){
        t.x=t.x*t.x;
    }
    //writefln(tm);
    tm.removeDisenable();
    //writefln(tm);
    foreach(t;tm){
        if(t.x%2==0){
            t.x = 0;
        }
    }
    tm.removeDisenable();
    //writefln(tm);
    tm.test3();
    tm.test10();
    tm.test3();
    //writefln(tm);
    //writefln(tm.list_length);
    tm.clear();
    //writefln(tm);
    //writefln(tm.list_length);
    tm.test10();
    tm.test10();
    tm.test10();
    tm.test10();
    tm.test10();
    tm.test10(); //poolを使っているなら例外
    //writefln(tm);
    //writefln(tm.list_length);
    
}
