// D import file generated from 'gamelib\figure.d'
module gamelib.figure;
import gamelib.all;
import std.stdio;
import mylib.list;
import dxlib.all;
alias VariableList!(Figure) FigureList;
abstract class Figure
{
    this()
{
}
    abstract int left();

    abstract int right();

    abstract int top();

    abstract int bottom();

    abstract int width();

    abstract int height();

    abstract int cx();

    abstract int cy();

    abstract bool draw(Drawer drawer, Vector pos, double dir, double scale, BlendMode blendMode, int blendParam, Color bright, bool isRotate, uint animationCount);

}

class NoFigure : Figure
{
    this()
{
super();
}
    override int left()
{
return 0;
}

    override int right()
{
return 0;
}

    override int top()
{
return 0;
}

    override int bottom()
{
return 0;
}

    override int width()
{
return 0;
}

    override int height()
{
return 0;
}

    override int cx()
{
return 0;
}

    override int cy()
{
return 0;
}

    override bool draw(Drawer drawer, Vector pos, double dir, double scale, BlendMode blendMode, int blendParam, Color bright, bool isRotate, uint animationCount)
in
{
assert(blendParam >= 0);
assert(blendParam < 256);
}
body
{
return true;
}

}
class CircleFigure : Figure
{
    Color _color;
    IntVector _pos;
    int _radius;
    bool _isFill;
    this(Color color, IntVector pos, int radius, bool isFill)
{
this._pos = pos;
this._color = color;
this._radius = radius;
this._isFill = isFill;
}
    this(Color color, int radius, bool isFill = false)
{
this(color,IntVector(0,0),radius,isFill);
}
    override int left()
{
return _pos.x - _radius;
}

    override int right()
{
return _pos.x + _radius;
}

    override int top()
{
return _pos.y - _radius;
}

    override int bottom()
{
return _pos.y + _radius;
}

    override int width()
{
return 2 * _radius;
}

    override int height()
{
return 2 * _radius;
}

    override int cx()
{
return _pos.x;
}

    override int cy()
{
return _pos.y;
}

    override bool draw(Drawer drawer, Vector pos, double dir, double scale, BlendMode blendMode, int blendParam, Color bright, bool isRotate, uint animationCount)
in
{
assert(blendParam >= 0);
assert(blendParam < 256);
}
body
{
return drawer.circle(this._color,this._pos + pos.toIntVector,cast(int)(this._radius * scale),this._isFill,blendMode,blendParam,bright);
}

}
class RectFigure : Figure
{
    Color _color;
    Rect _rect;
    bool _isFill;
    double _scale;
    this(Color color, Rect rect, double scale, bool isFill)
{
_color = color;
_rect = rect;
_scale = scale;
_isFill = isFill;
}
    this(Color color, uint w, uint h, double scale, bool isFill)
{
_color = color;
_rect = Rect(-cast(int)w / 2,-cast(int)h / 2,w,h);
_scale = scale;
_isFill = isFill;
}
    override int left()
{
return _rect.left;
}

    override int right()
{
return _rect.right;
}

    override int top()
{
return _rect.top;
}

    override int bottom()
{
return _rect.bottom;
}

    override int width()
{
return _rect.width;
}

    override int height()
{
return _rect.height;
}

    override int cx()
{
return _rect.cx;
}

    override int cy()
{
return _rect.cy;
}

    override bool draw(Drawer drawer, Vector pos, double dir, double scale, BlendMode blendMode, int blendParam, Color bright, bool isRotate, uint animationCount)
in
{
assert(blendParam >= 0);
assert(blendParam < 256);
}
body
{
return drawer.rect(this._color,this._rect + pos,this._isFill,blendMode,blendParam,bright);
}

}
class PolygonFigure : Figure
{
    Color _color;
    bool _isFill;
    double _scale;
    Vector[] _vectorArray;
    this(Color color, Vector[] vectorArray, double scale, bool isFill)
{
this._color = color;
this._vectorArray = vectorArray;
this._scale = scale;
this._isFill = isFill;
}
    override int left()
{
return 0;
}

    override int right()
{
return 0;
}

    override int top()
{
return 0;
}

    override int bottom()
{
return 0;
}

    override int width()
{
return 0;
}

    override int height()
{
return 0;
}

    override int cx()
{
return 0;
}

    override int cy()
{
return 0;
}

