module gamereplayscene;

import all;

///
class GameReplayScene : GameScene{
    int speed = 6;
    const int DEFAULT_SPEED = 6;
    static assert(DEFAULT_SPEED != 0);
    ///
    invariant(){
        assert(speed > 0);
    }
	deprecated
    this(State st, ScoreData scoreData)
    in{
        assert(st !is null);
        assert(scoreData !is null);
    }body{
        Controller ctr = new InputPlayController(scoreData.ctrLog);
        super(st, ctr, new Rand());
        this.mode = Mode.START;
    }
    ///
    this(State st, ControllerLogData ctrLog, int randseed)
    in{
        assert(st !is null);
        assert(ctrLog !is null);
    }body{
        Controller ctr = new InputPlayController(ctrLog);
        super(st, ctr, new Rand(randseed));
        this.mode = Mode.START; 
    }
    protected override void updatePlayByMode(State st){
        if(this.freezCount > 0){
            this.freezCount -= 1;
            return;
        }
        if(st.game.it.a.isDown || st.game.it.b.isDown){
            this.mode = Mode.RESULT;
        }
        if(st.game.it.left.isDown){
            this.speed = max(this.speed-2, 2);
        }
        if(st.game.it.right.isDown){
            this.speed = min(this.speed+2, 50);
        }
        if(this.speed != this.DEFAULT_SPEED){
            //st.game.screen.wait_vsync = false;
        }
        assert(this.DEFAULT_SPEED != 0);
        st.game.fps.flamerate = 60*this.speed / this.DEFAULT_SPEED;
    }
    override Scene updateGameOver(State st)
    in{
        assert(st !is null);
    }out(res){
        assert(res !is null);
    }body{
        if(st.game.fps.flamerate != 60){
            st.game.fps.flamerate = 60;
        }
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
    override void updateResult(State st){
        if(st.game.it.a.isDown || true){
            this.mode = Mode.END;
        }
    }
    ///
    override void drawByMode(State st, in double blend)
    in{
        assert(st !is null);
    }body{
        // [ToDo: Write somethings]
    }
}
