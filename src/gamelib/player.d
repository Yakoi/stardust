module gamelib.player;


import dxlib.all;
import std.stdio;
import std.conv;
import gamelib.all;

/// オーディオを扱うプレイヤーのベースクラス
class AudioPlayer{
    //abstract void play(Audio audio);
    abstract void update();
    abstract double masterVolume();
    abstract void masterVolume(double val);
    abstract void stop(int fadeTime = 0);
    abstract void pause(int fadeTime);
    abstract bool isEnable();
    abstract void play();
}
/// フェードのための構造体
struct FadeData{
    double preVolume = 0.0; /// フェード前の音量
    double postVolume = 0.0; /// フェード後の音量
    double finalVolume = 0.0; /// 最終的な音量
    int time = 0;              /// フェードにかける時間
    //bool reset_after_fade = false; /// フェード終了後にフェード前の音量に戻すかどうか
    //T next_music = null;
    invariant(){
        assert(0.0 <= preVolume   && preVolume   <= 1.0, text(preVolume));
        assert(0.0 <= postVolume  && postVolume  <= 1.0, text(postVolume));
        assert(0.0 <= finalVolume && finalVolume <= 1.0, text(finalVolume));
    }

}
/// 音楽プレイヤーのためのインターフェース
class MusicPlayer : AudioPlayer{
protected:
    double _masterVolume;
    double _fadeVolume = 1.0;
    bool _isEnable;
    int _fadeCoung = -1;
    PlayerState _playerState = PlayerState.STOPPED;
    FadeData _fadeData;
    bool _mute = false;
package:
    /// コンストラクタ
    /// Params:
    ///     masterVolume = マスターボリューム
    ///     isEnable = falseだと音楽を再生しない
    this(double masterVolume, bool isEnable = true)
    in{
        assert(0.0 <= masterVolume && masterVolume <= 1.0, to!(string)(masterVolume));
    }body{
        this._masterVolume = masterVolume;
        this._isEnable = isEnable;
    }
    invariant(){
        assert(this._masterVolume >= 0.0, to!(string)(this._masterVolume));
        assert(this._masterVolume <= 1.0, to!(string)(this._masterVolume));
        assert(this._fadeVolume >= 0.0, to!(string)(this._fadeVolume));
        assert(this._fadeVolume <= 1.0, to!(string)(this._fadeVolume));
    }
protected:
    abstract void _play();
    abstract void _pause();
    abstract void _stop();
    abstract void _fade();
    abstract void _fadeout();
public:
    pure const bool mute(){
        return this._mute;
    }
    void mute(bool val){
        this._mute = val;
        this.masterVolume = this.masterVolume;
    }
    /// マスターボリュームを得る
    const pure override double masterVolume(){return this._masterVolume;}
    /// マスターボリュームを設定する
    override abstract void masterVolume(double val);
    ///
    double volume(){return this.masterVolume * this._fadeVolume;}


