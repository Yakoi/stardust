// D import file generated from 'gamelib\sound.d'
module gamelib.sound;
import dxlib.all;
import std.string;
import mylib.utils;
import std.conv;
enum PlayType 
{
normal = DX_PLAYTYPE_NORMAL,
back = DX_PLAYTYPE_BACK,
loop = DX_PLAYTYPE_LOOP,
}
class Sound
{
    int _dxsound;
    double _volume;
    int _pan;
    int _frequency;
    int _loopPos = 0;
    static bool isEnable = true;

    PlayType _playType;
    this(int dxsound)
{
_dxsound = dxsound;
_volume = 1;
_pan = 0;
_playType = PlayType.back;
_frequency = 44100;
_loopPos = 0;
}
        void volume(double val)
in
{
assert(0 <= val && val <= 1,text(val));
}
body
{
_volume = val;
dx_ChangeVolumeSoundMem(to!(int)(val * 255),_dxsound);
}
    double volume()
{
return _volume;
}
    void pan(int val)
{
_pan = val;
dx_SetPanSoundMem(val,_dxsound);
}
    int pan()
{
return _pan;
}
    void frequency(int val)
{
_frequency = val;
dx_SetFrequencySoundMem(val,_dxsound);
}
    void loopPos(int val)
{
assert(val >= 0);
_loopPos = val;
dx_SetLoopPosSoundMem(val,_dxsound);
}
    int length()
{
return dx_GetSoundTotalTime(_dxsound);
}
    int time()
{
return dx_GetSoundCurrentTime(_dxsound);
}
    void time(int val)
{
dx_SetSoundCurrentTime(val,_dxsound);
}
    bool isPlaying()
{
return dx_CheckSoundMem(_dxsound) != 0;
}
    int frequency()
{
return _frequency;
}
    void play();
    void stop()
{
dx_StopSoundMem(_dxsound);
}
}
Sound loadSound(string path);
Sound loadSound(string path1, string path2);
