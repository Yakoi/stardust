// D import file generated from 'gamelib\text.d'
module gamelib.text;
import gamelib.all;
import mylib.utils;
import std.stdio;
import std.conv;
import std.math;
import mylib.list;
abstract class Text
{
    Font _font;
    this(Font font)
{
this._font = font;
}
    abstract bool draw(Drawer drawer, string str, int n, Vector pos = vecpos(0,0), BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255));

    final bool draw(Drawer drawer, string str, Vector pos = vecpos(0,0), BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255))
{
return this.draw(drawer,str,str.length,pos,blendMode,blendParam,bright);
}

}

class TextLine : Text
{
    int _width;
    this(Font font, int width)
{
super(font);
this._width = width;
}
}
class TextBox : Text
{
    protected 
{
    Rect _rect;
    Color _textColor;
    Color _backColor;
    bool _autoLinefeed = !false;
    public 
{
    this(Rect rect, Color textColor, Color backColor, Font font)
{
this._rect = rect;
this._textColor = textColor;
this._backColor = backColor;
super(font);
}
    this(int x, int y, int wstrnum, int hstrnum, Color textColor, Color backColor, Font font)
{
int w = wstrnum * (font.size + 1);
int h = hstrnum * (font.size + 1);
int dw = 3;
int dh = 2;
this._rect = rect(x - w / 2 - dw,y - h / 2 - dh,w + dw * 2,h + dh * 2);
this._textColor = textColor;
this._backColor = backColor;
super(font);
}
    override bool draw(Drawer drawer, string str, int n = -1, Vector pos = vecpos(0,0), BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255));

    private void drawTextline(Drawer drawer, string str, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255))
{
}

}
}
}
class DebugText : Text
{
    int _centerX;
    int _width;
    int _bottomY;
    int _maxLine;
    int _drawTime;
    int _colorCount;
    struct StrCount
{
    wstring wstr;
    int count;
    Color backColor;
}
    FixedList!(StrCount) _strCountList;
    this(int centerX, int width, int bottomY, int drawTime, int maxLine, Font font)
{
super(font);
this._centerX = centerX;
this._width = width;
this._bottomY = bottomY;
this._maxLine = maxLine;
this._drawTime = drawTime;
this._strCountList = new FixedList!(StrCount)(maxLine);
this._colorCount = 0;
}
    Color rotationColor()
{
this._colorCount++;
const div = 10;
return hls(cast(double)this._colorCount / div * 360,0.5,1);
}
    void addText(wstring str);
    void update();
    int maxChara()
{
return this._width / this._font.size;
}
    bool draw(Drawer drawer, Vector pos = vecpos(0,0), BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255));
    int drawStrCount(Drawer drawer, StrCount sc, Vector pos, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255));
    override bool draw(Drawer drawer, string str, int n = -1, Vector pos = vecpos(0,0), BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255))
{
assert(false);
}

}
class InfomationText : Text
{
    this(Font font)
{
super(font);
}
    void regist(string name, lazy string f)
{
}
    void regist(string name, ref int x)
{
}
}
class MessageText : TextBox
{
    string _currentStr = "";
    string _nextStr = "";
    int _drawCount = 0;
    int _currentDrawTime = 0;
    int _nextDrawTime = 0;
    int _defaultDrawTime = 200;
    int _fadeTime = 5;
    this(Rect rect, Color textColor, Color backColor, Font font)
{
super(rect,textColor,backColor,font);
}
    void str(string str)
{
this._nextStr = str;
this._nextDrawTime = this._defaultDrawTime;
}
    void str(string str, int drawTime)
in
{
assert(drawTime >= 0);
}
body
{
this._nextDrawTime = drawTime;
this._nextStr = str;
}
    bool isVisible()
{
return this._drawCount > 0;
}
    void update();
    bool draw(Drawer drawer);
    int alpha();
}
class FpsText : TextBox
{
    Rect _rect;
    Color _textColor;
    Color _backColor;
    Font _font;
    this(Rect rect, Color textColor, Color backColor, Font font)
{
super(rect,textColor,backColor,font);
}
}
