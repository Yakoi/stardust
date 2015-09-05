
module gameplayscene;
import all;

///
class GamePlayScene : GameScene{
    ///
    this(State st){
        Controller ctr = new Controller(st.game.it);
        super(st, ctr, new Rand());
        this.mode = Mode.START; 
    }
    protected override void updatePlayByMode(State st){
        if(this.freezCount > 0){
            this.freezCount -= 1;
            return;
        }
        // [ToDo: Write somethings]
    }
    override Scene updateGameOver(State st){
        assert(st.game.fps.flamerate == 60);
        // フリーズエフェクト
        //st.tt.roll.draw(st.game.drawer, this.gameoverCount, this.gameoverCountMax, BLACK);
        if(this.gameoverCount == 0){
            foreach(b; this.balls){
                foreach(i; 0..20){
                    this.particles.pushBack(new WaveParticle(b.pos, st.systemRand));
                }
            }
            this.bar.visible = false;
            this.balls.clear();
            this.bars.clear();
        }
        foreach(particle; this.particles){
            if(!particle.enable){continue;}
            particle.update();
        }
        this.particles.leave((Particle b){return b.enable;});
        if(this.gameoverCount >= this.GAMEOVER_COUNT_MAX){
            this.mode = Mode.RESULT;
            //saveLog(st.replay_data);
            //st.replay_data = controllerToControllerLogData(ctr);
        }
        return this;
    }
    ///
    override void drawByMode(State st, in double blend){
        // [ToDo: Write somethings]
    
    }
    override void updateResult(State st){
        if(st.game.it.a.isDown || true){
            /+ScoreData newScore = new ScoreData(this.gst.point, "ore", this.rand.seed, controllerToControllerLogData(ctr), this.gst.boundNum, this.goskyNum);
            if(st.scoreData is null || st.scoreData.score < newScore.score){
                saveScoreData("score.yaml", newScore);
                st.scoreData = newScore;
            }
            +/

            // スコアのセーブ
            //データベースに追加する
            scope Score score = new Score(this.gst.point, this.gameCount/60, this.gst.goskyNum, nowDateStr(), st.VERSION, this.rand.seed, controllerToControllerLogData(this.ctr));
            ScoreDatabase db = new ScoreDatabase;
            db.insertScore(score);
            //StarDataのセーブ
            List!StarData sdl = new LinkedList!StarData;
            sdl.extend(st.starDataList);
            foreach(sp; this.starParticles){
                sdl.pushBack(new StarData(sp.pos, sp.color, sp.size, sp.brightMax));
            }
            stardata.saveStarData("stars.xml", st.encoder, st.hash, sdl);



            this.mode = Mode.END;
        }
    }
}
