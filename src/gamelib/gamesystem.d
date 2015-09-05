module gamelib.gamesystem;

import dxlib.all;
import std.string;
import std.conv;
import std.stdio;
import std.compiler;
import gamelib.all;
import std.file;
import std.path;
import yaml.all;
import mylib.yaml;

class GameSystem{
private:
    bool             _isInited            = false;
    Screen           _screen            = null;
    Window           _window            = null;
    SystemFont       _font              = null;
    DrawableSurface  _drawSurface       = null;
    Drawer           _systemDrawer      = null;
    Drawer[string]   _drawerHash        = null;
    DebugText        _debugText         = null;
    bool             _enableDebugText   = false;
    bool             _drawsFps         = false;
    DxlibMusicPlayer _musicPlayer       = null;
    InputTable       _inputTable        = null;
    Fps              _fps               = null;
    string           _ssDirectory       = "ss";
    bool             _errorMode         = false;
    string           _errorMessage      = "";
    bool             _returnTitle       = true;
    //void delegate()[Input] _systemKey;
    int _count = 0;
    bool _pausing;

    //int grayShade;
    int grayParamIndex;



public:
    this(in GameInitData d){
        this._window       = new Window(this);
        this._screen       = new Screen(this);
        this._font         = new SystemFont();
        this._musicPlayer = new DxlibMusicPlayer(1.0);
        init(d);
        //this._systemDrawer       = new Drawer(this.screen);
        this._drawSurface  = new DrawableSurface(d.screenWidth, d.screenHeight);
        this._systemDrawer       = new Drawer(this._drawSurface);
        this._inputTable = new InputTable;
        this._fps         = new Fps(d.fps);
        this._debugText  = new DebugText(this.screen.rect.cx, 
                this.screen.width-20, this.screen.height-10, 300, 15, this.font);
        this._ssDirectory = d.ssDirectory;
        dx_SetWindowSizeChangeEnableFlag(true);

        // ピクセルシェーダーバイナリコードの読み込み
        //grayShade = LoadPixelShader( "Sample2.pso" ) ;
        //grayParamIndex = GetConstIndexToShader( "param", grayShade ) ;
    }
    ~this(){
        this.end();
        assert(0==dx_DxLib_IsInit());
    }
    /// window
    @property const pure Window window()
    in{
    }out(res){
        assert(res !is null);
    }body{
        return cast(Window)this._window;
    }
    /// screen
    @property const pure Screen screen()out(res){assert(res !is null);}body{return cast(Screen)this._screen;}
    /// systemDrawer
    @property const pure Drawer systemDrawer()out(res){assert(res !is null);}body{return cast(Drawer)this._systemDrawer;}
    /// drawerHash
    @property pure Drawer[string] drawerHash(){return this._drawerHash;}
    /// system font
    @property const pure SystemFont font()out(res){assert(res !is null);}body{return cast(SystemFont)this._font;}
    /// music player
    @property const pure DxlibMusicPlayer musicPlayer()out(res){assert(res !is null);}body{return cast(DxlibMusicPlayer)this._musicPlayer;}
    /// draws Fps
    @property const pure bool drawsFps(){return this._drawsFps;}
    /// draws Fps
    @property void drawsFps(bool val){this._drawsFps = val;}
    /// music player
    alias musicPlayer mplayer;
    /// music player
    alias musicPlayer mp;
    /// input table
    @property const pure InputTable inputTable()out(res){assert(res !is null);}body{return cast(InputTable)this._inputTable;}
    /// input table
    alias inputTable itable;
    /// input table
    alias inputTable it;
    /// fps
    @property const pure Fps fps()out(res){assert(res !is null);}body{return cast(Fps)this._fps;}
    /// debug
    @property const pure DebugText debugText()out(res){assert(res !is null);}body{return cast(DebugText)this._debugText;}
    alias debugText dt;
    /// 内部カウンタ
    @property const pure int count(){return this._count;}
    /// 一時停止中かどうか
    @property const pure bool pausing(){return this._pausing;}
    /// 一時中止中かどうか
    @property void pausing(bool val){this._pausing = val;}
    ///
    @property const pure bool getReturnTitle(){return this._returnTitle;}
    ///
    @property void setReturnTitle(in bool val){this._returnTitle = val;}
    ///
    void returnTitle(){this._returnTitle = true;}
    /// 初期化
    void init(){
        if(!this._isInited){
            int a = 0;
            // dxlib初期化
            assert(0==dx_DxLib_IsInit());
            if (dx_DxLib_Init() == -1){throw new Exception("Dxlib init Error");}
            // 描画対象を裏画面に
            dx_SetDrawScreen(DX_SCREEN_BACK);
            this._isInited = true;
        }
    }
    /// 初期化2
    void init(in GameInitData d){
        this.preInit(d);
        dx_SetUseBlendGraphCreateFlag( true ) ;                            // ブレンド処理用画像を作成するかどうかのフラグをセットする
        init();
        this.postInit(d);
    }
    /// Dxlib の初期化前にする設定
    void preInit(in GameInitData d){
        if(d.iconId >= 0){
            this.window.iconId(d.iconId); //アイコン
        }
        this.window.caption = d.caption; //キャプション
        this.setScreen(d.screenWidth, d.screenHeight, d.fullScreen, d.screenSize, d.emulation320x240, d.fps);
        this.outputLog  = d.outputLog;     /// ログを出力するかどうか
        this.alwaysRun  = d.alwaysRun;     /// アクティブでない時も動作させるか
        this.use3d       = d.use3d;          /// 3D機能を使うか
        this.basicBlend = d.basicBlend;     /// Basic Blendを使うか
        this.window.changeWindowSizeButton = false; //最大化ボタンを有効にするか
        /// 垂直同期するか
        this.screen.waitVsync = d.waitVsync;
    }
    /// Dxlibの初期化後にする設定
    void postInit(in GameInitData d){
        /// 上の三つをまとめてする
        setDxarchive(d.dxarchiveExtension, d.dxarchiveKey);
        /// フォント関係を一気に設定
        setFont(d.fontName, d.fontPath, d.fontSize, d.fontThickness, d.fontType);
        /// グラフィック減色時の画像劣化緩和処理モードの変更
        shavedMode(d.shavedMode);
    }
    /// 後処理
    void end(){
        if(this._isInited){
            // 後始末
            dx_DxLib_End();
            this._isInited = false;
        }
    }
    /// dxlibのバージョン取得
    @property string dxlibVersion(){
        int dxlibVersion;
        dx__GetSystemInfo(&dxlibVersion, null, null);
        // 8進数を直す
        return format("%x.%03x", dxlibVersion/(16*16*16), dxlibVersion%(16*16*16));
    }
    /// DirectXのバージョン取得
    @property string directxVersion(){
        int directxVersion;
        dx__GetSystemInfo(null, &directxVersion, null);
        switch(directxVersion){
        case DX_DIRECTXVERSION_NON:
            return "0";
        case DX_DIRECTXVERSION_1:
            return "1";
        case DX_DIRECTXVERSION_2:
            return "2";
        case DX_DIRECTXVERSION_3:
            return "3";
        case DX_DIRECTXVERSION_4:
            return "4";
        case DX_DIRECTXVERSION_5:
            return "5";
        case DX_DIRECTXVERSION_6:
            return "6";
        case DX_DIRECTXVERSION_6_1:
            return "6.1";
        case DX_DIRECTXVERSION_7:
            return "7";
        case DX_DIRECTXVERSION_8:
            return "8";
        case DX_DIRECTXVERSION_8_1:
            return "8.1";
        default:
            assert(false);
        }
    }
    /// ユーザーのWindowsのバージョン取得
    @property string windowsVersion(){
        int windowsVersion;
        dx__GetSystemInfo(null, null, &windowsVersion);
        // ＷＩＮＤＯＷＳのバージョンマクロ
        switch(windowsVersion){
        case DX_WINDOWSVERSION_31:
            return "31";
        case DX_WINDOWSVERSION_95:
            return "95";
        case DX_WINDOWSVERSION_98:
            return "98";
        case DX_WINDOWSVERSION_ME:
            return "ME";
        case DX_WINDOWSVERSION_NT31:
            return "NT31";
        case DX_WINDOWSVERSION_NT40:
            return "NT40";
        case DX_WINDOWSVERSION_2000:
            return "2000";
        case DX_WINDOWSVERSION_XP:
            return "XP";
        case DX_WINDOWSVERSION_VISTA:
            return "VISTA";
        case DX_WINDOWSVERSION_NT_TYPE:
            return "NT TYPE";
        default:
            assert(false);
        }
    }
    /// libyaml.dllのバージョン取得
    @property string yamlVersion(){
        return text(yaml_get_version_string());
    }
    /// コンパイルしたD言語コンパイラのバージョン取得
    @property string dVersion(){
        return format("%d.%03d", version_major, version_minor);
    }
    bool errorProcess(){
        if(this.window.fullScreen){
            this.window.fullScreen = false;
        }
        /// draw
        this.systemDrawer.fill(BLACK, BlendMode.ALPHA, 128);
        this.systemDrawer.text_c(WHITE, vecpos(this.screen.width/2,this.screen.height/2-this.font.size), "sorry");
        this.systemDrawer.text_c(WHITE, vecpos(this.screen.width/2,this.screen.height/2), this._errorMessage);
        string compilerName = std.compiler.name ~" " ~ dVersion;
        string dxlibName      = "DXライブラリ " ~ this.dxlibVersion();
        string directxName    = "DirectX "      ~ this.directxVersion();
        string windowsName    = "Windows "      ~ this.windowsVersion();
        string libyamlVersion = "libyaml "      ~ this.yamlVersion();
        string camelliaName   = "camellia "     ~ "1.2.0";

        this.systemDrawer.text_br(WHITE, vecpos(this.screen.width-4, this.screen.height-this.font.size*5-4), camelliaName);
        this.systemDrawer.text_br(WHITE, vecpos(this.screen.width-4, this.screen.height-this.font.size*4-4), windowsName);
        this.systemDrawer.text_br(WHITE, vecpos(this.screen.width-4, this.screen.height-this.font.size*3-4), directxName);
        this.systemDrawer.text_br(WHITE, vecpos(this.screen.width-4, this.screen.height-this.font.size*2-4), libyamlVersion);
        this.systemDrawer.text_br(WHITE, vecpos(this.screen.width-4, this.screen.height-this.font.size*1-4), dxlibName);
        this.systemDrawer.text_br(WHITE, vecpos(this.screen.width-4, this.screen.height-this.font.size*0-4), compilerName);
        debug if(this._enableDebugText){
            this._debugText.draw(this.systemDrawer, vecpos(0,0), BlendMode.ALPHA, 192);
        }
        /// flip
        if(!this.fps.skip()){
            // 使用するテクスチャをセット
            //SetUseTextureToShader( 0, _drawSurface.dxhandle ) ;
            SetDrawScreen(DX_SCREEN_BACK);
            //SetUsePixelShader( grayShade ) ;
            //SetPSConstF( grayParamIndex, FLOAT4(0.0,0.0,0.0,0.0) ) ;    // ピクセルシェーダーの float 型定数を設定する
            SetDrawMode(DX_DRAWMODE_NEAREST);
            DrawPrimitive2DToShader( _drawSurface.vertShader.ptr, 6, DX_PRIMTYPE_TRIANGLELIST ) ;
            this.screen.flip();
        }

        /// update
        bool res1, res2 = true;
        this.fps.fpsWait();
        this.inputTable.update();
        debug{this.debugText.update();}
        this._count = this._count + 1;
        if(this.window.active){checkSystemKey();}
        //systemDrawer.clear();

        // 終了条件
        res1 = 0 == dx_ProcessMessage(); // システムの終了(バツボタンとか)
        res2 = !(this.it.escape.isDown && this.window.active);// アクティブなときにEscapeキーをおす
        return res1 && res2;
    }
    /// システムプロセス
    /// 面倒なことはここで自動でするよ
    bool process(){
        if(this.errorMode){
            return errorProcess();
        }
        /// draw
        if(this.pausing){
            this.systemDrawer.fill(BLACK, BlendMode.ALPHA, 128);
            this.systemDrawer.text_c(WHITE, vecpos(this.screen.width/2,this.screen.height/2), "PAUSE\n\nスペースキーを押すとゲームに戻ります");
            //デバッグモードの時は各種ライブラリ・システムのバージョンを表示する
            debug{
                //DMDコンパイラのバージョン取得
                string compilerName = std.compiler.name ~" " ~ dVersion;
                //DXライブラリのバージョン取得
                string dxlibName = "DXライブラリ " ~ this.dxlibVersion();
                //DirectXのバージョン取得
                string directxName = "DirectX " ~ this.directxVersion();
                //Windowsのバージョン取得
                string windowsName = "Windows " ~ this.windowsVersion();
                //Yamlのバージョン取得
                string libyamlVersion = "libyaml " ~ this.yamlVersion();
                //Camelliaのバージョン取得
                string camelliaName   = "camellia "     ~ "1.2.0";

                this.systemDrawer.text_br(WHITE, vecpos(this.screen.width-4, this.screen.height-this.font.size*5-4), camelliaName);
                this.systemDrawer.text_br(WHITE, vecpos(this.screen.width-4, this.screen.height-this.font.size*4-4), windowsName);
                this.systemDrawer.text_br(WHITE, vecpos(this.screen.width-4, this.screen.height-this.font.size*3-4), directxName);
                this.systemDrawer.text_br(WHITE, vecpos(this.screen.width-4, this.screen.height-this.font.size*2-4), libyamlVersion);
                this.systemDrawer.text_br(WHITE, vecpos(this.screen.width-4, this.screen.height-this.font.size*1-4), dxlibName);
                this.systemDrawer.text_br(WHITE, vecpos(this.screen.width-4, this.screen.height-this.font.size*0-4), compilerName);
            }
        }
        debug if(this._enableDebugText){
            this._debugText.draw(this.systemDrawer, vecpos(0,0), BlendMode.ALPHA, 192);
        }
        /// flip
        if(!this.fps.skip()){
            // 使用するテクスチャをセット
            //SetUseTextureToShader( 0, _drawSurface.dxhandle ) ; //Shader
            SetDrawScreen(DX_SCREEN_BACK);
            //SetUsePixelShader( grayShade ) ; //Shader
            //SetPSConstF( grayParamIndex, FLOAT4(0.0,0.0,0.0,0.0) ) ;    // ピクセルシェーダーの float 型定数を設定する //Shader
            SetDrawMode(DX_DRAWMODE_NEAREST); //モードはNEARESTじゃないとうまくいかないみたい
            //DrawPrimitive2DToShader( _drawSurface.vertShader.ptr, 6, DX_PRIMTYPE_TRIANGLELIST ) ; //Shader
            DrawPrimitive2D( _drawSurface.vert.ptr, 6, DX_PRIMTYPE_TRIANGLELIST, _drawSurface.dxhandle, false ) ;// ２Ｄプリミティブを描画する
            this.screen.flip();
        }

        /// update
        auto d = this.it.mpos.vel.dir;
        bool res1, res2 = true;
        this.fps.fpsWait();
        this.musicPlayer.update();
        this.inputTable.update();
        if(!this.pausing){
            debug{this.debugText.update();}
            this._count = this._count + 1;
        }
        // ウィンドウがアクティブじゃなくなったら自動的にpause画面に移る
        if(!this.window.active){
            assert(mp !is null);
            if(this.mp.isPlaying){
                this.mp.pause();
            }
            this.pausing = true;
        }
        if(this.window.active){checkSystemKey();}
        this.dt.addText(wtext(this.mp.volume));

        // 終了条件
        res1 = 0 == dx_ProcessMessage(); // システムの終了(バツボタンとか)
        res2 = !(this.it.escape.isDown && this.window.active);// アクティブなときにEscapeキーをおす
        return res1 && res2;
    }
    /// システムキー(function keyなど)をチェック
    private void checkSystemKey(){
        /// screen shot
        if(this.it.prtsc.isDown()){
            this.screenShot();
        }
        if(this.it.space.isDown){ // F1 : デバッグモードの切り替え
            this.doDownSpaceKeyEvent();
        }
        if(this.it.f1.isDown){ // F1 : デバッグモードの切り替え
            this.doDownF1KeyEvent();
        }
        if(this.it.f2.isDown()){ // F2 : 音楽を消す
            this.doDownF2KeyEvent();
        }
        if(this.it.f3.isDown()){ // F3
            this.doDownF3KeyEvent();
        }
        if(this.it.f4.isDown()){ // F4 : フルスクリーンの切り替え
            this.doDownF4KeyEvent();
        }
        if(this.it.f5.isDown){ // F5 : 画面のサイズを変更
            this.doDownF5KeyEvent();
        }
        if(this.it.f6.isDown()){ // F6 :画面のサイズを小さくする
            this.doDownF6KeyEvent();
        }
        if(this.it.f7.isDown()){ // F7 : 画面のサイズを大きくする
            this.doDownF7KeyEvent();
        }
        if(this.it.f8.isDown()){
            this.doDownF8KeyEvent();
        }
        if(this.it.f9.isDown()){
            this.doDownF9KeyEvent();
        }
        if(this.it.f11.isDown()){
            this.doDownF11KeyEvent();
        }
        if(this.it.f12.isDown()){ // F12 : タイトルに戻る
            this.doDownF12KeyEvent();
        }
    }
    protected void doDownSpaceKeyEvent(){
        if(this.window.active){
            this.pausing = !this.pausing;
            if(this.pausing){
                //core.memory.GC.collect();
                if(this.mp !is null){
                    this.mp.pause();
                    //this.mp.fade(0.1, 20);
                }
            }else{
                if(this.mp !is null){
                    this.mp.fade(1,20);
                }
            }
        }
    }
    ///デフォルトではデバッグ情報表示切替
    protected void doDownF1KeyEvent(){
        this._enableDebugText = !this._enableDebugText;
        this._drawsFps = !this._drawsFps;
    }
    ///デフォルトでは音楽の再生／非再生切り替え
    protected void doDownF2KeyEvent(){
        this.musicPlayer.mute = !this.musicPlayer.mute;
    }
    protected void doDownF3KeyEvent(){
        Sound.isEnable = !Sound.isEnable;
    }
    ///デフォルトではウィンドウモード／フルスクリーンモード切り替え
    protected void doDownF4KeyEvent(){
        this.pausing = true;
        this.mp.pause();
        this.window.fullScreen = !this.window.fullScreen;
    }
    protected void doDownF5KeyEvent(){
        changeScreenSize123();
    }
    protected void doDownF6KeyEvent(){
        this.window.screenRate = this.window.screenRate / 1.1;
    }
    protected void doDownF7KeyEvent(){
        this.window.screenRate = this.window.screenRate * 1.1;
    }
    protected void doDownF8KeyEvent(){
        this.mp.masterVolume = max(this.mp.masterVolume - 0.1, 0.0);
    }
    protected void doDownF9KeyEvent(){
        this.mp.masterVolume = min(this.mp.masterVolume + 0.1, 1.0);
    }
    protected void doDownF11KeyEvent(){
        // do nothing
    }
    protected void doDownF12KeyEvent(){
        this.returnTitle();
    }
    public final void changeMusicMute(){
        this.musicPlayer.mute = !this.musicPlayer.mute;
    }
    public final void changeScreenSize123(){
        switch( cast(int)(this._window.screenRate) ){
            case 1:
                this.window.screenRate = 2;
                break;
            case 2:
                this.window.screenRate = 3;
                break;
            case 3:
                this.window.screenRate = 1;
                break;
            default:
                this.window.screenRate = 1;
                break;
        }
    }
    final public void changeWindowMode(){
        this.pausing = true;
        this.mp.pause();
        this.window.fullScreen = !this.window.fullScreen;
    }
    ///
    final void happenError(string message){
        this.mp.stop();
        this._errorMode = true;
        this._errorMessage = message;
    }
    /// getter
    final bool errorMode(){
        return this._errorMode;
    }
    ///
    final void screenShot(){
        void save(string name, int num){
            string path;
            version(none){
                if(num == 0){
                    path = name~".png";
                }else{
                    path = text(name, "-", num, ".png");
                }
            }else{
                path = text(name, "-", format("%03d", num), ".png");
            }
            if(!exists(path)){
                this.screen.saveToPng(path, 5);
            }else{
                save(name, num+1);
            }
        }
        string name = this._ssDirectory ~ "/" ~ nowTimeStr();
        if(exists(this._ssDirectory)){
            if(!isDir(this._ssDirectory)){
                throw new Exception('"' ~ this._ssDirectory ~ '"' ~ "is not a directory");
            }
        }else{
            mkdir(this._ssDirectory);
        }
        save(name, 0);
    }
    ////////////////////////////////////////////////////
    // ここから設定
    ////////////////////////////////////////////////////


