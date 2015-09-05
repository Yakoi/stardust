module dxlib.dxdraw;
import dxlib.all;
import core.sys.windows.windows;
    extern(Windows):
// DxDraw.cpp関数プロトタイプ宣言

// 設定関係関数
    int dx_Set2D3DKyouzonFlag( int Flag ) ;                            // ３Ｄと２Ｄの共存率を上げるフラグのセット
    int dx_SetWaitVSyncFlag( int Flag ) ;                                // ＶＳＹＮＣ待ちをするかのフラグセット
    int dx_SetNotUse3DFlag( int Flag ) ;                                // ３Ｄ機能を使わないフラグのセット
    int dx_SetBasicBlendFlag( int Flag ) ;                                // 簡略化ブレンド処理を行うか否かのフラグをセットする
    int dx_SetScreenMemToVramFlag( int Flag ) ;                        // 画面データをＶＲＡＭに置くか、フラグ
    int dx_SetUseSoftwareRenderModeFlag( int Flag ) ;                    // ソフトウエアレンダリングモードを使用するかどうかをセットする
    int dx_SetUseDirectDrawFlag( int Flag ) ;                            // ＤｉｒｅｃｔＤｒａｗを使用するかどうかをセットする
    int dx_SetUseGDIFlag( int Flag ) ;                                    // ＧＤＩ描画を必要とするか、を変更する
    int dx_SetDDrawUseGuid( GUID *Guid ) ;                                // ＤｉｒｅｃｔＤｒａｗが使用するＧＵＤＩを設定する
    int dx_SetDisplayRefreshRate( int RefreshRate ) ;                    // フルスクリーン時の画面のリフレッシュレートを変更する(Windows2000以降のみ有効)
    int dx_SetMultiThreadFlag( int Flag ) ;                            // DirectDraw の協調レベルをマルチスレッド対応にするかどうかをセットする
    int dx_SetUseDirectDrawDeviceIndex( int Index ) ;                    // 使用する DirectDraw デバイスのインデックスを設定する
    int dx_SetUseTempFrontScreen( int Flag ) ;                            // 一時退避用表画面を使用するかどうかを設定する( TRUE:使用する  FALSE:使用しない )
    int dx_SetEmulation320x240( int Flag ) ;                            // ６４０ｘ４８０の画面で３２０ｘ２４０の画面解像度にするかどうかのフラグをセットする、６４０ｘ４８０以外の解像度では無効( TRUE:有効  FALSE:無効 )

