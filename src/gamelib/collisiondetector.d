module gamelib.collisiondetector;

import gamelib.all;
import mylib.utils;
import std.stdio;
import std.conv;
import std.math;

/// 当たり判定するクラス
class CollisionDetector{
    this(){}
protected:
    /// point to point
    const pure bool detectVectorToVector(in Vector vec1, in Vector vec2, in Vector pos1, in Vector pos2){
        return (vec1.x+pos1.x==vec2.x+pos2.x)
            && (vec1.y+pos1.y==vec2.y+pos2.y);
    }
    /// point to circle
    const pure bool detectVectorToCircle(in Vector vec, in DoubleCircle cir, in Vector pos1, in Vector pos2)
    in{
        assert(cir.innerRadius == cir.outerRadius);
    }body{
        double p2p2 = ((vec+pos1) - (cir.center+pos2)).length2;
        return p2p2 < cir.innerRadius*cir.innerRadius;
    }
    /// point to double circle
    const pure bool detectVectorToDoubleCircle(in Vector vec, in DoubleCircle cir, in Vector pos1, in Vector pos2)
    in{
        assert(false);
    }body{
        return true;
    }
        /+
    bool vector_rect(Vector vec, Rectangle rect, Vector pos1, Vector pos2){
        return (rect.left <= vec.x && vec.x <= rect.right)
            && (rect.top  <= vec.y && vec.y <= rect.bottom);
        +/
    /// circle to circle
    const pure bool detectCircleToCircle(in DoubleCircle cir1, in DoubleCircle cir2, in Vector pos1, in Vector pos2)
    in{
        assert(cir1.innerRadius == cir1.outerRadius);
        assert(cir2.innerRadius == cir2.outerRadius);
    }body{
        double p2p2 = ((cir1.center+pos1) - (cir2.center+pos2)).length2;
        double rad2 = (cir1.innerRadius + cir2.innerRadius)
                     *(cir1.innerRadius + cir2.innerRadius);
        return p2p2 <= rad2;
    }
    /// circle to circle
    const pure bool detectCircleToCircle(in double c1x, in double c1y, in double c1r,
            in double c2x, in double c2y, in double c2r, in Vector pos1, in Vector pos2)
    in{
        assert(c1r >= 0);
        assert(c2r >= 0);
    }body{
        Vector c1c = vecpos(c1x,c1y);
        Vector c2c = vecpos(c2x,c2y);
        double p2p2 = ((c1c+pos1) - (c2c+pos2)).length2;
        double rad2 = (c1r + c2r) * (c1r + c2r);
        return p2p2 <= rad2;
    }
    /// circle to double circle
    const pure bool detectCircleToDoubleCircle(in DoubleCircle cir1, in DoubleCircle cir2, in Vector pos1, in Vector pos2, in double scale1, in double scale2)
    in{
        assert(cir1.innerRadius == cir1.outerRadius);
    }body{
        double p2p = ((cir1.center+pos1) - (cir2.center+pos2)).length;
        if(p2p+cir1.innerRadius <= cir2.innerRadius*scale2){return false;}
        if(p2p-cir1.innerRadius >= cir2.outerRadius*scale2){return false;}
        return true;
    }
    /// double circle to double circle
    const pure bool detectDoubleCircleToDoubleCircle(in DoubleCircle cir1, in DoubleCircle cir2, in Vector pos1, in Vector pos2)
    in{assert(false);}body{
        return false;
    }
    const pure bool detectRectToRect(in Rectangle rect1, in Rectangle rect2, in Vector pos1, in Vector pos2){
        bool cond_x = rect1.left+pos1.x <= rect2.right+pos2.x
            && rect2.left+pos2.x <= rect1.right+pos1.x;
        bool cond_y = rect1.top+pos1.y <= rect2.bottom+pos2.y
            && rect2.top+pos2.y <= rect1.bottom+pos1.y;
        return cond_x && cond_y;
    }
    /// circle to rect
    const pure bool detectCircleToRect(in DoubleCircle cir, in Rectangle rct, in Vector pos1, in Vector pos2)
    in{
        assert(cir.innerRadius == cir.outerRadius);
    }body{
        bool res1 = detectRectToRect(cir, rct, pos1, pos2);
        if(!res1){return false;}
        bool res2 = detectCircleToCircle(cir.cx, cir.cy, cir.innerRadius,
                rct.cx, rct.cy, max(rct.width, rct.height), pos1, pos2);
        if(res2){return true;}
        return false;
    }
    /// point to rect
    const pure bool detectVectorToRect(in Vector vec, in Rectangle rect, in Vector posv, in Vector posr){
        return rect.left+posr.x <= vec.x+posv.x && vec.x+posv.x <= rect.right+posr.x 
            && rect.top+posr.y  <= vec.y+posv.y && vec.y+posv.y <= rect.bottom+posr.y;
    }
    /// point to rect
    const pure bool detectVectorToRect(IntVector vec, Rectangle rect, Vector posv, Vector posr){
        return rect.left+posr.x <= vec.x+posv.x && vec.x+posv.x <= rect.right+posr.x 
            && rect.top+posr.y  <= vec.y+posv.y && vec.y+posv.y <= rect.bottom+posr.y;
    }
    /// point to line
    const pure bool detectVectorToLine(in Vector vec, in Vector l_start, in double l_dir, in double l_length,
            in double l_thickness, in Vector posv, in Vector posl)
    in{
        assert(isFinite(l_dir));
        assert(isFinite(l_length));
        assert(isFinite(l_thickness));
    }body{
        // 両端から近いとき
        Vector l_end = l_start + vecdir(l_dir, l_length);
        double p2s = ((vec+posv)-(l_start+posl)).length2;
        if(p2s < l_thickness/2*l_thickness/2){return true;}
        double p2e = ((vec+posv)-(l_end  +posl)).length2;
        if(p2e < l_thickness/2*l_thickness/2){return true;}
        // 点と線の距離を考慮
        double inner1 = (l_end - l_start).inner(vec - l_start);
        double inner2 = (l_start - l_end).inner(vec - l_end);
        if(inner1 < 0 || inner2 < 0){return false;}

        double dist2 = gamelib.utils.distance2PosToLine(vec+posv, l_start+posl, l_dir);
        if(dist2 < l_thickness/2*l_thickness/2){return true;}

        // それ以外
        return false;
    }
    /// circle to line
    const pure bool detectCircleToLine(in DoubleCircle cir, in Vector l_start, in double l_dir, in double l_length,
            in double l_thickness, in Vector posv, in Vector posl)
    in{
        assert(isFinite(l_dir));
        assert(isFinite(l_length));
        assert(isFinite(l_thickness));
    }body{
        // 両端から近いとき
        Vector l_end = l_start + vecdir(l_dir, l_length);
        double l = (cir.outerRadius+l_thickness/2);
        double p2s = ((cir.center+posv)-(l_start+posl)).length2;
        if(p2s < l*l){return true;}
        double p2e = ((cir.center+posv)-(l_end  +posl)).length2;
        if(p2e < l*l){return true;}
        // 点と線の距離を考慮
        double inner1 = (l_end - l_start).inner((cir.center+posv) - (l_start+posl));
        double inner2 = (l_start - l_end).inner((cir.center+posv) - (l_end  +posl));
        if(inner1 < 0 || inner2 < 0){return false;}
        double dist2 = gamelib.utils.distance2PosToLine(
                cir.center+posv, l_start+posl, l_dir);
        assert(dist2>=0);
        if(dist2 < l*l){return true;}

        // それ以外
        return false;
    }

public:
    ///detect mover to mover
    const pure bool detect(in Mover m1, in Mover m2)
    in{
        assert(m1 !is null);
        assert(m2 !is null);
    }body{
        return m1.detectCollision(this, m2);
    }
    /// detect area to area
    const pure bool detect(in Area a1, in Area a2, in Vector pos1, in Vector pos2,
            in double dir1, in double dir2, in double scale1, in double scale2)
    in{
        assert(a1 !is null);
        assert(a2 !is null);
    }body{
        return a1.detectCollision(this, a2, pos1, pos2, dir1, dir2, scale1, scale2);
    }
    /// detect area to area
    const pure bool detect(in Area a1, in Area a2, in Vector pos1, in Vector pos2)
    in{
        assert(a1 !is null);
        assert(a2 !is null);
    }body{
        return a1.detectCollision(this, a2, pos1, pos2, 0,0,0,0);
    }
    /// detect pointarea to pointarea
    const pure bool point_point(in PointArea a1, in PointArea a2, in Vector pos1, in Vector pos2,
            in double dir1, in double dir2, in double scale1, in double scale2)
    in{
        assert(a1 !is null);
        assert(a2 !is null);
    }body{
        return detectVectorToVector(a1.center, a2.center, pos1, pos2);
    }
    /// detect pointarea to rectarea
    const pure bool point_rect(in PointArea a1, in RectArea a2, in Vector pos1, in Vector pos2,
            in double dir1, in double dir2, in double scale1, in double scale2)
    in{
        assert(a1 !is null);
        assert(a2 !is null);
    }body{
        return detectVectorToRect(a1.center, a2, pos1, pos2);
    }
    /// detect pointarea to circlearea
    const pure bool point_circle(in PointArea a1, in CircleArea a2, in Vector pos1, in Vector pos2,
            in double dir1, in double dir2, in double scale1, in double scale2)
    in{
        assert(a1 !is null);
        assert(a2 !is null);
    }body{
        return detectVectorToCircle(a1.center, a2, pos1, pos2);
    }
    /// detect pointarea to doublecirclearea
    const pure bool point_doublecircle(in PointArea a1, in DoubleCircleArea a2, in Vector pos1, in Vector pos2,
            in double dir1, in double dir2, in double scale1, in double scale2)
    in{
        assert(a1 !is null);
        assert(a2 !is null);
    }body{
        return detectVectorToDoubleCircle(a1.center, a2, pos1, pos2);
    }
    /// detect circlearea to circlearea
    const pure bool circle_circle(in CircleArea a1, in CircleArea a2, in Vector pos1, in Vector pos2,
            in double dir1, in double dir2, in double scale1, in double scale2)
    in{
        assert(a1 !is null);
        assert(a2 !is null);
    }body{
        return detectCircleToCircle(a1, a2, pos1, pos2);
    }
    /// detect circlearea to doublecirclearea
    const pure bool circle_doublecircle(in CircleArea a1, in DoubleCircleArea a2, in Vector pos1, in Vector pos2,
            in double dir1, in double dir2, in double scale1, in double scale2)
    in{
        assert(a1 !is null);
        assert(a2 !is null);
    }body{
        return detectCircleToDoubleCircle(a1, a2, pos1, pos2, scale1, scale2);
    }
    /// detect circlearea to rectarea
    const pure bool circle_rect(in CircleArea a1, in RectArea a2, in Vector pos1, in Vector pos2,
            in double dir1, in double dir2, in double scale1, in double scale2)
    in{
        assert(a1 !is null);
        assert(a2 !is null);
    }body{
        return detectRectToRect(a1, a2, pos1, pos2);
    }
    /// detect doublecirclearea to doublecirclearea
    const pure bool doublecircle_doublecircle(in DoubleCircleArea a1, in DoubleCircleArea a2,
            in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2)
    in{
        assert(a1 !is null);
        assert(a2 !is null);
    }body{
        return detectDoubleCircleToDoubleCircle(a1, a2, pos1, pos2);
    }
    /// detect doublecirclearea to rectarea
    const pure bool doublecircle_rect(in DoubleCircleArea a1, in RectArea a2, in Vector pos1, in Vector pos2,
            in double dir1, in double dir2, in double scale1, in double scale2)
    in{
        assert(a1 !is null);
        assert(a2 !is null);
    }body{
        return detectRectToRect(a1, a2, pos1, pos2);
    }
    /// detect rectearea to rectarea
    const pure bool rect_rect(in RectArea a1, in RectArea a2, in Vector pos1, in Vector pos2,
            in double dir1, in double dir2, in double scale1, in double scale2)
    in{
        assert(a1 !is null);
        assert(a2 !is null);
    }body{
        return detectRectToRect(a1, a2, pos1, pos2);
    }
    /// detect circlearea to linearea
    const pure bool circle_line(in CircleArea a1, in LineArea a2, in Vector pos1, in Vector pos2,
            in double dir1, in double dir2, in double scale1, in double scale2)
    in{
        assert(a1 !is null);
        assert(a2 !is null);
        assert(isFinite(dir2));
    }body{
        return detectCircleToLine(a1, a2.start_pos, a2.dir+dir2, a2.length,
                a2.thickness, pos1, pos2);
    }
    /// detect circlearea to stickarea
    const pure bool circle_stick(in CircleArea a1, in StickArea a2, in Vector pos1, in Vector pos2,
            in double dir1, in double dir2, in double scale1, in double scale2)
    in{
        assert(a1 !is null);
        assert(a2 !is null);
        assert(isFinite(dir2));
    }body{
        return detectCircleToLine(a1, a2.start_pos(dir2), a2.dir+dir2, a2.length,
                a2.thickness, pos1, pos2);
    }
    /// detect map to area
    const bool map_area(FmfMapLayer map, uint val, Area area,
            Vector pos1 = vecpos(0,0), Vector pos2 = vecpos(0,0),
            double dir1 = 0, double dir2 = 0, double scale1 = 1, double scale2 = 1){
        assert(false);
    }
    /// detect map to rect
    const bool mapRect(in FmfMapLayer map, in uint val, in Rectangle rct,
            in Vector pos1 = vecpos(0,0), in Vector pos2 = vecpos(0,0),
            in double dir1 = 0, in double dir2 = 0, in double scale1 = 1, in double scale2 = 1){
        //assert(rct !is null);
        //assert(map !is null);
        int l = cast(int)floor((rct.left   + pos2.x - pos1.x) / map.chipWidth);
        int r = cast(int)floor((rct.right  + pos2.x - pos1.x) / map.chipWidth);
        int t = cast(int)floor((rct.top    + pos2.y - pos1.y) / map.chipHeight);
        int b = cast(int)floor((rct.bottom + pos2.y - pos1.y) / map.chipHeight);
        assert(l<=r, to!(string)(l) ~ " <= " ~ to!(string)(r));
        assert(t<=b, to!(string)(t) ~ " <= " ~ to!(string)(b));
        for(int iy = t; iy<= b; iy++){
            for(int ix = l; ix<= r; ix++){
                if(map.chip(ix,iy) == val){return true;}
            }
        }
        return false;
    }
    /// detect map to rect
    const bool mapRect(in FmfMapLayer map, in uint[] vals, in Rectangle rct,
            in Vector pos1 = vecpos(0,0), in Vector pos2 = vecpos(0,0),
            in double dir1 = 0, in double dir2 = 0, in double scale1 = 1, in double scale2 = 1){
        foreach(v; vals){
            if(mapRect(map, v, rct, pos1, pos2, dir1, dir2, scale1, scale2)){
                return true;
            }
        }
        return false;
    }
    /// detect map to rect
    const bool mapRect(in FmfMapLayer map, ChipId[] vals, in Rectangle rct,
            in Vector pos1 = vecpos(0,0), in Vector pos2 = vecpos(0,0),
            in double dir1 = 0, in double dir2 = 0, in double scale1 = 1, in double scale2 = 1){
        foreach(v; vals){
            if(this.mapRect(map, cast(uint)v, rct, pos1, pos2, dir1, dir2, scale1, scale2)){
                return true;
            }
        }
        return false;
    }
    /// detect map to rect
    const bool mapRect(FmfMapLayer map, bool delegate(uint) valfun, RectArea rct,
            Vector pos1 = vecpos(0,0), Vector pos2 = vecpos(0,0),
            double dir1 = 0, double dir2 = 0, double scale1 = 1, double scale2 = 1){
        int l = cast(int)floor((rct.left   + pos2.x - pos1.x) / map.chipWidth);
        int r = cast(int)floor((rct.right  + pos2.x - pos1.x) / map.chipWidth);
        int t = cast(int)floor((rct.top    + pos2.y - pos1.y) / map.chipHeight);
        int b = cast(int)floor((rct.bottom + pos2.y - pos1.y) / map.chipHeight);
        assert(l<=r);
        assert(t<=b);
        for(int iy = t; iy<= b; iy++){
            for(int ix = l; ix<= r; ix++){
                if(valfun(map.chip(ix,iy))){return true;}
            }
        }
        return false;
    }
}

