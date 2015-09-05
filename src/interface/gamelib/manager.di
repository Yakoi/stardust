// D import file generated from 'gamelib\manager.d'
module gamelib.manager;
import gamelib.generator;
import mylib.list;
import std.stdio;
import std.conv;
abstract template Manager(T)
{
class Manager
{
    List!(T) _usingList;
    this(List!(T) list)
{
this._usingList = list;
}
    abstract void removeDisenable();

    abstract void clear();

    int opApply(int delegate(ref T) dg)
{
return _usingList.opApply(dg);
}
    int opApply(int delegate(ref uint, ref T) dg)
{
return _usingList.opApply(dg);
}
    int opApplyReverse(int delegate(ref T) dg)
{
return _usingList.opApplyReverse(dg);
}
    int opApplyReverse(int delegate(ref uint, ref T) dg)
{
return _usingList.opApplyReverse(dg);
}
    override string toString()
{
return _usingList.toString();
}

    protected void pushList(T t)
{
_usingList.pushBack(t);
}

    uint list_length()
{
return _usingList.length;
}
}
}

template PoolManager(T)
{
class PoolManager : Manager!(T)
{
    PoolGenerator!(T) _generator;
    this(int max, T delegate() create)
{
this._generator = new PoolGenerator!(T)(max,create);
super(new FixedList!(T)(max));
}
    protected void _checkLen()
{
assert(_usingList.length + _generator.rest == _generator.length);
}

    override void removeDisenable()
{
foreach (t; _usingList)
{
if (!t.isEnable())
{
_generator._pool.push(t);
}
}
_usingList.remove(delegate (T t)
{
return !t.isEnable();
}
);
}

    override void clear()
{
foreach (t; _usingList)
{
_generator._pool.push(t);
}
_usingList.clear();
}

    uint rest()
{
return _generator.rest;
}
    uint max()
{
return _generator.max;
}
    uint using()
{
return _generator.using;
}
    protected T pushListFromPool()
{
T res = _generator._pool.pop();
pushList(res);
return res;
}

}
}
template NewManager(T)
{
class NewManager : Manager!(T)
{
    this()
{
super(new VariableList!(T));
}
    override void removeDisenable()
{
_usingList.remove(delegate (T t)
{
return !t.isEnable();
}
);
}

    override void clear()
{
_usingList.clear();
}

}
}
class Test
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

    bool isEnable()
{
return !x == 0;
}
}
class TestManagerPool : PoolManager!(Test)
{
    this(uint max);
    void test3()
in
{
_checkLen();
}
out
{
_checkLen();
}
body
{
Test res = pushListFromPool();
res.x = 3;
}
    void test10()
in
{
_checkLen();
}
out
{
_checkLen();
}
body
{
Test res = pushListFromPool();
res.x = 10;
}
    void test0()
in
{
_checkLen();
}
out
{
_checkLen();
}
body
{
Test res = pushListFromPool();
res.x = 0;
}
}
class TestManagerNew : NewManager!(Test)
{
    this()
{
super();
}
    void test3()
{
Test res = new Test(3);
pushList(res);
}
    void test10()
{
Test res = new Test(10);
pushList(res);
}
    void test0()
{
Test res = new Test(0);
pushList(res);
}
}
const bool USE_POOL = !false;

void _main();
