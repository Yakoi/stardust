// D import file generated from 'tables.d'
module tables;
import std.path;
import all;
class MusicData
{
    DxlibMusic music;
    string title;
    string author;
    int bps;
    public 
{
    this(DxlibMusic music, string title, string author, int bps)
{
this.music = music;
this.title = title;
this.author = author;
this.bps = bps;
}
    const pure @property string info()
{
return this.author ~ " - " ~ this.title;
}

}
}
version (none)
{
    Sound[string] createSoundTable()
{
Sound[string] res;
res["reflect_wall"] = loadSound("./data/sound/chin.ogg");
res["reflect_bar"] = loadSound("./data/sound/chin.ogg");
res["appear_ball"] = loadSound("./data/sound/appear.ogg");
res["appear_effect"] = loadSound("./data/sound/chin.ogg");
res["finish_reflect"] = loadSound("./data/sound/chin.ogg");
res["gosky"] = loadSound("./data/sound/chin.ogg");
res["finish_effect"] = loadSound("./data/sound/chin.ogg");
res["gameover"] = loadSound("./data/sound/chukin.ogg");
return res;
}
}
Sound[string] createSoundDict(mylib.csv.Table table, string dirPath);
version (none)
{
    DxlibMusic[string] createMusicTable()
{
DxlibMusic[string] res;
res["music_b"] = loadMusic2("./data/music/gfdg.ogg",91380,24920);
res["music_a"] = loadMusic2("./data/music/naks.ogg",115340,10480);
return res;
}
}
MusicData[string] createMusicTable(YamlNode yn);
MusicData[string] createMusicTable(mylib.csv.Table table, string dirPath);
version (none)
{
    Font[string] createFontTable(int size = 14, int thickness = 1, FontType type = FontType.ANTIALIASING)
{
Font[string] res;
res["shnm12"] = loadFont2("./data/font/bdfShnmGothic.ttf","BDF\xe6\x9d\xb1\xe9\x9b\xb2\xe3\x82\xb4\xe3\x82\xb7\xe3\x83\x83\xe3\x82\xaf",12,1,FontType.NORMAL);
res["shnm14"] = loadFont2("./data/font/bdfShnmGothic.ttf","BDF\xe6\x9d\xb1\xe9\x9b\xb2\xe3\x82\xb4\xe3\x82\xb7\xe3\x83\x83\xe3\x82\xaf",14,1,FontType.NORMAL);
res["shnm16"] = loadFont2("./data/font/bdfShnmGothic.ttf","BDF\xe6\x9d\xb1\xe9\x9b\xb2\xe3\x82\xb4\xe3\x82\xb7\xe3\x83\x83\xe3\x82\xaf",16,1,FontType.NORMAL);
return res;
}
}
Font[string] createFontDict(Table table, string path, FontType fontType = FontType.ANTIALIASING);
