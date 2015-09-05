module logoscene;
import all;


/// ロゴ表示
class LogoScene : Scene{
    List!(Particle) particles;
    const int COUNT_MAX = 400;
    const int FADE_OUT_TIME = 100;
    const int TEXT_BEGIN_TIME = 20;
    const int TEXT_INTERVAL_TIME = 10;
    const wstring NAME;
    int count = 0;
    static assert(LogoScene.FADE_OUT_TIME * 2 <= LogoScene.COUNT_MAX);
    this(string name){
        this.particles = new LinkedList!(Particle);
        this.NAME = wtext(name);
    }
    override Scene update(State st){
        st.game.mp.masterVolume=0;
        count += 1;

        if(st.game.it.a.isPress && this.count < this.COUNT_MAX - this.FADE_OUT_TIME){
            this.count = this.COUNT_MAX - this.FADE_OUT_TIME;
        }


        foreach(p; this.particles){
            p.update();
        }
        const int c = this.count-this.TEXT_BEGIN_TIME;
        if(  0 <= c && c/this.TEXT_INTERVAL_TIME < this.NAME.length && c/this.TEXT_INTERVAL_TIME*this.TEXT_INTERVAL_TIME == c){
            Vector p = vecpos(160-(cast(double)this.NAME.length/2-this.charnum-0.5)*st.font.size, 120);
            foreach(i; 0..st.systemRand.i(8,15)){
                this.particles.pushBack(new WaveParticle2(    p, st.systemRand));
            }
            foreach(i; 0..st.systemRand.i(1,3)){
                this.particles.pushBack(new TriangleParticle(p, st.systemRand));
            }
            foreach(i; 0..st.systemRand.i(4,8)){
                this.particles.pushBack(new CircleParticle(    p, st.systemRand));
            }
            foreach(i; 0..3){
                this.particles.pushBack(new FixedCircleParticle(    p, st.systemRand));
            }
        }
        if(count > COUNT_MAX){st.game.mp.play();return new TitleScene(st);}
        else{return this;}
    }
    override void draw(State st){
        Drawer drawer = st.systemDrawer;
        // set blend
        int blend;
        if(this.count < 0){
            assert(false);
        }else if(this.count < this.COUNT_MAX - this.FADE_OUT_TIME){
            blend = 255;
        }else if(this.count <= this.COUNT_MAX){
            blend = 255*(this.COUNT_MAX - this.count) / this.FADE_OUT_TIME;
        }else{
            assert(false);
        }

        drawer.fill(BLACK);
        foreach(p; this.particles){
            p.draw(drawer, zerovec, cast(double)blend/255);
        }
        drawer.fill(BLACK, BlendMode.ALPHA, 32);
        wchar[] tx;
        int charnum = this.charnum;
        tx.length = this.NAME.length;
        foreach(i, c; this.NAME){
            if(i<charnum){
                tx[i] = c;
            }else{
                tx[i] = '　';
            }
        }
        drawer.wtextDrawer.c(BLACK, vecpos(160,120)+vecpos(1,1), wtext(tx), 1,1,st.font, BlendMode.ALPHA, blend/2);
        drawer.wtextDrawer.c(BLACK, vecpos(160,120)-vecpos(1,1), wtext(tx), 1,1,st.font, BlendMode.ALPHA, blend/2);
        drawer.wtextDrawer.c(WHITE, vecpos(160,120), wtext(tx), 1,1,st.font, BlendMode.ALPHA, blend);
        //drawer.wtextDrawer.b(WHITE, vecpos(160,120+st.font.size/2), wtext(tx), 2,3,st.font, BlendMode.ALPHA, blend);
        drawer.line(YELLOW, vecpos(0,120+st.font.size/2), vecpos(320,120+st.font.size/2), 1, BlendMode.ALPHA, blend);
        //drawer.line(YELLOW, vecpos(0,120), vecpos(320,120));
        //drawer.line(YELLOW, vecpos(160,0), vecpos(160,120*2));
        //st.te.draw(drawer, RED, vecpos(100,100), "aaいaaあおばくあ44あああ"w, this.count, st.font, 1.0);
        //st.te.draw(drawer, RED, vecpos(100,160), wtext(this.count), this.count, st.font, 1.0);
    }
    private int charnum(){
        return min!(int)(this.NAME.length, max((this.count-this.TEXT_BEGIN_TIME) /this.TEXT_INTERVAL_TIME, 0));
    }
}
