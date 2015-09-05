module titlescene;
import all;
import mylib.database;
import std.base64;

/// タイトルを制御するクラス
class TitleScene : Scene{
private:
    ///タイトルのモード
    enum TitleMode{
        LOGO,               /// オープニングロゴ
        TITLE,              /// タイトルトップメニュー
        TITLE_TO_GAME,      /// タイトルからゲームへと移ろうとしているところ
        TITLE_TO_REPLAY,    /// タイトルからリプレイへと移ろうとしているところ
        TITLE_TO_SCORE,     /// タイトルからスコア画面へと移ろうとしているところ
        TITLE_TO_END,       /// タイトルから終了しようとしているところ
        SCORE,              /// スコア画面
        SCORE_TO_TITLE,     /// スコア画面からタイトルへ移ろうとしているところ
        SCORE_TO_REPLAY,    /// スコア画面からリプレイへ移ろうとしているところ
    }
    /// タイトルで表示するメニュー
    TitleMenu titleMenu;
    /// スコア画面で表示するメニュー
    ScoreMenu scoreMenu;
    /// 今のモード 最初はTITLE
    TitleMode mode = TitleMode.TITLE;
    /// 画面遷移の時のブレンドの時間
    const int BLEND_MAX = 32;
    /// 画面遷移の時のブレンド処理のための値
    int blendInt = 0;
    /// 背景に表示する星
    List!(StarParticle) starList;
    ///
    int drawingMusicTitleCount = 0;
    const int DRAWING_MUSIC_TITLE_COUNT_MAX = 200;
    const int DRAWING_MUSIC_TITLE_COUNT_FADE_TIME = 50;
    MusicData currentMusicData = null;
public:
    this(State st){
        this.titleMenu = new TitleMenu(vecpos(160,120),4);
        this.titleMenu.texts[0] = Terms.TitleMenu.START_GAMES;
        //this.titleMenu.texts[1] = "ハイスコアのリプレイを見る";
        this.titleMenu.texts[1] = Terms.TitleMenu.SEE_SCORE;
        this.titleMenu.texts[2] = Terms.TitleMenu.SELECT_MUSIC;
        this.titleMenu.texts[3] = Terms.TitleMenu.EXIT_GAMES;
        this.titleMenu.caption = st.PROGRAM_NAME_EN;
        this.scoreMenu = new ScoreMenu(vecpos(160,100),10);
        this.starList = this.createStarList(st);
        this.currentMusicData = st.mt["music_a"];
        if(st.game.mp.masterVolume == 0){
            st.game.mp.masterVolume=1.0;
            st.game.mp.stop();
            st.game.mp.play();
        }
    }
    List!(StarParticle) createStarList(State st)
    in{
        assert(st !is null);
        assert(st.systemRand !is null);
    }out(res){
        assert(res !is null);
    }body{
        auto res = new LinkedList!(StarParticle);
        st.starDataList = loadStarsData("stars.xml", st.encoder, st.hash);
        foreach(starData; st.starDataList){
            res.pushBack(starData.createStarParticle(st.systemRand));
        }
        return res;
    }
    /// 描画処理
    override void draw(State st){
        this.draw(st, cast(double)this.blendInt/this.BLEND_MAX);
    }
    /// 描画処理
    /// Params:
    ///     st = ゲーム全体の状態
    ///     blend = 画面フェードのためのパラメータ 1ですべて表示，0で表示しない
    void draw(State st, in double blend)
    in{
        assert(0.0 <= blend && blend <= 1.0);
    }body{
        Drawer drawer = st.systemDrawer;
        drawer.fill(hsv(st.h/10, 0.6, 0.15), BlendMode.ALPHA);
        foreach(s; this.starList){
            with(TitleMode)final switch(this.mode){
                case TITLE_TO_GAME, TITLE_TO_REPLAY, TITLE_TO_END, SCORE_TO_REPLAY:
                    s.draw(drawer, zerovec, (blend*0.5));
                    break;
                case TITLE, TITLE_TO_SCORE, SCORE_TO_TITLE, LOGO, SCORE:
                    s.draw(drawer, zerovec, (0.5));
                    break;
            }
        }
        drawer.fill(hsv(st.h/10, 0.6, 0.15), BlendMode.ALPHA, 127);
        final switch(this.mode){
        case TitleMode.LOGO:
            break;
        case TitleMode.TITLE:
        case TitleMode.TITLE_TO_GAME:
        case TitleMode.TITLE_TO_REPLAY:
        case TitleMode.TITLE_TO_SCORE:
        case TitleMode.TITLE_TO_END:
            //drawer.text_c(WHITE, vecpos(160,120)-vecpos(0,0), "push 'z' to start game", st.font);
            //drawer.text_c(WHITE, vecpos(160,120)+vecpos(0,16), "push 'x' to play replay", st.font);
            this.titleMenu.draw(st, WHITE, blend);

            /+
            drawer.text_r(WHITE, vecpos(320-8,0)+vecpos(0,16)*1,
                    format(Terms.TitleHeader.MAX_SCORE ~ " : %5d", this.scoreMenu.getMaxScore), st.font, BlendMode.ALPHA, cast(int)(blend*255));
            +/
            drawer.text_r(WHITE, vecpos(320-8,0)+vecpos(0,16)*1, 
                    format(Terms.TitleHeader.STARS_SUM ~ " : %3d", this.starList.length), st.font, BlendMode.ALPHA, cast(int)(blend*255));
            drawer.text_c(YELLOW, vecpos(320/4, 240-12),
                    Terms.TitleHelp.DecisionButton.NAME~" : "~Terms.TitleHelp.DecisionButton.DESCRIPTION,
                    st.font, BlendMode.ALPHA, cast(int)(blend*255));
            drawer.text_c(YELLOW, vecpos(320-320/4, 240-12),
                    Terms.TitleHelp.CancelButton.NAME~" : "~Terms.TitleHelp.CancelButton.DESCRIPTION,
                    st.font, BlendMode.ALPHA, cast(int)(blend*255));
            break;
        case TitleMode.SCORE:
        case TitleMode.SCORE_TO_TITLE:
        case TitleMode.SCORE_TO_REPLAY:
            this.scoreMenu.draw(st, WHITE, blend);
            if(this.scoreMenu.current < this.scoreMenu.rows.length){
                drawer.text_c(YELLOW, vecpos(320/4, 240-12), Terms.TitleHelp.DecisionButton.NAME~" : "~Terms.TitleHelp.Description.PLAY_REPLAY, st.font, BlendMode.ALPHA, cast(int)(blend*255));
            }else{
                drawer.text_c(GRAY, vecpos(320/4, 240-12), Terms.TitleHelp.DecisionButton.NAME~" : "~Terms.TitleHelp.Description.PLAY_REPLAY, st.font, BlendMode.ALPHA, cast(int)(blend*255));
            }
            drawer.text_c(YELLOW, vecpos(320-320/4, 240-12), Terms.TitleHelp.CancelButton.NAME~" : "~Terms.TitleHelp.Description.RETURN_TO_TITLE, st.font, BlendMode.ALPHA, cast(int)(blend*255));
            break;
        }
        //共通

        // 曲名表示
        debug //表示しないことにするよ
        if(drawingMusicTitleCount>0){
            int param;
            if(drawingMusicTitleCount < DRAWING_MUSIC_TITLE_COUNT_FADE_TIME){ //フェードイン
                param = 255*drawingMusicTitleCount/DRAWING_MUSIC_TITLE_COUNT_FADE_TIME;
            }else if(drawingMusicTitleCount < DRAWING_MUSIC_TITLE_COUNT_MAX - DRAWING_MUSIC_TITLE_COUNT_FADE_TIME){ //通常表示
                param = 255;
            }else if(drawingMusicTitleCount < DRAWING_MUSIC_TITLE_COUNT_MAX){ //フェードアウト
                param = 255*(DRAWING_MUSIC_TITLE_COUNT_MAX - drawingMusicTitleCount)/DRAWING_MUSIC_TITLE_COUNT_FADE_TIME;
            }else{
                assert(false);
            }
            Vector pos = vecpos(0,0) + vecpos(4,4);
            drawer.text_tl(WHITE, pos, this.currentMusicData.info, st.font, BlendMode.ALPHA, param); 
        }
        
    }
    /// 更新処理
    override Scene update(State st){
        final switch(this.mode){
        case TitleMode.LOGO:
            break;
        case TitleMode.TITLE:
            if(st.game.it.a.isDown){
                st.st["cursor"].play();
                switch(this.titleMenu.getCurrentText()){
                    case "音楽を選ぶ":
                        if(st.game.mp.music is st.mt["music_a"].music){
                            st.game.mp.play(st.mt["music_b"].music);
                            this.currentMusicData = st.mt["music_b"];
                            this.drawingMusicTitleCount = DRAWING_MUSIC_TITLE_COUNT_MAX;
                        }else{
                            st.game.mp.play(st.mt["music_a"].music);
                            this.currentMusicData = st.mt["music_a"];
                            this.drawingMusicTitleCount = DRAWING_MUSIC_TITLE_COUNT_MAX;
                        }
                        break;
                    case "ゲームを開始する":
                        this.mode = TitleMode.TITLE_TO_GAME;
                        break;
                    case "ハイスコアのリプレイを見る":
                        this.mode = TitleMode.TITLE_TO_REPLAY;
                        break;
                    case "スコアを見る":
                        this.mode = TitleMode.TITLE_TO_SCORE;
                        break;
                    case "ゲームを終了する":
                        this.mode = TitleMode.TITLE_TO_END;
                        break;
                    default:
                        break;
                }
            }
            if(st.game.it.b.isDown){ //下キー
                st.st["cursor"].play();
                this.titleMenu.setCurrentBottom();
            }
            if(st.game.it.down.isDown){ //下キー
                st.st["cursor"].play();
                this.titleMenu.succCurrent();
            }
            if(st.game.it.up.isDown){ //上キー
                st.st["cursor"].play();
                this.titleMenu.decCurrent();
            }
            this.blendInt = min(this.blendInt+1, cast(int)BLEND_MAX);
            break;
        case TitleMode.TITLE_TO_GAME:
            if(st.game.it.b.isDown){
                st.st["cursor"].play();
                this.mode = TitleMode.TITLE;
            }
            if(blendInt <= 0){
                return new GamePlayScene(st);
            }
            this.titleMenu.update(st);
            blendInt = max(blendInt-1, 0);
            break;
        case TitleMode.TITLE_TO_END:
            if(st.game.it.b.isDown){
                st.st["cursor"].play();
                this.mode = TitleMode.TITLE;
            }
            if(blendInt <= 0){
                return null;
            }
            this.titleMenu.update(st);
            blendInt = max(blendInt-1, 0);
            break;
        case TitleMode.TITLE_TO_REPLAY:
            if(st.game.it.b.isDown){
                st.st["cursor"].play();
                this.mode = TitleMode.TITLE;
            }
            this.titleMenu.update(st);
            blendInt = max(blendInt-1, 0);
            break;
        case TitleMode.TITLE_TO_SCORE:
            if(st.game.it.b.isDown){
                st.st["cursor"].play();
                this.mode = TitleMode.TITLE;
            }
            if(blendInt <= 0){
                this.mode = TitleMode.SCORE;
            }
            this.titleMenu.update(st);
            blendInt = max(blendInt-1, 0);
            break;
        case TitleMode.SCORE:
            this.scoreMenu.update(st);
            this.blendInt = min(this.blendInt+1, cast(int)BLEND_MAX);
            if(st.game.it.b.isDown){
                st.st["cursor"].play();
                this.mode = TitleMode.SCORE_TO_TITLE;
            } else if(st.game.it.a.isDown && scoreMenu.current < scoreMenu.rows.length/+Todo+/){
                st.st["cursor"].play();
                this.mode = TitleMode.SCORE_TO_REPLAY;
            }
            if(st.game.it.down.isDown){ //下キー
                st.st["cursor"].play();
                this.scoreMenu.succCurrent();
            }
            if(st.game.it.up.isDown){ //上キー
                st.st["cursor"].play();
                this.scoreMenu.decCurrent();
            }
            break;
        case TitleMode.SCORE_TO_TITLE:
            this.scoreMenu.update(st);
            if(blendInt <= 0){
                this.mode = TitleMode.TITLE;
            }
            blendInt = max(blendInt-1, 0);
            break;
        case TitleMode.SCORE_TO_REPLAY:
            this.scoreMenu.update(st);
            if(st.game.it.b.isDown){
                st.st["cursor"].play();
                this.mode = TitleMode.SCORE;
            }
            if(blendInt <= 0){
                auto row = scoreMenu.rows[scoreMenu.current];
                auto replayData1 = std.base64.Base64.decode(row["replay"]);
                auto replayData2 = decodeAndUnzipData(cast(ubyte[])replayData1, "simple");
                auto replayData3 = yamlToControllerLogData(replayData2);
                return new GameReplayScene(st, replayData3, to!(int)(row["randseed"]));
            }
            blendInt = max(blendInt-1, 0);
            break;
        }

        // 共通
        foreach(s; this.starList){
            s.update();
        }
        st.h += 1;  // 背景色をゆっくり変化させる

        this.drawingMusicTitleCount -= 1;

        this.titleMenu.update(st);
        return this;
    }
}


