module gamelib.matrix;
import gamelib.all;
import dxlib.all;

///dxlibのmatrix
version(none)
struct Matrix{
    MATRIX dxmat;
    float get(int i, int j){
        return dxmat.m[j][i];
    }
    float opIndex(int i, int j){
        return get(j,i);
    }


    Matrix opMul(Matrix mat2){
        Matrix res;
        dx_CreateMultiplyMatrix( &res.dxmat, &this.dxmat, &mat2.dxmat ) ;                                // 行列の積を求める
        return res;
    }
    Matrix opMul(float val){
        Matrix res;
        static assert(true);
        return res*this;
    }
    void write(){
        foreach(i; 0..this.dxmat.m.length){
            foreach(j; 0..this.dxmat.m[i].length){
                writeln(this.get(i,j));
            }
        }
    }
    string toString(){
        string res="";
        foreach(i; 0..this.dxmat.m.length){
            res ~= "| ";
            foreach(j; 0..this.dxmat.m[i].length){
                res ~= text(this.get(i,j));
                res ~= ",";
            }
            res ~= " |\n";
        }
        return res;
    }
}
version(none)
void test(){
    Matrix m1;
    dx_CreateRotationZMatrix(&m1.dxmat, 3.14/2);
    writeln(m1*m1);
}
    //int dx_CreateIdentityMatrix( MATRIX *Out ) ;                                                        // 単位行列を作成する
    //int dx_CreateMultiplyMatrix( MATRIX *Out, MATRIX *In1, MATRIX *In2 ) ;                                // 行列の積を求める
    //int dx_CreateScalingMatrix( MATRIX *Out, float sx, float sy, float sz ) ;                            // スケーリング行列を作成する
    //int dx_CreateRotationZMatrix( MATRIX *Out, float Angle ) ;                                            // Ｚ軸を中心とした回転行列を作成する
    //int dx_CreateTranslationMatrix( MATRIX *Out, float x, float y, float z ) ;                            // 平行移動行列を作成する
    //int dx_CreateViewportMatrix( MATRIX *Out, float CenterX, float CenterY, float Width, float Height ) ; // ビューポート行列を作成する
