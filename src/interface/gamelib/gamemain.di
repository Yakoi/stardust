// D import file generated from 'gamelib\gamemain.d'
module gamelib.gamemain;
import gamelib.all;
enum GameResult 
{
CONTINUE,
EXIT,
ERROR,
RESET,
}
abstract class GameMain
{
    private 
{
    GameSystem _game;
    protected 
{
    this(GameSystem game)
{
this._game = game;
}
    const final pure @property GameSystem game()
{
return cast(GameSystem)this._game;
}

    abstract void init();

    abstract GameResult update();

    abstract void draw();

    abstract void recreate();

    abstract void finalize();

    public 
{
    final void run();

    private 
{
    final void runMain();

    final GameResult mainLoop();

}
}
}
}
}

