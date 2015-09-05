module dxlib.dxwin;

import core.sys.windows.windows;
import dxlib.all;
// 関数プロトタイプ宣言------------------------------------------------------------------


    extern(Windows):
// DxWin.cpp関数プロトタイプ宣言

// 初期化終了系関数
    int dx_DxLib_Init() ;                                                    /// ライブラリ初期化関数
    int dx_DxLib_End() ;                                                        /// ライブラリ使用の終了関数

    int dx_DxLib_GlobalStructInitialize() ;                                    /// ライブラリの内部で使用している構造体をゼロ初期化して、DxLib_Init の前に行った設定を無効化する( DxLib_Init の前でのみ有効 )
    int dx_DxLib_IsInit() ;                                                    /// ライブラリが初期化されているかどうかを取得する( 戻り値: TRUE=初期化されている  FALSE=されていない )

// エラー処理関数
    BOOL dx_ErrorLogAdd( const char *ErrorStr ) ;                                    /// エラー文書を書き出す
    BOOL dx_ErrorLogFmtAdd( const char *FormatString , ... ) ;                        /// 書式付きエラー文書を書き出す
    BOOL dx_ErrorLogTabAdd() ;                                                /// タブ数を増やす
    BOOL dx_ErrorLogTabSub() ;                                                /// タブ数を減らす
    BOOL dx_SetUseTimeStampFlag( int UseFlag ) ;                                    /// タイムスタンプの有無を設定する
    BOOL dx_AppLogAdd( const char *String , ... ) ;                                    /// 書式付きログ文字列を書き出す

// メモリ確保系関数
    void dx_DxAlloc( size_t AllocSize , const char *File = null , int Line = -1 ) ;    /// メモリを確保する
    void dx_DxCalloc( size_t AllocSize , const char *File = null , int Line = -1 ) ;    /// メモリを確保して０で初期化する
    void dx_DxRealloc( void *Memory , size_t AllocSize , const char *File = null , int Line = -1 ) ;    /// メモリの再確保を行う
    void dx_DxFree( void *Memory ) ;                                                /// メモリを解放する
    size_t dx_DxSetAllocSizeTrap( size_t Size ) ;                                        /// 列挙対象にするメモリの確保容量をセットする
    int dx_DxSetAllocPrintFlag( int Flag ) ;                                        /// ＤＸライブラリ内でメモリ確保が行われる時に情報を出力するかどうかをセットする
    size_t dx_DxGetAllocSize() ;                                                /// 確保しているメモリサイズを取得する
    int dx_DxGetAllocNum() ;                                                    /// 確保しているメモリの数を取得する
    void dx_DxDumpAlloc() ;                                                    /// 確保しているメモリを列挙する
    int dx_DxErrorCheckAlloc() ;                                                /// 確保したメモリ情報が破壊されていないか調べる( -1:破壊あり  0:なし )
    int dx_DxSetAllocSizeOutFlag( int Flag ) ;                                        /// メモリが確保、解放が行われる度に確保しているメモリの容量を出力するかどうかのフラグをセットする
    int dx_DxSetAllocMemoryErrorCheckFlag( int Flag ) ;                            /// メモリの確保、解放が行われる度に確保しているメモリ確保情報が破損していないか調べるかどうかのフラグをセットする

// ログ出力機能関数
    int dx_SetLogDrawOutFlag( int DrawFlag ) ;                                        /// ログ出力フラグをセットする
    int dx_GetLogDrawFlag() ;                                                /// ログ出力をするかフラグの取得

// 簡易画面出力関数
    int dx_printfDx( const char *FormatString , ... ) ;                            /// 簡易画面出力
    int dx_clsDx() ;                                                            /// 簡易画面出力をクリアする

