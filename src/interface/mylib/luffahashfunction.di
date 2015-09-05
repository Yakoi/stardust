// D import file generated from 'mylib\luffahashfunction.d'
module mylib.luffahashfunction;
import mylib.hashfunction;
import std.stdio;
import luffa.all;
enum LuffaDigitBitLen 
{
LEN224 = DIGEST_BIT_LEN_224,
LEN256 = DIGEST_BIT_LEN_256,
LEN384 = DIGEST_BIT_LEN_384,
LEN512 = DIGEST_BIT_LEN_512,
}
final class LuffaHashFunction : mylib.hashfunction.HashFunction
{
    private const LuffaDigitBitLen bitLen;


    this(in LuffaDigitBitLen bitLen = LuffaDigitBitLen.LEN256)
{
this.bitLen = bitLen;
}
    const override ubyte[] hash(in ubyte[] data);

}

