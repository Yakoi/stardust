// D import file generated from 'mylib\camellia.d'
module mylib.camellia;
import std.stdio;
import std.conv;
import camellia.all;
import std.string;
import std.file;
import std.md5;
import std.zip;
import mylib.utils;
const string CAMELLIA_VERSION = "1.2.0";

class Camellia
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
ubyte[] p = cast(ubyte[])pass;
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
    private const void[] encode(in void[] data);


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


    const void[] encodeString(in string data)
{
return this.encode(cast(ubyte[])data);
}

    private const void[] decode(in void[] data);


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


    const string decodeString(in void[] code)
{
return text(cast(char[])this.decode(code));
}

}
}
}
ubyte[] encodeCamellia(in void[] data, in string key)
{
const Camellia cam = new Camellia(key);
ubyte[] data2 = cast(ubyte[])cam.encode(cast(ubyte[])data);
return data2;
}
ubyte[] decodeCamellia(in ubyte[] data, in string key)
{
auto cam = new Camellia(key);
ubyte[] data2 = cast(ubyte[])data;
return cast(ubyte[])cam.decode(cast(ubyte[])data2);
}
void saveCamelliaData(in string path, in void[] data, in string key)
{
auto data2 = encodeCamellia(data,key);
std.file.write(path,data2);
}
ubyte[] loadCamelliaData(in string path, in string key);
ubyte[] zipAndEncodedData(in string data, in string key)
{
auto data1 = cast(ubyte[])(data ~ getDigestString(data));
auto data2 = zipData(data1);
auto data3 = encodeCamellia(data2,key);
return data3;
}
ubyte[] decodeAndUnzipData(in ubyte[] data, in string key);
