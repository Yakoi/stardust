import mylib.squirrel;
import squirrel.all;
import std.windows.charset;
import std.conv;

import std.stdio;

int main(string[] args){
    SquirrelObject sum(SquirrelObject[] args){
        int res = 0;
        foreach(so; args){
            with(SquirrelType)switch(so.type){
                case INTEGER:
                    res += so.i;
                    break;
                default:
                    break;
            }
        }
        return sqv(res);
    }
    auto s = loadSquirrel("test.nut");
    //s.register!("ok")( &ok);
    //s.registerFunction!("ok")(&ok);
    s.doBuffer(`function ok(){return "he";}`);
    s.registerDelegate!("sum")(&sum);
    //writeln(1);
    //s.test();
    //auto t = new Squirrel("print(4+4+3+2*4*4*5+34)");
    s.doFile("sub.nut");
    writeln(s.call("foo", sqv(4), sqv(5), sqv(6)));
    //writeln(s.call("foo", sqv(1), sqv(2), sqv(3)));
    //writeln(sqv(2),"*",sqv(3)," is ",s.call("bar", sqv(2), sqv(3)));
    //writeln(s.get("a"));
    return 0;
}

/+
extern(C) int ok(HSQUIRRELVM v){
    writeln("okok");
    return 0;
}
+/
SquirrelObject ok(SquirrelObject[] args){
    foreach(a;args){
        writeln(a);
    }
    return sqv("hello");
}
