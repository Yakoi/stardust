// D import file generated from 'mylib\utils.d'
module mylib.utils;
import std.stdio;
import std.conv;
import std.string;
import std.c.stdlib;
import std.c.locale;
import std.windows.charset;
import std.datetime;
import std.zip;
import std.xml;
import mylib.yaml;
import mylib.csv;
import mylib.table;
import mylib.encoder;
import mylib.hashfunction;
pure template abs(T)
{
T abs(in T data)
{
return data < 0 ? -data : data;
}
}

pure template max(T)
{
T max(in T x, in T[] xs...)
{
static if(is(T == const(double)))
{
double res = x;
}
else
{
static if(is(T == const(int)))
{
int res = x;
}
else
{
T res = x;
}

}

foreach (xx; xs)
{
if (xx > res)
{
res = xx;
}
}
return res;
}
}

pure template maxArray(T)
{
T maxArray(in T[] xs)
in
{
assert(xs.length >= 1);
}
body
{
T res = xs[0];
foreach (x; xs)
{
if (x > res)
{
res = x;
}
}
return res;
}
}

pure template min(T)
{
T min(in T x, in T[] xs...)
{
static if(is(T == const(double)))
{
double res = x;
}
else
{
static if(is(T == const(int)))
{
int res = x;
}
else
{
T res = x;
}

}

foreach (xx; xs)
{
if (xx < res)
{
res = xx;
}
}
return res;
}
}

pure template minArray(T)
{
T minArray(in T[] xs)
in
{
assert(xs.length >= 1);
}
body
{
T res = xs[0];
foreach (x; xs)
{
if (x < res)
{
res = x;
}
}
return res;
}
}

pure template between(T)
{
T between(in T x, in T y, in T z)
in
{
assert(x <= z);
}
body
{
return min(max(x,y),z);
}
}

pure template contain(T)
{
bool contain(in T[] xs, in T x)
{
foreach (xx; xs)
{
if (x == xx)
{
return true;
}
}
return false;
}
}

char[] toCString(in string str, in int start = 0, in int end = (int).max)
{
return cast(char[])str;
}
char[] toCString(in char[] str, in int start = 0, in int end = (int).max)
{
return cast(char[])str[0..min!(int)(end,$)];
}
wchar* toWStringz(char[] str)
{
return to!(wchar[])(str ~ "\x00").ptr;
}
wchar* toWStringz(string str)
{
return to!(wchar[])(str ~ "\x00").ptr;
}
wchar* toWStringz(dchar[] str)
{
return to!(wchar[])(str ~ "\x00").ptr;
}
wchar* toWStringz(dstring str)
{
return to!(wchar[])(str ~ "\x00").ptr;
}
wchar* toWStringz(wchar[] str)
{
return to!(wchar[])(str ~ "\x00").ptr;
}
wchar* toWStringz(wstring str)
{
return to!(wchar[])(str ~ "\x00").ptr;
}
wstring[] divstr(in wstring wstr, in int num);
void[] zipData(in ubyte[] data, in string directory = "")
{
auto archive = new ZipArchive;
auto mem = new ArchiveMember;
mem.expandedData = data.dup;
mem.name = directory;
mem.compressionMethod = 8;
archive.addMember(mem);
auto data2 = archive.build();
return data2;
}
void[] unzipData(in ubyte[] data, in string directory = "")
{
auto archive = new ZipArchive(cast(ubyte[])data);
auto data1 = archive.expand(archive.directory[directory]);
return data1;
}
string getXmlSignature(in Base64Encoder b64, in Encoder enc, in HashFunction hf, in std.xml.Element elm)
{
return cast(string)b64.encode(enc.encode(hf.hash(cast(ubyte[])join(elm.pretty(0),""))));
}
string getXmlSignature(in Encoder enc, in HashFunction hf, in std.xml.Element elm)
{
return cast(string)std.base64.Base64.encode(cast(ubyte[])enc.encode(hf.hash(cast(ubyte[])join(elm.pretty(0),""))));
}
bool checkXmlSignature(in Encoder enc, in HashFunction hf, in string xmlData);
void setXmlSignature(in Encoder enc, in HashFunction hf, ref Element elem);
YamlNode tableToYamlNode(Table tbl);