    /// ウィンドウの設定を一気にする
    /// Params:
    ///     width = 解像度の幅
    ///     height = 解像度の高さ
    ///     isFullScreen = フルスクリーンにするかどうか
    ///     emulate320x240 = フルスクリーンが上手くいかないときに設定するフラグ
    final void setScreen(int width, int height, bool isFullScreen, double screenRate, bool isEmulation320x240, int fps = 60){
        // ディスプレイが320x240に対応していない場合、自動でエミュレートする
        if((!this.screen.checkDisplayMode(width, height)) && width == 320 && height == 240){
            if(!isEmulation320x240){
                if(this.screen.checkDisplayMode(width*2, height*2)){
                    debug writeln("change emulation mode to 320x240");
                    isEmulation320x240 = true;
                    assert(false);
                }
            }
        }
        if(isEmulation320x240 && width == 320 && height == 240 && isFullScreen){
            this.screen.graphMode( width*2, height*2, 32, fps);
        }else{
            this.screen.graphMode( width, height, 32, fps);
        }
        this.window.fullScreen(isFullScreen);
        this.window.changeScreen = false;
        if(!isFullScreen){
            this.window.screenRate(screenRate) ;// 描画画面のサイズに対するウインドウサイズの比率を設定する
        }
        this.screen.emulation320x240(isEmulation320x240); //フルスクリーンでうまくいくように
    }
    /// ログを出力するか
    @property final const void outputLog(bool val){
        dx_SetOutApplicationLogValidFlag(val);
    }
    /// アクティブでない時も動作させるか
    @property final const void alwaysRun(bool val){
        dx_SetAlwaysRunFlag(val);
    }
    /// 3D機能を使うか
    @property final const void use3d(bool val){
        dx_SetUse3DFlag(val);
    }
    /// Basic Blendを使うか
    @property final const void basicBlend(bool val){
        dx_SetBasicBlendFlag(val);
    }
    /// Screen memでなくVramを使うか
    @property final const void useVram(bool val){
        dx_SetScreenMemToVramFlag(val);
    }


