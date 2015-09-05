// D import file generated from 'gamelib\music.d'
module gamelib.music;
import gamelib.sound;
import dxlib.all;
import std.string;
import std.stdio;
import std.conv;
import std.file;
import gamelib.utils;
abstract deprecated class Channel
{
    Audio _audio;
}

abstract class Audio
{
    abstract void volume(double val);

    abstract double volume();

    abstract void pan(double val);

    abstract double pan();

    abstract void frequency(int val);

    abstract int frequency();

    abstract void loopTime(int val);

    abstract int loopTime();

    abstract void loopStartTime(int val);

    abstract int loopStartTime();

}

abstract class Music : Audio
{
    abstract override void volume(double val);

    abstract override double volume();

    abstract override void pan(double val);

    abstract override double pan();

    abstract override void frequency(int val);

    abstract override int frequency();

    abstract override void loopTime(int val);

    abstract override int loopTime();

    abstract override void loopStartTime(int val);

    abstract override int loopStartTime();

    abstract void isLoop(bool val);

    abstract bool isLoop();

}

abstract class MusicPlus : Music
{
    private 
{
    double _volume = 1;
    double _pan = 0;
    int _frequency = 44100;
    int _loopPos = 0;
    int _loopStartPos = 0;
    bool _isLoaded = false;
    bool _isLoop = true;
    public 
{
    this()
{
_volume = 1;
_pan = 0;
_frequency = 44100;
_loopPos = 0;
_isLoaded = false;
_isLoop = true;
}
    ~this()
{
}
        final override void volume(double val)
{
this._volume = val;
}

    final override pure double volume()
{
return this._volume;
}

    final override void pan(double val)
{
this._pan = val;
}

    final override pure double pan()
{
return this._pan;
}

    final override void frequency(int val)
{
this._frequency = val;
}

    final override pure int frequency()
{
return _frequency;
}

    final override void loopTime(int val);

    final override pure int loopTime()
{
return this._loopPos;
}

    final override void loopStartTime(int val)
{
this._loopStartPos = val;
}

    final override pure int loopStartTime()
{
return this._loopStartPos;
}

    final pure bool isLoaded()
{
return this._isLoaded;
}

    final void isLoaded(bool val)
{
this._isLoaded = val;
}

    final override pure bool isLoop()
{
return this._isLoop;
}

    final override void isLoop(bool val)
{
this._isLoop = val;
}

}
}
}

class DxlibMusic : MusicPlus
{
    private 
{
    int _dxsound;
    PlayType _play_type;
    public 
{
    this()
{
_play_type = PlayType.loop;
super();
}
    pure int dxsound()
{
return this._dxsound;
}

    abstract void load();

    void free();
}
}
}
class Music1 : DxlibMusic
{
    private string _path;

    this(string path)
{
super();
_path = path;
}
    override void load();

}
class Music2 : DxlibMusic
{
    private string _introPath;

    private string _loopPath;

    this(string introPath, string loopPath)
{
super();
_introPath = introPath;
_loopPath = loopPath;
}
    override void load();

}
Music1 loadMusic(string path, int loopTime, double volume = 1);
Music1 loadMusic2(string path, int loopStartTime, int loopEndTime, double volume = 1);
Music2 loadMusic(string introPath, string loopPath, double volume = 1)
{
Music2 res = new Music2(introPath,loopPath);
res.volume = volume;
return res;
}
