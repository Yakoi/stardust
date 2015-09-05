module gamelib.area;

import gamelib.all;
import mylib.utils;
import std.math;
import std.conv;
import std.stdio;

/// 範囲をあらわすクラス
abstract class Area : Rectangle, DoubleCircle{
    /// コンストラクタ
    this(){}
    /// 何かのAreaとの当たり判定
    const pure abstract bool detectCollision(in CollisionDetector cd, in Area,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double, in double);
    /// RectAreaとの当たり判定
    const pure abstract bool detectCollision(in CollisionDetector cd, in RectArea,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2);
    /// PointAreaとの当たり判定
    const pure abstract bool detectCollision(in CollisionDetector cd, in PointArea,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2);
    /// CircleAreaとの当たり判定
    const pure abstract bool detectCollision(in CollisionDetector cd, in CircleArea,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2);
    /// DoubleCircleAreaとの当たり判定
    const pure abstract bool detectCollision(in CollisionDetector cd, in DoubleCircleArea,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2);
    /// LineAreaとの当たり判定
    const pure abstract bool detectCollision(in CollisionDetector cd, in LineArea,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2);
    /// SrickAreaとの当たり判定
    const pure abstract bool detectCollision(in CollisionDetector cd, in StickArea,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2);
    /// OvalAreaとの当たり判定
    const pure abstract bool detectCollision(in CollisionDetector cd, in OvalArea,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2);
    /// AndAreaとの当たり判定
    const pure abstract bool detectCollision(in CollisionDetector cd, in AndArea,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2);
    /// OrAreaとの当たり判定
    const pure abstract bool detectCollision(in CollisionDetector cd, in OrArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2);
    /// 描画
    abstract bool draw(Drawer drawer, Vector pos, double dir, double scale, Color color); 
    const pure Rect rect(){
        return mylib.rect.rect(cast(int)this.left, cast(int)this.top, cast(int)this.width, cast(int)this.height);
    }
}
/// 当たり判定のない範囲
/// 必ずあたらない
class NoArea : Area, Rectangle, DoubleCircle{
    const pure override bool detectCollision(in CollisionDetector cd, in Area,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double, in double){return false;}
    const pure override bool detectCollision(in CollisionDetector cd, in RectArea,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){return false;}
    const pure override bool detectCollision(in CollisionDetector cd, in PointArea,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){return false;}
    const pure override bool detectCollision(in CollisionDetector cd, in CircleArea,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){return false;}
    const pure override bool detectCollision(in CollisionDetector cd, in DoubleCircleArea,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){return false;}
    const pure override bool detectCollision(in CollisionDetector cd, in LineArea,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){return false;}
    const pure override bool detectCollision(in CollisionDetector cd, in StickArea,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){return false;}
    const pure override bool detectCollision(in CollisionDetector cd, in OvalArea,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){return false;}
    const pure override bool detectCollision(in CollisionDetector cd, in AndArea,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){return false;}
    /// OrAreaとの当たり判定
    const pure override bool detectCollision(in CollisionDetector cd, in OrArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){return false;}
    override bool draw(Drawer drawer, Vector pos, double dir, double scale, Color color){return true;} 
    const pure override double left(){return double.nan;}
    const pure override double right(){return double.nan;}
    const pure override double top(){return double.nan;}
    const pure override double bottom(){return double.nan;}
    const pure override double width(){return double.nan;}
    const pure override double height(){return double.nan;}
    const pure override double cx(){return double.nan;}
    const pure override double cy(){return double.nan;}
    mixin RectangleVectorTemplate;
    const pure override double innerRadius(){return double.nan;}
    const pure override double outerRadius(){return double.nan;}
}
/// 点
class PointArea : Area, Rectangle, DoubleCircle{
    Vector _pos;
    this(Vector pos = vecpos(0,0)){
        _pos = pos;
    }
    this(double x, double y){
        this(vecpos(x,y));
    }
    const pure private Vector pos(){return _pos;}
    const pure override double left(){return pos.x;}
    const pure override double right(){return pos.x;}
    const pure override double top(){return pos.y;}
    const pure override double bottom(){return pos.y;}
    const pure override double width(){return 0;}
    const pure override double height(){return 0;}
    const pure override double cx(){return pos.x;}
    const pure override double cy(){return pos.y;}
    mixin RectangleVectorTemplate;
    const pure override double innerRadius(){return width>height ? width/2 : height/2;}
    const pure override double outerRadius(){
        return std.math.sqrt(cast(double)(height*height+ width*width))/2;}
    const pure override bool detectCollision(in CollisionDetector cd, in Area a,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        return a.detectCollision(cd, this, pos2, pos1, dir1, dir2, scale1, scale2);
    }
    const pure override bool detectCollision(in CollisionDetector cd, in RectArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        return cd.point_rect(this, a2, pos1, pos2, dir1, dir2, scale1, scale2);
    }
    const pure override bool detectCollision(in CollisionDetector cd, in PointArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        return cd.point_point(this, a2, pos1, pos2, dir1, dir2, scale1, scale2);
    }
    const pure override bool detectCollision(in CollisionDetector cd, in CircleArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        return cd.point_circle(this, a2, pos1, pos2, dir1, dir2, scale1, scale2);
    }
    const pure override bool detectCollision(in CollisionDetector cd, in DoubleCircleArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        return cd.point_doublecircle(this, a2, pos1, pos2, dir1, dir2, scale1, scale2);
    }
    override bool draw(Drawer drawer, Vector pos, double dir, double scale, Color color){
        return drawer.point(color, (_pos+pos).toIntVector());
    }
    /// AndAreaとの当たり判定
    const pure override bool detectCollision(in CollisionDetector cd, in AndArea and,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        foreach(a; and._areaArray){
            if(!this.detectCollision(cd, a, pos1, pos2, dir1, dir2, scale1, scale2)){
                return false;
            }
        }
        return true;
    }
    /// OrAreaとの当たり判定
    const pure override bool detectCollision(in CollisionDetector cd, in OrArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        foreach(a; a2._areaArray){
            if(this.detectCollision(cd, a, pos1, pos2, dir1, dir2, scale1, scale2)){
                return true;
            }
        }
        return false;
    }
    const pure override bool detectCollision(in CollisionDetector cd, in LineArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){assert(false);}
    const pure override bool detectCollision(in CollisionDetector cd, in StickArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){assert(false);}
    const pure override bool detectCollision(in CollisionDetector cd, in OvalArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        assert(false);
    }
}
/// 長方形
class RectArea : Area, Rectangle, DoubleCircle{
    double _l, _t, _w, _h;
    this(Rect rect){
        this(rect.left, rect.top, rect.width, rect.height);
    }
    this(double w, double h)
    in{
        assert(w>=0);
        assert(h>=0);
    }body{
        this(-w/2, -h/2, w, h);
    }
    this(double l, double t, double w, double h)
    in{
        assert(w>=0);
        assert(h>=0);
    }body{
        this._l = l;
        this._w = w;
        this._t = t;
        this._h = h;
    }
    const pure override double left()  {return this._l;}
    const pure override double top()   {return this._t;}
    const pure override double width() {return this._w;}
    const pure override double height(){return this._h;}
    const pure override double cx()    {return this.left + this.width/2;}
    const pure override double cy()    {return this.top + this.height/2;}
    mixin RectangleVectorTemplate;
    mixin RectangleRBTemplate;

