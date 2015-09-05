// D import file generated from 'replay.d'
module replay;
import gamelib.all;
import mylib.yaml;
import controller;
enum GameMode 
{
normal,
}
class Replay
{
    ControllerLogData ctr_log;
    int rand_seed;
    GameMode game_mode;
}
Replay load_replay(string path)
{
return null;
}
Replay load_replay(Yaml yaml)
{
return null;
}
void save_replay(string path, Replay replay)
{
}
