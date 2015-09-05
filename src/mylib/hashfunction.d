module mylib.hashfunction;

import std.stdio;
import std.conv;

public import mylib.md5hashfunction;
public import mylib.luffahashfunction;
public import mylib.sha1hashfunction;
//public import mylib.sha512hashfunction;


abstract class HashFunction{
    const abstract ubyte[] hash(in ubyte[] data);
}



int mainHash(string[] args){
    const HashFunction h1 = new LuffaHashFunction();
    const HashFunction h2 = new Md5HashFunction();
    const HashFunction h3 = new Sha1HashFunction();
    if(args.length > 1){
        foreach(h; [h1, h2, h3]){
            foreach(s; args[1..$]){
                testHash(h, s);
            }
        }
    }else{
        string str1 = "a10";
        string str2 = "ag0";
        testHash(h1, str1);
        testHash(h1, str2);
        testHash(h2, str1);
        testHash(h2, str2);
        testHash(h3, str1);
        testHash(h3, str2);
        //testHash(h4, str1);
        //testHash(h4, str2);
    }
    return 0;
}
void testHash(in HashFunction h, in string str){
    //writeln(str);
    writeln(h.hash(cast(ubyte[])str));
}