    ////////////////////////////////////////////////////
    // ここから初期化後の設定
    ////////////////////////////////////////////////////

    /// DXArchiveを有効にする
    @property final const void useDxArchive(bool val){
        dx_SetUseDXArchiveFlag(val);
    }
    /// DXArchiveのパスワードを指定
    @property final const void dxarchiveKey(string key){
        dx_SetDXArchiveKeyString(toWStringz(key));
    }
    /// DXArchiveのパスワードを指定
    @property final const void dxarchiveKey(wstring key){
        dx_SetDXArchiveKeyString(toWStringz(key));
    }
    /// DXArchiveの拡張子を指定
    @property final const void dxarchiveExtension(string val){
        dx_SetDXArchiveExtension(toWStringz(val));
    }
    /// DXArchiveの拡張子を指定
    @property final const void dxarchiveExtension(wstring val){
        dx_SetDXArchiveExtension(toWStringz(val));
    }
    /// 上の三つをまとめてする
    final const void setDxarchive(string extension, string key = null)
    in{
        assert(extension !is null);
    }body{
        this.useDxArchive(true);
        this.dxarchiveExtension(extension);
        if(key !is null){
            this.dxarchiveKey(key);
        }
    }
    /// フォント関係を一気に設定
    final void setFont(string name, string path, int size, int thickness = 1, int type = 1){
        if(path.length > 0){
            addFont(path);
        }
        this.font.path = name;
        this.font.size = size;
        this.font.thickness = thickness;
        this.font.type = type;
    }
    /// グラフィック減色時の画像劣化緩和処理モードの変更
    /// dx3d
    @property void shavedMode(int val){
        dx_SetGraphDataShavedMode( val ) ;// グラフィック減色時の画像劣化緩和処理モードの変更
    }
}




