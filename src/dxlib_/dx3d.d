module dxlib.dx3d;
import dxlib.all;
import core.sys.windows.windows;
// Dx3D.cpp関数プロトタイプ宣言
    extern(Windows):

// 設定関係
    D_IDirect3DDevice7 dx_GetUseD3DDevObj() ;                                                            // 使用中のＤｉｒｅｃｔ３ＤＤｅｖｉｃｅオブジェクトを得る
    int dx_SetUseDivGraphFlag( int Flag ) ;                                                                // 必要ならグラフィックの分割を行うか、フラグのセット
    int dx_SetUseMaxTextureSize( int Size ) ;                                                                // 使用するテクスチャーの最大サイズをセット(0でデフォルト)
    int dx_SetUseVertexBufferFlag( int Flag ) ;                                                            // 頂点バッファを使用するかどうかを設定する
    int dx_RenderVertexBuffer() ;                                                                    // 頂点バッファに溜まった頂点データを吐き出す
    VERTEX_2D dx_GetVertexBuffer( int VertexNum = 6 , int PrimType = DX_PRIMTYPE_TRIANGLELIST ) ;                // 追加頂点バッファの頂点追加アドレスを得る( 戻り値はテクスチャなしの場合は VERTEX_NOTEX_2D となる )
    void dx__DrawPreparation( int GrHandle = DX_NONE_GRAPH , int ParamFlag = 0 ) ;                            // 描画準備を行う( ParamFlag は DRAWPREP_TRANS 等 )
    void dx_Add4VertexBuffer() ;                                                                        // GetVertexTo3DDevice によって４頂点追加されたことを前提に頂点追加処理を行う
    void dx_AddVertexBuffer( int VertexNum = 6 ) ;                                                            // GetVertexTo3DDevice によって指定数頂点が追加されたことを前提に頂点追加処理を行う
    void dx_SetGraphTexture( int GrHandle ) ;                                                                // Ｄｉｒｅｃｔ３Ｄデバイスにテクスチャをセットする
    int dx_SetUseOldDrawModiGraphCodeFlag( int Flag ) ;                                                    // 以前の DrawModiGraph 関数のコードを使用するかどうかのフラグをセットする

// その他補助関数
    D_DDPIXELFORMAT dx_GetTexPixelFormat( int AlphaCh, int AlphaTest, int ColorBitDepth, int DrawValid = FALSE ) ;    // ピクセルフォーマットを得る
    COLORDATA dx_GetTexColorData( int AlphaCh, int AlphaTest, int ColorBitDepth, int DrawValid = FALSE ) ;    // カラーデータを得る
    D_DDPIXELFORMAT dx_GetTexPixelFormat( IMAGEFORMATDESC *Format ) ;                                                // フォーマットに基づいたカラーフォーマットを得る
    COLORDATA dx_GetTexColorData( IMAGEFORMATDESC *Format ) ;                                                // フォーマットに基づいたカラーデータを得る
    D_DDPIXELFORMAT dx_GetTexPixelFormat( int FormatIndex ) ;                                                        // 指定のフォーマットインデックスのカラーフォーマットを得る
    COLORDATA dx_GetTexColorData( int FormatIndex ) ;                                                        // 指定のフォーマットインデックスのカラーデータを得る
    int dx_GetTexFormatIndex( IMAGEFORMATDESC *Format ) ;                                                // テクスチャフォーマットのインデックスを得る
    D_DDPIXELFORMAT dx_GetZBufferPixelFormat( int BitDepth ) ;                                                        // 指定のビット深度のＺバッファーのピクセルフォーマットを得る( 現在のところ 16 ビットのみ )

    int dx_GraphColorMatchBltVer2( void *DestGraphData, int DestPitch, COLORDATA *DestColorData,
                                            void *SrcGraphData, int SrcPitch, COLORDATA *SrcColorData,
                                            void *AlphaMask, int AlphaPitch, COLORDATA *AlphaColorData,
                                            POINT DestPoint, RECT *SrcRect, int ReverseFlag,
                                            int TransColorAlphaTestFlag, uint TransColor,
                                            int ImageShavedMode, int AlphaOnlyFlag = FALSE ,
                                            int RedIsAlphaFlag = FALSE , int TransColorNoMoveFlag = FALSE,
                                            int Pal8ColorMatch = FALSE ) ;                                            // カラーマッチングしながらグラフィックデータ間転送を行う Ver2








// DxGraphics関数プロトタイプ宣言

// グラフィック制御関係関数
    int dx_MakeGraph( int SizeX, int SizeY, int NotUse3DFlag = FALSE ) ;                                                                                                // 空のグラフィックを作成
    int dx_MakeScreen( int SizeX, int SizeY ) ;                                                                                                                        // 描画可能な画面を作成
    int dx_DeleteGraph( int GrHandle, int LogOutFlag = FALSE ) ;                                                                                                        // 指定のグラフィックデータを削除する
    int dx_GetGraphNum() ;                                                                                                                                        // 有効なグラフィックの数を取得する
    int dx_SetGraphLostFlag( int GrHandle, int *LostFlag ) ;                                                                                                            // 解放時に立てるフラグのポインタをセットする
    int dx_InitGraph( int LogOutFlag = FALSE ) ;                                                                                                                        // 画像データの初期化

    int dx_BltBmpToGraph( COLORDATA *SrcColor, HBITMAP Bmp, HBITMAP AlphaMask, const char *GraphName, int CopyPointX, int CopyPointY, int GrHandle, int ReverseFlag ) ; // 画像データの転送
    int dx_BltBmpToDivGraph( COLORDATA *SrcColor, HBITMAP Bmp, HBITMAP AlphaMask, const char *GraphName,
                                        int AllNum, int XNum, int YNum, int Width, int Height, int *GrHandle, int ReverseFlag ) ;                                                // 分割画像へのＢＭＰの転送
    int dx_BltBmpOrGraphImageToGraph( COLORDATA *SrcColorData, HBITMAP Bmp, HBITMAP AlphaMask, const char *GraphName,
                                        int BmpFlag, BASEIMAGE *RgbImage, BASEIMAGE *AlphaImage,
                                        int CopyPointX, int CopyPointY, int GrHandle, int ReverseFlag ) ;                                                                        // ＢＭＰ か GraphImage を画像に転送
    int dx_BltBmpOrGraphImageToGraph2( COLORDATA *SrcColorData, HBITMAP Bmp, HBITMAP AlphaMask, const char *GraphName,
                                        int BmpFlag, BASEIMAGE *RgbImage, BASEIMAGE *AlphaImage,
                                        RECT *SrcRect, int DestX, int DestY, int GrHandle, int ReverseFlag ) ;                                                                    // ＢＭＰ か GraphImage を画像に転送
    int dx_BltBmpOrGraphImageToDivGraph( COLORDATA *SrcColor, HBITMAP Bmp, HBITMAP AlphaMask, const char *GraphName,
                                        int BmpFlag, BASEIMAGE *RgbImage, BASEIMAGE *AlphaImage,
                                        int AllNum, int XNum, int YNum, int Width, int Height, int *GrHandle, int ReverseFlag ) ;                                                // 分割画像への ＢＭＰ か GraphImage の転送
    int dx_LoadBmpToGraph( const char *GraphName, int TextureFlag, int ReverseFlag, int SurfaceMode = DX_MOVIESURFACE_NORMAL ) ;                                        // 画像を読みこむ 
    int dx_LoadDivBmpToGraph( const char *FileName, int AllNum, int XNum, int YNum, int SizeX, int SizeY, int *HandleBuf, int TextureFlag, int ReverseFlag ) ;            // 画像ファイルの分割読みこみ
    int dx_LoadGraph( const char *FileName, int NotUse3DFlag = FALSE ) ;                                                                                                // 画像ファイルのメモリへの読みこみ
    int dx_LoadGraphToResource( int ResourceID ) ;                                                                                                                        // リソースから画像データを読み込む
    int dx_LoadGraphToResource( const char *ResourceName, const char *ResourceType ) ;                                                                                    // リソースから画像データを読み込む
    int dx_LoadDivGraphToResource( const char *ResourceName, const char *ResourceType, int AllNum, int XNum, int YNum, int XSize, int YSize, int *HandleBuf ) ;        // リソースから画像データを分割読み込みする
    int dx_LoadBlendGraph( const char *FileName ) ;                                                                                                                    // 画像ファイルからブレンド用画像を読み込む

    int dx_LoadReverseGraph( const char *FileName, int NotUse3DFlag = FALSE ) ;                                                                                        // 画像ファイルのメモリへの反転読み込み
    int dx_LoadDivGraph( const char *FileName, int AllNum, int XNum, int YNum, int XSize, int YSize, int *HandleBuf, int NotUse3DFlag = FALSE ) ;                        // 画像の分割読みこみ
    int dx_LoadReverseDivGraph( const char *FileName, int AllNum, int XNum, int YNum, int XSize, int YSize, int *HandleBuf, int NotUse3DFlag = FALSE ) ;                // 画像の反転分割読みこみ
    int dx_OpenMovieToOverlay( const char *FileName ) ;                                                                                                                // オーバーレイサーフェスを使用したムービーファイルのオープン
    int dx_UpdateMovieToOverlay( int x, int y, int ExRate, int ShowFlag, int MovieHandle ) ;                                                                            // オーバーレイサーフェスを使用したムービーの表示ステータスセット
    int dx_CloseMovieToOverlay( int MovieHandle ) ;                                                                                                                    // オーバーレイサーフェスを使用したムービーファイルを閉じる
    int dx_ReloadGraph( const char *FileName, int GrHandle, int ReverseFlag = FALSE ) ;                                                                                // 画像への画像データの読み込み
    int dx_ReloadDivGraph( const char *FileName, int AllNum, int XNum, int YNum, int XSize, int YSize, int *HandleBuf, int ReverseFlag = FALSE ) ;                        // 画像への画像データの分割読み込み
    int dx_ReloadReverseGraph( const char *FileName, int GrHandle ) ;                                                                                                    // 画像への画像データの読み込み
    int dx_ReloadReverseDivGraph( const char *FileName, int AllNum, int XNum, int YNum, int XSize, int YSize, int *HandleBuf ) ;                                        // 画像への画像データの分割読み込み
    int dx_ReloadFileGraphAll() ;                                                                                                                                // ファイルから読み込んだ画像情報を再度読み込む
    int dx_SetGraphTransColor( int GrHandle, int Red, int Green, int Blue ) ;                                                                                            // 画像の透過色を変更する(アルファチャンネル使用時は無効)

    int dx_RestoreGraph( int GrHandle ) ;                                                                                                                                // 画像データのリストア
    int dx_AllRestoreGraph() ;                                                                                                                                    // すべての画像データのリストア