// ＤｉｒｅｃｔＤｒａｗ関係情報提供関数
    pure int dx_GetDrawScreenSize( int *XBuf, int *YBuf ) ;                            // 描画サイズを取得する
    pure int dx_GetScreenBitDepth() ;                                            // 使用色ビット数を返す
    pure int dx_GetWaitVSyncFlag() ;                                            // ＶＳＹＮＣ待ちをする設定になっているかどうかを取得する
    int dx_GetBmpSurf3DRenderingValidState( int BmpIndex ) ;                    // 指定のインデックスのビットマップデータが３Ｄデバイスによる描画が可能かどうかを取得する( TRUE:出来る  FALSE:出来ない )
    void dx_GetDrawTargetSurface() ;    /* 戻り値を IDirectDrawSurface7 * にキャストして下さい */        // 描画対象となっているサーフェスを取得
    void dx_GetPrimarySurface() ;        /* 戻り値を IDirectDrawSurface7 * にキャストして下さい */        // プライマリサーフェスを取得
    void dx_GetBackSurface() ;        /* 戻り値を IDirectDrawSurface7 * にキャストして下さい */        // バックサーフェスを取得
    void dx_GetWorkSurface() ;        /* 戻り値を IDirectDrawSurface7 * にキャストして下さい */        // 作業用サーフェスを取得
    int dx_GetDesktopDrawCmp() ;                                            // デスクトップ画面への描画かの判定情報
    void dx_GetUseDDrawObj() ;        /* 戻り値を IDirectDraw7 * にキャストして下さい */            // 現在使用しているＤｉｒｅｃｔＤｒａｗオブジェクトのアドレスを取得する
    int dx_GetUseDirectDrawFlag() ;                                        // ＤｉｒｅｃｔＤｒａｗを使用するかどうかを取得する
    pure int dx_GetColorBitDepth() ;                                            // 画面の色ビット深度を得る
    pure int dx_GetChangeDisplayFlag() ;                                        // 画面モードが変更されているかどうかのフラグを取得する
    COLORDATA dx_GetDispColorData() ;                                            // ディスプレーのカラーデータポインタを得る
    D_DDPIXELFORMAT*    dx_GetPixelFormat() ;                                            // ピクセルフォーマットの取得
    int dx_GetScreenMemToSystemMemFlag() ;                                // 画面グラフィックデータがシステムメモリに存在するかフラグの取得
    D_DDPIXELFORMAT*    dx_GetOverlayPixelFormat() ;                                        // 使用できるオーバーレイのピクセルフォーマットを得る
    D_DDCAPS dx_GetDirectDrawCaps() ;                                            // DirectDraw の情報を得る
    int dx_GetVideoMemorySize( int *AllSize, int *FreeSize ) ;                    // ビデオメモリの容量を得る
    int dx_GetUseGDIFlag() ;                                                // ＧＤＩ描画を必要とするかどうかを取得する
    int dx_GetNotDraw3DFlag() ;                                            // NotDraw3DFlag を取得する
    HDC dx_GetDrawScreenDC() ;                                            // 描画先になっている画面のＤＣを取得する
    int dx_ReleaseDrawScreenDC( HDC Dc ) ;                                        // GetScreenDC で取得したＤＣを解放する
    GUID dx_GetDirectDrawDeviceGUID( int Number ) ;                                // 有効な DirectDraw デバイスの GUID を取得する
    int dx_GetDirectDrawDeviceDescription( int Number, char *StringBuffer ) ;    // 有効な DirectDraw デバイスの名前を得る
    int dx_GetDirectDrawDeviceNum() ;                                    // 有効な DirectDraw デバイスの数を取得する
    int dx_GetUseMEMIMGFlag() ;                                            // MEMIMG 構造体を使用するかどうかを取得する
    int dx_GetVSyncTime() ;                                                // 垂直同期信号一回に付きかかる時間をミリ秒単位で取得する
    int dx_GetRefreshRate() ;                                            // 現在の画面のリフレッシュレートを取得する
    int dx_GetDisplayModeNum( ) ;                                            // 変更可能なディスプレイモードの数を取得する
    DISPLAYMODEDATA dx_GetDisplayMode( int ModeIndex ) ;                                    // 変更可能なディスプレイモードの情報を取得する( ModeIndex は 0 ～ GetDisplayModeNum の戻り値-1 )

// パレット操作関係関数
    int dx_SetPalette( int PalIndex, int Red, int Green, int Blue ) ;                            // パレットのセット
    int dx_ReflectionPalette() ;                                                            // セットしたパレットをハードウエアに反映させる
    int dx_GetPalette( int PalIndex, int *Red, int *Green, int *Blue ) ;                        // パレットの取得
    int dx_SetBmpPal( const char *FileName ) ;                                                    // ＢＭＰファイルのパレットを反映させる
    int dx_SetBmpPalPart( const char *FileName, int StartNum, int GetNum, int SetNum ) ;        // ＢＭＰファイルからのパレットの部分取得
    int dx_GetGraphPalette( int GrHandle, int ColorIndex, int *Red, int *Green, int *Blue ) ;    // メモリ上に読み込んだ画像のパレットを取得する(フルカラー画像の場合は無効)
    int dx_GetGraphOriginalPalette( int GrHandle, int ColorIndex, int *Red, int *Green, int *Blue ) ; // メモリ上に読み込んだ画像の SetGraphPalette で変更する前のパレットを取得する
    int dx_SetGraphPalette( int GrHandle, int ColorIndex, int Color ) ;                            // メモリ上に読み込んだ画像のパレットを変更する(フルカラー画像の場合は無効)
    int dx_ResetGraphPalette( int GrHandle ) ;                                                    // SetGraphPalette で変更したパレットを全て元に戻す

