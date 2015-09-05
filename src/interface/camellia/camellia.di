// D import file generated from 'camellia\camellia.d'
module camellia.camellia;
extern (C) 
{
    const int CAMELLIA_BLOCK_SIZE = 16;

    const int CAMELLIA_TABLE_BYTE_LEN = 272;

    const int CAMELLIA_TABLE_WORD_LEN = CAMELLIA_TABLE_BYTE_LEN / 4;

    alias uint* KEY_TABLE_TYPE;
    void Camellia_Ekeygen(const int keyBitLength, const ubyte* rawKey, KEY_TABLE_TYPE keyTable);
    void Camellia_EncryptBlock(const int keyBitLength, const ubyte* plaintext, const KEY_TABLE_TYPE keyTable, ubyte* cipherText);
    void Camellia_DecryptBlock(const int keyBitLength, const ubyte* cipherText, const KEY_TABLE_TYPE keyTable, ubyte* plaintext);
}
