// D import file generated from 'mylib\pool.d'
module mylib.pool;
import std.stdio;
import std.conv;
template Pool(T)
{
class Pool
{
    T[] stack;
    uint _p;
    this(uint max, lazy T create)
{
stack.length = max;
foreach (ref s; stack)
{
s = create();
}
_p = 0;
}
        const nothrow pure bool full()
{
return _p == 0;
}

    const nothrow pure bool empty()
{
return _p == length;
}

    void push(T obj)
{
if (full())
{
throw new Exception("Pool.push (" ~ to!(string)(this.max) ~ ")");
}
_p--;
stack[_p] = obj;
}
    T pop()
{
if (empty())
{
throw new Exception("Pool.pop (" ~ to!(string)(this.max) ~ ")");
}
T res = stack[_p];
_p++;
return res;
}
    const nothrow pure uint max()
{
return stack.length;
}

    const nothrow pure uint length()
{
return stack.length;
}

    const nothrow pure uint using()
{
return _p;
}

    const nothrow pure uint rest()
{
return this.length - this.using;
}

    override string toString()
{
string str = "[";
{
for (int i = using;
 i < length; i++)
{
{
str ~= to!(string)(stack[i]);
str ~= ", ";
}
}
}
str ~= "]";
return str;
}

}
}
class A
{
    int x;
    this(int x)
{
this.x = x;
}
    override string toString()
{
return to!(string)(x);
}

}
alias Pool!(A) APool;
