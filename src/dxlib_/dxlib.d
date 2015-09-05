module dxlib.dxlib;

import dxlib.dxdirectx;

// -------------------------------------------------------------------------------
// 
// 		ＤＸライブラリ		ヘッダファイル
// 
// 				Ver 2.25
// 
// -------------------------------------------------------------------------------


// ＤＸライブラリのバージョン
const int DXLIB_VERSION = 0x3010;
const string DXLIB_VERSION_STR = "3.01";

// 設定 -----------------------------------------------------------------------

// ＤＸライブラリに必要な lib ファイルを、プロジェクトのカレントフォルダや
// コンパイラのデフォルト LIB パスに設定せずに使用される場合は以下の
// コメントを外してください
//#define DX_LIB_NOT_DEFAULTPATH


// 描画関連の関数を一切使用されない場合は以下のコメントを外して下さい
//#define DX_NOTUSE_DRAWFUNCTION


// 型定義 ---------------------------------------------------------------------

// ＤｉｒｅｃｔＩｎｐｕｔのバージョン設定
const int DIRECTINPUT_VERSION = 0x700;

//#include <windows.h>
//#include <stdio.h>

//#ifndef DWORD_PTR
//#define DWORD_PTR	DWORD
//#endif

//#ifndef LONG_PTR
//#define LONG_PTR	DWORD
//#endif

// ＤｉｒｅｃｔＸ関連定義部 ---------------------------------------------------

//#include "DxDirectX.h"
/*
#ifdef DX_USE_DIRECTX_SDK_FILE
	#include <dinput.h>
	#include <ddraw.h>
	#include <d3d.h>
	#ifndef DX_NON_MOVIE
		#include <dshow.h>
	#endif
	#include <qedit.h>
	#include <stdio.h>
	#include <dsound.h>
	#include <dmusici.h>
#else
	#include "DxDirectX.h"
#endif
*/

// ライブラリリンク定義--------------------------------------------------------

//#ifndef __DX_MAKE
//	#ifndef DX_LIB_NOT_DEFAULTPATH
//		#ifdef _DEBUG
//			#pragma comment( lib, "DxLib_d.lib"		)			//  ＤＸライブラリ使用指定
//			#pragma comment( lib, "DxUseCLib_d.lib"		)		//  標準Ｃライブラリを使用する部分の lib ファイルの使用指定
//			#pragma comment( linker, "/NODEFAULTLIB:libcmt.lib" )
//			#pragma comment( linker, "/NODEFAULTLIB:libc.lib" )
//			#pragma comment( linker, "/NODEFAULTLIB:libcd.lib" )
//		#else
//			#pragma comment( lib, "DxLib.lib"		)			//  ＤＸライブラリ使用指定
//			#pragma comment( lib, "DxUseCLib.lib"		)		//  標準Ｃライブラリを使用する部分の lib ファイルの使用指定
//			#pragma comment( linker, "/NODEFAULTLIB:libcmtd.lib" )
//			#pragma comment( linker, "/NODEFAULTLIB:libc.lib" )
//			#pragma comment( linker, "/NODEFAULTLIB:libcd.lib" )
//		#endif

		//#pragma comment( lib, "GetDirectXVer" )
		//#pragma comment( lib, "ddraw.lib"		)				//  DirectDrawライブラリ
		//#pragma comment( lib, "dinput.lib"		)			//  DirectInputライブラリ
		//#pragma comment( lib, "dxguid.lib"		)			//  DirectX GUIDライブラリ
		//#pragma comment( lib, "dsound.lib"		)			//  DirectSoundライブラリ
		//#pragma comment( lib, "libcmt.lib"		)				//  C標準マルチスレッド対応ライブラリ
//		#pragma comment( lib, "kernel32.lib"		)			//  Win32カーネルライブラリ
//		#pragma comment( lib, "comctl32.lib"		)			//　Win32API用ライブラリ
//		#pragma comment( lib, "user32.lib"		)				//  Win32API用ライブラリ
//		#pragma comment( lib, "gdi32.lib"		)				//  Win32API用ライブラリ
//		#pragma comment( lib, "advapi32.lib"		)			//  Win32API用ライブラリ
//		#pragma comment( lib, "ole32.lib"		)				//  Win32API用ライブラリ
//		#pragma comment( lib, "shell32.lib"		)				//  マルチメディアライブラリ
//		#pragma comment( lib, "winmm.lib"		)				//  マルチメディアライブラリ
//		#ifndef DX_NON_MOVIE
//			//#pragma comment( lib, "Strmiids.lib" )			//　DirectShow用ライブラリ
//		#endif
//		#ifndef DX_NON_NETWORK
//			#pragma comment( lib, "wsock32.lib" )				//  WinSockets用ライブラリ
//		#endif
//		#ifndef DX_NON_KEYEX
//			#pragma comment( lib, "imm32.lib" )					// ＩＭＥ操作用ライブラリ
//		#endif
//		#ifndef DX_NON_ACM
//			#pragma comment( lib, "msacm32.lib" )				// ＡＣＭ操作用ライブラリ 
//		#endif
//		#ifndef DX_NON_PNGREAD
//			#ifdef _DEBUG
//				#pragma comment( lib, "libpng_d.lib" )			// ＰＮＧ用ライブラリ
//				#pragma comment( lib, "zlib_d.lib" )
//			#else
//				#pragma comment( lib, "libpng.lib" )			// ＰＮＧ用ライブラリ
//				#pragma comment( lib, "zlib.lib" )
//			#endif
//		#endif
//		#ifndef DX_NON_JPEGREAD
//			#ifdef _DEBUG
//				#pragma comment( lib, "libjpeg_d.lib" )			// ＪＰＥＧ用ライブラリ
//			#else
//				#pragma comment( lib, "libjpeg.lib" )			// ＪＰＥＧ用ライブラリ
//			#endif
//		#endif
//		#ifndef DX_NON_OGGVORBIS								// ＯｇｇＶｏｒｂｉｓ用ライブラリ
//			#ifdef _DEBUG
//				#pragma comment( lib, "ogg_static_d.lib" )
//				#pragma comment( lib, "vorbis_static_d.lib" )
//				#pragma comment( lib, "vorbisfile_static_d.lib" )
//			#else
//				#pragma comment( lib, "ogg_static.lib" )
//				#pragma comment( lib, "vorbis_static.lib" )
//				#pragma comment( lib, "vorbisfile_static.lib" )
//			#endif
//		#endif
//		#ifndef DX_NON_OGGTHEORA								// ＯｇｇＴｈｅｏｒａ用ライブラリ
//			#ifndef _DEBUG
//				#pragma comment( lib, "ogg_static_d.lib" )
//				#pragma comment( lib, "vorbis_static_d.lib" )
//				#pragma comment( lib, "vorbisfile_static_d.lib" )
//
//				#pragma comment( lib, "libtheora_static.lib"		)		//  ＤＸライブラリ使用指定
//			#else
//				#pragma comment( lib, "ogg_static.lib" )
//				#pragma comment( lib, "vorbis_static.lib" )
//				#pragma comment( lib, "vorbisfile_static.lib" )
//
//				#pragma comment( lib, "libtheora_static_d.lib"		)		//  ＤＸライブラリ使用指定
//			#endif
//		#endif
//	#endif
//#endif

/*
#ifndef __DX_MAKE
	#pragma comment( linker, "/NODEFAULTLIB:libc.lib" )
	#pragma comment( linker, "/NODEFAULTLIB:libcd.lib" )
	#pragma comment( linker, "/NODEFAULTLIB:libcmtd.lib" )
	#pragma comment( linker, "/NODEFAULTLIB:msvcrt.lib" )
	#pragma comment( linker, "/NODEFAULTLIB:msvcrtd.lib" )
#endif
*/

