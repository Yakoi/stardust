module surfacetable;

import std.stdio;
import std.file;
import std.path;
import gameall;

class SurfaceTable : Table!(Surface){
    Surface[string] _table;
    Surface shot;
    Surface[4] bk_night;
    BlendSurface blend;
    Surface old; //ブレンドに使う
    this(){
        search_data_dir();
        blend = load_blend_surface("./byouga.png");
    }
    this(YamlNode yn){
        blend = load_blend_surface("./byouga.png");
        foreach(n; yn){
            this._table[n["name"].s] = load_surface(n["path"].s);
        }
    }
    void search_data_dir(){
        auto dirs = std.file.listdir("data", "*.png");
        foreach (d; dirs){
            _table[d[5..$]] = load_surface(d);
            _table[d[5..$]~"#white"] = load_silhouettesurface(d, Color(255,255,255));
        }
        auto dirs_jpg = std.file.listdir("data", "*.jpg");
        foreach (d; dirs_jpg){
            _table[d[5..$]] = load_surface(d);
            //_table[d[5..$]~"_white"] = load_silhouettesurface(d, Color(255,255,255));
        }
        auto dirs_bmp = std.file.listdir("data", "*.bmp");
        foreach (d; dirs_bmp){
            _table[d[5..$]] = load_surface(d);
            //_table[d[5..$]~"_white"] = load_silhouettesurface(d, Color(255,255,255));
        }
    }
    private Surface add(string path){
        _table[path] = load_surface(path);
        return _table[path];
    }
    private Surface addw(string path){
        _table[path] = load_surface(path);
        _table[path~"#white"] = load_silhouettesurface(path, Color(255,255,255));
        return _table[path];
    }
    private Surface add_chara(string name){
        return this.addw("data/chara/"~name);
    }
    private Surface add_back(string name, bool is_translate = true){
        auto res = this.add("data/back/"~name);
        res.is_translate = is_translate;
        return res;
    }
    private Surface add_object(string name){
        return this.add("data/object/"~name);
    }
    Surface opIndex(string key){
        assert(key in this._table, key);
        return _table[key];
    }
    void remake(){
        foreach(s; this._table){
            s.remake();
        }
    }
}