// ファイルアクセス関数
    int dx_FileRead_open( const char *FilePath , int ASync = FALSE ) ;            /// ファイルを開く
    int dx_FileRead_size( const char *FilePath ) ;                                /// ファイルのサイズを得る
    int dx_FileRead_close( int FileHandle ) ;                                    /// ファイルを閉じる
    int dx_FileRead_tell( int FileHandle ) ;                                    /// ファイルポインタの現在位置を得る
    int dx_FileRead_seek( int FileHandle , int Offset , int Origin ) ;            /// ファイルポインタの位置を変更する
    static if(true){
        int dx_FileRead_read_2( void *Buffer , int ReadSize , int FileHandle ) ;        /// ファイルからデータを読み込む
        alias dx_FileRead_read_2 dx_FileRead_read;
    }else{
        int dx_FileRead_read( void *Buffer , int ReadSize , int FileHandle ) ;        /// ファイルからデータを読み込む
    }
    int dx_FileRead_idle_chk( int FileHandle ) ;                                /// ファイル読み込みが完了しているかどうかを取得する
    int dx_FileRead_eof( int FileHandle ) ;                                    /// ファイルの終端かどうかを得る
    int dx_FileRead_gets( char *Buffer , int BufferSize , int FileHandle ) ;    /// ファイルから文字列を読み出す
    int dx_FileRead_getc( int FileHandle ) ;                                    /// ファイルから一文字読み出す
    int dx_FileRead_scanf( int FileHandle , const char *Format , ... ) ;        /// ファイルから書式化されたデータを読み出す

    int dx_FileRead_createInfo( const char *ObjectPath ) ;                        /// ファイル情報ハンドルを作成する( 戻り値  -1:エラー  -1以外:ファイル情報ハンドル )
    int dx_FileRead_getInfoNum( int FileInfoHandle ) ;                            /// ファイル情報ハンドル中のファイルの数を取得する
    int dx_FileRead_getInfo( int Index , FILEINFO *Buffer , int FileInfoHandle ) ;    /// ファイル情報ハンドル中のファイルの情報を取得する
    int dx_FileRead_deleteInfo( int FileInfoHandle ) ;                            /// ファイル情報ハンドルを削除する

    int dx_FileRead_findFirst( const char *FilePath, FILEINFO *Buffer ) ;        /// 指定のファイル又はフォルダの情報を取得し、ファイル検索ハンドルも作成する( 戻り値: -1=エラー  -1以外=ファイル検索ハンドル )
    int dx_FileRead_findNext( int FindHandle, FILEINFO *Buffer ) ;                /// 条件の合致する次のファイルの情報を取得する( 戻り値: -1=エラー  0=成功 )
    int dx_FileRead_findClose( int FindHandle ) ;                                /// ファイル検索ハンドルを閉じる( 戻り値: -1=エラー  0=成功 )

// 便利関数
    int dx_GetResourceInfo( const char *ResourceName , const char *ResourceType , void **DataPointerP , int *DataSizeP ) ;        /// 指定のリソースを取得する( -1:失敗  0:成功 )

// メッセージ処理関数
    int dx_ProcessMessage() ;                                                /// ウインドウズのメッセージループに代わる処理を行う

// ウインドウ関係情報取得関数
    int dx_GetWindowCRect( RECT *RectBuf ) ;                                        /// ウインドウのクライアント領域を取得する
    pure int dx_GetWindowActiveFlag() ;                                            /// ウインドウのアクティブフラグを取得
    HWND dx_GetMainWindowHandle() ;                                            /// メインウインドウのハンドルを取得する
    int dx_GetWindowModeFlag() ;                                                /// ウインドウモードで起動しているか、のフラグを取得する
    int dx_GetDefaultState( int *SizeX , int *SizeY , int *ColorBitDepth ) ;        /// 起動時のデスクトップの画面モードを取得する
    int dx_GetActiveFlag() ;                                                    /// ソフトがアクティブかどうかを取得する
    int dx_GetNoActiveState( int ResetFlag = TRUE ) ;                                /// 非アクティブになり、処理が一時停止していたかどうかを取得する(引数 ResetFlag=TRUE:状態をリセット FALSE:状態をリセットしない    戻り値: 0=一時停止はしていない  1=一時停止していた )
    int dx_GetMouseDispFlag() ;                                                /// マウスを表示するかどうかのフラグを取得する
    int dx_GetAlwaysRunFlag() ;                                                /// ウインドウがアクティブではない状態でも処理を続行するか、フラグを取得する
    int dx__GetSystemInfo( int *DxLibVer , int *DirectXVer , int *WindowsVer ) ;    /// ＤＸライブラリと DirectX のバージョンと Windows のバージョンを得る
    int dx_GetPcInfo( char *OSString , char *DirectXString ,
                                char *CPUString , int *CPUSpeed /* 単位MHz */ ,
                                double *FreeMemorySize /* 単位MByte */ , double *TotalMemorySize ,
                                char *VideoDriverFileName , char *VideoDriverString ,
                                double *FreeVideoMemorySize /* 単位MByte */ , double *TotalVideoMemorySize ) ;    /// ＰＣの情報を得る
    int dx_GetUseMMXFlag() ;                                                    /// ＭＭＸが使えるかどうかの情報を得る
    int dx_GetUseSSEFlag() ;                                                    /// ＳＳＥが使えるかどうかの情報を得る
    int dx_GetUseSSE2Flag() ;                                                /// ＳＳＥ２が使えるかどうかの情報を得る
    int dx_GetWindowCloseFlag() ;                                            /// ウインドウを閉じようとしているかの情報を得る
    HINSTANCE dx_GetTaskInstance() ;                                                /// ソフトのインスタンスを取得する
    int dx_GetUseWindowRgnFlag() ;                                            /// リージョンを使っているかどうかを取得する
    int dx_GetWindowSizeChangeEnableFlag( int *FitScreen = null ) ;                /// ウインドウのサイズを変更できるかどうかのフラグを取得する
    pure double dx_GetWindowSizeExtendRate() ;                                        /// 描画画面のサイズに対するウインドウサイズの比率を取得する
    //double dx_GetWindowSizeExtendRate( double * ExRateX = null , double * ExRateY = null ) ;
    int dx_GetWindowUserCloseFlag( int StateResetFlag = FALSE ) ;                    /// ウインドウの閉じるボタンが押されたかどうかを取得する
    int dx_GetNotDrawFlag() ;                                                /// 描画機能を使うかどうかのフラグを取得する
    int dx_GetPaintMessageFlag() ;                                            /// WM_PAINT メッセージが来たかどうかを取得する(戻り値  TRUE:WM_PAINTメッセージが来た(一度取得すると以後、再び WM_PAINTメッセージが来るまで FALSE が返ってくるようになる)  FALSE:WM_PAINT メッセージは来ていない)
    int dx_GetValidHiPerformanceCounter() ;                                    /// パフォーマンスカウンタが有効かどうかを取得する(戻り値  TRUE:有効  FALSE:無効)

