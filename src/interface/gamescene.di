// D import file generated from 'gamescene.d'
module gamescene;
import all;
struct GameSceneState
{
    int level = 0;
    int score;
    int combo = 0;
    int maxCombo = 0;
    int tapNum = 0;
    int point;
    int goskyNum = 0;
    int boundNum = 0;
}
struct NextBallAppear
{
    Vector pos;
    int time;
    int num;
}
class GameScene : Scene
{
    protected 
{
    enum Mode 
{
START,
GAME,
GAMEOVER,
RESULT,
END,
}
    Mode mode = Mode.START;
    double masterBlend = 0;
    int startCount = 0;
    int gameCount = 0;
    int gameoverCount = 0;
    int resultCount = 0;
    int endCount = 0;
    int freezCount = 0;
    const int START_COUNT_MAX = 20;

    const int GAMEOVER_COUNT_MAX = 150;

    const int END_COUNT_MAX = 30;

    const int FREEZ_COUNT_MAX = 2;

    const int BALL_APPEAR_TIME = 50;

    const double BAR_SPEED = 1.5 * 2;

    GameSceneState gst;
    Controller ctr;
    Rand rand;
    Bar bar;
    List!(Ball) balls;
    List!(Particle) particles;
    List!(ShadowBar) bars;
    List!(StarParticle) starParticles;
    NextBallAppear nextBallAppear;
    int count;
    Field field;
    const int BALL_LIST_SIZE = 100;

    const int PARTICLE_LIST_SIZE = 1500;

    const(int) SHADOW_BAR_LIST_SIZE = 10;
    const Level[] levels;

    this(State st, Controller ctr, Rand rand)
{
this.field = new Field;
this.bar = new Bar;
this.balls = new FixedList!(Ball)(BALL_LIST_SIZE);
this.particles = new FixedList!(Particle)(PARTICLE_LIST_SIZE);
this.starParticles = new FixedList!(StarParticle)(PARTICLE_LIST_SIZE);
this.bars = new FixedList!(ShadowBar)(SHADOW_BAR_LIST_SIZE);
this.count = 0;
this.gst.point = 0;
this.nextBallAppear.pos = vecpos(st.game.screen.width / 2,40);
this.nextBallAppear.time = 0;
this.nextBallAppear.num = 1;
this.rand = rand;
this.ctr = ctr;
this.levels = loadLevels("data/level.csv");
this.masterBlend = 0;
}
    const pure const(Level) currentLevel()
in
{
assert(this.levels !is null);
}
out(res)
{
assert(res !is null);
}
body
{
return this.levels[this.gst.level];
}

    int tmp = 0;
    public final override void draw(State st)
{
this.drawCommon(st,min(1,this.masterBlend));
this.drawByMode(st,min(1,this.masterBlend));
}


    protected final void drawCommon(State st, in double blend);


    private void drawScore(State st, in double blend);

    protected abstract void drawByMode(State st, in double blend);


    public override Scene update(State st);


    protected abstract Scene updateGameOver(State st);


    protected abstract void updatePlayByMode(State st);


    protected void updatePlay(State st);

    void addBeforeAppearBallParticles(State st, List!(Particle) particles, Vector pos);
    void addAppearBallParticles(State st, List!(Particle) particles, Vector pos);
}
}
