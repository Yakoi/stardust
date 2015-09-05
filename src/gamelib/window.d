module gamelib.window;

import gamelib.all;
import dxlib.all;
import std.stdio;
import std.conv;
/// Window(描画部分じゃなくて枠とかボタンとかそういうの)を管理
class Window{
protected:
    //bool _fullScreen = true;
    bool _changeScreen = false;
    GameSystem _game;
package:
    void changeScreen(bool val){this._changeScreen = val;}
    this(GameSystem game){this._game = game;}
public:
    ////////////////////////////////////////////////////
    // ここから設定
    ////////////////////////////////////////////////////

    /// ウィンドウのアイコンを設定
    /// Param:
    ///     val = リソースのナンバー
    const void iconId(int val){
        SetWindowIconID(val);
    }
    /// ウィンドウキャプションに表示する文字列
    const void caption(string val){
        SetWindowText(toWStringz(val));
    }
    /// ウィンドウキャプションに表示する文字列
    const void caption(wstring val){
        SetWindowText(toWStringz(val));
    }
    /// フルスクリーンにするかどうか
    void fullScreen(bool val){
        if(val){
            if(this.fullScreen == false){this._changeScreen = true;}
            //this._fullScreen = true;
            if(!this._game.screen.checkDisplayMode()){
                throw new Exception("display ga taiou shiteimasen");
            }
            ChangeWindowMode(false);
            if(this._game.screen.emulation320x240 &&
                    this._game.screen.width == 320 &&
                    this._game.screen.height == 240)
            {
                this._game.screen.graphMode(this._game.screen.width*2, this._game.screen.height*2);
            }
            SetDrawScreen(DX_SCREEN_BACK);
        }else{
            if(this.fullScreen == true){this._changeScreen = true;}
            //this._fullScreen = false;
            ChangeWindowMode(true);
            if(this._game.screen.emulation320x240 &&
                    this._game.screen.width == 640 &&
                    this._game.screen.height == 480)
            {
                this._game.screen.graphMode(this._game.screen.width/2, this._game.screen.height/2);
            }
            SetDrawScreen(DX_SCREEN_BACK);
        }
    }
    /// フルスクリーンかどうか
    const bool fullScreen(){
        return 0!=GetChangeDisplayFlag() ;   // 画面モードが変更されているかどうかのフラグを取得する
        //return this._fullScreen ;  /// ウインドウモードで起動しているか、のフラグを取得する
    }
    /// ウィンドウの解像度が変化した瞬間だけtrueになる
    bool changeScreen(){
        if(this._changeScreen){
            this._changeScreen = false;
            return true;
        }else{
            return false;
        }
    }
    /// 描画画面のサイズに対するウインドウサイズの比率を設定する
    const void screenRate(double val)
    in{
        assert(val>0);
    }body{
        SetWindowSizeExtendRate(val) ;// 描画画面のサイズに対するウインドウサイズの比率を設定する
    }
    /// ウインドウの初期位置を設定する
    void position(int x, int y){
        SetWindowInitPosition(x , y) ;
    }
    ////////////////////////
    ////////////////////////
    ////// dxwin関係 ///////
    ////////////////////////
    ////////////////////////
    const double screenRate(){ 
        return GetWindowSizeExtendRate() ;/// 描画画面のサイズに対するウインドウサイズの比率を取得する
    }
    /// ファイルのドラッグ＆ドロップ機能を有効にするかどうかのフラグをセットする
    const void dragFileValid(bool val){
        SetDragFileValidFlag( val ) ;
    }
    /// ドラッグ＆ドロップされたファイルの情報を初期化する
    const void clearDragFileInfo(){
        DragFileInfoClear() ;
    }
    /// ドラッグ＆ドロップされたファイル名を取得する
    const wstring dragFilePath(){
        wchar[] buf;
        int b = GetDragFilePath( buf.ptr ) ; 
        switch(b){
            case -1:
                return null;
            case 0:
                return to!(wstring)(buf);
            default:
                assert(false);
        }
    }
    /// ドラッグ＆ドロップされたファイルの数を取得する
    const int dragFileNum(){
        return GetDragFileNum() ;
    }
    /// ウィンドウがアクティブかどうか
    const bool active(){
        return 0!=GetWindowActiveFlag() ;                                            /// ウインドウのアクティブフラグを取得
    }
    /// ALT+ENTERや、ウィンドウ右上の最大化ボタンの有効/無効を切り替える
    void changeWindowSizeButton(bool val){
        static extern(C) void func(void* window){
            auto w = cast(Window)window;
            w.changeScreen = true;
            w.fullScreen = true;
        }
        /// ALT+ENTERや、ウィンドウ右上の最大化ボタンの有効/無効を切り替える
        SetUseASyncChangeWindowModeFunction( val , &func, cast(void*)this);
    }
    int x(){
        int x,y;
        GetWindowPosition(&x,&y);
        return x;
    }
    void x(int val){
        SetWindowPosition(val,this.y);
    }
    int y(){
        int x,y;
        GetWindowPosition(&x,&y);
        return y;
    }
    void y(int val){
        SetWindowPosition(this.x, val);
    }
    IntVector pos(){
        int x,y;
        GetWindowPosition(&x,&y);
        return IntVector(x,y);
    }
    void pos(int x, int y){
        SetWindowPosition(x,y);
    }
    void pos(Vector val){
        this.pos(cast(int)val.x, cast(int)val.y);
    }
    void pos(IntVector val){
        this.pos(val.x, val.y);
    }

}
