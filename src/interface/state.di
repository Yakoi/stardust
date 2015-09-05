// D import file generated from 'state.d'
module state;
import all;
import mylib.encoder;
import mylib.hashfunction;
enum AbilityType 
{
DASH,
BIG,
TAP,
SLOW,
MIRROR,
POWER,
}
class State
{
    immutable string PROGRAM_NAME_JP = "\xe3\x83\x9b\xe3\x82\xb7\xe3\x82\xaf\xe3\x82\xba";

    immutable string PROGRAM_NAME_EN = "STAR DUST";

    immutable string PROGRAM_NAME = PROGRAM_NAME_EN;

    immutable string TEAM_NAME_JP = "\xe3\x82\xb7\xe3\x82\xb3\xe3\x82\xa6\xe3\x83\x86\xe3\x82\xa4\xe3\x82\xb7\xe3\x83\x81\xe3\x83\xa5\xe3\x82\xa6";

    immutable string TEAM_NAME_EN = "SHIKOU TEISHICHU";

    immutable string TEAM_NAME = TEAM_NAME_JP;

    Encoder encoder;
    HashFunction hash;
    GameSystem game;
    int count;
    Font[string] fontTable;
    CollisionDetector cd;
    Font font;
    Scene scene;
    Ability ability1;
    Ability ability2;
    TransitionTable tt;
    Rand systemRand;
    Sound[string] st;
    MusicData[string] mt;
    int h;
    TextEffect te;
    List!(StarData) starDataList;
    this()
{
this.encoder = new CamelliaEncoder("devilsticks");
this.hash = new LuffaHashFunction;
}
    @property Color backgroundColor()
{
return hsv(this.h / 10,0.6,0.15);
}

}
