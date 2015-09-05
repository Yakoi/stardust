module dxlib.dxsound;
import core.sys.windows.windows;
import dxlib.all;
    extern(Windows):
// DxSound.cpp関数プロトタイプ宣言

// サウンドデータ管理系関数
    int dx_InitSoundMem( int LogOutFlag = FALSE ) ;																// メモリに読みこんだWAVEデータを削除し、初期化する

    int dx_AddSoundData( int Handle = -1 ) ;																		// 新しいサウンドデータ領域を確保する
    int dx_AddStreamSoundMem( STREAMDATA *Stream, int LoopNum,  int SoundHandle, int StreamDataType, int *CanStreamCloseFlag, int UnionHandle = -1 ) ;	// ストリーム風サウンドデータにサウンドデータを追加する
    int dx_AddStreamSoundMemToMem( void *FileImageBuffer, int ImageSize, int LoopNum,  int SoundHandle, int StreamDataType, int UnionHandle = -1 ) ;	// ストリーム風サウンドデータにサウンドデータを追加する
    int dx_AddStreamSoundMemToFile( const char *WaveFile, int LoopNum,  int SoundHandle, int StreamDataType, int UnionHandle = -1 ) ;	// ストリーム風サウンドデータにサウンドデータを追加する
    int dx_SetupStreamSoundMem( int SoundHandle ) ;																// ストリーム風サウンドデータの再生準備を行う
    int dx_PlayStreamSoundMem( int SoundHandle, int PlayType = DX_PLAYTYPE_LOOP , int TopPositionFlag = TRUE ) ;	// ストリーム風サウンドデータの再生開始
    int dx_CheckStreamSoundMem( int SoundHandle ) ;																// ストリーム風サウンドデータの再生状態を得る
    int dx_StopStreamSoundMem( int SoundHandle ) ;																	// ストリーム風サウンドデータの再生終了
    int dx_SetStreamSoundCurrentPosition( int Byte, int SoundHandle ) ;											// サウンドハンドルの再生位置をバイト単位で変更する(再生が止まっている時のみ有効)
    int dx_GetStreamSoundCurrentPosition( int SoundHandle ) ;														// サウンドハンドルの再生位置をバイト単位で取得する
    int dx_SetStreamSoundCurrentTime( int Time, int SoundHandle ) ;												// サウンドハンドルの再生位置をミリ秒単位で設定する(圧縮形式の場合は正しく設定されない場合がある)
    int dx_GetStreamSoundCurrentTime( int SoundHandle ) ;															// サウンドハンドルの再生位置をミリ秒単位で取得する(圧縮形式の場合は正しい値が返ってこない場合がある)
    int dx_ProcessStreamSoundMem( int SoundHandle ) ;																// ストリームサウンドの再生処理関数
    int dx_ProcessStreamSoundMemAll() ;																		// 有効なストリームサウンドのすべて再生処理関数にかける


    int dx_LoadSoundMem2( const char *WaveName1, const char *WaveName2 ) ;											// 前奏部とループ部に分かれたサウンドデータの作成
    int dx_LoadBGM( const char *WaveName ) ;																		// 主にＢＧＭを読み込むのに適した関数

    int dx_LoadSoundMemBase( const char *WaveName, int BufferNum, int UnionHandle ) ;								// サウンドデータを追加する
    int dx_LoadSoundMem( const char *WaveName, int BufferNum = 3 , int UnionHandle = -1 ) ;						// サウンドデータを追加する
    int dx_LoadSoundMemToBufNumSitei( const char *WaveName, int BufferNum ) ;										// 同時再生数指定型サウンド追加関数
    int dx_LoadSoundMemByResource( const char *ResourceName, const char *ResourceType, int BufferNum = 1 ) ;		// サウンドをリソースから読み込む

    int dx_LoadSoundMemByMemImageBase( void *FileImageBuffer, int ImageSize, int BufferNum, int UnionHandle = -1 ) ; // メモリ上に展開されたファイルイメージからハンドルを作成する(ベース関数)
    int dx_LoadSoundMemByMemImage( void *FileImageBuffer, int ImageSize, int UnionHandle = -1 ) ;					// メモリ上に展開されたファイルイメージからハンドルを作成する(バッファ数指定あり) 
    int dx_LoadSoundMemByMemImage2( void *UData, int UDataSize, WAVEFORMATEX *UFormat, int UHeaderSize ) ;			// メモリ上に展開されたファイルイメージからハンドルを作成する2
    int dx_LoadSoundMemByMemImageToBufNumSitei( void *FileImageBuffer, int ImageSize, int BufferNum ) ;			// メモリ上に展開されたファイルイメージからハンドルを作成する
    int dx_LoadSoundMem2ByMemImage( void *FileImageBuffer1, int ImageSize1, void *FileImageBuffer2, int ImageSize2 ) ;	// メモリ上に展開されたファイルイメージから前奏部とループ部に分かれたハンドルを作成する

    int dx_DeleteSoundMem( int SoundHandle, int LogOutFlag = FALSE ) ;												// メモリに読み込んだWAVEデータを削除する

    int dx_PlaySoundMem( int SoundHandle, int PlayType, int TopPositionFlag = TRUE ) ;								// メモリに読みこんだWAVEデータを再生する
    int dx_StopSoundMem( int SoundHandle ) ;																		// メモリに読み込んだWAVEデータの再生を止める
    int dx_CheckSoundMem( int SoundHandle ) ;																		// メモリに読みこんだWAVEデータが再生中か調べる
    int dx_SetPanSoundMem( int PanPal, int SoundHandle ) ;															// メモリに読みこんだWAVEデータの再生にパンを設定する
    int dx_SetVolumeSoundMem( int VolumePal, int SoundHandle ) ;													// メモリに読みこんだWAVEデータの再生にボリュームを設定する( 100分の1デシベル単位 )
    int dx_ChangeVolumeSoundMem( int VolumePal, int SoundHandle ) ;												// メモリに読みこんだWAVEデータの再生にボリュームを設定する( パーセント指定 )
    int dx_GetVolumeSoundMem( int SoundHandle ) ;																	// メモリに読みこんだWAVEデータの再生のボリュームを取得する
    int dx_SetFrequencySoundMem( int FrequencyPal, int SoundHandle ) ;												// メモリに読み込んだWAVEデータの再生周波数を設定する
    int dx_GetFrequencySoundMem( int SoundHandle ) ;																// メモリに読み込んだWAVEデータの再生周波数を取得する

    int dx_SetSoundCurrentPosition( int Byte, int SoundHandle ) ;													// サウンドハンドルの再生位置をバイト単位で変更する(再生が止まっている時のみ有効)
    int dx_GetSoundCurrentPosition( int SoundHandle ) ;															// サウンドハンドルの再生位置をバイト単位で取得する
    int dx_SetSoundCurrentTime( int Time, int SoundHandle ) ;														// サウンドハンドルの再生位置をミリ秒単位で設定する(圧縮形式の場合は正しく設定されない場合がある)
    int dx_GetSoundCurrentTime( int SoundHandle ) ;																// サウンドハンドルの再生位置をミリ秒単位で取得する(圧縮形式の場合は正しい値が返ってこない場合がある)
    int dx_GetSoundTotalSample( int SoundHandle ) ;																// サウンドハンドルの音の総時間を取得する(単位はサンプル)
    int dx_GetSoundTotalTime( int SoundHandle ) ;																	// サウンドハンドルの音の総時間を取得する(単位はミリ秒)

    int dx_SetLoopPosSoundMem( int LoopTime, int SoundHandle ) ;													// サウンドハンドルにループ位置を設定する
    int dx_SetLoopTimePosSoundMem( int LoopTime, int SoundHandle ) ;												// サウンドハンドルにループ位置を設定する
    int dx_SetLoopSamplePosSoundMem( int LoopSamplePosition, int SoundHandle ) ;									// サウンドハンドルにループ位置を設定する