class Menu{
    string[] texts;
    Vector pos;
protected:
    Vector cursorPos;
    double cursorWidth = 20;
    int current;
    const int COUNT = 20;
    int count = 0;
public:
    void succCurrent(){
        this.current = min(this.current + 1, cast(int)this.texts.length-1);
        this.count = COUNT;
    }
    void decCurrent(){
        this.current = max(this.current - 1 , 0);
        this.count = COUNT;
    }
    void setCurrentTop(){
        this.current = 0;
        this.count = COUNT;
    }
    void setCurrentBottom(){
        this.current = this.texts.length-1;
        this.count = COUNT;
    }
    @property string getCurrentText(){
        return this.texts[this.current];
    }
}
class TitleMenu : Menu{
private:
    string caption;
public:
    this(in Vector pos, in int num){
        this.pos = pos;
        this.current = 0;
        this.texts.length = num;
    }
    void update(State st){
        Vector currentPos = pos + vecpos(0, current*16-8+2);
        double currentWidth = st.font.stringWidth(texts[current])+4;
        cursorPos = move2(cursorPos, currentPos, count);
        cursorWidth = move2(cursorWidth, currentWidth, count);

        count -= 1;
    }
    void draw(State st, in Color color, in double blend){
        Drawer drawer = st.systemDrawer;
        drawer.text_c(color, this.pos-vecpos(0,40), this.caption, st.font, BlendMode.ALPHA, cast(int)(255*blend));
        foreach(i,s; this.texts){
            drawer.text_c(color, pos+vecpos(0,0+16*i), s, st.font, BlendMode.ALPHA, cast(int)(255*blend));
        }
        drawer.box(WHITE, cast(int)(cursorPos.x - cursorWidth/2), cast(int)(cursorPos.y - 8 - 1), cast(int)(cursorPos.x + cursorWidth/2), cast(int)(cursorPos.y + 8 - 1),
                false, BlendMode.ALPHA, cast(int)(255*blend));
    }
}
class ScoreMenu : Menu{
private:
    const Row[] rows;
    Chart chart;
public:
    this(in Vector pos, in int num){
        this.pos = pos;
        this.current = 0;
        this.texts.length = num;
        ScoreDatabase scoreDatabase = new ScoreDatabase;
        const string sql = "SELECT * FROM 'score' ORDER BY 'star' DESC;";
        this.rows = scoreDatabase.query(sql);
        this.chart = this.createChart(); //描画用
    }
    this(in Vector pos, in int num, in Row[] rows){
        this.pos = pos;
        this.current = 0;
        this.texts.length = num;
        this.chart = this.createChart(); //描画用
        this.rows = rows;
    }
    /// 描画用データを作る
    private Chart createChart(){
        chart = new Chart(5, this.texts.length+1, 8, 6, 12) ;
        chart.setData(0,0,"");
        //chart.setData(1,0,"スコア");
        chart.setData(2,0," TIME ");
        chart.setData(1,0,"  ★  ");
        chart.setData(3,0," DATE ");
        foreach(uint num; 0..this.texts.length){
            if(num < this.rows.length){
                auto row = this.rows[num];
                try{
                chart.setData(0, num+1, format("%02d"     , num+1                 ));
                //chart.setData(1, num+1, format("%07d"     , to!(int)(row["score"] )));
                chart.setData(2, num+1, format("%02d:%02d", to!(int)(row["time"])/60, to!(int)(row["time"])%60));
                chart.setData(1, num+1, format("%04d"     , to!(int)(row["star"]  )));
                chart.setData(3, num+1, row["date"]);
                }catch(Throwable e){
                    writeln(e);
                    writeln(num);
                    writeln(row["score"]);
                    writeln(row["time"]);
                    writeln(row["star"]);
                    throw e;
                }
            }else{
                chart.setData(0, num+1, "--");
                //chart.setData(1, num+1, "-------");
                chart.setData(2, num+1, "-----");
                chart.setData(1, num+1, "----");
                chart.setData(3, num+1, "----------");
            }
        }
        chart.autoSetCellWidth();
        return chart;
    }

    void update(State st){
        Vector currentPos = this.pos + this.chart.top_center + vecpos(0, current*(14)+13);
        double currentWidth = this.chart.width+4;
        cursorPos = move2(cursorPos, currentPos, count);
        cursorWidth = move2(cursorWidth, currentWidth, count);

        count -= 1;
    }
    void draw(State st, in Color color, in double blend){
        Drawer drawer = st.systemDrawer;
        foreach(cell; this.chart){
            drawer.text_c(color, pos+cell.center, cell.data, st.font, BlendMode.ALPHA, cast(int)(255*blend));
        }
        drawer.box(WHITE, cast(int)(cursorPos.x - cursorWidth/2), cast(int)(cursorPos.y - 8), cast(int)(cursorPos.x + cursorWidth/2), cast(int)(cursorPos.y + 8),
                false, BlendMode.ALPHA, cast(int)(255*blend));
    }
    int getMaxScore(){
        if(this.chart.height <= 0){
            return 0;
        }else{
            try{
                return to!int(this.chart.getData(1,1));
            }catch(ConvException e){
                // スコア情報がないとき(-----が入っている)
                return 0;
            }catch(Throwable e){
                writeln(e);
                throw e;
            }
        }
    }
}
