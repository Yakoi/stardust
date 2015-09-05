// D import file generated from 'gamelib\loader.d'
module gamelib.loader;
import gamelib.all;
import mylib.yaml;
abstract class Loader
{
    bool _dxarchive_enable;
    string _ext;
    string _pass;
    this(bool dxarchive_enable, string ext, string pass)
{
this._dxarchive_enable = dxarchive_enable;
this._ext = ext;
this._pass = pass;
}
    this(string ext = null, string pass = "dxa");
    Surface load_surface(string path);
    Yaml load_yaml(string path);
    FmfMapLayer load_fmfmaplayer(string path, Surface sur, int layer);
    FmfMapLayer[] load_fmfmaplayers(string path, Surface sur);
    Font load_font(string fontname);
}

