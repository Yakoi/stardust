module gamelib.music;

import gamelib.sound;
import dxlib.all;
import std.string;
import std.stdio;
import std.conv;
import std.file;
import gamelib.utils;

/// チャンネル オーディオデータとプレイヤーのセットで単体で再生できたりできなかったり
deprecated abstract class Channel{
    Audio _audio;
}
/// MusicとSoundのベースインターフェース
abstract class Audio{
    /// 音量を増やしたり減らしたり
    abstract void volume(double val);
    /// 音量取得
    abstract double volume();
    
    /// パンをフリフリ
    abstract void pan(double val);
    /// パンを取得
    abstract double pan();

    /// 周波数をうねうね
    abstract void frequency(int val);
    /// 周波数を取得
    abstract int frequency();

    /// ループ先の時間を指定
    abstract void loopTime(int val);
    /// ループ先の時間を取得
    abstract int loopTime();
    /// ループ先の時間を指定
    abstract void loopStartTime(int val);
    /// ループ先の時間を取得
    abstract int loopStartTime();

}
/// 音楽を扱うクラス
abstract class Music : Audio{
    /// 音量を増やしたり減らしたり
    override abstract void volume(double val);
    /// 音量取得
    override abstract double volume();

    /// パンをフリフリ
    override abstract void pan(double val);
    /// パンを取得
    override abstract double pan();

    /// 周波数をうねうね
    override abstract void frequency(int val);
    /// 周波数を取得
    override abstract int frequency();

    /// ループ先の時間を指定
    override abstract void loopTime(int val);
    /// ループ先の時間を取得
    override abstract int loopTime();
    /// ループ先の時間を指定
    override abstract void loopStartTime(int val);
    /// ループ先の時間を取得
    override abstract int loopStartTime();

    /// ループ先の時間を指定
    abstract void isLoop(bool val);
    /// ループ先の時間を取得
    abstract bool isLoop();

}
/// 音楽を扱うクラス+ちょっと具体的にした
abstract class MusicPlus : Music{
private:
    double _volume = 1.0;
    double _pan    = 0.0;
    int _frequency  = 44100;
    int _loopPos   = 0;
    int _loopStartPos = 0;
    bool _isLoaded = false;
    bool _isLoop   = true;
public:
    this(){
        _volume     = 1.0;
        _pan        = 0;
        _frequency  = 44100;
        _loopPos   = 0;
        _isLoaded  = false;
        _isLoop    = true;
    }
    ~this(){ }
    invariant(){
        assert(0<= _volume && _volume <= 1.0, to!(string)(_volume));
        assert(-1.0<= _pan && _pan <= 1.0, to!(string)(_pan));
        assert(100<= _frequency && _frequency < 100000, to!(string)(_frequency));
        assert(0<= _loopPos);
    }
    /// volume セット
    final override void volume(double val){ this._volume = val; }
    /// volume ゲット
    final pure override double volume(){ return this._volume; }

    /// pan セット
    final override void pan(double val){ this._pan = val; }
    /// pan ゲット
    final pure override double pan(){ return this._pan; }

    /// frequency セット
    final override void frequency(int val){ this._frequency = val; }
    /// frequency ゲット
    final pure override int frequency() { return _frequency; }

    /// loopTime セット
    final override void loopTime(int val){
        if(val >= 0){
            _loopPos = val;
        }else{
            this.isLoop = false;
            _loopPos = 0;
        }
    }
    /// loopTime ゲット
    final pure override int loopTime(){
        return this._loopPos;
    }
    /// loopTime セット
    final override void loopStartTime(int val){
        this._loopStartPos = val;
    }
    /// loopTime ゲット
    final pure override int loopStartTime(){
        return this._loopStartPos;
    }

    /// isLoaded ゲット
    final pure bool isLoaded(){ return this._isLoaded;}
    /// isLoaded セット
    final void isLoaded(bool val){this._isLoaded = val;}

