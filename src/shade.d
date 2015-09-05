
import std.stdio;
import std.math;
import std.string;
import dxlib.all;

int main( string[] args )
{
    int grhandle;
    VERTEX2DSHADER Vert[ 6 ] ;

    // ウインドウモードで起動
    ChangeWindowMode( TRUE );

    // ＤＸライブラリの初期化
    if( DxLib_Init() < 0 ) return -1;

    // 画像の読み込み
    grhandle = LoadGraph( "H:/collect/0001/zipyaru-20100905-02-00036.jpg" );
    //grhandle = LoadGraph( "Test1.bmp" );

    // ピクセルシェーダーバイナリコードの読み込み
    int grayShade = LoadPixelShadera( "Sample2.pso" ) ;
    int negaShade = LoadPixelShader( "nega.pso" ) ;
    int sepiaShade = LoadPixelShader( "sepia.pso" ) ;
    int twoColorShade = LoadPixelShader( "2color.pso" ) ;

    int grayParamIndex = GetConstIndexToShader( "param", grayShade ) ;
    int negaParamIndex = GetConstIndexToShader( "param", negaShade ) ;
    int sepiaParamIndex = GetConstIndexToShader( "param", sepiaShade ) ;

    // 頂点データの準備
    Vert[ 0 ].pos = VGet(   0.0f,   0.0f, 0.0f ) ;
    Vert[ 1 ].pos = VGet( 1024.0f,   0.0f, 0.0f ) ;
    Vert[ 2 ].pos = VGet(   0.0f, 1024.0f, 0.0f ) ;
    Vert[ 3 ].pos = VGet( 1024.0f, 1024.0f, 0.0f ) ;
    Vert[ 0 ].dif = GetColorU8( 255,255,255,255 ) ;
    Vert[ 0 ].spc = GetColorU8( 0,0,0,0 ) ;
    Vert[ 0 ].u = 0.0f ; Vert[ 0 ].v = 0.0f ;
    Vert[ 1 ].u = 1.0f ; Vert[ 1 ].v = 0.0f ;
    Vert[ 2 ].u = 0.0f ; Vert[ 2 ].v = 1.0f ;
    Vert[ 3 ].u = 1.0f ; Vert[ 3 ].v = 1.0f ;
    Vert[ 0 ].su = 0.0f ; Vert[ 0 ].sv = 0.0f ;
    Vert[ 1 ].su = 1.0f ; Vert[ 1 ].sv = 0.0f ;
    Vert[ 2 ].su = 0.0f ; Vert[ 2 ].sv = 1.0f ;
    Vert[ 3 ].su = 1.0f ; Vert[ 3 ].sv = 1.0f ;
    Vert[ 0 ].rhw = 1.0f ;
    Vert[ 1 ].rhw = 1.0f ;
    Vert[ 2 ].rhw = 1.0f ;
    Vert[ 3 ].rhw = 1.0f ;
    Vert[ 4 ] = Vert[ 2 ] ;
    Vert[ 5 ] = Vert[ 1 ] ;

    // 描画可能なサーフェイスを作成
    dx_SetDrawValidAlphaChannelGraphCreateFlag( true );
    int handle = MakeScreen( 1024, 1024 ) ;// 描画可能な画面を作成
    dx_SetDrawValidAlphaChannelGraphCreateFlag( false );

    // 使用するテクスチャをセット
    SetUseTextureToShader( 0, handle ) ;

    // 使用するピクセルシェーダーをセット
    SetUsePixelShader( grayShade ) ;
    string mode = "gray";

    // 描画
    SetDrawScreen(handle);
    DrawBox(40,30,500,300, GetColor(255,0,0), 1);
    DrawGraph(0, 0, grhandle, true); // グラフィックの描画
    SetDrawScreen(DX_SCREEN_BACK);
    SetPSConstF( grayParamIndex, FLOAT4(1.0,1.0,1.0,1.0) ) ;    // ピクセルシェーダーの float 型定数を設定する
    DrawPrimitive2DToShader( Vert.ptr, 6, DX_PRIMTYPE_TRIANGLELIST ) ;

    // キー入力待ち
    WaitKey() ;
    int Key;
    int rad = 0;
    immutable MAX_RAD=60;
    // ループ
    while( ProcessMessage() == 0 && CheckHitKey( KEY_INPUT_ESCAPE ) == 0 )
    {
        // キー入力取得
        Key = GetJoypadInputState( DX_INPUT_KEY_PAD1 ) ;


        // 画面を初期化する
        ClearDrawScreen() ;

        float val = sin(cast(double)rad/MAX_RAD)/2+0.5;
        switch(mode){
            case "gray":
                SetPSConstF( grayParamIndex, FLOAT4(val,val,val,val) ) ;    // ピクセルシェーダーの float 型定数を設定する
                if( CheckHitKey(KEY_INPUT_RETURN )){
                    mode = "nega";
                }
                SetUsePixelShader( negaShade ) ;
                break;
            case "nega":
                SetPSConstF( negaParamIndex, FLOAT4(val,val,val,val) ) ;    // ピクセルシェーダーの float 型定数を設定する
                if( CheckHitKey(KEY_INPUT_RETURN )){
                    mode = "sepia";
                }
                SetUsePixelShader( grayShade ) ;
                break;
            case "sepia":
                SetPSConstF( sepiaParamIndex, FLOAT4(val,val,val,val) ) ;    // ピクセルシェーダーの float 型定数を設定する
                if( CheckHitKey(KEY_INPUT_RETURN )){
                    mode = "2color";
                }
                SetUsePixelShader( sepiaShade ) ;
                break;
            case "2color":
                int threshold = GetConstIndexToShader( "threshold", twoColorShade ) ;
                int color1 = GetConstIndexToShader( "color1", twoColorShade ) ;
                int color2 = GetConstIndexToShader( "color2", twoColorShade ) ;
                SetPSConstF(threshold , FLOAT4(val,0,0,0) ) ;    // ピクセルシェーダーの float 型定数を設定する
                SetPSConstF(color1 , FLOAT4(0,0,1.,1.0) ) ;    // ピクセルシェーダーの float 型定数を設定する
                SetPSConstF(color2 , FLOAT4(1.0,0,0,1.0) ) ;    // ピクセルシェーダーの float 型定数を設定する
                if( CheckHitKey(KEY_INPUT_RETURN )){
                    mode = "gray";
                }
                SetUsePixelShader( twoColorShade) ;
                break;
        }
        rad+=1;
        // 描画
        DrawPrimitive2DToShader( Vert.ptr, 6, DX_PRIMTYPE_TRIANGLELIST ) ;
        writeln(val, " - ", mode);

        // 裏画面の内容を表画面に反映させる
        ScreenFlip() ;
    }

    // ＤＸライブラリの後始末
    DxLib_End();

    // ソフトの終了
    return 0;
}
