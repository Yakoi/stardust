module gamelib.dxlibdrawer;
import gamelib.all;
import mylib.matrix;
import dxlib.all;


/// カメラ
class Camera{
    this(Rect rect){
        this.rect = rect;
        this.center = rect.center;
        this.dir   = 0.0;
        this.rotx  = 0.0;
        this.roty  = 0.0;
        this.scale = 1.0;
        this.dist = max(rect.width, rect.height);
        this.usesRot = false;
    }
    Rect rect;
    IntVector2d center;
    double dir   = 0.0;
    double rotx  = 0.0;
    double roty  = 0.0;
    double scale = 1.0;
    double dist = 1.0;
    bool usesRot = false;
    const pure Matrix2d makeMatrix(in Vector pos){
        if(this.usesRot){
            return matrot(this.dir)*matscale(this.scale) * this.rotPositionMatrix(pos.x,pos.y);
        }else{
            return matrot(this.dir)*matscale(this.scale);
        }

    }
    const pure Vector mapPosition(in Vector vec){
        immutable Vector movedPos = vec - this.center;
        return this.makeMatrix(movedPos)*movedPos+this.center;
    }
    const pure Vector mapPosition(in double x, in double y){
        return this.mapPosition(vecpos(x,y));
    }
    const pure Matrix2d rotPositionMatrix(in double x, in double y){
        return this.rotxPositionMatrix(x,y) * this.rotyPositionMatrix(x,y);
    }
    const pure Matrix2d rotxPositionMatrix(in double x, in double y){
        immutable double z = 0;
        immutable double x2 = x;
        immutable double y2 =  y*cos(this.rotx);
        immutable double z2 = -y*sin(this.rotx);
        return matscale(this.dist/(this.dist+z2)) * mat(1,0,0,cos(this.rotx));
    }
    const pure Matrix2d rotyPositionMatrix(in double x, in double y){
        immutable double z = 0;
        immutable double x2 =  x*cos(this.roty);
        immutable double y2 =  y;
        immutable double z2 = -x*sin(this.roty);
        return matscale(this.dist/(this.dist+z2)) * mat(cos(this.roty),0,0,1);
    }
    alias mapPosition mp ;
}

