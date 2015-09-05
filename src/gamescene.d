module gamescene;
import all;


struct GameSceneState{
    int level = 0;
    int score;
    int combo = 0;
    int maxCombo = 0;
    int tapNum = 0;
    int point;
    int goskyNum = 0;
    int boundNum = 0;
}
struct NextBallAppear{
    Vector pos;
    int time;
    int num;
}
/// ゲームプレイとリプレイの共通部分
class GameScene : Scene{

protected:
    enum Mode{
        START,
        GAME,
        GAMEOVER,
        RESULT,
        END,
    }
    Mode mode = Mode.START;
    //ControllerLogData replay_data = null;

    double masterBlend = 0;

    // 各モードのカウント
    int startCount    = 0;
    int gameCount     = 0;
    int gameoverCount = 0;
    int resultCount   = 0;
    int endCount      = 0;
    int freezCount    = 0;

    // 各モードのカウントの最大値
    const int START_COUNT_MAX = 20;
    const int GAMEOVER_COUNT_MAX = 150;
    const int END_COUNT_MAX = 30;
    const int FREEZ_COUNT_MAX    = 2;

    const int BALL_APPEAR_TIME = 50;
    // バーのスピード
    const double BAR_SPEED = 1.5*2;
    GameSceneState gst;
    // コントローラ
    Controller ctr;
    // 乱数
    Rand rand;
    // オブジェクト
    Bar bar;
    List!Ball balls;
    List!Particle particles;
    List!ShadowBar bars;
    List!StarParticle starParticles;
    
    NextBallAppear nextBallAppear;

    int count;
    Field field;

    // 各リストのサイズ
    const int BALL_LIST_SIZE = 100;
    const int PARTICLE_LIST_SIZE = 1500;
    const(int) SHADOW_BAR_LIST_SIZE = 10;
    const Level[] levels;
    this(State st, Controller ctr, Rand rand){
        this.field = new Field();
        //res.balls.pushBack(new Ball());
        this.bar  = new Bar();
        this.balls     = new FixedList!(Ball     )( BALL_LIST_SIZE);
        this.particles = new FixedList!(Particle )( PARTICLE_LIST_SIZE);
        this.starParticles = new FixedList!(StarParticle )( PARTICLE_LIST_SIZE);
        this.bars      = new FixedList!(ShadowBar)( SHADOW_BAR_LIST_SIZE);
        this.count = 0;
        this.gst.point = 0;
        this.nextBallAppear.pos = vecpos(st.game.screen.width/2,40); //次のボールの出現位置
        this.nextBallAppear.time = 0; //ボールが出現する間隔
        this.nextBallAppear.num = 1; //次に出現するボールの数
        //this.mode = Mode.REPLAY; //[ToDo: なんとか]
        this.rand = rand;
        this.ctr = ctr;

        //レベルデータ作成
        this.levels = loadLevels("data/level.csv");
        //writeln(this.levels);
        this.masterBlend = 0.0;

    }
    const pure const(Level) currentLevel()
    in{
        assert(this.levels !is null);
    }out(res){
        assert(res !is null);
    }body{
        return this.levels[this.gst.level];
    }
    int tmp = 0;
    /// 描画処理
    /// draw(State * double)をコールする
    /// 毎フレーム呼ばれる
    /// Params:
    ///     st = ゲームの状態
    import dxlib.all;
    public final override void draw(State st){
        //this.draw(st, sin(cast(double)tmp/199)/2+0.5);
        //tmp+= 1;
             //int grhandle = LoadGraph( "D:\\documents\\image\\do-kutu1st.jpg" );
        this.drawCommon(st, min(1.0, this.masterBlend));
        this.drawByMode(st, min(1.0, this.masterBlend));
        //SetDrawBlendMode(BlendMode.ALPHA, 255);
        //SetDrawBright(255,255,255);
        //SetDrawScreen(DX_SCREEN_BACK);
        //DrawGraph(0,0,st.systemDrawer.screen.dxhandle, false);
        //DrawRotaGraph(160,120, 0.6, 0.1, st.systemDrawer.screen.dxhandle, false   ) ;// グラフィックの回転描画
        //SetUsePixelShader(  LoadPixelShader( "./expand1.pso" ) ) ;
        // 使用するテクスチャをセット
        //writeln(SetUseTextureToShader( 0, grhandle/+st.systemDrawer.screen.dxhandle +/)) ;
        //DrawPrimitive2DToShader( DrawableSurface.Vert.ptr, 6, DX_PRIMTYPE_TRIANGLELIST) ;												// シェーダーを使って２Ｄプリミティブを描画する
    }

