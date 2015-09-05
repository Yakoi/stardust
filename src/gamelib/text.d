module gamelib.text;

import gamelib.all;
import mylib.utils;
import std.stdio;
import std.conv;
import std.math;
import mylib.list;

/// text base class
abstract class Text{
    Font _font;
    this(Font font){ this._font = font; }
    abstract bool draw(Drawer drawer, string str, int n, Vector pos = vecpos(0,0),
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255));
    final bool draw(Drawer drawer, string str, Vector pos = vecpos(0,0),
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255)){
        return this.draw(drawer, str, str.length, pos,blendMode, blendParam, bright);
    }
}
class TextLine : Text{
    int _width;
    this(Font font, int width){
        super(font);
        this._width = width;
    }
}
class TextBox : Text{
protected:
    Rect _rect;
    Color _textColor;
    Color _backColor;
    bool _autoLinefeed = !false;
public:
    this(Rect rect, Color textColor, Color backColor, Font font){
        this._rect       = rect;
        this._textColor = textColor;
        this._backColor = backColor;
        super(font);
    }
    this(int x, int y, int wstrnum, int hstrnum, Color textColor, Color backColor, Font font){
        int w = wstrnum*(font.size+1);
        int h = hstrnum*(font.size+1);
        int dw = 3;
        int dh = 2;
        this._rect       = rect(x-w/2-dw, y-h/2-dh, w+dw*2, h+dh*2);
        this._textColor = textColor;
        this._backColor = backColor;
        super(font);
    }
    override bool draw(Drawer drawer, string str, int n = -1, Vector pos = vecpos(0,0),
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255)){
        drawer.drawArea(this._rect);
        if(n<0){
            n=99999999;
        }
        int w = this._font.size;
        wstring[] wstrs;
        if(this._autoLinefeed){
            int maxChara = this._rect.width / w; //一行に表示出来る文字数
            wstrs = divstr(to!(wstring)(str)[0..min!(int)(n,$-1)], (maxChara));
        }else{
            wstrs = divstr(to!(wstring)(str)[0..min!(int)(n,$-1)], 999999);
        }
        bool res1 = drawer.rect(this._backColor, this._rect+pos, true,
                BlendMode.ALPHA, blendParam/3, bright);
        bool res2 = drawer.rect(WHITE, this._rect+pos, false, BlendMode.ALPHA, blendParam, bright);
        foreach(int i, wstring ws; wstrs){
            int y = i*(this._font.size+1);
            bool res3 = drawer.textln_tl(this._textColor, 
                this._rect.top_left.toVector+Vector(2,3+y)+pos, ws, this._font,
                blendMode, blendParam, bright);
        }
        /+
        for(int i=0; i<line_num; i++){
            bool res3 = drawer.text(this._textColor, 
                this._rect.top_left.toVector+Vector(2,3+y)+pos, wstr[0+i*maxChara..min((i+1)*maxChara,n)], this._font,
                blendMode, blendParam, bright);
            y += this._font.size;
            if(!res3){return false;}
        }
        +/
        /+
        bool res3 = drawer.text(this._textColor, 
                this._rect.top_left.toVector+Vector(2,3+y)+pos, wstr, this._font,
                blendMode, blendParam, bright);
        +/
        drawer.clearDrawArea();
        

        return res1 && res2 ;
    }

    private void drawTextline(Drawer drawer, string str,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255)){
    }

}

class DebugText : Text{
    int _centerX;
    int _width;
    int _bottomY;
    int _maxLine;
    int _drawTime;
    int _colorCount;
    struct StrCount{
        wstring wstr;
        int count;
        Color backColor;
    }
    FixedList!(StrCount) _strCountList;
    this(int centerX, int width, int bottomY, int drawTime, int maxLine, Font font){
        super(font);
        this._centerX = centerX;
        this._width    = width;
        this._bottomY = bottomY;
        this._maxLine = maxLine;
        this._drawTime = drawTime; 
        this._strCountList = new FixedList!(StrCount)(maxLine);
        this._colorCount = 0;
    }
    Color rotationColor(){
        this._colorCount++;
        const div = 10;
        return hls(cast(double)this._colorCount/div*360, 0.5, 1);
        //return hsv(cast(double)this._colorCount/div*360, 0.5, 1);
    }
    void addText(wstring str){
        Color col = this.rotationColor;
        void add(wstring str){
            if(str == "\n"){return;}
            if(_strCountList.full){
                _strCountList.popBack;
            }
            _strCountList.pushFront(StrCount(str, 0, col));
        }
        wstring[] wstrs = divstr(str, this.maxChara);
        foreach_reverse(ws; wstrs){
            add(ws);
        }
    }
    void update(){
        auto func = (StrCount sc){return sc.count < this._drawTime;};
        this._strCountList.leave(func);
        foreach(ref sc; this._strCountList){
            sc.count ++;
        }
    }
        
