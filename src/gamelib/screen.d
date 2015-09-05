module gamelib.screen;

import gamelib.all;
import dxlib.all;
import std.stdio;
import std.conv;

/// スクリーン
package class Screen : SurfaceBase, DrawableSurfaceInterface{
protected:
    GameSystem _game;
package:
    this(GameSystem game){
        this._game = game;
        super(false);
    }
    bool _emulation320x240 = false;
public:
    /// 裏画面の内容を表画面に反映
    void flip(){
        dx_ScreenFlip();
    }
    /// 垂直同期するか
    package
    const void waitVsync(bool val){
        dx_SetWaitVSyncFlag(val);
    }
    ////////////////////////////////////////////////////
    // ここから情報取得
    ////////////////////////////////////////////////////

    /// スクリーンの幅
    override const uint width()
    out(res){
        assert(res > 0);
    }body{
        int x,y;
        GetDrawScreenSize( &x, &y ) ;// 描画サイズを取得する
        if(this.emulation320x240 && this._game.window.fullScreen && x == 640 && y == 480){
            return x/2;
        }else{
            return x;
        }
    }
    /// スクリーンの高さ
    override const uint height()
    out(res){
        assert(res > 0);
    }body{
        int x,y;
        dx_GetDrawScreenSize( &x, &y ) ;// 描画サイズを取得する
        if(this.emulation320x240 && this._game.window.fullScreen && x == 640 && y == 480){
            return y/2;
        }else{
            return y;
        }
    }
    /// スクリーンの範囲
    override const Rect rect() {
        return mylib.rect.rect(0,0,this.width,this.height);
    }
    /// 使用色ビット数を返す
    const int bitDepth(){
        return dx_GetScreenBitDepth() ;// 使用色ビット数を返す
    }
    /// ＶＳＹＮＣ待ちをする設定になっているかどうかを取得する
    const bool waitVsync(){
        return 0!=dx_GetWaitVSyncFlag() ;// ＶＳＹＮＣ待ちをする設定になっているかどうかを取得する
    }
    /// 画面の色ビット深度を得る
    const int colorBitDepth(){
        return dx_GetColorBitDepth() ;               // 画面の色ビット深度を得る
    }
    /// 画面モードが変更されているかどうかのフラグを取得する
    //bool change_display(){
        //return 0!=dx_GetChangeDisplayFlag() ;        // 画面モードが変更されているかどうかのフラグを取得する
    //}
    ///ウィンドウモードのときのサイズ
    void graphMode(int width, int height, int depth=32, int n=60)
    in{
        assert(width>0);
        assert(height>0);
        assert(depth>0);
        assert(n>0);
    }body{
        dx_SetGraphMode( width, height, depth, n);
    }
    ///フルスクリーンでうまくいくように
    void emulation320x240(bool val){
        dx_SetEmulation320x240(val);
        this._emulation320x240 = val;
    }
    const pure bool emulation320x240(){
        return this._emulation320x240;
    }
    /// 現在描画対象になっている画面をBMP形式で保存する
    void saveToBmp(string path, Rect rect){
        dx_SaveDrawScreenToBMP(rect.left, rect.top, rect.right, rect.bottom,
                toWStringz(path)) ;
    }
    /// 現在描画対象になっている画面をＰＮＧ形式で保存する
    void saveToBmp(string path){
        this.saveToBmp(path, this.rect);
    }
    /// 現在描画対象になっている画面をＰＮＧ形式で保存する
    void saveToPng(string path, Rect rect, int compressionLevel = -1){
        dx_SaveDrawScreenToPNG(rect.left, rect.top, rect.right, rect.bottom,
                (toWStringz(path)), compressionLevel ) ;
    }
    /// 現在描画対象になっている画面をＰＮＧ形式で保存する
    void saveToPng(string path, int compressionLevel = -1){
        this.saveToPng(path, this.rect, compressionLevel);
    }
    /// 現在描画対象になっている画面をJPG形式で保存する
    void saveToJpg(string path, Rect rect, int quality = 80, bool sample2x1 = true){
        dx_SaveDrawScreenToJPEG(rect.left, rect.top, rect.right, rect.bottom,
                (toWStringz(path)), quality, sample2x1) ;
    }
    /// 現在描画対象になっている画面をJPG形式で保存する
    void saveToJpg(string path, int quality = 80, bool sample2x1 = true){
        this.saveToJpg(path, this.rect, quality, sample2x1);
    }
    /// 現在描画対象になっている画面をJPG形式で保存する
    alias saveToJpg saveToJpeg;
    /// 指定座標の色を取得する
    Color pixel(int x, int y){
        int dxcol = dx_GetPixel( x, y ) ;
        int r,g,b;
        dx_GetColor2( dxcol, &r, &g, &b) ; // 画面モードに対応した色データ値から個々の３原色データを抜き出す
        return col(r,g,b);
    }
    /// 指定座標の色を取得する
    Color pixel(IntVector pos){
        return pixel(pos.x, pos.y);
    }
    /// 指定座標の色を取得する
    Color pixel(Vector pos){
        return pixel(cast(int)pos.x, cast(int)pos.y);
    }
    /// 指定座標の色を取得する
    Color opIndex(int x, int y){
        return this.pixel(x,y);
    }
    const pure int left(){return 0;}
    const pure int top(){return 0;}
    const int right(){return this.width;}
    const int bottom(){return this.height;}
    const int cx(){return this.width /2;}
    const int cy(){return this.height /2;}

    ///
    bool checkDisplayMode(int width, int height){
        int dmnum = dx_GetDisplayModeNum( ) ;// 変更可能なディスプレイモードの数を取得する
        for(int i=0; i<dmnum; i++){
            DISPLAYMODEDATA dm = dx_GetDisplayMode(i) ; // 変更可能なディスプレイモードの情報を取得する( ModeIndex は 0 ～ GetDisplayModeNum の戻り値-1 )
            if(dm.Width == width && dm.Height == height){return true;}
        }
        return false;
    }
    ///
    bool checkDisplayMode(){
        int x,y;
        dx_GetDrawScreenSize( &x, &y ) ;// 描画サイズを取得する
        if(this.emulation320x240 && ((x == 640 && y == 480)||(x == 320 && y == 240))){
            return this.checkDisplayMode(640, 480);
        }else{
            return this.checkDisplayMode(x, y);
        }
    }
    ///
    void copyScreen(Rect rect, ref Surface dest){
        dx_GetDrawScreenGraph( rect.left, rect.top, rect.right, rect.bottom, dest.dxhandle, true) ;    // アクティブになっている画面から指定領域のグラフィックを取得する
    }
    ///
    void copyScreen(ref Surface dest){
        this.copyScreen(this.rect, dest);
    }
    override int dxhandle(){return DX_SCREEN_BACK;}
}
