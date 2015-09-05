module state;

import all;
import mylib.encoder;
import mylib.hashfunction;
///いらない
enum AbilityType{
    DASH,
    BIG,
    TAP,
    SLOW,
    MIRROR,
    POWER,
}
/// 背景の星
class State{
    immutable string PROGRAM_NAME_JP = Terms.MetaInformation.PROGRAM_NAME_JP;
    immutable string PROGRAM_NAME_EN = Terms.MetaInformation.PROGRAM_NAME_EN;
    immutable string PROGRAM_NAME    = Terms.MetaInformation.PROGRAM_NAME;
    immutable string TEAM_NAME_JP    = Terms.MetaInformation.TEAM_NAME_JP;
    immutable string TEAM_NAME_EN    = Terms.MetaInformation.TEAM_NAME_EN;
    immutable string TEAM_NAME       = Terms.MetaInformation.TEAM_NAME;
    immutable int VERSION            = 100;
    Drawer systemDrawer;
    Encoder encoder;
    HashFunction hash;
    GameSystem game;                  //ゲーム管理クラス
    int count;                  //ゲームが起動してからのフレーム数
    Font[string] fontTable;     //ロードしたフォントのテーブル
    CollisionDetector cd;       //衝突判定クラス
    Font font;                  //デフォルトで使用するフォント
    Scene scene;                //現在のシーン
    //ControllerLogData replay_data;
    Ability ability1;           //アビリティ1[Todo: 多分消す]
    Ability ability2;           //アビリティ2[Todo: 多分消す]
    TransitionTable tt;         //作ったトランジション
    Rand systemRand;            //エフェクトなどで使用するRand
    Sound[string] st;           //ロードした効果音
    MusicData[string] mt;       //ロードした音楽
    int h;                      //背景色のためのパラメータ
    TextEffect te;
    List!(StarData) starDataList;
    this(){
        this.encoder = new CamelliaEncoder("devilsticks");
        this.hash    = new Sha1HashFunction();
    }
    @property Color backgroundColor(){
        return hsv(this.h/10, 0.6, 0.15);
    }
}