    int maxChara(){return  this._width / this._font.size;} //一行に表示出来る文字数
    bool draw(Drawer drawer, Vector pos = vecpos(0,0),
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255)){
        int x = this._centerX - this._width/2;
        int y = this._bottomY - (this._font.size+1);
        foreach_reverse(sc; this._strCountList){
            int linenum = drawStrCount(drawer, sc, pos + vecpos(x,y),
                    blendMode, blendParam, bright);
            y -= linenum *(this._font.size+1);
        }
        Rect r = box(this._centerX-this._width/2, y+this._font.size,
                this._centerX+this._width/2, this._bottomY);
        drawer.rect(WHITE, r, false, BlendMode.ALPHA, blendParam, bright);
        return true;
    }
    int drawStrCount(Drawer drawer, StrCount sc, Vector pos, 
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255)){
        //wstring[] wstrs = divstr(sc.wstr, this._width/(this._font.size+1));
        wstring[] wstrs = [sc.wstr];
        Rect r = box(this._centerX-this._width/2, pos.y,
                this._centerX+this._width/2, pos.y+this._font.size+1);
        bool res1 = drawer.rect(sc.backColor, r, true,
                BlendMode.ALPHA, blendParam/3, bright);
        foreach(int i, wstring ws; wstrs){
            int y = i*(this._font.size+1);
            bool res3 = drawer.textln_tl(WHITE, 
                vecpos(3,y)+pos, ws, this._font,
                blendMode, blendParam, bright);
        }
        return wstrs.length;
    }
    override bool draw(Drawer drawer, string str, int n = -1, Vector pos = vecpos(0,0),
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255)){
        assert(false);
    }
}
class InfomationText : Text{
    this(Font font){
        super(font);
    }
    void regist(string name, lazy string f){
    }
    void regist(string name, ref int x){
    }

}


class MessageText : TextBox{
    string _currentStr    = "";
    string _nextStr       = "";
    int _drawCount        = 0;
    int _currentDrawTime = 0;
    int _nextDrawTime    = 0;
    int _defaultDrawTime = 200;
    int _fadeTime         = 5;

    this(Rect rect, Color textColor, Color backColor, Font font){
        super(rect, textColor, backColor, font);
    }
    void str(string str){
        this._nextStr = str;
        this._nextDrawTime  = this._defaultDrawTime;
    }
    void str(string str, int drawTime)
    in{
        assert(drawTime >= 0);
    }body{
        this._nextDrawTime  = drawTime;
        this._nextStr = str;
    }
    bool isVisible(){return this._drawCount>0;}
    void update(){
        if(this._nextDrawTime > 0){   //次に表示すべき文字がセットされている
            if(this._drawCount<0){         //今は何も表示されていない
                this._currentStr       = this._nextStr;
                this._currentDrawTime = this._nextDrawTime;
                this._drawCount        = this._nextDrawTime;
                this._nextStr          = "";
                this._nextDrawTime    = 0;
            }else if(this._drawCount<this._fadeTime){
                //表示されているが、フェードアウト中
                //do nothing
            }else{         //表示されており、まだフェードアウトまでたどり着いていない
                //_drawCountを、フェードアウトする地点までスキップ
                this._drawCount = this._fadeTime;
            }
        }
        this._drawCount --;
    }
    bool draw(Drawer drawer){
        if(this.isVisible){
            bool res1 = drawer.rect(this._backColor, this._rect, true,
                    BlendMode.ALPHA, 128*this.alpha / 255);
            drawer.rect(WHITE, this._rect, false, BlendMode.ALPHA, this.alpha);
            bool res2 = drawer.textln_tl(this._textColor, 
                    this._rect.top_left.toVector+Vector(2,2), this._currentStr, this._font,
                    BlendMode.ALPHA, 255*this.alpha / 255);
            return res1 && res2;
        }else{
            return true;
        }
    }
    int alpha(){
        if(this._drawCount <= this._fadeTime){
            return 255*this._drawCount/this._fadeTime;
        }else if(this._drawCount >= this._currentDrawTime-this._fadeTime){
            return 255*(this._currentDrawTime -this._drawCount) /this._fadeTime;
        }else{
            return 255;
        }
    }
}
class FpsText : TextBox{
    Rect _rect;
    Color _textColor;
    Color _backColor;
    Font _font;
    this(Rect rect, Color textColor, Color backColor, Font font){
        super(rect, textColor, backColor, font);
    }


}
