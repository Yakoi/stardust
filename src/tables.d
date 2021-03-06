module tables;
import std.path;
import all;

class MusicData{
//private:
    DxlibMusic music;
    string title;
    string author;
    int bps;
public:
    this(DxlibMusic music, string title, string author, int bps){
        this.music = music;
        this.title = title;
        this.author = author;
        this.bps = bps;
    }
    @property const pure string info(){
        return this.author ~ " - " ~ this.title;
    }
}

version(none)
Sound[string] createSoundTable(){
    Sound[string] res;
    res["reflect_wall"]   = loadSound("./data/sound/chin.ogg");
    res["reflect_bar"]    = loadSound("./data/sound/chin.ogg");
    res["appear_ball"]    = loadSound("./data/sound/appear.ogg");
    res["appear_effect"]  = loadSound("./data/sound/chin.ogg");
    res["finish_reflect"] = loadSound("./data/sound/chin.ogg");
    res["gosky"]          = loadSound("./data/sound/chin.ogg");
    res["finish_effect"]  = loadSound("./data/sound/chin.ogg");
    res["gameover"]       = loadSound("./data/sound/chukin.ogg");
    return res;
}
Sound[string] createSoundDict(mylib.csv.Table table, string dirPath){
    Sound[string] res;
    foreach(uint i, TableRow row; table){
        immutable string name = row["name"];
        immutable string path = row["path"];
        immutable double volume = to!double(row["volume"]);
        immutable int frequency = to!int(row["frequency"]);
        res[name] = loadSound(std.path.buildPath(dirPath,path));
        assert(0.0 <= volume && volume <= 1.0);
        res[name].volume = volume;
        res[name].frequency = frequency;
    }
    return res;

}

version(none)
DxlibMusic[string] createMusicTable(){
    DxlibMusic[string] res;
    //res["music_a"] = loadMusic("./data/music/naks.ogg", 10480);
    res["music_b"] = loadMusic2("./data/music/gfdg.ogg", 91380, 24920);
    res["music_a"] = loadMusic2("./data/music/naks.ogg", 115340, 10480);
    return res;
}
MusicData[string] createMusicTable(YamlNode yn){
    MusicData[string] res;
    //res["music_a"] = loadMusic("./data/music/naks.ogg", 10480);
    assert(yn.type == NodeType.SEQUENCE);
    foreach(uint i, YamlNode node; yn){
        assert(node.type == NodeType.MAPPING);
        DxlibMusic m = loadMusic2(node["path"].s, node["loop_end"].i, node["loop_begin"].i);
        res[node["name"].str] = new MusicData(m, node["title"].s, node["author"].s, node["bps"].i);
    }
    return res;
}
MusicData[string] createMusicTable(mylib.csv.Table table, string dirPath){
    MusicData[string] res;
    foreach(uint i, TableRow row; table){
        DxlibMusic m = loadMusic2(std.path.buildPath(dirPath,row["path"]), to!(int)(row["loopEnd"]), to!(int)(row["loopBegin"]));
        res[row["name"]] = new MusicData(m, row["title"], row["author"], to!(int)(row["bps"]));
    }
    return res;
}
version(none)
Font[string] createFontTable(int size = 14, int thickness = 1, FontType type = FontType.ANTIALIASING){
    Font[string] res;
    //res["mplus"]    = loadFont2("./mplus-1m-regular.ttf", "M+ 1m"          , 17  , thickness, FontType.antialiasing);
    //res["mika"]     = loadFont2("./mika.ttf"            , "みかちゃん"     , size, thickness, FontType.antialiasing);
    //res["bdfmp13"]  = loadFont2("./bdfmplus.ttf"        , "BDF M+"         , 13  , 1        , FontType.normal);
    //res["bdfmp11"]  = loadFont2("./bdfmplus.ttf"        , "BDF M+"         , 11  , 1        , FontType.normal);
    //res["bdfump13"] = loadFont2("./bdfUMplus.ttf"       , "BDF UM+"        , 13  , 1        , FontType.normal);
    static assert(false);
    res["shnm12"]   = loadFont2("./data/font/bdfShnmGothic.ttf"   , "BDF東雲ゴシック", 12  , 1        , FontType.NORMAL);
    res["shnm14"]   = loadFont2("./data/font/bdfShnmGothic.ttf"   , "BDF東雲ゴシック", 14  , 1        , FontType.NORMAL);
    res["shnm16"]   = loadFont2("./data/font/bdfShnmGothic.ttf"   , "BDF東雲ゴシック", 16  , 1        , FontType.NORMAL);
    return res;
}
Font[string] createFontDict(Table table, string path, FontType fontType = FontType.ANTIALIASING){
    Font[string] res;
    foreach(TableRow row; table){
        res[row["name"]]   = loadFont2(std.path.buildPath(path, row["path"])   , row["fontName"], to!(int)(row["size"])  , to!(int)(row["thickness"]), fontType);
    }
    return res;

}
