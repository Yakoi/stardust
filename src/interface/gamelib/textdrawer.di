// D import file generated from 'gamelib\textdrawer.d'
module gamelib.textdrawer;
import gamelib.all;
template TextDrawerInterface(T)
{
interface TextDrawerInterface
{
    bool tl(Color color, Vector pos, T str, double scaleX, double scaleY, Font font = null, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255));
    bool t(Color color, Vector pos, T str, double scaleX, double scaleY, Font font = null, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255));
    bool tr(Color color, Vector pos, T str, double scaleX, double scaleY, Font font = null, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255));
    bool l(Color color, Vector pos, T str, double scaleX, double scaleY, Font font = null, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255));
    bool c(Color color, Vector pos, T str, double scaleX, double scaleY, Font font = null, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255));
    bool r(Color color, Vector pos, T str, double scaleX, double scaleY, Font font = null, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255));
    bool bl(Color color, Vector pos, T str, double scaleX, double scaleY, Font font = null, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255));
    bool b(Color color, Vector pos, T str, double scaleX, double scaleY, Font font = null, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255));
    bool br(Color color, Vector pos, T str, double scaleX, double scaleY, Font font = null, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255));
}
}
class TextDrawer
{
}
class WTextDrawer : TextDrawerInterface!(wstring)
{
    this()
{
}
    private bool line(Color color, Vector pos, wstring str, double scaleX, double scaleY, Font font = null, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255));

    override bool tl(Color color, Vector pos, wstring str, double scaleX, double scaleY, Font font = null, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255));

    override bool t(Color color, Vector pos, wstring str, double scaleX, double scaleY, Font font = null, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255));

    override bool tr(Color color, Vector pos, wstring str, double scaleX, double scaleY, Font font = null, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255));

    override bool l(Color color, Vector pos, wstring str, double scaleX, double scaleY, Font font = null, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255))
in
{
assert(blendParam >= 0);
assert(blendParam < 256);
}
body
{
const wstring[] ss = splitlines(str);
const int fs = getFontSize(font);
const double u = cast(double)ss.length * fs * scaleY / 2;
this.tl(color,pos - vecpos(0,u),str,scaleX,scaleY,font,blendMode,blendParam,bright);
return true;
}

    override bool c(Color color, Vector pos, wstring str, double scaleX, double scaleY, Font font = null, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255))
in
{
assert(blendParam >= 0);
assert(blendParam < 256);
}
body
{
const wstring[] ss = splitlines(str);
const int fs = getFontSize(font);
const double u = cast(double)ss.length * fs * scaleY / 2;
this.t(color,pos - vecpos(0,u),str,scaleX,scaleY,font,blendMode,blendParam,bright);
return true;
}

    override bool r(Color color, Vector pos, wstring str, double scaleX, double scaleY, Font font = null, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255))
in
{
assert(blendParam >= 0);
assert(blendParam < 256);
}
body
{
const wstring[] ss = splitlines(str);
const int fs = getFontSize(font);
const double u = cast(double)ss.length * fs * scaleY / 2;
this.tr(color,pos - vecpos(0,u),str,scaleX,scaleY,font,blendMode,blendParam,bright);
return true;
}

    override bool bl(Color color, Vector pos, wstring str, double scaleX, double scaleY, Font font = null, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255))
in
{
assert(blendParam >= 0);
assert(blendParam < 256);
}
body
{
const wstring[] ss = splitlines(str);
const int fs = getFontSize(font);
const double u = ss.length * fs * scaleY;
this.tl(color,pos - vecpos(0,u),str,scaleX,scaleY,font,blendMode,blendParam,bright);
return true;
}

    override bool b(Color color, Vector pos, wstring str, double scaleX, double scaleY, Font font = null, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255))
in
{
assert(blendParam >= 0);
assert(blendParam < 256);
}
body
{
const wstring[] ss = splitlines(str);
const int fs = getFontSize(font);
const double u = ss.length * fs * scaleY;
this.t(color,pos - vecpos(0,u),str,scaleX,scaleY,font,blendMode,blendParam,bright);
return true;
}

    override bool br(Color color, Vector pos, wstring str, double scaleX, double scaleY, Font font = null, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255))
in
{
assert(blendParam >= 0);
assert(blendParam < 256);
}
body
{
const wstring[] ss = splitlines(str);
const int fs = getFontSize(font);
const double u = ss.length * fs * scaleY;
this.tr(color,pos - vecpos(0,u),str,scaleX,scaleY,font,blendMode,blendParam,bright);
return true;
}

    int stringWidth(wstring str, int str_len = -1, Font font = null);
    bool ch(Color color, Vector pos, wchar ch, double scaleX, double scaleY, Font font = null, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255))
in
{
assert(blendParam >= 0);
assert(blendParam < 256);
}
body
{
return this.c(color,pos,[ch],scaleX,scaleY,font,blendMode,blendParam,bright);
}
}
