module gamelib.texteffect;

import gamelib.all;
import std.stdio;
import std.conv;
import mylib.list;

class TextEffect{
    //CharacterMoverList charList;
    Vector pos;
    this(){
    }
    public final void draw(Drawer drawer, Color color, Vector pos, wstring str, int count, Font font, double blend){
        int xpos = 0;
        foreach(uint i, wchar ch; str){
            int c = this.counter(ch, i) + count;
            xpos += this.drawCharacter(drawer, color, pos+vecpos(xpos,0), ch, i, c, font, blend);
        }
    }
    protected int drawCharacter(Drawer drawer, Color color, Vector pos, wchar ch, int i, int count, Font font, double blend){
        const int MAX = 20;
        const int MOVE_LEN = 20;
        if(count < 0){
            //donothing
        }else if(count < MAX){
            double countPar = cast(double)count/MAX;
            drawer.wtextDrawer.tl(color, pos-vecpos(0,(1-countPar)*(1-countPar))*MOVE_LEN, [ch], 1, 1, font, BlendMode.ALPHA, 255*count/MAX);
        }else{
            drawer.wtextDrawer.tl(color, pos, [ch], 1, 1);
        }
        return drawer.wstringWidth([ch], -1, font);
    }
    protected int counter(wchar ch, int i){
        return -i*4;
    }
}

