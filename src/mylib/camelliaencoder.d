module mylib.camelliaencoder;
import std.stdio;
import camellia.all;
import mylib.encoder;
import std.conv;

/// Cammeliaをつかったエンコーダ
final class CamelliaEncoder : Encoder{
private:
    //キーの長さ
    const int KEY_BIT_LENGTH = 256;
    uint[]  keyTable;
public:
    ///鍵データを指定して初期化
    this(in ubyte[] pass)
    in{
        assert(pass.length < KEY_BIT_LENGTH);
    }body{
        ubyte[] p = pass.dup;
        p.length = KEY_BIT_LENGTH;
        keyTable.length = ubyte.sizeof*p.length/int.sizeof;
        Camellia_Ekeygen(KEY_BIT_LENGTH,  cast(ubyte*)p,  keyTable.ptr);
    }
    ///鍵データを指定して初期化
    this(in string pass)
    in{
        assert(pass.length < KEY_BIT_LENGTH);
    }body{
        this(cast(ubyte[])pass);
    }
    /// データを暗号化
    override const void[] encode(in void[] data){
        void[] res;
        void[] d = cast(void[])data;
        const int len = data.length;
        const int len_16 = len/16;
        const ubyte r = cast(ubyte)(len%16);
        const int len16 = r==0 ? len_16*16 : (len_16+1)*16;
        res.length = len16;
        d.length   = len16;

        foreach(i; 0..len16/16){
            res[i*16..i*16+16] = encode16(d[i*16..i*16+16]);
        }
        return cast(ubyte[])([r]~res);
    }
    /// データを暗号化16
    private const void[16] encode16(in void[] data)
    in{
        assert(data.length == 16);
    }body{
        ubyte[16] res;
        Camellia_EncryptBlock(
                KEY_BIT_LENGTH, 
                cast(ubyte*)data.ptr,
                keyTable.ptr,
                res.ptr);

        assert(data == this.decode16(res));
        return cast(void[16])res;
    }
    /// データを復号
    override const void[] decode(in void[] data){
        void[] res;
        ubyte r = (cast(ubyte[])data)[0];
        void[] d = cast(void[])data[1..$];
        assert(d.length % 16 == 0, text(d.length));
        res.length = d.length;

        foreach(i; 0..d.length/16){
            res[i*16..i*16+16] = decode16(d[i*16..i*16+16]);
        }
        return cast(ubyte[])(res[0..$-(16-r)]);
    }
    /// データを復号16
    private const void[16] decode16(in void[] data)
    in{
        assert(data.length == 16);
    } body{
        ubyte[16] res;
        ubyte* data2 = cast(ubyte*)(data.ptr) ;
        Camellia_DecryptBlock(
                KEY_BIT_LENGTH,
                data2,
                keyTable.ptr,
                res.ptr);
        return cast(void[16])res;
    }
}