// 設定系関数
    int dx_ChangeWindowMode( int Flag ) ;                                            /// ウインドウモードを変更する
    int dx_LoadPauseGraph( const char *FileName ) ;                                /// アクティブウインドウが他のソフトに移っている際に表示する画像のロード(null で解除)
    int dx_LoadPauseGraphFromMem( void *MemImage , int MemImageSize ) ;            /// アクティブウインドウが他のソフトに移っている際に表示する画像のロード(null で解除)
    int dx_SetActiveStateChangeCallBackFunction( int (* CallBackFunction )( int ActiveState , void * UserData ) , void *UserData ) ;    /// ウインドウのアクティブ状態に変化があったときに呼ばれるコールバック関数をセットする( null をセットすると呼ばれなくなる )
    int dx_SetWindowText( const char *WindowText ) ;                                /// メインウインドウのウインドウテキストを変更する
    int dx_SetMainWindowText( const char *WindowText ) ;                            /// メインウインドウのウインドウテキストを変更する
    int dx_SetMainWindowClassName( const char *ClassName ) ;                        /// メインウインドウのクラス名を設定する
    int dx_SetOutApplicationLogValidFlag( int Flag ) ;                                /// ログ出力を行うか否かのセット
    int dx_SetAlwaysRunFlag( int Flag ) ;                                            /// ウインドウがアクティブではない状態でも処理を続行するか、フラグをセットする
    int dx_SetWindowIconID( int ID ) ;                                                /// 使用するアイコンのＩＤをセットする
    static if(OLD_VERSION){
        int dx_SetUseASyncChangeWindowModeFunction_2( int Flag ,
                                         void (* CallBackFunction )( void * ) , void *Data ) ;    /// 最大化ボタンやALT+ENTERキーによる非同期なウインドウモードの変更の機能の設定を行う
        alias dx_SetUseASyncChangeWindowModeFunction_2 dx_SetUseASyncChangeWindowModeFunction;
    }else{
        int dx_SetUseASyncChangeWindowModeFunction( int Flag ,
                                         void (* CallBackFunction )( void * ) , void *Data ) ;    /// 最大化ボタンやALT+ENTERキーによる非同期なウインドウモードの変更の機能の設定を行う
    }
    int dx_SetWindowStyleMode( int Mode ) ;                                        /// ウインドウのスタイルを変更する
    int dx_SetWindowSizeChangeEnableFlag( int Flag, int FitScreen = TRUE ) ;        /// ウインドウのサイズを変更できるかどうかのフラグをセットする( NotFitScreen:ウインドウのクライアント領域に画面をフィットさせる(拡大させる)かどうか  TRUE:フィットさせる  FALSE:フィットさせない )
    int dx_SetWindowSizeExtendRate( double ExRate ) ;                                /// 描画画面のサイズに対するウインドウサイズの比率を設定する
    //int dx_SetWindowSizeExtendRate( double  ExRateX, double  ExRateY = -1.0);
    int dx_SetSysCommandOffFlag( int Flag , const char *HookDllPath = null ) ;    /// タスクスイッチを有効にするかどうかを設定する
    int dx_SetHookWinProc( WNDPROC WinProc ) ;                                        /// メッセージをフックするウインドウプロージャを登録する
    int dx_SetDoubleStartValidFlag( int Flag ) ;                                    /// ２重起動を許すかどうかのフラグをセットする
    int dx_AddMessageTakeOverWindow( HWND Window ) ;                                /// メッセージ処理をＤＸライブラリに肩代わりしてもらうウインドウを追加する
    int dx_SubMessageTakeOverWindow( HWND Window ) ;                                /// メッセージ処理をＤＸライブラリに肩代わりしてもらうウインドウを減らす

    int dx_SetWindowPosition(int x, int y);
    int dx_GetWindowPosition(int* x, int* y);
    int dx_SetWindowInitPosition( int x , int y ) ;                                    /// ウインドウの初期位置を設定する
    int dx_SetNotWinFlag( int Flag ) ;                                                /// ＤＸライブラリのウインドウ関連の機能を使用しないフラグ
    int dx_SetNotDrawFlag( int Flag ) ;                                            /// 描画機能を使うかどうかのフラグをセットする
    int dx_SetNotSoundFlag( int Flag ) ;                                            /// サウンド機能を使うかどうかのフラグをセットする
    int dx_SetNotInputFlag( int Flag ) ;                                            /// 入力状態の取得機能を使うかどうかのフラグをセットする
    int dx_SetDialogBoxHandle( HWND WindowHandle ) ;                                /// ＤＸライブラリでメッセージ処理を行うダイアログボックスを登録する
    int dx_ChangeStreamFunction( STREAMDATASHREDTYPE2 *StreamThread ) ;            /// ＤＸライブラリでストリームデータアクセスに使用する関数を変更する
    int dx_GetStreamFunctionDefault() ;                                        /// ＤＸライブラリでストリームデータアクセスに使用する関数がデフォルトのものか調べる( TRUE:デフォルト  FALSE:デフォルトではない )
    int dx_SetWindowVisibleFlag( int Flag ) ;                                        /// メインウインドウを表示するかどうかのフラグをセットする
    int dx_SetWindowUserCloseEnableFlag( int Flag ) ;                                /// メインウインドウの×ボタンを押した時にライブラリが自動的にウインドウを閉じるかどうかのフラグをセットする
    int dx_SetDxLibEndPostQuitMessageFlag( int Flag ) ;                            /// ＤＸライブラリ終了時に PostQuitMessage を呼ぶかどうかのフラグをセットする
    int dx_SetUserWindow( HWND WindowHandle ) ;                                    /// ＤＸライブラリで利用するウインドウのハンドルをセットする(DxLib_Init を実行する以前でのみ有効)
    int dx_SetUserWindowMessageProcessDXLibFlag( int Flag ) ;                        /// SetUseWindow で設定したウインドウのメッセージループ処理をＤＸライブラリで行うかどうか、フラグをセットする
    int dx_SetUseDXArchiveFlag( int Flag ) ;                                        /// ＤＸアーカイブファイルの読み込み機能を使うかどうかを設定する( FALSE:使用しない  TRUE:使用する )
    int dx_SetDXArchiveExtension( const char *Extension = null ) ;                    /// 検索するＤＸアーカイブファイルの拡張子を変更する
    int dx_SetDXArchiveKeyString( const char *KeyString = null ) ;                    /// ＤＸアーカイブファイルの鍵文字列を設定する
    int dx_SetUseDateNameLogFile( int Flag ) ;                                        /// ログファイル名に日付をつけるかどうかをセットする
    int dx_SetBackgroundColor( int Red, int Green, int Blue ) ;                    /// メインウインドウのバックグラウンドカラーを設定する
    int dx_SetLogFontSize( int Size ) ;                                            /// printfDx で画面に出力するログフォントのサイズを変更する


