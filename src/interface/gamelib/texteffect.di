// D import file generated from 'gamelib\texteffect.d'
module gamelib.texteffect;
import gamelib.all;
import std.stdio;
import std.conv;
import mylib.list;
class TextEffect
{
    Vector pos;
    this()
{
}
    public final void draw(Drawer drawer, Color color, Vector pos, wstring str, int count, Font font, double blend);


    protected int drawCharacter(Drawer drawer, Color color, Vector pos, wchar ch, int i, int count, Font font, double blend);

    protected int counter(wchar ch, int i)
{
return -i * 4;
}

}
