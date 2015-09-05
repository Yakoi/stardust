// D import file generated from 'gameplayscene.d'
module gameplayscene;
import all;
class GamePlayScene : GameScene
{
    this(State st)
{
Controller ctr = new Controller(st.game.it);
super(st,ctr,new Rand);
this.mode = Mode.START;
}
    protected override void updatePlayByMode(State st);


    override Scene updateGameOver(State st);

    override void drawByMode(State st, in double blend)
{
}

}
