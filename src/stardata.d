module stardata;

import std.xml;
import all;
import mylib.encoder;
import mylib.hashfunction;
import mylib.base64encoder;


class StarData{
    Vector pos;
    int power; //明るさ
    int size; //大きさ
    Color color;
    string date;
    string info;
    this(Vector pos, Color color, int size, int power, string date="", string info="no info"){
        this.pos = pos;
        this.color = color;
        this.size = size;
        this.power = power;
        this.date = date;
        this.info = info;
    }
/+
//rng
star = 
    element pos{
        element x{ xsd:integer },
        element y{ xsd:integer }
    },
    element color {
        element red{ xsd:integer },
        element green{ xsd:integer },
        element blue{ xsd:integer }
    },
    element size {xsd:integer},
    element power { xsd:integer },
    element date { text },
    element info { text }?
+/
    this(std.xml.Element element){
        assert(element.tag.name == "star");
        Element posElement = element.elements[0];
        assert(posElement.tag.name == "pos");
        {
            Element xElement = posElement.elements[0];
            assert(xElement.tag.name == "x");
            this.pos.x = to!double(text(xElement.items[0]));

            Element yElement = posElement.elements[1];
            assert(yElement.tag.name == "y");
            this.pos.y = to!double(text(yElement.items[0]));
        }
        Element colorElement = element.elements[1];
        assert(colorElement.tag.name == "color");
        {
            Element redElement = colorElement.elements[0];
            assert(redElement.tag.name == "red");
            int red = to!int(text(redElement.items[0]));

            Element greenElement = colorElement.elements[1];
            assert(greenElement.tag.name == "green");
            int green = to!int(text(greenElement.items[0]));

            Element blueElement = colorElement.elements[2];
            assert(blueElement.tag.name == "blue");
            int blue = to!int(text(blueElement.items[0]));

            this.color = col(red,green,blue);
        }

        Element sizeElement = element.elements[2];
        assert(sizeElement.tag.name == "size");
        this.size = to!int(text(sizeElement.items[0]));

        Element powerElement = element.elements[3];
        assert(powerElement.tag.name == "power");
        this.power = to!int(text(powerElement.items[0]));

        Element dateElement = element.elements[4];
        assert(dateElement.tag.name == "date");
        if(dateElement.items.length == 1){
            this.date = text(dateElement.items[0]);
        }else{
            this.date = "";
        }

        Element infoElement = element.elements[5];
        assert(infoElement.tag.name == "info");
        if(infoElement.items.length == 1){
            this.info = text(infoElement.items[0]);
        }else{
            this.info = "no info";
        }
    }
    Element toXmlElement(){
        Element topElement = new Element("star");
        {
            Element posElement = (new Element("pos"));
            {
                posElement ~= (new Element("x", to!string(this.pos.x)));
                posElement ~= (new Element("y", to!string(this.pos.y)));
            }
            topElement ~= posElement;

            Element colorElement = new Element("color");
            {
                colorElement ~= new Element("red", to!string(this.color.red));
                colorElement ~= new Element("green", to!string(this.color.green));
                colorElement ~= new Element("blue", to!string(this.color.blue));
            }
            topElement ~= colorElement;

            Element sizeElement = new Element("size", to!string(this.size));
            topElement ~= sizeElement;

            Element powerElement = new Element("power", to!string(this.power));
            topElement ~= powerElement;

            Element dateElement = new Element("date", to!string(this.date));
            topElement ~= dateElement;

            Element infoElement = new Element("info", to!string(this.info));
            topElement ~= infoElement;
        }
        return topElement;
    }
    StarParticle createStarParticle(Rand rand){
        StarParticle res = new StarParticle(this.pos, this.color, this.size, this.power, rand);
        return res;
    }

}

unittest{
    //mainHash(["","1", "2"]);
    StarData s1 = new StarData;
    StarData s2 = new StarData;
    StarData s3 = new StarData;
    Document doc = new Document(new Tag("stars"));
    doc ~= s1.toXmlElement;
    doc ~= s2.toXmlElement;
    doc ~= s3.toXmlElement;
    Encoder enc = new CamelliaEncoder("devilsticks");
    HashFunction hf = new Sha1HashFunction();
    string signature = getXmlSignature(enc, hf, doc);
    doc.tag.attr["signature"] = signature;
    string xmlstr = join(doc.pretty,"\n");
    writeln(xmlstr);


    Document doc2 = new Document(xmlstr);
    string sig1 = doc2.tag.attr["signature"];
    doc2.tag.attr.remove("signature");
    string sig2 = getXmlSignature(enc,hf,doc2);
    if(sig1 == sig2){writeln("ok");}
    string xmlstr2 = join(doc2.pretty,"\n");
    writeln(xmlstr2);
    writeln(doc);
    writeln(doc2);
    writeln(sig1);
    writeln(sig2);
    assert(0);
}

List!StarData loadStarsData(string path, Encoder enc, HashFunction hf){
    Tag t1 = new Tag("stars");
    string data = cast(string)(dxread(path));
    if(!checkXmlSignature(enc, hf, data)){
        writeln("sig error");
        return new LinkedList!StarData();
    }
    Document d = new Document(data);
    List!StarData starDataList = new LinkedList!StarData();
    foreach(elem; d.elements){
        starDataList.pushBack(new StarData(elem));
    }
    return starDataList;
}
void saveStarData(string path, Encoder enc, HashFunction hf, List!StarData starDataList){
    Element d = new Document(new Tag("stars"));
    foreach(starData; starDataList){
        d ~= starData.toXmlElement();
    }
    setXmlSignature(enc, hf, d);
    std.file.write(path, join(d.pretty(2),"\n"));
}