/// 一気に初期化するための構造体
/++
 + -------------------------
    GameInitData gid;
    with(gid){
        iconId             = -1;
        caption             = "caption";
        width               = 640;
        height              = 480;
        fullScreen          = true;
        screenSize         = 1;
        emulation320x240    = false;
        outputLog          = true;
        alwaysRun          = false;
        use3d               = true;
        basicBlend         = false;
        useVram            = true;
        dxarchiveExtension = "dxa";
        dxarchiveKey       = null;
        fontName           = null;
        fontSize           = 16;
        fontThickness      = 1;
        fontType           = 1;
        waitVsync          = true;
        shavedMode         = 1;
    }
 + --------------------------
+/
struct GameInitData{
    int iconId = -1;                   /// アイコンのリソースのナンバー
    string caption = "caption";         /// キャプション
    int screenWidth = 640;                    /// 解像度 幅
    int screenHeight = 480;                   /// 解像度 高さ
    bool fullScreen = true;             /// フルスクリーンにするかどうか
    double screenSize = 1.0;           /// スクリーンの拡大倍率
    bool emulation320x240 = false;      /// フルスクリーンが上手くいかないときに設定するフラグ
    bool outputLog = true;             /// ログを出力するかどうか
    bool alwaysRun = false;            /// アクティブでない時も動作させるか
    bool use3d = true;                  /// 3D機能を使うか
    bool basicBlend = false;           /// Basic Blendを使うか
    bool useVram = true;               /// VRamを使うかどうか

