module camera;
import gameall;

/// バネでついて来るカメラ
class Camera : Position{
    mixin PositionReadWriteTemplate;
protected:
    Vector _vel;
public:
    double k = 1.0; ///ばね定数
    double f = 0.04; ///摩擦係数
    double ar = 0.9; ///空気抵抗
    double movemin = 0.1; /// カメラの最低移動距離 これより小さい場合は位置を固定する
    this(Vector pos, double k = 1.0,
            double f = 0.04, double ar = 0.9, double movemin = 0.3){
        this.pos = pos;
        this.k = k;
        this.f = f;
        this.ar = ar;
        this.movemin = movemin;
    }
    this(double x, double y, double k = 1.0,
            double f = 0.04, double ar = 0.9){
        this(vecpos(x,y), k, f, ar);
    }
    void move(Vector pos){
        Vector acc = k*(pos - this.pos);
        version(none){
            this._vel = physical_move_vel(this._vel, acc, f, ar);
            this.pos = this.pos + this._vel;
            if((this.pos - pos).length2 < movemin){
                this.pos = pos;
            }
        }
        version(none){
            //movemin test
            writeln(this.y);
        }
        physical_move_ref(this._pos, pos, this._vel, acc, f, ar, movemin);
    }
}
Camera fast_camera(Vector pos){
    auto camera = new Camera(pos);
    camera.k = 2.2;
    camera.movemin = 0.1;
    return camera;
}