// グラフィック描画関係関数
    int dx_ClearDrawScreen() ;                                                                                                                // 画面の状態を初期化する
    int dx_ClsDrawScreen() ;                                                                                                                    // 画面の状態を初期化する(ClearDrawScreenの旧名称)

    int dx_LoadGraphScreen( int x, int y, const char *GraphName, int TransFlag ) ;                                                                    // ＢＭＰファイルを読みこんで画面に描画する
    int dx_DrawGraph( int x, int y, int GrHandle, int TransFlag ) ;                                                                                // グラフィックの描画
    int dx_DrawGraphF( float xf, float yf, int GrHandle, int TransFlag ) ;                                                                            // グラフィックの描画
    int dx_DrawExtendGraph( int x1, int y1, int x2, int y2, int GrHandle, int TransFlag ) ;                                                        // グラフィックの拡大縮小描画
    int dx_DrawExtendGraphF( float x1f, float y1f, float x2f, float y2, int GrHandle, int TransFlag ) ;                                                // グラフィックの拡大縮小描画
    int dx_DrawRotaGraph( int x, int y, double ExRate, double Angle, int GrHandle, int TransFlag, int TurnFlag = FALSE  ) ;                        // グラフィックの回転描画
    int dx_DrawRotaGraphF( float xf, float yf, double ExRate, double Angle, int GrHandle, int TransFlag, int TurnFlag = FALSE  ) ;                    // グラフィックの回転描画
    int dx_DrawRotaGraph2( int x, int y, int cx, int cy, double ExtRate, double Angle, int GrHandle, int TransFlag, int TurnFlag = FALSE  ) ;        // グラフィックの回転描画２
    int dx_DrawRotaGraph2F( float xf, float yf, float cxf, float cyf, double ExtRate, double Angle, int GrHandle, int TransFlag, int TurnFlag = FALSE  ) ;    // グラフィックの回転描画２
    int dx_DrawModiGraph( int x1, int y1, int x2, int y2, int x3, int y3, int x4, int y4, int GrHandle, int TransFlag ) ;                            // 画像の自由変形描画
    int dx_DrawModiGraphF( float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4, int GrHandle, int TransFlag ) ;            // 画像の自由変形描画( float 版 )
    int dx_DrawTurnGraph( int x, int y, int GrHandle, int TransFlag ) ;                                                                            // 画像の左右反転描画
    int dx_DrawTurnGraphF( float xf, float yf, int GrHandle, int TransFlag ) ;                                                                        // 画像の左右反転描画
    int dx_DrawChipMap( int Sx, int Sy, int XNum, int YNum, int *MapData, int ChipTypeNum, int MapDataPitch, int *GrHandle, int TransFlag ) ;        // チップグラフィックを使ったマップ描画
    int dx_DrawChipMap( int MapWidth, int MapHeight, int *MapData, int ChipTypeNum, int *ChipGrHandle, int TransFlag,
                                        int MapDrawPointX, int MapDrawPointY, int MapDrawWidth, int MapDrawHeight, int ScreenX, int ScreenY ) ;            // チップグラフィックを使ったマップ描画
    int dx_DrawTile( int x1, int y1, int x2, int y2, int Tx, int Ty,
                                double ExtRate, double Angle, int GrHandle, int TransFlag ) ;                                                            // グラフィックを指定領域にタイル状に描画する
    int dx_DrawRectGraph( int DestX, int DestY, int SrcX, int SrcY, int Width, int Height, int GraphHandle, int TransFlag, int TurnFlag ) ;    // グラフィックの指定矩形部分のみを描画
    int dx_DrawRectExtendGraph( int DestX1, int DestY1, int DestX2, int DestY2, int SrcX, int SrcY, int SrcWidth, int SrcHeight, int GraphHandle, int TransFlag ) ;    // グラフィックの指定矩形部分のみを拡大描画
    int dx_DrawBlendGraph( int x, int y, int GrHandle, int TransFlag, int BlendGraph, int BorderParam, int BorderRange ) ;                        // ブレンド画像と合成して画像を描画する
    int dx_DrawBlendGraphPos( int x, int y, int GrHandle, int TransFlag, int bx, int by, int BlendGraph, int BorderParam, int BorderRange ) ;    // ブレンド画像と合成して画像を描画する( ブレンド画像の起点座標を指定する版 )
    int dx_DrawRectRotaGraph( int X, int Y, int SrcX, int SrcY, int Width, int Height, double ExtRate, double Angle, int GraphHandle, int TransFlag, int TurnFlag ) ; 
    int dx_DrawCircleGauge( int CenterX, int CenterY, double Percent, int GrHandle ) ;                                                            // 円グラフ的な描画を行う
    int dx_DrawGraphToZBuffer( int X, int Y, int GrHandle, int WriteZMode /* DX_ZWRITE_MASK 等 */ ) ;                                            // Ｚバッファに対して画像の描画を行う
    int dx_DrawTurnGraphToZBuffer( int x, int y, int GrHandle, int WriteZMode /* DX_ZWRITE_MASK 等 */ ) ;                                        // Ｚバッファに対して画像の左右反転描画
    int dx_DrawExtendGraphToZBuffer( int x1, int y1, int x2, int y2, int GrHandle, int WriteZMode /* DX_ZWRITE_MASK 等 */ ) ;                    // Ｚバッファに対して画像の拡大縮小描画
    int dx_DrawRotaGraphToZBuffer( int x, int y, double ExRate, double Angle, int GrHandle, int WriteZMode /* DX_ZWRITE_MASK 等 */ , int TurnFlag = FALSE  ) ;    // Ｚバッファに対して画像の回転描画
    int dx_DrawModiGraphToZBuffer( int x1, int y1, int x2, int y2, int x3, int y3, int x4, int y4, int GrHandle, int WriteZMode /* DX_ZWRITE_MASK 等 */ ) ;    // Ｚバッファに対して画像の自由変形描画
    int dx_DrawBoxToZBuffer( int x1, int y1, int x2, int y2, int FillFlag, int WriteZMode /* DX_ZWRITE_MASK 等 */ ) ;                            // Ｚバッファに対して矩形の描画を行う
    int dx_DrawCircleToZBuffer( int x, int y, int r, int FillFlag, int WriteZMode /* DX_ZWRITE_MASK 等 */ ) ;                                    // Ｚバッファに対して円の描画を行う
    //int dx_DrawPolygonBase( VERTEX *Vertex, int VertexNum, int PrimitiveType, int GrHandle, int TransFlag ) ;                                    // ２Ｄポリゴンを描画する
    int dx_DrawPolygonBase( VERTEX *  Vertex, int  VertexNum, int  PrimitiveType, int  GrHandle, int  TransFlag, int  UVScaling = FALSE);
    int dx_DrawPolygon( VERTEX *Vertex, int PolygonNum, int GrHandle, int TransFlag ) ;                                                        // ２Ｄポリゴンを描画する
    int dx_DrawPolygon3DBase( VERTEX_3D *Vertex, int VertexNum, int PrimitiveType, int GrHandle, int TransFlag ) ;                                // ３Ｄポリゴンを描画する
    int dx_DrawPolygon3D( VERTEX_3D *Vertex, int PolygonNum, int GrHandle, int TransFlag ) ;                                                    // ３Ｄポリゴンを描画する
    int dx_DrawGraph3D( float x, float y, float z, int GrHandle, int TransFlag ) ;                                                                // グラフィックの３Ｄ描画
    int dx_DrawExtendGraph3D( float x, float y, float z, double ExRateX, double ExRateY, int GrHandle, int TransFlag ) ;                        // グラフィックの拡大３Ｄ描画
    int dx_DrawRotaGraph3D( float x, float y, float z, double ExRate, double Angle, int GrHandle, int TransFlag, int TurnFlag = FALSE ) ;        // グラフィックの回転３Ｄ描画
    int dx_DrawRota2Graph3D( float x, float y, float z, float cx, float cy, double ExtRateX, double ExtRateY, double Angle, int GrHandle, int TransFlag, int TurnFlag = FALSE ) ;    // グラフィックの回転３Ｄ描画(回転中心指定型)
    int dx_FillGraph( int GrHandle, int Red, int Green, int Blue, int Alpha = 255 ) ;                                                            // グラフィックを特定の色で塗りつぶす
    int dx_DrawLine( int x1, int y1, int x2, int y2, int Color, int Thickness = 1 ) ;                                                                // 線を描画
    int dx_DrawBox( int x1, int y1, int x2, int y2, int Color, int FillFlag ) ;                                                                // 四角形の描画
    int dx_DrawFillBox( int x1, int y1, int x2, int y2, int Color ) ;                                                                            // 中身のある四角を描画
    int dx_DrawLineBox( int x1, int y1, int x2, int y2, int Color ) ;                                                                            // 四角形の描画 
    int dx_DrawCircle( int x, int y, int r, int Color, int FillFlag = TRUE ) ;                                                                    // 円を描く
    int dx_DrawOval( int x, int y, int rx, int ry, int Color, int FillFlag ) ;                                                                    // 楕円を描く
    int dx_DrawTriangle( int x1, int y1, int x2, int y2, int x3, int y3, int Color, int FillFlag ) ;                                            // 三角形の描画
    int dx_DrawPixel( int x, int y, int Color ) ;                                                                                                // 点を描画する
    int dx_DrawPixelSet( POINTDATA *PointData, int Num ) ;                                                                                        // 点の集合を描く
    int dx_DrawLineSet( LINEDATA *LineData, int Num ) ;                                                                                        // 線の集合を描く
    int dx_DrawString( int x, int y, const char *String, int Color, int EdgeColor = 0 ) ;                                                        // 文字列の描画
    int dx_DrawVString( int x, int y, const char *String, int Color, int EdgeColor = 0 ) ;                                                        // 文字列の描画
    int dx_DrawStringToHandle( int x, int y, const char *String, int Color, int FontHandle, int EdgeColor = 0 , int VerticalFlag = FALSE ) ;    // 文字列を描画する
    int dx_DrawVStringToHandle( int x, int y, const char *String, int Color, int FontHandle, int EdgeColor = 0 ) ;                                // 文字列を描画する
    int dx_DrawFormatString( int x, int y, int Color, const char *FormatString, ... ) ;                                                        // 書式指定文字列を描画する
    int dx_DrawFormatVString( int x, int y, int Color, const char *FormatString, ... ) ;                                                        // 書式指定文字列を描画する
    int dx_DrawFormatStringToHandle( int x, int y, int Color, int FontHandle, const char *FormatString, ... ) ;                                // 書式指定文字列を描画する
    int dx_DrawFormatVStringToHandle( int x, int y, int Color, int FontHandle, const char *FormatString, ... ) ;                                // 書式指定文字列を描画する
    int dx_DrawExtendString( int x, int y, double ExRateX, double ExRateY, const char *String, int Color, int EdgeColor = 0 ) ;                                                    // 文字列の拡大描画
    int dx_DrawExtendVString( int x, int y, double ExRateX, double ExRateY, const char *String, int Color, int EdgeColor = 0 ) ;                                                    // 文字列の拡大描画
    int dx_DrawExtendStringToHandle( int x, int y, double ExRateX, double ExRateY, const char *String, int Color, int FontHandle, int EdgeColor = 0 , int VerticalFlag = FALSE ) ;    // 文字列を拡大描画する
    int dx_DrawExtendVStringToHandle( int x, int y, double ExRateX, double ExRateY, const char *String, int Color, int FontHandle, int EdgeColor = 0 ) ;                            // 文字列を拡大描画する
    int dx_DrawExtendFormatString( int x, int y, double ExRateX, double ExRateY, int Color, const char *FormatString, ... ) ;                                                        // 書式指定文字列を拡大描画する
    int dx_DrawExtendFormatVString( int x, int y, double ExRateX, double ExRateY, int Color, const char *FormatString, ... ) ;                                                        // 書式指定文字列を拡大描画する
    int dx_DrawExtendFormatStringToHandle( int x, int y, double ExRateX, double ExRateY, int Color, int FontHandle, const char *FormatString, ... ) ;                                // 書式指定文字列を拡大描画する
    int dx_DrawExtendFormatVStringToHandle( int x, int y, double ExRateX, double ExRateY, int Color, int FontHandle, const char *FormatString, ... ) ;                                // 書式指定文字列を拡大描画する

    int dx_DrawNumberToI( int x, int y, int Num, int RisesNum, int Color, int EdgeColor = 0 ) ;                                                // 整数型の数値を描画する
    int dx_DrawNumberToF( int x, int y, double Num, int Length, int Color, int EdgeColor = 0 ) ;                                                // 浮動小数点型の数値を描画する
    int dx_DrawNumberPlusToI( int x, int y, const char *NoteString, int Num, int RisesNum, int Color, int EdgeColor = 0 ) ;                        // 整数型の数値とその説明の文字列を一度に描画する
    int dx_DrawNumberPlusToF( int x, int y, const char *NoteString, double Num, int Length, int Color, int EdgeColor = 0 ) ;                    // 浮動小数点型の数値とその説明の文字列を一度に描画する

    int dx_DrawNumberToIToHandle( int x, int y, int Num, int RisesNum, int Color, int FontHandle, int EdgeColor = 0 ) ;                            // 整数型の数値を描画する
    int dx_DrawNumberToFToHandle( int x, int y, double Num, int Length, int Color, int FontHandle, int EdgeColor = 0 ) ;                        // 浮動小数点型の数値を描画する
    int dx_DrawNumberPlusToIToHandle( int x, int y, const char *NoteString, int Num, int RisesNum, int Color, int FontHandle, int EdgeColor = 0 ) ;    // 整数型の数値とその説明の文字列を一度に描画する
    int dx_DrawNumberPlusToFToHandle( int x, int y, const char *NoteString, double Num, int Length, int Color, int FontHandle, int EdgeColor = 0 ) ;    // 浮動小数点型の数値とその説明の文字列を一度に描画する

