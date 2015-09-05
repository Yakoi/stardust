module dxlib.dxinput;
import dxlib.all;
import core.sys.windows.windows;
    extern(Windows):
// DxInput.cpp関数プロトタイプ宣言

// 入力状態取得関数
    int dx_CheckHitKey( int KeyCode ) ;											// キーボードの入力状態取得
    int dx_CheckHitKeyAll( int CheckType = DX_CHECKINPUT_ALL ) ;					// 全キーの押下状態を取得
    int dx_GetHitKeyStateAll( DX_CHAR *KeyStateBuf ) ;								// すべてのキーの押下状態を取得する
    int dx_SetKeyExclusiveCooperativeLevelFlag( int Flag ) ;						// キーボードの協調レベルを排他レベルにするかどうかのフラグをセットする
    int dx_GetJoypadNum() ;													// ジョイパッドが接続されている数を取得する
    int dx_GetJoypadInputState( int InputType ) ;									// ジョイバッドの入力状態取得
    int dx_GetJoypadAnalogInput( int *XBuf, int *YBuf, int InputType ) ;			// ジョイパッドのアナログ的なスティック入力情報を得る
    int dx_GetJoypadAnalogInputRight( int *XBuf, int *YBuf, int InputType ) ;		// ジョイパッドのアナログ的なスティック入力情報を得る(右スティック用)
    int dx_KeyboradBufferProcess() ;											// キーボードのバッファからデータを取得する処理
    int dx_GetJoypadGUID( int PadIndex, GUID *GuidBuffer ) ;						// ジョイパッドのＧＵIＤを得る
    int dx_ConvertKeyCodeToVirtualKey( int KeyCode ) ;								// ＤＸライブラリのキーコードから Windows の仮想キーコードを取得する
    int dx_SetJoypadInputToKeyInput( int InputType, int PadInput, int KeyInput1, int KeyInput2 = -1 , int KeyInput3 = -1 , int KeyInput4 = -1  ) ; // ジョイパッドの入力に対応したキーボードの入力を設定する
    int dx_SetJoypadDeadZone( int InputType, double Zone ) ;						// ジョイパッドの無効ゾーンの設定を行う
    int dx_StartJoypadVibration( int InputType, int Power, int Time ) ;			// ジョイパッドの振動を開始する
    int dx_StopJoypadVibration( int InputType ) ;									// ジョイパッドの振動を停止する
    int dx_GetJoypadPOVState( int InputType, int POVNumber ) ;						// ジョイパッドのＰＯＶ入力の状態を得る( 単位は角度の１００倍  中心位置にある場合は -1 が返る )
    int dx_GetJoypadName( int InputType, char *InstanceNameBuffer, char *ProductNameBuffer ) ;	// ジョイパッドのデバイス登録名と製品登録名を取得する
    int dx_ReSetupJoypad() ;													// ジョイパッドの再セットアップを行う( 新たに接続されたジョイパッドがある場合に検出される )

    int dx_SetKeyboardNotDirectInputFlag( int Flag ) ;								// キーボードの入力処理に DirectInput を使わないか、フラグをセットする
    int dx_SetUseDirectInputFlag( int Flag ) ;										// 入力処理に DirectInput を使用するかどうかのフラグをセットする


