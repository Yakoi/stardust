// D import file generated from 'gamelib\direction.d'
module gamelib.direction;
import std.math;
import gamelib.all;
enum Direction4 
{
R,
B,
L,
T,
}
enum Direction5 
{
R,
B,
L,
T,
C,
}
enum Vertical2 
{
T,
B,
}
enum Vertical3 
{
T,
B,
C,
}
enum Horizon2 
{
L,
R,
}
enum Horizon3 
{
L,
R,
C,
}
enum Direction8 
{
R,
BR,
B,
BL,
L,
TL,
T,
TR,
}
enum Direction9 
{
R,
BR,
B,
BL,
L,
TL,
T,
TR,
C,
}
nothrow pure Direction5 direction4to5(Direction4 d4);

nothrow pure Direction9 direction5to9(Direction5 d5);

nothrow pure Direction8 direction4to8(Direction4 d4);

nothrow pure Direction9 direction8to9(Direction8 d8);

nothrow pure Direction9 direction4to9(Direction4 d4)
{
return direction5to9(direction4to5(d4));
}

enum RelativeDirection5 
{
FORWARD,
LEFTHAND,
RIGHTHAND,
BACK,
NONE,
}
enum RelativeDirection4 
{
FORWARD,
LEFTHAND,
RIGHTHAND,
BACK,
}
nothrow pure RelativeDirection4 relativeDirection(Direction4 my_dir, Direction4 yourDir);

nothrow pure RelativeDirection5 relativeDirection(Direction4 my_dir, Direction5 yourDir);

pure Direction4 rotate(Direction4 dir, RelativeDirection4 rdir);

nothrow pure double dirToRad(Direction4 dir4);

nothrow pure double dirToRad(Direction8 dir8);

nothrow pure Direction4 radToDir4(double rad);

nothrow pure Direction4 vectorToDir4(Vector vec);

nothrow pure Direction5 vectorToDir5(Vector vec);

enum RotationDirection 
{
right,
left,
}
nothrow pure real rotate(real nowRad, RotationDirection rd, real rotRad);

enum VerticalHorizon 
{
vertical,
horizon,
}