// トランジション機能関数
//    int dx_SetupTransition( int BlendGraph, int BorderRange ) ;                // トランジション処理の準備を行う
//    in dx_t

// ３Ｄ描画関係関数
//    void dx_SetColorVertexState( LPVERTEXDATA Vertex, float x, float y, float z, float rhw, int red, int green, int blue, int alpha, float tu, float tv ) ;    // ３Ｄ頂点データをセットする  

// 描画設定関係関数
    int dx_SetDrawMode( int DrawMode ) ;                                        // 描画モードをセットする
    int dx_SetDrawBlendMode( int BlendMode, int BlendParam ) ;                    // 描画ブレンドモードをセットする
    int dx_SetBlendGraph( int BlendGraph, int BorderParam, int BorderRange ) ;    // 描画処理時に描画する画像とブレンドするαチャンネル付き画像をセットする( BlendGraph を -1 でブレンド機能を無効 )
    int dx_SetBlendGraphPosition( int x, int y ) ;                                // ブレンド画像の起点座標をセットする
    int dx_SetDrawBright( int RedBright, int GreenBright, int BlueBright ) ;    // 描画輝度をセット
    int dx_SetDrawScreen( int DrawScreen ) ;                                    // 描画先画面のセット
    int dx_SetDrawArea( int x1, int y1, int x2, int y2 ) ;                        // 描画可能領域のセット
    int dx_SetUse3DFlag( int Flag ) ;                                            // ３Ｄ機能を使うか、のフラグをセット
    int dx_SetUseNotManageTextureFlag( int Flag ) ;                            // 非管理テクスチャを使用するか、のフラグをセット( TRUE:使用する  FALSE:使用しない )
    int dx_SetTransColor( int Red, int Green, int Blue ) ;                        // グラフィックに設定する透過色をセットする
    int dx_SetRestoreShredPoint( void (* ShredPoint )() ) ;                // SetRestoreGraphCallback の旧名
    int dx_SetRestoreGraphCallback( void (* Callback )() ) ;                // グラフィックハンドル復元関数の登録
    int dx_RunRestoreShred() ;                                            // グラフィック復元関数の実行
    int dx_SetTransformToWorld( MATRIX *Matrix) ;            // ワールド変換用行列をセットする
    int dx_SetTransformToView( MATRIX *Matrix ) ;                                // ビュー変換用行列をセットする
    int dx_SetTransformToProjection( MATRIX *Matrix ) ;                        // 投影変換用行列をセットする
    int dx_SetTransformToViewport( MATRIX *Matrix ) ;                            // ビューポート行列をセットする
    int dx_SetUseZBufferFlag( int Flag ) ;                                        // Ｚバッファを有効にするか、フラグをセットする
    int dx_SetWriteZBufferFlag( int Flag ) ;                                    // Ｚバッファに書き込みを行うか、フラグをセットする
    int dx_SetZBufferCmpType( int CmpType /* DX_CMP_NEVER 等 */ ) ;            // Ｚ値の比較モードをセットする
    int dx_SetUseCullingFlag( int Flag ) ;                                        // ポリゴンカリングの有効、無効をセットする
    int dx_SetTextureAddressMode( int Mode /* DX_TEXADDRESS_WRAP 等 */ ) ;        // テクスチャアドレスモードを設定する
    int dx_SetDefTransformMatrix() ;                                        // デフォルトの変換行列をセットする
    int dx_SetLeftUpColorIsTransColorFlag( int Flag ) ;                        // 画像左上の色を透過色にするかどうかのフラグをセットする
    int dx_SetUseAlphaChannelGraphCreateFlag( int Flag ) ;                        // αチャンネル付きグラフィックを作成するかどうかのフラグをセットする( TRUE:αチャンネル付き   FALSE:αチャンネル無し )
    int dx_SetUseGraphAlphaChannel( int Flag ) ;                                // SetUseAlphaChannelGraphCreateFlag の旧名称
    int dx_SetUseAlphaTestGraphCreateFlag( int Flag ) ;                        // アルファテストを使用するグラフィックを作成するかどうかのフラグをセットする
    int dx_SetUseAlphaTestFlag( int Flag ) ;                                    // SetUseAlphaTestGraphCreateFlag の旧名称
    int dx_SetDrawValidGraphCreateFlag( int Flag ) ;                            // 描画可能なグラフィックを作成するかどうかのフラグをセットする( TRUE:描画可能  FALSE:描画不可能 )
    int dx_SetDrawValidFlagOf3DGraph( int Flag ) ;                                // SetDrawValidGraphCreateFlag の旧名称
    int dx_SetDrawValidAlphaChannelGraphCreateFlag( int Flag ) ;                // 描画可能なαチャンネル付き画像を作成するかどうかのフラグをセットする,SetDrawValidGraphCreateFlag 関数で描画可能画像を作成するように設定されていないと効果がない( TRUE:αチャンネル付き FALSE:αチャンネルなし )
    int dx_SetUseNoBlendModeParam( int Flag ) ;                                // SetDrawBlendMode 関数の第一引数に DX_BLENDMODE_NOBLEND を代入した際に、デフォルトでは第二引数は内部で２５５を指定したことになるが、その自動２５５化をしないかどうかを設定する( TRUE:しない(第二引数の値が使用される)   FALSE:する(第二引数の値は無視されて 255 が常に使用される)(デフォルト) )αチャンネル付き画像に対して描画を行う場合のみ意味がある関数
    int dx_SetUseSystemMemGraphCreateFlag( int Flag ) ;                        // システムメモリ上にグラフィックを作成するかどうかのフラグをセットする( TRUE:システムメモリ上に作成  FALSE:ＶＲＡＭ上に作成 )
    int dx_SetUseBlendGraphCreateFlag( int Flag ) ;                            // ブレンド処理用画像を作成するかどうかのフラグをセットする
    int dx_SetUseVramFlag( int Flag ) ;                                        // ＶＲＡＭを使用するかのフラグをセットする
    int dx_SetMovieRightImageAlphaFlag( int Flag ) ;                            // 動画ファイルの右半分をアルファ情報として扱うかどうかをセットする( TRUE:アルファ情報として扱う )
    int dx_SetCreateGraphColorBitDepth( int BitDepth ) ;                        // 作成するグラフィックの色深度を設定する
    int dx_SetGraphColorBitDepth( int ColorBitDepth ) ;                        // SetCreateGraphColorBitDepth の旧名称
    int dx_SetGraphDataShavedMode( int ShavedMode ) ;                            // グラフィック減色時の画像劣化緩和処理モードの変更
    int dx_RestoreGraphSystem() ;                                        // ＤＸライブラリのグラフィック関連の復帰処理を行う
    int dx_SetUseBasicGraphDraw3DDeviceMethodFlag( int Flag ) ;                // 単純図形の描画に３Ｄデバイスの機能を使用するかどうかのフラグをセットする
    int dx_SetWindowDrawRect( RECT *DrawRect ) ;                                // 通常使用しない
    int dx_SetDrawZ( float Z ) ;                                                // ２Ｄ描画時にＺバッファに書き込むＺ値を変更する
    int dx_SetUseTransColor( int Flag ) ;                                        // 透過色機能を使用するかどうかを設定する
    int dx_SetUseTransColorGraphCreateFlag( int Flag ) ;                        // 透過色機能を使用することを前提とした画像の読み込み処理を行うかどうかを設定する( TRUE にすると SetDrawMode( DX_DRAWMODE_BILINEAR ); をした状態で DrawGraphF 等の浮動小数点型座標を受け取る関数で小数点以下の値を指定した場合に発生する描画結果の不自然を緩和する効果がある ( デフォルトは FALSE ) )


