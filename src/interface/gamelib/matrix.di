// D import file generated from 'gamelib\matrix.d'
module gamelib.matrix;
import gamelib.all;
import dxlib.all;
struct Matrix
{
    MATRIX dxmat;
    float get(int i, int j)
{
return dxmat.m[j][i];
}
    float opIndex(int i, int j)
{
return get(j,i);
}
    Matrix opMul(Matrix mat2)
{
Matrix res;
dx_CreateMultiplyMatrix(&res.dxmat,&this.dxmat,&mat2.dxmat);
return res;
}
    Matrix opMul(float val);
    void write();
    string toString();
}
void test()
{
Matrix m1;
dx_CreateRotationZMatrix(&m1.dxmat,3.14 / 2);
writeln(m1 * m1);
}