    override bool draw(Drawer drawer, Vector pos, double dir, double scale, BlendMode blendMode, int blendParam, Color bright, bool isRotate, uint animationCount)
in
{
assert(blendParam >= 0);
assert(blendParam < 256);
}
body
{
return drawer.polygon(this._color,this._vectorArray,this._isFill,blendMode,blendParam,bright);
}

}
class SurfaceFigure : Figure
{
    Surface _surface;
    this(Surface surface)
{
_surface = surface;
}
    override int left()
{
return _surface.rect.left;
}

    override int right()
{
return _surface.rect.right;
}

    override int top()
{
return _surface.rect.top;
}

    override int bottom()
{
return _surface.rect.bottom;
}

    override int width()
{
return _surface.rect.width;
}

    override int height()
{
return _surface.rect.height;
}

    override int cx()
{
return _surface.rect.cx;
}

    override int cy()
{
return _surface.rect.cy;
}

    override bool draw(Drawer drawer, Vector pos, double dir, double scale, BlendMode blendMode, int blendParam, Color bright, bool isRotate, uint animationCount);

}
SurfaceFigure create_figure_from_file(string path)
{
Surface sur = loadSurface(path);
return new SurfaceFigure(sur);
}
class AnimationFigure : Figure
{
    Figure[] _figureArray;
    double _perFlame;
    bool _isLoop;
    Vector _pos;
    double _dir;
    this(Figure[] figureArray, double perFlame, bool isLoop, Vector pos, double dir)
{
this._figureArray = figureArray;
this._perFlame = perFlame;
this._isLoop = isLoop;
this._pos = pos;
this._dir = dir;
}
    override int left()
{
return 0;
}

    override int right()
{
return 0;
}

    override int top()
{
return 0;
}

    override int bottom()
{
return 0;
}

    override int width()
{
return 0;
}

    override int height()
{
return 0;
}

    override int cx()
{
return 0;
}

    override int cy()
{
return 0;
}

    override bool draw(Drawer drawer, Vector pos, double dir, double scale, BlendMode blendMode, int blendParam, Color bright, bool isRotate, uint animationCount);

}
AnimationFigure createAnimationFigureFromFile(string path, uint divX, uint divY, double perFlame, bool isLoop = true, Vector pos = Vector(0,0), double dir = 0);
AnimationFigure createAnimationFigureFromSurface(Surface surface, uint divX, uint divY, double perFlame, bool isLoop = true, Vector pos = Vector(0,0), double dir = 0);
class FigureGroup : Figure
{
    FigureList _figureList;
    Vector _pos;
    double _dir;
    this(FigureList figureList, Vector pos, double dir)
{
this._figureList = figureList;
this._pos = pos;
this._dir = dir;
}
    override int left()
{
return 0;
}

    override int right()
{
return 0;
}

    override int top()
{
return 0;
}

    override int bottom()
{
return 0;
}

    override int width()
{
return 0;
}

    override int height()
{
return 0;
}

    override int cx()
{
return 0;
}

    override int cy()
{
return 0;
}

    override bool draw(Drawer drawer, Vector pos, double dir, double scale, BlendMode blendMode, int blendParam, Color bright, bool isRotate, uint animationCount);

}
abstract class TwoPointFigure : Figure
{
    abstract Vector pos1();

    abstract Vector pos2();

    override int left()
{
return cast(int)min(pos1.x,pos2.x);
}

    override int right()
{
return cast(int)max(pos1.x,pos2.x);
}

    override int top()
{
return cast(int)min(pos1.y,pos2.y);
}

    override int bottom()
{
return cast(int)max(pos1.y,pos2.y);
}

    override int width()
{
return cast(int)std.math.abs(pos1.x - pos2.x);
}

    override int height()
{
return cast(int)std.math.abs(pos1.y - pos2.y);
}

    override int cx()
{
return cast(int)(pos1.x + pos2.x) / 2;
}

    override int cy()
{
return cast(int)(pos1.y + pos2.y) / 2;
}

}

class ThunderLineFigure : TwoPointFigure
{
    Vector[] poss;
    const Color color;

    const int thickness;

    this(Rand rand, in Vector p1, in Vector p2, Color color, int divNum = 5, int r1 = 30, int thickness = 4);
    override Vector pos1()
{
return this.poss[0];
}

    override Vector pos2()
{
return this.poss[$ - 1];
}

    override bool draw(Drawer drawer, Vector pos, double dir, double scale, BlendMode blendMode, int blendParam, Color bright, bool isRotate, uint animationCount);

