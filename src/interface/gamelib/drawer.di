// D import file generated from 'gamelib\drawer.d'
module gamelib.drawer;
import std.c.windows.windows;
import dxlib.all;
import gamelib.all;
import std.stdio;
import std.c.stdlib;
import std.c.locale;
import std.conv;
import std.math;
enum BlendMode 
{
NOBLEND = DX_BLENDMODE_NOBLEND,
ALPHA = DX_BLENDMODE_ALPHA,
ADD = DX_BLENDMODE_ADD,
SUB = DX_BLENDMODE_SUB,
MUL = DX_BLENDMODE_MULA,
SUB2 = DX_BLENDMODE_SUB2,
XOR = DX_BLENDMODE_XOR,
DESTCOLOR = DX_BLENDMODE_DESTCOLOR,
INVDESTCOLOR = DX_BLENDMODE_INVDESTCOLOR,
INVSRC = DX_BLENDMODE_INVSRC,
MULA = DX_BLENDMODE_MULA,
}
enum DrawMode 
{
nearest = DX_DRAWMODE_NEAREST,
bilinear = DX_DRAWMODE_BILINEAR,
}
interface DrawerInterface
{
    Screen screen();
    bool drawMode(DrawMode val);
    DrawMode drawMode();
    TextDrawer textDrawer();
    WTextDrawer wtextDrawer();
    void flip();
    void flip();
    void clear();
    bool rect(Color color, Rect rect, bool isFill = false, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255));
    bool rect(Color color, Rectangle rect, bool isFill = false, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255));
    bool circle(Color color, int x, int y, int r, bool isFill = false, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255));
}
template DxlibDrawerTemplate()
{
}
class Drawer : DrawerInterface
{
    private 
{
    bool drawFloat = !true;
    Screen _screen;
    TextDrawer td;
    WTextDrawer wtd;
    package 
{
    this(Screen screen)
{
this.drawMode = DrawMode.nearest;
this.drawFloat = !true;
this._screen = screen;
this.td = new TextDrawer;
this.wtd = new WTextDrawer;
}
    public 
{
    void flip()
{
dx_ScreenFlip();
}
    bool box(Color color, int x1, int y1, int x2, int y2, bool isFill = false, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255))
in
{
assert(blendParam >= 0);
assert(blendParam < 256);
}
body
{
dx_SetDrawBlendMode(blendMode,blendParam);
dx_SetDrawBright(bright.red,bright.green,bright.blue);
return 0 == dx_DrawBox(x1,y1,x2,y2,color.dxColor,isFill);
}
    bool line(Color color, int x1, int y1, int x2, int y2, int thickness = 1, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255))
in
{
assert(blendParam >= 0);
assert(blendParam < 256);
}
body
{
dx_SetDrawBlendMode(blendMode,blendParam);
dx_SetDrawBright(bright.red,bright.green,bright.blue);
return 0 == dx_DrawLine(x1,y1,x2,y2,color.dxColor,thickness);
}
    bool line(Color color, IntVector pos1, IntVector pos2, int thickness = 1, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255))
in
{
assert(blendParam >= 0,text(blendParam));
assert(blendParam < 256,text(blendParam));
}
body
{
dx_SetDrawBlendMode(blendMode,blendParam);
dx_SetDrawBright(bright.red,bright.green,bright.blue);
return 0 == dx_DrawLine(pos1.x,pos1.y,pos2.x,pos2.y,color.dxColor,thickness);
}
    bool circle(Color color, int x, int y, int r, bool isFill = false, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255))
in
{
assert(blendParam >= 0,text(blendParam));
assert(blendParam < 256,text(blendParam));
}
body
{
dx_SetDrawBlendMode(blendMode,blendParam);
dx_SetDrawBright(bright.red,bright.green,bright.blue);
return 0 == dx_DrawCircle(x,y,r,color.dxColor,isFill);
}
    bool oval(Color color, int x, int y, int rx, int ry, bool isFill = false, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255))