// 色情報取得関係
    int dx_ColorKaiseki( void *PixelData, COLORDATA* ColorData ) ;                                    // 色ビット情報解析
    pure DWORD dx_GetColor( int Red, int Green, int Blue ) ;                                                    // ３原色値から現在の画面モードに対応した色データ値を得る
    int dx_GetColor2( int Color, int *Red, int *Green, int *Blue ) ;                                    // 画面モードに対応した色データ値から個々の３原色データを抜き出す
    int dx_GetColor3( COLORDATA *ColorData, int Red, int Green, int Blue, int Alpha = 255 ) ;            // ３原色値から指定のピクセルフォーマットに対応した色データ値を得る
    int dx_GetColor4( COLORDATA *DestColorData, COLORDATA* SrcColorData, int SrcColor ) ;            // ２つのカラーフォーマット間のデータ変換を行った情報を得る 
    int dx_GetColor5( COLORDATA *ColorData, int Color, int *Red, int *Green, int *Blue, int *Alpha = null ) ;    // 指定カラーフォーマットに対応した色データ値から個々の３原色データを抜き出す
    int dx_CreatePaletteColorData( COLORDATA *ColorDataBuf ) ;                                        // パレットカラーのカラー情報を構築する
    int dx_CreateXRGB8ColorData( COLORDATA *ColorDataBuf ) ;                                            // ＸＲＧＢ８カラーのカラー情報を構築する
    int dx_CreateARGB8ColorData( COLORDATA *ColorDataBuf ) ;                                            // ＡＲＧＢ８カラーのカラー情報を構築する
    int dx_CreateFullColorData( COLORDATA *ColorDataBuf ) ;                                            // フルカラーＤＩＢのカラー情報を構築する
    int dx_CreateGrayColorData( COLORDATA *ColorDataBuf ) ;                                            // グレースケールのカラー情報を構築する
    int dx_CreatePal8ColorData( COLORDATA *ColorDataBuf ) ;                                            // パレット２５６色のカラー情報を構築する
    int dx_CreateColorData( COLORDATA *ColorDataBuf, int ColorBitDepth,
                                 DWORD RedMask, DWORD GreenMask, DWORD BlueMask, DWORD AlphaMask ) ;        // カラーデータを作成する
    int dx_CreatePixelFormat( D_DDPIXELFORMAT *PixelFormatBuf, int ColorBitDepth,
                                 DWORD RedMask, DWORD GreenMask, DWORD BlueMask, DWORD AlphaMask ) ;        // DDPIXELFORMATデータを作成する
    void dx_SetColorDataNoneMask( COLORDATA *ColorData ) ;                                                // NoneMask 以外の要素を埋めた COLORDATA 構造体の情報を元に NoneMask をセットする
    int dx_CmpColorData( COLORDATA *ColorData1, COLORDATA *ColorData2 ) ;                            // 二つのカラーデータが等しいかどうか調べる( TRUE:等しい  FALSE:等しくない )

// 簡易グラフィック関係関数
    int dx_GetPixel( int x, int y ) ;                                                                                                            // 指定座標の色を取得する
    int dx_Paint( int x, int y, int FillColor, int BoundaryColor = -1 ) ;                                                                        // 指定点から境界色があるところまで塗りつぶす(境界色を -1 にすると指定点の色の領域を塗りつぶす)
    //int dx_BltFastOrBitBlt( D_IDirectDrawSurface7 *Dest, D_IDirectDrawSurface7 *Src, int DestX, int DestY, RECT *SrcRect, int BltType = -1 ) ;    // 指定のサーフェスから指定のサーフェスへグラフィックデータを転送する

// ウエイト関係関数
    int dx_WaitVSync( int SyncNum ) ;                                                                                                                // 垂直同期信号を待つ

// 画面操作関係関数
    int dx_ScreenFlip() ;                                                                                                                    // 裏画面と表画面を交換する
    int dx_ScreenCopy() ;                                                                                                                    // 裏画面の内容を表画面に描画する
    int dx_GraphCopy( RECT *SrcRect, RECT *DestRect, int SrcHandle, int DestHandle = DX_SCREEN_BACK ) ;                                            // 画像の内容をコピーする
    int dx_SetGraphMode( int ScreenSizeX, int ScreenSizeY, int ColorBitDepth, int RefreshRate = 60 ) ;                                                // 画面モードのセット

// ＢＭＰ保存関数
    int dx_SaveDrawScreen( int x1, int y1, int x2, int y2, const char *FileName, int SaveType = DX_IMAGESAVETYPE_BMP, int Jpeg_Quality = 80 , int Jpeg_Sample2x1 = TRUE , int Png_CompressionLevel = -1 ) ;        // 現在描画対象になっている画面を保存する
    int dx_SaveDrawScreenToBMP( int x1, int y1, int x2, int y2, const char *FileName ) ;                                                        // 現在描画対象になっている画面をＢＭＰ形式で保存する
    int dx_SaveDrawScreenToJPEG( int x1, int y1, int x2, int y2, const char *FileName, int Quality = 80 , int Sample2x1 = TRUE ) ;                // 現在描画対象になっている画面をＪＰＥＧ形式で保存する
    int dx_SaveDrawScreenToPNG( int x1, int y1, int x2, int y2, const char *FileName, int CompressionLevel = -1 ) ;                            // 現在描画対象になっている画面をＰＮＧ形式で保存する