    /// isLoop ゲット
    final pure override bool isLoop(){ return this._isLoop;}
    /// isLoop セット
    final override void isLoop(bool val){this._isLoop = val;}




}
/// Dxlibで音楽を鳴らせる
class DxlibMusic : MusicPlus{
private:
    int _dxsound; /// dxlibのID
    PlayType _play_type; ///これ使わない？
public:
    /// コンストラクタ。気にしなくてOK
    this(){
        _play_type  = PlayType.loop;
        super();
    }
    /// dxlibのID
    pure int dxsound(){return this._dxsound;}
    /// ファイルのロード
    abstract void load();
    /// ファイルの開放
    void free(){
        if(this.isLoaded){
            dx_DeleteSoundMem(this.dxsound);
            _isLoaded = false;
            _dxsound = 0;
        }
    }
}
/// ひとつのDxLib Musicファイルを再生するためのクラス ループ位置指定可能
class Music1 : DxlibMusic{
    private string _path; ///ファイルのパス
    /// コンストラクタ。
    /// Params:
    ///     path = ファイルのパス。ogg or wav
    this(string path){
        super();
        _path = path;
    }
    /// コンストラクタで与えたパスのファイルをロードする
    override void load(){ 
        if(!this._isLoaded){
            dx_SetCreateSoundDataType(DX_SOUNDDATATYPE_MEMPRESS);
            //dx_SetCreateSoundDataType(DX_SOUNDDATATYPE_MEMNOPRESS);
            _dxsound = dx_LoadSoundMem(toWStringz(_path));
            if(_dxsound == -1){throw new Exception("Music Load Error : " ~ _path);}
            _isLoaded = true;
        }
    }
}
/// ふたつのDxLib Musicファイルを再生するためのクラス 二つ目のファイルをループ再生
class Music2 : DxlibMusic{
    private string _introPath;
    private string _loopPath;
    /// コンストラクタ。
    /// Params:
    ///     introPath = ループしない部分の音楽ファイル
    ///     loopPath = ループする部分の音楽ファイル
    this(string introPath, string loopPath){
        super();
        _introPath = introPath;
        _loopPath  = loopPath;
    }
    /// コンストラクタで与えたパスのファイルをロードする
    override void load(){ 
        if(!this._isLoaded){
            dx_SetCreateSoundDataType(DX_SOUNDDATATYPE_MEMPRESS);
            _dxsound = dx_LoadSoundMem2(toWStringz(_introPath), toWStringz(_loopPath));
            if(_dxsound == -1){throw new Exception("Music Load Error : " ~ _introPath ~ ", " ~ _loopPath);}
            _isLoaded = true;
        }
    }
}

/// ファイルから音楽ロード ループ場所も決められる
Music1 loadMusic(string path, int loopTime, double volume = 1.0){
    if(!checkDxFile(path, "dxa")){throw new Exception("music.loadMusic Load Error : " ~ path);}
    //if(!isfile(path)){throw new Exception("music.loadMusic Load Error : " ~ path);}
    Music1 res = new Music1(path);
    res.loopTime = loopTime;
    res.volume = volume;
    return res;
}
/// ファイルから音楽ロード ループ場所も決められる
Music1 loadMusic2(string path, int loopStartTime, int loopEndTime, double volume = 1.0){
    if(!checkDxFile(path, "dxa")){throw new Exception("music.loadMusic Load Error : " ~ path);}
    //if(!isfile(path)){throw new Exception("music.loadMusic Load Error : " ~ path);}
    Music1 res = new Music1(path);
    res.loopTime = loopEndTime;
    res.loopStartTime = loopStartTime;
    res.volume = volume;
    return res;
}

/// ループしない部分とループする部分に分けて音楽をロードする
Music2 loadMusic(string introPath, string loopPath, double volume = 1.0){
    //if(!exists(introPath)){throw new Exception("music.loadMusic Load Error : " ~ introPath);}
    //if(!isfile(introPath)){throw new Exception("music.loadMusic Load Error : " ~ introPath);}
    //if(!exists(loopPath)){throw new Exception("music.loadMusic Load Error : " ~ loopPath);}
    //if(!isfile(loopPath)){throw new Exception("music.loadMusic Load Error : " ~ loopPath);}
    Music2 res = new Music2(introPath, loopPath);
    res.volume = volume;
    return res;
}