// ドラッグ＆ドロップされたファイル関係
    int dx_SetDragFileValidFlag( int Flag ) ;                                        /// ファイルのドラッグ＆ドロップ機能を有効にするかどうかのフラグをセットする
    int dx_DragFileInfoClear() ;                                                /// ドラッグ＆ドロップされたファイルの情報を初期化する
    int dx_GetDragFilePath( char *FilePathBuffer ) ;                                /// ドラッグ＆ドロップされたファイル名を取得する( -1:取得できなかった  0:取得できた )
    pure int dx_GetDragFileNum() ;                                                /// ドラッグ＆ドロップされたファイルの数を取得する

// ウインドウ描画領域設定系関数
    HRGN dx_CreateRgnFromGraph( int Width , int Height , void *MaskData , int Pitch , int Byte ) ; /// 任意のグラフィックからRGNハンドルを作成する
    int dx_SetWindowRgnGraph( const char *FileName ) ;                                /// 任意のグラフィックからＲＧＮをセットする

// ツールバー関係
    int dx_SetupToolBar( const char *BitmapName , int DivNum , int ResourceID = -1 ) ;                /// ツールバーの準備( null を指定するとツールバーを解除、ResourceID は BitmapName が null の際に使用される )
    int dx_AddToolBarButton( int Type /* TOOLBUTTON_TYPE_NORMAL 等 */ , int State /* TOOLBUTTON_STATE_ENABLE 等 */ , int ImageIndex, int ID ) ;        /// ツールバーにボタンを追加
    int dx_AddToolBarSep() ;                                                /// ツールバーに隙間を追加
    int dx_GetToolBarButtonState( int ID ) ;                                    /// ツールバーのボタンの状態を取得( TRUE:押されている or 押された  FALSE:押されていない )
    int dx_SetToolBarButtonState( int ID , int State ) ;                        /// ツールバーのボタンの状態を設定
    int dx_DeleteAllToolBarButton() ;                                    /// ツールバーのボタンを全て削除

