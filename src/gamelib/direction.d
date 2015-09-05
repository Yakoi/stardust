module gamelib.direction;
import std.math;
import gamelib.all;

///
enum Direction4{
    R ,
    B ,
    L ,
    T ,
}
///
enum Direction5{
    R,
    B,
    L,
    T,
    C,
}
///
enum Vertical2{
    T,
    B,
}
enum Vertical3{
    T,
    B,
    C,
}
enum Horizon2{
    L,
    R,
}
enum Horizon3{
    L,
    R,
    C,
}


///
enum Direction8{
    R  ,//= pi*0.00,
    BR ,//= pi*0.25,
    B  ,//= pi*0.50,
    BL ,//= pi*0.75,
    L  ,//= pi*1.00,
    TL ,//= pi*1.25,
    T  ,//= pi*1.50,
    TR ,//= pi*1.75,
}
///
enum Direction9{
    R  ,
    BR ,
    B  ,
    BL ,
    L  ,
    TL ,
    T  ,
    TR ,
    C  ,
}
///
pure nothrow Direction5 direction4to5(Direction4 d4){
    final switch(d4){
    case Direction4.R:
        return Direction5.R;
    case Direction4.B:
        return Direction5.B;
    case Direction4.L:
        return Direction5.L;
    case Direction4.T:
        return Direction5.T;
    }
}
///
pure nothrow Direction9 direction5to9(Direction5 d5){
    final switch(d5){
    case Direction5.R:
        return Direction9.R;
    case Direction5.B:
        return Direction9.B;
    case Direction5.L:
        return Direction9.L;
    case Direction5.T:
        return Direction9.T;
    case Direction5.C:
        return Direction9.C;
    }
}
///
pure nothrow Direction8 direction4to8(Direction4 d4){
    final switch(d4){
    case Direction4.R:
        return Direction8.R;
    case Direction4.B:
        return Direction8.B;
    case Direction4.L:
        return Direction8.L;
    case Direction4.T:
        return Direction8.T;
    }
}
///
pure nothrow Direction9 direction8to9(Direction8 d8){
    final switch(d8){
    case Direction8.R :
        return Direction9.R;
    case Direction8.BR:
        return Direction9.BR;
    case Direction8.B :
        return Direction9.B;
    case Direction8.BL:
        return Direction9.BL;
    case Direction8.L :
        return Direction9.L;
    case Direction8.TL:
        return Direction9.TL;
    case Direction8.T :
        return Direction9.T;
    case Direction8.TR:
        return Direction9.TR;
    }
}
///
pure nothrow Direction9 direction4to9(Direction4 d4){
    return direction5to9(direction4to5(d4));
}

/// 自分から見てどの方向か
/+
enum RelativeDirection4{
    forward,
    lefthand,
    righthand,
    back,
}
+/
/// 自分から見てどの方向か
enum RelativeDirection5{
    FORWARD,
    LEFTHAND,
    RIGHTHAND,
    BACK,
    NONE,
}
enum RelativeDirection4{
    FORWARD,
    LEFTHAND,
    RIGHTHAND,
    BACK,
}