    version (none)
{
    void thunder_line(Drawer drawer, int seed, in Vector pos1, in Vector pos2, Color col = rgb(0.5,0.5,1), int divNum = 5, int r1 = 30, int r2 = 10, int thickness = 4, int alpha = 50, int num = 10);
}
}
class LaserFigure : Figure
{
    Vector _pos;
    double _dir;
    double _length;
    Surface _surface;
    Surface _edgeSurface;
    double _thickness;
    double _edgeLengthPar;
    this(Surface surface, Vector pos, double dir, double length, double thickness)
{
this._surface = surface;
this._edgeSurface = surface;
this._pos = pos;
this._dir = dir;
this._length = length;
this._thickness = thickness;
}
    this(Surface surface, Surface edgeSurface, Vector pos, double dir, double length, double edgeLengthPar, double thickness)
{
this._surface = surface;
this._edgeSurface = edgeSurface;
this._pos = pos;
this._dir = dir;
this._length = length;
this._thickness = thickness;
this._edgeLengthPar = edgeLengthPar;
}
    override bool draw(Drawer drawer, Vector pos, double dir, double scale, BlendMode blendMode, int blendParam, Color bright, bool isRotate, uint animationCount)
in
{
assert(blendParam >= 0);
assert(blendParam < 256);
}
body
{
return drawer.laser(_surface,_edgeSurface,pos + _pos,_dir + dir,_length * scale,_length * scale * _edgeLengthPar / 2,_thickness,blendMode,blendParam,bright);
}

    override int left()
{
return 0;
}

    override int right()
{
return 0;
}

    override int top()
{
return 0;
}

    override int bottom()
{
return 0;
}

    override int width()
{
return 0;
}

    override int height()
{
return 0;
}

    override int cx()
{
return 0;
}

    override int cy()
{
return 0;
}

}
class SimpleLaserFigure : Figure
{
    Vector _pos;
    double _dir;
    double _length;
    Surface _surface;
    double _thickness;
    this(Surface surface, Vector pos, double dir, double length, double thickness)
{
this._surface = surface;
this._pos = pos;
this._dir = dir;
this._length = length;
this._thickness = thickness;
}
    this(Surface surface, double thickness)
{
this(surface,Vector(0,0),0,1,thickness);
}
    override bool draw(Drawer drawer, Vector pos, double dir, double scale, BlendMode blendMode, int blendParam, Color bright, bool isRotate, uint animationCount)
in
{
assert(blendParam >= 0);
assert(blendParam < 256);
}
body
{
return drawer.simpleLaser(_surface,pos + _pos,_dir + dir,_length * scale,_thickness,blendMode,blendParam,bright);
}

    override int left()
{
return 0;
}

    override int right()
{
return 0;
}

    override int top()
{
return 0;
}

    override int bottom()
{
return 0;
}

    override int width()
{
return 0;
}

    override int height()
{
return 0;
}

    override int cx()
{
return 0;
}

    override int cy()
{
return 0;
}

}
LaserFigure create_laser_figure(Surface surface, int edgeLength, double edgeLengthPar, double thickness)
in
{
assert(edgeLength >= 0);
assert(edgeLength < surface.width);
}
body
{
int dxhandleEdge = dx_DerivationGraph(0,0,edgeLength,surface.height,surface.dxhandle);
int dxhandleMain = dx_DerivationGraph(edgeLength,0,surface.width - edgeLength,surface.height,surface.dxhandle);
Surface surEdge = new Surface(dxhandleEdge,true);
Surface surMain = new Surface(dxhandleMain,true);
LaserFigure res = new LaserFigure(surMain,surEdge,Vector(0,0),0,1,edgeLengthPar,thickness);
return res;
}
struct FigureSet
{
    Figure figure;
    Vector pos;
    double dir;
}
pure FigureSet[] figureSet(in Figure fig)
{
return [FigureSet(cast(Figure)fig)];
}

pure FigureSet[] figureSet(in Figure fig1, in Figure fig2)
{
return [FigureSet(cast(Figure)fig1),FigureSet(cast(Figure)fig2)];
}

pure FigureSet[] figureSet(in Figure fig1, in Figure fig2, in Figure fig3)
{
return [FigureSet(cast(Figure)fig1),FigureSet(cast(Figure)fig2),FigureSet(cast(Figure)fig3)];
}

alias figureSet figSet;