// メニュー関係
    int dx_SetUseMenuFlag( int Flag ) ;                                                /// メニューを有効にするかどうかを設定する
    int dx_SetUseKeyAccelFlag( int Flag ) ;                                            /// キーボードアクセラレーターを使用するかどうかを設定する

    int dx_AddKeyAccel( const char *ItemName , int ItemID , int KeyCode , int CtrlFlag , int AltFlag , int ShiftFlag ) ;    /// ショートカットキーを追加する
    int dx_AddKeyAccel_Name( const char *ItemName , int KeyCode , int CtrlFlag , int AltFlag , int ShiftFlag ) ;    /// ショートカットキーを追加する
    int dx_AddKeyAccel_ID( int ItemID, int KeyCode, int CtrlFlag, int AltFlag, int ShiftFlag ) ;    /// ショートカットキーを追加する
    int dx_ClearKeyAccel() ;                                                        /// ショートカットキーの情報を初期化する

    int dx_AddMenuItem( int AddType /* MENUITEM_ADD_CHILD等 */ , const char *ItemName, int ItemID,
                                    int SeparatorFlag, const char *NewItemName = null , int NewItemID = -1 ) ;    /// メニューに項目を追加する
    int dx_DeleteMenuItem( const char *ItemName, int ItemID ) ;                        /// メニューから選択項目を削除する
    int dx_CheckMenuItemSelect( const char *ItemName, int ItemID ) ;                    /// メニューが選択されたかどうかを取得する( 0:選択されていない  1:選択された )
    int dx_SetMenuItemEnable( const char *ItemName, int ItemID, int EnableFlag ) ;        /// メニューの項目を選択出来るかどうかを設定する
    int dx_SetMenuItemMark( const char *ItemName, int ItemID, int Mark ) ;                /// メニューの項目にチェックマークやラジオボタンを表示するかどうかを設定する

    int dx_AddMenuItem_Name( const char *ParentItemName, const char *NewItemName ) ;    /// メニューに選択項目を追加する
    int dx_AddMenuLine_Name( const char *ParentItemName ) ;                            /// メニューのリストに区切り線を追加する
    int dx_InsertMenuItem_Name( const char *ItemName, const char *NewItemName ) ;        /// 指定の項目と、指定の項目の一つ上の項目との間に新しい項目を追加する
    int dx_InsertMenuLine_Name( const char *ItemName ) ;                                /// 指定の項目と、指定の項目の一つ上の項目との間に区切り線を追加する
    int dx_DeleteMenuItem_Name( const char *ItemName ) ;                                /// メニューから選択項目を削除する
    int dx_CheckMenuItemSelect_Name( const char *ItemName ) ;                            /// メニューが選択されたかどうかを取得する( 0:選択されていない  1:選択された )
    int dx_SetMenuItemEnable_Name( const char *ItemName, int EnableFlag ) ;            /// メニューの項目を選択出来るかどうかを設定する( 1:選択できる  0:選択できない )
    int dx_SetMenuItemMark_Name( const char *ItemName, int Mark ) ;                    /// メニューの項目にチェックマークやラジオボタンを表示するかどうかを設定する

    int dx_AddMenuItem_ID( int ParentItemID, const char *NewItemName, int NewItemID = -1 ) ;    /// メニューに選択項目を追加する
    int dx_AddMenuLine_ID( int ParentItemID ) ;                                        /// メニューのリストに区切り線を追加する
    int dx_InsertMenuItem_ID( int ItemID, int NewItemID ) ;                            /// 指定の項目と、指定の項目の一つ上の項目との間に新しい項目を追加する
    int dx_InsertMenuLine_ID( int ItemID, int NewItemID ) ;                            /// 指定の項目と、指定の項目の一つ上の項目との間に区切り線を追加する
    int dx_DeleteMenuItem_ID( int ItemID ) ;                                            /// メニューから選択項目を削除する
    int dx_CheckMenuItemSelect_ID( int ItemID ) ;                                        /// メニューが選択されたかどうかを取得する( 0:選択されていない  1:選択された )
    int dx_SetMenuItemEnable_ID( int ItemID, int EnableFlag ) ;                        /// メニューの項目を選択出来るかどうかを設定する
    int dx_SetMenuItemMark_ID( int ItemID, int Mark ) ;                                /// メニューの項目にチェックマークやラジオボタンを表示するかどうかを設定する

    int dx_DeleteMenuItemAll() ;                                                    /// メニューの全ての選択項目を削除する
    int dx_ClearMenuItemSelect() ;                                                /// メニューが選択されたかどうかの情報を初期化
    int dx_GetMenuItemID( const char *ItemName ) ;                                        /// メニューの項目名からＩＤを取得する
    int dx_GetMenuItemName( int ItemID, char *NameBuffer ) ;                            /// メニューの項目名からＩＤを取得する
    int dx_LoadMenuResource( int MenuResourceID ) ;                                    /// メニューをリソースから読み込む
    int dx_SetMenuItemSelectCallBackFunction( void (* CallBackFunction )( const char *ItemName, int ItemID ) ) ; /// メニューの選択項目が選択されたときに呼ばれるコールバック関数を設定する

    int dx_SetWindowMenu( int MenuID, int (* MenuProc )( WORD ID ) ) ;                /// (古い関数)ウインドウにメニューを設定する
    int dx_SetDisplayMenuFlag( int Flag ) ;                                        /// メニューを表示するかどうかをセットする
    int dx_GetDisplayMenuFlag() ;                                            /// メニューを表示しているかどうかを取得する
    int dx_GetUseMenuFlag() ;                                                /// メニューを使用しているかどうかを得る
    int dx_SetAutoMenuDisplayFlag( int Flag ) ;                                    /// フルスクリーン時にメニューを自動で表示したり非表示にしたりするかどうかのフラグをセットする

