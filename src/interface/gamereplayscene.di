// D import file generated from 'gamereplayscene.d'
module gamereplayscene;
import all;
class GameReplayScene : GameScene
{
    int speed = 6;
    const int DEFAULT_SPEED = 6;

    static assert(DEFAULT_SPEED != 0);
        deprecated this(State st, ScoreData scoreData)
in
{
assert(st !is null);
assert(scoreData !is null);
}
body
{
Controller ctr = new InputPlayController(scoreData.ctrLog);
super(st,ctr,new Rand);
this.mode = Mode.START;
}

    this(State st, ControllerLogData ctrLog, int randseed)
in
{
assert(st !is null);
assert(ctrLog !is null);
}
body
{
Controller ctr = new InputPlayController(ctrLog);
super(st,ctr,new Rand(randseed));
this.mode = Mode.START;
}
    protected override void updatePlayByMode(State st);


    override Scene updateGameOver(State st);

    override void drawByMode(State st, in double blend)
in
{
assert(st !is null);
}
body
{
}

}
