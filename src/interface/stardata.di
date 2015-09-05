// D import file generated from 'stardata.d'
module stardata;
import std.xml;
import all;
import mylib.encoder;
import mylib.hashfunction;
import mylib.base64encoder;
class StarData
{
    Vector pos;
    int power;
    int size;
    Color color;
    string date;
    string info;
    this(Vector pos, Color color, int size, int power, string date = "", string info = "no info")
{
this.pos = pos;
this.color = color;
this.size = size;
this.power = power;
this.date = date;
this.info = info;
}
    this(std.xml.Element element);
    Element toXmlElement();
    StarParticle createStarParticle(Rand rand)
{
StarParticle res = new StarParticle(this.pos,this.color,this.size,this.power,rand);
return res;
}
}
List!(StarData) loadStarsData(string path, Encoder enc, HashFunction hf);
void saveStarData(string path, Encoder enc, HashFunction hf, List!(StarData) starDataList);