    /// 描画処理
    /// 毎フレーム呼ばれる
    /// Params:
    ///     st = ゲームの状態
    ///     blend = 描画の割合[0.0,1.0] 0なら描画しない 1なら100％描画
    protected final void drawCommon(State st, in double blend){
        // 名前が長いので別名に置き換え
        Drawer drawer = st.systemDrawer;

        //背景描画 背景色はゲーム全体で共有(st.h)
        drawer.fill(st.backgroundColor, BlendMode.ALPHA); 

        //パーティクル（ゲーム自体に影響を与えない、描画だけのオブジェクト）の描画
        foreach(particle; this.particles){
            if(particle.enable){
                particle.draw(drawer, vecpos(0,0), blend);
            }
        }
        //パーティクル（ゲーム自体に影響を与えない、描画だけのオブジェクト）の描画
        foreach(starParticle; this.starParticles){
            if(starParticle.enable){
                starParticle.draw(drawer, vecpos(0,0), blend);
            }
        }

        // パーティクルを目立たなくさせるため、上から背景色で塗りつぶす
        // パーティクルはゲーム自体には影響を与えないため、目立ちすぎては困るから
        const double PARTICLE_BLEND = 0.125*1.5;
        drawer.fill(st.backgroundColor, BlendMode.ALPHA, cast(int)(255*PARTICLE_BLEND));

        // ボールの描画
        foreach(ball; this.balls){
            ball.draw(st, drawer, vecpos(0,0), blend);
        }
        // draw walls
        //drawer.rect(st.wallCol, this.field.rect, false, BlendMode.ALPHA, cast(int)(blend*255));

        // シャドウバーのリストの描画
        foreach(bar; this.bars){
            if(bar.enable){
                bar.draw(drawer, vecpos(0,0), blend);
            }
        }
        // バーの描画
        // ゲームオーバーになったあとは描画しない（visibleで管理）
        if(this.bar.visible){
            this.bar.draw(drawer, vecpos(0,0), blend);
        }
        // result
        void drawResult(){
            double blend = between(0.0 ,cast(double)(resultCount)/30,1.0);
            int height = 100;
            int width  = 160;
            drawer.rect(BLACK, (320-width)/2, (240-height)/2,width,height, false, BlendMode.ALPHA, cast(int)(blend*masterBlend*255));
            drawer.rect(WHITE, (320-width)/2, (240-height)/2,width,height, false, BlendMode.ALPHA, cast(int)(blend*masterBlend*255));
            drawer.text_c(WHITE, vecpos(320/2, ((240-(st.font.size+1)*6)/2+st.font.size+2)+0*(st.font.size+1)), "結果", st.font, BlendMode.ALPHA, cast(int)(blend*masterBlend*255));
            /+
            drawer.text_c(WHITE, 
                    vecpos(320/2, ((240-(st.font.size+1)*6)/2+st.font.size+2)+2*(st.font.size+1)), 
                    format(Terms.Result.BOUND_NUMBER ~ " : %5d", this.gst.boundNum), st.font, BlendMode.ALPHA, cast(int)(blend*masterBlend*255));
            +/
            drawer.text_c(WHITE, vecpos(320/2, ((240-(st.font.size+1)*6)/2+st.font.size+2)+2*(st.font.size+1)), 
                    format(Terms.Result.STAR_NUMBER  ~ " : %5d", this.gst.goskyNum), st.font, BlendMode.ALPHA, cast(int)(blend*masterBlend*255));
            /+
            drawer.text_c(WHITE, vecpos(320/2, ((240-(st.font.size+1)*6)/2+st.font.size+2)+4*(st.font.size+1)), 
                    format(Terms.Result.SCORE        ~ " : %5d", this.gst.point), st.font, BlendMode.ALPHA, cast(int)(blend*masterBlend*255));
            +/
            drawer.text_c(WHITE, vecpos(320/2, ((240-(st.font.size+1)*6)/2+st.font.size+2)+3*(st.font.size+1)), 
                    format(Terms.Result.TIME         ~ " : %02d:%02d", this.gameCount/60/60, this.gameCount/60%60), st.font, BlendMode.ALPHA, cast(int)(blend*masterBlend*255));
        }
        this.drawScore(st, blend);
        /// ゲームモードによって場合分け
        with(Mode)final switch(this.mode){
        case START:
            break;
        case GAME:
            break;
        case GAMEOVER:
            //st.tt.mist.draw(drawer, this.gameoverCount, this.gameoverCountMax*2, BLACK);
            break;
        case RESULT:
            //drawer.fill(BLACK, BlendMode.MUL, cast(int)(127*masterBlend));
            /+if(st.scoreData is null || st.scoreData.score < this.gst.point){
                drawer.text_c(RED, vecpos(320/2, (40+st.font.size+2)+5*(st.font.size+1)), format("新記録！！"), st.font);
            }+/
            drawResult();
            break;
        case END:
            //drawer.fill(BLACK, BlendMode.MUL, 127);
            drawResult();
            st.tt.mist.draw(drawer, this.endCount, this.END_COUNT_MAX*2, BLACK);
            break;
        }



    }
    /// スコアなどの文字表示
    private void drawScore(State st, in double blend){
        Drawer drawer = st.systemDrawer;
        const int size  = st.font.size+1;
        const int top   = 30;
        const int left  = 260+4;
        const int right = 320-4;

        // 文字表示関数
        void dtext(int t, string text1, string text2){
            drawer.text_l(WHITE, vecpos(left, t), text1, st.font, BlendMode.ALPHA, cast(int)(blend*255));
            drawer.text_r(WHITE, vecpos(right, t + size), text2, st.font, BlendMode.ALPHA, cast(int)(blend*255));
            drawer.rect(WHITE, box(left, t+size*1.5, right, t+size*1.5+1), false, BlendMode.ALPHA, cast(int)(blend*255));
        }

        /// スコア等の表示
        //dtext( top + (size + 1)* 2 * 0, "SCORE",   format("%4d" , this.gst.point));
        dtext( top + (size + 1)* 2 * 0, " ★ ",   format("%4d" , this.gst.goskyNum));
        //dtext( top + (size + 1)* 2 * 1, "LEVEL",   format("%2d" , this.gst.level));
        //dtext( top + (size + 1)* 2 * 2, "COMBO",   format("%2d" , this.gst.combo));
        //dtext( top + (size + 1)* 2 * 3, "M COMBO", format("%2d" , this.gst.maxCombo));
        dtext( top + (size + 1)* 2 * 1, "TIME",    count2time(this.gameCount, 60));
    }