// グラフィック情報取得関係関数
    int dx_GetTransColor( int *Red, int *Green, int *Blue ) ;                                                // 透過色を得る
//    int dx_GetGraphHandle( IMAGEDATA *GraphData ) ;                                                    // 自分のグラフィックインデックス番号を取得する
//    IMAGEDATA dx_*GetGraphData( int GrHandle ) ;                                                                // グラフィックのデータをインデックス値から取り出す
    int dx_GetDrawScreenGraph( int x1, int y1, int x2, int y2, int GrHandle, int UseClientFlag = TRUE ) ;    // アクティブになっている画面から指定領域のグラフィックを取得する
    DWORD dx_GetFullColorImage( int GrHandle ) ;                                                                // 指定の画像のＡＲＧＢ８のフルカラーイメージを取得する

    int dx_GraphLock( int GrHandle, int *PitchBuf, void **DataPointBuf, COLORDATA **ColorDataPP = null ) ;    // グラフィックメモリ領域のロック
    int dx_GraphUnLock( int GrHandle ) ;                                                                // グラフィックメモリ領域のロック解除

    int dx_SetUseGraphZBuffer( int GrHandle, int UseFlag ) ;                                            // グラフィックにＺバッファを使用するかどうかを設定する

    int dx_GetGraphSize( int GrHandle, int *SizeXBuf, int *SizeYBuf ) ;                                // グラフィックのサイズを得る
    int dx_GetScreenState( int *SizeX, int *SizeY, int *ColorBitDepth ) ;                                // 現在の画面の大きさとカラービット数を得る 
    int dx_GetActiveGraph() ;                                                                    // アクティブになっているグラフィックのハンドルを得る
    int dx_GetDrawArea( RECT *Rect ) ;                                                                    // 描画可能領域を得る
    int dx_GetUse3DFlag() ;                                                                        // 描画に３Ｄ機能を使うかフラグを取得
    int dx_GetUseNotManageTextureFlag() ;                                                        // 非管理テクスチャを使用するか、のフラグを取得する( TRUE:使用する  FALSE:使用しない )
    int dx_GetValidRestoreShredPoint() ;                                                            // グラフィック復元関数の有無を取得                                                                
    int dx_GetFontSize() ;                                                                        // フォントのサイズを得る
    int dx_GetFontSizeToHandle( int FontHandle ) ;                                                        // フォントのサイズを得る
    char dx_GetResourceIDString( int ResourceID ) ;                                                        // リソースＩＤからリソースＩＤ文字列を得る 
    int dx_GetTransformToViewMatrix( MATRIX *MatBuf ) ;                                                // ビュー行列を取得する
    int dx_GetTransformToWorldMatrix( MATRIX *MatBuf ) ;                                                // ワールド行列を取得する
    int dx_GetTransformToProjectionMatrix( MATRIX *MatBuf ) ;                                            // 射影行列を取得する
    int dx_GetTransformPosition( VECTOR *LocalPos, float *x, float *y ) ;                                // ローカル座標から画面座標を取得する
    int dx_SetUseFastLoadFlag( int Flag ) ;                                                            // 高速読み込みルーチンを使うか否かのフラグをセットする
    int dx_GetDrawBlendMode( int *BlendMode, int *BlendParam ) ;                                        // 描画ブレンドモードを取得する
    int dx_GetDrawMode() ;                                                                        // 描画モードを取得する
    int dx_GetDrawBright( int *Red, int *Green, int *Blue ) ;                                            // 描画輝度を取得する
    int dx_GetCreateGraphColorBitDepth() ;                                                        // 作成するグラフィックの色深度を設定する
    int dx_GetGraphColorBitDepth() ;                                                                // GetCreateGraphColorBitDepth の旧名称
    int dx_GetGraphDataShavedMode() ;                                                            // グラフィック減色時の画像劣化緩和処理モードの取得
    int dx_GetUseSystemMemGraphCreateFlag() ;                                                    // システムメモリ上にグラフィックを作成するかどうかのフラグを取得する( TRUE:システムメモリ上に作成  FALSE:ＶＲＡＭ上に作成 )
    int dx_GetUseBlendGraphCreateFlag() ;                                                        // ブレンド処理用画像を作成するかどうかのフラグを取得する
    int dx_GetUseVramFlag() ;                                                                    // ２Ｄグラフィックサーフェス作成時にシステムメモリーを使用するかのフラグ取得
    int dx_GetUseAlphaTestGraphCreateFlag() ;                                                    // アルファテストを使用するグラフィックを作成するかどうかのフラグを取得する
    int dx_GetUseAlphaTestFlag() ;                                                                // GetUseAlphaTestGraphCreateFlag の旧名称
    int dx_GetUseAlphaChannelGraphCreateFlag() ;                                                    // αチャンネル付きグラフィックを作成するかどうかのフラグを取得する( TRUE:αチャンネル付き   FALSE:αチャンネル無し )
    int dx_GetUseGraphAlphaChannel() ;                                                            // GetUseAlphaChannelGraphCreateFlag の旧名称
    int dx_GetDrawValidGraphCreateFlag() ;                                                        // 描画可能なグラフィックを作成するかどうかのフラグを取得する