    const pure override bool detectCollision(in CollisionDetector cd, in Area a,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        return a.detectCollision(cd, this, pos2, pos1, dir2, dir1, scale2, scale1);
    }
    const pure override bool detectCollision(in CollisionDetector cd, in PointArea a,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        return cd.point_rect(a, this, pos2, pos1, dir2, dir1, scale2, scale1);
    }
    const pure override bool detectCollision(in CollisionDetector cd, in RectArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        return cd.rect_rect(this,a2, pos1, pos2, dir1, dir2, scale1, scale2);
    }
    const pure override bool detectCollision(in CollisionDetector cd, in CircleArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        return cd.circle_rect(a2, this, pos2, pos1, dir2, dir1, scale2, scale1);
    }
    const pure override bool detectCollision(in CollisionDetector cd, in DoubleCircleArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        return cd.doublecircle_rect(a2, this, pos2, pos1, dir2, dir1, scale2, scale1);
    }
    const pure override bool detectCollision(in CollisionDetector cd, in LineArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        assert(false);
    }
    const pure override bool detectCollision(in CollisionDetector cd, in StickArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        assert(false);
    }
    const pure override bool detectCollision(in CollisionDetector cd, in OvalArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        assert(false);
    }
    /// AndAreaとの当たり判定
    const pure override bool detectCollision(in CollisionDetector cd, in AndArea and,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        foreach(a; and._areaArray){
            if(!this.detectCollision(cd, a, pos1, pos2, dir1, dir2, scale1, scale2)){
                return false;
            }
        }
        return true;
    }
    /// OrAreaとの当たり判定
    const pure override bool detectCollision(in CollisionDetector cd, in OrArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        foreach(a; a2._areaArray){
            if(this.detectCollision(cd, a, pos1, pos2, dir1, dir2, scale1, scale2)){
                return true;
            }
        }
        return false;
    }
    const pure override double innerRadius(){return width>height ? width/2 : height/2;}
    const pure override double outerRadius(){
        return std.math.sqrt(cast(double)(height*height+ width*width))/2;}
    override bool draw(Drawer drawer, Vector pos, double dir, double scale, Color color){
        return drawer.rect(color, rect+pos, false);
    }
}
/// 円
class CircleArea : Area, Rectangle, DoubleCircle{
    Vector _center;
    double       _radius;

