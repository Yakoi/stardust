module mylib.camellia;
import std.stdio;
import std.conv;
import camellia.all;
import std.string;
import std.file;
import std.md5;
import std.zip;
import mylib.utils;

/// Camelliaのバージョン
const string CAMELLIA_VERSION = "1.2.0";
/// Camelliaを使って暗号化，復号をする
class Camellia{
private:
    const int KEY_BIT_LENGTH = 256;
	uint[]  keyTable;
public:
    ///暗号化されたデータの型
    //typedef ubyte[] Code;

    ///鍵データを指定して初期化
    this(in ubyte[] pass)
    in{
        assert(pass.length < KEY_BIT_LENGTH);
    }body{
        ubyte[] p = cast(ubyte[])pass;
        p.length = KEY_BIT_LENGTH;
        keyTable.length = ubyte.sizeof*p.length/int.sizeof;
        Camellia_Ekeygen(KEY_BIT_LENGTH,  cast(ubyte*)p,  keyTable.ptr);
    }

    ///鍵データを文字列で指定して初期化
    this(in string pass)
    in{
        assert(pass.length < KEY_BIT_LENGTH);
    }body{
        this(cast(ubyte[])pass);
    }

    /// データを暗号化
    private const void[] encode(in void[] data){
        void[] res;
        void[] d = cast(void[])data;
        int len = data.length;
        int len_16 = len/16;
        ubyte r = cast(ubyte)(len%16);
        int len16 = r==0 ? len_16*16 : (len_16+1)*16;
        res.length = len16;
        d.length   = len16;

        foreach(i; 0..len16/16){
            res[i*16..i*16+16] = encode16(d[i*16..i*16+16]);
        }
        return [r]~res;
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

    /// 文字列データを暗号化
    const void[] encodeString(in string data){
        return this.encode(cast(ubyte[])data);
    }

    /// データを復号
    private const void[] decode(in void[] data){
        void[] res;
        ubyte r = (cast(ubyte[])data)[0];
        void[] d = cast(void[])data[1..$];
        assert(d.length % 16 == 0, text(d.length));
        res.length = d.length;

        foreach(i; 0..d.length/16){
            res[i*16..i*16+16] = decode16(d[i*16..i*16+16]);
        }
        return res[0..$-(16-r)];
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

    /// データを復号して文字列に変換
    const string decodeString(in void[] code){
        return text(cast(char[])this.decode(code));
    }
}


ubyte[] encodeCamellia(in void[] data, in string key){
    const Camellia cam = new Camellia(key);
    ubyte[] data2 = cast(ubyte[])cam.encode(cast(ubyte[])data);
    return data2;
}
ubyte[] decodeCamellia(in ubyte[] data, in string key){
    auto cam = new Camellia(key);
    ubyte[] data2 = cast(ubyte[])(data);
    return cast(ubyte[])cam.decode(cast(ubyte[])data2);
}
void saveCamelliaData(in string path, in void[] data, in string key){
    //const Camellia cam = new Camellia(key);
    //ubyte[] data2 = cast(ubyte[])cam.encode(cast(ubyte[])data);
    auto data2 = encodeCamellia(data, key);
    std.file.write(path, data2);
}

ubyte[] loadCamelliaData(in string path, in string key){
    if(!exists(path) ||!isFile(path)){throw new Exception("camellia.load_data Load Error : " ~ path);}
    auto cam = new Camellia(key);
    ubyte[] data = cast(ubyte[])(std.file.read(path));
    auto data2 = decodeCamellia(data, key);
    //return cast(ubyte[])cam.decode(cast(ubyte[])data);
    return data2;
}

ubyte[] zipAndEncodedData(in string data, in string key){
    auto data1 = cast(ubyte[])(data~getDigestString(data)); // チェックディジットを付けたデータをアーカイブ化のためのデータにセット
    auto data2 = zipData(data1); // encode
    auto data3 = encodeCamellia(data2, key); //encode camellia
    return data3;
}

ubyte[] decodeAndUnzipData(in ubyte[] data, in string key){
    ubyte[] data0 = decodeCamellia(data, key);
    ubyte[] allData = cast(ubyte[])unzipData(data0);
    ubyte[] mainData = allData[0..$-32];
    string md5Data = cast(string)allData[$-32..$];
    if(md5Data == getDigestString(mainData)){
        return mainData;
    }else{
        throw new Exception("oioi");
    }
}
