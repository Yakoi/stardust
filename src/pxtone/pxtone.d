module pxtone.pxtone;
extern (C){


import std.c.windows.windows;

typedef BOOL (* PXTONEPLAY_CALLBACK)( LONG clock );
alias int LONG;

// 以下 pxtone関数群 ==========================================

// pxtone を生成します。
BOOL pxtone_Ready(
	HWND hWnd,          // ウインドウハンドルを渡してください
	LONG channel_num,   // のチャンネル数を指定してください。( 1:モノラル / 2:ステレオ )
	LONG sps,           // 秒間サンプリングレートです。      ( 11025 / 22050 / 44100 )
	LONG bps,           // １サンプルを表現するビット数です。( 8 / 16 )
	float buffer_sec,   // 曲を再生するのに使用するバッファサイズを秒で指定します。( 推奨 0.1 )
	BOOL bDirectSound,  // TRUE: DirectSound を使用します / FALSE: WAVEMAPPER を使用します。
	PXTONEPLAY_CALLBACK pProc // サンプリング毎に呼ばれる関数です。NULL でかまいません。
); // pxtone の準備

// pxtone を再設定します。
BOOL pxtone_Reset(
	HWND hWnd,
	LONG channel_num,
	LONG sps,
	LONG bps,
	float buffer_sec,
	BOOL bDirectSound,
	PXTONEPLAY_CALLBACK pProc
);

// pxtone で生成されたDirectSoundのポインタ(LPDIRECTSOUND)を取得する。
// 取得したDirectSoundは自分でリリースしないように注意してください。
void *pxtone_GetDirectSound();

// ラストエラー文字列取得
char * pxtone_GetLastError();

// pxtone の音質を取得します
void pxtone_GetQuality( LONG *p_channel_num, LONG *p_sps, LONG *p_bps, LONG *p_sample_per_buf ); // pxtone

// pxtone を開放します
BOOL pxtone_Release();

// 曲を読み込みます(ファイル・リソースから)
BOOL pxtone_Tune_Load(
	HMODULE hModule,       // リソースから読む場合はモジュールハンドルを指定します。NULL でも問題ないかも。
	const char *type_name, // リソースから読む場合はリソースの種類名。外部ファイルを読む場合は NULL。
	const char *file_name  // ファイルパスもしくはリソース名。
	);

// 曲を読み込む(メモリから)
BOOL pxtone_Tune_Read( void* p, LONG size );

// 曲を解放します
BOOL pxtone_Tune_Release();

// 曲を再生します
BOOL pxtone_Tune_Start(
	LONG start_sample,     // 開始位置です。主に Stop や Fadeout で取得した値を設定します。0 で最初から。
	LONG fadein_msec       // フェードインする場合はここに時間（ミリ秒）を指定します。
	);

// フェードアウトスイッチを入れて現在再生サンプルを取得します
LONG pxtone_Tune_Fadeout( LONG msec );

// 曲のボリュームを設定します。1.0 が最大で、0.5 が半分です。
void pxtone_Tune_SetVolume( float v );

// 曲を停止して現在再生サンプルを取得
LONG pxtone_Tune_Stop();

// 再生中かどうかを調べます
BOOL pxtone_Tune_IsStreaming();

// ループ再生の ON/OFF を切り替えます
void pxtone_Tune_SetLoop( BOOL bLoop );

// 曲の情報を取得します
void pxtone_Tune_GetInformation( LONG *p_beat_num, float *p_beat_tempo, LONG *p_beat_clock, LONG *p_meas_num );

// リピート小節を取得します
LONG pxtone_Tune_GetRepeatMeas();

// 有効演奏小節を取得します(LASTイベント小節。無ければ最終小節)
LONG pxtone_Tune_GetPlayMeas();

// 曲の名称を取得します
char * pxtone_Tune_GetName();

// 曲のコメントを取得します
char * pxtone_Tune_GetComment();

// ■指定のアドレスに再生バッファを書き込みます
BOOL pxtone_Tune_Vomit(
	void* p,         // 再生バッファを吐き出すアドレスです
	LONG sample_num  // 書き込むサンプル数です
	);
// 戻り値：まだ続きがある場合は TRUE それ以外は FALSE
// １、この関数を使用する場合は pxtone_Ready() の引数 buffer_sec には 0 を設定してください。
//     pxtone のストリーミング機能が無効になります。
// ２、曲のロードと pxtone_Tune_Start() を終えてからこの関数を呼び出してください。
// ３、sample_num はサイズではなくてサンプル数です。
//     例) 11025hz 2ch 8bit を１秒吐き出す場合、sample_num は 11025 を指定する。
//         p には 22050バイト分の再生バッファが書き込まれる。
// ４、ストリーミング機能が有効な時と同様に pxtone_Tune_Fadeout() 等の関数が使えます。




// ピストンノイズを生成します
struct PXTONENOISEBUFFER
{
	ubyte* p_buf;
	int            size ;

}

void              pxtone_Noise_Release( PXTONENOISEBUFFER* p_noise );
PXTONENOISEBUFFER *pxtone_Noise_Create(
	const char* name   ,     // リソース名      を設定。外部ファイルの場合はファイルパス。
	const char* type   ,     // リソースタイプ名を設定。外部ファイルの場合はNULL。
	LONG        channel_num, LONG sps, LONG bps );

}
