/*******************************/
/* luffa.h                     */
/* Version 2.0 (Sep 15th 2009) */
/* Made by Hitachi Ltd.        */
/*******************************/
module luffa.luffa;
extern(C):

/* The length of digests*/
const int  DIGEST_BIT_LEN_224 = 224;
const int  DIGEST_BIT_LEN_256 = 256;
const int  DIGEST_BIT_LEN_384 = 384;
const int  DIGEST_BIT_LEN_512 = 512;

/*********************************/
/* The parameters of Luffa       */
const int MSG_BLOCK_BIT_LEN = 256;  /*The bit length of a message block*/
const int MSG_BLOCK_BYTE_LEN = (MSG_BLOCK_BIT_LEN >> 3); /* The byte length
                                                     * of a message block*/

/* The number of blocks in Luffa */
const int WIDTH_224 = 3;
const int WIDTH_256 = 3;
const int WIDTH_384 = 4;
const int WIDTH_512 = 5;

/* The limit of the length of message */
const int LIMIT_224 = 64;
const int LIMIT_256 = 64;
const int LIMIT_384 = 128;
const int LIMIT_512 = 128;
/*********************************/


alias ubyte BitSequence;
alias ulong DataLength;
enum HashReturn{ SUCCESS = 0, FAIL = 1, BAD_HASHBITLEN = 2} ;


alias ubyte uint8;
alias uint uint32;
alias ulong uint64;

struct hashState{
    int hashbitlen;
    int width;        /* The number of blocks in chaining values*/
    uint64 bitlen[2]; /* Message length in bits */
    uint32 rembitlen; /* Length of buffer data to be hashed */
    uint32 buffer[8]; /* Buffer to be hashed */
    uint32 chainv[40];   /* Chaining values */
} ;

HashReturn Init(hashState *state, int hashbitlen);
HashReturn Update(hashState *state, const BitSequence *data, DataLength databitlen);
HashReturn Final(hashState *state, BitSequence *hashval);
HashReturn Hash(int hashbitlen, const BitSequence *data, DataLength databitlen, BitSequence *hashval);
