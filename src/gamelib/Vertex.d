module gamelib.vertex;

import gamelib.all;
import dxlib.all;

struct Vertex{
    Color color;
    Vector vector;
    VERTEX dx_vertex(){
        return VERTEX(vector.x, vector.y, 0,0, color.blue256, color.green256, color.red256, color.alpha256);
    }
    
}
