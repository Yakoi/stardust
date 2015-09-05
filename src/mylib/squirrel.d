module mylib.squirrel;

import squirrel.all;
import std.c.stdio;
import std.c.stdlib;
import std.c.string;
import std.c.stdarg;
import std.string;
import std.stdio;
import std.conv;
import std.windows.charset;

class SquirrelException : Exception{
    this(string str){
        super(str);
    }
}
/// Squirrelを簡単に扱うためのクラス
class Squirrel{
private:
    HSQUIRRELVM vm; // VM
public:
    this(int stackSize = 1024){
        this.vm = sq_open(stackSize);  // VMを初期スタックサイズ1024で作成
        sqstd_seterrorhandlers(this.vm);
        sq_setprintfunc(this.vm, &printfunc);
    }
    this(string code, int stackSize=1024){
        this(stackSize);
        this.doBuffer(code);
    }
    void doBuffer(string buf){
        sq_compilebuffer(this.vm, sqs(buf), buf.length,
                _SC((cast(char[])"").ptr), SQTrue);
        sq_pushroottable(this.vm);
        sq_call(this.vm, 1, SQTrue, SQTrue);
    }
    void doFile(string path){
        sq_pushroottable(this.vm);
        if(!SQ_SUCCEEDED(sqstd_dofile(vm, sqs(path), 0, 1))){
            throw new SquirrelException("mylib.squirrel.Squirrel.this");
        }
    }
    private this(string path, int stackSize, bool isBinary){
        this(stackSize);
        if(isBinary){
            assert(false);
        }else{
            this.doFile(path);
        }
    }
    