// マウス関係関数
    int dx_SetMouseDispFlag( int DispFlag ) ;                                        /// マウスの表示フラグのセット
    int dx_GetMousePoint( int *XBuf, int *YBuf ) ;                                    /// マウスの位置を取得する
    int dx_SetMousePoint( int PointX, int PointY ) ;                                /// マウスの位置をセットする
    int dx_GetMouseInput() ;                                                    /// マウスのボタンの状態を得る 
    int dx_GetMouseWheelRotVol( int CounterReset = TRUE )  ;                                            /// マウスホイールの回転量を得る

// ウエイト系関数
    int dx_WaitTimer( int WaitTime ) ;                                                /// 指定の時間だけ処理をとめる
    int dx_WaitKey() ;                                                        /// キーの入力待ち

// カウンタ及び時刻取得系関数
    int dx_GetNowCount( int UseRDTSCFlag = FALSE ) ;                                /// ミリ秒単位の精度を持つカウンタの現在値を得る
    LONGLONG dx_GetNowHiPerformanceCount( int UseRDTSCFlag = FALSE ) ;                    /// GetNowCountの高精度バージョン
    int dx_GetDateTime( DATEDATA *DateBuf ) ;                                        /// 現在時刻を取得する 

// 乱数取得
    int dx_GetRand( int RandMax ) ;                                                /// 乱数を取得する( RandMax : 返って来る値の最大値 )
    int dx_SRand( int Seed ) ;                                                        /// 乱数の初期値を設定する


// 通信関係
    int dx_ProcessNetMessage( int RunReleaseProcess = FALSE ) ;                    /// 通信メッセージの処理をする関数

    int dx_GetHostIPbyName( const char *HostName, IPDATA *IPDataBuf ) ;            /// ＤＮＳサーバーを使ってホスト名からＩＰアドレスを取得する
    int dx_ConnectNetWork( IPDATA IPData, int Port = -1 ) ;                            /// 他マシンに接続する
    int dx_PreparationListenNetWork( int Port = -1 ) ;                                /// 接続を受けられる状態にする
    int dx_StopListenNetWork() ;                                                /// 接続を受けつけ状態の解除
    int dx_CloseNetWork( int NetHandle ) ;                                            /// 接続を終了する

    int dx_GetNetWorkAcceptState( int NetHandle ) ;                                /// 接続状態を取得する
    int dx_GetNetWorkDataLength( int NetHandle ) ;                                    /// 受信データの量を得る
    int dx_GetNetWorkSendDataLength( int NetHandle ) ;                                /// 未送信のデータの量を得る 
    int dx_GetNewAcceptNetWork() ;                                            /// 新たに接続した通信回線を得る
    int dx_GetLostNetWork() ;                                                /// 接続を切断された通信回線を得る
    int dx_GetNetWorkIP( int NetHandle, IPDATA *IpBuf ) ;                            /// 接続先のＩＰを得る
    int dx_GetMyIPAddress( IPDATA *IpBuf ) ;                                        /// 自分のＩＰを得る
    int dx_SetConnectTimeOutWait( int Time ) ;                                        /// 接続のタイムアウトまでの時間を設定する
    int dx_SetUseDXNetWorkProtocol( int Flag ) ;                                    /// ＤＸライブラリの通信形態を使うかどうかをセットする
    int dx_GetUseDXNetWorkProtocol() ;                                         /// ＤＸライブラリの通信形態を使うかどうかを取得する
    int dx_SetUseDXProtocol( int Flag ) ;                                            /// SetUseDXNetWorkProtocol の別名
    int dx_GetUseDXProtocol() ;                                                 /// GetUseDXNetWorkProtocol の別名
    int dx_SetNetWorkCloseAfterLostFlag( int Flag ) ;                                /// 接続が切断された直後に接続ハンドルを解放するかどうかのフラグをセットする
    int dx_GetNetWorkCloseAfterLostFlag() ;                                    /// 接続が切断された直後に接続ハンドルを解放するかどうかのフラグを取得する
    int dx_SetProxySetting( int UseFlag, char *Address, int Port ) ;                        /// ＨＴＴＰ通信で使用するプロキシ設定を行う
    int dx_GetProxySetting( int *UseFlagBuffer, char *AddressBuffer, int *PortBuffer ) ;    /// ＨＴＴＰ通信で使用するプロキシ設定を取得する
    int dx_SetIEProxySetting() ;                                                /// ＩＥのプロキシ設定を適応する


    int dx_NetWorkRecv( int NetHandle, void *Buffer, int Length ) ;                /// 受信したデータを読み込む
    int dx_NetWorkRecvToPeek( int NetHandle, void *Buffer, int Length ) ;            /// 受信したデータを読み込む、読み込んだデータはバッファから削除されない
    int dx_NetWorkRecvBufferClear( int NetHandle ) ;                                /// 受信したデータをクリアする
    int dx_NetWorkSend( int NetHandle, void *Buffer, int Length ) ;                /// データを送信する

