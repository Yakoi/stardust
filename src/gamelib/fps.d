module gamelib.fps;


import gamelib.all;
import std.string;
import dxlib.all;
import std.stdio;
enum UnitTime{
    micro,
    mili,
}
class Fps{
private:
    //fps
    const SKIP_TIME = 10;
    int  FLAME = 60;

    //fpsのカウンタ、60フレームに1回基準となる時刻を記録する変数
    long count0t;
    int fpsCount;
    //平均を計算するため60回の1周時間を記録
    long[] f;
    //平均fps
    double ave;
    long prevTime=0;
    bool _skip = false;

    bool _isEnable = true;
    UnitTime unitTime = UnitTime.micro;
    invariant(){
        assert(this.FLAME > 0);
    }
package:
    this(uint flame=60, UnitTime = UnitTime.micro){
        FLAME = flame;
        f.length = updateIntervalFlame;
        this._isEnable = true;
    }
public:
    ///FLAME fps になるようにfpsを計算・制御
    void fpsWait(){
        long nowTime = getNowTimeMicro();
        if(fpsCount == 0){
            this.count0t = nowTime;
        }
        double term = waitMicro(nowTime, this.count0t, this.fpsCount);
        if(term>0){//待つべき時間だけ待つ
            //sleep(term);
            if(this.isEnable){
                dx_WaitTimer(cast(int)(term/1000));
            }
        }
        if(term<-SKIP_TIME){
            this._skip = true;
        }else{
            this._skip = false;
        }
        if(prevTime != 0){
            f[cast(int)fpsCount] = nowTime-prevTime;//１周した時間を記録
        }else{
            assert(FLAME > 0);
            f[cast(int)fpsCount] = 1000*1000/FLAME;//１周した時間を記録
        }

        //平均計算
        if(fpsCount==this.updateIntervalFlame-1){
            ave=0;
            for(int i=0;i<this.updateIntervalFlame;i++){
                ave+=f[i];
            }
            ave/=this.updateIntervalFlame;
        }
        //update
        fpsCount = (fpsCount+1)%this.updateIntervalFlame ;
        this.prevTime = nowTime;
    }
    const private double waitMicro(long nowTime, long count0t, int fpsCount){
        version(none){//60フレームの1回目なら
            auto count0t_tmp = count0t; 
            //count0t = nowTime;  //基準値の設定
            if(prevTime==0){//完全に最初ならまたない
                return 0;
            } else{//前回記録した時間を元に計算
                assert(this.FLAME > 0);
                double term = (cast(double)prevTime+1*(1000.0*1000/this.FLAME)) - nowTime;
                return (1000.0*1000/this.FLAME) - (nowTime - prevTime);
            }
        }
        //else{    //待つべき時間=現在あるべき時刻-現在の時刻
            //double term = (cast(double)count0t+(fpsCount+1)*(1000.0*1000/FLAME)) - nowTime;
            assert(this.FLAME > 0);
            return (fpsCount+1)*(1000.0*1000/this.FLAME) - (nowTime - count0t);
            //return term;
        //}
    }
    const pure int updateIntervalFlame(){
        return this.FLAME/2;
    }
    private long getNowTimeMicro(){
        final switch(this.unitTime){
        case UnitTime.mili:
            return dx_GetNowCount()*1000;
        case UnitTime.micro:
            return dx_GetNowHiPerformanceCount();
        }
    }
    final void draw(Drawer drawer, int x, int y){
        if(ave!=0){
            wstring str = wtext(this.toString);
            dx_DrawString(x, y, toWStringz(cast(wchar[])str), 0xFFFFFF);
        }
        return;
    }
    ///x,yの位置にfpsを表示
    final void draw(Drawer drawer, int x, int y, Font font){
        if(ave!=0){
            string str = this.toString;
            drawer.text_tl(gamelib.color.WHITE, vecpos(0,0), (str), font);
        }
        return;
    }

    ///平均FPSを取得
    final const pure double average(){
        final switch(this.unitTime){
        case UnitTime.mili:
            return 1000.0/(this.ave);
        case UnitTime.micro:
            return 1000.0*1000/this.ave;
        }
    }
    ///平均FPSを取得
    final const pure double par(){return this.average/this.FLAME;}
    ///平均FPSを文字列に
    final override string toString(){
        static if(!false){
            string str = std.conv.to!(string)(this.average);
        }else{
            string str = std.conv.to!(string)(this.par*100);
        }
        return str;
    }
    final const pure bool isEnable(){return this._isEnable;}
    final void isEnable(bool val){this._isEnable = val;}
    final const pure int flamerate(){return this.FLAME;}
    final void flamerate(int val)
    in{
        assert(val > 0);
    }body{
        if(val != this.FLAME){
            fpsCount = 0;
            ave = 0;
        }
        this.FLAME = val;
        if(this.f.length < this.updateIntervalFlame){
            f.length = this.updateIntervalFlame;
        }
    }
    const pure nothrow bool skip(){
        return this._skip;
    }

    
}