// 設定関係関数
    int dx_SetCreateSoundDataType( int SoundDataType ) ;															// 作成するサウンドのデータ形式を設定する( DX_SOUNDDATATYPE_MEMNOPRESS 等 )
    int dx_GetCreateSoundDataType() ;																		// 作成するサウンドのデータ形式を取得する( DX_SOUNDDATATYPE_MEMNOPRESS 等 )
    int dx_SetEnableSoundCaptureFlag( int Flag ) ;																	// サウンドキャプチャを前提とした動作をするかどうかを設定する

// 情報取得系関数
    void dx_GetDSoundObj() ;	/* 戻り値を IDirectSound * にキャストして下さい */							// ＤＸライブラリが使用している DirectSound オブジェクトを取得する

// BEEP音再生用命令
    int dx_SetBeepFrequency( int Freq ) ;																			// ビープ音周波数設定関数
    int dx_PlayBeep() ;																						// ビープ音を再生する
    int dx_StopBeep() ;																						// ビープ音を止める

// ラッパー関数
    int dx_PlaySoundFile( const char *FileName, int PlayType ) ;													// WAVEファイルを再生する
    int dx_PlaySound( const char *FileName, int PlayType ) ;														// PlaySoundFile の旧名称
    int dx_CheckSoundFile() ;																				// WAVEファイルの再生中か調べる
    int dx_CheckSound() ;																					// CheckSoundFile の旧名称
    int dx_StopSoundFile() ;																					// WAVEファイルの再生を止める
    int dx_StopSound() ;																						// StopSoundFile の旧名称
    int dx_SetVolumeSoundFile( int VolumePal ) ;																	// WAVEファイルの音量をセットする
    int dx_SetVolumeSound( int VolumePal ) ;																		// SetVolumeSound の旧名称