/*    使用不可
extern    int            HTTP_FileDownload( const char *FileURL, const char *SavePath = null ,
                                         void **SaveBufferP = null , int *FileSize = null ,
                                         char **ParamList = null ) ;                        /// HTTP を使用してネットワーク上のファイルをダウンロードする
extern    int            HTTP_GetFileSize( const char *FileURL ) ;                                /// HTTP を使用してネットワーク上のファイルのサイズを得る

extern    int            HTTP_StartFileDownload( const char *FileURL, const char *SavePath, void **SaveBufferP = null , char **ParamList = null ) ;    // HTTP を使用したネットワーク上のファイルをダウンロードする処理を開始する
extern    int            HTTP_StartGetFileSize( const char *FileURL ) ;                            // HTTP を使用したネットワーク上のファイルのサイズを得る処理を開始する
extern    int            HTTP_Close( int HttpHandle ) ;                                            // HTTP の処理を終了し、ハンドルを解放する
extern    int            HTTP_CloseAll() ;                                                    // 全てのハンドルに対して HTTP_Close を行う
extern    int            HTTP_GetState( int HttpHandle ) ;                                        // HTTP 処理の現在の状態を得る( NET_RES_COMPLETE 等 )
extern    int            HTTP_GetError( int HttpHandle ) ;                                        // HTTP 処理でエラーが発生した場合、エラーの内容を得る( HTTP_ERR_NONE 等 )
extern    int            HTTP_GetDownloadFileSize( int HttpHandle ) ;                            // HTTP 処理で対象となっているファイルのサイズを得る( 戻り値: -1 = エラー・若しくはまだファイルのサイズを取得していない  0以上 = ファイルのサイズ )
extern    int            HTTP_GetDownloadedFileSize( int HttpHandle ) ;                            // HTTP 処理で既にダウンロードしたファイルのサイズを取得する

extern    int            fgetsForNetHandle( int NetHandle, char *strbuffer ) ;                    // fgets のネットワークハンドル版( -1:取得できず 0:取得できた )
extern    int            URLAnalys( const char *URL, char *HostBuf = null , char *PathBuf = null ,
                                                 char *FileNameBuf = null , int *PortBuf = null ) ;    // ＵＲＬを解析する
extern    int            URLConvert( char *URL, int ParamConvert = TRUE , int NonConvert = FALSE ) ;    // HTTP に渡せない記号が使われた文字列を渡せるような文字列に変換する( 戻り値: -1 = エラー  0以上 = 変換後の文字列のサイズ )
extern    int            URLParamAnalysis( char **ParamList, char **ParamStringP ) ;                // HTTP 用パラメータリストから一つのパラメータ文字列を作成する( 戻り値:  -1 = エラー  0以上 = パラメータの文字列の長さ )
*/



