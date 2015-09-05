// D import file generated from 'scoredata.d'
module scoredata;
import all;
class ScoreData
{
    int score;
    string name;
    int randseed;
    int boundNum;
    int goskyNum;
    ControllerLogData ctrLog;
    YamlNode toYamlNode()
{
YamlNode[string] data;
data["score"] = new ScalarYamlNode(score);
data["name"] = new ScalarYamlNode(name);
data["randseed"] = new ScalarYamlNode(randseed);
data["input"] = logToYaml(ctrLog);
data["bound"] = new ScalarYamlNode(this.boundNum);
data["gosky"] = new ScalarYamlNode(this.goskyNum);
data["date"] = new ScalarYamlNode(0);
return mapping(data);
}
    this(int score, string name, int randseed, ControllerLogData ctrLog, int boundNum, int goskyNum)
{
this.score = score;
this.name = name;
this.randseed = randseed;
this.ctrLog = ctrLog;
this.boundNum = boundNum;
this.goskyNum = goskyNum;
}
    this(YamlNode n);
}
void saveScoreData(string path, ScoreData sd)
{
auto archive = new ZipArchive;
auto mem = new ArchiveMember;
string yndata = sd.toYamlNode.toString;
mem.expandedData = cast(ubyte[])(yndata ~ getDigestString(yndata));
mem.name = "score_data";
mem.compressionMethod = 8;
archive.addMember(mem);
auto svdata = archive.build();
saveCamelliaData("02.sav",svdata,"simple");
}
ScoreData loadScoreData(string path);