    protected abstract void setVolume();
    /// ループやフェードをする
    override void update()
    out{
        assert(0.0 <= this._fadeVolume && this._fadeVolume <= 1.0);
    }body{
        with(PlayerState)final switch(this._playerState){
            case PAUSING, PLAYING, STOPPED:
                break;
            case FADING:
                double par = cast(double)this._fadeCoung/this._fadeData.time;
                double newvol = (this._fadeData.preVolume * (1-par) + this._fadeData.postVolume * (par));
                newvol = between(0.0,newvol,1.0);
                assert(0.0 <= newvol && newvol <= 1.0, to!(string)(newvol));
                this._fadeVolume = newvol;
                this._fadeCoung++;
                if(this._fadeCoung >= this._fadeData.time){ //後処理
                    this._fadeVolume = this._fadeData.finalVolume;
                    this._playerState = PLAYING;
                }
                this.setVolume();
                break;
            case FADING_OUT:
                assert(this._fadeData.postVolume == 0);
                double par = cast(double)this._fadeCoung/this._fadeData.time;
                double newvol = (this._fadeData.preVolume * (1-par) + this._fadeData.postVolume * (par));
                newvol = between(0.0,newvol,1.0);
                assert(0.0 <= newvol && newvol <= 1.0, to!(string)(newvol));
                this._fadeVolume = newvol;
                this._fadeCoung++;
                if(this._fadeCoung >= this._fadeData.time){ //後処理
                    this._pause();
                    this._fadeVolume = this._fadeData.finalVolume;
                }
                this.setVolume();
                break;
        }
        /+
        if( this._is_fading ){  //ここからフェード処理
            double par = cast(double)this._fadeCoung/this._fadeData.time;
            double newvol = (this._fadeData.preVolume * (1-par) + this._fadeData.postVolume * (par));
            newvol = between(0.0,newvol,1.0);
            assert(0.0 <= newvol && newvol <= 1.0, to!(string)(newvol));
            this.fadeVolume = newvol;
            this._fadeCoung++;
            if(this._fadeCoung >= this._fadeData.time){ //後処理
                stop_fade();
            }
        }
        +/
    }

    ////////////////////////////////////////////////////////////


    /// 音楽を再生する
    override void play(){
        this._play();
    }
    override void pause(int time=0){
        debug writeln("pause");
        if(time <= 0){
            this._pause();
        }else{
            this.fadeout(time);
        }
    }
    override void stop(int time=0){
        this._stop();
    }
    void fade(double volume, int time){
        this.setFadedata(volume, time);
        this._fade();
    }
    void fadeout(int time){
        this.setFadedataFadeout(0, time);
        this._fadeout();
    }
    /// フェードインさせる
    /// fadeVolume のpostVolume が1.0固定
    /// Params:
    ///     time = フェードさせる間隔
    void fadein(int time){
        this.fade(1.0, time);
    }