in
{
assert(blendParam >= 0);
assert(blendParam < 256);
}
body
{
dx_SetDrawBlendMode(blendMode,blendParam);
dx_SetDrawBright(bright.red,bright.green,bright.blue);
return 0 == dx_DrawOval(x,y,rx,ry,color.dxColor,isFill);
}
    mixin DxlibDrawerTemplate!();
    Screen screen()
{
return this._screen;
}
    bool drawMode(DrawMode val)
{
return 0 == dx_SetDrawMode(val);
}
    DrawMode drawMode();
    TextDrawer textDrawer()
{
return this.td;
}
    WTextDrawer wtextDrawer()
{
return this.wtd;
}
    void clear()
{
this.fill(BLACK);
}
    bool rect(Color color, Rect rect, bool isFill = false, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255))
in
{
assert(blendParam >= 0,to!(string)(blendParam));
assert(blendParam < 256,to!(string)(blendParam));
}
body
{
return this.box(color,rect.left,rect.top,rect.right,rect.bottom,isFill,blendMode,blendParam,bright);
}
    bool rect(Color color, Rectangle rect, bool isFill = false, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255))
in
{
assert(blendParam >= 0,to!(string)(blendParam));
assert(blendParam < 256,to!(string)(blendParam));
}
body
{
return this.box(color,cast(int)rect.left,cast(int)rect.top,cast(int)rect.right,cast(int)rect.bottom,isFill,blendMode,blendParam,bright);
}
    bool rect(Color color, int l, int t, uint w, uint h, bool isFill = false, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255))
in
{
assert(blendParam >= 0);
assert(blendParam < 256);
}
body
{
return this.box(color,l,t,l + w,t + h,isFill,blendMode,blendParam,bright);
}
    bool line(Color color, double x1, double y1, double x2, double y2, int thickness = 1, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255))
in
{
assert(blendParam >= 0);
assert(blendParam < 256);
}
body
{
return line(color,cast(int)x1,cast(int)y1,cast(int)x2,cast(int)y2,thickness,blendMode,blendParam,bright);
}
    bool line(Color color, Vector pos1, Vector pos2, int thickness = 1, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255))
in
{
assert(blendParam >= 0,text(blendParam));
assert(blendParam < 256,text(blendParam));
}
body
{
return line(color,pos1.x,pos1.y,pos2.x,pos2.y,thickness,blendMode,blendParam,bright);
}
    bool circle(Color color, Vector pos, int r, bool isFill = false, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255))
in
{
assert(blendParam >= 0,text(blendParam));
assert(blendParam < 256,text(blendParam));
}
body
{
return this.circle(color,cast(int)pos.x,cast(int)pos.y,r,isFill,blendMode,blendParam,bright);
}
    bool circle(Color color, Vector pos, double r, bool isFill = false, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255))
in
{
assert(blendParam >= 0,text(blendParam));
assert(blendParam < 256,text(blendParam));
}
body
{
return this.circle(color,cast(int)pos.x,cast(int)pos.y,cast(int)r,isFill,blendMode,blendParam,bright);
}
    bool circle(Color color, IntVector pos, int r, bool isFill = false, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255))
in
{
assert(blendParam >= 0,text(blendParam));
assert(blendParam < 256,text(blendParam));
}
body
{
return this.circle(color,pos.x,pos.y,r,isFill,blendMode,blendParam,bright);
}
    bool triangle(Color color, int x1, int y1, int x2, int y2, int x3, int y3, bool isFill = false, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255))
in
{
assert(blendParam >= 0);
assert(blendParam < 256);
}
body
{
dx_SetDrawBlendMode(blendMode,blendParam);
dx_SetDrawBright(bright.red,bright.green,bright.blue);
return 0 == dx_DrawTriangle(x1,y1,x2,y2,x3,y3,color.dxColor,isFill);
}
    bool triangle(Color color, IntVector pos1, IntVector pos2, IntVector pos3, bool isFill = false, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255))
