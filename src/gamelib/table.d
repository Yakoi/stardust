module gamelib.table;
import gamelib.all;

version(none)
abstract class Table(T){
protected:
    T[string] data ;
public:
    this(){}
    void add(string key, T val){
        this.data[key] = val;
    }
    /// foreach用
    int opApply(int delegate(ref T) dg){
        foreach(ref d; this.data){
            int res = dg(d);
            if(res != 0){return res;}
        }
        return 0;
    }
    /// foreach用
    int opApply(int delegate(string, ref T) dg){
        foreach(s,ref d; this.data){
            int res = dg(s,d);
            if(res != 0){return res;}
        }
        return 0;
    }
    version(none){
    /// foreach_reverse用
    int opApplyReverse(int delegate(ref T) dg){
        foreach(ref d; this.data){
            int res = dg(d);
            if(res != 0){return res;}
        }
        return 0;
    }
    /// foreach_reverse用
    int opApplyReverse(int delegate(string, ref T) dg){
        foreach(s,ref d; this.data){
            int res = dg(s,d);
            if(res != 0){return res;}
        }
        return 0;
    }
    }
}

