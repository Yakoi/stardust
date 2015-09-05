module mylib.pxtone;

import pxtone.all;
import std.string;

class PxtoneFileMusic{
    string _path;
    this(string path){
        this._path = path;
    }

    void open(){
        pxtone_Tune_Load( null, null, cast(char*)toStringz(this._path));
    }
}

class PxtoneResourceMusic{
    string _type_name;
    string _file_name;
    this(string type_name, string file_name){
        this._type_name = type_name;
        this._file_name = file_name;
    }

    void open(){
        pxtone_Tune_Load( null, cast(char*)toStringz(this._type_name), cast(char*)toStringz(this._file_name));
    }
}
class PxtoneMemoryMusic{
    void[] _data;
    this(void[] data){
        this._data = data;
    }

    void open(){
        pxtone_Tune_Read( this._data.ptr, this._data.length );
    }
}
