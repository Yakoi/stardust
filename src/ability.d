module ability;

import all;

const class Ability{
    const string name;
    const int cost;
    const AbilityType type;
    this(string name, int cost, AbilityType type){
        this.name = name;
        this.cost = cost;
        this.type = type;
    }
}


class TapAbility : Ability{
    this(){
        super("tap", 0, AbilityType.TAP);
    }
}
class DashAbility : Ability{
    this(){
        super("dash", 0, AbilityType.DASH);
    }
}