    this(Vector center, double radius){
        _center = center;
        _radius = radius;
    }
    this(double radius){
        this(vecpos(0,0), radius);
    }
    const pure override double left()  {return _center.x - _radius;}
    const pure override double right() {return _center.x + _radius;}
    const pure override double top()   {return _center.y - _radius;}
    const pure override double bottom(){return _center.y + _radius;}
    const pure override double width() {return _radius * 2;}
    const pure override double height(){return _radius * 2;}
    const pure override double cx()    {return _center.x;}
    const pure override double cy()    {return _center.y;}
    mixin RectangleVectorTemplate;


    const pure override bool detectCollision(in CollisionDetector cd, in Area a,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2)
    {
        return a.detectCollision(cd, this, pos2, pos1, dir2, dir1, scale2, scale1);
    }
    const pure override bool detectCollision(in CollisionDetector cd, in PointArea a,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2)
    {
        return cd.point_circle(a, this, pos1, pos2, dir1, dir2, scale1, scale2);
    }
    const pure override bool detectCollision(in CollisionDetector cd, in CircleArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2)
    {
        return cd.circle_circle(this, a2, pos1, pos2, dir1, dir2, scale1, scale2);
    }
    const pure override bool detectCollision(in CollisionDetector cd, in RectArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        return cd.circle_rect(this, a2, pos1, pos2, dir1, dir2, scale1, scale2);
    }
    const pure override bool detectCollision(in CollisionDetector cd, in DoubleCircleArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        return cd.circle_doublecircle(this, a2, pos1, pos2, dir1, dir2, scale1, scale2);
    }
    const pure override bool detectCollision(in CollisionDetector cd, in LineArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        assert(false);}
    const pure override bool detectCollision(in CollisionDetector cd, in StickArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2)
    {
        assert(false);
    }
    const pure override bool detectCollision(in CollisionDetector cd, in OvalArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        assert(false);
    }
    /// AndAreaとの当たり判定
    const pure override bool detectCollision(in CollisionDetector cd, in AndArea and,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        foreach(a; and._areaArray){
            if(!this.detectCollision(cd, a, pos1, pos2, dir1, dir2, scale1, scale2)){
                return false;
            }
        }
        return true;
    }
    /// OrAreaとの当たり判定
    const pure override bool detectCollision(in CollisionDetector cd, in OrArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        foreach(a; a2._areaArray){
            if(this.detectCollision(cd, a, pos1, pos2, dir1, dir2, scale1, scale2)){
                return true;
            }
        }
        return false;
    }
    const pure override double innerRadius(){return this._radius;}
    const pure override double outerRadius(){return this._radius;}
    override bool draw(Drawer drawer, Vector pos, double dir, double scale, Color color){
        return drawer.circle(color, (this._center+pos).toIntVector(), cast(int)_radius, false);
    }
}
/// 二重の円
class DoubleCircleArea : Area, Rectangle, DoubleCircle{
    Vector _center;
    double _innerRadius;
    double _outerRadius;

    this(Vector center, double innerRadius, double outerRadius){
        this._center = center;
        this._innerRadius = innerRadius;
        this._outerRadius = outerRadius;
    }
    this(double innerRadius, double outerRadius){
        this(vecpos(0,0), innerRadius, outerRadius);
    }
    const pure override double left()  {return this._center.x - this._outerRadius;}
    const pure override double right() {return this._center.x + this._outerRadius;}
    const pure override double top()   {return this._center.y - this._outerRadius;}
    const pure override double bottom(){return this._center.y + this._outerRadius;}
    const pure override double width() {return this._outerRadius * 2;}
    const pure override double height(){return this._outerRadius * 2;}
    const pure override double cx()    {return this._center.x;}
    const pure override double cy()    {return this._center.y;}
    mixin RectangleVectorTemplate;


