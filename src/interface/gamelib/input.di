// D import file generated from 'gamelib\input.d'
module gamelib.input;
import gamelib.all;
alias VariableList!(int) InputLogData;
class Input
{
    private 
{
    const int _countInit = -100000;

    int _count = _countInit;
    int _lastCount = _countInit;
    InputLogRecorder _inputLogRecorder;
    public 
{
    bool _recordingLog = false;
    package 
{
    public this()
{
_count = _countInit;
_lastCount = _countInit;
_inputLogRecorder = new InputLogRecorder;
}

    public 
{
    void update(bool is_push);
    InputLogData log()
{
return this._inputLogRecorder.data;
}
    const pure bool isPress()
{
return _count > 0;
}

    const pure bool isDown()
{
return _count == 1;
}

    const pure bool isUp()
{
return _count == -1;
}

    const pure bool isChange()
{
return isDown() || isUp();
}

    const pure int count()
{
return _count;
}

    const pure int lastCount()
{
return _lastCount;
}

    void count(int count)
{
_count = count;
}
    void reset()
{
_count = _countInit;
}
}
}
}
}
}
class InputLogRecorder
{
    InputLogData data;
    int count = 0;
    bool lastCond = false;
    this()
{
this.data = new InputLogData;
this.count = 0;
}
    void record(bool cond);
}
class InputLogPlayer
{
    InputLogData data;
    int count = 0;
    int time = -1;
    bool lastCond = false;
    this(InputLogData data);
    bool play();
}
InputLogPlayer recorderToPlayer(InputLogRecorder rec)
{
return new InputLogPlayer(rec.data);
}