// 演算ライブラリ
    int dx_CreateIdentityMatrix( MATRIX *Out ) ;                                                        // 単位行列を作成する
    int dx_CreateLookAtMatrix( MATRIX *Out, VECTOR *Eye, VECTOR *At, VECTOR *Up ) ;                    // ビュー行列を作成する
    int dx_CreateLookAtMatrix2( MATRIX *Out, VECTOR *Eye, double XZAngle, double Oira ) ;                // ビュー行列を作成する
    int dx_CreateLookAtMatrixRH( MATRIX *Out, VECTOR *Eye, VECTOR *At, VECTOR *Up ) ;                    // ビュー行列を作成する(右手座標系用)
    int dx_CreateMultiplyMatrix( MATRIX *Out, MATRIX *In1, MATRIX *In2 ) ;                                // 行列の積を求める
    int dx_CreatePerspectiveFovMatrix( MATRIX *Out, float fov, float zn, float zf ) ;                    // 射影行列を作成する
    int dx_CreatePerspectiveFovMatrixRH( MATRIX *Out, float fov, float zn, float zf ) ;                // 射影行列を作成する(右手座標系用)
    int dx_CreateScalingMatrix( MATRIX *Out, float sx, float sy, float sz ) ;                            // スケーリング行列を作成する
    int dx_CreateRotationXMatrix( MATRIX *Out, float Angle ) ;                                            // Ｘ軸を中心とした回転行列を作成する
    int dx_CreateRotationYMatrix( MATRIX *Out, float Angle ) ;                                            // Ｙ軸を中心とした回転行列を作成する
    int dx_CreateRotationZMatrix( MATRIX *Out, float Angle ) ;                                            // Ｚ軸を中心とした回転行列を作成する
    int dx_CreateTranslationMatrix( MATRIX *Out, float x, float y, float z ) ;                            // 平行移動行列を作成する
    int dx_CreateViewportMatrix( MATRIX *Out, float CenterX, float CenterY, float Width, float Height ) ; // ビューポート行列を作成する
    int dx_VectorNormalize( VECTOR *Out, VECTOR *In ) ;                                                // ベクトルを正規化する
    int dx_VectorScale( VECTOR *Out, VECTOR *In, float Scale ) ;                                        // ベクトルをスカラー倍する
    int dx_VectorMultiply( VECTOR *Out, VECTOR *In1, VECTOR *In2 ) ;                                    // ベクトルの掛け算をする
    int dx_VectorSub( VECTOR *Out, VECTOR *In1, VECTOR *In2 ) ;                                        // Out = In1 - In2 のベクトル計算をする 
    int dx_VectorAdd( VECTOR *Out, VECTOR *In1, VECTOR *In2 ) ;                                        // Out = In1 + In2 のベクトル計算をする 
    int dx_VectorOuterProduct( VECTOR *Out, VECTOR *In1, VECTOR *In2 ) ;                                // In1とIn2の外積を計算する
    float dx_VectorInnerProduct( VECTOR *In1, VECTOR *In2 ) ;                                            // In1とIn2の内積を計算する
    int dx_VectorRotationX( VECTOR *Out, VECTOR *In, double Angle ) ;                                    // ベクトルのＸ軸を軸にした回転を行う
    int dx_VectorRotationY( VECTOR *Out, VECTOR *In, double Angle ) ;                                    // ベクトルのＹ軸を軸にした回転を行う
    int dx_VectorRotationZ( VECTOR *Out, VECTOR *In, double Angle ) ;                                    // ベクトルのＺ軸を軸にした回転を行う
    int dx_VectorTransform( VECTOR *Out, VECTOR *InVec, MATRIX *InMatrix ) ;                            // ベクトル行列と4x4正方行列を乗算する( w は 1 と仮定 )
    int dx_VectorTransform4( VECTOR *Out, float *V4Out, VECTOR *InVec, float *V4In, MATRIX *InMatrix ) ; // ベクトル行列と4x4正方行列を乗算する( w の要素を渡す )

// 補助関係
//    int dx_AddUserGraphLoadFunction( int ( *UserLoadFunc )( FILE *fp, BITMAPINFO **BmpInfo, void **GraphData ) ) ;                                        // ユーザー定義のグラフィックロード関数を登録する
//    int dx_AddUserGraphLoadFunction2( int ( *UserLoadFunc )( void *Image, int ImageSize, int ImageType, BITMAPINFO **BmpInfo, void **GraphData ) ) ;    // ユーザー定義のグラフィックロード関数を登録する
//    int dx_AddUserGraphLoadFunction3( int ( *UserLoadFunc )( void *DataImage, int DataImageSize, int DataImageType, int BmpFlag, BASEIMAGE *Image, BITMAPINFO **BmpInfo, void **GraphData ) ) ; // ユーザー定義のグラフィックロード関数Ver3を登録する
    int dx_AddUserGraphLoadFunction4( int (* UserLoadFunc )( STREAMDATA *Src, BASEIMAGE *Image ) ) ;                                                     // ユーザー定義のグラフィックロード関数Ver4を登録する
//    int dx_SubUserGraphLoadFunction( int ( *UserLoadFunc )( FILE *fp, BITMAPINFO **BmpInfo, void **GraphData ) ) ;                                        // ユーザー定義のグラフィックロード関数を登録から抹消する
//    int dx_SubUserGraphLoadFunction2( int ( *UserLoadFunc )( void *Image, int ImageSize, int ImageType, BITMAPINFO **BmpInfo, void **GraphData ) ) ;    // ユーザー定義のグラフィックロード関数を登録から抹消する
//    int dx_SubUserGraphLoadFunction3( int ( *UserLoadFunc )( void *DataImage, int DataImageSize, int DataImageType, int BmpFlag, BASEIMAGE *Image, BITMAPINFO **BmpInfo, void **GraphData ) ) ; // ユーザー定義のグラフィックロード関数Ver3を登録から抹消する
    int dx_SubUserGraphLoadFunction4( int (* UserLoadFunc )( STREAMDATA *Src, BASEIMAGE *Image ) ) ;                                                     // ユーザー定義のグラフィックロード関数Ver4を登録から抹消する
    int dx_RectClipping( RECT *MotoRect, RECT *ClippuRect ) ;                                                            // 矩形のクリッピング
    int dx_GetCreateGraphColorData( COLORDATA *ColorData, IMAGEFORMATDESC *Format ) ;                                    // これから新たにグラフィックを作成する場合に使用するカラー情報を取得する

// フォント、文字列描画関係関数
    int dx_EnumFontName( char *NameBuffer, int NameBufferNum, int JapanOnlyFlag = TRUE ) ;                                // 使用可能なフォントの名前をすべて列挙する
    int dx_InitFontToHandle() ;                                                                                    // フォントのステータスをデフォルトに戻す
    int dx_CreateFontToHandle( const char *FontName, int Size, int Thick, int FontType = -1 , int CharSet = -1 , int EdgeSize = -1 , int Italic = FALSE , int DataIndex = -1 , int ID = -1 ) ;            // 新しいフォントデータを作成
    int dx_SetFontSpaceToHandle( int Point, int FontHandle ) ;                                                            // 字間を変更する
    int dx_SetDefaultFontState( const char *FontName, int Size, int Thick ) ;                                            // デフォルトフォントのステータスを一括設定する
    int dx_DeleteFontToHandle( int FontHandle ) ;                                                                        // フォントキャッシュの制御を終了する
    int dx_SetFontLostFlag( int FontHandle, int *LostFlag ) ;                                                            // 解放時に TRUE にするフラグへのポインタを設定する
    int dx_SetFontSize( int FontSize ) ;                                                                                // 描画するフォントのサイズをセットする
    int dx_SetFontThickness( int ThickPal ) ;                                                                            // フォントの太さをセット
    int dx_SetFontSpace( int Point ) ;                                                                                    // 字間を変更する
    int dx_SetFontCacheToTextureFlag( int Flag ) ;                                                                        // フォントのキャッシュにテクスチャを使用するか、フラグをセットする
    int dx_SetFontChacheToTextureFlag( int Flag ) ;                                                                    // フォントのキャッシュにテクスチャを使用するか、フラグをセットする(誤字版)
    int dx_SetFontCacheCharNum( int CharNum ) ;                                                                        // フォントキャッシュでキャッシュできる文字数を指定する
    int dx_ChangeFont( const char *FontName, int CharSet = -1 /* DX_CHARSET_SHFTJIS */ ) ;                                // フォントを変更
    int dx_ChangeFontType( int FontType ) ;                                                                            // フォントタイプの変更
// FontCacheStringDraw は DrawString を使ってください
    int dx_FontCacheStringDrawToHandle( int x, int y, const char *StrData, int Color, int EdgeColor,
                                                    BASEIMAGE *DestImage, RECT *ClipRect /* null 可 */ , int FontHandle,
                                                    int VerticalFlag = FALSE , SIZE *DrawSizeP = null ) ;

    int dx_GetFontMaxWidth() ;                                                                                    // 文字の最大幅を得る
    int dx_GetFontMaxWidthToHandle( int FontHandle ) ;                                                                    // 文字の最大幅を得る
    int dx_GetDrawStringWidth( const char *String, int StrLen, int VerticalFlag = FALSE ) ;                            // 文字列の幅を得る
    int dx_GetDrawFormatStringWidth( const char *FormatString, ... ) ;                                                    // 書式付き文字列の描画幅を得る
    int dx_GetDrawStringWidthToHandle( const char *String, int StrLen, int FontHandle, int VerticalFlag = FALSE ) ;    // 文字列の幅を得る
    int dx_GetDrawFormatStringWidthToHandle( int FontHandle, const char *FormatString, ... ) ;                            // 書式付き文字列の描画幅を得る
    int dx_GetDrawExtendStringWidth( double ExRateX, const char *String, int StrLen, int VerticalFlag = FALSE ) ;                            // 文字列の幅を得る
    int dx_GetDrawExtendFormatStringWidth( double ExRateX, const char *FormatString, ... ) ;                                                // 書式付き文字列の描画幅を得る
    int dx_GetDrawExtendStringWidthToHandle( double ExRateX, const char *String, int StrLen, int FontHandle, int VerticalFlag = FALSE ) ;    // 文字列の幅を得る
    int dx_GetDrawExtendFormatStringWidthToHandle( double ExRateX, int FontHandle, const char *FormatString, ... ) ;                        // 書式付き文字列の描画幅を得る
    int dx_GetFontStateToHandle( char *FontName, int *Size, int *Thick, int FontHandle) ;                                // フォントの情報を得る
    int dx_GetDefaultFontHandle() ;                                                                                // デフォルトのフォントのハンドルを得る
    int dx_GetFontChacheToTextureFlag() ;                                                                        // フォントにテクスチャキャッシュを使用するかどうかを取得する
    int dx_CheckFontChacheToTextureFlag( int FontHandle ) ;                                                            // 指定のフォントがテクスチャキャッシュを使用しているかどうかを得る