/*
#ifndef __DX_MAKE
	#ifdef _DEBUG
		#ifndef DX_USE_VISUALC_MEM_DEBUG
			#pragma comment( linker, "/NODEFAULTLIB:libc.lib" )
			#pragma comment( linker, "/NODEFAULTLIB:libcd.lib" )
//			#pragma comment( linker, "/NODEFAULTLIB:libcmt.lib" )
			#pragma comment( linker, "/NODEFAULTLIB:libcmtd.lib" )
			#pragma comment( linker, "/NODEFAULTLIB:msvcrt.lib" )
			#pragma comment( linker, "/NODEFAULTLIB:msvcrtd.lib" )
		#else
			#pragma comment( linker, "/NODEFAULTLIB:libc.lib" )
			#pragma comment( linker, "/NODEFAULTLIB:libcd.lib" )
			#pragma comment( linker, "/NODEFAULTLIB:libcmt.lib" )
		#endif
	#else
		#pragma comment( linker, "/NODEFAULTLIB:libc.lib" )
		#pragma comment( linker, "/NODEFAULTLIB:libcd.lib" )
//		#pragma comment( linker, "/NODEFAULTLIB:libcmt.lib" )
		#pragma comment( linker, "/NODEFAULTLIB:libcmtd.lib" )
		#pragma comment( linker, "/NODEFAULTLIB:msvcrt.lib" )
		#pragma comment( linker, "/NODEFAULTLIB:msvcrtd.lib" )
	#endif
#endif
*/

/*
#ifndef __DX_MAKE
	#ifdef _DEBUG
		#pragma comment( linker, "/NODEFAULTLIB:libc.lib" )
//		#pragma comment( linker, "/NODEFAULTLIB:libcmt.lib" )
		#pragma comment( linker, "/NODEFAULTLIB:msvcrt.lib" )
		#ifdef DX_USE_MULTITASK_LIB
			#pragma comment( linker, "/NODEFAULTLIB:libcd.lib" )
		#else
			#pragma comment( linker, "/NODEFAULTLIB:libcmtd.lib" )
			#pragma comment( linker, "/NODEFAULTLIB:msvcrtd.lib" )
		#endif
	#else
		#pragma comment( linker, "/NODEFAULTLIB:libc.lib" )
		#pragma comment( linker, "/NODEFAULTLIB:libcd.lib" )
		#pragma comment( linker, "/NODEFAULTLIB:libcmtd.lib" )
		#pragma comment( linker, "/NODEFAULTLIB:msvcrtd.lib" )
		#ifdef DX_USE_MULTITASK_LIB
			#pragma comment( linker, "/NODEFAULTLIB:libc.lib" )
		#else
//			#pragma comment( linker, "/NODEFAULTLIB:libcmt.lib" )
			#pragma comment( linker, "/NODEFAULTLIB:msvcrt.lib" )
		#endif
	#endif
#endif
*/


//#ifdef DX_USE_DIRECTX_SDK_FILE
//	#ifndef __DX_MAKE
//		#ifdef __BCC
//			#ifdef strcpy
//			#undef strcpy
//			#endif
//			
//			#ifdef strcat
//			#undef strcat
//			#endif
//			
//			#ifdef sprintf
//			#undef sprintf
//			#endif
//			
//			#ifdef vsprintf
//			#undef vsprintf
//			#endif
//		#endif
//	#endif

	// strsafe.h への対抗策
//	#undef lstrcpy
//	#undef lstrcat
//	#undef wsprintf
//	#undef wvsprintf
//	#undef StrCpy
//	#undef StrCat
//	#undef StrNCat
//	#undef StrCatN
//
//	#undef lstrcpyA
//	#undef lstrcpyW
//	#undef lstrcatA
//	#undef lstrcatW
//	#undef wsprintfA
//	#undef wsprintfW
//
//	#undef StrCpyW
//	#undef StrCatW
//	#undef StrNCatA
//	#undef StrNCatW
//	#undef StrCatNA
//	#undef StrCatNW
//	#undef wvsprintfA
//	#undef wvsprintfW
//
//	#undef _tcscpy
//	#undef _ftcscpy
//	#undef _tcscat
//	#undef _ftcscat
//	#undef _stprintf
//	#undef _sntprintf
//	#undef _vstprintf
//	#undef _vsntprintf
//	#undef _getts
//
//	#undef strcpy
//	#undef wcscpy
//	#undef strcat
//	#undef wcscat
//	#undef sprintf
//	#undef swprintf
//	#undef vsprintf
//	#undef vswprintf
//	#undef _snprintf
//	#undef _snwprintf
//	#undef _vsnprintf
//	#undef _vsnwprintf
//	#undef gets
//	#undef _getws
//
//	#ifdef UNICODE
//	#define lstrcpy    lstrcpyW
//	#define lstrcat    lstrcatW
//	#define wsprintf   wsprintfW
//	#define wvsprintf  wvsprintfW
//	#else
//	#define lstrcpy    lstrcpyA
//	#define lstrcat    lstrcatA
//	#define wsprintf   wsprintfA
//	#define wvsprintf  wvsprintfA
//	#endif
//
//	#ifdef UNICODE
//	#define StrCpy  StrCpyW
//	#define StrCat  StrCatW
//	#define StrNCat StrNCatW
//	#else
//	#define StrCpy  lstrcpyA
//	#define StrCat  lstrcatA
//	#define StrNCat StrNCatA
//	#endif
//
//	#ifdef _UNICODE
//	#define _tcscpy     wcscpy
//	#define _ftcscpy    wcscpy
//	#define _tcscat     wcscat
//	#define _ftcscat    wcscat
//	#define _stprintf   swprintf
//	#define _sntprintf  _snwprintf
//	#define _vstprintf  vswprintf
//	#define _vsntprintf _vsnwprintf
//	#define _getts      _getws
//	#else
//	#define _tcscpy     strcpy
//	#define _ftcscpy    strcpy
//	#define _tcscat     strcat
//	#define _ftcscat    strcat
//	#define _stprintf   sprintf
//	#define _sntprintf  _snprintf
//	#define _vstprintf  vsprintf
//	#define _vsntprintf _vsnprintf
//	#define _getts      gets
//	#endif
//
//	#define strcpy	_STRCPY
//	#define strcat	_STRCAT
//#endif

// 定義---------------------------------------------------------------------------

alias char DX_CHAR;

//#define DX_DEFINE_START

const int MAX_IMAGE_NUM = (32768);				// 同時に持てるグラフィックハンドルの最大数( ハンドルエラーチェックのマスクに使用しているので 65536 以下の 2 のべき乗にして下さい )
const int MAX_2DSURFACE_NUM = (32768);				// ２Ｄサーフェスデータの最大数( ハンドルエラーチェックのマスクに使用しているので 65536 以下の 2 のべき乗にして下さい )
const int MAX_3DSURFACE_NUM = (65536);				// ３Ｄサーフェスデータの最大数( ハンドルエラーチェックのマスクに使用しているので 65536 以下の 2 のべき乗にして下さい )
const int MAX_IMAGE_DIVNUM  = (64);				// 画像分割の最大数
const int MAX_SURFACE_NUM   = 	(65536);				// サーフェスデータの最大数

const int MAX_SOUND_NUM = (4096);				// 同時に持てるサウンドハンドルの最大数
const int MAX_MUSIC_NUM = (256);				// 同時に持てるミュージックハンドルの最大数
const int MAX_MOVIE_NUM = (100);				// 同時に持てるムービーハンドルの最大数
const int MAX_MASK_NUM = (512);				// 同時に持てるマスクハンドルの最大数
const int MAX_FONT_NUM = (40);				// 同時に持てるフォントハンドルの最大数
const int MAX_INPUT_NUM = (20);				// 同時に持てる文字列入力ハンドルの最大数
const int MAX_SOCKET_NUM = (4096);				// 同時に持てる通信ハンドルの最大数

const int MAX_JOYPAD_NUM = (8);					// ジョイパッドの最大数
const int MAX_EVENTPROCESS_NUM = (5);					// 一度に処理するイベントの最大数

const int DEFAULT_SCREEN_SIZE_X = (640);			// デフォルトの画面の幅
const int DEFAULT_SCREEN_SIZE_Y = (480);			// デフォルトの画面の高さ
const int DEFAULT_COLOR_BITDEPTH = (16);			// デフォルトの色ビット深度

