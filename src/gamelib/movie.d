module gamelib.movie;

import gamelib.all;
import dxlib.all;

class Movie{
private:
    int _dxhandle;
    this(int dxhandle){
        this._dxhandle = dxhandle;
    }
package:
    /// dxlibの為のハンドル
    int dxhandle(){return this._dxhandle;}
public:
    /// -> movie player
    void play(){
        if(!this.is_finished){
            dx_PlayMovieToGraph(this.dxhandle);
        }
    }
    /// -> movie player
    void pause(){
        dx_PauseMovieToGraph(this.dxhandle);
    }
    /// -> movie player
    void stop(){
        this.pause();
        this.frame = 0;
    }
    /// -> movie player
    void time(int val){
        int res = dx_SeekMovieToGraph(this.dxhandle, val);
        assert(res == 0);
    }
    /// -> movie player
    int time(){
        return dx_TellMovieToGraph(this.dxhandle) ;// ムービーの再生位置を取得する(ミリ秒単位)
    }
    /// -> movie player
    void frame(int val){
        int res = dx_SeekMovieToGraphToFrame(this.dxhandle, val);
        assert(res == 0);
    }
    /// -> movie player
    int frame(){
        return dx_TellMovieToGraphToFrame(this.dxhandle) ;// ムービーの再生位置を取得する(ミリ秒単位)
    }
    /// 曲の長さを得る
    int total_frame(){
        return dx_GetMovieTotalFrameToGraph(this.dxhandle) ;// ムービーの総フレーム数を得る( Ogg Theora でのみ有効 )
    }
    /// -> movie player
    bool playing(){
        int res = dx_GetMovieStateToGraph(this.dxhandle) ;
        assert(res != -1);
        return res == 1;
    }
    /// 曲の長さを得る
    long length(){
        return  this.total_frame * this.frame_time ;// ムービーの総フレーム数を得る( Ogg Theora でのみ有効 )
    }
    /// 一フレーム当たりの時間を得る
    long frame_time(){
        return dx_GetOneFrameTimeMovieToGraph(this.dxhandle) ;// ムービーの１フレームあたりの時間を得る
    }
    /// ボリューム
    void volume(double val)
    in{
        assert(0.0<=val);
        assert(val<=1.0);
    }body{
        dx_SetMovieVolumeToGraph(cast(int)(10000*val), this.dxhandle) ;// ムービーのボリュームをセットする(0～10000)
    }
    bool is_finished(){
        return this.frame() >= this.total_frame-1;
    }
}
/// 動画を扱うプレイヤーのベースクラス
class MoviePlayer{
    //abstract void play(Audio audio);
    abstract void update();
    abstract double master_volume();
    abstract void master_volume(double val);
    abstract void stop(int fade_time = 0);
    abstract void pause(int fade_time);
    abstract bool is_enable();
    abstract void play();
}
/// 動画を開く
Movie load_movie(string path, bool is_translate = true){
    int dxhandle = dx_OpenMovieToGraph(toWStringz(path)) ;                                // ムービーを開く
    if(dxhandle == -1){throw new Exception("Movie Load Error : " ~ path);}
    //int dxhandle = dx_LoadGraph(toWStringz(path));
    return new Movie(dxhandle);
}