//    LPFONTMANAGE dx_GetFontManageDataToHandle( int FontHandle ) ;                                                                // フォント管理データの取得
    int dx_CheckFontHandleValid( int FontHandle ) ;                                                                    // 指定のフォントハンドルが有効か否か調べる
    int dx_MultiByteCharCheck( const char *Buf, int CharSet /* DX_CHARSET_SHFTJIS */ ) ;                                    // ２バイト文字か調べる( TRUE:２バイト文字  FALSE:１バイト文字 )
    int dx_GetFontCacheCharNum() ;                                                                                // フォントキャッシュでキャッシュできる文字数を取得する( 戻り値  0:デフォルト  1以上:指定文字数 )


// マスク関係
    int dx_CreateMaskScreen() ;                                                                                // マスクスクリーンを作成する
    int dx_DeleteMaskScreen() ;                                                                                // マスクスクリーンを削除する
    void dx_GetMaskSurface() ; /* 戻り値を IDirectDrawSurface7 * にキャストして下さい */                        // マスクサーフェスを取得する
//    MEMIMG dx_*GetMaskMemImg() ;                                                                                // マスクサーフェスの代わりの MEMIMG を取得する
    int dx_DrawMaskToDirectData( int x, int y, int Width, int Height, void *MaskData , int TransMode ) ;            // マスクのデータを直接セット
    int dx_DrawFillMaskToDirectData( int x1, int y1, int x2, int y2,  int Width, int Height, void *MaskData ) ;    // マスクのデータを直接マスク画面全体に描画する

    int dx_SetUseMaskScreenFlag( int ValidFlag ) ;                                                                    // マスク使用モードを変更
    int dx_GetUseMaskScreenFlag() ;                                                                            // マスク使用モードの取得
    int dx_FillMaskScreen( int Flag ) ;                                                                            // マスクスクリーンを指定の色で塗りつぶす

    int dx_InitMask() ;                                                                                        // マスクデータを初期化する
    int dx_MakeMask( int Width, int Height ) ;                                                                        // マスクデータの追加
    int dx_GetMaskSize( int *WidthBuf, int *HeightBuf, int MaskHandle ) ;                                            // マスクの大きさを得る 
    int dx_SetDataToMask( int Width, int Height, void *MaskData, int MaskHandle ) ;                                // マスクのデータをマスクに転送する
    int dx_DeleteMask( int MaskHandle ) ;                                                                            // マスクデータを削除
    int dx_BmpBltToMask( HBITMAP Bmp, int BmpPointX, int BmpPointY, int MaskHandle ) ;                                // マスクデータにＢＭＰデータをマスクデータと見たてて転送
    int dx_LoadMask( const char *FileName ) ;                                                                        // マスクデータをロードする
    int dx_LoadDivMask( const char *FileName, int AllNum, int XNum, int YNum, int XSize, int YSize, int *HandleBuf ) ;    // マスクを画像から分割読みこみ
    int dx_DrawMask( int x, int y, int MaskHandle, int TransMode ) ;                                                // マスクをセットする
    int dx_DrawFormatStringMask( int x, int y, int Flag, const char *FormatString, ... ) ;                            // 書式指定ありの文字列をマスクスクリーンに描画する
    int dx_DrawFormatStringMaskToHandle( int x, int y, int Flag, int FontHandle, const char *FormatString, ... ) ;    // 書式指定ありの文字列をマスクスクリーンに描画する(フォントハンドル指定版)
    int dx_DrawStringMask( int x, int y, int Flag, const char *String ) ;                                            // 文字列をマスクスクリーンに描画する
    int dx_DrawStringMaskToHandle( int x, int y, int Flag, int FontHandle, const char *String ) ;                    // 文字列をマスクスクリーンに描画する(フォントハンドル指定版)
    int dx_DrawFillMask( int x1, int y1, int x2, int y2, int MaskHandle ) ;                                        // 指定のマスクを画面いっぱいに展開する    
    int dx_SetMaskTransColor( int ColorCode ) ;                                                                    // マスクに使う透過色のセット
    int dx_SetMaskReverseEffectFlag( int ReverseFlag ) ;                                                            // マスクの数値に対する効果を逆転させる

    int dx_GetMaskScreenData( int x1, int y1, int x2, int y2, int MaskHandle ) ;                                    // マスク画面上の描画状態を取得する
    int dx_GetMaskUseFlag() ;                                                                                // マスクスクリーンを使用中かフラグの取得


// 基本イメージデータ機能公開用関数
    int dx_LoadSoftImage( const char *FileName ) ;                                                                        // ソフトウエアで扱うイメージの読み込み( -1:エラー  -1以外:イメージハンドル )
    int dx_LoadSoftImageToMem( void *FileImage, int FileImageSize ) ;                                                    // ソフトウエアで扱うイメージのメモリからの読み込み( -1:エラー  -1以外:イメージハンドル )
    int dx_MakeSoftImage( int SizeX, int SizeY ) ;                                                                        // ソフトウエアで扱うイメージの作成( -1:エラー  -1以外:イメージハンドル )
    int dx_MakeARGB8ColorSoftImage( int SizeX, int SizeY ) ;                                                            // ソフトウエアで扱うイメージの作成( RGBA8 カラー )
    int dx_MakeXRGB8ColorSoftImage( int SizeX, int SizeY ) ;                                                            // ソフトウエアで扱うイメージの作成( XRGB8 カラー )
    int dx_MakeRGB8ColorSoftImage( int SizeX, int SizeY ) ;                                                            // ソフトウエアで扱うイメージの作成( RGB8 カラー )
    int dx_MakePAL8ColorSoftImage( int SizeX, int SizeY ) ;                                                            // ソフトウエアで扱うイメージの作成( パレット２５６色 カラー )

    int dx_DeleteSoftImage( int SIHandle ) ;                                                                            // ソフトウエアで扱うイメージの解放

    int dx_GetSoftImageSize( int SIHandle, int *Width, int *Height ) ;                                                    // ソフトウエアで扱うイメージのサイズを取得する

    int dx_FillSoftImage( int SIHandle, int r, int g, int b, int a ) ;                                                    // ソフトウエアで扱うイメージを指定色で塗りつぶす(各色要素は０～２５５)
    int dx_GetPaletteSoftImage( int SIHandle, int PaletteNo, int *r, int *g, int *b, int *a ) ;                        // ソフトウエアで扱うイメージのパレットを取得する(各色要素は０～２５５)
    int dx_SetPaletteSoftImage( int SIHandle, int PaletteNo, int  r, int  g, int  b, int  a ) ;                        // ソフトウエアで扱うイメージのパレットをセットする(各色要素は０～２５５)
    int dx_DrawPixelPalCodeSoftImage( int SIHandle, int x, int y, int palNo ) ;                                        // ソフトウエアで扱うイメージの指定座標にドットを描画する(パレット画像用、有効値は０～２５５)
    int dx_GetPixelPalCodeSoftImage( int SIHandle, int x, int y ) ;                                                    // ソフトウエアで扱うイメージの指定座標の色コードを取得する(パレット画像用、戻り値は０～２５５)
    int dx_DrawPixelSoftImage( int SIHandle, int x, int y, int  r, int  g, int  b, int  a ) ;                            // ソフトウエアで扱うイメージの指定座標にドットを描画する(各色要素は０～２５５)
    int dx_GetPixelSoftImage(  int SIHandle, int x, int y, int *r, int *g, int *b, int *a ) ;                            // ソフトウエアで扱うイメージの指定座標の色を取得する(各色要素は０～２５５)
    int dx_BltSoftImage( int SrcX, int SrcY, int SrcSizeX, int SrcSizeY, int SrcSIHandle, int DestX, int DestY, int DestSIHandle ) ;    // ソフトウエアで扱うイメージを別のイメージ上に転送する
    int dx_DrawSoftImage( int x, int y, int SIHandle ) ;                                                                // ソフトウエアで扱うイメージを画面に描画する

    int dx_CreateGraphFromSoftImage( int SIHandle ) ;                                                                    // ソフトウエアで扱うイメージからグラフィックハンドルを作成する( -1:エラー  -1以外:グラフィックハンドル )
    int dx_ReCreateGraphFromSoftImage( int SIHandle, int GrHandle ) ;                                                    // ソフトウエアで扱うイメージから既存のグラフィックハンドルに画像データを転送する
    int dx_CreateDivGraphFromSoftImage( int SIHandle, int AllNum, int XNum, int YNum, int SizeX, int SizeY, int *HandleBuf ) ;        // ソフトウエアで扱うイメージから分割グラフィックハンドルを作成する


