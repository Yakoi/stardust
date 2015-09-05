module mylib.base64encoder;

import std.base64;
import mylib.encoder;
import std.stdio;

final class Base64Encoder : Encoder{
    override const void[] encode(in void[] data){
        return cast(void[])std.base64.Base64.encode(cast(ubyte[])data);
    }
    override const void[] decode(in void[] data){
        return cast(void[])std.base64.Base64.decode(cast(string)data);
    }
}