const double DEFAULT_FOV = (60.0F * 3.1415926535897932384626433832795F / 180.0F);	// デフォルトの視野角
const double DEFAULT_TAN_FOV_HALF = (0.57735026918962576450914878050196F); // tan( FOV * 0.5 )
const double DEFAULT_NEAR = (0.0F);				// NEARクリップ面
const double DEFAULT_FAR = (1000.0F);			// FARクリップ面

const int DEFAULT_FONT_SIZE = (16);				// フォントのデフォルトのサイズ
const int DEFAULT_FONT_THINCK = (6);					// フォントのデフォルトの太さ
const int DEFAULT_FONT_TYPE = ( DX_FONTTYPE_NORMAL );	// フォントのデフォルトの形態
const int DEFAULT_FONT_EDGESIZE = (1);					// フォントのデフォルトの太さ

const int FONT_CACHE_MAXNUM = (2024);				// フォントキャッシュに格納できる最大文字数
const int FONT_CACHE_MEMORYSIZE = (0x50000);			// フォントキャッシュの最大容量
const int FONT_CACHE_MAX_YLENGTH = (0x4000);			// フォントキャッシュサーフェスの最大縦幅

const int MAX_USERIMAGEREAD_FUNCNUM = (10);				// ユーザーが登録できるグラフィックロード関数の最大数


// ハンドルの内訳
const int DX_HANDLEINDEX_MASK = (0x0000ffff);		// ハンドル配列インデックスマスク
const int DX_HANDLECHECKBIT_MASK = (0x07ff0000);		// ハンドルインデックスエラーチェック用マスク
const int DX_HANDLECHECKBIT_ADDRESS = (16);				// ハンドルインデックスエラーチェック用マスクの開始アドレス
const int DX_HANDLETYPE_MASK = (0x78000000);		// ハンドルタイプマスク
const int DX_HANDLEERROR_MASK = (0x80000000);		// エラーチェックマスク( ０ではなかったらエラー )
const int DX_HANDLEERROR_OR_TYPE_MASK = (0xf8000000);		// DX_HANDLETYPE_MASK と DX_HANDLEERROR_MASK を掛け合わせたもの

// ハンドルタイプ定義
const int DX_HANDLETYPE_GRAPH = (0x08000000);		// グラフィックハンドル
const int DX_HANDLETYPE_SOUND = (0x10000000);		// サウンドハンドル
const int DX_HANDLETYPE_MOVIE = (0x18000000);		// ムービーハンドル
const int DX_HANDLETYPE_FONT = (0x20000000);		// フォントハンドル
const int DX_HANDLETYPE_2DSURFACE = (0x28000000);		// ２Ｄサーフェスハンドル
const int DX_HANDLETYPE_3DSURFACE = (0x30000000);		// ３Ｄサーフェスハンドル
const int DX_HANDLETYPE_SURFACE = (0x38000000);		// サーフェスハンドル
const int DX_HANDLETYPE_GMASK = (0x40000000);		// マスクハンドル
const int DX_HANDLETYPE_NETWORK = (0x48000000);		// ネットワークハンドル
const int DX_HANDLETYPE_KEYINPUT = (0x50000000);		// 文字列入力ハンドル
const int DX_HANDLETYPE_MUSIC = (0x58000000);		// ミュージックハンドル
const int DX_HANDLETYPE_PALETTEGRAPH = (0x60000000);		// パレットグラフィックハンドル
const int DX_HANDLETYPE_MODEL = (0x68000000);		// ３Ｄモデル

// ＷＩＮＤＯＷＳのバージョンマクロ
const int DX_WINDOWSVERSION_31 = (0x000);
const int DX_WINDOWSVERSION_95 = (0x001);
const int DX_WINDOWSVERSION_98 = (0x002);
const int DX_WINDOWSVERSION_ME = (0x003);
const int DX_WINDOWSVERSION_NT31 = (0x104);
const int DX_WINDOWSVERSION_NT40 = (0x105);
const int DX_WINDOWSVERSION_2000 = (0x106);
const int DX_WINDOWSVERSION_XP = (0x107);
const int DX_WINDOWSVERSION_VISTA = (0x108);
const int DX_WINDOWSVERSION_NT_TYPE = (0x100);

// ＤｉｒｅｃｔＸのバージョンマクロ
const int DX_DIRECTXVERSION_NON = (0);
const int DX_DIRECTXVERSION_1 = (0x10000);
const int DX_DIRECTXVERSION_2 = (0x20000);
const int DX_DIRECTXVERSION_3 = (0x30000);
const int DX_DIRECTXVERSION_4 = (0x40000);
const int DX_DIRECTXVERSION_5 = (0x50000);
const int DX_DIRECTXVERSION_6 = (0x60000);
const int DX_DIRECTXVERSION_6_1 = (0x60100);
const int DX_DIRECTXVERSION_7 = (0x70000);
const int DX_DIRECTXVERSION_8 = (0x80000);
const int DX_DIRECTXVERSION_8_1 = (0x80100);

// 文字セット
const int DX_CHARSET_DEFAULT = (0);				// デフォルト文字セット
const int DX_CHARSET_SHFTJIS = (1);				// 日本語文字セット
const int DX_CHARSET_HANGEUL = (2);				// 韓国語文字セット

// ＭＩＤＩの再生モード定義
const int DX_MIDIMODE_MCI = (0);				// ＭＣＩによる再生
const int DX_MIDIMODE_DM = (1);				// ＤｉｒｅｃｔＭｕｓｉｃによる再生

// 描画モード定義
const int DX_DRAWMODE_NEAREST = (0);				// ネアレストネイバー法で描画
const int DX_DRAWMODE_BILINEAR = (1);				// バイリニア法で描画する

// フォントのタイプ
const int DX_FONTTYPE_NORMAL = (0);				// ノーマルフォント
const int DX_FONTTYPE_EDGE = (1);				// エッジつきフォント
const int DX_FONTTYPE_ANTIALIASING = (2);				// アンチエイリアスフォント
const int DX_FONTTYPE_ANTIALIASING_EDGE = (3);				// アンチエイリアス＆エッジ付きフォント

// 描画ブレンドモード定義
const int DX_BLENDMODE_NOBLEND = (0);				// ノーブレンド
const int DX_BLENDMODE_ALPHA = (1);				// αブレンド
const int DX_BLENDMODE_ADD = (2);				// 加算ブレンド
const int DX_BLENDMODE_SUB = (3);				// 減算ブレンド
const int DX_BLENDMODE_MUL = (4);				// 乗算ブレンド
   // (内部処理用)
const int DX_BLENDMODE_SUB2 = (5);				// 内部処理用減算ブレンド子１
const int DX_BLENDMODE_BLINEALPHA = (7);				// 境界線ぼかし
const int DX_BLENDMODE_XOR = (6);				// XORブレンド
const int DX_BLENDMODE_DESTCOLOR = (8);				// カラーは更新されない
const int DX_BLENDMODE_INVDESTCOLOR = (9);				// 描画先の色の反転値を掛ける
const int DX_BLENDMODE_INVSRC = (10);			// 描画元の色を反転する
const int DX_BLENDMODE_MULA = (11);			// アルファチャンネル考慮付き乗算ブレンド

// 描画先画面指定用定義
const int DX_SCREEN_FRONT = (0xfffffffc);
const int DX_SCREEN_BACK = (0xfffffffe); 
const int DX_SCREEN_WORK = (0xfffffffd);
const int DX_SCREEN_TEMPFRONT = (0xfffffffb);

const int DX_NONE_GRAPH = (0xfffffffb);	// グラフィックなしハンドル

// グラフィック減色時の画像劣化緩和処理モード
const int DX_SHAVEDMODE_NONE = (0);				// 画像劣化緩和処理を行わない
const int DX_SHAVEDMODE_DITHER = (1);				// ディザリング
const int DX_SHAVEDMODE_DIFFUS = (2);				// 誤差拡散

