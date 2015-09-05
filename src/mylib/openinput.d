module mylib.openinput;

import openinput.all;

class OpenInput{
    this(){
        oi_init();
    }
    ~this(){
        oi_close();
    }
}