// ＭＩＤＩ制御関数
    int dx_AddMusicData() ;																					// 新しいＭＩＤＩハンドルを取得する
    int dx_DeleteMusicMem( int MusicHandle ) ;																		// ＭＩＤＩハンドルを削除する
    int dx_LoadMusicMem( const char *FileName ) ;																	// ＭＩＤＩファイルを読み込む
    int dx_LoadMusicMemByMemImage( void *FileImageBuffer, int FileImageSize ) ;									// メモリ上に展開されたＭＩＤＩファイルを読み込む
    int dx_LoadMusicMemByResource( const char *ResourceName, const char *ResourceType ) ;							// リソース上のＭＩＤＩファイルを読み込む
    int dx_PlayMusicMem( int MusicHandle, int PlayType ) ;															// 読み込んだＭＩＤＩデータの演奏を開始する
    int dx_StopMusicMem( int MusicHandle ) ;																		// ＭＩＤＩデータの演奏を停止する
    int dx_CheckMusicMem( int MusicHandle ) ;																		// ＭＩＤＩデータが演奏中かどうかを取得する( TRUE:演奏中  FALSE:停止中 )
    int dx_GetMusicMemPosition( int MusicHandle ) ;																// ＭＩＤＩデータの現在の再生位置を取得する
    int dx_InitMusicMem() ;																					// ＭＩＤＩデータハンドルをすべて削除する
    int dx_ProcessMusicMem() ;																				// ＭＩＤＩデータの周期的処理

    int dx_PlayMusic( const char *FileName, int PlayType ) ;														// ＭＩＤＩファイルを演奏する
    int dx_PlayMusicByMemImage( void *FileImageBuffer, int FileImageSize, int PlayType ) ;							// メモリ上に展開されているＭＩＤＩファイルを演奏する
    int dx_PlayMusicByResource( const char *ResourceName, const char *ResourceType, int PlayType ) ;				// リソースからＭＩＤＩファイルを読み込んで演奏する
    int dx_SetVolumeMusic( int Volume ) ;																			// ＭＩＤＩの再生音量をセットする
    int dx_StopMusic() ;																						// ＭＩＤＩファイルの演奏停止
    int dx_CheckMusic() ;																					// ＭＩＤＩファイルが演奏中か否か情報を取得する
    int dx_GetMusicPosition() ;																				// ＭＩＤＩの現在の再生位置を取得する

    int dx_SelectMidiMode( int Mode ) ;																			// ＭＩＤＩの再生形式をセットする


