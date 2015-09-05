// D import file generated from 'titlescene.d'
module titlescene;
import all;
import mylib.database;
import std.base64;
class TitleScene : Scene
{
    private 
{
    enum TitleMode 
{
LOGO,
TITLE,
TITLE_TO_GAME,
TITLE_TO_REPLAY,
TITLE_TO_SCORE,
TITLE_TO_END,
SCORE,
SCORE_TO_TITLE,
SCORE_TO_REPLAY,
}
    TitleMenu titleMenu;
    ScoreMenu scoreMenu;
    TitleMode mode = TitleMode.TITLE;
    const int BLEND_MAX = 32;

    int blendInt = 0;
    List!(StarParticle) starList;
    int drawingMusicTitleCount = 0;
    const int DRAWING_MUSIC_TITLE_COUNT_MAX = 100;

    const int DRAWING_MUSIC_TITLE_COUNT_FADE_TIME = 10;

    MusicData currentMusicData = null;
    public 
{
    this(State st);
    List!(StarParticle) createStarList(State st);
    override void draw(State st)
{
this.draw(st,cast(double)this.blendInt / this.BLEND_MAX);
}

    void draw(State st, in double blend);
    override Scene update(State st);

}
}
}
class Menu
{
    string[] texts;
    Vector pos;
    protected 
{
    Vector cursorPos;
    double cursorWidth = 20;
    int current;
    const int COUNT = 20;

    int count = 0;
    public 
{
    void succCurrent()
{
this.current = min(this.current + 1,cast(int)this.texts.length - 1);
this.count = COUNT;
}
    void decCurrent()
{
this.current = max(this.current - 1,0);
this.count = COUNT;
}
    void setCurrentTop()
{
this.current = 0;
this.count = COUNT;
}
    void setCurrentBottom()
{
this.current = this.texts.length - 1;
this.count = COUNT;
}
    @property string getCurrentText()
{
return this.texts[this.current];
}

}
}
}
class TitleMenu : Menu
{
    private 
{
    string caption;
    public 
{
    this(in Vector pos, in int num)
{
this.pos = pos;
this.current = 0;
this.texts.length = num;
}
    void update(State st)
{
Vector currentPos = pos + vecpos(0,current * 16 - 8 + 2);
double currentWidth = st.font.stringWidth(texts[current]) + 4;
cursorPos = move2(cursorPos,currentPos,count);
cursorWidth = move2(cursorWidth,currentWidth,count);
count -= 1;
}
    void draw(State st, in Color color, in double blend);
}
}
}
class ScoreMenu : Menu
{
    private 
{
    const Row[] rows;

    Chart chart;
    public 
{
    this(in Vector pos, in int num)
{
this.pos = pos;
this.current = 0;
this.texts.length = num;
ScoreDatabase scoreDatabase = new ScoreDatabase;
const string sql = "SELECT * FROM 'score' ORDER BY 'score' DESC;";
this.rows = scoreDatabase.query(sql);
this.chart = this.createChart();
}
    this(in Vector pos, in int num, in Row[] rows)
{
this.pos = pos;
this.current = 0;
this.texts.length = num;
this.chart = this.createChart();
this.rows = rows;
}
    private Chart createChart();

    void update(State st)
{
Vector currentPos = this.pos + this.chart.top_center + vecpos(0,current * 14 + 13);
double currentWidth = this.chart.width + 4;
cursorPos = move2(cursorPos,currentPos,count);
cursorWidth = move2(cursorWidth,currentWidth,count);
count -= 1;
}
    void draw(State st, in Color color, in double blend);
    int getMaxScore();
}
}
}
