module mylib.primitives;

import std.math;
import std.conv;
import std.stdio;
import mylib.vector2d;


public:
/// ポジション
/// x軸とy軸を持ったやつ
interface Position{
    @property const pure abstract double x();
    @property const pure abstract double y();
    @property const pure abstract Vector2d pos();
}
/// Mixin用
template PositionReadTemplate(){
    private Vector2d _pos;
    public{
        @property const pure override double x(){return this.pos.x;}
        @property const pure override double y(){return this.pos.y;}
        @property const pure override Vector2d pos(){return this._pos;}
    }
}
/// Mixin用
template PositionReadWriteTemplate(){
    private Vector2d _pos;
    public{
        @property const pure override double x(){return this.pos.x;}
        @property const pure override double y(){return this.pos.y;}
        @property const pure override Vector2d pos(){return this._pos;}
        @property void pos(in Vector2d val){this._pos = val;}
        @property void x(in double val){_pos.x = val;}
        @property void y(in double val){_pos.y = val;}
    }
}
/// 長方形
/// 上下左右の位置を返すような図形
interface Rectangle{
    @property const pure abstract double left();             /// 左
    @property const pure abstract double right();            /// 右
    @property const pure abstract double top();              /// 上
    @property const pure abstract double bottom();           /// 下
    @property const pure abstract double width();            /// 幅(right - left)
    @property const pure abstract double height();           /// 高さ(bottom - top)
    @property const pure abstract double cx();               /// 中心x座標((left + right)/2)
    @property const pure abstract double cy();               /// 中心y座標((top + bottom)/2)
    @property const pure abstract Vector2d top_left();         /// 左上
    @property const pure abstract Vector2d center_left();      /// 中央左
    @property const pure abstract Vector2d bottom_left();      /// 左下
    @property const pure abstract Vector2d top_right();        /// 右上
    @property const pure abstract Vector2d center_right();     /// 中央右
    @property const pure abstract Vector2d bottom_right();     /// 右下
    @property const pure abstract Vector2d top_center();       /// 中央上
    @property const pure abstract Vector2d center();           /// 中央
    @property const pure abstract Vector2d bottom_center();    /// 中央下
}
///
template RectangleRBTemplate(){
    @property const pure override double right() {return this.left+this.width;}
    @property const pure override double bottom(){return this.top+this.height;}
}
template RectangleWHTemplate(){
    @property const pure override double width()
    out(res){
        assert(res>=0);
    }body{
        return this.right - this.left;
    }

    @property const pure override double height()
    out(res){
        assert(res>=0);
    }body{
        return this.bottom - this.top;
    }
}
///
template RectangleCxCyByLTWHTemplate(){
    @property const pure override double cx() {return this.left+this.width/2;}
    @property const pure override double cy() {return this.top+this.height/2;}
}
///
template RectangleCxCyByLRTBTemplate(){
    @property const pure override double cx() {return (this.left+this.right)/2;}
    @property const pure override double cy() {return (this.top+this.bottom)/2;}
}
///
template RectangleVectorTemplate(){
    /// 左上
    @property const pure override Vector2d top_left()     {return vecpos(this.left,  this.top   );}
    /// 左
    @property const pure override Vector2d center_left()  {return vecpos(this.left,  this.cy    );}
    /// 左下
    @property const pure override Vector2d bottom_left()  {return vecpos(this.left,  this.bottom);}
    /// 上
    @property const pure override Vector2d top_center()   {return vecpos(this.cx,    this.top   );}
    /// 中心
    @property const pure override Vector2d center()       {return vecpos(this.cx,    this.cy    );}
    /// 下
    @property const pure override Vector2d bottom_center(){return vecpos(this.cx,    this.bottom);}
    /// 右上
    @property const pure override Vector2d top_right()    {return vecpos(this.right, this.top   );}
    /// 右
    @property const pure override Vector2d center_right() {return vecpos(this.right, this.cy    );}
    /// 右下
    @property const pure override Vector2d bottom_right() {return vecpos(this.right, this.bottom);}
}
template RectangleVectorTemplate2(){
    @property const pure override Vector2d top_left()     {return vecpos(this.left,  this.top   );}
    @property const pure override Vector2d center_left()  {return vecpos(this.left,  this.cy    );}
    @property const pure override Vector2d bottom_left()  {return vecpos(this.left,  this.bottom);}
    @property const pure override Vector2d top_right()    {return vecpos(this.right, this.top   );}
    @property const pure override Vector2d center_right() {return vecpos(this.right, this.cy    );}
    @property const pure override Vector2d bottom_right() {return vecpos(this.right, this.bottom);}
    @property const pure override Vector2d top_center()   {return vecpos(this.cx,    this.top   );}
    @property const pure override Vector2d bottom_center(){return vecpos(this.cx,    this.bottom);}
}
/// 円
/// 中心座標と半径
interface Circle : Rectangle{
    @property const pure abstract Vector2d center();
    @property const pure abstract int radius();
}
/// 円
/// 中心座標と内側の半径と外側の半径
/// 四角形なんかで使う
/// innerRadius = outerRadius で普通の円
interface DoubleCircle : Rectangle{
    @property const pure abstract Vector2d center();           /// 中心
    @property const pure abstract double innerRadius();     /// 内側の円の半径
    @property const pure abstract double outerRadius();     /// 外側の円の半径
}
/// 方向を持ったもの
interface Direction{
    @property const pure abstract double dir();  /// 方向 ラジアン
}