// 画像の保存タイプ
const int DX_IMAGESAVETYPE_BMP = (0);				// bitmap
const int DX_IMAGESAVETYPE_JPEG = (1);				// jpeg
const int DX_IMAGESAVETYPE_PNG = (2);				// Png

// サウンド再生形態指定用定義
const int DX_PLAYTYPE_LOOPBIT = (0x0002);		// ループ再生ビット
const int DX_PLAYTYPE_BACKBIT = (0x0001);		// バックグラウンド再生ビット
	
const int DX_PLAYTYPE_NORMAL = (0);												// ノーマル再生
const int DX_PLAYTYPE_BACK = ( DX_PLAYTYPE_BACKBIT );							// バックグラウンド再生
const int DX_PLAYTYPE_LOOP = ( DX_PLAYTYPE_LOOPBIT | DX_PLAYTYPE_BACKBIT );	// ループ再生

// 動画再生タイプ定義
const int DX_MOVIEPLAYTYPE_BCANCEL = (0);				// ボタンキャンセルあり
const int DX_MOVIEPLAYTYPE_NORMAL = (1);				// ボタンキャンセルなし

// サウンドのタイプ
const int DX_SOUNDTYPE_NORMAL = (0);				// ノーマルサウンド形式
const int DX_SOUNDTYPE_STREAMSTYLE = (1);				// ストリーム風サウンド形式

// ストリームサウンド再生データタイプのマクロ
const int DX_SOUNDDATATYPE_MEMNOPRESS = (0);				// 圧縮された全データは再生が始まる前にサウンドメモリにすべて解凍され、格納される
const int DX_SOUNDDATATYPE_MEMNOPRESS_PLUS = (1);				// 圧縮された全データはシステムメモリに格納され、再生しながら逐次解凍され、最終的にすべてサウンドメモリに格納される(その後システムメモリに存在する圧縮データは破棄される)
const int DX_SOUNDDATATYPE_MEMPRESS = (2);				// 圧縮された全データはシステムメモリに格納され、再生する部分だけ逐次解凍しながらサウンドメモリに格納する(鳴らし終わると解凍したデータは破棄されるので何度も解凍処理が行われる)
const int DX_SOUNDDATATYPE_FILE = (3);				// 圧縮されたデータの再生する部分だけファイルから逐次読み込み解凍され、サウンドメモリに格納される(鳴らし終わると解凍したデータは破棄されるので何度も解凍処理が行われる)

// マスク透過色モード
const int DX_MASKTRANS_WHITE = (0);				// マスク画像の白い部分を透過色とする
const int DX_MASKTRANS_BLACK = (1);				// マスク画像の黒い部分を透過色とする
const int DX_MASKTRANS_NONE = (2); 			// 透過色なし

// Ｚバッファ書き込みモード
const int DX_ZWRITE_MASK = (0);				// 書き込めないようにマスクする
const int DX_ZWRITE_CLEAR = (1);				// 書き込めるようにマスクをクリアする

// 比較モード
const int DX_CMP_NEVER = (1);				// FALSE
const int DX_CMP_LESS = (2);				// Src <  Dest
const int DX_CMP_EQUAL = (3);				// Src == Dest
const int DX_CMP_LESSEQUAL = (4);				// Src <= Dest
const int DX_CMP_GREATER = (5);				// Src >  Dest
const int DX_CMP_NOTEQUAL = (6);				// Src != Dest
const int DX_CMP_GREATEREQUAL = (7);				// Src >= Dest
const int DX_CMP_ALWAYS = (8);				// TRUE
const int DX_ZCMP_DEFAULT = ( DX_CMP_LESSEQUAL );
const int DX_ZCMP_REVERSE = ( DX_CMP_GREATEREQUAL );

// シェーディングモード
const int DX_SHADEMODE_FLAT = D_D3DSHADEMODE.D_D3DSHADE_FLAT;
const int DX_SHADEMODE_GOURAUD = D_D3DSHADEMODE.D_D3DSHADE_GOURAUD;

// テクスチャアドレスタイプ
const int DX_TEXADDRESS_WRAP   = D_D3DTEXTUREADDRESS.D_D3DTADDRESS_WRAP;
const int DX_TEXADDRESS_MIRROR = D_D3DTEXTUREADDRESS.D_D3DTADDRESS_MIRROR;
const int DX_TEXADDRESS_CLAMP  = D_D3DTEXTUREADDRESS.D_D3DTADDRESS_CLAMP;
const int DX_TEXADDRESS_BORDER = D_D3DTEXTUREADDRESS.D_D3DTADDRESS_BORDER;

// ポリゴン描画タイプ
const int DX_PRIMTYPE_POINTLIST     = D_D3DPRIMITIVETYPE.D_D3DPT_POINTLIST;
const int DX_PRIMTYPE_LINELIST      = D_D3DPRIMITIVETYPE.D_D3DPT_LINELIST;
const int DX_PRIMTYPE_LINESTRIP     = D_D3DPRIMITIVETYPE.D_D3DPT_LINESTRIP;
const int DX_PRIMTYPE_TRIANGLELIST  = D_D3DPRIMITIVETYPE.D_D3DPT_TRIANGLELIST;
const int DX_PRIMTYPE_TRIANGLESTRIP = D_D3DPRIMITIVETYPE.D_D3DPT_TRIANGLESTRIP;
const int DX_PRIMTYPE_TRIANGLEFAN   = D_D3DPRIMITIVETYPE.D_D3DPT_TRIANGLEFAN;

// ライトタイプ
const int DX_LIGHTTYPE_D3DLIGHT_POINT       = D_D3DLIGHTTYPE.D_D3DLIGHT_POINT;
const int DX_LIGHTTYPE_D3DLIGHT_SPOT        = D_D3DLIGHTTYPE.D_D3DLIGHT_SPOT;
const int DX_LIGHTTYPE_D3DLIGHT_DIRECTIONAL = D_D3DLIGHTTYPE.D_D3DLIGHT_DIRECTIONAL;
const int DX_LIGHTTYPE_D3DLIGHT_FORCEDWORD  = D_D3DLIGHTTYPE.D_D3DLIGHT_FORCE_DWORD;

// グラフィックイメージフォーマットの定義
const int DX_GRAPHICSIMAGE_FORMAT_3D_RGB16 = (0);		// １６ビットカラー標準
const int DX_GRAPHICSIMAGE_FORMAT_3D_RGB32 = (1);		// ３２ビットカラー標準
const int DX_GRAPHICSIMAGE_FORMAT_3D_ALPHA_RGB16 = (2);		// αチャンネル付き１６ビットカラー
const int DX_GRAPHICSIMAGE_FORMAT_3D_ALPHA_RGB32 = (3);		// αチャンネル付き３２ビットカラー
const int DX_GRAPHICSIMAGE_FORMAT_3D_ALPHATEST_RGB16 = (4);		// αテスト付き１６ビットカラー
const int DX_GRAPHICSIMAGE_FORMAT_3D_ALPHATEST_RGB32 = (5);		// αテスト付き３２ビットカラー
const int DX_GRAPHICSIMAGE_FORMAT_3D_DRAWVALID_RGB16 = (6);		// 描画可能１６ビットカラー
const int DX_GRAPHICSIMAGE_FORMAT_3D_DRAWVALID_RGB32 = (7);		// 描画可能３２ビットカラー
const int DX_GRAPHICSIMAGE_FORMAT_3D_DRAWVALID_ALPHA_RGB32 = (8);		// 描画可能α付き３２ビットカラー
const int DX_GRAPHICSIMAGE_FORMAT_3D_NUM = (9);
const int DX_GRAPHICSIMAGE_FORMAT_2D = (9);		// 標準( DirectDrawSurface の場合はこれのみ )
const int DX_GRAPHICSIMAGE_FORMAT_R5G6B5 = (10);	// R5G6B5( MEMIMG 用 )
const int DX_GRAPHICSIMAGE_FORMAT_X8A8R5G6B5 = (11);	// X8A8R5G6B5( MEMIMG 用 )
const int DX_GRAPHICSIMAGE_FORMAT_X8R8G8B8 = (12);	// X8R8G8B8( MEMIMG 用 )
const int DX_GRAPHICSIMAGE_FORMAT_A8R8G8B8 = (13);	// A8R8G8B8( MEMIMG 用 )

