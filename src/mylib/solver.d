module mylib.solver;
import lp_solve.all;
import std.stdio;

alias lp_solve.lp_lib lpsol;


/// 使う？
class Solver{}
/// 不等式の種類
enum RowType : int{
    le = lpsol.LE, /// <=
    ge = lpsol.GE, /// >=
    eq = lpsol.EQ, /// =
    of = lpsol.OF, /// ?
}
/// lp_solve を使いやすくラッピング
/// 制約式の配列の0番目がダミーとかそんなのないよ
class Problem{
private:
    lprec* _lp;
    int _seiyaku;
    int _hensuu;
    bool _is_solved = false; ///解を求めたか？
public:
    /// コンストラクタ
    /// param:
    ///     solver = 使わないかも
    this(Solver solver, int seiyaku, int hensuu){
        this._lp = lpsol.make_lp ( seiyaku, hensuu );
        this._seiyaku = seiyaku;
        this._hensuu = hensuu;
    }
    this(int seiyaku, int hensuu){
        this._lp = lpsol.make_lp ( seiyaku, hensuu );
        this._seiyaku = seiyaku;
        this._hensuu = hensuu;
    }
    this(lprec* lp){
        this._lp = lp;
    }
    ~this(){
        lpsol.delete_lp(this._lp);
    }
    void add_constraint(string row_string, RowType r, double rh){
        char* str = cast(char*)std.string.toStringz(row_string);
        lpsol.str_add_constraint(this._lp, str, r, rh);
    }
    /// 制約を追加 <=
    void add_constraint_le(double[] a, double b)
    in{
        assert(a.length == this._hensuu);
        assert(this._lp !is null);
        assert(a !is null);
    }body{
        lpsol.add_constraint(this._lp, ([100.0]~a).ptr, RowType.le, b);
    }
    /// 制約を追加 >=
    void add_constraint_ge(double[] a, double b)
    in{
        assert(a.length == this._hensuu);
        assert(this._lp !is null);
        assert(a !is null);
    }body{
        this.add_constraint(a, RowType.ge, b);
    }
    /// 制約を追加 =
    void add_constraint_eq(double[] a, double b)
    in{
        assert(a.length == this._hensuu);
        assert(this._lp !is null);
        assert(a !is null);
    }body{
        this.add_constraint(a, RowType.eq, b);
    }
    /// 制約を追加
    /// deprecated:
    ///     直接呼び出すとなぜかAccess Violation
    ///     謎。
    void add_constraint(double[] a, RowType r, double b)
    in{
        assert(a.length == this._hensuu);
        assert(this._lp !is null);
        assert(a !is null);
    }body{
        lpsol.add_constraint(this._lp, ([100.0]~a).ptr, r, b);
    }
    /// 制約をまとめて追加
    /// 行列だと思えばわかりやすいか
    void add_constraint(double[][] a, RowType r, double b[])
    in{
        assert(a.length == b.length);
    }body{
        for(uint i=0; i<a.length; i++){
            this.add_constraint(a[i], r, b[i]);
        }
    }
    /// 目的関数を設定
    void maxim ( double[] c )
    in{
        assert(c.length == this._hensuu);
    }body{
        lpsol.set_obj_fn(this._lp, ([100.0]~c).ptr);
        lpsol.set_maxim ( this._lp ) ; // 最大化問題に設定
    }
    /// 最大化問題に設定
    void maxim (){
        lpsol.set_maxim (this._lp ) ; 
    }
    /// 求解
    void solve(){
        lpsol.solve( this._lp ) ;
        this._is_solved = true;
    }
    /// 目的関数値の取得
    double get_objective()
    in{
        assert(this._is_solved);
    }body{
        return lpsol.get_objective(this._lp);
    }
    /// 最適解の取得
    double[] get_variables()
    out(res){
        assert(res.length == this._hensuu);
        assert(this._is_solved);
    }body{
        double[] x;
        x.length = this._hensuu;
        lpsol.get_variables ( this._lp, x.ptr ) ;
        return x;
    }
    /// colnr番目の変数を整数として扱う
    void set_int(int colnr){
        lpsol.set_int(this._lp, colnr+1, true);
    }
    /// 全ての変数を整数として扱う
    void set_int(){
        for(uint i=0; i<this._hensuu; i++){
            this.set_int(i);
        }
    }
    /// colnr番目の変数を実数として扱う
    void set_real(int colnr){
        lpsol.set_int(this._lp, colnr+1, false);
    }
    /// 全ての変数を実数として扱う
    void set_real(){
        for(uint i=0; i<this._hensuu; i++){
            this.set_real(i);
        }
    }
    /// colnr番目の変数のバインドをなくす
    void set_unbounded(int colnr){
        lpsol.set_unbounded(this._lp, colnr+1);
    }
    /// 全ての変数のバインドをなくす
    void set_unbounded(){
        for(uint i=0; i<this._hensuu; i++){
            this.set_unbounded(i);
        }
    }
    void is_debug(bool val){
        ubyte v = val ? 1 : 0;
        lpsol.set_debug(this._lp, v);
    }
    void is_trace(bool val){
        ubyte v = val ? 1 : 0;
        lpsol.set_trace(this._lp, v);
    }

}

deprecated Problem load_lp(string path){
    FILE* data = std.c.stdio.fopen(path.ptr, "r");
    writeln(data);
    auto lp = read_lp(data, NORMAL, cast(char*)(std.string.toStringz("test model")));
    writeln(lp);
    assert(lp !is null);
    writeln(lp);
    return new Problem(lp);
}

