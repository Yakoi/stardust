// D import file generated from 'logoscene.d'
module logoscene;
import all;
class LogoScene : Scene
{
    List!(Particle) particles;
    const int COUNT_MAX = 400;

    const int FADE_OUT_TIME = 100;

    const int TEXT_BEGIN_TIME = 20;

    const int TEXT_INTERVAL_TIME = 10;

    const wstring NAME;

    int count = 0;
    static assert(LogoScene.FADE_OUT_TIME * 2 <= LogoScene.COUNT_MAX);
    this(string name)
{
this.particles = new LinkedList!(Particle);
this.NAME = wtext(name);
}
    override Scene update(State st);

    override void draw(State st);

    private int charnum()
{
return min!(int)(this.NAME.length,max((this.count - this.TEXT_BEGIN_TIME) / this.TEXT_INTERVAL_TIME,0));
}

}