    ~this(){
        sq_close(this.vm);
    }
protected:
    void push(int n){
        sq_pushinteger(this.vm, n);
    }
    void push(double f){
        sq_pushfloat(this.vm, f);
    }
    void push(string s){
        sq_pushstring(this.vm, _SC(cast(char*)toStringz(s)), s.length);
    }
    void push(char* s, int length=-1){
        sq_pushstring(this.vm, _SC(s), length);
    }
    void push(bool b){
        sq_pushbool(this.vm, b);
    }
    void pushNull(){
        sq_pushnull(this.vm);
    }
    void pushRootTable(){
        sq_pushroottable(this.vm);
    }
    SquirrelObject pop(int index=-1){
        SquirrelObject res = get(index);
        sq_remove(this.vm, index);
        return res;
    }
    SquirrelObject get(int index=-1){
        with(tagSQObjectType)switch(sq_gettype(this.vm, index)){
            case OT_NULL:
                {
                    return new NullObject();
                }
            case OT_INTEGER:
                {
                    int res;
                    if(SQ_FAILED(sq_getinteger(this.vm, index, &res))){
                        throw new SquirrelException("Squirrel.get(integer)");
                    }
                    return new IntObject(res);
                }
            case OT_FLOAT:
                {
                    float res;
                    if(SQ_FAILED(sq_getfloat(this.vm, index, &res))){
                        throw new SquirrelException("Squirrel.get(float)");
                    }
                    return new RealObject(res);
                }
            case OT_STRING:
                {
                    char* res;
                    if(SQ_FAILED(sq_getstring(this.vm, index, &res))){
                        throw new SquirrelException("Squirrel.get(string)");
                    }
                    return new StringObject(text(res));
                }
            case OT_TABLE:
                break;
            case OT_ARRAY:
                break;
            case OT_USERDATA:
                break;
            case OT_CLOSURE:
                break;
            case OT_NATIVECLOSURE:
                break;
            case OT_GENERATOR:
                break;
            case OT_USERPOINTER:
                break;
            case OT_BOOL:
                {
                    uint res;
                    if(SQ_FAILED(sq_getbool(this.vm, index, &res))){
                        throw new SquirrelException("Squirrel.get(bool)");
                    }
                    return new BoolObject(res!=0);
                }
            case OT_INSTANCE:
                break;
            case OT_CLASS:
                break;
            case OT_WEAKREF:
                break;
            default:
                throw new SquirrelException("Squirrel.get(default)");
        }
        return null;
    }
public:
    void foo(){
        sq_pushroottable(vm);
        sq_pushstring(vm, _SC(cast(char*)toStringz("foo")), -1);
        sq_get(vm, -2);         // ルートテーブルから関数を取得
        sq_pushroottable(vm);   // 'this' (関数の環境オブジェクト)
        sq_pushinteger(vm, 1);
        sq_pushfloat(vm, 2.0);
        sq_pushstring(vm, _SC(cast(char*)toStringz("three")), -1);
        sq_call(vm, 4, SQFalse,0);
        sq_pop(vm, 2);          // ルートテーブルと関数のpop
    }
    SquirrelObject get(string str){
        this.pushRootTable();
        this.push(str);
        this.printStack();
        sq_get(vm, -2);         // ルートテーブルから取得
        this.pushRootTable();
        this.printStack();
        return this.pop(-2);
    }
    int compileFile(string filename){
        return .compileFile(this.vm, cast(char*)toStringz(filename));
    }
    private void register_(string functionName, SQFUNCTION func/+function(HSQUIRRELVM )+/) {
        this.pushRootTable();
        this.push(functionName);
        sq_newclosure(this.vm, func, 0); // 新規関数を作成
        sq_createslot(this.vm, -3); 
        sq_pop(this.vm, 1); // ルートテーブルをpop

    }
    version(none)
    static SquirrelObject function(SquirrelObject[] args ...)[string] funcTable;
    version(none)
    void register(const string functionName)(int function(SquirrelObject[] args ...) func){
        extern(C) static int f(HSQUIRRELVM v){
            SQInteger nargs = sq_gettop(v);
            SquirrelObject[] sqobjs;
            sqobjs.length = nargs;
            foreach(index; 1..nargs+1){
                sqobjs[index-1] = getSquirrelObject(v,index);
            }
            funcTable[functionName](sqobjs);
            sq_pushinteger(v, nargs);
            return 1;
        }
        if(functionName in Squirrel.funcTable){
            throw new SquirrelException("Squirrel.register");
        }
        Squirrel.funcTable[functionName] = func;
        register_(functionName, &f);

    }
    void registerFunction(const string functionName)(SquirrelObject function(SquirrelObject[] args) func){
        SquirrelObject f(SquirrelObject[] args){
            return func(args);
        }
        this.registerDelegate!(functionName)(&f);
    }
    static SquirrelObject delegate(SquirrelObject[] args)[string] dgTable;
    void registerDelegate(const string functionName)(SquirrelObject delegate(SquirrelObject[] args) func){
        extern(C) static int f(HSQUIRRELVM v){
            SQInteger nargs = sq_gettop(v);
            SquirrelObject[] sqobjs;
            sqobjs.length = nargs-1;
            foreach(index; 2..nargs+1){
                sqobjs[index-2] = getSquirrelObject(v,index);
            }
            assert(functionName in dgTable);
            SquirrelObject res = dgTable[functionName](sqobjs);
            .push(v, res);
            return 1;
        }
        if(functionName in Squirrel.dgTable){
            throw new SquirrelException("Squirrel.register");
        }
        Squirrel.dgTable[functionName] = func;
        register_(functionName, &f);

    }
    SquirrelObject call(string name, SquirrelObject[] args...){
        int top = sq_gettop(this.vm); //スタックのサイズを記憶しておく
        this.pushRootTable();   // 'this' (関数の環境オブジェクト)
        this.push(name);  //関数名をスタックに積む
        if(SQ_FAILED(sq_get(vm, -2))){         // ルートテーブルから関数を取得
            assert(false);
        }
        sq_pushroottable(vm);   

        //引数の数チェック
        uint n; // 引数の数
        uint fn;// 自由変数の数
        sq_getclosureinfo(this.vm, -2, &n, &fn);
        if(args.length != n-1){
            writeln(n,"-",fn);
            throw new SquirrelException("Squirrel.call");
        }


        //引数をスタックにプッシュ
        foreach(arg; args){
            .push(this.vm, arg);
        }
        if(SQ_FAILED(sq_call(vm, args.length+1, SQTrue,0))){
            throw new SquirrelException("Squirrel.call");
        }
        SquirrelObject res = this.pop();
        sq_pop(vm, 2);          // ルートテーブルと関数のpop


        sq_settop(this.vm, top);
        return res;
    }
    void printStack(string s=""){
        writeln("-------------",s,"---------------");
        try{
            for(int i=0; true; i++){
                writeln(-i-1, " : ", this.get(-i-1));
            }
        }catch(SquirrelException e){
        }
    }
}
Squirrel loadSquirrel(string path, int stack_size=1024){
    return new Squirrel(path, stack_size, false);
}
extern(C)
SQInteger file_lexfeedASCII(SQUserPointer file) {
    int ret;
    char c;
    ret = fread(&c, c.sizeof, 1, cast(FILE *)file );
    if( ( ret > 0) )
        return c;
    return 0;
}


private int compileFile(HSQUIRRELVM v, char* filename) {
    FILE* f = fopen(filename, "rb");
    if (f) {
        sq_compile(v, &file_lexfeedASCII, cast(void*)f, _SC(filename), 1);
        fclose(f);
        return 1;
    }
    return 0;
}


