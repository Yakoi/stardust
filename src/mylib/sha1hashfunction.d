module mylib.sha1hashfunction;
import std.stdio;
import sha.sha1;
import mylib.hashfunction;
class Sha1HashFunction : HashFunction{
    override const ubyte[] hash(in ubyte[] data){
        return sha.sha1.hash(cast(char[])data);
    }
}
