module stardust;
import all;
/// メイン
final class StardustSystem : GameSystem{
    this(in GameInitData d){
        super(d);
    }
    override protected void doDownF4KeyEvent(){
        //do nothing
    }
}
final class StardustMain : GameMain{
private:
    State st;
public:
    this(){
        this.st = createState();
        super(this.st.game);
    }
private:
    /// state 作る
    State createState(){
        State res = new State;
        YamlNode systemYaml = loadYaml("system.yaml")[0]; //ロードする音楽データや、なんかいろいろの設定ファイル 変更されない
        YamlNode settingYaml = loadYaml("setting.yaml")[0]; //ウィンドウサイズや音量など。ユーザにより変更される。
        GameInitData gid = createInitDataFromYaml(settingYaml["setting"]);

        gid.fontPath = "./data/font/bdfShnmGothic.ttf";
        gid.fontName = "BDF東雲ゴシック";
        gid.fontSize = 14;
        gid.fontThickness = 1;
        gid.fontType = FontType.NORMAL;
        gid.emulation320x240 = true;
	gid.dxarchiveExtension = "yka";
	gid.dxarchiveKey = "devilsticks";        /// DXアーカイブのパスワード
        res.game        = new StardustSystem(gid);
        res.systemDrawer = res.game.systemDrawer;
        res.fontTable   = createFontDict(
                loadCsvAsTable(systemYaml["settingCsvFile"]["font"].s), 
                systemYaml["directories"]["font"].s, FontType.NORMAL);
        res.font        = res.fontTable["shnm14"];
        res.cd          = new CollisionDetector();
        //res.scoreData   = loadScoreData("score.yaml");
        res.ability1    = null;//AbilityType.BIG;
        res.ability1    = new TapAbility();//AbilityType.TAP;
        res.ability2    = new DashAbility();//AbilityType.DASH;
        res.systemRand  = new Rand();
        res.tt          = new TransitionTable(res.game.screen);
        //res.st          = createSoundTable();
        res.st          = createSoundDict(
                loadCsvAsTable(systemYaml["settingCsvFile"]["sound"].s),
                systemYaml["directories"]["sound"].s);
        //res.mt          = createMusicTable(systemYaml["materials"]["musics"]);
        res.mt          = createMusicTable(
                loadCsvAsTable(systemYaml["settingCsvFile"]["music"].s),
                systemYaml["directories"]["music"].s);
        res.scene       = new LogoScene(res.PROGRAM_NAME); // sceneは最後に初期化
        res.h           = res.systemRand.i(0,3590);

        res.game.mp.set(res.mt["music_a"].music);
        res.te = new TextEffect();
        saveYaml("setting", (tableToYamlNode(loadCsvAsTable(systemYaml["settingCsvFile"]["font"].s))));

        return res;
    }
protected:
    /// 画面サイズ変更時の画像のリロード
    override void recreate(){
        this.st.font.remake();
    }
    /// 初期化
    /// ゲーム開始時に一度呼ばれる
    override void init(){
        st.scene = new LogoScene(st.TEAM_NAME);
    }
    /// 毎フレーム呼ばれる更新処理
    override GameResult update(){
        static rad = PI/4;
        rad+=0.01;
        rad=0.0;
        //this.st.game.systemDrawer.dxlibDrawer.camera.scale = std.math.sin(rad)/2+1;
        //this.st.game.systemDrawer.dxlibDrawer.camera.dir = rad/9;
        //this.st.game.systemDrawer.dxlibDrawer.camera.roty = rad/7;
        //this.st.game.systemDrawer.dxlibDrawer.camera.rotx = rad/5;
        this.st.scene = this.st.scene.update(this.st); // メインの更新処理
        if(this.st.scene is null){
            return GameResult.EXIT;
        } else {
            return GameResult.CONTINUE;
        }
    }
    /// 毎フレーム呼ばれる描画処理
    override void draw(){
        this.st.scene.draw(this.st); // メインの更新処理
    }
    /// 終了処理
    /// ゲーム終了時に一度呼ばれる
    override void finalize(){
        this.game.mp.stop();
    }
}
/// main関数
int main(string[] args){
    /// GameMain関数が全部やってくれる！
    GameMain m = new StardustMain();
    m.run();
    return 0;

}
