// D import file generated from 'gamelib\movie.d'
module gamelib.movie;
import gamelib.all;
import dxlib.all;
class Movie
{
    private 
{
    int _dxhandle;
    this(int dxhandle)
{
this._dxhandle = dxhandle;
}
    package 
{
    int dxhandle()
{
return this._dxhandle;
}
    public 
{
    void play();
    void pause()
{
dx_PauseMovieToGraph(this.dxhandle);
}
    void stop()
{
this.pause();
this.frame = 0;
}
    void time(int val)
{
int res = dx_SeekMovieToGraph(this.dxhandle,val);
assert(res == 0);
}
    int time()
{
return dx_TellMovieToGraph(this.dxhandle);
}
    void frame(int val)
{
int res = dx_SeekMovieToGraphToFrame(this.dxhandle,val);
assert(res == 0);
}
    int frame()
{
return dx_TellMovieToGraphToFrame(this.dxhandle);
}
    int total_frame()
{
return dx_GetMovieTotalFrameToGraph(this.dxhandle);
}
    bool playing()
{
int res = dx_GetMovieStateToGraph(this.dxhandle);
assert(res != -1);
return res == 1;
}
    long length()
{
return this.total_frame * this.frame_time;
}
    long frame_time()
{
return dx_GetOneFrameTimeMovieToGraph(this.dxhandle);
}
    void volume(double val)
in
{
assert(0 <= val);
assert(val <= 1);
}
body
{
dx_SetMovieVolumeToGraph(cast(int)(10000 * val),this.dxhandle);
}
    bool is_finished()
{
return this.frame() >= this.total_frame - 1;
}
}
}
}
}
class MoviePlayer
{
    abstract void update();

    abstract double master_volume();

    abstract void master_volume(double val);

    abstract void stop(int fade_time = 0);

    abstract void pause(int fade_time);

    abstract bool is_enable();

    abstract void play();

}
Movie load_movie(string path, bool is_translate = true);