    const pure override bool detectCollision(in CollisionDetector cd, in Area a,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2)
    {
        return a.detectCollision(cd, this, pos2, pos1, dir2, dir1, scale2, scale1);
    }
    const pure override bool detectCollision(in CollisionDetector cd, in PointArea a,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2)
    {
        return cd.point_doublecircle(a, this, pos1, pos2, dir1, dir2, scale1, scale2);
    }
    const pure override bool detectCollision(in CollisionDetector cd, in CircleArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2)
    {
        return cd.circle_doublecircle(a2, this, pos2, pos1, dir2, dir1, scale2, scale1);
    }
    const pure override bool detectCollision(in CollisionDetector cd, in RectArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2)
    {
        return cd.doublecircle_rect(this, a2, pos1, pos2, dir1, dir2, scale1, scale2);
    }
    const pure override bool detectCollision(in CollisionDetector cd, in DoubleCircleArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2)
    {
        return cd.doublecircle_doublecircle(this, a2, pos1, pos2, dir1, dir2, scale1, scale2);
    }
    const pure override bool detectCollision(in CollisionDetector cd, in LineArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2)
    {
        assert(false);
    }
    const pure override bool detectCollision(in CollisionDetector cd, in StickArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2)
    {
        assert(false);
    }
    const pure override bool detectCollision(in CollisionDetector cd, in OvalArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        assert(false);
    }
    /// AndAreaとの当たり判定
    const pure override bool detectCollision(in CollisionDetector cd, in AndArea and,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        foreach(a; and._areaArray){
            if(!this.detectCollision(cd, a, pos1, pos2, dir1, dir2, scale1, scale2)){
                return false;
            }
        }
        return true;
    }
    /// OrAreaとの当たり判定
    const pure override bool detectCollision(in CollisionDetector cd, in OrArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        foreach(a; a2._areaArray){
            if(this.detectCollision(cd, a, pos1, pos2, dir1, dir2, scale1, scale2)){
                return true;
            }
        }
        return false;
    }
    const pure override double innerRadius(){return this._innerRadius;}
    const pure override double outerRadius(){return this._outerRadius;}
    override bool draw(Drawer drawer, Vector pos, double dir, double scale, Color color){
        bool res1 = drawer.circle(color, (this._center+pos).toIntVector(), cast(int)(this._innerRadius*scale), false);
        bool res2 = drawer.circle(color, (this._center+pos).toIntVector(), cast(int)(this._outerRadius*scale), false);
        return res1 && res2;
    }
}
/// 線状の範囲 中心が線の先端
class LineArea : Area, Rectangle, DoubleCircle{
private:
    Vector _start_pos;
    double _dir;
    double _length;
    double _thickness;
public:
    this(Vector start_pos, double dir, double length, double thickness){
        this._start_pos = start_pos;
        this._dir       = dir;
        this._length    = length;
        this._thickness = thickness;
    }
    this(double dir, double length, double thickness)
    in{
        assert(isFinite(dir));
        assert(isFinite(length));
        assert(isFinite(thickness));
    }body{
        //this(-vecdir(dir, length/2), dir, length, thickness);
        this(vecpos(0,0), dir, length, thickness);
    }
    const pure Vector _end_pos(double dir=0){return this._start_pos+vecdir(this._dir+dir, this._length);}
    const pure override double left()  {return min!(double)(this._start_pos.x, this._end_pos.x);}
    const pure override double right() {return max!(double)(this._start_pos.x, this._end_pos.x);}
    const pure override double top()   {return min!(double)(this._start_pos.y, this._end_pos.y);}
    const pure override double bottom(){return max!(double)(this._start_pos.y, this._end_pos.y);}
    const pure override double width() {return this.right-this.left;}
    const pure override double height(){return this.bottom - this.top;}
    const pure override double cx()    {return this.center.x;}
    const pure override double cy()    {return this.center.y;}
    mixin RectangleVectorTemplate2;
    const pure override Vector center()       {return (this._start_pos + this._end_pos)/2;}


