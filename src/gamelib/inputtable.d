module gamelib.inputtable;

import gamelib.all;
import dxlib.all;
import mylib.list;
import std.stdio;
import std.string;
import std.conv;

class DxLibInput : Input{
    int[] _keycodeArray;
    int[] _joypadCodeArray;
    this(int[] keycodeArray, int[] joypadCodeArray){
        _keycodeArray       = keycodeArray;
        _joypadCodeArray = joypadCodeArray;
    }
    package bool check(char[256] keyState, int joypadState){
        foreach(k; _keycodeArray){
            if(keyState[k]==1){
                return true;
            }
        }
        foreach(k; _joypadCodeArray){
            if((joypadState & k) != 0){
                return true;
            }
        }
        return false;
    }
}

///brief インプットクラスを扱うクラス
///since 2007/12/7(Fri)
///date 2007/12/7(Fri)
///version 0.1.0.0
///author N
class InputTable/+ : Table!(DxLibInput)+/{
public:
    DxLibInput a,b,c,x,y,z;
    DxLibInput l,r;
    DxLibInput left, up, right, down;
    DxLibInput escape, space, enter;
    DxLibInput k1, k2, k3, k4, k5, k6;
    DxLibInput f1, f2, f3, f4, f5, f6;
    DxLibInput f7, f8, f9, f10, f11, f12;
    DxLibInput prtsc;
    MouseButton mleft, mright, mmid;
    MouseWheel mwheel;
    MousePosition mpos;
    Mouse _mouse = null;
    List!(MouseButton) _mouseButtonList;
    uint _joypadNum = 0;
    int _inputType = DX_INPUT_PAD1;
    private List!(DxLibInput) _inputList;
    ///コンストラクタ
    package this(){
        _mouse = new Mouse;
        _inputType = DX_INPUT_PAD1;
        _joypadNum = dx_GetJoypadNum();

        a = new DxLibInput([KEY_INPUT_Z],[PAD_INPUT_A]);
        b = new DxLibInput([KEY_INPUT_X],[PAD_INPUT_B]);
        c = new DxLibInput([KEY_INPUT_C],[PAD_INPUT_C]);
        x = new DxLibInput([KEY_INPUT_A],[PAD_INPUT_X]);
        y = new DxLibInput([KEY_INPUT_S],[PAD_INPUT_Y]);
        z = new DxLibInput([KEY_INPUT_D],[PAD_INPUT_Z]);

        l = new DxLibInput([KEY_INPUT_Q],[PAD_INPUT_L]);
        r = new DxLibInput([KEY_INPUT_W],[PAD_INPUT_R]);

        left   = new DxLibInput([KEY_INPUT_H, KEY_INPUT_LEFT], [PAD_INPUT_LEFT] );
        up     = new DxLibInput([KEY_INPUT_K, KEY_INPUT_UP],   [PAD_INPUT_UP]   );
        right  = new DxLibInput([KEY_INPUT_L, KEY_INPUT_RIGHT],[PAD_INPUT_RIGHT]);
        down   = new DxLibInput([KEY_INPUT_J, KEY_INPUT_DOWN], [PAD_INPUT_DOWN] );

        escape = new DxLibInput([KEY_INPUT_ESCAPE], []);
        space  = new DxLibInput([KEY_INPUT_SPACE],  [PAD_INPUT_START, PAD_INPUT_M]);
        enter  = new DxLibInput([KEY_INPUT_RETURN], []);

        k1 = new DxLibInput([KEY_INPUT_1],[]);
        k2 = new DxLibInput([KEY_INPUT_2],[]);
        k3 = new DxLibInput([KEY_INPUT_3],[]);
        k4 = new DxLibInput([KEY_INPUT_4],[]);
        k5 = new DxLibInput([KEY_INPUT_5],[]);
        k6 = new DxLibInput([KEY_INPUT_6],[]);

        f1  = new DxLibInput([KEY_INPUT_F1 ],[]);
        f2  = new DxLibInput([KEY_INPUT_F2 ],[]);
        f3  = new DxLibInput([KEY_INPUT_F3 ],[]);
        f4  = new DxLibInput([KEY_INPUT_F4 ],[]);
        f5  = new DxLibInput([KEY_INPUT_F5 ],[]);
        f6  = new DxLibInput([KEY_INPUT_F6 ],[]);
        f7  = new DxLibInput([KEY_INPUT_F7 ],[]);
        f8  = new DxLibInput([KEY_INPUT_F8 ],[]);
        f9  = new DxLibInput([KEY_INPUT_F9 ],[]);
        f10 = new DxLibInput([KEY_INPUT_F10],[]);
        f11 = new DxLibInput([KEY_INPUT_F11],[]);
        f12 = new DxLibInput([KEY_INPUT_F12],[]);
        prtsc = new DxLibInput([KEY_INPUT_SYSRQ],[]);
        
        mleft  = new MouseButton(MouseButtonType.left);
        mright = new MouseButton(MouseButtonType.right);
        mmid   = new MouseButton(MouseButtonType.middle);

        mwheel = new MouseWheel(100);
        mpos = new MousePosition(100);
        /+
        this.add("a", a);
        this.add("b", b);
        this.add("c", c);
        this.add("x", x);
        this.add("y", y);
        this.add("z", z);
        this.add("l", l);
        this.add("r", r);
        this.add("left"  , left  );
        this.add("up"    , up    );
        this.add("right" , right );
        this.add("down"  , down  );
        this.add("escape", escape);
        this.add("space" , space );
        this.add("enter" , enter );
        this.add("k1", k1);
        this.add("k2", k2);
        this.add("k3", k3);
        this.add("k4", k4);
        this.add("k5", k5);
        this.add("k6", k6);
        this.add("f1" , f1 );
        this.add("f2" , f2 );
        this.add("f3" , f3 );
        this.add("f4" , f4 );
        this.add("f5" , f5 );
        this.add("f6" , f6 );
        this.add("f7" , f7 );
        this.add("f8" , f8 );
        this.add("f9" , f9 );
        this.add("f10", f10);
        this.add("f11", f11);
        this.add("f12", f12);
        this.add("prtsc", prtsc);
        +/
        _inputList = new VariableList!(DxLibInput);
        _inputList.pushBack(a);
        _inputList.pushBack(b);
        _inputList.pushBack(c);
        _inputList.pushBack(x);
        _inputList.pushBack(y);
        _inputList.pushBack(z);

        _inputList.pushBack(l);
        _inputList.pushBack(r);

        _inputList.pushBack(left);
        _inputList.pushBack(up);
        _inputList.pushBack(right);
        _inputList.pushBack(down);

        _inputList.pushBack(escape);
        _inputList.pushBack(space);
        _inputList.pushBack(enter);

        _inputList.pushBack(k1);
        _inputList.pushBack(k2);
        _inputList.pushBack(k3);
        _inputList.pushBack(k4);
        _inputList.pushBack(k5);
        _inputList.pushBack(k6);

        _inputList.pushBack(f1);
        _inputList.pushBack(f2);
        _inputList.pushBack(f3);
        _inputList.pushBack(f4);
        _inputList.pushBack(f5);
        _inputList.pushBack(f6);
        _inputList.pushBack(f7);
        _inputList.pushBack(f8);
        _inputList.pushBack(f9);
        _inputList.pushBack(f10);
        _inputList.pushBack(f11);
        _inputList.pushBack(f12);

        _inputList.pushBack(prtsc);

        this._mouseButtonList = new VariableList!(MouseButton);
        this._mouseButtonList.pushBack(mright);
        this._mouseButtonList.pushBack(mleft);
        this._mouseButtonList.pushBack(mmid);
    }

