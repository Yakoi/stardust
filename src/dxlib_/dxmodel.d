module dxlib.dxmodel;
import dxlib.all;
// DxModel.cpp 関数 プロトタイプ宣言

    extern(Windows):

    int dx_MV1LoadModel( const char *FileName ) ;													// モデルの読み込み( -1:エラー  0以上:モデルハンドル )

    int dx_MV1AttachMotion( int MHandle, int MV1ModelHandle, const char *MotionName, int MotionIndex = -1, int AttachIndex = 0 ) ;	// モーションをアタッチする
    int dx_MV1DetachMotion( int MHandle, int AttachIndex = 0 ) ;									// モーションをデタッチする

    int dx_MV1PlayMotion( int MHandle, int Loop, int AttachIndex = 0 ) ;							// モーションを再生する
    int dx_MV1MotionAddTime( int MHandle, float AddTime, int AttachIndex = 0 ) ;					// モーションを進める
    int dx_MV1StopMotion( int MHandle, int AttachIndex = 0 ) ;										// モーションを止める
    int dx_MV1GetMotionState( int MHandle, int AttachIndex = 0 ) ;									// モーションが再生中かどうかを取得する( TRUE:再生中  FALSE:停止中 )

    int dx_MV1SetPosition( int MHandle, float x, float y, float z ) ;								// モデルの位置をセット
    int dx_MV1SetScale( int MHandle, float x, float y, float z ) ;									// モデルのスケールをセット
    int dx_MV1SetRotation( int MHandle, float x, float y, float z ) ;								// モデルのローテーションをセット
    int dx_MV1DrawModel( int MHandle ) ;															// モデルの描画


// モデルデータ描画及びアニメーション系
    int dx_StartModelAnimation( int ModelHandle, char *AnimationName, int AnimeType ) ;				// アニメーションを実行する
    int dx_StopModelAnimation( int ModelHandle ) ;													// アニメーションを止める
    int dx_AddModelAnimationTime( int ModelHandle, float AddTime ) ;								// アニメーションの再生ポイントを移動する

    int dx_DrawModel( float x, float y, float z, int Modelhandle ) ;								// モデルを描画する

// 外部公開関数
    int dx_LoadModel( char *FileName ) ;															// モデルデータを読み込む  
    int dx_DeleteModel( int ModelHandle ) ;															// モデルを削除する
    int dx_InitModel() ;																		// モデルデータを一掃する