// 文字コードバッファ操作関係
    int dx_StokInputChar( char CharCode ) ;                                                                                                                /// バッファにコードをストックする
    int dx_ClearInputCharBuf() ;                                                                                                                        /// 文字コードバッファをクリアする
    char dx_GetInputChar( int DeleteFlag ) ;                                                                                                                /// 文字コードバッファに溜まったデータから文字コードを取得する
    char dx_GetInputCharWait( int DeleteFlag ) ;                                                                                                            /// 文字コードバッファに溜まったデータから１バイト分取得する、バッファになにも文字コードがない場合はキーが押されるまで待つ

    int dx_GetOneChar( char *CharBuffer, int DeleteFlag ) ;                                                                                                /// 文字コードバッファに溜まったデータから１文字分取得する
    int dx_GetOneCharWait( char *CharBuffer, int DeleteFlag ) ;                                                                                            /// 文字コードバッファに溜まったデータから１文字分取得する、バッファに何も文字コードがない場合はキーが押されるまで待つ
    int dx_GetCtrlCodeCmp( char Char ) ;                                                                                                                    /// アスキーコントロールコードか調べる


    int dx_DrawIMEInputString( int x, int y, int SelectStringNum ) ;                                                                                        /// 画面上に入力中の文字列を描画する
    int dx_SetUseIMEFlag( int UseFlag ) ;                                                                                                                    /// ＩＭＥを使用するかどうかをセットする
    int dx_SetInputStringMaxLengthIMESync( int Flag ) ;                                                                                                    /// ＩＭＥで入力できる最大文字数を MakeKeyInput の設定に合わせるかどうかをセットする( TRUE:あわせる  FALSE:あわせない(デフォルト) )
    int dx_SetIMEInputStringMaxLength( int Length ) ;                                                                                                        /// ＩＭＥで一度に入力できる最大文字数を設定する( 0:制限なし  1以上:指定の文字数で制限 )


    int dx_GetStringPoint( const char *String, int Point ) ;                                                                                                /// 全角文字、半角文字入り乱れる中から指定の文字数での半角文字数を得る
    int dx_GetStringPoint2( const char *String, int Point ) ;                                                                                                /// 全角文字、半角文字入り乱れる中から指定の文字数での全角文字数を得る

    int dx_DrawObtainsString( int x, int y, int AddY, const char *String, int StrColor , int StrEdgeColor = 0 , int FontHandle = -1 ) ;                    /// 規定領域に収めたかたちで文字列を描画
    int dx_DrawObtainsBox( int x1, int y1, int x2, int y2, int AddY, int Color, int FillFlag ) ;                                                            /// 規定領域に収めたかたちで矩形を描画 


    int dx_InputStringToCustom( int x, int y, int BufLength, char *StrBuffer, int CancelValidFlag, int SingleCharOnlyFlag, int NumCharOnlyFlag ) ;            /// 文字列の入力取得

    int dx_KeyInputString( int x, int y, int CharMaxLength, char *StrBuffer, int CancelValidFlag ) ;                                                        /// 文字列の入力取得
    int dx_KeyInputSingleCharString( int x, int y, int CharMaxLength, char *StrBuffer, int CancelValidFlag ) ;                                                /// 半角文字列のみの入力取得
    int dx_KeyInputNumber( int x, int y, int MaxNum, int MinNum, int CancelValidFlag ) ;                                                                    /// 数値の入力

    int dx_GetIMEInputModeStr( char *GetBuffer ) ;                                                                                                            /// IMEの入力モード文字列の取得
    IMEINPUTDATA dx_GetIMEInputData() ;                                                                                                                        /// IMEで入力中の文字列の情報を取得する
    int dx_SetKeyInputStringColor( ULONGLONG NmlStr, ULONGLONG NmlCur, ULONGLONG IMEStr, ULONGLONG IMECur, ULONGLONG IMELine, ULONGLONG IMESelectStr, ULONGLONG IMEModeStr , ULONGLONG NmlStrE = 0 , ULONGLONG IMESelectStrE = 0 , ULONGLONG IMEModeStrE = 0 , ULONGLONG IMESelectWinE = 0xffffffffffffffff ,    ULONGLONG IMESelectWinF = 0xffffffffffffffff ) ;    /// InputString関数使用時の文字の各色を変更する
    int dx_SetKeyInputStringFont( int FontHandle ) ;                                                                                                        /// キー入力文字列描画関連で使用するフォントのハンドルを変更する(-1でデフォルトのフォントハンドル)
    int dx_DrawKeyInputModeString( int x, int y ) ;                                                                                                        /// 入力モード文字列を描画する

    int dx_InitKeyInput() ;                                                                                                                            /// キー入力データ初期化
    int dx_MakeKeyInput( int MaxStrLength, int CancelValidFlag, int SingleCharOnlyFlag, int NumCharOnlyFlag ) ;                                            /// 新しいキー入力データの作成
    int dx_DeleteKeyInput( int InputHandle ) ;                                                                                                                /// キー入力データの削除
    int dx_SetActiveKeyInput( int InputHandle ) ;                                                                                                            /// 指定のキー入力をアクティブにする
    int dx_CheckKeyInput( int InputHandle ) ;                                                                                                                /// 入力が終了しているか取得する
    int dx_ProcessActKeyInput() ;                                                                                                                    /// キー入力処理関数
    int dx_DrawKeyInputString( int x, int y, int InputHandle ) ;                                                                                            /// キー入力中データの描画

    int dx_SetKeyInputCursorBrinkTime( int Time ) ;                                                                                                        /// キー入力時のカーソルの点滅する早さをセットする
    int dx_SetKeyInputCursorBrinkFlag( int Flag ) ;                                                                                                        /// キー入力時のカーソルを点滅させるかどうかをセットする
    int dx_SetKeyInputString( const char *String, int InputHandle ) ;                                                                                        /// キー入力データに指定の文字列をセットする
    int dx_SetKeyInputNumber( int Number, int InputHandle ) ;                                                                                                /// キー入力データに指定の数値を文字に置き換えてセットする
    int dx_GetKeyInputString( char *StrBuffer, int InputHandle ) ;                                                                                            /// 入力データの文字列を取得する
    int dx_GetKeyInputNumber( int InputHandle ) ;
    int dx_GetKeyInputCursorPosition( int InputHandle ) ;                                                                                                    /// キー入力の現在のカーソル位置を取得する



// メモリに置かれたデータをファイルのデータに例えてつかうための関数
    void dx_MemStreamOpen( void *DataBuffer, uint DataSize ) ;
    int dx_MemStreamClose( void *StreamDataPoint ) ;



