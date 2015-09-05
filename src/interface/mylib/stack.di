// D import file generated from 'mylib\stack.d'
module mylib.stack;
import std.stdio;
import std.conv;
import std.algorithm;
template Stack(T)
{
class Stack
{
    abstract void push(T val);

    abstract T pop();

    const abstract pure int depth();

    abstract int opApply(int delegate(ref T) dg);

    abstract int opApply(int delegate(uint, ref T) dg);

    abstract int opApplyReverse(int delegate(ref T) dg);

    abstract int opApplyReverse(int delegate(uint, ref T) dg);

}
}
template FixedStack(T)
{
class FixedStack : Stack!(T)
{
    protected 
{
    T[] _data;
    int _pointer = 0;
    int _depth = 0;
    void init()
{
static if(is(T == class))
{
foreach (ref d; this._data)
{
d = null;
}
}
else
{
foreach (ref d; this._data)
{
d = T.init;
}
}

}
    private void forward_pointer()
{
this._pointer = this._pointer + 1;
}

    private void back_pointer()
{
this._pointer = this._pointer - 1;
}

        public 
{
    this(int size)
{
_data.length = size;
}
    override void push(T val)
{
if (this._depth >= this._data.length - 1)
{
throw new Exception("Stack.full : Stack is full");
}
this._data[this._pointer] = val;
this.forward_pointer();
this._depth += 1;
}

    override T pop()
{
if (this._depth <= 0)
{
throw new Exception("Stack.pop : Stack is empty");
}
this.back_pointer();
T res = this._data[this._pointer];
this._depth -= 1;
return res;
}

    const override pure int depth()
{
return this._depth;
}

    const pure int size()
{
return this._data.length;
}

    const pure bool full()
{
return this.depth + 1 == this.size;
}

    const pure bool empty()
{
return this.depth == 0;
}

    override int opApply(int delegate(ref T) dg)
{
{
for (uint i = 0;
 i < this.depth; i++)
{
{
int res = dg(this._data[this._pointer - 1 - i]);
if (res != 0)
{
return res;
}
}
}
}
return 0;
}

    override int opApply(int delegate(uint, ref T) dg)
{
{
for (uint i = 0;
 i < this.depth; i++)
{
{
int res = dg(i,this._data[this._pointer - 1 - i]);
if (res != 0)
{
return res;
}
}
}
}
return 0;
}

    override int opApplyReverse(int delegate(ref T) dg)
{
{
for (uint i = 0;
 i < this.depth; i++)
{
{
int j = this.depth - i - 1;
int res = dg(this._data[this._pointer - 1 - j]);
if (res != 0)
{
return res;
}
}
}
}
return 0;
}

    override int opApplyReverse(int delegate(uint, ref T) dg)
{
{
for (uint i = 0;
 i < this.depth; i++)
{
{
int j = this.depth - i - 1;
int res = dg(i,this._data[this._pointer - 1 - j]);
if (res != 0)
{
return res;
}
}
}
}
return 0;
}

}
}
}
}
template RingStack(T)
{
class RingStack : Stack!(T)
{
    protected 
{
    T[] _data;
    int _pointer = 0;
    int _depth = 0;
    void init()
{
static if(is(T == class))
{
foreach (ref d; this._data)
{
d = null;
}
}
else
{
foreach (ref d; this._data)
{
d = T.init;
}
}

}
    void forward_pointer()
{
this._pointer = (this._pointer + 1) % this.size;
}
    void back_pointer()
{
this._pointer = (this._pointer - 1 + this.size) % this.size;
}
    public 
{
    this(int size)
{
_data.length = size;
}
    override void push(T val)
{
this._data[this._pointer] = val;
this.forward_pointer();
this._depth = min(this._depth + 1,this.size);
}

    override T pop()
{
if (this._depth <= 0)
{
throw new Exception("Stack.pop : This stack is empty");
}
this.back_pointer();
T res = this._data[this._pointer];
this._depth -= 1;
return res;
}

    const T opIndex(int i)
{
if (i >= this.depth)
{
throw new Exception(text("Stack.opIndex : The index[",i,"]is too big. The stack's depth is ",this.depth));
}
return this._data[(this._pointer - 1 - i + this.size) % this.size];
}

    const override string toString()
{
return text(this._data);
}

    const override pure int depth()
{
return this._depth;
}

    const pure int size()
{
return this._data.length;
}

    const pure bool full()
{
return this.depth + 1 == this.size;
}

    const pure bool empty()
{
return this.depth == 0;
}

    override int opApply(int delegate(ref T) dg)
{
{
for (uint i = 0;
 i < this.depth; i++)
{
{
int res = dg(this._data[(this._pointer - 1 - i + this.size) % this.size]);
if (res != 0)
{
return res;
}
}
}
}
return 0;
}

    override int opApply(int delegate(uint, ref T) dg)
{
{
for (uint i = 0;
 i < this.depth; i++)
{
{
int res = dg(i,this._data[(this._pointer - 1 - i + this.size) % this.size]);
if (res != 0)
{
return res;
}
}
}
}
return 0;
}

    override int opApplyReverse(int delegate(ref T) dg)
{
{
for (uint i = 0;
 i < this.depth; i++)
{
{
int j = this.depth - i - 1;
int res = dg(this._data[(this._pointer - 1 - j + this.size) % this.size]);
if (res != 0)
{
return res;
}
}
}
}
return 0;
}

    override int opApplyReverse(int delegate(uint, ref T) dg)
{
{
for (uint i = 0;
 i < this.depth; i++)
{
{
int j = this.depth - i - 1;
int res = dg(j,this._data[(this._pointer - 1 - j + this.size) % this.size]);
if (res != 0)
{
return res;
}
}
}
}
return 0;
}

}
}
}
}
void main_();