    /// フェードさせるよ
    /// Params:
    ///     postVolume = フェード後の音量
    ///     time = フェードさせる間隔
    private void setFadedata(double postVolume, int time)
    in{
        assert(0.0 <= postVolume && postVolume <= 1.0);
        assert(0 < time);
    }body{
        this._fadeData.postVolume  = postVolume;
        this._fadeData.time         = time;
        this._fadeCoung             = 0;
        this._fadeData.finalVolume = postVolume;
        with(PlayerState)final switch(this._playerState){
        case FADING, FADING_OUT, PLAYING:
            this._fadeData.preVolume = this._fadeVolume;
            break;
        case PAUSING, STOPPED:
            this._fadeVolume = 0;
            this._fadeData.preVolume = 0;
            break;
        }
        this.setVolume();
    }
    /// フェードさせるよ
    /// Params:
    ///     postVolume = フェード後の音量
    ///     time = フェードさせる間隔
    private void setFadedataFadeout(double postVolume, int time)
    in{
        assert(0.0 <= postVolume && postVolume <= 1.0);
        assert(0 < time);
    }body{
        this._fadeData.postVolume  = postVolume;
        this._fadeData.time         = time;
        this._fadeCoung             = 0;
        this._fadeData.preVolume = this._fadeVolume;
        with(PlayerState)final switch(this._playerState){
        case FADING, FADING_OUT:
            this._fadeData.finalVolume = this._fadeData.finalVolume;
            break;
        case PAUSING, STOPPED, PLAYING:
            this._fadeData.finalVolume = this._fadeVolume;
            break;
        }
        this.setVolume();
    }
    /// 音楽再生が有効かどうか得る
    final pure override bool isEnable(){ return this._isEnable;}
    /// 音楽再生が有効かどうかセット
    final void isEnable(bool val){
        if(!val){this.stop();}
        this._isEnable = val;
    }
}
enum PlayerState{
    PLAYING,
    FADING,
    FADING_OUT,
    PAUSING,
    STOPPED,
}
string toString(PlayerState ps){
    return ";";
}
/// Dxlibを使った音楽プレイヤー
class DxlibMusicPlayer : MusicPlayer{
protected:
    DxlibMusic _music;
public:
    this(double masterVolume, bool isEnable = true)
    in{
        assert(0.0 <= masterVolume && masterVolume <= 1.0, to!(string)(masterVolume));
    }body{
        super(masterVolume, isEnable);
    }
    override void play(){super.play();}
    void play(DxlibMusic m){
        set(m);
        this.play();
    }
    void set(DxlibMusic music){
        if( this._music !is null ){
            if( music == this._music){return;}
            this.pause();
            this._music.free();
        }
        this._music = music;
    }
    /// 現在の再生位置を得る
    int time()
    in{
        assert(this._music !is null);
        assert(this._music.isLoaded);
    }body{
        return dx_GetSoundCurrentTime(_music.dxsound); 
    }
    /// 再生位置を指定する
    void time(int val)
    in{
        assert(this._music !is null);
        assert(val < this.length);
        assert(val >= 0);
        assert(_music.isLoaded);
    }body{
        if(this.isPlaying){
            this.pause();
            dx_SetSoundCurrentTime(val, _music.dxsound);
            this.play();
        } else {
            dx_SetSoundCurrentTime(val, _music.dxsound);
        }

        //dx_PlaySoundMem(_dxsound, DX_PLAYTYPE_LOOP, false);
    }
    /// 現在再生中かどうか得る
    bool isPlaying()
    in{
        //assert(this._music !is null);
    }body{
        if(this._music is null){return false;}
        else{
            //assert(this._music.isLoaded);
            return dx_CheckSoundMem(this._music.dxsound)!=0; 
        }
    }
    /// 曲全体の時間を得る
    int length()
    in{
        assert(this._music !is null);
        assert(_music.isLoaded);
    }body{
        return dx_GetSoundTotalTime(_music.dxsound);
    }
    /// 再生位置を最初からにする
    void reset(){
        this.time = 0;
    }
    ///
    const pure override double masterVolume(){
        return super.masterVolume;
    }
    ///
    override void masterVolume(double val)
    in{
        assert(0.0 <= val && val <= 1.0, to!(string)(val));
    }body{
        this._masterVolume = val;
        this.setVolume();
    }
    protected override void setVolume(){
        if(_music !is null){
            if(_music.isLoaded){
                if(this.isPlaying){
                    if(!this.mute){
                        static if(true){
                            double volume = _music.volume*_music.volume
                                    * this.volume*this.volume;
                            int volume255;
                            if(volume == 0){
                                volume255 = 0;
                            }else{
                                volume255 = max(1, cast(int)(volume*255));
                            }
                            dx_ChangeVolumeSoundMem( volume255, _music.dxsound);
                        }else{
                            dx_ChangeVolumeSoundMem(
                                cast(int)(_music.volume * this.volume * 255),
                                _music.dxsound);
                        }
                    }else{
                        dx_ChangeVolumeSoundMem(
                                0,
                                _music.dxsound);
                    }
                }
            }
        }
    }
    @property public DxlibMusic music(){
        return this._music;
    }
    private bool _load(){
        if(!_isEnable){return false;}
        if(this._music is null){return false;}
        if(!_music.isLoaded){ _music.load();}
        return true;
    }
    private void __play()
    in{
    }body{
        if(!this._isEnable){return;}
        if(_music !is null){
            if(!this.mute){
                static if(true){
                    dx_ChangeVolumeSoundMem(
                        cast(int)(this._music.volume*this._music.volume * this.volume*this.volume * 255),
                        _music.dxsound);
                }else{
                    dx_ChangeVolumeSoundMem(
                        cast(int)(_music.volume * this.volume * 255),
                        _music.dxsound);
                }
            }else{
                dx_ChangeVolumeSoundMem( 0, _music.dxsound);
            }

            dx_SetFrequencySoundMem(_music.frequency, _music.dxsound);
            if(_music.isLoop){
                dx_SetLoopPosSoundMem(_music.loopTime, _music.dxsound);
                if(_music.loopStartTime > 0){
                    dx_SetLoopStartTimePosSoundMem(_music.loopStartTime, _music.dxsound);
                }
                dx_PlaySoundMem(_music.dxsound, DX_PLAYTYPE_LOOP, false);
            }else{
                dx_PlaySoundMem(_music.dxsound, DX_PLAYTYPE_BACK, false);
            }
        }
    }
    override void _play(){
        with(PlayerState)final switch(this._playerState){
        case PLAYING: // 再生
            this._load();
            this.__play();
            this._playerState = PLAYING;
            break;
        case FADING: // 再生
            this._load();
            this.__play();
            this._playerState = PLAYING;
            break;
        case FADING_OUT: // 再生
            this._load();
            this.__play();
            this._playerState = PLAYING;
            break;
        case PAUSING: // 再生
            this._load();
            this.__play();
            this._playerState = PLAYING;
            break;
        case STOPPED: // 再生
            if(this._load()){
                this.__play();
                this._playerState = PLAYING;
            }
            break;
        }
    }
    override void _fade(){
        with(PlayerState)final switch(this._playerState){
        case PLAYING: // フェードさせる
            this._playerState = FADING;
            break;
        case FADING: // 今の音量からフェードさせる
            this._playerState = FADING;
            break;
        case FADING_OUT: // 今の音量からフェードさせる
            this._playerState = FADING;
            break;
        case PAUSING: // 曲を再生させ，音量0からフェードさせる
            assert(this._load());
            this.__play();
            this._playerState = FADING;
            break;
        case STOPPED: // 曲を再生させ，音量0からフェードさせる
            if(this._load()){
                this.__play();
                this._playerState = FADING;
            }
            break;
        }
    }
    override void _fadeout(){
        with(PlayerState)final switch(this._playerState){
        case PLAYING: // フェードアウトさせる
            this._playerState = FADING_OUT;
            break;
        case FADING: // 今の音量からフェードアウトさせる
            this._playerState = FADING_OUT;
            break;
        case FADING_OUT: // フェードアウトの時間だけ変更
            this._playerState = FADING_OUT;
            break;
        case PAUSING: // なにもしない
            this._playerState = PAUSING;
            break;
        case STOPPED: // なにもしない
            this._playerState = STOPPED;
            break;
        }
    }
    override void _pause(){
        debug writeln("_pause");
        with(PlayerState)final switch(this._playerState){
        case PLAYING: // ポーズする
            assert(this.isPlaying);
            this.__pause();
            this._playerState = PAUSING;
            break;
        case FADING: // ポーズする
            assert(this.isPlaying);
            this.__pause();
            this._playerState = PAUSING;
            break;
        case FADING_OUT: // ポーズする
            assert(this.isPlaying);
            this.__pause();
            this._playerState = PAUSING;
            break;
        case PAUSING: // なにもしない
            //assert(!this.isPlaying);
            this._playerState = PAUSING;
            break;
        case STOPPED: // なにもしない
            //assert(!this.isPlaying);
            this._playerState = STOPPED;
            break;
        }
    }
    override void _stop(){
        with(PlayerState)final switch(this._playerState){
        case PLAYING: // ストップする
            this.__pause();
            this.time = 0;
            this._playerState = STOPPED;
            break;
        case FADING: // ストップする
            this.__pause();
            this.time = 0;
            this._playerState = STOPPED;
            break;
        case FADING_OUT: // ストップする
            this.__pause();
            this.time = 0;
            this._playerState = STOPPED;
            break;
        case PAUSING: // 時間を最初に巻き戻す
            this.time = 0;
            this._playerState = STOPPED;
            break;
        case STOPPED: // なにもしない
            this._playerState = STOPPED;
            break;
        }
    }
    void __pause()
    {
        if(this._music !is null){
            if(this._music.isLoaded){
                dx_StopSoundMem(_music.dxsound);
            }
        }
    }
}