const int DX_GRAPHICSIMAGE_FORMAT_NUM = (14);	// グラフィックフォーマットの種類の数

// ツールバーのボタンの状態
const int TOOLBUTTON_STATE_ENABLE = (0);			// 入力可能な状態
const int TOOLBUTTON_STATE_PRESSED = (1);			// 押されている状態
const int TOOLBUTTON_STATE_DISABLE = (2);			// 入力不可能な状態
const int TOOLBUTTON_STATE_PRESSED_DISABLE = (3);			// 押されている状態で、入力不可能な状態
const int TOOLBUTTON_STATE_NUM = (4);			// ツールバーのボタンの状態の数

// ツールバーのボタンのタイプ
const int TOOLBUTTON_TYPE_NORMAL = (0);			// 普通のボタン
const int TOOLBUTTON_TYPE_CHECK = (1);			// 押すごとにＯＮ／ＯＦＦが切り替わるボタン
const int TOOLBUTTON_TYPE_GROUP = (2);			// 別の TOOLBUTTON_TYPE_GROUP タイプのボタンが押されるとＯＦＦになるタイプのボタン(グループの区切りは隙間で)
const int TOOLBUTTON_TYPE_SEP = (3);			// 隙間(ボタンではありません)
const int TOOLBUTTON_TYPE_NUM = (4);			// ツールバーのボタンのタイプの数

// 親メニューのＩＤ
const int MENUITEM_IDTOP = (0xabababab);

// メニューに追加する際のタイプ
const int MENUITEM_ADD_CHILD = (0);				// 指定の項目の子として追加する
const int MENUITEM_ADD_INSERT = (1);				// 指定の項目と指定の項目より一つ上の項目の間に追加する

// メニューの横に付くマークタイプ
const int MENUITEM_MARK_NONE = (0);				// 何も付け無い
const int MENUITEM_MARK_CHECK = (1);				// チェックマーク
const int MENUITEM_MARK_RADIO = (2);				// ラジオボタン

// 文字変換タイプ定義
const int DX_NUMMODE_10 = (0);				// １０進数
const int DX_NUMMODE_16 = (1);				// １６進数
const int DX_STRMODE_NOT0 = (2);				// 空きを０で埋めない
const int DX_STRMODE_USE0 = (3);				// 空きを０で埋める

// CheckHitKeyAll で調べる入力タイプ
const int DX_CHECKINPUT_KEY = (0x0001);		// キー入力を調べる
const int DX_CHECKINPUT_PAD = (0x0002);		// パッド入力を調べる
const int DX_CHECKINPUT_MOUSE = (0x0004);		// マウスボタン入力を調べる
const int DX_CHECKINPUT_ALL = (DX_CHECKINPUT_KEY | DX_CHECKINPUT_PAD | DX_CHECKINPUT_MOUSE);	// すべての入力を調べる

// パッド入力取得パラメータ
const int DX_INPUT_KEY_PAD1 = (0x1001);		// キー入力とパッド１入力
const int DX_INPUT_PAD1 = (0x0001);		// パッド１入力
const int DX_INPUT_PAD2 = (0x0002);		// パッド２入力
const int DX_INPUT_PAD3 = (0x0003);		// パッド３入力
const int DX_INPUT_PAD4 = (0x0004);		// パッド４入力
const int DX_INPUT_PAD5 = (0x0005);		// パッド５入力
const int DX_INPUT_PAD6 = (0x0006);		// パッド６入力
const int DX_INPUT_PAD7 = (0x0007);		// パッド７入力
const int DX_INPUT_PAD8 = (0x0008);		// パッド８入力
const int DX_INPUT_KEY = (0x1000);		// キー入力

// ムービーのサーフェスモード
const int DX_MOVIESURFACE_NORMAL = (0);
const int DX_MOVIESURFACE_OVERLAY = (1);
const int DX_MOVIESURFACE_FULLCOLOR = (2);

// パッド入力定義
const int PAD_INPUT_DOWN = (0x00000001);	// ↓チェックマスク
const int PAD_INPUT_LEFT = (0x00000002);	// ←チェックマスク
const int PAD_INPUT_RIGHT = (0x00000004);	// →チェックマスク
const int PAD_INPUT_UP = (0x00000008);	// ↑チェックマスク
const int PAD_INPUT_A = (0x00000010);	// Ａボタンチェックマスク
const int PAD_INPUT_B = (0x00000020);	// Ｂボタンチェックマスク
const int PAD_INPUT_C = (0x00000040);	// Ｃボタンチェックマスク
const int PAD_INPUT_X = (0x00000080);	// Ｘボタンチェックマスク
const int PAD_INPUT_Y = (0x00000100);	// Ｙボタンチェックマスク
const int PAD_INPUT_Z = (0x00000200);	// Ｚボタンチェックマスク
const int PAD_INPUT_L = (0x00000400);	// Ｌボタンチェックマスク
const int PAD_INPUT_R = (0x00000800);	// Ｒボタンチェックマスク
const int PAD_INPUT_START = (0x00001000);	// ＳＴＡＲＴボタンチェックマスク
const int PAD_INPUT_M = (0x00002000);	// Ｍボタンチェックマスク
const int PAD_INPUT_D = (0x00004000);
const int PAD_INPUT_F = (0x00008000);
const int PAD_INPUT_G = (0x00010000);
const int PAD_INPUT_H = (0x00020000);
const int PAD_INPUT_I = (0x00040000);
const int PAD_INPUT_J = (0x00080000);
const int PAD_INPUT_K = (0x00100000);
const int PAD_INPUT_LL = (0x00200000);
const int PAD_INPUT_N = (0x00400000);
const int PAD_INPUT_O = (0x00800000);
const int PAD_INPUT_P = (0x01000000);
const int PAD_INPUT_RR = (0x02000000);
const int PAD_INPUT_S = (0x04000000);
const int PAD_INPUT_T = (0x08000000);
const int PAD_INPUT_U = (0x10000000);
const int PAD_INPUT_V = (0x20000000);
const int PAD_INPUT_W = (0x40000000);
const int PAD_INPUT_XX = (0x80000000);

// マウス入力定義
const int MOUSE_INPUT_LEFT = (0x0001);			// マウス左ボタン
const int MOUSE_INPUT_RIGHT = (0x0002);			// マウス右ボタン
const int MOUSE_INPUT_MIDDLE = (0x0004);			// マウス中央ボタン
const int MOUSE_INPUT_1 = (0x0001);			// マウス１ボタン
const int MOUSE_INPUT_2 = (0x0002);			// マウス２ボタン
const int MOUSE_INPUT_3 = (0x0004);			// マウス３ボタン
const int MOUSE_INPUT_4 = (0x0008);			// マウス４ボタン
const int MOUSE_INPUT_5 = (0x0010);			// マウス５ボタン
const int MOUSE_INPUT_6 = (0x0020);			// マウス６ボタン
const int MOUSE_INPUT_7 = (0x0040);			// マウス７ボタン
const int MOUSE_INPUT_8 = (0x0080);			// マウス８ボタン

// キー定義
const int KEY_INPUT_BACK = D_DIK_BACK;			// バックスペースキー
const int KEY_INPUT_TAB = D_DIK_TAB;			// タブキー
const int KEY_INPUT_RETURN = D_DIK_RETURN;		// エンターキー

