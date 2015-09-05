// D import file generated from 'gamelib\generator.d'
module gamelib.generator;
import mylib.pool;
import std.stdio;
import std.conv;
abstract class Generator
{
}

template PoolGenerator(T)
{
class PoolGenerator : Generator
{
    Pool!(T) _pool;
    this(Pool!(T) pool)
{
this._pool = pool;
}
    this(uint max, T delegate() create)
{
_pool = new Pool!(T)(max,create());
}
    bool full()
{
return _pool.full;
}
    bool empty()
{
return _pool.empty;
}
    uint max()
{
return _pool.max;
}
    uint length()
{
return _pool.length;
}
    uint using()
{
return _pool.using;
}
    uint rest()
{
return _pool.rest;
}
}
}
alias PoolGenerator!(int) intgen;
