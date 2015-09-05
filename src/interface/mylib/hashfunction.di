// D import file generated from 'mylib\hashfunction.d'
module mylib.hashfunction;
import std.stdio;
import std.conv;
public import mylib.md5hashfunction;

public import mylib.luffahashfunction;

public import mylib.sha1hashfunction;

abstract class HashFunction
{
    const abstract ubyte[] hash(in ubyte[] data);

}

int mainHash(string[] args);
void testHash(in HashFunction h, in string str)
{
writeln(h.hash(cast(ubyte[])str));
}