const int KEY_INPUT_LSHIFT = D_DIK_LSHIFT;		// 左シフトキー
const int KEY_INPUT_RSHIFT = D_DIK_RSHIFT;		// 右シフトキー
const int KEY_INPUT_LCONTROL = D_DIK_LCONTROL;		// 左コントロールキー
const int KEY_INPUT_RCONTROL = D_DIK_RCONTROL;		// 右コントロールキー
const int KEY_INPUT_ESCAPE = D_DIK_ESCAPE;		// エスケープキー
const int KEY_INPUT_SPACE = D_DIK_SPACE;			// スペースキー
const int KEY_INPUT_PGUP = D_DIK_PGUP;			// ＰａｇｅＵＰキー
const int KEY_INPUT_PGDN = D_DIK_PGDN;			// ＰａｇｅＤｏｗｎキー
const int KEY_INPUT_END = D_DIK_END;			// エンドキー
const int KEY_INPUT_HOME = D_DIK_HOME;			// ホームキー
const int KEY_INPUT_LEFT = D_DIK_LEFT;			// 左キー
const int KEY_INPUT_UP = D_DIK_UP;			// 上キー
const int KEY_INPUT_RIGHT = D_DIK_RIGHT;			// 右キー
const int KEY_INPUT_DOWN = D_DIK_DOWN;			// 下キー
const int KEY_INPUT_INSERT = D_DIK_INSERT;		// インサートキー
const int KEY_INPUT_DELETE = D_DIK_DELETE;		// デリートキー

const int KEY_INPUT_MINUS = D_DIK_MINUS;			// －キー
const int KEY_INPUT_YEN = D_DIK_YEN;			// ￥キー
const int KEY_INPUT_PREVTRACK = D_DIK_PREVTRACK;		// ＾キー
const int KEY_INPUT_PERIOD = D_DIK_PERIOD;		// ．キー
const int KEY_INPUT_SLASH = D_DIK_SLASH;			// ／キー
const int KEY_INPUT_LALT = D_DIK_LALT;			// 左ＡＬＴキー
const int KEY_INPUT_RALT = D_DIK_RALT;			// 右ＡＬＴキー
const int KEY_INPUT_SCROLL = D_DIK_SCROLL;		// ScrollLockキー
const int KEY_INPUT_SEMICOLON = D_DIK_SEMICOLON;		// ；キー
const int KEY_INPUT_COLON = D_DIK_COLON;			// ：キー
const int KEY_INPUT_LBRACKET = D_DIK_LBRACKET;		// ［キー
const int KEY_INPUT_RBRACKET = D_DIK_RBRACKET;		// ］キー
const int KEY_INPUT_AT = D_DIK_AT;			// ＠キー
const int KEY_INPUT_BACKSLASH = D_DIK_BACKSLASH;		// ＼キー
const int KEY_INPUT_COMMA = D_DIK_COMMA;			// ，キー
const int KEY_INPUT_CAPSLOCK = D_DIK_CAPSLOCK;		// CaspLockキー
const int KEY_INPUT_SYSRQ = D_DIK_SYSRQ;			// PrintScreenキー
const int KEY_INPUT_PAUSE = D_DIK_PAUSE;			// PauseBreakキー

const int KEY_INPUT_NUMPAD0 = D_DIK_NUMPAD0;		// テンキー０
const int KEY_INPUT_NUMPAD1 = D_DIK_NUMPAD1;		// テンキー１
const int KEY_INPUT_NUMPAD2 = D_DIK_NUMPAD2;		// テンキー２
const int KEY_INPUT_NUMPAD3 = D_DIK_NUMPAD3;		// テンキー３
const int KEY_INPUT_NUMPAD4 = D_DIK_NUMPAD4;		// テンキー４
const int KEY_INPUT_NUMPAD5 = D_DIK_NUMPAD5;		// テンキー５
const int KEY_INPUT_NUMPAD6 = D_DIK_NUMPAD6;		// テンキー６
const int KEY_INPUT_NUMPAD7 = D_DIK_NUMPAD7;		// テンキー７
const int KEY_INPUT_NUMPAD8 = D_DIK_NUMPAD8;		// テンキー８
const int KEY_INPUT_NUMPAD9 = D_DIK_NUMPAD9;		// テンキー９
const int KEY_INPUT_MULTIPLY = D_DIK_MULTIPLY;		// テンキー＊キー
const int KEY_INPUT_ADD = D_DIK_ADD;			// テンキー＋キー
const int KEY_INPUT_SUBTRACT = D_DIK_SUBTRACT;		// テンキー－キー
const int KEY_INPUT_DECIMAL = D_DIK_DECIMAL;		// テンキー．キー
const int KEY_INPUT_DIVIDE = D_DIK_DIVIDE;		// テンキー／キー
const int KEY_INPUT_NUMPADENTER = D_DIK_NUMPADENTER;	// テンキーのエンターキー

const int KEY_INPUT_F1 = D_DIK_F1;			// Ｆ１キー
const int KEY_INPUT_F2 = D_DIK_F2;			// Ｆ２キー
const int KEY_INPUT_F3 = D_DIK_F3;			// Ｆ３キー
const int KEY_INPUT_F4 = D_DIK_F4;			// Ｆ４キー
const int KEY_INPUT_F5 = D_DIK_F5;			// Ｆ５キー
const int KEY_INPUT_F6 = D_DIK_F6;			// Ｆ６キー
const int KEY_INPUT_F7 = D_DIK_F7;			// Ｆ７キー
const int KEY_INPUT_F8 = D_DIK_F8;			// Ｆ８キー
const int KEY_INPUT_F9 = D_DIK_F9;			// Ｆ９キー
const int KEY_INPUT_F10 = D_DIK_F10;			// Ｆ１０キー
const int KEY_INPUT_F11 = D_DIK_F11;			// Ｆ１１キー
const int KEY_INPUT_F12 = D_DIK_F12;			// Ｆ１２キー

const int KEY_INPUT_A = D_DIK_A;			// Ａキー
const int KEY_INPUT_B = D_DIK_B;			// Ｂキー
const int KEY_INPUT_C = D_DIK_C;			// Ｃキー
const int KEY_INPUT_D = D_DIK_D;			// Ｄキー
const int KEY_INPUT_E = D_DIK_E;			// Ｅキー
const int KEY_INPUT_F = D_DIK_F;			// Ｆキー
const int KEY_INPUT_G = D_DIK_G;			// Ｇキー
const int KEY_INPUT_H = D_DIK_H;			// Ｈキー
const int KEY_INPUT_I = D_DIK_I;			// Ｉキー
const int KEY_INPUT_J = D_DIK_J;			// Ｊキー
const int KEY_INPUT_K = D_DIK_K;			// Ｋキー
const int KEY_INPUT_L = D_DIK_L;			// Ｌキー
const int KEY_INPUT_M = D_DIK_M;			// Ｍキー
const int KEY_INPUT_N = D_DIK_N;			// Ｎキー
const int KEY_INPUT_O = D_DIK_O;			// Ｏキー
const int KEY_INPUT_P = D_DIK_P;			// Ｐキー
const int KEY_INPUT_Q = D_DIK_Q;			// Ｑキー
const int KEY_INPUT_R = D_DIK_R;			// Ｒキー
const int KEY_INPUT_S = D_DIK_S;			// Ｓキー
const int KEY_INPUT_T = D_DIK_T;			// Ｔキー
const int KEY_INPUT_U = D_DIK_U;			// Ｕキー
const int KEY_INPUT_V = D_DIK_V;			// Ｖキー
const int KEY_INPUT_W = D_DIK_W;			// Ｗキー
const int KEY_INPUT_X = D_DIK_X;			// Ｘキー
const int KEY_INPUT_Y = D_DIK_Y;			// Ｙキー
const int KEY_INPUT_Z = D_DIK_Z;			// Ｚキー

const int KEY_INPUT_0 = D_DIK_0;			// ０キー
const int KEY_INPUT_1 = D_DIK_1;			// １キー
const int KEY_INPUT_2 = D_DIK_2;			// ２キー
const int KEY_INPUT_3 = D_DIK_3;			// ３キー
const int KEY_INPUT_4 = D_DIK_4;			// ４キー
const int KEY_INPUT_5 = D_DIK_5;			// ５キー
const int KEY_INPUT_6 = D_DIK_6;			// ６キー
const int KEY_INPUT_7 = D_DIK_7;			// ７キー
const int KEY_INPUT_8 = D_DIK_8;			// ８キー
const int KEY_INPUT_9 = D_DIK_9;			// ９キー

