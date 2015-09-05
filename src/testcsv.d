import std.stdio;
import mylib.csv;
import mylib.database;
import std.windows.charset;
import std.conv;


void main(){
    auto db = new Database("score.db");
    //auto csvs = (divideCsv!(string)("name,ok, go, aa\n4,5,3,2\naaa,bb,c c c,   "));
    //auto tb = new Table(csvs);
    //writeln(tb);
    //writeln(tb[1]["name"]);
    auto rows = db.query("select * from score");
    auto tb = loadCsvAsTable("ホシクズ_要件一覧.csv");
    auto tb2 = new Table(rows);
    writeln(tb.toCsv);
/+
    writeln(text(toMBSz(text(tb))));
    writeln(text(toMBSz(text(tb[3]["説明"]))));
    foreach(uint i,row; tb){
        wln(i);
        foreach(string key, string str; row){
            wln("    " ~ key ~ " : " ~ str);
        }
    }
    +/

}
void wln(T)(T s){
    writeln(text(toMBSz(text(s))));
}
