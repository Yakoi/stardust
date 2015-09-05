module gamelib.gamemain;

import gamelib.all;
enum GameResult{
    CONTINUE,
    EXIT,
    ERROR,
    RESET,
}
abstract class GameMain{
private:
    GameSystem _game;
protected:
    this(GameSystem game){
        this._game = game;
    }
    /// ゲームシステムクラスを返す
    @property pure const final GameSystem game(){return cast(GameSystem)this._game;}
    /// 初期化
    /// 一番最初に呼ばれる
    /// サブクラスで実装
    abstract void init();
    /// 更新
    /// ゲームが中断されている時以外、毎フレーム呼ばれる
    /// サブクラスで実装
    abstract GameResult update();
    /// 描画
    /// 処理が追いついているとき、毎フレーム呼ばれる
    /// サブクラスで実装
    abstract void draw();
    /// 画像再生成
    /// 画面モードが変更されたときに呼ばれる
    /// サブクラスで実装
    abstract void recreate();
    /// 後処理
    /// ゲームが終了するときに呼ばれる
    /// サブクラスで実装
    abstract void finalize();
public:
    /// ゲーム実行関数
    final void run(){
        // エラーが出たらログを出力してプログラムを終了させる。
        try{
            this.runMain();
        } catch(Exception e){
            game.happenError(e.msg);
            std.file.write("exception.log", e.msg);
            std.stdio.writeln(e.msg);
            writeln("happen exception in function `run()`!");
            assert(game.errorMode);
            throw e;
        } catch(Error err){
            game.happenError(err.msg);
            std.file.write("error.log", err.msg);
            std.stdio.writeln(err.msg);
            writeln("happen error in function `run()`!");
            assert(game.errorMode);
            throw err;
        } catch(Throwable o){
            game.happenError(o.toString);
            std.file.write("error.log", text(o));
            std.stdio.writeln(text(o));
            writeln("happen ??? in function `run()`!");
            assert(game.errorMode);
            throw o;
        }
    }
private:
    // メイン処理
    // ここはいじらない
    // 最初に呼ばれる
    final void runMain(){
        this.init();
        GameResult result;
        while(game.process() && result == GameResult.CONTINUE){
            // エラーが出たらログを出力してプログラムを終了させる。
            try{
                result = this.mainLoop();
            } catch(Exception e){
                game.happenError(e.msg);
                writeln("happen exception in function `runMain()`!");
                std.file.write("exception.log", e.msg);
                std.stdio.writeln(e.msg);
            } catch(Error e){
                game.happenError(text(e));
                writeln("happen error in function `runMain()`!");
                std.file.write("exception.log", text(e));
                std.stdio.writeln(text(e));
            } catch(Throwable o){
                game.happenError(text(o));
                writeln("happen ??? in function `runMain()`!");
                std.file.write("error.log", text(o));
                std.stdio.writeln(text(o));
            }
        }
        this.finalize();
    }
    // メインループ
    // ここはいじらない
    // runMainから呼ぶ
    final GameResult mainLoop(){
        // ウィンドウモード，フルスクリーンモードの変更により，
        // メモリ上から画像データが失われた時
        if(game.window.changeScreen){ 
            this.recreate();
        }
        // エラーがでてないとき
        if(!game.errorMode){
            // システムキーによりポーズがかけられていない時
            ////////////////////////////// 更新処理とその結果処理 /////////////////////////////
            GameResult result;
            if(!game.pausing){
                result = this.update(); // メインの更新処理
            }
            with(GameResult)final switch(result){
            case CONTINUE:
                //do normal process
                break;
            case EXIT:
            case ERROR:
            case RESET:
                // do nothing
                return result;
            }

            ////////////////////////////// 描画処理 /////////////////////////////
            if(!game.fps.skip){
                this.draw(); // メインの描画処理
            }
            /////////////////////////////// draw FPS ////////////////////////////////
            void drawFps(Drawer drawer, Color color, double fpsAverage){
                drawer.rect(BLACK, 0, 0, game.font.size*6/2+1, game.font.size, true, BlendMode.ALPHA, 127);
                drawer.rect(WHITE, 0, 0, game.font.size*6/2+1, game.font.size, false, BlendMode.ALPHA, 127);
                drawer.text_tl(color, vecpos(0+1,0), format("%6.2f", fpsAverage), game.font, BlendMode.ALPHA, 191);
            }
            if(game.drawsFps){
                if(isFinite(game.fps.average)){ //普通に表示
                    if(game.fps.average > game.fps.flamerate * 55/60){
                        drawFps(game.systemDrawer, WHITE, game.fps.average);
                    }else{
                        drawFps(game.systemDrawer, RED, game.fps.average);
                    }
                }else{//FPSを切り替えた瞬間
                    drawFps(game.systemDrawer, GREEN, game.fps.flamerate);
                }
            }
            /////////////////////////////// ゲームのリセット ////////////////////////////////
            //[Todo: Gameクラス中のsystemKey関係のメソッドはこのクラスで実装すべき？]
            if(game.getReturnTitle){
                game.setReturnTitle = false;
                //st.scene = new LogoScene(st.TEAM_NAME_JP);
                this.finalize();
                this.init();
                game.fps.flamerate = 60;
            }
            return result;
        }else{
            //writeln("Error");//[Todo: ???]
            return GameResult.CONTINUE;
        }
        //game.systemDrawer.text(RED, vecpos(100,0), "SCORE : " ~ text(st.point), st.font);
        //game.systemDrawer.text(RED, vecpos(0,20), "" ~ text(st.count), st.font);
        //GC.collect();
    }
}