// アスキーコントロールキーコード
const int CTRL_CODE_BS = (0x08);				// バックスペース
const int CTRL_CODE_TAB = (0x09);				// タブ
const int CTRL_CODE_CR = (0x0d);				// 改行
const int CTRL_CODE_DEL = (0x10);				// ＤＥＬキー

const int CTRL_CODE_LEFT = (0x1d);				// ←キー
const int CTRL_CODE_RIGHT = (0x1c);				// →キー
const int CTRL_CODE_UP = (0x1e);				// ↑キー
const int CTRL_CODE_DOWN = (0x1f);				// ↓キー

const int CTRL_CODE_ESC = (0x1b);				// ＥＳＣキー
const int CTRL_CODE_CMP = (0x20);				// 制御コード敷居値

// SetGraphMode 戻り値定義
const int DX_CHANGESCREEN_OK = (0);					// 画面変更は成功した
const int DX_CHANGESCREEN_RETURN = (-1);				// 画面の変更は失敗し、元の画面モードに戻された
const int DX_CHANGESCREEN_DEFAULT = (-2);				// 画面の変更は失敗しデフォルトの画面モードに変更された
const int DX_CHANGESCREEN_REFRESHNORMAL = (-3);				// 画面の変更は成功したが、リフレッシュレートの変更は失敗した

// ストリームデータ読み込み処理コード簡略化関連
LONG STTELL(T)(T st ){return ((st).ReadShred.Tell( (st).DataPoint ));}
int STSEEK(T)(T st, long pos, int type ){return ((st).ReadShred.Seek( (st).DataPoint, (pos), (type) ));}
size_t STREAD(T)(void* buf, size_t length, size_t num, T st ){return ((st).ReadShred.Read( (buf), (length), (num), (st).DataPoint ));}
size_t STWRITE(T)(void* buf, size_t length, size_t num, T st ){return ((st).ReadShred.Write( (buf), (length), (num), (st).DataPoint ));}
int STEOF(T)( T st ){return ((st).ReadShred.Eof( (st).DataPoint ));}
int STCLOSE(T)(T st ){return ((st).ReadShred.Close( (st).DataPoint ));}

// ストリームデータ制御のシークタイプ定義
//const int STREAM_SEEKTYPE_SET = (SEEK_SET);
//const int STREAM_SEEKTYPE_END = (SEEK_END);
//const int STREAM_SEEKTYPE_CUR = (SEEK_CUR);

// グラフィックロード時のイメージタイプ
const int LOADIMAGE_TYPE_FILE = (0);				// イメージはファイルである
const int LOADIMAGE_TYPE_MEM = (1);				// イメージはメモリである
const int LOADIMAGE_TYPE_NONE = (-1);			// イメージは無い

// DrawPreparation 関数に渡すフラグ
const int DRAWPREP_TRANS = (0x0001);
const int DRAWPREP_VECTORINT = (0x0002);
const int DRAWPREP_ENABLEZBUFFER = (0x0004);
const int DRAWPREP_GOURAUDSHADE = (0x0008);
const int DRAWPREP_PERSPECTIVE = (0x0010);
const int DRAWPREP_DIFFUSERGB = (0x0020);
const int DRAWPREP_DIFFUSEALPHA = (0x0040);

//#ifndef DX_NON_NETWORK

// HTTP エラー
const int HTTP_ERR_SERVER = (0);				// サーバーエラー
const int HTTP_ERR_NOTFOUND = (1);				// ファイルが見つからなかった
const int HTTP_ERR_MEMORY = (2);				// メモリ確保の失敗
const int HTTP_ERR_LOST = (3);				// 途中で切断された
const int HTTP_ERR_NONE = (-1);			// エラーは報告されていない

// HTTP 処理の結果
const int HTTP_RES_COMPLETE = (0);				// 処理完了
const int HTTP_RES_STOP = (1);				// 処理中止
const int HTTP_RES_ERROR = (2);				// エラー終了
const int HTTP_RES_NOW = (-1);			// 現在進行中

//#endif

//#define DX_DEFINE_END

// データ型定義-------------------------------------------------------------------

//#define DX_STRUCT_START

// ＩＭＥ入力文字列の描画に必要な情報の内の文節情報
struct tagIMEINPUTCLAUSEDATA
{
	int						Position ;				// 何バイト目から
	int						Length ;				// 何バイトか
}
alias tagIMEINPUTCLAUSEDATA IMEINPUTCLAUSEDATA;
alias tagIMEINPUTCLAUSEDATA*LPIMEINPUTCLAUSEDATA;

// ＩＭＥ入力文字列の描画に必要な情報
struct tagIMEINPUTDATA
{
	const char *				InputString ;			// 入力中の文字列

	int							CursorPosition ;		// カーソルの入力文字列中の位置(バイト単位)

	const IMEINPUTCLAUSEDATA *	ClauseData ;			// 文節情報
	int							ClauseNum ;				// 文節情報の数
	int							SelectClause ;			// 選択中の分節( -1 の場合はどの文節にも属していない( 末尾にカーソルがある ) )

	int							CandidateNum ;			// 変換候補の数( 0の場合は変換中ではない )
	const char **				CandidateList ;			// 変換候補文字列リスト( 例：ｎ番目の候補を描画する場合  DrawString( 0, 0, data.CandidateList[ n ], GetColor(255,255,255) ); )
	int							SelectCandidate ;		// 選択中の変換候補
}
alias tagIMEINPUTDATA IMEINPUTDATA;
alias tagIMEINPUTDATA *LPIMEINPUTDATA ;

// タイムデータ型
struct tagDATEDATA
{
	int						Year ;							// 年
	int						Mon ;							// 月
	int						Day ;							// 日
	int						Hour ;							// 時間
	int						Min ;							// 分
	int						Sec ;							// 秒
}
alias tagDATEDATA DATEDATA;
alias tagDATEDATA *LPDATEDATA ;

// 画面モード情報データ型
struct tagDISPLAYMODEDATA
{
	int						Width ;				// 水平解像度
	int						Height ;			// 垂直解像度
	int						ColorBitDepth ;		// 色ビット深度
	int						RefreshRate ;		// リフレッシュレート( -1 の場合は規定値 )
}
alias tagDISPLAYMODEDATA DISPLAYMODEDATA;
alias tagDISPLAYMODEDATA *LPDISPLAYMODEDATA ;

// ファイル情報構造体
struct tagFILEINFO
{
	char					Name[260] ;			// オブジェクト名
	int						DirFlag ;			// ディレクトリかどうか( TRUE:ディレクトリ  FALSE:ファイル )
	long				Size ;				// サイズ
	DATEDATA				CreationTime ;		// 作成時刻
	DATEDATA				LastWriteTime ;		// 最終更新時刻
}
alias tagFILEINFO FILEINFO;
alias tagFILEINFO *LPFILEINFO ;

//#ifndef DX_NOTUSE_DRAWFUNCTION

// 行列構造体
struct tagMATRIX
{
	float					m[4][4] ;
}
alias tagMATRIX MATRIX;
alias tagMATRIX *LPMATRIX ;

// ベクトルデータ型
struct tagVECTOR
{
	float					x, y, z ;
}
alias tagVECTOR VECTOR;
alias tagVECTOR *LPVECTOR ;

// クォータニオンデータ構造体
struct tagQT
{
	float w ;
	VECTOR v ;
}
alias tagQT QT;
alias tagQT *LPQT ;

// ２Ｄ描画用頂点構造体(テクスチャ無し)
struct tagVERTEX_NOTEX_2D
{
	VECTOR					pos ;
	float					rhw ;
	int						color ;
}
alias tagVERTEX_NOTEX_2D VERTEX_NOTEX_2D; 
alias tagVERTEX_NOTEX_2D *LPVERTEX_NOTEX_2D ; 