    const pure override bool detectCollision(in CollisionDetector cd, in Area a,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2)
    {
        return a.detectCollision(cd, this, pos2, pos1, dir2, dir1, scale2, scale1);
    }
    const pure override bool detectCollision(in CollisionDetector cd, in PointArea a,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2)
    {
        assert(false);
    }
    const pure override bool detectCollision(in CollisionDetector cd, in CircleArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2)
    {
        return cd.circle_line(a2, this, pos2, pos1, dir2, dir1, scale2, scale1);
    }
    const pure override bool detectCollision(in CollisionDetector cd, in RectArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2)
    {
        assert(false);
    }
    const pure override bool detectCollision(in CollisionDetector cd, in DoubleCircleArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2)
    {
        assert(false);
    }
    const pure override bool detectCollision(in CollisionDetector cd, in LineArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2)
    {
        assert(false);}
    const pure override bool detectCollision(in CollisionDetector cd, in StickArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2)
    {
        assert(false);
    }
    const pure override bool detectCollision(in CollisionDetector cd, in OvalArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        assert(false);
    }
    /// AndAreaとの当たり判定
    const pure override bool detectCollision(in CollisionDetector cd, in AndArea and,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        foreach(a; and._areaArray){
            if(!this.detectCollision(cd, a, pos1, pos2, dir1, dir2, scale1, scale2)){
                return false;
            }
        }
        return true;
    }
    /// OrAreaとの当たり判定
    const pure override bool detectCollision(in CollisionDetector cd, in OrArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        foreach(a; a2._areaArray){
            if(this.detectCollision(cd, a, pos1, pos2, dir1, dir2, scale1, scale2)){
                return true;
            }
        }
        return false;
    }
    const pure override double innerRadius(){return this._length;}
    const pure override double outerRadius(){return this._length;}
    override bool draw(Drawer drawer, Vector pos, double dir, double scale, Color color){
        bool res1 = drawer.circle(color, (this._start_pos+pos).toIntVector(), cast(int)this._thickness/2, false);
        bool res2 = drawer.circle(color, (this._end_pos(dir)+pos).toIntVector(), cast(int)this._thickness/2, false);
        Vector vec90 = vecdir(this._dir+dir + PI/2, this._thickness/2);
        bool res3 = drawer.line(color, this._start_pos+pos + vec90, this._end_pos(dir)+pos + vec90);
        bool res4 = drawer.line(color, this._start_pos+pos - vec90, this._end_pos(dir)+pos - vec90);
        return res1 && res2;
    }
    /// 始端の位置
    const pure Vector start_pos(){return this._start_pos;}
    /// 終端の位置
    const pure Vector end_pos(){return this._end_pos;}
    /// 線の角度
    const pure double dir(){return this._dir;}
    /// 線の長さ
    const pure double length(){return this._length;}
    /// 線の太さ
    const pure double thickness(){return this._thickness;}
}
/// 線状の範囲 中心が線の中心
class StickArea : Area, Rectangle, DoubleCircle{
private:
    Vector _center_pos;
    double _dir;
    double _length;
    double _thickness;
public:
    this(Vector center_pos, double dir, double length, double thickness){
        this._center_pos = center_pos;
        this._dir       = dir;
        this._length    = length;
        this._thickness = thickness;
    }
    this(double dir, double length, double thickness)
    in{
        assert(isFinite(dir));
        assert(isFinite(length));
        assert(isFinite(thickness));
    }body{
        //this(-vecdir(dir, length/2), dir, length, thickness);
        this(vecpos(0,0), dir, length, thickness);
    }
    const pure Vector _start_pos(double dir=0){return this._center_pos-vecdir(this._dir+dir, this._length/2);}
    const pure Vector _end_pos(double dir=0){return this._center_pos+vecdir(this._dir+dir, this._length/2);}
    const pure override double left()  {return min!(double)(this._start_pos.x, this._end_pos.x);}
    const pure override double right() {return max!(double)(this._start_pos.x, this._end_pos.x);}
    const pure override double top()   {return min!(double)(this._start_pos.y, this._end_pos.y);}
    const pure override double bottom(){return max!(double)(this._start_pos.y, this._end_pos.y);}
    const pure override double width() {return this.right-this.left;}
    const pure override double height(){return this.bottom - this.top;}
    const pure override double cx()    {return this.center.x;}
    const pure override double cy()    {return this.center.y;}
    mixin RectangleVectorTemplate2;
    const pure override Vector center()       {return (this._start_pos + this._end_pos)/2;}


