// D import file generated from 'mylib\csv.d'
module mylib.csv;
import std.string;
import std.conv;
import std.stdio;
import std.file;
import mylib.table;
template divideCsv(T)
{
string[][] divideCsv(T buf)
{
const char SP = ',';
T[][] res;
T[] divbuf = splitlines(buf);
res.length = divbuf.length;
foreach (uint i, db; divbuf)
{
T[] sp = split!(T)(db,[SP]);
res[i].length = sp.length;
foreach (uint j, T str; sp)
{
res[i][j] = strip(removechars(str,"\""));
}
}
return res;
}
}
Table csvToTable(string buf)
{
return new Table(divideCsv(buf));
}
string[][] loadCsv(string path);
Table loadCsvAsTable(string path)
{
return new Table(loadCsv(path));
}
