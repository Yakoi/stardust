// D import file generated from 'mylib\primitives.d'
module mylib.primitives;
import std.math;
import std.conv;
import std.stdio;
import mylib.vector2d;
public 
{
    interface Position
{
    const abstract pure @property double x();

    const abstract pure @property double y();

    const abstract pure @property Vector2d pos();

}
    template PositionReadTemplate()
{
private Vector2d _pos;

public 
{
    const override pure @property double x()
{
return this.pos.x;
}

    const override pure @property double y()
{
return this.pos.y;
}

    const override pure @property Vector2d pos()
{
return this._pos;
}

}
}
    template PositionReadWriteTemplate()
{
private Vector2d _pos;

public 
{
    const override pure @property double x()
{
return this.pos.x;
}

    const override pure @property double y()
{
return this.pos.y;
}

    const override pure @property Vector2d pos()
{
return this._pos;
}

    @property void pos(in Vector2d val)
{
this._pos = val;
}

    @property void x(in double val)
{
_pos.x = val;
}

    @property void y(in double val)
{
_pos.y = val;
}

}
}
    interface Rectangle
{
    const abstract pure @property double left();

    const abstract pure @property double right();

    const abstract pure @property double top();

    const abstract pure @property double bottom();

    const abstract pure @property double width();

    const abstract pure @property double height();

    const abstract pure @property double cx();

    const abstract pure @property double cy();

    const abstract pure @property Vector2d top_left();

    const abstract pure @property Vector2d center_left();

    const abstract pure @property Vector2d bottom_left();

    const abstract pure @property Vector2d top_right();

    const abstract pure @property Vector2d center_right();

    const abstract pure @property Vector2d bottom_right();

    const abstract pure @property Vector2d top_center();

    const abstract pure @property Vector2d center();

    const abstract pure @property Vector2d bottom_center();

}
    template RectangleRBTemplate()
{
const override pure @property double right()
{
return this.left + this.width;
}

const override pure @property double bottom()
{
return this.top + this.height;
}

}
    template RectangleWHTemplate()
{
const override pure @property double width()
out(res)
{
assert(res >= 0);
}
body
{
return this.right - this.left;
}

const override pure @property double height()
out(res)
{
assert(res >= 0);
}
body
{
return this.bottom - this.top;
}

}
    template RectangleCxCyByLTWHTemplate()
{
const override pure @property double cx()
{
return this.left + this.width / 2;
}

const override pure @property double cy()
{
return this.top + this.height / 2;
}

}
    template RectangleCxCyByLRTBTemplate()
{
const override pure @property double cx()
{
return (this.left + this.right) / 2;
}

const override pure @property double cy()
{
return (this.top + this.bottom) / 2;
}

}
    template RectangleVectorTemplate()
{
const override pure @property Vector2d top_left()
{
return vecpos(this.left,this.top);
}

const override pure @property Vector2d center_left()
{
return vecpos(this.left,this.cy);
}

const override pure @property Vector2d bottom_left()
{
return vecpos(this.left,this.bottom);
}

const override pure @property Vector2d top_center()
{
return vecpos(this.cx,this.top);
}

const override pure @property Vector2d center()
{
return vecpos(this.cx,this.cy);
}

const override pure @property Vector2d bottom_center()
{
return vecpos(this.cx,this.bottom);
}

const override pure @property Vector2d top_right()
{
return vecpos(this.right,this.top);
}

const override pure @property Vector2d center_right()
{
return vecpos(this.right,this.cy);
}

const override pure @property Vector2d bottom_right()
{
return vecpos(this.right,this.bottom);
}

}
    template RectangleVectorTemplate2()
{
const override pure @property Vector2d top_left()
{
return vecpos(this.left,this.top);
}

const override pure @property Vector2d center_left()
{
return vecpos(this.left,this.cy);
}

const override pure @property Vector2d bottom_left()
{
return vecpos(this.left,this.bottom);
}

const override pure @property Vector2d top_right()
{
return vecpos(this.right,this.top);
}

const override pure @property Vector2d center_right()
{
return vecpos(this.right,this.cy);
}

const override pure @property Vector2d bottom_right()
{
return vecpos(this.right,this.bottom);
}

const override pure @property Vector2d top_center()
{
return vecpos(this.cx,this.top);
}

const override pure @property Vector2d bottom_center()
{
return vecpos(this.cx,this.bottom);
}

}
    interface Circle : Rectangle
{
    const abstract pure @property Vector2d center();

    const abstract pure @property int radius();

}
    interface DoubleCircle : Rectangle
{
    const abstract pure @property Vector2d center();

    const abstract pure @property double innerRadius();

    const abstract pure @property double outerRadius();

}
    interface Direction
{
    const abstract pure @property double dir();

}
}
