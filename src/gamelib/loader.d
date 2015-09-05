module gamelib.loader;
import gamelib.all;
import mylib.yaml;

/// DxArchiveを考慮したLoader
/// Surfaceの管理もするか(reloadなど)
abstract class Loader{
    bool _dxarchive_enable;
    string _ext;
    string _pass;
    this(bool dxarchive_enable, string ext, string pass){
        this._dxarchive_enable = dxarchive_enable;
        this._ext = ext;
        this._pass = pass;
    }
    this(string ext = null, string pass = "dxa"){
        if(ext is null || pass is null){
            this(false, ext, pass);
        }else{
            this(true, ext, pass);
        }
    }
    Surface load_surface(string path);
    Yaml load_yaml(string path);
    FmfMapLayer load_fmfmaplayer(string path, Surface sur, int layer);
    FmfMapLayer[] load_fmfmaplayers(string path, Surface sur);
    Font load_font(string fontname);
}
