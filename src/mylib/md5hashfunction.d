module mylib.md5hashfunction;
import mylib.hashfunction;
import std.stdio;
import std.md5;

///
class Md5HashFunction : HashFunction{
    const override ubyte[] hash(in ubyte[] data){
        return cast(ubyte[])getDigestString(data);
    }
}