in
{
assert(blendParam >= 0);
assert(blendParam < 256);
}
body
{
dx_SetDrawBlendMode(blendMode,blendParam);
dx_SetDrawBright(bright.red,bright.green,bright.blue);
return 0 == dx_DrawTriangle(pos1.x,pos1.y,pos2.x,pos2.y,pos3.x,pos3.y,color.dxColor,isFill);
}
    bool triangle(Color color, Vector pos1, Vector pos2, Vector pos3, bool isFill = false, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255))
in
{
assert(blendParam >= 0);
assert(blendParam < 256);
}
body
{
dx_SetDrawBlendMode(blendMode,blendParam);
dx_SetDrawBright(bright.red,bright.green,bright.blue);
return 0 == dx_DrawTriangle(cast(int)pos1.x,cast(int)pos1.y,cast(int)pos2.x,cast(int)pos2.y,cast(int)pos3.x,cast(int)pos3.y,color.dxColor,isFill);
}
    bool point(Color color, IntVector pos, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255))
in
{
assert(blendParam >= 0);
assert(blendParam < 256);
}
body
{
dx_SetDrawBlendMode(blendMode,blendParam);
dx_SetDrawBright(bright.red,bright.green,bright.blue);
return 0 == dx_DrawPixel(pos.x,pos.y,color.dxColor);
}
    bool fill(Color color, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255))
in
{
assert(blendParam >= 0);
assert(blendParam < 256);
}
body
{
return this.rect(color,0,0,this.screen.width,this.screen.height,true,blendMode,blendParam,bright);
}
    bool polygon(Surface surface, VERTEX* vertexArray, int vertex_num, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255));
    bool polygon(Surface surface, VERTEX[] vertexArray, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255))
in
{
assert(blendParam >= 0);
assert(blendParam < 256);
}
body
{
return polygon(surface,vertexArray.ptr,vertexArray.length,blendMode,blendParam,bright);
}
    bool polygon(Surface surface, Vector[] vector_array, Color[] color_array, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255));
    bool polygon_(Color color, IntVector[] vector_array, bool isFill, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255));
    bool polygon(Color color, Vector[] vector_array, bool isFill, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255));
    bool dx_graph(int GrHandle, int x, int y, bool isTranslate, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255))
in
{
assert(blendParam >= 0);
assert(blendParam < 256);
}
body
{
dx_SetDrawBlendMode(blendMode,blendParam);
dx_SetDrawBright(bright.red,bright.green,bright.blue);
return 0 == dx_DrawGraph(x,y,GrHandle,isTranslate);
}
    bool surface(Surface surface, Vector pos, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255))
in
{
assert(blendParam >= 0);
assert(blendParam < 256);
}
body
{
return this.dx_graph(surface.dxhandle,cast(int)pos.x,cast(int)pos.y,surface.isTranslate,blendMode,blendParam,bright);
}
    bool surface2(Surface surface, Vector pos, double dir, double scale, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255))
in
{
assert(blendParam >= 0);
assert(blendParam < 256);
}
body
{
dx_SetDrawBlendMode(blendMode,blendParam);
dx_SetDrawBright(bright.red,bright.green,bright.blue);
auto res = dx_DrawRotaGraph(cast(int)pos.x,cast(int)pos.y,scale,dir,surface.dxhandle,surface.isTranslate,false);
return res == 0;
}
    bool surface_rect(Surface surface, Vector pos, Rect rect, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255))
