// D import file generated from 'luffa\luffa.d'
module luffa.luffa;
extern (C) 
{
    const int DIGEST_BIT_LEN_224 = 224;

    const int DIGEST_BIT_LEN_256 = 256;

    const int DIGEST_BIT_LEN_384 = 384;

    const int DIGEST_BIT_LEN_512 = 512;

    const int MSG_BLOCK_BIT_LEN = 256;

    const int MSG_BLOCK_BYTE_LEN = MSG_BLOCK_BIT_LEN >> 3;

    const int WIDTH_224 = 3;

    const int WIDTH_256 = 3;

    const int WIDTH_384 = 4;

    const int WIDTH_512 = 5;

    const int LIMIT_224 = 64;

    const int LIMIT_256 = 64;

    const int LIMIT_384 = 128;

    const int LIMIT_512 = 128;

    alias ubyte BitSequence;
    alias ulong DataLength;
    enum HashReturn 
{
SUCCESS = 0,
FAIL = 1,
BAD_HASHBITLEN = 2,
}
    alias ubyte uint8;
    alias uint uint32;
    alias ulong uint64;
    struct hashState
{
    int hashbitlen;
    int width;
    uint64[2] bitlen;
    uint32 rembitlen;
    uint32[8] buffer;
    uint32[40] chainv;
}
    HashReturn Init(hashState* state, int hashbitlen);
    HashReturn Update(hashState* state, const BitSequence* data, DataLength databitlen);
    HashReturn Final(hashState* state, BitSequence* hashval);
    HashReturn Hash(int hashbitlen, const BitSequence* data, DataLength databitlen, BitSequence* hashval);
}