    const pure override bool detectCollision(in CollisionDetector cd, in Area a,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2)
    {
        return a.detectCollision(cd, this, pos2, pos1, dir2, dir1, scale2, scale1);
    }
    const pure override bool detectCollision(in CollisionDetector cd, in PointArea a,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2)
    {
        assert(false);
    }
    const pure override bool detectCollision(in CollisionDetector cd, in CircleArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2)
    {
        return cd.circle_stick(a2, this, pos2, pos1, dir2, dir1, scale2, scale1);
    }
    const pure override bool detectCollision(in CollisionDetector cd, in RectArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2)
    {
        assert(false);
    }
    const pure override bool detectCollision(in CollisionDetector cd, in DoubleCircleArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2)
    {
        assert(false);
    }
    const pure override bool detectCollision(in CollisionDetector cd, in LineArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2)
    {
        assert(false);
    }
    const pure override bool detectCollision(in CollisionDetector cd, in StickArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2)
    {
        assert(false);
    }
    const pure override bool detectCollision(in CollisionDetector cd, in OvalArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        assert(false);
    }
    /// AndAreaとの当たり判定
    const pure override bool detectCollision(in CollisionDetector cd, in AndArea and,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        foreach(a; and._areaArray){
            if(!this.detectCollision(cd, a, pos1, pos2, dir1, dir2, scale1, scale2)){
                return false;
            }
        }
        return true;
    }
    /// OrAreaとの当たり判定
    const pure override bool detectCollision(in CollisionDetector cd, in OrArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        foreach(a; a2._areaArray){
            if(this.detectCollision(cd, a, pos1, pos2, dir1, dir2, scale1, scale2)){
                return true;
            }
        }
        return false;
    }
    const pure override double innerRadius(){return this._length;}
    const pure override double outerRadius(){return this._length;}
    override bool draw(Drawer drawer, Vector pos, double dir, double scale, Color color){
        bool res1 = drawer.circle(color, (this._start_pos(dir)+pos).toIntVector(), cast(int)this._thickness/2, false);
        bool res2 = drawer.circle(color, (this._end_pos(dir)+pos).toIntVector(), cast(int)this._thickness/2, false);
        Vector vec90 = vecdir(this._dir+dir + PI/2, this._thickness/2);
        bool res3 = drawer.line(color, this._start_pos(dir)+pos + vec90, this._end_pos(dir)+pos + vec90);
        bool res4 = drawer.line(color, this._start_pos(dir)+pos - vec90, this._end_pos(dir)+pos - vec90);
        return res1 && res2;
    }
    /// 始端の位置
    const pure Vector start_pos(double dir){return this._start_pos(dir);}
    /// 終端の位置
    const pure Vector end_pos(){return this._end_pos;}
    /// 線の角度
    const pure double dir(){return this._dir;}
    /// 線の長さ
    const pure double length(){return this._length;}
    /// 線の太さ
    const pure double thickness(){return this._thickness;}
}
/// 円弧
class OvalArea : Area, Rectangle, DoubleCircle{
    Vector _center;
    double _innerRadius;
    double _outerRadius;
    double _min_angle;
    double _max_angle;

    this(Vector center, double innerRadius, double outerRadius,
            double min_angle, double max_angle)
    in{
        assert(innerRadius <= outerRadius);
        assert(0 <= innerRadius);
    }body{
        this._center = center;
        this._innerRadius = innerRadius;
        this._outerRadius = outerRadius;
        this._min_angle = min_angle;
        this._max_angle = max_angle;
    }
    this(double innerRadius, double outerRadius,
            double min_angle, double max_angle)
    in{
        assert(innerRadius <= outerRadius);
        assert(0 <= innerRadius);
    }body{
        this(vecpos(0,0), innerRadius, outerRadius, min_angle, max_angle);
    }
    this(double min_angle, double max_angle)
    {
        this(vecpos(0,0), 0, double.infinity, min_angle, max_angle);
    }
    const pure override double left()  {return this._center.x - this._outerRadius;}
    const pure override double right() {return this._center.x + this._outerRadius;}
    const pure override double top()   {return this._center.y - this._outerRadius;}
    const pure override double bottom(){return this._center.y + this._outerRadius;}
    const pure override double width() {return this._outerRadius * 2;}
    const pure override double height(){return this._outerRadius * 2;}
    const pure override double cx()    {return this._center.x;}
    const pure override double cy()    {return this._center.y;}
    mixin RectangleVectorTemplate;


