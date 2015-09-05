module gamelib.music;

import gamelib.sound;
import dxlib.all;
import std.string;
import std.stdio;
import system;
import std.conv;


abstract class Music{
    abstract void volume(int val);
    abstract int volume();

    abstract void pan(int val);
    abstract int pan();

    abstract void set_master_volume(int val);

    abstract void frequency(int val);

    abstract void loop_time(int val);

    abstract int loop_time();

    abstract protected int length();

    abstract protected int time();

    abstract protected void time(int val, int master_volume);

    abstract protected int position();

    abstract protected void position(int val);

    abstract bool is_loop();
    abstract void is_loop(bool val);


    /// playしているの？
    abstract protected bool is_playing();

    /// frequencyを取得
    abstract int frequency();

    abstract protected void play(int master_volume);
    abstract protected void free();
    abstract protected void stop();
    abstract string name();
}
abstract class DxlibMusic : Music{
    string _name;
    int _volume;
    int _pan;
    int _frequency  = 44100;
    int _loop_pos   = 0;
    bool _is_loaded = false;
    bool _is_loop   = true;
    int _dxsound;
    PlayType _play_type;
    this(){
        _volume     = 255;
        _pan        = 0;
        _play_type  = PlayType.loop;
        _frequency  = 44100;
        _loop_pos   = 0;
        _is_loaded  = false;
        _is_loop    = true;
        _name       = "";
    }
    ~this(){
        this.free();
    }
    override void set_master_volume(int val)
    in{
        assert(0<= val && val < 256, to!(string)(val));
    }body{
        dx_ChangeVolumeSoundMem(this._volume*val/255, _dxsound);

    }
    private int dxsound(){return this._dxsound;}
    override string name(){return this._name;}
    invariant(){
        assert(0<= _volume && _volume < 256, to!(string)(_volume));
        assert(-10000<= _pan && _pan <= 10000, to!(string)(_pan));
        assert(100<= _frequency && _frequency < 100000, to!(string)(_frequency));
        assert(0<= _loop_pos);
        if(_is_loaded){ assert(_dxsound != 0); }
        else{ assert(_dxsound == 0); }
    }
    override void volume(int val){
        _volume = val;
        if(_is_loaded){
            dx_ChangeVolumeSoundMem(val, _dxsound);
        }
    }
    override int volume(){ return _volume; }

    override void pan(int val){
        _pan = val;
        if(_is_loaded){
            dx_SetPanSoundMem(val, _dxsound);
        }
    }

    override int pan(){ return _pan;}
    override void frequency(int val){
        _frequency = val;
        if(_is_loaded){
            dx_SetFrequencySoundMem(val, _dxsound);
        }
    }

    override void loop_time(int val){
        if(val >= 0){
            _loop_pos = val;
            if(_is_loaded){
                dx_SetLoopPosSoundMem(val, _dxsound);
            }
        }else{
            this.is_loop = false;
            _loop_pos = 0;
        }
    }

    override int loop_time(){
        return this._loop_pos;
    }

    override protected int length()
    in{
        assert(this._is_loaded);
    }body{
        return dx_GetSoundTotalTime(_dxsound);
    }

    override protected int time()
    in{
        assert(this._is_loaded);
    }body{
        return dx_GetSoundCurrentTime(_dxsound);
    }

    override protected void time(int val, int master_volume)
    in{
        assert(val < this.length);
        assert(val >= 0);
        assert(this._is_loaded);
    }body{
        this.stop();
        dx_SetSoundCurrentTime(val, _dxsound);
        this.play(master_volume);
        //dx_PlaySoundMem(_dxsound, DX_PLAYTYPE_LOOP, false);
    }

    override protected int position()
    out(result){
        assert(result >= 0);
    }body{
        assert(this._is_loaded);
        return dx_GetSoundCurrentPosition(this._dxsound);
    }

    override protected void position(int val)
    in{
        //assert(val < this.length);
        assert(this._is_loaded);
    }body{
        this.stop();
        dx_SetSoundCurrentPosition(val, _dxsound);
        dx_PlaySoundMem(_dxsound, DX_PLAYTYPE_LOOP, false);
        //this.play();
    }

    override bool is_loop(){ return this._is_loop;}
    override void is_loop(bool val){this._is_loop = val;}


    /// playしているの？
    override protected bool is_playing()
    in{
        assert(this._is_loaded);
    }body{
        return dx_CheckSoundMem(_dxsound)!=0; 
    }

    /// frequencyを取得
    override int frequency()
    in{
        assert(this._is_loaded);
    }body{
        return _frequency;
    }

