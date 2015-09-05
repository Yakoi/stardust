module mylib.encoder;
import std.stdio;

public import mylib.camelliaencoder;
public import mylib.zipencoder;
public import mylib.base64encoder;

/// エンコードする
abstract class Encoder{
    /// エンコードする
    /// Params:
    ///     data = 元データ
    /// Result:
    ///     変換後のデータ
    abstract const void[] encode(in void[] data);
    /// 戻り値の型を指定してエンコードする
    /// Params:
    ///     data = 元データ
    /// Result:
    ///     変換後のデータ
    final const T encodeTo(T)(in void[] data)
    out(res){
        assert(checkEncode(data, res), cast(string)this.decode(res)~"\n"~cast(string)data);
    }body{
        static assert(is(T : byte[]) || is(T : char[]) || is(T : string)
                || is(T : ubyte[]) || is(T : void[]));
        return cast(T)this.encode(data);
    }
    /// エンコードしてstring型のデータを返す
    /// Params:
    ///     data = 元データ
    /// Result:
    ///     変換後のデータ
    alias encodeTo!(string) encodeString;
    /// 正常にエンコードされたかどうか（デコードしたら元に戻るかどうか）調べる
    /// 継承先でチェックに使って
    /// Params:
    ///     data = 元データ
    ///     res  = 変換後のデータ
    /// Result:
    ///     trueなら正常にエンコードされた
    protected const bool checkEncode(in void[] data, in void[] res){
        return this.decode(res) == data;
    }
    /// デコードする
    /// Params:
    ///     data = 変換されたデータ
    /// Result:
    ///     元データ
    abstract const void[] decode(in void[] data);
    /// 型を指定してデコードする
    /// Params:
    ///     data = 変換されたデータ
    /// Result:
    ///     元データ
    final const T decodeType(T)(in void[] data)
    out(res){
        assert(checkDecode(data, res), cast(string)this.encode(res)~"\n"~cast(string)data);
    }body{
        static assert(is(T : byte[]) || is(T : char[]) || is(T : string)
                || is(T : ubyte[]) || is(T : void[]));
        return cast(T)this.decode(data);
    }
    /// デコードしてstring型のデータを返す
    /// Params:
    ///     data = 変換されたデータ
    /// Result:
    ///     元データ
    alias decodeType!(string) decodeString;
    ///
    final const pure Encoder opMul(in Encoder e2){
        const Encoder e1 = this;
        return new MulEncoder(e1, e2);
    }
    /// 正常にデコードされたかどうか（エンコードしたら元に戻るかどうか）調べる
    /// 継承先でチェックに使って
    /// Params:
    ///     data = 変換されたデータ
    ///     res  = 元データ
    /// Result:
    ///     trueなら正常にデコードされた
    protected const bool checkDecode(in void[] data, in void[] res){
        return this.encode(res) == data;
    }
}
/// エンコードクラスの合成
/// 合成関数と一緒
final class MulEncoder : Encoder{
private:
    const Encoder e1;
    const Encoder e2;
    this(in Encoder e1, in Encoder e2){
        this.e1 = e1;
        this.e2 = e2;
    }
public:
    /// e2, e1の順番にエンコード
    override const void[] encode(in void[] data){
        return this.e1.encode(this.e2.encode(data));
    }
    /// e1, e2の順番にデコード
    override const void[] decode(in void[] data){
        return this.e2.decode(this.e1.decode(data));
    }
}


version(none)
int main(string[] args){
    const Encoder e1 = new CamelliaEncoder(cast(ubyte[])"okok");
    const Encoder e1_ = new CamelliaEncoder(cast(ubyte[])"okaaaaaaaaaaagagwgtw4tohoiok");
    const Encoder e2 = new ZipEncoder();
    const Encoder e3 = new Base64Encoder();
    const string a = "okあああaaaaaaaaaaaaaaaahgggggggggggggggggljlkjelwjtjitjwijtiwjtiwjoitjwoirjgghagnnbnoigoirj";
    testEncoder(e1,a);
    testEncoder(e2,a);
    testEncoder(e3,a);
    testEncoder(e1*e2*e3,a);
    testEncoder(e1*e1*e1_,a);
    writeln(e3.encodeTo!(char[])(a));


    return 0;
}

void testEncoder(in Encoder e, in string str){
    writeln(str);
    const void[] b = e.encode(str);
    writeln("->", b.length);
    const string c = e.decodeString(b);
    writeln(c);
}