in
{
assert(blendParam >= 0);
assert(blendParam < 256);
}
body
{
dx_SetDrawBlendMode(blendMode,blendParam);
dx_SetDrawBright(bright.red,bright.green,bright.blue);
auto res = dx_DrawRectGraph(cast(int)pos.x,cast(int)pos.y,rect.left,rect.top,rect.width,rect.height,surface.dxhandle,surface.isTranslate,false);
return res == 0;
}
    version (none)
{
    bool alltext(Color color, Direction9 direct, Vector pos, wstring str, Horizon3 lcr);
}
    bool textln_tl(Color color, Vector pos, wstring str, Font font = null, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255))
{
return this.wtextln(color,pos,str,font,blendMode,blendParam,bright);
}
    bool textln_tl(Color color, Vector pos, string str, Font font = null, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255))
{
return this.textln(color,pos,str,font,blendMode,blendParam,bright);
}
    private bool wtextln(Color color, Vector pos, wstring str, Font font = null, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255));

    private bool textln(Color color, Vector pos, string str, Font font = null, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255))
in
{
assert(blendParam >= 0);
assert(blendParam < 256);
}
body
{
return wtextln(color,pos,wtext(str),font,blendMode,blendParam,bright);
}

    private bool wtextln_c(Color color, Vector pos, wstring str, Font font = null, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255))
in
{
assert(blendParam >= 0);
assert(blendParam < 256);
}
body
{
int sw = this.wstringWidth(str,-1,font);
int sh = font is null ? dx_GetFontSize() : font.size;
Vector tl = pos - vecpos(sw / 2,sh / 2);
return wtextln(color,tl,str,font,blendMode,blendParam,bright);
}

    private bool textln_c(Color color, Vector pos, string str, Font font = null, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255))
in
{
assert(blendParam >= 0);
assert(blendParam < 256);
}
body
{
int sw = this.stringWidth(str,-1,font);
int sh = font is null ? dx_GetFontSize() : font.size;
Vector tl = pos - vecpos(sw / 2,sh / 2);
return textln(color,tl,str,font,blendMode,blendParam,bright);
}

    bool text_tl(Color color, Vector pos, string str, Font font = null, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255));
    bool text_tr(Color color, Vector pos, string str, Font font = null, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255))
in
{
assert(blendParam >= 0);
assert(blendParam < 256);
}
body
{
return true;
}
    bool wtext_c(Color color, Vector pos, wstring str, Font font = null, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255));
    bool text_c(Color color, Vector pos, string str, Font font = null, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255));
    bool text_l(Color color, Vector pos, string str, Font font = null, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255))
in
{
assert(blendParam >= 0);
assert(blendParam < 256);
}
body
{
int sh = splitlines(str).length * getFontSize(font);
Vector tl = pos - vecpos(0,sh / 2);
return text_tl(color,tl,str,font,blendMode,blendParam,bright);
}
    bool text_r(Color color, Vector pos, string str, Font font = null, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255));
    bool text_br(Color color, Vector pos, string str, Font font = null, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255));
    int stringWidth(string str, int str_len = -1, Font font = null);
    int wstringWidth(wstring str, int str_len = -1, Font font = null);
    bool laser(Surface surface, Surface edgeSurface, Vector pos, double dir, double length, double lengthEdge, double width, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255))
in
{
assert(blendParam >= 0);
assert(blendParam < 256);
}
body
{
dx_SetDrawBlendMode(blendMode,blendParam);
dx_SetDrawBright(bright.red,bright.green,bright.blue);
Vector d = Vector(1,0);
d.dir = dir;
Vector dp = Vector(1,0);
dp.dir = dir + PI / 2;
Vector[4] edge1 = [pos + dp * width / 2,pos - dp * width / 2,pos + d * lengthEdge + dp * width / 2,pos + d * lengthEdge - dp * width / 2];
Vector[4] main = [pos + d * lengthEdge + dp * width / 2,pos + d * lengthEdge - dp * width / 2,pos + d * (length + 1) - d * lengthEdge - dp * width / 2,pos + d * (length + 1) - d * lengthEdge + dp * width / 2];
Vector[4] edge2 = [pos + d * length + dp * width / 2,pos + d * length - dp * width / 2,pos + d * length - d * lengthEdge + dp * width / 2,pos + d * length - d * lengthEdge - dp * width / 2];
bool res1 = 0 == dx_DrawModiGraphF(edge1[0].x,edge1[0].y,edge1[2].x,edge1[2].y,edge1[3].x,edge1[3].y,edge1[1].x,edge1[1].y,edgeSurface.dxhandle,true);
bool res2 = 0 == dx_DrawModiGraphF(main[1].x,main[1].y,main[2].x,main[2].y,main[3].x,main[3].y,main[0].x,main[0].y,surface.dxhandle,true);
bool res3 = 0 == dx_DrawModiGraphF(edge2[0].x,edge2[0].y,edge2[2].x,edge2[2].y,edge2[3].x,edge2[3].y,edge2[1].x,edge2[1].y,edgeSurface.dxhandle,true);
return res1 && res2 && res3;
}
    bool simpleLaser(Surface surface, Vector pos, double dir, double length, double thickness, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255));
    bool laser2(Surface surface, Surface edgeSurface, Vector pos, double dir, double length, double lengthEdge, double width, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255))
