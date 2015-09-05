// D import file generated from 'sha\sha1.d'
module sha.sha1;
import std.stream;
ubyte[] hash(uint seed);
ubyte[] hash(char[] msg)
{
SHA1 hash = new SHA1(cast(ubyte[])msg);
return hash.hash();
}
uint[] hashUInts(uint seed);
uint[] hashUInts(char[] msg);
uint hashUInt(uint seed)
{
uint[] value;
value = hashUInts(seed);
return value[0] ^ value[1] ^ value[2] ^ value[3] ^ value[4];
}
uint hashUInt(char[] msg);
class SHA1
{
    private 
{
    const int HashSize = 20;

    uint[HashSize / 4] IntermediateHash;
    uint Length;
    uint LengthLow;
    uint LengthHigh;
    int MessageBlockIndex;
    ubyte[64] MessageBlock;
    int Computed;
    int Corrupted;
    ubyte[] Message;
    const uint[4] K = [1518500249,1859775393,-1894007588u,-899497514u];

    public 
{
    this(ubyte[] msg)
{
Length = msg.length;
LengthLow = 0;
LengthHigh = 0;
MessageBlockIndex = 0;
IntermediateHash[0] = 1732584193;
IntermediateHash[1] = -271733879u;
IntermediateHash[2] = -1732584194u;
IntermediateHash[3] = 271733878;
IntermediateHash[4] = -1009589776u;
Computed = 0;
Corrupted = 0;
Message = msg;
}
    ubyte[] hash();
    private 
{
    uint shiftCircular(uint bits, uint value)
{
return value << bits | value >> 32 - bits;
}
    void paddingMessage();
    void processMessageBlock();
    void calclation();
}
}
}
}