// 基本イメージデータ構造体関係
    int dx_CreateBaseImage(  const char *FileName, void *FileImage, int FileImageSize, int DataType/*=LOADIMAGE_TYPE_FILE*/, BASEIMAGE *BaseImage, int ReverseFlag ) ;                                                                                        // 各種グラフィックデータから基本イメージデータを構築する
    int dx_CreateGraphImage( const char *FileName, void *DataImage, int DataImageSize, int DataImageType, BASEIMAGE *GraphImage, int ReverseFlag ) ;                                                                                                        // CreateBaseImage の旧名称
    int dx_CreateBaseImageToFile( const char *FileName,               BASEIMAGE *BaseImage, int ReverseFlag = FALSE ) ;                                                                                                                                    // 画像ファイルから基本イメージデータを構築する
    int dx_CreateBaseImageToMem(  void *FileImage, int FileImageSize, BASEIMAGE *BaseImage, int ReverseFlag = FALSE ) ;                                                                                                                                    // メモリ上に展開された画像ファイルから基本イメージデータを構築する
    int dx_CreateARGB8ColorBaseImage( int SizeX, int SizeY, BASEIMAGE *BaseImage ) ;                                                                                                                                                                        // ＡＲＧＢ８カラーの空の基本イメージデータを作成する
    int dx_CreateXRGB8ColorBaseImage( int SizeX, int SizeY, BASEIMAGE *BaseImage ) ;                                                                                                                                                                        // ＸＲＧＢ８カラーの空の基本イメージデータを作成する
    int dx_CreateRGB8ColorBaseImage( int SizeX, int SizeY, BASEIMAGE *BaseImage ) ;                                                                                                                                                                        // ＲＧＢ８カラーの空の基本イメージデータを作成する
    int dx_CreatePAL8ColorBaseImage( int SizeX, int SizeY, BASEIMAGE *BaseImage ) ;                                                                                                                                                                        // パレット８ビットカラーの空の基本イメージデータを作成する

    int dx_ReleaseBaseImage(  BASEIMAGE *BaseImage ) ;                                                                                                                                                                                                        // 基本イメージデータの後始末を行う
    int dx_ReleaseGraphImage( BASEIMAGE *GraphImage ) ;                                                                                                                                                                                                    // ReleaseBaseImage の旧名称

    int dx_FillBaseImage( BASEIMAGE *BaseImage, int r, int g, int b, int a ) ;                                                                                                                                                                                // 基本イメージデータを指定の色で塗りつぶす
    int dx_GetPaletteBaseImage( BASEIMAGE *BaseImage, int PaletteNo, int *r, int *g, int *b, int *a ) ;                                                                                                                                                    // 基本イメージデータのパレットを取得する
    int dx_SetPaletteBaseImage( BASEIMAGE *BaseImage, int PaletteNo, int  r, int  g, int  b, int  a ) ;                                                                                                                                                    // 基本イメージデータのパレットをセットする
    int dx_SetPixelPalCodeBaseImage( BASEIMAGE *BaseImage, int x, int y, int palNo ) ;                                                                                                                                                                        // 基本イメージデータの指定の座標の色コードを変更する(パレット画像用)
    int dx_GetPixelPalCodeBaseImage( BASEIMAGE *BaseImage, int x, int y ) ;                                                                                                                                                                                // 基本イメージデータの指定の座標の色コードを取得する(パレット画像用)
    int dx_SetPixelBaseImage( BASEIMAGE *BaseImage, int x, int y, int  r, int  g, int  b, int  a ) ;                                                                                                                                                        // 基本イメージデータの指定の座標の色を変更する(各色要素は０～２５５)
    int dx_GetPixelBaseImage( BASEIMAGE *BaseImage, int x, int y, int *r, int *g, int *b, int *a ) ;                                                                                                                                                        // 基本イメージデータの指定の座標の色を取得する(各色要素は０～２５５)
    int dx_BltBaseImage( int SrcX, int SrcY, int SrcSizeX, int SrcSizeY, int DestX, int DestY, BASEIMAGE *SrcBaseImage, BASEIMAGE *DestBaseImage ) ;                                                                                                        // 基本イメージデータを転送する
    int dx_BltBaseImage( int DestX, int DestY, BASEIMAGE *SrcBaseImage, BASEIMAGE *DestBaseImage ) ;                                                                                                                                                            // 基本イメージデータを転送する
    int dx_DrawBaseImage( int x, int y, BASEIMAGE *BaseImage ) ;                                                                                                                                                                                            // 基本イメージデータを描画する

    int dx_CreateGraphFromBaseImage( BASEIMAGE *BaseImage ) ;                                                                                                                                                                                                // 基本イメージデータからグラフィックハンドルを作成する
    int dx_ReCreateGraphFromBaseImage( BASEIMAGE *BaseImage, int GrHandle ) ;                                                                                                                                                                                // 基本イメージデータから既存のグラフィックハンドルに画像データを転送する
    int dx_CreateDivGraphFromBaseImage( BASEIMAGE *BaseImage, int AllNum, int XNum, int YNum, int SizeX, int SizeY, int *HandleBuf ) ;                                                                                                                        // 基本イメージデータから分割グラフィックハンドルを作成する


