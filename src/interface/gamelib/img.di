// D import file generated from 'gamelib\img.d'
module gamelib.img;
import gamelib.all;
import mylib.list;
import std.stdio;
alias VariableList!(Img) ImgList;
class Img : Position,Direction
{
    Vector _pos;
    double _scale;
    bool _is_visible;
    bool _is_rotate;
    bool _is_enable;
    BlendMode _blend_mode;
    ubyte _blend_param;
    double _dir;
    Figure _figure;
    ImgList _img_list;
    double _animation_count;
    double _animation_fps;
    this()
{
_img_list = new ImgList;
}
    protected void init(Vector pos, double dir, BlendMode blend_mode, ubyte blend_param, double scale, bool is_rotate, bool is_visible, bool is_enable)
{
this.pos = pos;
this.is_visible = is_visible;
this.is_enable = is_enable;
this.is_rotate = is_rotate;
this.blend_mode = blend_mode;
this.blend_param = blend_param;
this.scale = scale;
this.dir = dir;
}

    void init_figure(Vector pos, double dir, BlendMode blend_mode, ubyte blend_param, double scale, bool is_rotate, bool is_visible, bool is_enable, Figure figure)
{
this.init(pos,dir,blend_mode,blend_param,scale,is_rotate,is_visible,is_enable);
this._figure = figure;
}
    void pos(Vector val)
{
_pos = val;
}
    const override pure Vector pos()
{
return _pos;
}

    void x(double val)
{
_pos.x = val;
}
    const override pure double x()
{
return pos.x;
}

    void y(double val)
{
_pos.y = val;
}
    const override pure double y()
{
return pos.y;
}

    void dir(double val)
{
_dir = val;
}
    const override pure double dir()
{
return _dir;
}

    void scale(double val)
{
_scale = val;
}
    double scale()
{
return _scale;
}
    void is_visible(bool val)
{
_is_visible = val;
}
    bool is_visible()
{
return _is_visible;
}
    void is_enable(bool val)
{
_is_enable = val;
}
    bool is_enable()
{
return _is_enable;
}
    void is_rotate(bool val)
{
_is_rotate = val;
}
    bool is_rotate()
{
return _is_rotate;
}
    void blend_param(ubyte val)
{
_blend_param = val;
}
    ubyte blend_param()
{
return _blend_param;
}
    void blend_mode(BlendMode val)
{
_blend_mode = val;
}
    Figure figure()
{
return _figure;
}
    BlendMode blend_mode()
{
return _blend_mode;
}
    bool draw(Drawer drawer);
}