    string dxarchiveExtension = "dxa"; /// DXアーカイブの拡張子
    string dxarchiveKey = null;        /// DXアーカイブのパスワード
    string fontName = null;            /// システムフォントのパス
    string fontPath = null;            /// システムフォントのパス
    int fontSize = 16;                 /// システムフォントのサイズ
    int fontThickness = 1;             /// システムフォントの太さ
    int fontType = 1;                  /// システムフォントのタイプ
    bool waitVsync = true;             /// 垂直同期を有効にするかどうか
    int shavedMode = 1;                /// 描画方法の選択
    int fps = 60;                       /// flame par second
    string ssDirectory = "ss";/// スクリーンショットを保存するディレクトリ
}

GameInitData createInitDataFromYaml(YamlNode yn){
    T get(T)(string key, T dft){
        try{
            static if(is(T == int)){
                return (key in yn) ? yn[key].i : dft;
            }else static if(is(T == double)){
                return (key in yn) ? yn[key].r : dft;
            }else static if(is(T == string)){
                return (key in yn) ? yn[key].s : dft;
            }else static if(is(T == bool)){
                return (key in yn) ? yn[key].b : dft;
            }else{
                static assert(false);
            }
        }catch(Exception e){
            writeln(e.msg);
            return dft;
        }catch(Throwable o){
            writeln(o);
            return dft;
        }
    }

    GameInitData res;
    with(res){
        iconId              = get("iconId", -1);
        caption             = get("caption", "caption");
        screenWidth         = get("screenWidth"  , 640);
        screenHeight        = get("screenHeight" , 480);
        fullScreen          = get("fullScreen", true);
        screenSize          = get("screenSize", 1.0);
        emulation320x240    = get("emulation320x240", false);
        outputLog           = get("outputLog", true);
        alwaysRun           = get("alwaysRun", true);
        use3d               = get("use3d", true);
        basicBlend          = get("basicBlend", false);
        useVram             = get("useVram", true);
        fontName            = get!(string)("fontName", null);
        fontPath            = get!(string)("fontPath", null);
        fontSize            = get("fontSize", 12);
        fontThickness       = get("fontThickness", 1);
        fontType            = FontType.NORMAL;
    }

    return res;
}

