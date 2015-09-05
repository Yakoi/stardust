// D import file generated from 'mylib\camelliaencoder.d'
module mylib.camelliaencoder;
import std.stdio;
import camellia.all;
import mylib.encoder;
import std.conv;
final class CamelliaEncoder : Encoder
{
    private 
{
    const int KEY_BIT_LENGTH = 256;

    uint[] keyTable;
    public 
{
    this(in ubyte[] pass)
in
{
assert(pass.length < KEY_BIT_LENGTH);
}
body
{
ubyte[] p = pass.dup;
p.length = KEY_BIT_LENGTH;
keyTable.length = (ubyte).sizeof * p.length / (int).sizeof;
Camellia_Ekeygen(KEY_BIT_LENGTH,cast(ubyte*)p,keyTable.ptr);
}
    this(in string pass)
in
{
assert(pass.length < KEY_BIT_LENGTH);
}
body
{
this(cast(ubyte[])pass);
}
    const override void[] encode(in void[] data);

    private const void[16] encode16(in void[] data)
in
{
assert(data.length == 16);
}
body
{
ubyte[16] res;
Camellia_EncryptBlock(KEY_BIT_LENGTH,cast(ubyte*)data.ptr,keyTable.ptr,res.ptr);
assert(data == this.decode16(res));
return cast(void[16])res;
}


    const override void[] decode(in void[] data);

    private const void[16] decode16(in void[] data)
in
{
assert(data.length == 16);
}
body
{
ubyte[16] res;
ubyte* data2 = cast(ubyte*)data.ptr;
Camellia_DecryptBlock(KEY_BIT_LENGTH,data2,keyTable.ptr,res.ptr);
return cast(void[16])res;
}


}
}
}

