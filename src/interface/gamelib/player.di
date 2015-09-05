// D import file generated from 'gamelib\player.d'
module gamelib.player;
import dxlib.all;
import std.stdio;
import std.conv;
import gamelib.all;
class AudioPlayer
{
    abstract void update();

    abstract double masterVolume();

    abstract void masterVolume(double val);

    abstract void stop(int fadeTime = 0);

    abstract void pause(int fadeTime);

    abstract bool isEnable();

    abstract void play();

}
struct FadeData
{
    double preVolume = 0;
    double postVolume = 0;
    double finalVolume = 0;
    int time = 0;
    }
class MusicPlayer : AudioPlayer
{
    protected 
{
    double _masterVolume;
    double _fadeVolume = 1;
    bool _isEnable;
    int _fadeCoung = -1;
    PlayerState _playerState = PlayerState.STOPPED;
    FadeData _fadeData;
    bool _mute = false;
    package 
{
    this(double masterVolume, bool isEnable = true)
in
{
assert(0 <= masterVolume && masterVolume <= 1,to!(string)(masterVolume));
}
body
{
this._masterVolume = masterVolume;
this._isEnable = isEnable;
}
        protected 
{
    abstract void _play();

    abstract void _pause();

    abstract void _stop();

    abstract void _fade();

    abstract void _fadeout();

    public 
{
    const pure bool mute()
{
return this._mute;
}

    void mute(bool val)
{
this._mute = val;
this.masterVolume = this.masterVolume;
}
    const override pure double masterVolume()
{
return this._masterVolume;
}

    abstract override void masterVolume(double val);

    double volume()
{
return this.masterVolume * this._fadeVolume;
}
    protected abstract void setVolume();


    override void update();

    override void play()
{
this._play();
}

    override void pause(int time = 0);

    override void stop(int time = 0)
{
this._stop();
}

    void fade(double volume, int time)
{
this.setFadedata(volume,time);
this._fade();
}
    void fadeout(int time)
{
this.setFadedataFadeout(0,time);
this._fadeout();
}
    void fadein(int time)
{
this.fade(1,time);
}
    private void setFadedata(double postVolume, int time);

    private void setFadedataFadeout(double postVolume, int time);

    final override pure bool isEnable()
{
return this._isEnable;
}

    final void isEnable(bool val);

}
}
}
}
}
enum PlayerState 
{
PLAYING,
FADING,
FADING_OUT,
PAUSING,
STOPPED,
}
string toString(PlayerState ps)
{
return ";";
}
class DxlibMusicPlayer : MusicPlayer
{
    protected 
{
    DxlibMusic _music;
    public 
{
    this(double masterVolume, bool isEnable = true)
in
{
assert(0 <= masterVolume && masterVolume <= 1,to!(string)(masterVolume));
}
body
{
super(masterVolume,isEnable);
}
    override void play()
{
super.play();
}

    void play(DxlibMusic m)
{
set(m);
this.play();
}
    void set(DxlibMusic music);
    int time()
in
{
assert(this._music !is null);
assert(this._music.isLoaded);
}
body
{
return dx_GetSoundCurrentTime(_music.dxsound);
}
    void time(int val);
    bool isPlaying();
    int length()
in
{
assert(this._music !is null);
assert(_music.isLoaded);
}
body
{
return dx_GetSoundTotalTime(_music.dxsound);
}
    void reset()
{
this.time = 0;
}
    const override pure double masterVolume()
{
return super.masterVolume;
}

    override void masterVolume(double val)
in
{
assert(0 <= val && val <= 1,to!(string)(val));
}
body
{
this._masterVolume = val;
this.setVolume();
}

    protected override void setVolume();


    @property public DxlibMusic music()
{
return this._music;
}


    private bool _load();

    private void __play();

    override void _play();

    override void _fade();

    override void _fadeout();

    override void _pause();

    override void _stop();

    void __pause();
}
}
}
