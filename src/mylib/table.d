module mylib.table;

import std.string;
import std.conv;
import std.stdio;
import std.file;
/// Csvファイルと親和性の高いテーブル形式
/// DBにも使えそう
class Table{
private:
    int[string] columnNames;
    string[][] data = [];
public:
    /// 列名と高さを与えて表を作る
    this(string[] columnNames, in int h, in string initValue = ""){
        foreach(int i, cn; columnNames){
            this.columnNames[cn] = i;
        }
        initData(this.columnNames.length, h, initValue);
    }
    /// DBのクエリー結果から表を作る
    this(string[string][] data)
    in{
        assert(data.length >= 1);
    }body{
        string[] columns = data[0].keys;
        foreach(uint i,col; columns){
            this.columnNames[col] = i;
        }
        this.data.length = data.length;
        foreach(uint y, string[string] d; data){
            this.data[y].length = this.columnNames.length;
            foreach(string key, int x; this.columnNames){
                assert(key in d, key ~ " not in " ~ text(d));
                assert(y < this.data.length, text(y) ~ " is over range of " ~ text(this.data));
                assert(x < this.data[y].length, text(x) ~ " is over range of " ~ text(this.data[y]));
                this.data[y][x] = d[key];
            }
        }
        
    }
    /// ひとつのテーブルデータから表を作る
    this(string[][] data)
    in{
        assert(data.length >= 1);
        const int len = data[0].length;
        foreach(uint i,d; data[1..$]){
            assert(len == d.length, 
                      "line " ~ text(i) ~ "'s length is " ~ text(d.length) 
                    ~ ", but column's length is " ~ text(len));
        }
    }body{
        this(data[0], data[1..$]);
    }
    /// Columnの名前配列とデータテーブルをバラバラに読み込み、テーブルを作る
    this(string[] columns, string[][] data)
    in{
        const int len = columns.length;
        foreach(uint i,d; data){
            assert(len == d.length, 
                      "line " ~ text(i) ~ "'s length is " ~ text(d.length) 
                    ~ ", but column's length is " ~ text(len));
        }
    }body{
        foreach(uint i,d; columns){
            columnNames[d] = i;
        }
        this.data = data;
    }
    /// データの初期化
    private void initData(int w, int h, string initData = ""){
        this.data.length = h;
        foreach(ref string[] d; this.data){
            d.length = w;
            foreach(ref string id; d){
                id = initData;
            }
        }
    }
    /// データへのアクセス
    TableRow opIndex(in int i){
        return TableRow(this.data[i], this.columnNames);
    }
    /// データへのアクセス(Column)
    TableColumn opIndex(in string columnName){
        return TableColumn(columnName, this);
    }
    /// 文字列へ直す（適当）
    const override string toString(){
        return text(this.columnNames) ~ "\n" ~ text(this.data);
    }
    /// Csvへ直す（あってるかな？）
    string toCsv(){
        string res;

        string[] columns;
        columns.length = this.columnNames.length;
        // 表の一番上
        foreach(string columnName, int idx; this.columnNames){
            columns[idx] = columnName;
        }
        foreach(string data; columns){
            res ~= data;
            res ~= ",";
        }
        res = res[0..$-1];
        res ~= "\n";

        // ここからデータ
        foreach(uint i, TableRow row; this){
            foreach(string columnName; columns){
                string data = row[columnName];
                res ~= data;
                res ~= ",";
            }
            res = res[0..$-1];
            res ~= "\n";
        }
        return res[0..$-1];
    }
    /// 行の数
    const uint rowLength(){
        return this.data.length;
    }
    alias rowLength length;
    /// 列の数
    const uint columnLength(){
        return this.columnNames.length;
    }
    /// foreach用
    int opApply(int delegate(ref TableRow) dg)
    {
        int result = 0;
        foreach (int i; 0..this.rowLength)
        {
            TableRow tmp = this[i];
            result = dg(tmp);
            if (result){ break;}
        }
        return result;
    }
    /// foreach用
    int opApply(int delegate(ref uint, ref TableRow) dg)
    {
        int result = 0;
        foreach (uint i; 0..this.rowLength)
        {
            TableRow tmp = this[i];
            result = dg(i, tmp);
            if (result){ break;}
        }
        return result;
    }
}
/// 行
struct TableRow{
private:
    string[] data;
    int[string] columnNames;
public:
    /// データ取得
    const string opIndex(in string key)
    in{
        assert(key in this.columnNames, key ~ " is not in " ~ text(columnNames));
    }body{
        return this.data[this.columnNames[key]];
    }
    /// データ設定
    void opIndexAssign(in string val, in string key)
    in{
        assert(key in columnNames, key ~" is not in " ~ text(columnNames));
    }body{
        this.data[this.columnNames[key]] = val;
    }
    /// 列の数
    const uint columnLength(){
        return this.columnNames.length;
    }
    /// foreach用
    int opApply(int delegate(ref string) dg)
    {
        int result = 0;
        foreach (string s,int i; this.columnNames)
        {
            string tmp = this[s];
            result = dg(tmp);
            if (result){ break;}
        }
        return result;
    }
    /// foreach用
    int opApply(int delegate(ref string, ref string) dg)
    {
        int result = 0;
        foreach (string s,int i; this.columnNames)
        {
            string tmp = this[s];
            result = dg(s, tmp);
            if (result){ break;}
        }
        return result;
    }
}
/// 列
struct TableColumn{
private:
    string columnName;
    Table parentTable;
public:
    string opIndex(in int index){
        return parentTable[index][columnName];
    }
}
