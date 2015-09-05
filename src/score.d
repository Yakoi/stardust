module score;
import all;
import mylib.database;
import std.base64;

class Score{
    int id;
    int score;
    //string name;
    string date;
    int randseed;
    int star;
    int time;
    int ver;
    ControllerLogData ctrLog;
    this(int score, int time, int star, string date, int ver, int randseed, ControllerLogData ctrLog){
        this.id = 0;
        this.score = score;
        this.time = time;
        this.star = star;
        this.date = date;
        this.ver = ver;
        this.randseed = randseed;
        this.ctrLog = ctrLog;
    }
    this(int score, int time, int star, string date, int ver, int randseed, YamlNode ctrLogNode){
        this(
            score,
            time,
            star,
            date,
            ver,
            randseed,
            yamlToControllerLogData(ctrLogNode)
        );
    }
    this(int score, int time, int star, string date, int ver, int randseed, string ctrLogYamlString){
        this(
            score,
            time,
            star,
            date,
            ver,
            randseed,
            (new Yaml(cast(ubyte[])(ctrLogYamlString)))[0]
        );
    }
    this(Row row){
        this.id = to!(int)(row["id"]);
        this(
            to!(int)(row["score"]),
            to!(int)(row["time"]),
            to!(int)(row["star"]),
                     row["date"],
            to!(int)(row["var"]),
            to!(int)(row["randseed"]),
                     row["replay"]
        );
    }
}
ControllerLogData yamlToControllerLogData(ubyte[] yamlString){
    return yamlToControllerLogData((new Yaml(yamlString))[0]);
}
ControllerLogData yamlToControllerLogData(YamlNode node){
    ControllerLogData ctrLog;
    foreach(string s, YamlNode btn; node){
        InputLogData ild = new InputLogData;
        if(btn.tag == YAML_SEQ_TAG){
            foreach(YamlNode num; btn){
                ild.pushBack(num.i);
            }
        }
        ctrLog[s] = ild;
    }
    return ctrLog;
}
class ScoreDatabase : Database{
public:
    const string DATABASE_PATH = "score.db";
    const string TABLE_NAME = "score";
private:
    const string CREATE_TABLE_QUERY = 
        "CREATE TABLE '" ~ 
        TABLE_NAME ~
        "' ("~
            "id INTEGER PRIMARY KEY," ~ 
            "score INTEGER," ~ 
            "time INTEGER," ~
            "star INTEGER," ~
            "date DATE," ~
            "version INTEGER," ~
            "randseed INTEGER," ~
            "replay BLOB" ~
        ");";
    const string INSERT_UPDATE = 
        "INSERT INTO '" ~
        TABLE_NAME ~
        "' (score, time, star, date,         version, randseed, replay) " ~
        " VALUES " ~
        "  (0,     0,    0,    '2010-01-01', 0,       0,        ''    ) " ~
        ";";

public:
    this(){
        super(DATABASE_PATH);
        if(!this.hasTable(TABLE_NAME)){
            this.query(CREATE_TABLE_QUERY);
            //this.query(INSERT_UPDATE);
        }
    }
    void insertScore(Score sc){
        string sql = 
            format(
                "INSERT INTO '" ~
                TABLE_NAME ~
                "' (score, time, star, date, version, randseed, replay) " ~
                " VALUES " ~
                "  (%d,     %d,   %d,   '%s',    %d,       %d,      '%s'  ) " ~
                ";",
                sc.score, sc.time, sc.star, sc.date, sc.ver, sc.randseed, std.base64.Base64.encode(cast(ubyte[])zipAndEncodedData(logToYaml(sc.ctrLog).toString, "simple")));
        this.query(sql);
    }
}