// 主に２Ｄ描画に使用する頂点データ型
struct tagVERTEX_2D
{
	VECTOR					pos ;
	float					rhw ;
	int						color ;
	float					u, v ;
}
alias tagVERTEX_2D VERTEX_2D; 
alias tagVERTEX_2D *LPVERTEX_2D ; 

// 主に２Ｄ描画に使用する頂点データ型(公開用)
struct tagVERTEX
{
	float					x, y ;
	float					u, v ;
	ubyte			b, g, r, a ;
}
alias tagVERTEX VERTEX ;

// 主に３Ｄ描画に使用する頂点データ型
struct tagVERTEX_3D
{
	VECTOR					pos ;
	ubyte			b, g, r, a ;
	float					u, v ;
}
alias tagVERTEX_3D VERTEX_3D;
alias tagVERTEX_3D *LPVERTEX_3D ;

// 主に３Ｄ描画に使用する頂点データ型のライト対応版
struct tagVERTEX_3D_LIGHT
{
	VECTOR					pos ;
	VECTOR					normal ;
	ubyte			b, g, r, a ;
	float					u, v ;
}// VERTEX_3D_LIGHT, *LPVERTEX_3D_LIGHT ;

// float 型のカラー値
struct tagCOLOR_F
{
	float					r, g, b, a ;
}// COLOR_F, *LPCOLOR_F ;

// ubyte 型のカラー値
struct tagCOLOR_U8
{
	byte b, g, r, a ;
}// COLOR_U8 ;

//#endif // DX_NOTUSE_DRAWFUNCTION






// ストリームデータ制御用関数ポインタ構造体タイプ２
struct tagSTREAMDATASHREDTYPE2
{
	int						(*Open)( const char *Path, int UseCacheFlag, int BlockReadFlag, int UseASyncReadFlag ) ;
	int						(*Close)( int Handle ) ;
	long					(*Tell)( int Handle ) ;
	int						(*Seek)( int Handle, long SeekPoint, int SeekType ) ;
	size_t					(*Read)( void *Buffer, size_t BlockSize, size_t DataNum, int Handle ) ;
	int						(*Eof)( int Handle ) ;
	int						(*IdleCheck)( int Handle ) ;
	int						(*ChDir)( const char *Path ) ;
	int						(*GetDir)( char *Buffer ) ;
	int						(*FindFirst)( const char *FilePath, FILEINFO *Buffer ) ;	// 戻り値: -1=エラー  -1以外=FindHandle
	int						(*FindNext)( int FindHandle, FILEINFO *Buffer ) ;			// 戻り値: -1=エラー  0=成功
	int						(*FindClose)( int FindHandle ) ;							// 戻り値: -1=エラー  0=成功
}
alias tagSTREAMDATASHREDTYPE2 STREAMDATASHREDTYPE2 ;

// ストリームデータ制御用関数ポインタ構造体
struct tagSTREAMDATASHRED
{
	long					(*Tell)( void *StreamDataPoint ) ;
	int						(*Seek)( void *StreamDataPoint, long SeekPoint, int SeekType ) ;
	size_t					(*Read)( void *Buffer, size_t BlockSize, size_t DataNum, void *StreamDataPoint ) ;
//	size_t					(*Write)( void *Buffer, size_t BlockSize, size_t DataNum, void *StreamDataPoint ) ;
	int						(*Eof)( void *StreamDataPoint ) ;
	int						(*IdleCheck)( void *StreamDataPoint ) ;
	int						(*Close)( void *StreamDataPoint ) ;
}
alias tagSTREAMDATASHRED STREAMDATASHRED;
alias tagSTREAMDATASHRED *LPSTREAMDATASHRED ;

// ストリームデータ制御用データ構造体
struct tagSTREAMDATA
{
	STREAMDATASHRED			ReadShred ;
	void					*DataPoint ;
}
alias tagSTREAMDATA STREAMDATA ;




//#ifndef DX_NOTUSE_DRAWFUNCTION

// メモリに置かれたデータをファイルとして扱うためのデータ構造体
struct tagMEMSTREAMDATA
{
	ubyte			*DataBuffer ;
	uint			DataSize ;
	int						DataPoint ;
	int						EOFFlag ;
}// MEMSTREAMDATA, *LPMEMSTREAMDATA ;

// パレット情報構造体
struct tagCOLORPALETTEDATA
{
	ubyte			Blue ;
	ubyte			Green ;
	ubyte			Red ;
	ubyte			Alpha ;
}
alias tagCOLORPALETTEDATA COLORPALETTEDATA ;

// カラー構造情報構造体
struct tagCOLORDATA
{
	ushort			ColorBitDepth ;									// ビット深度
	ushort			PixelByte ;										// １ピクセルあたりのバイト数
	ubyte			RedWidth, GreenWidth, BlueWidth, AlphaWidth ;	// 各色のビット幅
	ubyte			RedLoc	, GreenLoc  , BlueLoc  , AlphaLoc   ;	// 各色の配置されているビットアドレス
	uint			RedMask , GreenMask , BlueMask , AlphaMask  ;	// 各色のビットマスク
	uint			NoneMask ;										// 使われていないビットのマスク
	COLORPALETTEDATA		Palette[256] ;									// パレット(ビット深度が８以下の場合のみ有効)
	ubyte			NoneLoc, NoneWidth;								// 使われていないビットのアドレスと幅
}
alias tagCOLORDATA COLORDATA;
alias tagCOLORDATA *LPCOLORDATA ;

// 基本イメージデータ構造体
struct tagBASEIMAGE
{
	COLORDATA				ColorData ;							// 色情報
	int						Width, Height, Pitch ;				// 幅、高さ、ピッチ
	void					*GraphData ;						// グラフィックイメージ
}// BASEIMAGE, GRAPHIMAGE, *LPGRAPHIMAGE ;

// ラインデータ型
struct tagLINEDATA
{
	int						x1, y1, x2, y2 ;					// 座標
	int						color ;								// 色
	int						pal ;								// パラメータ
}
alias tagLINEDATA LINEDATA;
alias tagLINEDATA *LPLINEDATA ;

// 座標データ型
struct tagPOINTDATA
{
	int						x, y ;								// 座標
	int						color ;								// 色
	int						pal ;								// パラメータ
}
alias tagPOINTDATA POINTDATA;
alias tagPOINTDATA *LPPOINTDATA ;

// イメージフォーマットデータ
struct tagIMAGEFORMATDESC
{
	ubyte			TextureFlag ;					// テクスチャか、フラグ( TRUE:テクスチャ  FALSE:標準サーフェス )
	ubyte			AlphaChFlag ;					// αチャンネルはあるか、フラグ	( TRUE:ある  FALSE:ない )
	ubyte			DrawValidFlag ;					// 描画可能か、フラグ( TRUE:可能  FALSE:不可能 )
	ubyte			SystemMemFlag ;					// システムメモリ上に存在しているか、フラグ( TRUE:システムメモリ上  FALSE:ＶＲＡＭ上 )( 標準サーフェスの時のみ有効 )
	ubyte			NotManagedTextureFlag ;			// マネージドテクスチャを使用しないか、フラグ

	ubyte			AlphaTestFlag ;					// αテストチャンネルはあるか、フラグ( TRUE:ある  FALSE:ない )( テクスチャの場合のみ有効 )
	ubyte			ColorBitDepth ;					// 色深度( テクスチャの場合のみ有効 )
	ubyte			BlendGraphFlag ;				// ブレンド用画像か、フラグ
	ubyte			UsePaletteFlag ;				// パレットを使用しているか、フラグ( SystemMemFlag が TRUE の場合のみ有効 )
}
alias tagIMAGEFORMATDESC IMAGEFORMATDESC ;

//#endif // DX_NOTUSE_DRAWFUNCTION







// WinSockets使用時のアドレス指定用構造体
struct tagIPDATA
{
	union
	{
		struct
		{
			ubyte	d1, d2, d3, d4 ;				// アドレス値
		} ;
		uint		dall ;
	} ;
}// IPDATA, *LPIPDATA ;



//#define DX_STRUCT_END