    /// マスターボリューム指定して再生
    /// Param:
    ///     master_volume = マスターボリューム
    override protected void play(int master_volume){
        if(!this._is_loaded){
            this.load();
        }
        dx_ChangeVolumeSoundMem(this._volume * master_volume / 255, _dxsound);
        dx_SetFrequencySoundMem(_frequency, _dxsound);
        if(this.is_loop){
            dx_SetLoopPosSoundMem(_loop_pos, _dxsound);
            dx_PlaySoundMem(_dxsound, DX_PLAYTYPE_LOOP, false);
        }else{
            dx_PlaySoundMem(_dxsound, DX_PLAYTYPE_BACK, false);
        }
    }
    protected abstract void load();
    override protected void free(){
        if(_is_loaded){
            dx_DeleteSoundMem(_dxsound);
            _is_loaded = false;
            _dxsound = 0;
        }
    }
    override protected void stop(){
        if(this._is_loaded){
            //if(this.is_playing()){
                dx_StopSoundMem(_dxsound);
            //}
        }
    }
}
class Music1 : DxlibMusic{
    string _path;
    this(string path){
        super();
        _path = path;
        _name = path;
    }
    this(string path, string name){
        super();
        _path = path;
        _name = name;
    }
    override void load(){ 
        if(!this._is_loaded){
            dx_SetCreateSoundDataType(DX_SOUNDDATATYPE_MEMPRESS);
            //dx_SetCreateSoundDataType(DX_SOUNDDATATYPE_MEMNOPRESS);
            _dxsound = dx_LoadSoundMem(toStringz(_path));
            _is_loaded = true;
        }
    }
}
class Music2 : DxlibMusic{
    string _intro_path;
    string _loop_path;
    this(string intro_path, string loop_path){
        super();
        _intro_path = intro_path;
        _loop_path  = loop_path;
        _name       = _loop_path;
    }
    this(string intro_path, string loop_path, string name){
        super();
        _intro_path = intro_path;
        _loop_path  = loop_path;
        _name = name;
    }
    override void load(){ 
        if(!this._is_loaded){
            dx_SetCreateSoundDataType(DX_SOUNDDATATYPE_MEMPRESS);
            _dxsound = dx_LoadSoundMem2(toStringz(_intro_path), toStringz(_loop_path));
            _is_loaded = true;
        }
    }
}


Music1 load_music(string path, int loop_time, string name = ""){
    Music1 res = new Music1(path, name);
    res.loop_time = loop_time;
    return res;
}

/// ループしない部分とループする部分に分けて音楽をロードする
Music2 load_music(string intro_path, string loop_path, string name = ""){
    Music2 res = new Music2(intro_path, loop_path, name);
    return res;
}
class MusicPlayer{
    Music _current_music;
    int _master_volume;
    bool _is_enable;
    int _fade_time = -1;
    int _fade_timelen;
    int _fade_postvolume;
    int _fade_prevolume;
    this(int master_volume, bool is_enable = true){
        this._master_volume = master_volume;
        this._is_enable = is_enable;
    }
    invariant(){
        assert(this._master_volume >= 0);
        assert(this._master_volume < 256);
    }
    void play(Music music = null){
        if(music is null){
            if(!_is_enable){return;}
            if(_current_music !is null){
                _current_music.play(this._master_volume);
            }
        }else{
            if(!_is_enable){
                _current_music = music;
                return;
            }
            if(_current_music is null){
                music.play(this._master_volume);
                _current_music = music;
            }else if(_current_music.is_playing){
                _current_music.stop();
                _current_music.free();
                music.play(this._master_volume);
                _current_music = music;
            }else{
                _current_music.free();
                music.play(this._master_volume);
                _current_music = music;
            }
        }
    }
    /+
    private void _play(Music m){
        dx_ChangeVolumeSoundMem(m.volume * this._master_volume / 255, m.dxsound);
        if(!m.is_loaded){
            m.load();
        }
        dx_SetFrequencySoundMem(m._frequency, m._dxsound);
        if(m.is_loop){
            dx_SetLoopPosSoundMem(m._loop_pos, m._dxsound);
            dx_PlaySoundMem(m._dxsound, DX_PLAYTYPE_LOOP, false);
        }else{
            dx_PlaySoundMem(m._dxsound, DX_PLAYTYPE_BACK, false);
        }
    }
    +/
    void update(){
        if(this._fade_time >= 0){
            double par = cast(double)this._fade_time/this._fade_timelen;
            int newvol = cast(int)(this._fade_prevolume * par + this._fade_postvolume * (1-par));
            this._master_volume = newvol;
            this.current_music.set_master_volume = newvol;
            this._fade_time--;
        }
    }

    /// フェードさせるよ
    void fade(int postvolume, int time){
        this._fade_postvolume = postvolume;
        this._fade_prevolume  = this.current_music.volume;
        this._fade_time       = time;
        this._fade_timelen    = time;
    }
    void fadedown(int time){
        this.fade(0, time);
    }
    void fadeup(int time){
        this.fade(255, time);
    }
    void pause(){
        if(_current_music !is null){
            _current_music.stop();
        }
    }
    Music current_music(){return this._current_music;}
    int time(){ return this._current_music.time; }
    void time(int val){ this._current_music.time(val,this._master_volume); }
    bool is_playing(){return this._current_music.is_playing;}
    int length(){return this._current_music.length;}
    bool is_enable(){return this._is_enable;}

}