///
pure nothrow RelativeDirection4 relativeDirection(Direction4 my_dir, Direction4 yourDir){
    with(Direction4) with(RelativeDirection4){
        final switch(my_dir){
        case R:
            final switch(yourDir){
            case R:
                return FORWARD;
            case B:
                return RIGHTHAND;
            case L:
                return BACK;
            case T:
                return LEFTHAND;
            }
        case B:
            final switch(yourDir){
            case R:
                return LEFTHAND;
            case B:
                return FORWARD;
            case L:
                return RIGHTHAND;
            case T:
                return BACK;
            }
        case L:
            final switch(yourDir){
            case R:
                return BACK;
            case B:
                return LEFTHAND;
            case L:
                return FORWARD;
            case T:
                return RIGHTHAND;
            }
        case T:
            final switch(yourDir){
            case R:
                return RIGHTHAND;
            case B:
                return BACK;
            case L:
                return LEFTHAND;
            case T:
                return FORWARD;
            }
        }
    }
}
/// 
pure nothrow RelativeDirection5 relativeDirection(Direction4 my_dir, Direction5 yourDir){
    with(Direction4) with(RelativeDirection5){
        final switch(my_dir){
        case R:
            final switch(yourDir){
            case Direction5.R:
                return FORWARD;
            case Direction5.B:
                return RIGHTHAND;
            case Direction5.L:
                return BACK;
            case Direction5.T:
                return LEFTHAND;
            case Direction5.C:
                return NONE;
            }
        case B:
            final switch(yourDir){
            case Direction5.R:
                return LEFTHAND;
            case Direction5.B:
                return FORWARD;
            case Direction5.L:
                return RIGHTHAND;
            case Direction5.T:
                return BACK;
            case Direction5.C:
                return NONE;
            }
        case L:
            final switch(yourDir){
            case Direction5.R:
                return BACK;
            case Direction5.B:
                return LEFTHAND;
            case Direction5.L:
                return FORWARD;
            case Direction5.T:
                return RIGHTHAND;
            case Direction5.C:
                return NONE;
            }
        case T:
            final switch(yourDir){
            case Direction5.R:
                return RIGHTHAND;
            case Direction5.B:
                return BACK;
            case Direction5.L:
                return LEFTHAND;
            case Direction5.T:
                return FORWARD;
            case Direction5.C:
                return NONE;
            }
        }
    }
}
///
pure Direction4 rotate(Direction4 dir, RelativeDirection4 rdir){
    with(Direction4)final switch(dir){
    case R:
        with(RelativeDirection4)final switch(rdir){
        case FORWARD:
            return R;
        case RIGHTHAND:
            return B;
        case BACK:
            return L;
        case LEFTHAND:
            return T;
        }
    case B:
        with(RelativeDirection4)final switch(rdir){
        case FORWARD:
            return B;
        case RIGHTHAND:
            return L;
        case BACK:
            return T;
        case LEFTHAND:
            return R;
        }
    case L:
        with(RelativeDirection4)final switch(rdir){
        case FORWARD:
            return L;
        case RIGHTHAND:
            return T;
        case BACK:
            return R;
        case LEFTHAND:
            return B;
        }
    case T:
        with(RelativeDirection4)final switch(rdir){
        case FORWARD:
            return T;
        case RIGHTHAND:
            return R;
        case BACK:
            return B;
        case LEFTHAND:
            return L;
        }
    }
}

///
pure nothrow double dirToRad(Direction4 dir4){
    with(Direction4)final switch(dir4){
    case R:
        return PI_2*0;
    case B:
        return PI_2*1;
    case L:
        return PI_2*2;
    case T:
        return PI_2*3;
    }
}
///
pure nothrow double dirToRad(Direction8 dir8){
    with(Direction8)final switch(dir8){
    case R:
        return PI_4*0;
    case BR:
        return PI_4*1;
    case B:
        return PI_4*2;
    case BL:
        return PI_4*3;
    case L:
        return PI_4*4;
    case TL:
        return PI_4*5;
    case T:
        return PI_4*6;
    case TR:
        return PI_4*7;
    }
}
///
pure nothrow Direction4 radToDir4(double rad){
    auto C = cos(rad);
    if(C >= SQRT1_2){
        return Direction4.R;
    }
    if(C <= -SQRT1_2){
        return Direction4.L;
    }
    if(sin(rad) > 0){
        return Direction4.B;
    }else{
        return Direction4.T;
    }
}
pure nothrow Direction4 vectorToDir4(Vector vec){
    with(Direction4){
        if(vec.x >= 0){
            if(vec.y >= 0){
                if(vec.x>=vec.y){
                    return R;
                }else{
                    return B;
                }
            }else{
                if(vec.x >= -vec.y){
                    return R;
                }else{
                    return T;
                }
            }
        }else{
            if(vec.y >= 0){
                if(-vec.x>=vec.y){
                    return L;
                }else{
                    return B;
                }
            }else{
                if(-vec.x >= -vec.y){
                    return L;
                }else{
                    return T;
                }
            }
        }
    }
}
///
pure nothrow Direction5 vectorToDir5(Vector vec){
    with(Direction5){
        if(vec.length2 == 0){
            return C;
        }else{
            return direction4to5(vectorToDir4(vec));
        }
    }
}
/// 回転方向
enum RotationDirection{
    right, ///時計回り
    left,  ///反時計回り
}
/// 方向データを用いて回転
pure nothrow real rotate(real nowRad, RotationDirection rd, real rotRad){
    with(RotationDirection)final switch(rd){
    case right:
        return nowRad + rotRad;
    case left:
        return nowRad - rotRad;
    }
}

enum VerticalHorizon{
    vertical,
    horizon,
}
