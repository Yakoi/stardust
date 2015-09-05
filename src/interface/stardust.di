// D import file generated from 'stardust.d'
module stardust;
import all;
final class StardustMain : GameMain
{
    private 
{
    State st;
    public 
{
    this()
{
this.st = createState();
super(this.st.game);
}
    private 
{
    State createState()
{
State res = new State;
YamlNode systemYaml = loadYaml("system.yaml")[0];
YamlNode settingYaml = loadYaml("setting.yaml")[0];
GameInitData gid = createInitDataFromYaml(settingYaml["setting"]);
gid.fontPath = "./data/font/bdfShnmGothic.ttf";
gid.fontName = "BDF\xe6\x9d\xb1\xe9\x9b\xb2\xe3\x82\xb4\xe3\x82\xb7\xe3\x83\x83\xe3\x82\xaf";
gid.fontSize = 14;
gid.fontThickness = 1;
gid.fontType = FontType.NORMAL;
gid.emulation320x240 = true;
res.game = new GameSystem(gid);
res.fontTable = createFontDict(loadCsvAsTable(systemYaml["settingCsvFile"]["font"].s),systemYaml["directories"]["font"].s,FontType.NORMAL);
res.font = res.fontTable["shnm14"];
res.cd = new CollisionDetector;
res.ability1 = null;
res.ability1 = new TapAbility;
res.ability2 = new DashAbility;
res.systemRand = new Rand;
res.tt = new TransitionTable(res.game.screen);
res.st = createSoundDict(loadCsvAsTable(systemYaml["settingCsvFile"]["sound"].s),systemYaml["directories"]["sound"].s);
res.mt = createMusicTable(loadCsvAsTable(systemYaml["settingCsvFile"]["music"].s),systemYaml["directories"]["music"].s);
res.scene = new LogoScene(res.PROGRAM_NAME);
res.h = res.systemRand.i(0,3590);
res.game.mp.set(res.mt["music_a"].music);
res.te = new TextEffect;
saveYaml("setting",tableToYamlNode(loadCsvAsTable(systemYaml["settingCsvFile"]["font"].s)));
return res;
}
    protected 
{
    override void recreate()
{
this.st.font.remake();
}

    override void init()
{
st.scene = new LogoScene(st.TEAM_NAME);
}

    override GameResult update();

    override void draw()
{
this.st.scene.draw(this.st);
}

    override void finalize()
{
this.game.mp.stop();
}

}
}
}
}
}

int main(string[] args)
{
GameMain m = new StardustMain;
m.run();
return 0;
}
