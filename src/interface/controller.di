// D import file generated from 'controller.d'
module controller;
import gamelib.all;
import mylib.yaml;
alias InputLogData[string] ControllerLogData;
class Controller
{
    Input attack;
    Input shoot;
    Input power;
    Input guard;
    Input left;
    Input right;
    Input up;
    Input down;
    version (none)
{
    private ControllerLog _log;

}
    private bool _recording = false;

    private InputTable it;

    this(InputTable it)
{
this.it = it;
this.attack = new Input;
this.shoot = new Input;
this.power = new Input;
this.guard = new Input;
this.left = new Input;
this.right = new Input;
this.up = new Input;
this.down = new Input;
this.attack._recordingLog = true;
this.shoot._recordingLog = true;
this.power._recordingLog = true;
this.guard._recordingLog = true;
this.left._recordingLog = true;
this.right._recordingLog = true;
this.up._recordingLog = true;
this.down._recordingLog = true;
}
    void update()
{
this.attack.update(it.a.isPress);
this.shoot.update(it.b.isPress);
this.power.update(it.c.isPress);
this.guard.update(it.c.isPress);
this.left.update(it.left.isPress);
this.right.update(it.right.isPress);
this.up.update(it.up.isPress);
this.down.update(it.down.isPress);
}
    int horizon()
{
return (this.left.isPress ? -1 : 0) + (this.right.isPress ? 1 : 0);
}
    int vertical()
{
return (this.up.isPress ? -1 : 0) + (this.down.isPress ? 1 : 0);
}
    Horizon3 horizon3();
    Vertical3 vertical3();
    Direction9 direction9();
    Direction5 direction5();
}
ControllerLogData controllerToControllerLogData(Controller ctr)
{
ControllerLogData ld;
ld["left"] = ctr.left.log;
ld["right"] = ctr.right.log;
ld["up"] = ctr.up.log;
ld["down"] = ctr.down.log;
ld["attack"] = ctr.attack.log;
ld["shoot"] = ctr.shoot.log;
ld["power"] = ctr.power.log;
ld["guard"] = ctr.guard.log;
return ld;
}
InputLogPlayer load_input_log(YamlNode yn);
version (none)
{
    void saveLog(ControllerLogPlayer logplayer)
{
InputLogData[string] tmp;
tmp["left"] = logplayer.left.data;
tmp["right"] = logplayer.right.data;
save_yaml("test.yaml",logToYaml(tmp));
}
}
MappingYamlNode logToYaml(ControllerLogData data);
SequenceYamlNode logToYaml(InputLogData data)
{
SequenceYamlNode node = sequenceList!(int)(data);
return node;
}
class InputPlayController : Controller
{
    ControllerLogPlayer log;
    private this(ControllerLogPlayer log)
{
this.log = log;
super(null);
}

    this(ControllerLogData log)
{
this(new ControllerLogPlayer(log));
}
    override void update()
{
this.attack.update(log.attack.play);
this.shoot.update(log.shoot.play);
this.power.update(log.power.play);
this.guard.update(log.guard.play);
this.left.update(log.left.play);
this.right.update(log.right.play);
this.up.update(log.up.play);
this.down.update(log.down.play);
}

}
private class ControllerLogPlayer
{
    InputLogPlayer attack;
    InputLogPlayer shoot;
    InputLogPlayer power;
    InputLogPlayer guard;
    InputLogPlayer left;
    InputLogPlayer right;
    InputLogPlayer up;
    InputLogPlayer down;
    this(YamlNode yn)
{
this.left = load_input_log(yn["left"]);
this.right = load_input_log(yn["right"]);
this.up = load_input_log(yn["up"]);
this.down = load_input_log(yn["down"]);
}
    this(Controller ctr)
{
this.attack = new InputLogPlayer(ctr.attack.log);
this.shoot = new InputLogPlayer(ctr.shoot.log);
this.power = new InputLogPlayer(ctr.power.log);
this.guard = new InputLogPlayer(ctr.guard.log);
this.left = new InputLogPlayer(ctr.left.log);
this.right = new InputLogPlayer(ctr.right.log);
this.up = new InputLogPlayer(ctr.up.log);
this.down = new InputLogPlayer(ctr.down.log);
}
    this(ControllerLogData cld);
}

