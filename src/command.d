module command;

import mylib.list;
import std.stdio;
import std.conv;

/// 一回分の入力
enum Com{
    attack,         /// A
    shoot,          /// B
    attack_shoot,   /// A+B
    pow_attack,     /// C+A
    forward_attack, /// →A
    back_attack,    /// ←A
}
/// 予め定められた、技を出すためのコマンド
class Command{
    Com[] _command; /// コマンド列
    int _time; /// 入力許容時間
    this(Com[] command){
        this._command = command;
    }
    string toString(){
        return to!(string)(this._command);
    }
}

/// 実際のプレイヤーの操作 一瞬
struct Op{
    bool attack = false;
    bool shoot  = false;
    bool power  = false;

    bool left   = false;
    bool right  = false;
    bool bottom = false;
    bool top    = false;
}
alias FixedList!(Op) OpList;
/// 実際のプレイヤーの操作列
class Operation{
    OpList _oplist;
    this(){
        this._oplist = new OpList(10);
        with(this._oplist){
            for(int i=0; i<10; i++){
                push_back(Op());
            }
        }
    }
    bool opIn(Command com){return false;}
    override string toString(){
        return to!(string)(_oplist);
    }
}

Command ppattack(){
    with(Com){
        Com[] cl = [pow_attack, pow_attack];
        return new Command(cl);
    }
}
void input(Operation ope){
    static const Op op1 = {attack : true, power : true};
    static const Op op2 = {attack : true, power : true};
    static const Op op3 = {};
    static const Op op4 = {attack : true, power : true};
    add(ope, op1);
    add(ope, op2);
    add(ope, op3);
    add(ope, op4);
}
void add(Operation op, Op c){
    with(op._oplist){
        assert(full, to!(string)(length));
        pop_back();
        assert(rest_length == 1);
        push_front(c);
        assert(full, to!(string)(length));
    }
}
void main(){
    Command com = ppattack();
    Operation op = new Operation;
    input(op);
    writeln(op in com);
    writeln(op);
    writeln(com);
}