in
{
assert(blendParam >= 0,to!(string)(blendParam));
assert(blendParam < 256,to!(string)(blendParam));
}
body
{
dx_SetDrawBlendMode(blendMode,blendParam);
dx_SetDrawBright(bright.red,bright.green,bright.blue);
Vector d = Vector(1,0);
d.dir = dir;
Vector dp = Vector(1,0);
dp.dir = dir + PI / 2;
Vector[3] tri = [pos,pos + d * lengthEdge + dp * width / 2,pos + d * lengthEdge - dp * width / 2];
Vector[4] qua = [pos + d * lengthEdge + dp * width / 2,pos + d * lengthEdge - dp * width / 2,pos + d * length - dp * width / 2,pos + d * length + dp * width / 2];
bool res1 = 0 == dx_DrawModiGraphF(tri[0].x,tri[0].y,tri[1].x,tri[1].y,tri[2].x,tri[2].y,tri[0].x,tri[0].y,edgeSurface.dxhandle,false);
bool res2 = 0 == dx_DrawModiGraphF(qua[1].x,qua[1].y,qua[2].x,qua[2].y,qua[3].x,qua[3].y,qua[0].x,qua[0].y,surface.dxhandle,false);
return res1;
}
    void drawArea(Rect rect)
{
dx_SetDrawArea(rect.left,rect.top,rect.right,rect.bottom);
}
    Rect drawArea()
{
RECT r;
dx_GetDrawArea(&r);
return mylib.rect.box(r.left,r.top,r.right,r.bottom);
}
    void clearDrawArea()
{
dx_SetDrawArea(0,0,this.screen.width,this.screen.height);
}
    void movie_rect(Movie movie, Rect rect, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255))
{
dx_SetDrawBlendMode(blendMode,blendParam);
dx_SetDrawBright(bright.red,bright.green,bright.blue);
dx_DrawExtendGraph(rect.left,rect.top,rect.right,rect.bottom,movie.dxhandle,false);
}
    alias movie_rect movie;
    void movie(Movie movie, BlendMode blendMode = BlendMode.NOBLEND, int blendParam = 255, Color bright = col(255,255,255))
{
this.movie(movie,this.screen.rect,blendMode,blendParam,bright);
}
    void blendSurface(BlendSurface bs, double par)
{
dx_SetBlendGraph(bs.dxhandle,cast(int)(par * 255),1);
}
    void clearBlendSurface()
{
dx_SetBlendGraph(0,-1,1);
}
    void blend(int x, int y, Surface surface, bool isTranslate, BlendSurface blendSurface, double border_param, BorderRange br)
{
dx_DrawBlendGraph(x,y,surface.dxhandle,isTranslate,blendSurface.dxhandle,cast(int)(border_param * 255),br);
}
}
}
}
}
enum BorderRange 
{
BORDER1 = 1,
BORDER64 = 64,
BORDER128 = 128,
BORDER255 = 255,
}
void DrawExRotaGraphF(float ex, float ey, float xScale, float yScale, float Angle, int GrHandle, int TransFlag, int TurnFlag);
