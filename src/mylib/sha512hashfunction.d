module mylib.sha512hash;

import std.stdio;
import mylib.hash;
import sha.sha512;

class Sha512Hash : Hash{
    deprecated override const ubyte[] hash(in ubyte[] data){
        //return cast(ubyte[])sha.sha512.digestToString(cast(ubyte[32u])data[0..32u]);
        assert(false);
    }
}
