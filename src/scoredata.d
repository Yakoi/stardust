module scoredata;
import all;

class ScoreData{
    int score;
    string name;
    int randseed;
    int boundNum;
    int goskyNum;
    ControllerLogData ctrLog;
    YamlNode toYamlNode(){
        YamlNode[string] data;
        data["score"] = new ScalarYamlNode(score);
        data["name"]  = new ScalarYamlNode(name);
        data["randseed"] = new ScalarYamlNode(randseed);
        data["input"]  = logToYaml(ctrLog);
        data["bound"]  = new ScalarYamlNode(this.boundNum);
        data["gosky"]  = new ScalarYamlNode(this.goskyNum);
        data["date"]   = new ScalarYamlNode(0);
        return mapping(data);
    }
    this(int score, string name, int randseed, ControllerLogData ctrLog, int boundNum, int goskyNum){
        this.score = score;
        this.name  = name;
        this.randseed = randseed;
        this.ctrLog = ctrLog;
        this.boundNum = boundNum;
        this.goskyNum = goskyNum;
    }
    this(YamlNode n){
        if("score" !in n || "name" !in n || "randseed" !in n || "gosky" !in n || "bound" !in n){
            throw new Exception("");
        }
        this.score = n["score"].i;
        this.name  = n["name"].s;
        this.randseed = n["randseed"].i;
        this.goskyNum = n["gosky"].i;
        this.boundNum = n["bound"].i;
        //this.ctrLog = ControllerLogData();
        foreach(string s, YamlNode btn; n["input"]){
            InputLogData ild = new InputLogData;
            if(btn.tag == YAML_SEQ_TAG){
                foreach(YamlNode num; btn){
                    ild.pushBack(num.i);
                }
            }
            this.ctrLog[s] = ild;
        }
    }
}
void saveScoreData(string path, ScoreData sd) {
    //save_yaml(path, sd.toYamlNode); //蟷ｳ譁?
    auto archive = new ZipArchive;
    auto mem = new ArchiveMember;
    string yndata = sd.toYamlNode.toString;
    mem.expandedData = cast(ubyte[])(yndata~getDigestString(yndata));
    mem.name = "score_data";
    mem.compressionMethod = 8;
    archive.addMember(mem);
    auto svdata = archive.build();
    saveCamelliaData("02.sav", svdata, "simple");
    //saveCamelliaData("01.sav", yndata~getDigestString(yndata), "simple");
}
ScoreData loadScoreData(string path){
    /+
    YamlNode n = load_yaml(path)[0];
    return new ScoreData(n);
    +/

    try{
        auto data0 = loadCamelliaData("02.sav", "simple");
        auto archive = new ZipArchive(data0);
        auto data = archive.expand(archive.directory["score_data"]);
        auto strdata = data[0..$-32];
        string md5data = cast(string)data[$-32..$];
        assert(md5data == getDigestString(strdata));
        writeln(cast(string)strdata);
        YamlNode n = (new Yaml(strdata))[0];
        return new ScoreData(n);
    }catch(Exception e){
        writeln(e.msg);
        return null;
    }
}