// 画像作成用関係
    int dx_CreateGraphFromMem( void *MemImage, int MemImageSize, void *AlphaImage = null , int AlphaImageSize = 0 , int TextureFlag = TRUE , int ReverseFlag = FALSE ) ;                                                                                        // メモリ上のグラフィックイメージからグラフィックハンドルを作成する
    int dx_ReCreateGraphFromMem( void *MemImage, int MemImageSize, int GrHandle, void *AlphaImage = null , int AlphaImageSize = 0 , int TextureFlag = TRUE , int ReverseFlag = FALSE ) ;                                                                        // メモリ上のグラフィックイメージから既存のグラフィックハンドルにデータを転送する
    int dx_CreateDivGraphFromMem( void *MemImage, int MemImageSize, int AllNum, int XNum, int YNum, int SizeX, int SizeY, int *HandleBuf, int TextureFlag = TRUE , int ReverseFlag = FALSE , void *AlphaImage = null , int AlphaImageSize = 0 ) ;                // メモリ上のグラフィックイメージから分割グラフィックハンドルを作成する
    int dx_ReCreateDivGraphFromMem( void *MemImage, int MemImageSize, int AllNum, int XNum, int YNum, int SizeX, int SizeY, int *HandleBuf, int TextureFlag = TRUE , int ReverseFlag = FALSE , void *AlphaImage = null , int AlphaImageSize = 0 ) ;            // メモリ上のグラフィックイメージから既存の分割グラフィックハンドルにデータを転送する
    int dx_CreateGraphFromBmp( BITMAPINFO *BmpInfo, void *GraphData, BITMAPINFO *AlphaInfo = null , void *AlphaData = null , int TextureFlag = TRUE , int ReverseFlag = FALSE ) ;                                                                                // ビットマップデータからグラフィックハンドルを作成する
    int dx_ReCreateGraphFromBmp( BITMAPINFO *BmpInfo, void *GraphData, int GrHandle, BITMAPINFO *AlphaInfo = null , void *AlphaData = null , int TextureFlag = TRUE , int ReverseFlag = FALSE ) ;                                                                // ビットマップデータから既存のグラフィックハンドルにデータを転送する
    int dx_CreateDivGraphFromBmp( BITMAPINFO *BmpInfo, void *GraphData, int AllNum, int XNum, int YNum, int SizeX, int SizeY, int *HandleBuf, int TextureFlag = TRUE , int ReverseFlag = FALSE , BITMAPINFO *AlphaInfo = null , void *AlphaData = null ) ;        // ビットマップデータから分割グラフィックハンドルを作成する
    int dx_ReCreateDivGraphFromBmp( BITMAPINFO *BmpInfo, void *GraphData, int AllNum, int XNum, int YNum, int SizeX, int SizeY, int *HandleBuf, int TextureFlag = TRUE , int ReverseFlag = FALSE , BITMAPINFO *AlphaInfo = null , void *AlphaData = null ) ;    // ビットマップデータから既存の分割グラフィックハンドルにデータを転送する
    int dx_CreateGraphFromGraphImage( BASEIMAGE *Image, int TextureFlag = TRUE , int ReverseFlag = FALSE , int DataReverseFlag = TRUE ) ;                                                                                                                    // GraphImageデータからグラフィックハンドルを作成する
    int dx_CreateGraphFromGraphImage( BASEIMAGE *Image, BASEIMAGE *AlphaImage, int TextureFlag = TRUE , int ReverseFlag = FALSE , int DataReverseFlag = TRUE ) ;                                                                                                // GraphImageデータからグラフィックハンドルを作成する
    int dx_ReCreateGraphFromGraphImage( BASEIMAGE *Image, int GrHandle, int TextureFlag = TRUE , int ReverseFlag = FALSE , int DataReverseFlag = TRUE ) ;                                                                                                    // GraphImageデータから既存のグラフィックハンドルにデータを転送する
    int dx_ReCreateGraphFromGraphImage( BASEIMAGE *Image, BASEIMAGE *AlphaImage, int GrHandle, int TextureFlag = TRUE , int ReverseFlag = FALSE , int DataReverseFlag = TRUE ) ;                                                                                // GraphImageデータから既存のグラフィックハンドルにデータを転送する
    int dx_CreateDivGraphFromGraphImage( BASEIMAGE *Image, int AllNum, int XNum, int YNum, int SizeX, int SizeY, int *HandleBuf, int TextureFlag = TRUE , int ReverseFlag = FALSE , int DataReverseFlag = TRUE ) ;                                            // GraphImageデータから分割グラフィックハンドルを作成する
    int dx_CreateDivGraphFromGraphImage( BASEIMAGE *Image, BASEIMAGE *AlphaImage, int AllNum, int XNum, int YNum, int SizeX, int SizeY, int *HandleBuf, int TextureFlag = TRUE , int ReverseFlag = FALSE , int DataReverseFlag = TRUE ) ;                        // GraphImageデータから分割グラフィックハンドルを作成する
    int dx_ReCreateDivGraphFromGraphImage( BASEIMAGE *Image, int AllNum, int XNum, int YNum, int SizeX, int SizeY, int *HandleBuf, int TextureFlag = TRUE , int ReverseFlag = FALSE , int DataReverseFlag = TRUE ) ;                                            // GraphImageデータから既存の分割グラフィックハンドルにデータを転送する
    int dx_ReCreateDivGraphFromGraphImage( BASEIMAGE *Image, BASEIMAGE *AlphaImage, int AllNum, int XNum, int YNum, int SizeX, int SizeY, int *HandleBuf, int TextureFlag = TRUE , int ReverseFlag = FALSE , int DataReverseFlag = TRUE ) ;                    // GraphImageデータから既存の分割グラフィックハンドルにデータを転送する
    int dx_SetGraphName( int Handle, const char *GraphName ) ;                                                                                                                                                                                                // 特定のファイルから画像を読み込んだ場合のファイルパスをセットする
    int dx_CreateGraph( int Width, int Height, int Pitch, void *GraphData, void *AlphaData = null , int GrHandle = -1 ) ;                                                                                                                                    // メモリ上のグラフィックデータからグラフィックハンドルを作成する
    int dx_CreateDivGraph( int Width, int Height, int Pitch, void *GraphData, int AllNum, int XNum, int YNum, int SizeX, int SizeY, int *HandleBuf, void *AlphaData = null ) ;                                                                                // メモリ上のグラフィックデータから分割グラフィックハンドルを作成する
    int dx_ReCreateGraph( int Width, int Height, int Pitch, void *GraphData, int GrHandle, void *AlphaData = null ) ;                                                                                                                                        // メモリ上のグラフィックデータからグラフィックハンドルを再作成する
    int dx_CreateBmpInfo( BITMAPINFO *BmpInfo, int Width, int Height, int Pitch, void *SrcGrData, void **DestGrData ) ;                                                                                                                                    // フルカラー形式のBITMAPINFO構造体を作成する
    HBITMAP dx_CreateDIBGraphVer2( const char *FileName, void *MemImage, int MemImageSize, int ImageType, int ReverseFlag, COLORDATA *SrcColor ) ;                                                                                                                // ＤＩＢグラフィックを作成する(バージョン２)
    int dx_CreateDIBGraphVer2_plus_Alpha( const char *FileName, void *MemImage, int MemImageSize, void *AlphaImage, int AlphaImageSize, int ImageType, HBITMAP *RGBBmp, HBITMAP *AlphaBmp, int ReverseFlag, COLORDATA *SrcColor ) ;                        // ＤＩＢグラフィックを作成する
    DWORD dx_GetGraphImageFullColorCode( BASEIMAGE *GraphImage, int x, int y ) ;                                                                                                                                                                                // BASEIMAGE 構造体の画像情報から指定の座標のフルカラーコードを取得する
    int dx_CreateGraphImageType2( STREAMDATA *Src, BASEIMAGE *Dest ) ;                                                                                                                                                                                        // 汎用読み込み処理によるグラフィックイメージ構築関数( 0:成功  -1:失敗 )
    int dx_CreateGraphImage_plus_Alpha( const char *FileName, void *RgbImage, int RgbImageSize, int RgbImageType,
                                                    void *AlphaImage, int AlphaImageSize, int AlphaImageType,
                                                    BASEIMAGE *RgbGraphImage, BASEIMAGE *AlphaGraphImage, int ReverseFlag ) ;                                                                                                                                    // 各種グラフィックデータからグラフィックイメージデータとアルファマップ用イメージデータを構築する
    int dx_CreateGraphImageOrDIBGraph( const char *FileName, void *DataImage, int DataImageSize, int DataImageType, int BmpFlag, int ReverseFlag, BASEIMAGE *Image, BITMAPINFO **BmpInfo, void **GraphData ) ;                                                // 登録されている各種グラフィックローダ関数から、ＢＭＰデータもしくは GraphImageデータを構築する
    int dx_ReverseGraphImage( BASEIMAGE *GraphImage ) ;                                                                                                                                                                                                    // 指定の GraphImage を左右反転する
    int dx_ConvBitmapToGraphImage( BITMAPINFO *BmpInfo, void *GraphData, BASEIMAGE *GraphImage, int CopyFlag ) ;                                                                                                                                            // ＢＭＰ を GraphImage に変換する( Ret 0:正常終了  1:コピーを行った  -1:エラー )
    int dx_ConvGraphImageToBitmap( BASEIMAGE *GraphImage, BITMAPINFO *BmpInfo, void **GraphData, int CopyFlag, int FullColorConv = TRUE ) ;                                                                                                                // GraphImage を ＢＭＰ に変換する(アルファデータはあっても無視される)( Ret 0:正常終了  1:コピーを行った  -1:エラー )
    HBITMAP dx_CreateDIBGraph( const char *FileName, int ReverseFlag, COLORDATA *SrcColor) ;                                                                                                                                                                    // ＤＩＢグラフィックを作成する
    HBITMAP dx_CreateDIBGraphToMem( BITMAPINFO *BmpInfo, void *GraphData, int ReverseFlag, COLORDATA *SrcColor ) ;                                                                                                                                                // ＤＩＢグラフィックをメモリイメージから作成する
    int dx_CreateDIBGraph_plus_Alpha( const char *FileName, HBITMAP *RGBBmp, HBITMAP *AlphaBmp, int ReverseFlag = FALSE , COLORDATA *SrcColor = null ) ;                                                                                                    // ファイルからＤＩＢグラフィックとマスクグラフィックを作成する
    int dx_CreateDXGraph( BASEIMAGE *RgbImage, BASEIMAGE *AlphaImage, int TextureFlag ) ;                                                                                                                                                                    // GraphImage データからサイズを割り出し、それに合ったグラフィックハンドルを作成する
    int dx_CreateDXDivGraph( BASEIMAGE *RgbImage, BASEIMAGE *AlphaImage, int AllNum, int XNum, int YNum, int SizeX, int SizeY, int *HandleBuf, int TextureFlag ) ;                                                                                            // GraphImage データに合ったサイズの分割グラフィックハンドルを作成する
    int dx_DerivationGraph( int SrcX, int SrcY, int Width, int Height, int SrcGraphHandle ) ;                                                                                                                                                                // 指定のグラフィックの指定部分だけを抜き出して新たなグラフィックハンドルを作成する



// ムービーグラフィック関係関数
    int dx_PlayMovie( const char *FileName, int ExRate, int PlayType ) ;                                    // 動画ファイルの再生
    int dx_OpenMovieToGraph( const char *FileName, int FullColor = TRUE ) ;                                // ムービーを開く
    static if(OLD_VERSION){
        int dx_PlayMovieToGraph( int GraphHandle, int PlayType = DX_PLAYTYPE_BACK) ; /// ムービーグラフィックに含まれるムービーの再生を開始する
    }else{
        int dx_PlayMovieToGraph( int GraphHandle, int PlayType = DX_PLAYTYPE_BACK, int SysPlay = 0 ) ; /// ムービーグラフィックに含まれるムービーの再生を開始する
    }
    static if(OLD_VERSION){
        int dx_PauseMovieToGraph( int GraphHandle) ; /// ムービーグラフィックに含まれるムービーの再生をストップする
    }else{
        int dx_PauseMovieToGraph( int GraphHandle, int SysPause = 0 ) ; /// ムービーグラフィックに含まれるムービーの再生をストップする
    }
    int dx_AddMovieFrameToGraph( int GraphHandle, uint FrameNum ) ;                                // ムービーのフレームを進める、戻すことは出来ない( ムービーが停止状態で、且つ Ogg Theora のみ有効 )
    int dx_SeekMovieToGraph( int GraphHandle, int Time ) ;                                                    // ムービーの再生位置を設定する(ミリ秒単位)
    int dx_GetMovieStateToGraph( int GraphHandle ) ;                                                        // ムービーの再生状態を得る
    int dx_SetMovieVolumeToGraph( int Volume, int GraphHandle ) ;                                            // ムービーのボリュームをセットする(0～10000)
    BASEIMAGE dx_GetMovieBaseImageToGraph( int GraphHandle ) ;                                                // ムービーの基本イメージデータを取得する
    int dx_GetMovieTotalFrameToGraph( int GraphHandle ) ;                                                    // ムービーの総フレーム数を得る( Ogg Theora でのみ有効 )
    int dx_TellMovieToGraph( int GraphHandle ) ;                                                            // ムービーの再生位置を取得する(ミリ秒単位)
    int dx_TellMovieToGraphToFrame( int GraphHandle ) ;                                                    // ムービーの再生位置を取得する(フレーム単位)
    int dx_SeekMovieToGraphToFrame( int GraphHandle, int Frame ) ;                                            // ムービーの再生位置を設定する(フレーム単位)
    LONGLONG dx_GetOneFrameTimeMovieToGraph( int GraphHandle ) ;                                                // ムービーの１フレームあたりの時間を得る