class DxlibDrawer{
    Camera camera;
    DrawableSurfaceInterface screen;
    DrawMode drawMode;
    this(DrawableSurfaceInterface screen, Camera camera){
        this.camera = camera;
        this.screen = screen;
        //writeln(screen);
        SetCameraDotAspect(0.5);
        this.drawMode = DrawMode.BILINEAR;
    }
    this(DrawableSurfaceInterface screen){
        this(screen, new Camera(createRect(0,0,320,240)));
    }
    this(DrawableSurfaceInterface screen, in int w, in int h){
        this(screen, new Camera(Rect(0,0,w,h)));
    }
    /// 塗りつぶす
    /// カメラの影響を受けない
    bool fill(Color color,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255))
    in{
        assert(blendParam >= 0);
        assert(blendParam < 256);
    }body{
        SetDrawBlendMode(blendMode, blendParam);
        SetDrawBright(bright.red, bright.green, bright.blue);
        SetDrawScreen(this.screen.dxhandle);
        SetDrawMode(this.drawMode);
        return 0==dx_DrawBox(camera.rect.left, camera.rect.top, camera.rect.right, camera.rect.bottom, color.dxColor, true);
    }
    /// 矩形を描画する
    bool box(Color color, int x1, int y1, int x2, int y2, bool isFill=false,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255))
    in{
        assert(blendParam >= 0);
        assert(blendParam < 256);
    }body{
        SetDrawBlendMode(blendMode, blendParam);
        SetDrawBright(bright.red, bright.green, bright.blue);
        SetDrawScreen(this.screen.dxhandle);
        SetDrawMode(this.drawMode);
        Vector p1 = camera.mp(x1,y1);
        Vector p2 = camera.mp(x2,y2);
        return 0==dx_DrawBox(cast(int)p1.x, cast(int)p1.y, cast(int)p2.x, cast(int)p2.y, color.dxColor, isFill);
    }
    /// 線を描画する
    bool line(Color color, double x1, double y1, double x2, double y2, double thickness=1,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255))
    in{
        assert(blendParam >= 0);
        assert(blendParam < 256);
    }body{
        SetDrawBlendMode(blendMode, blendParam);
        SetDrawBright(bright.red, bright.green, bright.blue);
        SetDrawScreen(this.screen.dxhandle);
        SetDrawMode(this.drawMode);
        Vector v1 = this.camera.mapPosition(x1, y1);
        Vector v2 = this.camera.mapPosition(x2, y2);
        return 0==dx_DrawLine(cast(int)v1.x, cast(int)v1.y, cast(int)v2.x, cast(int)v2.y, color.dxColor, cast(int)(thickness*camera.scale)) ;    // 線を描画
    }
    bool circle(Color color, double x, double y, double r, bool isFill=false,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255))
    in{
        assert(blendParam >= 0, text(blendParam));
        assert(blendParam < 256, text(blendParam));
    }body{
        dx_SetDrawBlendMode(blendMode, blendParam);
        dx_SetDrawBright(bright.red, bright.green, bright.blue);
        SetDrawScreen(this.screen.dxhandle);
        SetDrawMode(this.drawMode);
        Vector v = this.camera.mapPosition(x, y);
        return 0==dx_DrawCircle( cast(int)v.x, cast(int)v.y, cast(int)(r*this.camera.scale), color.dxColor, isFill ) ;    // 円を描く
    }
    bool oval(Color color, int x, int y, int rx, int ry, bool isFill=false,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255))
    in{
        assert(blendParam >= 0);
        assert(blendParam < 256);
    }body{
        dx_SetDrawBlendMode(blendMode, blendParam);
        dx_SetDrawBright(bright.red, bright.green, bright.blue);
        SetDrawScreen(this.screen.dxhandle);
        SetDrawMode(this.drawMode);
        return 0==dx_DrawOval( x, y, rx, ry, color.dxColor, isFill) ;    // 楕円を描く
    }
    bool triangle(Color color, double x1, double y1, double x2, double y2,
            double x3, double y3, bool isFill = false,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255))
    in{
        assert(blendParam >= 0);
        assert(blendParam < 256);
    }body{
        dx_SetDrawBlendMode(blendMode, blendParam);
        dx_SetDrawBright(bright.red, bright.green, bright.blue);
        SetDrawScreen(this.screen.dxhandle);
        SetDrawMode(this.drawMode);
        Vector v1 = this.camera.mapPosition(x1, y1);
        Vector v2 = this.camera.mapPosition(x2, y2);
        Vector v3 = this.camera.mapPosition(x3, y3);
        return 0==dx_DrawTriangle( cast(int)v1.x, cast(int)v1.y,cast(int)v2.x, cast(int)v2.y,cast(int)v3.x, cast(int)v3.y, color.dxColor, isFill) ;    // 三角形の描画
    }
    bool point(Color color, int x, int y,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255))
    in{
        assert(blendParam >= 0);
        assert(blendParam < 256);
    }body{
        dx_SetDrawBlendMode(blendMode, blendParam);
        dx_SetDrawBright(bright.red, bright.green, bright.blue);
        SetDrawScreen(this.screen.dxhandle);
        SetDrawMode(this.drawMode);
        Vector v = this.camera.mapPosition(x, y);
        return 0==dx_DrawPixel( cast(int)v.x, cast(int)v.y, color.dxColor ) ;    // 点を描画する
    }
    bool dx_graph(int GrHandle, int x, int y, bool isTranslate, 
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255))
    in{
        assert(blendParam >= 0);
        assert(blendParam < 256);
    }body{
        SetDrawBlendMode(blendMode, blendParam);
        SetDrawBright(bright.red, bright.green, bright.blue);
        SetDrawScreen(this.screen.dxhandle);
        SetDrawMode(this.drawMode);
        return 0==dx_DrawGraph(x, y, GrHandle, isTranslate); // グラフィックの描画
    }
    ///ポリゴン描画
    bool polygon(Surface surface, Vertex[] vertexArray, bool isFill,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,

            Color bright = col(255,255,255))
    in{
        assert(blendParam >= 0);
        assert(blendParam < 256);
        assert(vertexArray.length < 64);
    }body{
        dx_SetDrawBlendMode(blendMode, blendParam);
        dx_SetDrawBright(bright.red, bright.green, bright.blue);
        SetDrawScreen(this.screen.dxhandle);
        SetDrawMode(this.drawMode);
        if(blendMode == BlendMode.NOBLEND){blendMode = BlendMode.ALPHA; blendParam = 255;}
        VERTEX[64] dxlibVertexArray;
        foreach(i,v; vertexArray){
            Vector nv = this.camera.mapPosition(v.vector);
            dxlibVertexArray[i].x = nv.x;
            dxlibVertexArray[i].y = nv.y;
            dxlibVertexArray[i].r = v.color.red256;
            dxlibVertexArray[i].g = v.color.green256;
            dxlibVertexArray[i].b = v.color.blue256;
            dxlibVertexArray[i].a = v.color.alpha256;
        }
        dxlibVertexArray[vertexArray.length] = dxlibVertexArray[0]; //最後の点を最初の点と同じにすることで、図形を閉じる
        dx_SetDrawBlendMode(BlendMode.ALPHA, blendParam);
        //dx_SetDrawBright(bright.red, bright.green, bright.blue);
        if(surface !is null){
            return 0==dx_DrawPolygonBase( dxlibVertexArray.ptr, vertexArray.length, 6, 
                    surface.dxhandle, false) ;    // ２Ｄポリゴンを描画する
        }else{
            if(isFill){
                return 0==dx_DrawPolygonBase( dxlibVertexArray.ptr, vertexArray.length, 6, 
                        DX_NONE_GRAPH, true, true) ;    // ２Ｄポリゴンを描画する
            }else{
                return 0==dx_DrawPolygonBase( dxlibVertexArray.ptr, vertexArray.length+1, DX_PRIMTYPE_LINESTRIP  , 
                        DX_NONE_GRAPH, true, true) ;    // ２Ｄポリゴンを描画する
            }
        }
    }
}
