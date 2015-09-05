module gamelib.sound;

//import gamelib.player;
import dxlib.all;
import std.string;
import mylib.utils;
import std.conv;
enum PlayType{
    normal = DX_PLAYTYPE_NORMAL,//　:　ノーマル再生
    back   = DX_PLAYTYPE_BACK,//　　:　バックグラウンド再生
    loop   = DX_PLAYTYPE_LOOP,//　　:　ループ再生
}

class Sound{
    int _dxsound;
    double _volume;
    int _pan;
    int _frequency;
    int _loopPos = 0;
    static bool isEnable = true;
    PlayType _playType;
    this(int dxsound){
        _dxsound = dxsound;
        _volume     = 1.0;
        _pan     = 0;
        _playType = PlayType.back;
        _frequency = 44100;
        _loopPos = 0;
    }
    invariant(){
        assert(0.0<= _volume && _volume <= 1.0);
        assert(-10000<= _pan && _pan <= 10000);
        assert(100<= _frequency && _frequency < 100000);
        assert(0<= _loopPos);
    }
    void volume(double val)
    in{
        assert(0.0<= val && val <= 1.0, text(val));
    }body{
        _volume = val;
        dx_ChangeVolumeSoundMem(to!int(val*255), _dxsound);
    }
    double volume(){ return _volume; }
    void pan(int val){
        _pan = val;
        dx_SetPanSoundMem(val, _dxsound);
    }
    int pan(){ return _pan;}
    void frequency(int val){
        _frequency = val;
        dx_SetFrequencySoundMem(val, _dxsound);
    }
    void loopPos(int val){
        assert(val>=0);
        _loopPos = val;
        dx_SetLoopPosSoundMem(val, _dxsound);
    }
    int length()      { return dx_GetSoundTotalTime(_dxsound); }
    int time()        { return dx_GetSoundCurrentTime(_dxsound); }
    void time(int val){ dx_SetSoundCurrentTime(val, _dxsound); }
    bool isPlaying() { return dx_CheckSoundMem(_dxsound)!=0; }
    int frequency()   { return _frequency;}
    void play()       {
        if(this.isEnable){
            //dx_SetLoopPosSoundMem(_loopPos, _dxsound);
            //dx_SetSoundCurrentPosition(40000, _dxsound);
            dx_PlaySoundMem(_dxsound, _playType);
        }
    }
    void stop()       { dx_StopSoundMem(_dxsound); }
}

Sound loadSound(string path){
    dx_SetCreateSoundDataType(0);
    int dxsound = dx_LoadSoundMem(toWStringz(path));
    if(dxsound == -1){throw new Exception("Sound Load Error : " ~ path);}
    Sound res = new Sound(dxsound);
    return res;
}
Sound loadSound(string path1, string path2){
    dx_SetCreateSoundDataType(DX_SOUNDDATATYPE_MEMNOPRESS);
    int dxsound = dx_LoadSoundMem2(toWStringz(path1), toWStringz(path2));
    if(dxsound == -1){throw new Exception("Sound Load Error");}
    Sound res = new Sound(dxsound);
    return res;
}