    const pure override bool detectCollision(in CollisionDetector cd, in Area a,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2)
    {
        assert(false);
    }
    const pure override bool detectCollision(in CollisionDetector cd, in PointArea a,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2)
    {
        assert(false);
    }
    const pure override bool detectCollision(in CollisionDetector cd, in CircleArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2)
    {
        assert(false);
    }
    const pure override bool detectCollision(in CollisionDetector cd, in RectArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2)
    {
        assert(false);
    }
    const pure override bool detectCollision(in CollisionDetector cd, in DoubleCircleArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2)
    {
        assert(false);
    }
    const pure override bool detectCollision(in CollisionDetector cd, in LineArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2)
    {
        assert(false);
    }
    const pure override bool detectCollision(in CollisionDetector cd, in StickArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2)
    {
        assert(false);
    }
    const pure override bool detectCollision(in CollisionDetector cd, in OvalArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        assert(false);
    }
    /// AndAreaとの当たり判定
    const pure override bool detectCollision(in CollisionDetector cd, in AndArea and,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        foreach(a; and._areaArray){
            if(!this.detectCollision(cd, a, pos1, pos2, dir1, dir2, scale1, scale2)){
                return false;
            }
        }
        return true;
    }
    /// OrAreaとの当たり判定
    const pure override bool detectCollision(in CollisionDetector cd, in OrArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        foreach(a; a2._areaArray){
            if(this.detectCollision(cd, a, pos1, pos2, dir1, dir2, scale1, scale2)){
                return true;
            }
        }
        return false;
    }
    const pure override double innerRadius(){return this._innerRadius;}
    const pure override double outerRadius(){return this._outerRadius;}
    override bool draw(Drawer drawer, Vector pos, double dir, double scale, Color color){
        bool res1 = drawer.circle(color, (this._center+pos).toIntVector(), cast(int)(this._innerRadius*scale), false);
        bool res2 = drawer.circle(color, (this._center+pos).toIntVector(), cast(int)(this._outerRadius*scale), false);
        return res1 && res2;
    }
}
class AndArea : Area, Rectangle, DoubleCircle{
    Area[] _areaArray;
    this(Area[] areaArray){
        _areaArray = areaArray;
    }
    const pure override bool detectCollision(in CollisionDetector cd, in Area a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        foreach(a1; _areaArray){
            bool res_ = a1.detectCollision(cd, a2, pos1, pos2, dir1, dir2, scale1, scale2);
            if(res_){ continue; }
            else{ return false; }
        }
        return true;
    }
    /// RectAreaとの当たり判定
    const pure override bool detectCollision(in CollisionDetector cd, in RectArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        foreach(a; this._areaArray){
            if(!a.detectCollision(cd, a2, pos1, pos2, dir1, dir2, scale1, scale2)){
                return false;
            }
        }
        return true;
    }
    /// PointAreaとの当たり判定
    const pure override bool detectCollision(in CollisionDetector cd, in PointArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        foreach(a; this._areaArray){
            if(!a.detectCollision(cd, a2, pos1, pos2, dir1, dir2, scale1, scale2)){
                return false;
            }
        }
        return true;
    }
    /// CircleAreaとの当たり判定
    const pure override bool detectCollision(in CollisionDetector cd, in CircleArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        foreach(a; this._areaArray){
            if(!a.detectCollision(cd, a2, pos1, pos2, dir1, dir2, scale1, scale2)){
                return false;
            }
        }
        return true;
    }
    /// DoubleCircleAreaとの当たり判定
    const pure override bool detectCollision(in CollisionDetector cd, in DoubleCircleArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        foreach(a; this._areaArray){
            if(!a.detectCollision(cd, a2, pos1, pos2, dir1, dir2, scale1, scale2)){
                return false;
            }
        }
        return true;
    }
    /// LineAreaとの当たり判定
    const pure override bool detectCollision(in CollisionDetector cd, in LineArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        foreach(a; this._areaArray){
            if(!a.detectCollision(cd, a2, pos1, pos2, dir1, dir2, scale1, scale2)){
                return false;
            }
        }
        return true;
    }
    /// SrickAreaとの当たり判定
    const pure override bool detectCollision(in CollisionDetector cd, in StickArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        foreach(a; this._areaArray){
            if(!a.detectCollision(cd, a2, pos1, pos2, dir1, dir2, scale1, scale2)){
                return false;
            }
        }
        return true;
    }
    /// OvalAreaとの当たり判定
    const pure override bool detectCollision(in CollisionDetector cd, in OvalArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        foreach(a; this._areaArray){
            if(!a.detectCollision(cd, a2, pos1, pos2, dir1, dir2, scale1, scale2)){
                return false;
            }
        }
        return true;
    }
    /// AndAreaとの当たり判定
    const pure override bool detectCollision(in CollisionDetector cd, in AndArea and,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        foreach(a; and._areaArray){
            if(!this.detectCollision(cd, a, pos1, pos2, dir1, dir2, scale1, scale2)){
                return false;
            }
        }
        return true;
    }
    /// OrAreaとの当たり判定
    const pure override bool detectCollision(in CollisionDetector cd, in OrArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        foreach(a; a2._areaArray){
            if(this.detectCollision(cd, a, pos1, pos2, dir1, dir2, scale1, scale2)){
                return true;
            }
        }
        return false;
    }
    /// 描画
    override bool draw(Drawer drawer, Vector pos, double dir, double scale, Color color){
        bool res = true;
        foreach(a; this._areaArray){
            res = res && a.draw(drawer, pos, dir, scale, color);
        }
        return res;
    }
    const pure override double left(){return double.nan;}
    const pure override double right(){return double.nan;}
    const pure override double top(){return double.nan;}
    const pure override double bottom(){return double.nan;}
    const pure override double width(){return double.nan;}
    const pure override double height(){return double.nan;}
    const pure override double cx(){return double.nan;}
    const pure override double cy(){return double.nan;}
    mixin RectangleVectorTemplate;
    const pure override double innerRadius(){return double.nan;}
    const pure override double outerRadius(){return double.nan;}
}

