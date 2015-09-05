// D import file generated from 'gamelib\gamesystem.d'
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
class GameSystem
{
    private 
{
    bool _isInited = false;
    Screen _screen = null;
    Window _window = null;
    SystemFont _font = null;
    Drawer _drawer = null;
    DebugText _debugText = null;
    bool _enableDebugText = false;
    bool _drawsFps = false;
    DxlibMusicPlayer _musicPlayer = null;
    InputTable _inputTable = null;
    Fps _fps = null;
    string _ssDirectory = "ss";
    bool _errorMode = false;
    string _errorMessage = "";
    bool _returnTitle = true;
    int _count = 0;
    bool _pausing;
    public 
{
    this(in GameInitData d)
{
this._window = new Window(this);
this._screen = new Screen(this);
this._font = new SystemFont;
this._drawer = new Drawer(this.screen);
this._musicPlayer = new DxlibMusicPlayer(1);
init(d);
this._inputTable = new InputTable;
this._fps = new Fps(d.fps);
this._debugText = new DebugText(this.screen.rect.cx,this.screen.width - 20,this.screen.height - 10,300,15,this.font);
this._ssDirectory = d.ssDirectory;
dx_SetWindowSizeChangeEnableFlag(true);
}
    ~this()
{
this.end();
assert(0 == dx_DxLib_IsInit());
}
    const pure @property Window window()
in
{
}
out(res)
{
assert(res !is null);
}
body
{
return cast(Window)this._window;
}

    const pure @property Screen screen()
out(res)
{
assert(res !is null);
}
body
{
return cast(Screen)this._screen;
}

    const pure @property Drawer drawer()
out(res)
{
assert(res !is null);
}
body
{
return cast(Drawer)this._drawer;
}

    const pure @property SystemFont font()
out(res)
{
assert(res !is null);
}
body
{
return cast(SystemFont)this._font;
}

    const pure @property DxlibMusicPlayer musicPlayer()
out(res)
{
assert(res !is null);
}
body
{
return cast(DxlibMusicPlayer)this._musicPlayer;
}

    const pure @property bool drawsFps()
{
return this._drawsFps;
}

    @property void drawsFps(bool val)
{
this._drawsFps = val;
}

    alias musicPlayer mplayer;
    alias musicPlayer mp;
    const pure @property InputTable inputTable()
out(res)
{
assert(res !is null);
}
body
{
return cast(InputTable)this._inputTable;
}

    alias inputTable itable;
    alias inputTable it;
    const pure @property Fps fps()
out(res)
{
assert(res !is null);
}
body
{
return cast(Fps)this._fps;
}

    const pure @property DebugText debugText()
out(res)
{
assert(res !is null);
}
body
{
return cast(DebugText)this._debugText;
}

    alias debugText dt;
    const pure @property int count()
{
return this._count;
}

    const pure @property bool pausing()
{
return this._pausing;
}

    @property void pausing(bool val)
{
this._pausing = val;
}

    const pure @property bool getReturnTitle()
{
return this._returnTitle;
}

    @property void setReturnTitle(in bool val)
{
this._returnTitle = val;
}

    void returnTitle()
{
this._returnTitle = true;
}
    void init();
    void init(in GameInitData d)
{
this.preInit(d);
dx_SetUseBlendGraphCreateFlag(true);
init();
this.postInit(d);
}
    void preInit(in GameInitData d);
    void postInit(in GameInitData d)
{
setDxarchive(d.dxarchiveExtension,d.dxarchiveKey);
setFont(d.fontName,d.fontPath,d.fontSize,d.fontThickness,d.fontType);
shavedMode(d.shavedMode);
}
    void end();
    @property string dxlibVersion()
{
int dxlibVersion;
dx__GetSystemInfo(&dxlibVersion,null,null);
return format("%x.%03x",dxlibVersion / (16 * 16 * 16),dxlibVersion % (16 * 16 * 16));
}

    @property string directxVersion();

    @property string windowsVersion();

    @property string yamlVersion()
{
return text(yaml_get_version_string());
}

    @property string dVersion()
{
return format("%d.%03d",version_major,version_minor);
}

    bool errorProcess();
    bool process();
    private void checkSystemKey();

    protected void doDownSpaceKeyEvent();

    protected void doDownF1KeyEvent()
{
this._enableDebugText = !this._enableDebugText;
this._drawsFps = !this._drawsFps;
}

    protected void doDownF2KeyEvent()
{
this.musicPlayer.mute = !this.musicPlayer.mute;
}

    protected void doDownF3KeyEvent()
{
}

    protected void doDownF4KeyEvent()
{
this.pausing = true;
this.mp.pause();
this.window.fullScreen = !this.window.fullScreen;
}

    protected void doDownF5KeyEvent()
{
changeScreenSize123();
}

    protected void doDownF6KeyEvent()
{
this.window.screenRate = this.window.screenRate / 1.1;
}

    protected void doDownF7KeyEvent()
{
this.window.screenRate = this.window.screenRate * 1.1;
}

    protected void doDownF8KeyEvent()
{
this.mp.masterVolume = max(this.mp.masterVolume - 0.1,0);
}

    protected void doDownF9KeyEvent()
{
this.mp.masterVolume = min(this.mp.masterVolume + 0.1,1);
}

    protected void doDownF11KeyEvent()
{
}

    protected void doDownF12KeyEvent()
{
this.returnTitle();
}

    public final void changeMusicMute()
{
this.musicPlayer.mute = !this.musicPlayer.mute;
}


    public final void changeScreenSize123();


    final public void changeWindowMode()
{
this.pausing = true;
this.mp.pause();
this.window.fullScreen = !this.window.fullScreen;
}


    final void happenError(string message)
{
this.mp.stop();
this._errorMode = true;
this._errorMessage = message;
}

    final bool errorMode()
{
return this._errorMode;
}

    final void screenShot();

    final void setScreen(int width, int height, bool isFullScreen, double screenRate, bool isEmulation320x240, int fps = 60);

    const final @property void outputLog(bool val)
{
dx_SetOutApplicationLogValidFlag(val);
}

    const final @property void alwaysRun(bool val)
{
dx_SetAlwaysRunFlag(val);
}

    const final @property void use3d(bool val)
{
dx_SetUse3DFlag(val);
}

    const final @property void basicBlend(bool val)
{
dx_SetBasicBlendFlag(val);
}

    const final @property void useVram(bool val)
{
dx_SetScreenMemToVramFlag(val);
}

    const final @property void useDxArchive(bool val)
{
dx_SetUseDXArchiveFlag(val);
}

    const final @property void dxarchiveKey(string key)
{
dx_SetDXArchiveKeyString(toWStringz(key));
}

    const final @property void dxarchiveKey(wstring key)
{
dx_SetDXArchiveKeyString(toWStringz(key));
}

    const final @property void dxarchiveExtension(string val)
{
dx_SetDXArchiveExtension(toWStringz(val));
}

    const final @property void dxarchiveExtension(wstring val)
{
dx_SetDXArchiveExtension(toWStringz(val));
}

    const final void setDxarchive(string extension, string key = null);

    final void setFont(string name, string path, int size, int thickness = 1, int type = 1);

    @property void shavedMode(int val)
{
dx_SetGraphDataShavedMode(val);
}

}
}
}
struct GameInitData
{
    int iconId = -1;
    string caption = "caption";
    int screenWidth = 640;
    int screenHeight = 480;
    bool fullScreen = true;
    double screenSize = 1;
    bool emulation320x240 = false;
    bool outputLog = true;
    bool alwaysRun = false;
    bool use3d = true;
    bool basicBlend = false;
    bool useVram = true;
    string dxarchiveExtension = "dxa";
    string dxarchiveKey = null;
    string fontName = null;
    string fontPath = null;
    int fontSize = 16;
    int fontThickness = 1;
    int fontType = 1;
    bool waitVsync = true;
    int shavedMode = 1;
    int fps = 60;
    string ssDirectory = "ss";
}
GameInitData createInitDataFromYaml(YamlNode yn);
