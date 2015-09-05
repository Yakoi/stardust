module mylib.csv;

import std.string;
import std.conv;
import std.stdio;
import std.file;
import mylib.table;


/// Csvを分解して配列にする
string[][] divideCsv(T)(T buf)
{
    const char SP = ',';
    T[][] res;
    T[] divbuf = splitLines(buf);
    res.length = divbuf.length;
    foreach(uint i,db; divbuf){
        T[] sp = split!(T)(db, [SP]);
        res[i].length = sp.length;
        foreach(uint j,T str; sp){
            res[i][j] = strip(removechars(str,"\""));
        }
    }
    return res;
}
Table csvToTable(string buf){
    return new Table(divideCsv(buf));
}


/// Csvデータをファイルからロード
string[][] loadCsv(string path){
    if(!exists(path) ||!isFile(path)){throw new Exception("yaml.loadCsv Load Error : " ~ path);}

    ubyte[] input = cast(ubyte[])(std.file.read(path));
    return divideCsv(cast(string)input);
}
Table loadCsvAsTable(string path){
    return new Table(loadCsv(path));
}