    //@brief キー情報の更新
    //@attention マイフレーム呼ぶこと。
    //           また、InputManagerのサブクラスを含めてupdate関数は1フレームに一回のみ呼ぶこと
    void update(){
        char[256] keyState;
        int joypadState;
        dx_GetHitKeyStateAll(cast(char*)keyState);
        joypadState = dx_GetJoypadInputState(_inputType);
        foreach(i; _inputList){
            i.update(i.check(keyState, joypadState));
        }
        this._mouse.update();
        foreach(b; _mouseButtonList){
            b.update(this._mouse);
        }
        mwheel.update(this._mouse);
        mpos.update(this._mouse);
        /+
        foreach(i; this){
            i.update(i.check(keyState, joypadState));
        }
        +/
    }
}


int _main() {
    dx_SetGraphMode( 320, 240, 16, 60);
    dx_ChangeWindowMode(true);

    // ＤＸライブラリ初期化処理
    if( dx_DxLib_Init() == -1 ) return -1;
    auto im = new InputTable();

    // メッセージの表示

    // 無限ループ
        // Windows 依存のメッセージ処理を行う
    while( dx_ProcessMessage() != -1 )
    {
        dx_ClearDrawScreen();
        im.update();
        if(im.a.isDown()){writefln("a");}
        if(im.b.isDown()){writefln("b");}
        if(im.c.isDown()){writefln("c");}
        if(im.x.isDown()){writefln("x");}
        if(im.y.isDown()){writefln("y");}
        if(im.z.isDown()){writefln("z");}
        if(im.l.isDown()){writefln("l");}
        if(im.r.isDown()){writefln("r");}
        if(im.left .isDown()){writefln("left");}
        if(im.right.isDown()){writefln("right");}
        if(im.up   .isDown()){writefln("up");}
        if(im.down .isDown()){writefln("down");}
        if(im.enter.isDown()){writefln("enter");}
        if(im.space.isDown()){writefln("space");}
        if(im.escape.isDown()){writefln("escape");}
        dx_ScreenFlip();
        if(im.escape.isDown())break;
    }

    // ＤＸライブラリ使用の終了処理
    dx_DxLib_End() ;

    // ソフトの終了
    return 0 ;
}
