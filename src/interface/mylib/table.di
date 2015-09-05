// D import file generated from 'mylib\table.d'
module mylib.table;
import std.string;
import std.conv;
import std.stdio;
import std.file;
class Table
{
    private 
{
    int[string] columnNames;
    string[][] data = [];
    public 
{
    this(string[] columnNames, in int h, in string initValue = "");
    this(string[string][] data);
    this(string[][] data)
in
{
assert(data.length >= 1);
const int len = data[0].length;
foreach (uint i, d; data[1..$])
{
assert(len == d.length,"line " ~ text(i) ~ "'s length is " ~ text(d.length) ~ ", but column's length is " ~ text(len));
}
}
body
{
this(data[0],data[1..$]);
}
    this(string[] columns, string[][] data);
    private void initData(int w, int h, string initData = "");

    TableRow opIndex(in int i)
{
return TableRow(this.data[i],this.columnNames);
}
    TableColumn opIndex(in string columnName)
{
return TableColumn(columnName,this);
}
    const override string toString()
{
return text(this.columnNames) ~ "\x0a" ~ text(this.data);
}

    string toCsv();
    const uint rowLength()
{
return this.data.length;
}

    alias rowLength length;
    const uint columnLength()
{
return this.columnNames.length;
}

    int opApply(int delegate(ref TableRow) dg);
    int opApply(int delegate(ref uint, ref TableRow) dg);
}
}
}
struct TableRow
{
    private 
{
    string[] data;
    int[string] columnNames;
    public 
{
    const string opIndex(in string key)
in
{
assert(key in this.columnNames,key ~ " is not in " ~ text(columnNames));
}
body
{
return this.data[this.columnNames[key]];
}

    void opIndexAssign(in string val, in string key)
in
{
assert(key in columnNames,key ~ " is not in " ~ text(columnNames));
}
body
{
this.data[this.columnNames[key]] = val;
}
    const uint columnLength()
{
return this.columnNames.length;
}

    int opApply(int delegate(ref string) dg);
    int opApply(int delegate(ref string, ref string) dg);
}
}
}
struct TableColumn
{
    private 
{
    string columnName;
    Table parentTable;
    public string opIndex(in int index)
{
return parentTable[index][columnName];
}

}
}
