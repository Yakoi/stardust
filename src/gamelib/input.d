module gamelib.input;
import gamelib.all;

alias VariableList!(int) InputLogData;
/// ボタン入力(On,Offで管理)
class Input{
private:
    const int _countInit = -100000;
    int _count = _countInit;
    int _lastCount = _countInit;
    InputLogRecorder _inputLogRecorder;
public:
    bool _recordingLog = false;
package:
    public this(){
        _count = _countInit;        //最初は押されていない状態
        _lastCount = _countInit;        //最初は押されていない状態
        _inputLogRecorder = new InputLogRecorder;
    }
public:
    ///##@brief キーのチェックとcountの増加を行う
    ///@attention 毎フレーム呼ぶこと
    ///@param[in] is_push:bool
    void update(bool is_push){
        this._lastCount = this._count;
        if(_count >= 0){    //前回押されていた
            if(is_push){
                this._count += 1;
            }else{
                this._count = -1;
            }
        }else if(this._count < 0){    //前回離されていた
            if(is_push){
                this._count = 1;
            }else{
                this._count += -1;
            }
        }
        if(this._recordingLog){
            this._inputLogRecorder.record(is_push);
        }
    }
    ///logデータを取得
    InputLogData log(){
        return this._inputLogRecorder.data;
    }
    ///@brief 押されているかどうか調べる
    ///@return bool 押されているならTrue,離されているならFalse
    const pure bool isPress(){
        return _count > 0;
    }
    ///@brief 押された瞬間かどうか調べる
    ///@return bool 押された瞬間ならTrue,そうでなければFalse
    const pure bool isDown(){
        return _count == 1;
    }
    ///@brief 離された瞬間かどうか調べる
    ///@return bool 離された瞬間ならTrue,そうでなければFalse
    const pure bool isUp(){
        return _count == -1;
    }
    ///@brief 押された瞬間または離された瞬間かどうか、つまりキーの状態が変化した瞬間か調べる
    ///@return bool キーの状態が変化した瞬間ならTrue,そうでなければFalse
    const pure bool isChange(){
        return isDown() || isUp();
    }
    /// カウンタ取得
    const pure int count(){
        return _count;
    }
    /// 一瞬前のカウントを取得
    const pure int lastCount(){
        return _lastCount;
    }
    /// カウンタ設定
    void count(int count){
        _count = count;
    }
    /// カウンタのリセット
    void reset(){
        _count = _countInit;
    }
}
class InputLogRecorder{
    InputLogData data;
    int count = 0;
    bool lastCond = false;
    this(){
        this.data = new InputLogData;
        this.count = 0;
    }
    void record(bool cond){
        if(cond ^ this.lastCond){
            data.pushBack(count);
        }
        this.lastCond = cond;
        this.count ++;
    }
}
class InputLogPlayer{
    InputLogData data;
    int count = 0;
    int time = -1;
    bool lastCond = false;
    this(InputLogData data){
        this.data = data;
        this.count = 0;
        if(this.data.empty()){
            this.time = int.max;
        }else{
            this.time = this.data.popFront();
        }
    }
    bool play(){
        if(this.count == this.time){
            assert(this.data !is null);
            if(this.data.empty()){
                this.time = int.max;
            }else{
            try{
                this.time = this.data.popFront();
            }catch(Throwable o){
                writeln(o);
                assert(false);
            }
            }
            this.lastCond = !this.lastCond;
        }else{
            // do nothing
        }
        this.count ++;
        return this.lastCond;
    }
}
InputLogPlayer recorderToPlayer(InputLogRecorder rec){
    return new InputLogPlayer(rec.data);
}
