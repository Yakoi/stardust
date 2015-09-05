module dxlib.dxarchive;
import core.sys.windows.windows;
import dxlib.all;
static if(EXTERN_WINDOWS){
extern(Windows):
// DxArchive_.cpp 関数 プロトタイプ宣言
    int dx_DXArchivePreLoad( const char *FilePath , int ASync = FALSE ) ;    // 指定のＤＸＡファイルを丸ごとメモリに読み込む( 戻り値: -1=エラー  0=成功 )
    int dx_DXArchiveCheckIdle( const char *FilePath ) ;                    // 指定のＤＸＡファイルの事前読み込みが完了したかどうかを取得する( 戻り値： TRUE=完了した FALSE=まだ )
    int dx_DXArchiveRelease( const char *FilePath ) ;                        // 指定のＤＸＡファイルをメモリから解放する

    int dx_DXArchiveCheckFile( const char *FilePath, const char *TargetFilePath ) ;    // ＤＸＡファイルの中に指定のファイルが存在するかどうかを調べる、TargetFilePath はＤＸＡファイルをカレントフォルダとした場合のパス( 戻り値:  -1=エラー  0:無い  1:ある )
}else{
extern(C):
// DxArchive_.cpp 関数 プロトタイプ宣言
    int dx_DXArchivePreLoad( const char *FilePath , int ASync = FALSE ) ;    // 指定のＤＸＡファイルを丸ごとメモリに読み込む( 戻り値: -1=エラー  0=成功 )
    int dx_DXArchiveCheckIdle( const char *FilePath ) ;                    // 指定のＤＸＡファイルの事前読み込みが完了したかどうかを取得する( 戻り値： TRUE=完了した FALSE=まだ )
    int dx_DXArchiveRelease( const char *FilePath ) ;                        // 指定のＤＸＡファイルをメモリから解放する

    int dx_DXArchiveCheckFile( const char *FilePath, const char *TargetFilePath ) ;    // ＤＸＡファイルの中に指定のファイルが存在するかどうかを調べる、TargetFilePath はＤＸＡファイルをカレントフォルダとした場合のパス( 戻り値:  -1=エラー  0:無い  1:ある )
}
