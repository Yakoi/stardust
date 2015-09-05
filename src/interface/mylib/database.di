// D import file generated from 'mylib\database.d'
module mylib.database;
import std.stdio;
import sqlite3.sqlite3;
import std.conv;
import std.string;
pragma (lib, "sqlite3");
alias string[string] Row;
class Database
{
    private 
{
    sqlite3.sqlite3.sqlite3* _db;
    public 
{
    this(string name);
    this()
{
this(":memory:");
}
    Row[] query(string str);
    bool hasTable(in string tableName);
    void insert(string table, Row data);
    static string version_str()
{
return text(sqlite3_libversion);
}

    static int version_num()
{
return sqlite3_libversion_number();
}

}
}
}
int main_(string[] args);
