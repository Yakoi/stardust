module mylib.stack;
import std.stdio;
import std.conv;
import std.algorithm;
/// stack のベースクラス
class Stack(T){
    /// プッシュ
    abstract void push(T val);
    /// ポップ
    abstract T pop();
    /// スタックの深さ
    abstract const pure int depth();
    /// foreach用
    abstract int opApply(int delegate(ref T) dg);
    /// foreach用
    abstract int opApply(int delegate(uint, ref T) dg);
    /// foreach_reverse用
    abstract int opApplyReverse(int delegate(ref T) dg);
    /// foreach_reverse用
    abstract int opApplyReverse(int delegate(uint, ref T) dg);
}
/// 固定長スタック
class FixedStack(T) : Stack!(T){
protected:
    T[] _data;
    int _pointer = 0;
    int _depth = 0;
    void init(){
        static if(is(T == class)){
            foreach(ref d; this._data){
                d = null;
            }
        }else{
            foreach(ref d; this._data){
                d = T.init;
            }
        }
    }
    private void forward_pointer(){
        this._pointer = (this._pointer + 1);
    }
    private void back_pointer(){
        this._pointer = (this._pointer - 1);
    }
    invariant(){
        assert(this._depth == this._pointer);
    }
public:
    this(int size){
        _data.length = size;
    }
    override void push(T val){
        if(this._depth >= this._data.length-1){
            throw new Exception("Stack.full : Stack is full");
        }
        this._data[this._pointer] = val;
        this.forward_pointer();
        this._depth += 1;
    }
    override T pop(){
        if(this._depth <= 0){
            throw new Exception("Stack.pop : Stack is empty");
        }
        this.back_pointer();
        T res = this._data[this._pointer];
        this._depth -= 1;
        return res;
    }
    override const pure int depth(){
        return this._depth;
    }
    const pure int size(){
        return this._data.length;
    }
    const pure bool full(){
        return (this.depth +1 == this.size);
    }
    const pure bool empty(){
        return this.depth == 0;
    }
    /// foreach用
    override int opApply(int delegate(ref T) dg){
        for(uint i=0; i<this.depth; i++){
            int res = dg(this._data[(this._pointer - 1 - i)]);
            if(res != 0){return res;}
        }
        return 0;
    }
    /// foreach用
    override int opApply(int delegate(uint, ref T) dg){
        for(uint i=0; i<this.depth; i++){
            int res = dg(i, this._data[(this._pointer - 1 - i)]);
            if(res != 0){return res;}
        }
        return 0;
    }
    /// foreach_reverse用
    override int opApplyReverse(int delegate(ref T) dg){
        for(uint i=0; i<this.depth; i++){
            int j = this.depth - i - 1;
            int res = dg(this._data[(this._pointer - 1 - j)]);
            if(res != 0){return res;}
        }
        return 0;
    }
    /// foreach_reverse用
    override int opApplyReverse(int delegate(uint, ref T) dg){
        for(uint i=0; i<this.depth; i++){
            int j = this.depth - i - 1;
            int res = dg(i, this._data[(this._pointer - 1 - j)]);
            if(res != 0){return res;}
        }
        return 0;
    }
}
/// 固定長スタックで，サイズを超えてpushしたときに古い値から捨てられていくスタック
class RingStack(T) : Stack!(T){
protected:
    T[] _data;
    int _pointer = 0;
    int _depth = 0;
    void init(){
        static if(is(T == class)){
            foreach(ref d; this._data){
                d = null;
            }
        }else{
            foreach(ref d; this._data){
                d = T.init;
            }
        }
    }
    void forward_pointer(){
        this._pointer = (this._pointer + 1)%this.size;
    }
    void back_pointer(){
        this._pointer = (this._pointer - 1 + this.size)%this.size;
    }
public:
    this(int size){
        _data.length = size;
    }
    override void push(T val){
        this._data[this._pointer] = val;
        this.forward_pointer();
        this._depth = min(this._depth + 1, this.size);
    }
    override T pop(){
        if(this._depth <= 0){
            throw new Exception("Stack.pop : This stack is empty");
        }
        this.back_pointer();
        T res = this._data[this._pointer];
        this._depth -= 1;
        return res;
    }
    const T opIndex(int i){
        if(i >= this.depth){
            throw new Exception(text("Stack.opIndex : The index[",i, "]is too big. The stack's depth is ",this.depth));
        }
        return this._data[(this._pointer - 1 - i + this.size)%this.size];
    }
    const override string toString(){
        return text(this._data);
    }
    override const pure int depth(){
        return this._depth;
    }
    const pure int size(){
        return this._data.length;
    }
    const pure bool full(){
        return (this.depth +1 == this.size);
    }
    const pure bool empty(){
        return this.depth == 0;
    }
    /// foreach用
    override int opApply(int delegate(ref T) dg){
        for(uint i=0; i<this.depth; i++){
            int res = dg(this._data[(this._pointer - 1 - i + this.size)%this.size]);
            if(res != 0){return res;}
        }
        return 0;
    }
    /// foreach用
    override int opApply(int delegate(uint,ref T) dg){
        for(uint i=0; i<this.depth; i++){
            int res = dg(i, this._data[(this._pointer - 1 - i + this.size)%this.size]);
            if(res != 0){return res;}
        }
        return 0;
    }
    /// foreach_reverse用
    override int opApplyReverse(int delegate(ref T) dg){
        for(uint i=0; i<this.depth; i++){
            int j = this.depth - i - 1;
            int res = dg(this._data[(this._pointer - 1 - j + this.size)%this.size]);
            if(res != 0){return res;}
        }
        return 0;
    }
    /// foreach_reverse用
    override int opApplyReverse(int delegate(uint,ref T) dg){
        for(uint i=0; i<this.depth; i++){
            int j = this.depth - i - 1;
            int res = dg(j, this._data[(this._pointer - 1 - j + this.size)%this.size]);
            if(res != 0){return res;}
        }
        return 0;
    }
}
void main_(){
    auto a = new RingStack!(int)(10);
    auto f = new FixedStack!(int)(10);
    a.push(10);
    a.push(11);
    a.push(12);
    a.push(13);
    writeln(a.pop);
    writeln(a.pop);
    writeln(a.pop);
    a.push(14);
    a.push(15);
    a.push(16);
    a.push(17);
    a.push(18);
    a.push(19);
    a.push(20);
    a.push(21);
    a.push(22);
    a.push(23);
    a.push(24);
    a.push(25);
    a.push(26);
    a.push(27);
    writeln(a);
    foreach(ref aa;a){
        aa = aa*2;
    }

    writeln(a);
    int i = 0;
    while(1){
        writeln(a[i]);
        i++;
    }
}