extern(C)void printfunc(HSQUIRRELVM v, const SQChar* s, ...)
{
     va_list arglist;
     va_start(arglist, s);
     vprintf(cast(const char *)s, arglist);
     va_end(arglist);
}
private static void push(HSQUIRRELVM vm, SquirrelObject sqo){
    with(SquirrelType)final switch(sqo.type){
        case INTEGER:
            sq_pushinteger(vm, sqo.i);
            break;
        case REAL:
            sq_pushfloat(vm, sqo.r);
            break;
        case STRING:
            sq_pushstring(vm, sqs(sqo.s), -1);
            break;
        case BOOL:
            sq_pushbool(vm,sqo.b);
            break;
        case NULL:
            sq_pushnull(vm);
            break;

    }
}
/// ゲット！
private static SquirrelObject getSquirrelObject(HSQUIRRELVM vm, int index=-1){
    with(tagSQObjectType)switch(sq_gettype(vm, index)){
        case OT_NULL:
            {
                return new NullObject();
            }
        case OT_INTEGER:
            {
                int res;
                if(SQ_FAILED(sq_getinteger(vm, index, &res))){
                    throw new SquirrelException("Squirrel.get(integer)");
                }
                return new IntObject(res);
            }
        case OT_FLOAT:
            {
                float res;
                if(SQ_FAILED(sq_getfloat(vm, index, &res))){
                    throw new SquirrelException("Squirrel.get(float)");
                }
                return new RealObject(res);
            }
        case OT_STRING:
            {
                char* res;
                if(SQ_FAILED(sq_getstring(vm, index, &res))){
                    throw new SquirrelException("Squirrel.get(string)");
                }
                return new StringObject(text(res));
            }
        case OT_TABLE:
            throw new SquirrelException("Squirrel.get(table) is not created");
            //break;
        case OT_ARRAY:
            throw new SquirrelException("Squirrel.get(array) is not created");
            break;
        case OT_USERDATA:
            throw new SquirrelException("Squirrel.get(userdata) is not created");
            break;
        case OT_CLOSURE:
            throw new SquirrelException("Squirrel.get(closure) is not created");
            break;
        case OT_NATIVECLOSURE:
            throw new SquirrelException("Squirrel.get(nativeclosure) is not created");
            break;
        case OT_GENERATOR:
            throw new SquirrelException("Squirrel.get(generator) is not created");
            break;
        case OT_USERPOINTER:
            throw new SquirrelException("Squirrel.get(userpointer) is not created");
            break;
        case OT_BOOL:
            {
                uint res;
                if(SQ_FAILED(sq_getbool(vm, index, &res))){
                    throw new SquirrelException("Squirrel.get(bool)");
                }
                return new BoolObject(res!=0);
            }
        case OT_INSTANCE:
            throw new SquirrelException("Squirrel.get(instance) is not created");
            break;
        case OT_CLASS:
            throw new SquirrelException("Squirrel.get(class) is not created");
            break;
        case OT_WEAKREF:
            throw new SquirrelException("Squirrel.get(weakref) is not created");
            break;
        default:
            throw new SquirrelException("Squirrel.get(default)");
    }
    return null;
}

enum SquirrelType{
    INTEGER,
    STRING,
    REAL,
    BOOL,
    NULL,
}
class SquirrelObjectAccessException : SquirrelException{
    this(string str){
        super(str);
    }
}
class SquirrelObject{
    const int i(){
        throw new SquirrelObjectAccessException("SquirrelObject.i");
    }
    const double r(){
        throw new SquirrelObjectAccessException("SquirrelObject.r");
    }
    const string s(){
        throw new SquirrelObjectAccessException("SquirrelObject.s");
    }
    const bool b(){
        throw new SquirrelObjectAccessException("SquirrelObject.b");
    }
    abstract SquirrelType type();
    const abstract override string toString();
}
template SquirrelObjectTemplate(T){
private:
    const T value;
public:
    this(T value){
        this.value = value;
    }
}
class IntObject : SquirrelObject{
    mixin SquirrelObjectTemplate!(int);
public:
    const pure nothrow override SquirrelType type(){
        return SquirrelType.INTEGER;
    }
    const pure nothrow override int i(){
        return this.value;
    }
    const override string toString(){
        return text(this.i);
    }
}
class RealObject : SquirrelObject{
    mixin SquirrelObjectTemplate!(double);
public:
    const pure nothrow override SquirrelType type(){
        return SquirrelType.REAL;
    }
    const pure nothrow override double r(){
        return this.value;
    }
    const override string toString(){
        return text(this.r);
    }
}
class StringObject : SquirrelObject{
    mixin SquirrelObjectTemplate!(string);
public:
    const pure nothrow override SquirrelType type(){
        return SquirrelType.STRING;
    }
    const pure nothrow override string s(){
        return this.value;
    }
    const pure nothrow override string toString(){
        return this.s;
    }
}

class BoolObject : SquirrelObject{
    mixin SquirrelObjectTemplate!(bool);
public:
    const pure nothrow override SquirrelType type(){
        return SquirrelType.BOOL;
    }
    const pure nothrow override bool b(){
        return this.value;
    }
    const override string toString(){
        return text(this.b);
    }
}
class NullObject : SquirrelObject{
    this(){}
public:
    const pure nothrow override SquirrelType type(){
        return SquirrelType.NULL;
    }
    const override string toString(){
        return "null";
    }
}
SquirrelObject sqv(int n){
    return new IntObject(n);
}
SquirrelObject sqv(double n){
    return new RealObject(n);
}
SquirrelObject sqv(string n){
    return new StringObject(n);
}
SquirrelObject sqv(bool n){
    return new BoolObject(n);
}
SquirrelObject sqnull(){
    return new NullObject();
}

char* sqs(string str){
    return _SC(cast(char*)toStringz(str));
}