    /// 描画処理
    /// draw(State * double)をコールする
    /// 毎フレーム呼ばれる
    protected abstract void drawByMode(State st, in double blend);

    /// メインの更新処理
    public override Scene update(State st)
    in{
        assert(st !is null);
    } out(res) {
        assert(res !is null);
    }body{
        //現在のモードによって場合分け
        Scene res = this;
        with(Mode)final switch(this.mode){
        case START:
            this.startCount ++;
            this.masterBlend = 1.0*this.startCount/START_COUNT_MAX;
            if(startCount>START_COUNT_MAX){
                this.masterBlend = 1;
                this.mode = GAME;
            }
            break;
        case GAME:
            this.updatePlay(st);
            this.updatePlayByMode(st);
            this.gameCount ++;
            break;
        case GAMEOVER:
            res = updateGameOver(st);
            assert(res !is null);
            this.gameoverCount += 1;
            break;
        case RESULT:
            foreach(particle; this.particles){
                if(!particle.enable){continue;}
                particle.update();
            }
            foreach(starParticle; this.starParticles){
                if(!starParticle.enable){continue;}
                starParticle.update();
            }
            this.particles.leave((Particle b){return b.enable;});
            updateResult(st);
            this.resultCount += 1;
            break;

        case END:
            st.game.fps.flamerate = 60;
            if(this.endCount >= this.END_COUNT_MAX){
                return new TitleScene(st);
            }
            this.endCount ++;
            break;
        }
        this.count++;
        return res;
    }
    protected abstract Scene updateGameOver(State st);
    protected abstract void updateResult(State st);
    ///ゲームプレイ／リプレイモードで異なる処理
    protected abstract void updatePlayByMode(State st);
    ///ゲーム共通部分の更新
    protected void updatePlay(State st){
        // フリーズエフェクト
        if(this.freezCount > 0){
            this.freezCount -= 1;
            return;
        }
        bool big = false;
        bool dash = false;
        bool tap = false;
        st.h++;  //背景色のタメのパラメータ
        this.ctr.update();
        // アビリティの使用1
        final switch(st.ability1.type){
        case AbilityType.DASH:
            if(this.ctr.attack.isDown || this.ctr.down.isDown){
                dash = true;
            }
            break;
        case AbilityType.BIG:
            if(this.ctr.attack.isPress){
                big = true;
            }
            break;
        case AbilityType.TAP:
            if(this.ctr.attack.isDown){
                //tap = true;
                //タップは無しで
            }
            break;
        case AbilityType.SLOW:
            break;
        case AbilityType.MIRROR:
            break;
        case AbilityType.POWER:
            break;
        }
        // アビリティの使用2
        final switch(st.ability2.type){
        case AbilityType.DASH:
            if(this.ctr.shoot.isDown || this.ctr.attack.isDown || this.ctr.down.isDown){
                dash = true;
            }
            break;
        case AbilityType.BIG:
            if(this.ctr.shoot.isPress){
                big = true;
            }
            break;
        case AbilityType.TAP:
            if(this.ctr.shoot.isDown){
                tap = true;
            }
            break;
        case AbilityType.SLOW:
            break;
        case AbilityType.MIRROR:
            break;
        case AbilityType.POWER:
            break;
        }
        ///キー入力（水平方向）
        with(Horizon3)final switch(this.ctr.horizon3){
        case L:
            if(dash && this.bar.doubleDashNum == 0){
                this.bars.pushBack(new ShadowBar(this.bar.pos, 20, this.bar.isBig));
                this.bar.x = this.bar.x - this.bar.area.width;
                st.st["dash"].play();
                //this.gst.point -=  20;
                this.bar.doubleDashNum += 1;
            }else{
                this.bar.x = this.bar.x - this.BAR_SPEED;
            }
            break;
        case R:
            if(dash && this.bar.doubleDashNum == 0){
                this.bars.pushBack(new ShadowBar(this.bar.pos, 20, this.bar.isBig));
                this.bar.x = this.bar.x + this.bar.area.width;
                st.st["dash"].play();
                //this.gst.point -=  20;
                this.bar.doubleDashNum += 1;
            }else{
                this.bar.x = this.bar.x + this.BAR_SPEED;
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
        //レベルアップ
        if((this.gst.goskyNum >= this.currentLevel.levelupSum)){
            this.gst.level += 1;
        }
        //ボール出現前エフェクト
        if((this.gameCount - BALL_APPEAR_TIME + BALL_APPEAR_TIME) == this.nextBallAppear.time){
            st.st["appear_ball"].play();
            addBeforeAppearBallParticles(st, this.particles, this.nextBallAppear.pos);
        }
        /// ボール出現
        if((this.gameCount-BALL_APPEAR_TIME) == this.nextBallAppear.time){
            //ボール出現時エフェクト
            addAppearBallParticles(st, this.particles, nextBallAppear.pos);
            //ボールの追加
            this.balls.pushBack(new Ball(nextBallAppear.pos));
            //次のボールの出現位置と時間と出現個数を決める
            //int levelCount = 400 - (this.gst.level % 5) * 20 - (this.gst.level / 5) * 2;
            this.nextBallAppear.time = this.nextBallAppear.time  + rand.i(-this.gst.level,this.gst.level) + this.currentLevel.interval;//levelCount;// + this.rand.i(-50,100);
            this.nextBallAppear.pos = vecpos(
                    st.game.screen.width/2+this.rand.i(-this.currentLevel.width/2,this.currentLevel.width/2),   /+x軸+/
                    40+this.rand.i(0,this.currentLevel.height)                                                  /+y軸+/
            );
        }
        if(big && this.gst.point > 0){
            this.gst.point -= 1;
            this.bar.isBig = true;
        }else{
            this.bar.isBig = false;
        }
        //this.gst.level = this.gameCount / (60*30); //レベルアップ
            
        if(tap && this.bar.tappingCount <= 0){  // アビリティ タップ
            foreach(ball; this.balls){
                if(!ball.enable){continue;}
                if(st.cd.detect(ball.area, this.bar.tapArea, ball.pos, this.bar.pos - vecpos(0, this.bar.tapArea.height/2))){
                    if(ball.vel.y >0){
                        ball.vel = vecpos(ball.vel.x, -ball.vel.y);
                    }
                }
            }
            this.bar.tappingCount = this.bar.tappingCountMax;
        }

        if(this.bar.doubleDashNum >= 2){
            this.gst.combo = 0;
        }
        if(this.gst.maxCombo < this.gst.combo){
            this.gst.maxCombo = this.gst.combo;
        }

        ///update
        this.bar.update();
        foreach(bar; this.bars){
            if(bar.enable){
                bar.update();
            }
        }
        foreach(particle; this.particles){
            if(!particle.enable){continue;}
            particle.update();
        }
        foreach(starParticle; this.starParticles){
            if(!starParticle.enable){continue;}
            starParticle.update();
        }
        foreach(ball; this.balls){
            if(!ball.enable){continue;}
            ball.update();
            double reflectVelocity = 2.5 - this.rand.r(0,0.2);
            double finishVelocity  = 2.5*2;
            int finishCount = 10;
            void normalReflect(){
                //this.gst.combo = 0;
                ball.vel = vecpos(ball.vel.x+this.rand.randf(-0.1,0.1), -reflectVelocity);
                foreach(i; 0..100){
                    particles.pushBack(new CircleParticle(ball.pos, st.systemRand));
                }
            }
            void finishReflect(){
                this.gst.combo += 1;
                ball.vel = vecpos(ball.vel.x+this.rand.randf(-0.1,0.1), -finishVelocity);
                foreach(i; 0..500){
                    particles.pushBack(new CircleParticle(ball.pos, st.systemRand));
                }
                ball.gosky = true;
                this.freezCount = FREEZ_COUNT_MAX;
            }
            void reflect(bool isShadowBarReflection){
                st.st["reflect_bar"].play();
                this.gst.boundNum += 1;
                this.bar.doubleDashNum = 0;
                if(ball.boundCount < finishCount/+ || isShadowBarReflection+/){
                    normalReflect();
                }else{
                    finishReflect();
                }
                ball.pos = vecpos(ball.pos.x, this.bar.pos.y + this.bar.area.top - ball.area.height/2-1);
                //スコア加算
                this.gst.point += 10+this.gst.combo/10;
                ball.boundCount ++;
                foreach(i; 0..10){
                    this.particles.pushBack(new WaveParticle(ball.pos, st.systemRand));
                }
            }



            ///////////////// ボールとバーの当たり判定 ////////////////////////////
            if(big && this.gst.point > 0){ 
                if(st.cd.detect(ball.area, this.bar.bigArea, ball.pos, this.bar.pos)){    // ボールと大きなバーとの当たり判定
                    reflect(false);

                }
            }else{
                if(st.cd.detect(ball, this.bar)){
                    reflect(false);
                }
            }
            ///////////////// ボールとシャドウバーの当たり判定 ////////////////////////////
            foreach(bar; this.bars){
                if(big && this.gst.point > 0){ 
                    if(st.cd.detect(ball.area, bar.bigArea, ball.pos, bar.pos)){    // ボールと大きなバーとの当たり判定
                        reflect(true);

                    }
                }else{
                    if(st.cd.detect(ball, bar)){
                        reflect(true);

                    }
                }
            }



             //ボールと左の壁との当たり判定
            if(st.cd.detect(ball.area, this.field.leftwall, ball.pos, vecpos(0,0))){
                ball.vel = vecpos(-ball.vel.x, ball.vel.y);
                st.st["reflect_wall"].play();
                foreach(i; 0..10){
                    this.particles.pushBack(new WaveParticle(ball.pos, st.systemRand));
                }
            }
            //ボールと右の壁との当たり判定
            if(st.cd.detect(ball.area, this.field.rightwall, ball.pos, vecpos(0,0))){ 
                ball.vel = vecpos(-ball.vel.x, ball.vel.y);
                st.st["reflect_wall"].play();
                foreach(i; 0..10){
                    this.particles.pushBack(new WaveParticle(ball.pos, st.systemRand));
                }
            }
            //ボールと下の壁との当たり判定
            if(st.cd.detect(ball.area, this.field.bottomwall, ball.pos, vecpos(0,0))){ 
                this.mode =  Mode.GAMEOVER;
                st.st["gameover"].play();
            }
            //ボールと上の壁との当たり判定
            if(st.cd.detect(ball.area, this.field.topwall, ball.pos, vecpos(0,0))){ 
                ball.enable = false;
                st.st["gosky"].play();
                foreach(i; 0..100){
                    particles.pushBack(new TriangleParticle(ball.pos, st.systemRand));
                }
                foreach(i; 0..2){
                    this.particles.pushBack(new WaveFillParticle(ball.pos+st.systemRand.v(40), st.systemRand));
                }
                // 背景の星の追加
                Vector pos = st.systemRand.v(100)+vecpos(160,120);
                this.starParticles.pushBack(new StarParticle(pos, st.systemRand));
                // 得点加算
                this.gst.point += this.gst.combo*this.gst.combo * 50;
                this.gst.goskyNum += 1;
            }
            // 後一回でGoSkyするボールのエフェクト
            if(!ball.gosky){
                if(ball.boundCount>=10){
                    if(st.systemRand.b(0.1)){
                        foreach(i; 0..10){
                            this.particles.pushBack(new WaveParticle(ball.pos, st.systemRand));
                        }
                    }
                }
            }else{// 空に向かうボールが放つエフェクト
                foreach(i; 0..4){
                    this.particles.pushBack(new FixedCircleParticle(ball.pos+st.systemRand.v(8), st.systemRand));
                }
                if(ball.count %12 == 0){ 
                    if(ball.finishCount == 0){
                        st.st["finish_effect1"].play();
                        this.particles.pushBack(new WaveFillParticle(ball.pos, st.systemRand));
                    }else if(ball.finishCount == 1){ 
                        st.st["finish_effect2"].play();
                        this.particles.pushBack(new WaveFillParticle(ball.pos, st.systemRand));
                    }else{ 
                        st.st["finish_effect3"].play();
                        this.particles.pushBack(new WaveFillParticle(ball.pos, st.systemRand));
                    }
                    ball.finishCount += 1;
                }
            }
        }
        this.bars.leave((ShadowBar b){return b.enable;});
        this.balls.leave((Ball b){return b.enable;});
        this.particles.leave((Particle b){return b.enable;});
    }
    void addBeforeAppearBallParticles(State st, List!(Particle) particles, Vector pos){
        foreach(i; 0..10){
            particles.pushBack(new InWaveParticle(pos, st.systemRand));
        }
        foreach(i; 0..30){
            particles.pushBack(new InLineParticle(pos, st.systemRand));
        }
        foreach(i; 0..20){
            particles.pushBack(new InCircleParticle(pos, st.systemRand));
        }
    }
    void addAppearBallParticles(State st, List!(Particle) particles, Vector pos){
        foreach(i; 0..20){
            this.particles.pushBack(new WaveParticle( pos, st.systemRand));
        }
        foreach(i; 0..60){
            this.particles.pushBack(new TriangleParticle(pos, st.systemRand));
        }
    }
}
