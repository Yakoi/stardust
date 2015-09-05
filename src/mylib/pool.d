module mylib.pool;
import std.stdio;
import std.conv;

///
class Pool(T){
    T[] stack;
    uint _p;
    this(uint max, lazy T create){
        stack.length = max;
        foreach(ref s;stack){
            s = create();
        }
        _p = 0;
    }
    invariant(){
        assert(0<=_p && _p<=stack.length);
    }
    nothrow const pure bool full(){
        return _p==0;
    }
    nothrow const pure bool empty(){
        return _p==length;
    }
    void push(T obj){
        if(full()){
            //もうPoolに全部返されているのに、さらに返そうとした時
            throw new Exception("Pool.push ("~to!(string)(this.max)~")");
        }
        _p--;
        stack[_p] = obj;
    }
    T pop(){
        if(empty()){
            //Poolが空っぽなのに、さらに使おうとした時
            throw new Exception("Pool.pop ("~to!(string)(this.max)~")");
        }
        T res = stack[_p];
        _p++;
        return res;
    }
    nothrow const pure uint max(){
        return stack.length;
    }
    nothrow const pure uint length(){
        return stack.length;
    }
    nothrow const pure uint using(){
        return _p;
    }
    nothrow const pure uint rest(){
        return this.length - this.using;
    }
    override string toString(){
        string str = "[";
        for(int i=using ; i<length ; i++){
            str ~= to!(string)(stack[i]);
            str ~= ", ";
        }
        str ~= "]";
        return str;
    }
}


class A{
    int x;
    this(int x){
        this.x=x;
    }
    override string toString(){
        return to!(string)(x);
    }
}
alias Pool!(A) APool;
