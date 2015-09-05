// D import file generated from 'gamelib\mouse.d'
module gamelib.mouse;
import gamelib.all;
import dxlib.all;
template DigitalInput(T)
{
class DigitalInput
{
    private 
{
    const int _count_init = -100000;

    int _count = _count_init;
    int _last_count = _count_init;
    package 
{
    this()
{
_count = _count_init;
_last_count = _count_init;
}
    protected 
{
    void set(bool is_push)
{
this._last_count = this._count;
if (_count >= 0)
{
if (is_push)
{
this._count += 1;
}
else
{
this._count = -1;
}
}
else
if (this._count < 0)
{
if (is_push)
{
this._count = 1;
}
else
{
this._count += -1;
}
}
}
    public 
{
    void update(T)
{
}
    const pure bool is_press()
{
return _count > 0;
}

    const pure bool is_down()
{
return _count == 1;
}

    const pure bool is_up()
{
return _count == -1;
}

    const pure bool is_change()
{
return is_down() || is_up();
}

    const pure int count()
{
return _count;
}

    const pure int last_count()
{
return _last_count;
}

    void count(int count)
{
_count = count;
}
    void reset()
{
_count = _count_init;
}
}
}
}
}
}
}
enum MouseButtonType 
{
left = MOUSE_INPUT_LEFT,
middle = MOUSE_INPUT_MIDDLE,
right = MOUSE_INPUT_RIGHT,
button4 = MOUSE_INPUT_4,
button5 = MOUSE_INPUT_5,
button6 = MOUSE_INPUT_6,
button7 = MOUSE_INPUT_7,
button8 = MOUSE_INPUT_8,
}
class MouseButton : DigitalInput!(Mouse)
{
    protected 
{
    MouseButtonType _button;
    package 
{
    this(MouseButtonType button)
{
this._button = button;
}
    override void update(Mouse mouse)
{
super.set(mouse.get(this._button));
}

}
}
}
class MousePosition
{
    protected 
{
    RingStack!(Vector) _pos;
    package 
{
    this(int num = 10)
{
this._pos = new RingStack!(Vector)(num);
}
    void update(Mouse mouse)
{
this._pos.push(mouse.pos);
}
    public 
{
    Vector pos(int time = 0)
{
return _pos[time];
}
    Vector vel(int time = 0);
    int depth()
{
return this._pos.depth;
}
}
}
}
}
class MouseWheel
{
    protected 
{
    RingStack!(int) _rot;
    package 
{
    this(int num = 10)
{
this._rot = new RingStack!(int)(num);
}
    void update(Mouse mouse)
{
this._rot.push(mouse.wheel);
}
    public 
{
    int rot(int time = 0)
{
return this._rot[time];
}
    int sum(int time = 1);
    int depth()
{
return this._rot.depth;
}
}
}
}
}
class Mouse
{
    protected 
{
    int _dxclick;
    int _dxwheel;
    public 
{
    Vector pos()
{
int x,y;
dx_GetMousePoint(&x,&y);
return Vector(x,y);
}
    int x()
{
int x;
dx_GetMousePoint(&x,null);
return x;
}
    int y()
{
int y;
dx_GetMousePoint(null,&y);
return y;
}
    void pos(int x, int y)
{
dx_SetMousePoint(x,y);
}
    void pos(IntVector p)
{
this.pos(p.x,p.y);
}
    void pos(Vector p)
{
this.pos(cast(int)p.x,cast(int)p.y);
}
    void x(int val)
{
this.pos(val,this.y);
}
    void y(int val)
{
this.pos(this.x,val);
}
    void visible(bool val)
{
dx_SetMouseDispFlag(val);
}
    bool visible()
{
return 0 != dx_GetMouseDispFlag();
}
    bool get(MouseButtonType val)
{
return (val & this._dxclick) != 0;
}
    bool left()
{
return this.get(MouseButtonType.left);
}
    bool right()
{
return this.get(MouseButtonType.right);
}
    bool middle()
{
return this.get(MouseButtonType.middle);
}
    bool button4()
{
return this.get(MouseButtonType.button4);
}
    bool button5()
{
return this.get(MouseButtonType.button5);
}
    bool button6()
{
return this.get(MouseButtonType.button6);
}
    bool button7()
{
return this.get(MouseButtonType.button7);
}
    bool button8()
{
return this.get(MouseButtonType.button8);
}
    int wheel()
{
return this._dxwheel;
}
    package void update()
{
this._dxclick = dx_GetMouseInput();
this._dxwheel = dx_GetMouseWheelRotVol();
}

}
}
}
