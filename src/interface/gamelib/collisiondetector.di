// D import file generated from 'gamelib\collisiondetector.d'
module gamelib.collisiondetector;
import gamelib.all;
import mylib.utils;
import std.stdio;
import std.conv;
import std.math;
class CollisionDetector
{
    this()
{
}
    protected 
{
    const pure bool detectVectorToVector(in Vector vec1, in Vector vec2, in Vector pos1, in Vector pos2)
{
return vec1.x + pos1.x == vec2.x + pos2.x && vec1.y + pos1.y == vec2.y + pos2.y;
}

    const pure bool detectVectorToCircle(in Vector vec, in DoubleCircle cir, in Vector pos1, in Vector pos2)
in
{
assert(cir.innerRadius == cir.outerRadius);
}
body
{
double p2p2 = (vec + pos1 - (cir.center + pos2)).length2;
return p2p2 < cir.innerRadius * cir.innerRadius;
}

    const pure bool detectVectorToDoubleCircle(in Vector vec, in DoubleCircle cir, in Vector pos1, in Vector pos2)
in
{
assert(false);
}
body
{
return true;
}

    const pure bool detectCircleToCircle(in DoubleCircle cir1, in DoubleCircle cir2, in Vector pos1, in Vector pos2)
in
{
assert(cir1.innerRadius == cir1.outerRadius);
assert(cir2.innerRadius == cir2.outerRadius);
}
body
{
double p2p2 = (cir1.center + pos1 - (cir2.center + pos2)).length2;
double rad2 = (cir1.innerRadius + cir2.innerRadius) * (cir1.innerRadius + cir2.innerRadius);
return p2p2 <= rad2;
}

    const pure bool detectCircleToCircle(in double c1x, in double c1y, in double c1r, in double c2x, in double c2y, in double c2r, in Vector pos1, in Vector pos2)
in
{
assert(c1r >= 0);
assert(c2r >= 0);
}
body
{
Vector c1c = vecpos(c1x,c1y);
Vector c2c = vecpos(c2x,c2y);
double p2p2 = (c1c + pos1 - (c2c + pos2)).length2;
double rad2 = (c1r + c2r) * (c1r + c2r);
return p2p2 <= rad2;
}

    const pure bool detectCircleToDoubleCircle(in DoubleCircle cir1, in DoubleCircle cir2, in Vector pos1, in Vector pos2, in double scale1, in double scale2);

    const pure bool detectDoubleCircleToDoubleCircle(in DoubleCircle cir1, in DoubleCircle cir2, in Vector pos1, in Vector pos2)
in
{
assert(false);
}
body
{
return false;
}

    const pure bool detectRectToRect(in Rectangle rect1, in Rectangle rect2, in Vector pos1, in Vector pos2)
{
bool cond_x = rect1.left + pos1.x <= rect2.right + pos2.x && rect2.left + pos2.x <= rect1.right + pos1.x;
bool cond_y = rect1.top + pos1.y <= rect2.bottom + pos2.y && rect2.top + pos2.y <= rect1.bottom + pos1.y;
return cond_x && cond_y;
}

    const pure bool detectCircleToRect(in DoubleCircle cir, in Rectangle rct, in Vector pos1, in Vector pos2);

    const pure bool detectVectorToRect(in Vector vec, in Rectangle rect, in Vector posv, in Vector posr)
{
return rect.left + posr.x <= vec.x + posv.x && vec.x + posv.x <= rect.right + posr.x && rect.top + posr.y <= vec.y + posv.y && vec.y + posv.y <= rect.bottom + posr.y;
}

    const pure bool detectVectorToRect(IntVector vec, Rectangle rect, Vector posv, Vector posr)
{
return rect.left + posr.x <= vec.x + posv.x && vec.x + posv.x <= rect.right + posr.x && rect.top + posr.y <= vec.y + posv.y && vec.y + posv.y <= rect.bottom + posr.y;
}

    const pure bool detectVectorToLine(in Vector vec, in Vector l_start, in double l_dir, in double l_length, in double l_thickness, in Vector posv, in Vector posl);

    const pure bool detectCircleToLine(in DoubleCircle cir, in Vector l_start, in double l_dir, in double l_length, in double l_thickness, in Vector posv, in Vector posl);

    public 
{
    const pure bool detect(in Mover m1, in Mover m2)
in
{
assert(m1 !is null);
assert(m2 !is null);
}
body
{
return m1.detectCollision(this,m2);
}

    const pure bool detect(in Area a1, in Area a2, in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2)
in
{
assert(a1 !is null);
assert(a2 !is null);
}
body
{
return a1.detectCollision(this,a2,pos1,pos2,dir1,dir2,scale1,scale2);
}

    const pure bool detect(in Area a1, in Area a2, in Vector pos1, in Vector pos2)
in
{
assert(a1 !is null);
assert(a2 !is null);
}
body
{
return a1.detectCollision(this,a2,pos1,pos2,0,0,0,0);
}

    const pure bool point_point(in PointArea a1, in PointArea a2, in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2)
in
{
assert(a1 !is null);
assert(a2 !is null);
}
body
{
return detectVectorToVector(a1.center,a2.center,pos1,pos2);
}

    const pure bool point_rect(in PointArea a1, in RectArea a2, in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2)
in
{
assert(a1 !is null);
assert(a2 !is null);
}
body
{
return detectVectorToRect(a1.center,a2,pos1,pos2);
}

    const pure bool point_circle(in PointArea a1, in CircleArea a2, in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2)
in
{
assert(a1 !is null);
assert(a2 !is null);
}
body
{
return detectVectorToCircle(a1.center,a2,pos1,pos2);
}

    const pure bool point_doublecircle(in PointArea a1, in DoubleCircleArea a2, in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2)
in
{
assert(a1 !is null);
assert(a2 !is null);
}
body
{
return detectVectorToDoubleCircle(a1.center,a2,pos1,pos2);
}

    const pure bool circle_circle(in CircleArea a1, in CircleArea a2, in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2)
in
{
assert(a1 !is null);
assert(a2 !is null);
}
body
{
return detectCircleToCircle(a1,a2,pos1,pos2);
}

    const pure bool circle_doublecircle(in CircleArea a1, in DoubleCircleArea a2, in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2)
in
{
assert(a1 !is null);
assert(a2 !is null);
}
body
{
return detectCircleToDoubleCircle(a1,a2,pos1,pos2,scale1,scale2);
}

    const pure bool circle_rect(in CircleArea a1, in RectArea a2, in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2)
in
{
assert(a1 !is null);
assert(a2 !is null);
}
body
{
return detectRectToRect(a1,a2,pos1,pos2);
}

    const pure bool doublecircle_doublecircle(in DoubleCircleArea a1, in DoubleCircleArea a2, in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2)
in
{
assert(a1 !is null);
assert(a2 !is null);
}
body
{
return detectDoubleCircleToDoubleCircle(a1,a2,pos1,pos2);
}

    const pure bool doublecircle_rect(in DoubleCircleArea a1, in RectArea a2, in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2)
in
{
assert(a1 !is null);
assert(a2 !is null);
}
body
{
return detectRectToRect(a1,a2,pos1,pos2);
}

    const pure bool rect_rect(in RectArea a1, in RectArea a2, in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2)
in
{
assert(a1 !is null);
assert(a2 !is null);
}
body
{
return detectRectToRect(a1,a2,pos1,pos2);
}

    const pure bool circle_line(in CircleArea a1, in LineArea a2, in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2)
in
{
assert(a1 !is null);
assert(a2 !is null);
assert(isFinite(dir2));
}
body
{
return detectCircleToLine(a1,a2.start_pos,a2.dir + dir2,a2.length,a2.thickness,pos1,pos2);
}

    const pure bool circle_stick(in CircleArea a1, in StickArea a2, in Vector pos1, in Vector pos2, in double dir1, in double dir2, in double scale1, in double scale2)
in
{
assert(a1 !is null);
assert(a2 !is null);
assert(isFinite(dir2));
}
body
{
return detectCircleToLine(a1,a2.start_pos(dir2),a2.dir + dir2,a2.length,a2.thickness,pos1,pos2);
}

    const bool map_area(FmfMapLayer map, uint val, Area area, Vector pos1 = vecpos(0,0), Vector pos2 = vecpos(0,0), double dir1 = 0, double dir2 = 0, double scale1 = 1, double scale2 = 1)
{
assert(false);
}

    const bool mapRect(in FmfMapLayer map, in uint val, in Rectangle rct, in Vector pos1 = vecpos(0,0), in Vector pos2 = vecpos(0,0), in double dir1 = 0, in double dir2 = 0, in double scale1 = 1, in double scale2 = 1);

    const bool mapRect(in FmfMapLayer map, in uint[] vals, in Rectangle rct, in Vector pos1 = vecpos(0,0), in Vector pos2 = vecpos(0,0), in double dir1 = 0, in double dir2 = 0, in double scale1 = 1, in double scale2 = 1);

    const bool mapRect(in FmfMapLayer map, ChipId[] vals, in Rectangle rct, in Vector pos1 = vecpos(0,0), in Vector pos2 = vecpos(0,0), in double dir1 = 0, in double dir2 = 0, in double scale1 = 1, in double scale2 = 1);

    const bool mapRect(FmfMapLayer map, bool delegate(uint) valfun, RectArea rct, Vector pos1 = vecpos(0,0), Vector pos2 = vecpos(0,0), double dir1 = 0, double dir2 = 0, double scale1 = 1, double scale2 = 1);

}
}
}
