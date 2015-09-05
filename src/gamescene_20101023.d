module gamescene;
import all;

class GameScene : Scene{
    enum Mode{
        START,
        PLAYING,
        REPLAY,
        GAMEOVER,
        GAMEOVER_REPLAY,
        RESULT,
        RESULT_REPLAY,
        END,
    }
    int level = 0;
    int combo = 0;
    int maxCombo = 0;
    Mode mode = Mode.PLAYING;
    //ControllerLogData replay_data = null;
    int gameCount = 0;
    int gameoverCount = 0;
    int gameoverCountMax = 150;
    int endCount = 0;
    int endCountMax = 30;
    int speed = 6;
    int dashNum = 0;
    int tapNum = 0;
    int doubleDashNum = 0;
    const int defaultSpeed = 6;
    Controller ctr;
    Rand rand;
    Bar bar;
    List!(Ball) balls;
    List!(Particle) particles;
    List!(ShadowBar) bars;
    int nexttime = 0; //ボールが出現する間隔の誤差
    Vector nextballpos; //次のボールの出現位置
    int goskyNum = 0;
    int boundNum = 0;

    int count;
    int point;
    Field field;
    this(State st, ControllerLogData ctrLog, int randseed){
        this.field = new Field();
        //res.balls.pushBack(new Ball());
        this.bar  = new Bar();
        this.balls     = new FixedList!(Ball     )( 30);
        this.particles = new FixedList!(Particle )( 1500);
        this.bars      = new FixedList!(ShadowBar)( 10);
        this.count = 0;
        this.point = 0;
        this.nexttime = 0; //ボールが出現する間隔の誤差
        this.nextballpos = vecpos(160,40); //次のボールの出現位置
        this.mode = Mode.REPLAY;
        this.rand = new Rand(randseed);
        this.ctr = new InputPlayController(ctrLog);
    }
    this(State st, ScoreData scoreData = null){
        this.field = new Field();
        //res.balls.pushBack(new Ball());
        this.bar  = new Bar();
        this.balls     = new FixedList!(Ball     )( 30);
        this.particles = new FixedList!(Particle )( 1500);
        this.bars      = new FixedList!(ShadowBar)( 10);
        this.count = 0;
        this.point = 0;
        this.nexttime = 0; //ボールが出現する間隔の誤差
        this.nextballpos = vecpos(160,40); //次のボールの出現位置
        if(scoreData is null){
            this.mode = Mode.PLAYING;
            this.rand = new Rand();
            this.ctr = new Controller(st.game.it);
        }else{
            this.mode = Mode.REPLAY;
            this.rand = new Rand(scoreData.randseed);
            this.ctr = new InputPlayController(scoreData.ctrLog);
        }
    }
    int tmp = 0;
    override void draw(State st){
        //this.draw(st, sin(cast(double)tmp/199)/2+0.5);
        //tmp+= 1;
        this.draw(st, 1);
    }
    void draw(State st, double blend){
        Drawer drawer = st.game.drawer;
        drawer.fill(hsv(st.h/10, 0.6, 0.15)*blend, BlendMode.ALPHA);
        foreach(particle; this.particles){
            if(particle.enable){
                particle.draw(drawer, vecpos(0,0), blend);
            }
        }
        drawer.fill(hsv(st.h/10, 0.6, 0.15)*blend, BlendMode.ALPHA, 48-1);
        foreach(ball; this.balls){
            ball.draw(st, drawer, vecpos(0,0), blend);
        }
        // draw walls
        //drawer.rect(st.wallCol, this.field.rect, false, BlendMode.ALPHA, cast(int)(blend*255));
        foreach(bar; this.bars){
            if(bar.enable){
                bar.draw(drawer, vecpos(0,0), blend);
            }
        }
        if(this.bar.visible){
            this.bar.draw(drawer, vecpos(0,0), blend);
        }
        final switch(this.mode){
        case Mode.START:
            break;
        case Mode.PLAYING:
            break;
        case Mode.REPLAY:
            break;
        case Mode.GAMEOVER:
            //st.tt.mist.draw(drawer, this.gameoverCount, this.gameoverCountMax*2, BLACK);
            break;
        case Mode.GAMEOVER_REPLAY:
            st.tt.mist.draw(drawer, this.gameoverCount, this.gameoverCountMax*2, BLACK);
            break;
        case Mode.RESULT:
            drawer.fill(BLACK, BlendMode.MUL, 127);
            drawer.rect(BLACK, 40,40,240,160);
            drawer.rect(WHITE, 40,40,240,160);
            drawer.text_c(WHITE, vecpos(320/2, (40+st.font.size+2)+0*(st.font.size+1)),
                    format(Terms.Result.BOUND_NUM ~ " : %d", this.boundNum), st.font);
            drawer.text_c(WHITE, vecpos(320/2, (40+st.font.size+2)+1*(st.font.size+1)),
                    format(Terms.Result.STAR_NUM ~ " : %d", this.goskyNum), st.font);
            drawer.text_c(WHITE, vecpos(320/2, (40+st.font.size+2)+2*(st.font.size+1)),
                    format(Terms.Result.SCORE ~ " : %d", this.point), st.font);
            drawer.text_c(WHITE, vecpos(320/2, (40+st.font.size+2)+3*(st.font.size+1)),
                    format(Terms.Result.SCORE ~ " : %02d:%02d", this.gameCount/60/60, this.gameCount/60%60), st.font);
            if(st.scoreData is null || st.scoreData.score < this.point){
                drawer.text_c(RED, vecpos(320/2, (40+st.font.size+2)+5*(st.font.size+1)), format("新記録！！"), st.font);
            }
            break;
        case Mode.RESULT_REPLAY:
            break;
        case Mode.END:
            drawer.fill(BLACK, BlendMode.MUL, 127);
            drawer.rect(BLACK, 40,40,240,160);
            drawer.rect(WHITE, 40,40,240,160);
            drawer.text_c(WHITE, vecpos(320/2, 60), format("打ち上げた星の数 : %d", 10), st.font);
            st.tt.mist.draw(drawer, this.endCount, this.endCountMax*2, BLACK);
            break;
        }
        int size = st.font.size+1;
        int top  = 30;
        int left = 260+4;
        int right = 320-4;

        void dtext(int t, string text1, string text2){
            drawer.text_l(WHITE, vecpos(left, t), text1, st.font);
            drawer.text_r(WHITE, vecpos(right, t + size), text2, st.font);
            drawer.rect(WHITE, box(left, t+size*1.5, right, t+size*1.5+1));
        }

        /// スコア等の表示
        dtext( top + (size + 1)* 2 * 0, "SCORE", format("%4d" , this.point));
        dtext( top + (size + 1)* 2 * 1, "LEVEL", format("%2d" , this.level));
        dtext( top + (size + 1)* 2 * 2, "COMBO", format("%2d" , this.combo));
        dtext( top + (size + 1)* 2 * 3, "M COMBO", format("%2d" , this.maxCombo));
        dtext( top + (size + 1)* 2 * 4, "TIME",  count2time(this.gameCount, 60));
    }
    override Scene update(State st){
        ///入力
        final switch(this.mode){
        case Mode.PLAYING:
            this.updatePlay(st);
            this.gameCount ++;
            break;
        case Mode.GAMEOVER:
            assert(st.game.fps.flamerate == 60);
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
            if(this.gameoverCount >= this.gameoverCountMax){
                this.mode = Mode.RESULT;
                //saveLog(st.replay_data);
                //st.replay_data = controllerToControllerLogData(ctr);
            }
            this.gameoverCount ++;
            break;
        case Mode.GAMEOVER_REPLAY:
            this.gameoverCount ++;
            if(st.game.fps.flamerate != 60){
                st.game.fps.flamerate = 60;
            }
            //st.tt.roll.draw(st.game.drawer, this.gameoverCount, this.gameoverCountMax, BLACK);
            if(this.gameoverCount >= this.gameoverCountMax){
                //saveLog(st.replay_data);
                //st.replay_data = controllerToControllerLogData(ctr);
                ScoreData newScore = new ScoreData(this.point, "ore", this.rand.seed, controllerToControllerLogData(ctr), this.boundNum, this.goskyNum);
                st.scoreData = newScore;
                return new TitleScene(st);
            }
            break;
        case Mode.REPLAY:
            this.updatePlay(st);
            if(this.mode == Mode.GAMEOVER){
                this.mode = Mode.GAMEOVER_REPLAY;
            }
            if(st.game.it.left.isDown){
                this.speed = max(this.speed-2, 2);
            }
            if(st.game.it.right.isDown){
                this.speed = min(this.speed+2, 50);
            }
            if(this.speed != this.defaultSpeed){
                //st.game.screen.wait_vsync = false;
            }
            //st.game.screen.wait_vsync = false;
            st.game.fps.flamerate = 60*this.speed / this.defaultSpeed;
            this.gameCount ++;
            break;
        case Mode.START:
            assert(false);
        case Mode.RESULT:
            foreach(particle; this.particles){
                if(!particle.enable){continue;}
                particle.update();
            }
            this.particles.leave((Particle b){return b.enable;});
            if(st.game.it.a.isDown){
                /+ScoreData newScore = new ScoreData(this.point, "ore", this.rand.seed, controllerToControllerLogData(ctr), this.boundNum, this.goskyNum);
                if(st.scoreData is null || st.scoreData.score < newScore.score){
                    saveScoreData("score.yaml", newScore);
                    st.scoreData = newScore;
                }
                +/

                scope Score score = new Score(this.point, this.gameCount/60, this.goskyNum, nowDateStr(), 100, this.rand.seed, controllerToControllerLogData(ctr));
                ScoreDatabase db = new ScoreDatabase;
                db.insertScore(score);
                this.mode = Mode.END;

            }
            break;

        case Mode.RESULT_REPLAY:
            assert(false);
        case Mode.END:
            this.endCount ++;
            st.game.fps.flamerate = 60;
            if(this.endCount >= this.endCountMax){
                return new TitleScene(st);
            }
            break;
        }
        this.count++;
        return this;
    }
    void updatePlay(State st){
        bool big = false;
        bool dash = false;
        bool tap = false;
        st.h++;  //背景色のタメのパラメータ
        ctr.update();
        // アビリティの使用1
        final switch(st.ability1){
        case Ability.dash:
            if(ctr.attack.isDown){
                dash = true;
            }
            break;
        case Ability.big:
            if(ctr.attack.isPress){
                big = true;
            }
            break;
        case Ability.tap:
            if(ctr.attack.isDown){
                tap = true;
            }
            break;
        case Ability.slow:
            break;
        case Ability.mirror:
            break;
        case Ability.power:
            break;
        }
        // アビリティの使用2
        final switch(st.ability2){
        case Ability.dash:
            if(ctr.shoot.isDown){
                dash = true;
            }
            break;
        case Ability.big:
            if(ctr.shoot.isPress){
                big = true;
            }
            break;
        case Ability.tap:
            if(ctr.shoot.isDown){
                tap = true;
            }
            break;
        case Ability.slow:
            break;
        case Ability.mirror:
            break;
        case Ability.power:
            break;
        }
        const double barSpeed = 1.5*2;
        with(Horizon3)final switch(ctr.horizon3){
        case L:
            if(dash /+&& this.point >= 20+/){
                this.bars.pushBack(new ShadowBar(this.bar.pos, 20, this.bar.isBig));
                this.bar.x = this.bar.x - this.bar.area.width;
                //this.point -=  20;
                this.doubleDashNum += 1;
            }else{
                this.bar.x = this.bar.x - barSpeed;
            }
            break;
        case R:
            if(dash /+&& this.point >= 20+/){
                this.bars.pushBack(new ShadowBar(this.bar.pos, 20, this.bar.isBig));
                this.bar.x = this.bar.x + this.bar.area.width;
                //this.point -=  20;
                this.doubleDashNum += 1;
            }else{
                this.bar.x = this.bar.x + barSpeed;
            }
            break;
        case C:
            break;
        }
        //壁グラフィック処理
        foreach(poss; [
                [vecpos(this.field.rect.left,  this.field.rect.top),    vecpos(this.field.rect.right, this.field.rect.top)],
                [vecpos(this.field.rect.right, this.field.rect.top),    vecpos(this.field.rect.right, this.field.rect.bottom)],
                [vecpos(this.field.rect.right, this.field.rect.bottom), vecpos(this.field.rect.left, this.field.rect.bottom)],
                [vecpos(this.field.rect.left,  this.field.rect.bottom), vecpos(this.field.rect.left, this.field.rect.top)]
                ]){
            if(st.systemRand.randb(0.1)){
                auto wall = new ThunderLineParticle(poss[0], poss[1], st.systemRand);
                this.particles.pushBack(wall);
            }
        }

        //左限界
        if(this.bar.area.left+this.bar.x < this.field.rect.left - this.bar.area.width/2){
            this.bar.x = this.field.rect.left + this.bar.area.width/2 - this.bar.area.width/2;
        }
        //右限界
        if(this.bar.area.right+this.bar.x > this.field.rect.right + this.bar.area.width/2){
            this.bar.x = this.field.rect.right - this.bar.area.width/2 + this.bar.area.width/2;
        }
        if((this.count-50+50) == this.nexttime){
            st.st["appear_ball"].play();
            foreach(i; 0..10){
                this.particles.pushBack(new InWaveParticle(nextballpos, st.systemRand));
            }
            foreach(i; 0..30){
                this.particles.pushBack(new InLineParticle(nextballpos, st.systemRand));
            }
            foreach(i; 0..20){
                this.particles.pushBack(new InCircleParticle(nextballpos, st.systemRand));
            }
        }
        if((this.count-50) == this.nexttime){
            this.balls.pushBack(new Ball(nextballpos));
            foreach(i; 0..20){
                this.particles.pushBack(new WaveParticle(    nextballpos, st.systemRand));
            }
            foreach(i; 0..60){
                this.particles.pushBack(new TriangleParticle(nextballpos, st.systemRand));
            }
            int levelCount = 400 - (this.level % 5) * 20 - (this.level / 5) * 2;
            this.nexttime = this.nexttime  + rand.i(-this.level,this.level) + levelCount;// + this.rand.i(-50,100);
            this.nextballpos = vecpos(160+this.rand.i(-60,60), 40+this.rand.i(0,20));
        }
        if(big && this.point > 0){
            this.point -= 1;
            this.bar.isBig = true;
        }else{
            this.bar.isBig = false;
        }
        this.level = this.gameCount / (60*30); //レベルアップ
            
        if(tap && this.point >= 30){  // アビリティ タップ
            foreach(ball; this.balls){
                if(!ball.enable){continue;}
                if(st.cd.detect(ball.area, this.bar.tapArea, ball.pos, this.bar.pos - vecpos(0, this.bar.tapArea.height/2))){
                    if(ball.vel.y >0){
                        ball.vel = vecpos(ball.vel.x, -ball.vel.y);
                    }
                }
            }
            this.point -=30;
        }

        if(this.doubleDashNum >= 2){
            this.combo = 0;
        }
        if(this.maxCombo < this.combo){
            this.maxCombo = this.combo;
        }

        ///update
        foreach(bar; this.bars){
            if(bar.enable){
                bar.update();
            }
        }
        foreach(particle; this.particles){
            if(!particle.enable){continue;}
            particle.update();
        }
        foreach(ball; this.balls){
            if(!ball.enable){continue;}
            ball.update();
            double reflectVelocity = 2.5 - this.rand.r(0,0.2);
            double finishVelocity  = 2.5*2;
            int finishCount = 10;



            ///////////////// ボールとバーの当たり判定 ////////////////////////////
            if(big && this.point > 0){ 
                if(st.cd.detect(ball.area, this.bar.bigArea, ball.pos, this.bar.pos)){    // ボールと大きなバーとの当たり判定
                    st.st["reflect_bar"].play();
                    this.boundNum += 1;
                    this.combo += 1;
                    this.doubleDashNum = 0;
                    if(ball.boundCount < finishCount){
                        ball.vel = vecpos(ball.vel.x+this.rand.randf(-0.1,0.1), -reflectVelocity);
                        foreach(i; 0..100){
                            particles.pushBack(new CircleParticle(ball.pos, st.systemRand));
                        }
                    }else{
                        ball.vel = vecpos(ball.vel.x+this.rand.randf(-0.1,0.1), -finishVelocity);
                        foreach(i; 0..500){
                            particles.pushBack(new CircleParticle(ball.pos, st.systemRand));
                        }
                        ball.gosky = true;
                    }
                    ball.pos = vecpos(ball.pos.x, this.bar.pos.y + this.bar.area.top - ball.area.height/2);
                    this.point += 10+this.combo/10;
                    ball.boundCount ++;
                    foreach(i; 0..10){
                        this.particles.pushBack(new WaveParticle(ball.pos, st.systemRand));
                    }

                }
            }else{
                if(st.cd.detect(ball, this.bar)){
                    st.st["reflect_bar"].play();
                    this.boundNum += 1;
                    this.combo += 1;
                    this.doubleDashNum = 0;
                    if(ball.boundCount < finishCount){
                        ball.vel = vecpos(ball.vel.x+this.rand.randf(-0.1,0.1), -reflectVelocity);
                        foreach(i; 0..100){
                            particles.pushBack(new CircleParticle(ball.pos, st.systemRand));
                        }
                    }else{
                        ball.vel = vecpos(ball.vel.x+this.rand.randf(-0.1,0.1), -finishVelocity);
                        foreach(i; 0..500){
                            particles.pushBack(new CircleParticle(ball.pos, st.systemRand));
                        }
                        ball.gosky = true;
                    }
                    ball.pos = vecpos(ball.pos.x, this.bar.pos.y + this.bar.area.top - ball.area.height/2);
                    this.point += 10+this.combo/10;
                    ball.boundCount ++;
                    foreach(i; 0..10){
                        this.particles.pushBack(new WaveParticle(ball.pos, st.systemRand));
                    }

                }
            }
            ///////////////// ボールとシャドウバーの当たり判定 ////////////////////////////
            foreach(bar; this.bars){
                if(big && this.point > 0){ 
                    if(st.cd.detect(ball.area, bar.bigArea, ball.pos, bar.pos)){    // ボールと大きなバーとの当たり判定
                        st.st["reflect_bar"].play();
                        this.boundNum += 1;
                        this.combo += 1;
                        this.doubleDashNum = 0;
                        if(ball.boundCount < finishCount){
                            ball.vel = vecpos(ball.vel.x+this.rand.randf(-0.1,0.1), -reflectVelocity);
                            foreach(i; 0..100){
                                particles.pushBack(new CircleParticle(ball.pos, st.systemRand));
                            }
                        }else{
                            ball.vel = vecpos(ball.vel.x+this.rand.randf(-0.1,0.1), -finishVelocity);
                            foreach(i; 0..500){
                                particles.pushBack(new CircleParticle(ball.pos, st.systemRand));
                            }
                            ball.gosky = true;
                        }
                        ball.pos = vecpos(ball.pos.x, bar.pos.y + bar.area.top - ball.area.height/2);
                        this.point += 10+this.combo/10;
                        ball.boundCount ++;
                        foreach(i; 0..10){
                            this.particles.pushBack(new WaveParticle(ball.pos, st.systemRand));
                        }

                    }
                }else{
                    if(st.cd.detect(ball, bar)){
                        st.st["reflect_bar"].play();
                        this.boundNum += 1;
                        this.combo += 1;
                        this.doubleDashNum = 0;
                        if(ball.boundCount < finishCount){
                            ball.vel = vecpos(ball.vel.x+this.rand.randf(-0.1,0.1), -reflectVelocity);
                            foreach(i; 0..50){
                                particles.pushBack(new CircleParticle(ball.pos, st.systemRand));
                            }
                        }else{
                            ball.vel = vecpos(ball.vel.x+this.rand.randf(-0.1,0.1), -finishVelocity);
                            foreach(i; 0..200){
                                particles.pushBack(new CircleParticle(ball.pos, st.systemRand));
                            }
                            ball.gosky = true;
                        }
                        ball.pos = vecpos(ball.pos.x, bar.pos.y + bar.area.top - ball.area.height/2);
                        this.point += 10+this.combo/10;
                        ball.boundCount ++;
                        foreach(i; 0..10){
                            this.particles.pushBack(new WaveParticle(ball.pos, st.systemRand));
                        }

                    }
                }
            }




            if(st.cd.detect(ball.area, this.field.leftwall, ball.pos, vecpos(0,0))){ //ボールと左の壁との当たり判定
                ball.vel = vecpos(-ball.vel.x, ball.vel.y);
                st.st["reflect_wall"].play();
                foreach(i; 0..10){
                    this.particles.pushBack(new WaveParticle(ball.pos, st.systemRand));
                }
            }
            if(st.cd.detect(ball.area, this.field.rightwall, ball.pos, vecpos(0,0))){ //ボールと右の壁との当たり判定
                ball.vel = vecpos(-ball.vel.x, ball.vel.y);
                st.st["reflect_wall"].play();
                foreach(i; 0..10){
                    this.particles.pushBack(new WaveParticle(ball.pos, st.systemRand));
                }
            }
            if(st.cd.detect(ball.area, this.field.bottomwall, ball.pos, vecpos(0,0))){ //ボールと下の壁との当たり判定
                this.mode =  Mode.GAMEOVER;
                st.st["gameover"].play();
            }
            if(st.cd.detect(ball.area, this.field.topwall, ball.pos, vecpos(0,0))){ //ボールと上の壁との当たり判定
                ball.enable = false;
                st.st["gosky"].play();
                foreach(i; 0..100){
                    particles.pushBack(new TriangleParticle(ball.pos, st.systemRand));
                }
                foreach(i; 0..2){
                    this.particles.pushBack(new WaveFillParticle(ball.pos+st.systemRand.v(40), st.systemRand));
                }
                this.point += this.combo * 10;
                this.goskyNum += 1;
            }
            if(!ball.gosky){
                if(ball.boundCount>=10){
                    if(st.systemRand.b(0.1)){
                        foreach(i; 0..10){
                            this.particles.pushBack(new WaveParticle(ball.pos, st.systemRand));
                        }
                    }
                }
            }else{
                foreach(i; 0..4){
                    this.particles.pushBack(new FixedCircleParticle(ball.pos+st.systemRand.v(8), st.systemRand));
                }
                if(ball.count % 12 == 0){ // 空に向かうボールが放つエフェクト
                    st.st["finish_effect"].play();
                    this.particles.pushBack(new WaveFillParticle(ball.pos, st.systemRand));
                }
            }
        }
        this.bars.leave((ShadowBar b){return b.enable;});
        this.balls.leave((Ball b){return b.enable;});
        this.particles.leave((Particle b){return b.enable;});
    }
}