class OrArea : Area, Rectangle, DoubleCircle{
    Area[] _areaArray;
    this(Area[] areaArray){
        _areaArray = areaArray;
    }
    const pure override double left(){return double.nan;}
    const pure override double right(){return double.nan;}
    const pure override double top(){return double.nan;}
    const pure override double bottom(){return double.nan;}
    const pure override double width(){return double.nan;}
    const pure override double height(){return double.nan;}
    const pure override double cx(){return double.nan;}
    const pure override double cy(){return double.nan;}
    mixin RectangleVectorTemplate;
    const pure override double innerRadius(){return double.nan;}
    const pure override double outerRadius(){return double.nan;}
    const pure override bool detectCollision(in CollisionDetector cd, in Area a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        foreach(a; this._areaArray){
            if(a.detectCollision(cd, a2, pos1, pos2, dir1, dir2, scale1, scale2)){
                return true;
            }
        }
        return false;
    }
    /// RectAreaとの当たり判定
    const pure override bool detectCollision(in CollisionDetector cd, in RectArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        foreach(a; this._areaArray){
            if(a.detectCollision(cd, a2, pos1, pos2, dir1, dir2, scale1, scale2)){
                return true;
            }
        }
        return false;
    }
    /// PointAreaとの当たり判定
    const pure override bool detectCollision(in CollisionDetector cd, in PointArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        foreach(a; this._areaArray){
            if(a.detectCollision(cd, a2, pos1, pos2, dir1, dir2, scale1, scale2)){
                return true;
            }
        }
        return false;
    }
    /// CircleAreaとの当たり判定
    const pure override bool detectCollision(in CollisionDetector cd, in CircleArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        foreach(a; this._areaArray){
            if(a.detectCollision(cd, a2, pos1, pos2, dir1, dir2, scale1, scale2)){
                return true;
            }
        }
        return false;
    }
    /// DoubleCircleAreaとの当たり判定
    const pure override bool detectCollision(in CollisionDetector cd, in DoubleCircleArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        foreach(a; this._areaArray){
            if(a.detectCollision(cd, a2, pos1, pos2, dir1, dir2, scale1, scale2)){
                return true;
            }
        }
        return false;
    }
    /// LineAreaとの当たり判定
    const pure override bool detectCollision(in CollisionDetector cd, in LineArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        foreach(a; this._areaArray){
            if(a.detectCollision(cd, a2, pos1, pos2, dir1, dir2, scale1, scale2)){
                return true;
            }
        }
        return false;
    }
    /// SrickAreaとの当たり判定
    const pure override bool detectCollision(in CollisionDetector cd, in StickArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        foreach(a; this._areaArray){
            if(a.detectCollision(cd, a2, pos1, pos2, dir1, dir2, scale1, scale2)){
                return true;
            }
        }
        return false;
    }
    /// OvalAreaとの当たり判定
    const pure override bool detectCollision(in CollisionDetector cd, in OvalArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        foreach(a; this._areaArray){
            if(a.detectCollision(cd, a2, pos1, pos2, dir1, dir2, scale1, scale2)){
                return true;
            }
        }
        return false;
    }
    /// AndAreaとの当たり判定
    const pure override bool detectCollision(in CollisionDetector cd, in AndArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        foreach(a; this._areaArray){
            if(a.detectCollision(cd, a2, pos1, pos2, dir1, dir2, scale1, scale2)){
                return true;
            }
        }
        return false;
    }
    /// OrAreaとの当たり判定
    const pure override bool detectCollision(in CollisionDetector cd, in OrArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2){
        foreach(a; this._areaArray){
            if(a.detectCollision(cd, a2, pos1, pos2, dir1, dir2, scale1, scale2)){
                return true;
            }
        }
        return false;
    }
}


