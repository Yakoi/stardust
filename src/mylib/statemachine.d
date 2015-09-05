module statemachine;


class StateMachine(S,A){
    S[] stateSet;
    A alphabetSet;
    S translate(S, A);
    S startState;
    S[] finishStateSet;
}

class TestStateMachine : StateMachine!(int, int){
    override int translate(int state, int alphabet){
        return state;
    }
}
