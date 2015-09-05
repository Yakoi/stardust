module mylib.database;

import std.stdio;
import sqlite3.sqlite3;
import std.conv;
import std.string;

pragma(lib, "sqlite3");

/// 一行のデータ。タプル。
alias string[string] Row;

/// ひとつのデータベースファイルを管理するクラス
class Database{
private:
    sqlite3.sqlite3.sqlite3* _db;
public:
    /// 開くDBファイル名を指定してクラス作成
    this(string name){
        int check = sqlite3_open( cast(char*)toStringz(name), &this._db);
        if( SQLITE_OK==check){
            // do nothing
        } else{
            throw new Exception("Faild!");
        }
    }
    /// メモリ内にデータベース作成
    this(){
        this(":memory:");
    }
    /// SQL文を実行してその結果を得る
    /// Params:
    ///     str = SQL文
    Row[] query(string str){
        Row[] res;
        extern(C) static int callback(void* res, int argc, char** argv, char** name){
            Row[]* _res = (cast(Row[]*)res);
            Row r;
            for(int i=0; i<argc; i++){
                string key = to!(string)(name[i]);
                string data = to!(string)(argv[i]);
                r[key] = data;
            }
            _res.length = _res.length+1;
            (*_res)[$-1] = r;
            return SQLITE_OK;
        }
        char* error_msg;
        int rc = sqlite3_exec(this._db,
                cast(char*)toStringz(str),
                &callback, cast(void*)&res, &error_msg);
        string errorMessage = to!(string)(error_msg);
        if(errorMessage.length == 0){
            return res;
        }else{
            throw new Exception(errorMessage);
        }
    }

    /// テーブルが存在するかどうかを調べる
    /// Params:
    ///     tableName = 存在するか調べたいテーブルの名前
    bool hasTable(in string tableName){
        string sql = "SELECT count(*) AS 'c' FROM sqlite_master WHERE type='table' AND name='" ~ tableName ~ "';";
        Row[] res = this.query(sql);
        assert(res.length == 1);
        switch(to!(int)(res[0]["c"])){
            case 1:
                return true;
            case 0:
                return false;
            default:
                assert(false);
        }
    }
    /// 行を追加する
    /// Params:
    ///     table = 行を追加するテーブル名
    ///     Row data = 追加するデータ
    void insert(string table, Row data){
        string keys = "";
        string ds = "";
        foreach(k,d; data){
            if(keys.length == 0){
                keys ~= k;
            }else{
                keys ~= ","~k;
            }
            if(ds.length == 0){
                ds   ~= d;
            }else{
                ds ~= "," ~ d;
            }
        }
        writeln(data);
        writeln("INSERT INTO "~table~"("~keys~") values ("~ds~")");
        this.query("INSERT INTO "~table~"("~keys~") values ("~ds~")");
    }
    /// sqliteのバージョンを取得
    static string version_str(){
        return text(sqlite3_libversion);
    }
    /// sqliteのバージョンを取得
    static int version_num(){
        return sqlite3_libversion_number();
    }
}
//class Row{
//}



int main_(string[] args){
    Database db = new Database("hoge.db");
    writeln(db.version_str);
    writeln(db.version_num);
    Row idata;
    idata["worker"] = "unko--------------";
    idata["aaa"] = "worker";
    idata["bbb"] = "worker";
    idata["sample"] = "worker";
    db.insert("sample",idata);
    foreach(r; db.query("SELECT worker,aaa FROM sample")){
        foreach(k,d; r){
            writeln("key:",k,",       data:",d);
        }
    }
    return 0;
}
