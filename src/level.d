module level;

import all;

/// レベルによる特殊効果
enum LevelType{
    NORMAL,
    TEST,
    TEST2,
    TEST3,
}

/// レベルデータ
class Level{
    int level;
    int interval;
    int width;
    int height;
    int number;
    int levelup;
    int levelupSum;
    LevelType levelType = LevelType.NORMAL;
    this(int level, int interval, int width, int height, int number, int levelup, int levelupSum, LevelType levelType){
        this.level = level;
        this.interval = interval;
        this.width = width;
        this.height = height;
        this.number = number;
		this.levelup = levelup;
		this.levelupSum = levelupSum;
        this.levelType = levelType;
    }
    this(TableRow row, int levelupSum){
        this(
            to!(int)(row["level"]),
            to!(int)(row["interval"]),
            to!(int)(row["width"]),
            to!(int)(row["height"]),
            to!(int)(row["number"]),
            to!(int)(row["levelup"]),
            levelupSum,
            intToLevelType(to!(int)(row["type"])));
    }

    override string toString(){
        return text(this.level, " - ", this.interval, " - ", this.number);
    }
}

/// レベルデータが定義されたCSVファイルを読み込む
Level[] loadLevels(string path){
    Level[] res;
	int sum = 0;
    //ロード
    string levelData = cast(string)dxread("data/level.csv");
    Table table = csvToTable(levelData);
    //Table table = loadCsvAsTable(path);
    res.length = table.length;
    //レベルテーブルの作成
    foreach(i, row; table){
		sum += to!(int)(row["levelup"]);
        res[i] = new Level(row, sum);
    }
    return res;
}

private LevelType intToLevelType(int n){
    assert(LevelType.min <= n && n < LevelType.max, text(LevelType.min, " <= ", n, " < ", LevelType.max));
    return cast(LevelType)n;
}
