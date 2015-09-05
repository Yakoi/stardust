module gamelib.drawer;

import std.c.windows.windows;
import dxlib.all;
import gamelib.all;
import std.stdio;
import std.c.stdlib;
import std.c.locale;
import std.conv;
import std.math;
/// ブレンドモード
enum BlendMode{
    NOBLEND      = DX_BLENDMODE_NOBLEND,      ///ブレンドなし
    ALPHA        = DX_BLENDMODE_ALPHA,        ///αブレンド
    ADD          = DX_BLENDMODE_ADD,          ///加算合成
    SUB          = DX_BLENDMODE_SUB,          /// 減算合成
  //MUL          = DX_BLENDMODE_MUL,
    MUL          = DX_BLENDMODE_MULA,         /// アルファチャンネル考慮付き乗算ブレンド
    SUB2         = DX_BLENDMODE_SUB2,         /// 内部処理用減算ブレンド子１
    //BLINEALPHA   = DX_BLENDMODE_BLINEALPHA,   /// 境界線ぼかし
    XOR          = DX_BLENDMODE_XOR,          /// XORブレンド
    DESTCOLOR    = DX_BLENDMODE_DESTCOLOR,    /// カラーは更新されない
    INVDESTCOLOR = DX_BLENDMODE_INVDESTCOLOR, /// 描画先の色の反転値を掛ける
    INVSRC       = DX_BLENDMODE_INVSRC,       /// 描画元の色を反転する
  //MUL A        = DX_BLENDMODE_MULA,         /// アルファチャンネル考慮付き乗算ブレンド
    MULA         = DX_BLENDMODE_MULA,         /// アルファチャンネル考慮付き乗算ブレンド
}
/// 拡大縮小時のぼかし方
enum DrawMode{
    nearest  = DX_DRAWMODE_NEAREST,  /// ネアレストネイバー法で描画
    bilinear = DX_DRAWMODE_BILINEAR, /// バイリニア法で描画する
}

/// Drawする人
class Drawer{
private:
    bool drawFloat = !true;
    Screen _screen;
package:
    this(Screen screen){
        this.drawMode = DrawMode.nearest;
        this.drawFloat = !true;
        this._screen = screen;
    }
public:

    Screen screen(){return this._screen;}
    bool drawMode(DrawMode val){
        return 0==dx_SetDrawMode(val);
    }
    DrawMode drawMode(){
        int drawMode = dx_GetDrawMode();
        DrawMode res;
        switch(drawMode){
            case DX_DRAWMODE_NEAREST:
                res = DrawMode.nearest;
                break;
            case DX_DRAWMODE_BILINEAR:
                res = DrawMode.bilinear;
                break;
            default:
                assert(false);
        }
        return res;
    }
    void flip(){
        // 裏画面の内容を表画面に反映
        dx_ScreenFlip();
    }
    void clear(){
        //dx_ClearDrawScreen();
        this.fill(BLACK);
    }
    bool rect(Color color, Rect rect, bool isFill = false,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255))
    in{
        assert(blendParam >= 0 , to!(string)(blendParam));
        assert(blendParam < 256 , to!(string)(blendParam));
    }body{
        return this.box(color, rect.left, rect.top, rect.right, rect.bottom,
                isFill, blendMode, blendParam, bright);
    }
    bool rect(Color color, Rectangle rect, bool isFill = false,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255))
    in{
        assert(blendParam >= 0 , to!(string)(blendParam));
        assert(blendParam < 256 , to!(string)(blendParam));
    }body{
        return this.box(color, cast(int)rect.left, cast(int)rect.top, cast(int)rect.right, cast(int)rect.bottom,
                isFill, blendMode, blendParam, bright);
    }
    bool rect(Color color, int l, int t, uint w, uint h, bool isFill = false,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255))
    in{
        assert(blendParam >= 0);
        assert(blendParam < 256);
    }body{
        return this.box(color, l, t, l+w, t+h, isFill, blendMode, blendParam, bright);
    }

    bool box(Color color, int x1, int y1, int x2, int y2, bool isFill=false,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255))
    in{
        assert(blendParam >= 0);
        assert(blendParam < 256);
    }body{
        dx_SetDrawBlendMode(blendMode, blendParam);
        dx_SetDrawBright(bright.red, bright.green, bright.blue);
        return 0==dx_DrawBox(x1, y1, x2, y2, color.dxColor, isFill);
    }
    bool line(Color color, int x1, int y1, int x2, int y2, int thickness=1,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255))
    in{
        assert(blendParam >= 0);
        assert(blendParam < 256);
    }body{
        dx_SetDrawBlendMode(blendMode, blendParam);
        dx_SetDrawBright(bright.red, bright.green, bright.blue);
        return 0==dx_DrawLine(x1, y1, x2, y2, color.dxColor, thickness) ;    // 線を描画
    }
    bool line(Color color, double x1, double y1, double x2, double y2, int thickness=1,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255))
    in{
        assert(blendParam >= 0);
        assert(blendParam < 256);
    }body{
        return line(color, cast(int)x1, cast(int)y1, cast(int)x2, cast(int)y2, thickness,
                blendMode, blendParam, bright);
    }
    bool line(Color color, IntVector pos1, IntVector pos2, int thickness=1,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255))
    in{
        assert(blendParam >= 0, text(blendParam));
        assert(blendParam < 256, text(blendParam));
    }body{
        dx_SetDrawBlendMode(blendMode, blendParam);
        dx_SetDrawBright(bright.red, bright.green, bright.blue);
        return 0==dx_DrawLine(pos1.x, pos1.y, pos2.x, pos2.y, color.dxColor, thickness) ;    // 線を描画
    }
    bool line(Color color, Vector pos1, Vector pos2, int thickness=1,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255))
    in{
        assert(blendParam >= 0, text(blendParam));
        assert(blendParam < 256, text(blendParam));
    }body{
        dx_SetDrawBlendMode(blendMode, blendParam);
        dx_SetDrawBright(bright.red, bright.green, bright.blue);
        return 0==dx_DrawLine(cast(int)pos1.x, cast(int)pos1.y, cast(int)pos2.x, cast(int)pos2.y, color.dxColor, thickness) ;    // 線を描画
    }
    bool circle(Color color, Vector pos, int r, bool isFill=false,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255))
    in{
        assert(blendParam >= 0, text(blendParam));
        assert(blendParam < 256, text(blendParam));
    }body{
        return this.circle(color, cast(int)pos.x, cast(int)pos.y, r, isFill, blendMode, blendParam, bright);
    }
    bool circle(Color color, Vector pos, double r, bool isFill=false,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255))
    in{
        assert(blendParam >= 0, text(blendParam));
        assert(blendParam < 256, text(blendParam));
    }body{
        return this.circle(color, cast(int)pos.x, cast(int)pos.y, cast(int)r, isFill, blendMode, blendParam, bright);
    }
    bool circle(Color color, IntVector pos, int r, bool isFill=false,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255))
    in{
        assert(blendParam >= 0, text(blendParam));
        assert(blendParam < 256, text(blendParam));
    }body{
        return this.circle(color, pos.x, pos.y, r, isFill, blendMode, blendParam, bright);
    }
    bool circle(Color color, int x, int y, int r, bool isFill=false,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255))
    in{
        assert(blendParam >= 0, text(blendParam));
        assert(blendParam < 256, text(blendParam));
    }body{
        dx_SetDrawBlendMode(blendMode, blendParam);
        dx_SetDrawBright(bright.red, bright.green, bright.blue);
        return 0==dx_DrawCircle( x, y, r, color.dxColor, isFill ) ;    // 円を描く
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
        return 0==dx_DrawOval( x, y, rx, ry, color.dxColor, isFill) ;    // 楕円を描く
    }
    bool triangle(Color color, int x1, int y1, int x2, int y2,
            int x3, int y3, bool isFill = false,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255))
    in{
        assert(blendParam >= 0);
        assert(blendParam < 256);
    }body{
        dx_SetDrawBlendMode(blendMode, blendParam);
        dx_SetDrawBright(bright.red, bright.green, bright.blue);
        return 0==dx_DrawTriangle( x1, y1, x2, y2, x3, y3, color.dxColor, isFill) ;    // 三角形の描画
    }
    bool triangle(Color color, IntVector pos1, IntVector pos2, IntVector pos3,
            bool isFill = false,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255))
    in{
        assert(blendParam >= 0);
        assert(blendParam < 256);
    }body{
        dx_SetDrawBlendMode(blendMode, blendParam);
        dx_SetDrawBright(bright.red, bright.green, bright.blue);
        return 0==dx_DrawTriangle( pos1.x, pos1.y, pos2.x, pos2.y, pos3.x, pos3.y, color.dxColor, isFill) ;    // 三角形の描画
    }
    bool triangle(Color color, Vector pos1, Vector pos2, Vector pos3,
            bool isFill = false,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255))
    in{
        assert(blendParam >= 0);
        assert(blendParam < 256);
    }body{
        dx_SetDrawBlendMode(blendMode, blendParam);
        dx_SetDrawBright(bright.red, bright.green, bright.blue);
        return 0==dx_DrawTriangle(cast(int)pos1.x, cast(int)pos1.y, cast(int)pos2.x, cast(int)pos2.y, cast(int)pos3.x, cast(int)pos3.y, color.dxColor, isFill) ;    // 三角形の描画
    }
    bool point(Color color, IntVector pos,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255))
    in{
        assert(blendParam >= 0);
        assert(blendParam < 256);
    }body{
        dx_SetDrawBlendMode(blendMode, blendParam);
        dx_SetDrawBright(bright.red, bright.green, bright.blue);
        return 0==dx_DrawPixel( pos.x, pos.y, color.dxColor ) ;    // 点を描画する
    }

    bool fill(Color color,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255))
    in{
        assert(blendParam >= 0);
        assert(blendParam < 256);
    }body{
        return this.rect(color, 0, 0, this.screen.width, this.screen.height, true, blendMode, blendParam, bright);
    }

    /// ポリゴン描画
    /+
    bool polygon(Surface surface, Vertex[] vertexArray,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255))
    in{
        assert(blendParam >= 0);
        assert(blendParam < 256);
    }body{
        return polygon(surface, vertexArray.ptr, vertexArray.length,
            blendMode, blendParam, bright );
    }
    +/
    ///ポリゴン描画
    bool polygon(Surface surface, VERTEX* vertexArray, int vertex_num,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255))
    in{
        assert(blendParam >= 0);
        assert(blendParam < 256);
    }body{
        if(blendMode == BlendMode.NOBLEND){blendMode = BlendMode.ALPHA; blendParam = 255;}
        dx_SetDrawBlendMode(BlendMode.ALPHA, blendParam);
        dx_SetDrawBright(bright.red, bright.green, bright.blue);
        dx_DrawPolygonBase( vertexArray, vertex_num, 6, 
                surface.dxhandle, true) ;    // ２Ｄポリゴンを描画する
        return true;
    }
    /// ポリゴン描画
    bool polygon(Surface surface, VERTEX[] vertexArray,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255))
    in{
        assert(blendParam >= 0);
        assert(blendParam < 256);
    }body{
        return polygon(surface, vertexArray.ptr, vertexArray.length,
            blendMode, blendParam, bright );
    }
    /// ポリゴン描画
    bool polygon(Surface surface, Vector[] vector_array, Color[] color_array,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255))
    in{
        assert(blendParam >= 0);
        assert(blendParam < 256);
        assert(vector_array.length < 64);
        assert(color_array.length < 64);
        assert(color_array.length == vector_array.length);
    }body{
        VERTEX[64] vertexArray;
        foreach(i,vec; vector_array){
            vertexArray[i].x = vec.x;
            vertexArray[i].y = vec.y;
        }
        foreach(i,col; color_array){
            vertexArray[i].r = col.red256;
            vertexArray[i].g = col.green256;
            vertexArray[i].b = col.blue256;
        }
        return polygon(surface, vertexArray.ptr, vector_array.length,
            blendMode, blendParam, bright);
    }

    bool polygon_(Color color, IntVector[] vector_array, bool isFill,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255))
    in{
        assert(blendParam >= 0);
        assert(blendParam < 256);
    }body{
        if(isFill){
            for(uint i=1; i<vector_array.length - 1; i++){
                this.triangle(color,
                        vector_array[0  ],
                        vector_array[i  ],
                        vector_array[i+1],
                         true, blendMode, blendParam, bright ) ;                                            // 三角形の描画
            }
            //this.triangle(color, vector_array[0  ], vector_array[$-1], vector_array[1  ],
            //         true, blendMode, blendParam, bright ) ;                                            // 三角形の描画
            return true;
        }else{
            for(uint i=0; i<vector_array.length - 1; i++){
                this.line(color, vector_array[i  ], vector_array[i+1], 1, blendMode, blendParam, bright) ;                                            // 三角形の描画
            }
            this.line(color, vector_array[$-1], vector_array[0  ], 1, blendMode, blendParam, bright ) ;                                            // 三角形の描画
            return true;
        }
    }
    bool polygon(Color color, Vector[] vector_array, bool isFill,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255))
    in{
        assert(blendParam >= 0);
        assert(blendParam < 256);
    }body{
        if(isFill){
            for(uint i=1; i<vector_array.length - 1; i++){
                this.triangle(color, vector_array[0  ], vector_array[i  ], vector_array[i+1],
                         true, blendMode, blendParam, bright ) ;                                            // 三角形の描画
            }
            //this.triangle(color, vector_array[0  ], vector_array[$-1], vector_array[1  ],
            //         !true, blendMode, blendParam, bright ) ;                                            // 三角形の描画
            return true;
        }else{
            for(uint i=0; i<vector_array.length - 1; i++){
                this.line(color, vector_array[i  ], vector_array[i+1],1, blendMode, blendParam, bright) ;                                            // 三角形の描画
            }
            this.line(color, vector_array[$-1], vector_array[0  ],1 , blendMode, blendParam, bright) ;                                            // 三角形の描画
            return true;
        }
    }
    bool dx_graph(int GrHandle, int x, int y, bool isTranslate, 
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255))
    in{
        assert(blendParam >= 0);
        assert(blendParam < 256);
    }body{
        dx_SetDrawBlendMode(blendMode, blendParam);
        dx_SetDrawBright(bright.red, bright.green, bright.blue);
        return 0==dx_DrawGraph(x, y, GrHandle, isTranslate); // グラフィックの描画
    }
    bool surface(Surface surface, Vector pos, 
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255))
    in{
        assert(blendParam >= 0);
        assert(blendParam < 256);
    }body{
        //auto rect = Surface.rect;
        //auto cx, cy = rect.cx, rect.cy;
        return this.dx_graph(surface.dxhandle, cast(int)pos.x, cast(int)pos.y, 
                surface.isTranslate, blendMode, blendParam, bright);
    }

    bool surface2(Surface surface, Vector pos,
            double dir, double scale, 
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255))
    in{
        assert(blendParam >= 0);
        assert(blendParam < 256);
    }body{
        dx_SetDrawBlendMode(blendMode, blendParam);
        dx_SetDrawBright(bright.red, bright.green, bright.blue);
        auto res=dx_DrawRotaGraph(cast(int)pos.x, cast(int)pos.y, scale, dir,
                surface.dxhandle, surface.isTranslate, false); // グラフィックの描画
        return res==0;
    }
    bool surface_rect(Surface surface, Vector pos, Rect rect,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255))
    in{
        assert(blendParam >= 0);
        assert(blendParam < 256);
    }body{
        dx_SetDrawBlendMode(blendMode, blendParam);
        dx_SetDrawBright(bright.red, bright.green, bright.blue);
        auto res=dx_DrawRectGraph( cast(int)pos.x, cast(int)pos.y,
                  rect.left, rect.top, rect.width, rect.height,
                surface.dxhandle, surface.isTranslate, false); // グラフィックの描画
        return res==0;
    }
    /+
    bool divided_surface(DividedSurface divsur, int n, Vector pos, 
            double dir, double scale, 
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255))
    in{
        assert(blendParam >= 0);
        assert(blendParam < 256);
    }body{
        dx_SetDrawBlendMode(blendMode, blendParam);
        dx_SetDrawBright(bright.red, bright.green, bright.blue);
        auto res=dx_DrawRotaGraph(cast(int)pos.x, cast(int)pos.y, scale, dir,
                *(divsur.dxhandle_p+n), divsur.isTranslate, false); // グラフィックの描画
        return res==0;
    }
    +/
    /// テキストの一行表示(wstring)
    /// Params:
    /// color = 色
    /// pos = 左上の位置
    bool textln(Color color, Vector pos, wstring str, Font font=null,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255)){
        return textln(color, pos, to!(string)(str), font, blendMode, blendParam, bright);
    }
    // 実際の描画処理を行う関数
    private bool text_(Color color, Vector pos, char[] str, Font font=null,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255))
    in{
        assert(blendParam >= 0);
        assert(blendParam < 256);
    }body{
        //描画
        dx_SetDrawBlendMode(blendMode, blendParam);
        dx_SetDrawBright(bright.red, bright.green, bright.blue);
        if(font is null){
            return 0==dx_DrawString(cast(int)pos.x, cast(int)pos.y,
                    wtext(str).ptr, color.dxColor);
        }else{
            return 0==dx_DrawStringToHandle(cast(int)pos.x, cast(int)pos.y,
                    wtext(str).ptr, color.dxColor, font.handle);
        }
    }
    deprecated private bool text_(Color color, Vector pos, string str, Font font=null,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255))
    in{
        assert(blendParam >= 0);
        assert(blendParam < 256);
    }body{
        //文字コードの変換
        //http://pokohimesama.blog98.fc2.com/blog-category-10.html
        char[] s;
        wstring ws = to!(wstring)(str);
        s.length = str.length * 3 + 1;
        setlocale(LC_CTYPE, "");
        auto n = wcstombs(s.ptr, cast(wchar*)(ws~"\0").ptr, s.length);
        s = s[0 .. n];
        //描画
        dx_SetDrawBlendMode(blendMode, blendParam);
        dx_SetDrawBright(bright.red, bright.green, bright.blue);
        if(font is null){
            return 0==dx_DrawString(cast(int)pos.x, cast(int)pos.y,
                    wtext(s).ptr, color.dxColor);
        }else{
            return 0==dx_DrawStringToHandle(cast(int)pos.x, cast(int)pos.y,
                    wtext(s).ptr, color.dxColor, font.handle);
        }
    }
    /// テキストの一行表示(string)
    /// Params:
    /// color = 色
    /// pos = 左上の位置
    bool textln(Color color, Vector pos, string str, Font font=null,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255))
    in{
        assert(blendParam >= 0);
        assert(blendParam < 256);
    }body{
        Vector tl = pos;
        return text_(color, tl, toCString(str), font, blendMode, blendParam, bright);
    }
    /// テキストの表示(string)
    /// Params:
    /// color = 色
    /// pos = 左上の位置
    bool text_tl(Color color, Vector pos, string str, Font font=null,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255))
    in{
        assert(blendParam >= 0);
        assert(blendParam < 256);
    }body{
        string[] ss = splitLines(str);
        int fs = getFontSize(font);
        int u = 0;
        foreach(int i,s; ss){
            textln(color, pos+vecpos(0,u+i*fs), s, font, blendMode, blendParam, bright);
        }
        return true;
    }
    /// テキストの表示(string)
    /// Params:
    /// color = 色
    /// pos = 中心の位置
    bool text_c(Color color, Vector pos, string str, Font font=null,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255))
    in{
        assert(blendParam >= 0);
        assert(blendParam < 256);
    }body{
        string[] ss = splitLines(str);
        int fs = getFontSize(font);
        int u = -((ss.length * fs)/2);
        foreach(int i,s; ss){
            textln_c(color, pos+vecpos(0,u+i*fs), s, font, blendMode, blendParam, bright);
        }
        return true;
    }
    /// テキストの表示(string)
    /// Params:
    /// color = 色
    /// pos = 中心左端の位置
    ///
    bool text_l(Color color, Vector pos, string str, Font font=null,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255))
    in{
        assert(blendParam >= 0);
        assert(blendParam < 256);
    }body{
        int sh = splitLines(str).length * getFontSize(font);
        Vector tl = pos - vecpos(0, sh/2);
        return text_tl(color, tl, str, font, blendMode, blendParam, bright);
    }
    /// テキストの表示(string)
    /// Params:
    /// color = 色
    /// pos = 中心右端の位置
    ///
    bool text_r(Color color, Vector pos, string str, Font font=null,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255))
    in{
        assert(blendParam >= 0);
        assert(blendParam < 256);
    }body{
        string[] ss = splitLines(str);
        int fs = getFontSize(font);
        int u = -((ss.length * fs)/2);
        foreach(int i,s; ss){
            char[] str2 = toCString(s);
            int sw = this.string_width(str2, -1, font);
            int sh;
            if(font is null){
                sh = dx_GetFontSize();
            }else{
                sh = font.size;
            }
            Vector tl = pos+vecpos(0,u+i*fs) - vecpos(sw, 0);
            bool res = textln(color, tl, s, font, blendMode, blendParam, bright);
            if(!res){return false;}
        }
        return true;
    }
    /// 一行だけ表示
    bool textln_c(Color color, Vector pos, string str, Font font=null,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255))
    in{
        assert(blendParam >= 0);
        assert(blendParam < 256);
    }body{
        char[] str2 = toCString(str);
        int sw = this.string_width(str2, -1, font);
        int sh;
        if(font is null){
            sh = dx_GetFontSize();
        }else{
            sh = font.size;
        }
        Vector tl = pos - vecpos(sw/2, sh/2);
        return text_(color, tl, str2, font, blendMode, blendParam, bright);
    }
    ///
    bool text_br(Color color, Vector pos, string str, Font font=null,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255))
    in{
        assert(blendParam >= 0);
        assert(blendParam < 256);
    }body{
        char[] str2 = toCString(str);
        int sw = this.string_width(str2, -1, font);
        int sh;
        if(font is null){
            sh = dx_GetFontSize();
        }else{
            sh = font.size;
        }
        Vector tl = pos - vecpos(sw, sh);
        return text_(color, tl, str2, font, blendMode, blendParam, bright);
    }
    int string_width(char[] str, int str_len = -1, Font font=null){
        if(str_len < 0){str_len = str.length;}
        if(font is null){
            return dx_GetDrawStringWidth(toWStringz(str), str_len);
        }else{
            return dx_GetDrawStringWidthToHandle(toWStringz(str), str_len, font.handle);
        }
    }
    int string_width(wchar[] str, int str_len = -1, Font font=null){
        if(str_len < 0){str_len = str.length;}
        if(font is null){
            return dx_GetDrawStringWidth(toWStringz(str), str_len);
        }else{
            return dx_GetDrawStringWidthToHandle(toWStringz(str), str_len, font.handle);
        }
    }
    deprecated int string_width(string str, int str_len = -1, Font font=null){
        if(str_len < 0){str_len = str.length;}
        char[] str2 = toCString(str);
        if(font is null){
            return dx_GetDrawStringWidth(toWStringz(str2), str_len);
        }else{
            return dx_GetDrawStringWidthToHandle(toWStringz(str2), str_len, font.handle);
        }
    }
    bool laser(Surface surface, Surface edgeSurface, Vector pos, double dir, double length,
            double lengthEdge, double width,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255))
    in{
        assert(blendParam >= 0);
        assert(blendParam < 256);
    }body{
        dx_SetDrawBlendMode(blendMode, blendParam);
        dx_SetDrawBright(bright.red, bright.green, bright.blue);
        Vector d = Vector(1,0);
        d.dir = dir;
        Vector dp = Vector(1,0);
        dp.dir = dir+PI/2;
        Vector[4] edge1 = [pos+dp*width/2, pos-dp*width/2,
            pos+d*lengthEdge+dp*width/2, pos+d*lengthEdge-dp*width/2];
        Vector[4] main = [pos+d*lengthEdge+dp*width/2, pos+d*lengthEdge-dp*width/2,
            pos+d*(length+1)-d*lengthEdge-dp*width/2, pos+d*(length+1)-d*lengthEdge+dp*width/2];
        Vector[4] edge2 = [pos+d*length+dp*width/2, pos+d*length-dp*width/2,
            pos+d*length-d*lengthEdge+dp*width/2, pos+d*length-d*lengthEdge-dp*width/2];
        bool res1 = 0==dx_DrawModiGraphF(edge1[0].x, edge1[0].y, edge1[2].x, edge1[2].y, 
                edge1[3].x, edge1[3].y, edge1[1].x, edge1[1].y, edgeSurface.dxhandle, true);
        bool res2 = 0==dx_DrawModiGraphF(main[1].x, main[1].y, main[2].x, main[2].y, 
                main[3].x, main[3].y, main[0].x, main[0].y, surface.dxhandle, true);
        bool res3 = 0==dx_DrawModiGraphF(edge2[0].x, edge2[0].y, edge2[2].x, edge2[2].y, 
                edge2[3].x, edge2[3].y, edge2[1].x, edge2[1].y, edgeSurface.dxhandle, true);
        return res1 && res2 && res3;
    
    }
    bool simpleLaser(Surface surface, Vector pos, double dir, double length, double thickness,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255))
    in{
        assert(blendParam >= 0);
        assert(blendParam < 256);
    }body{
        dx_SetDrawBlendMode(blendMode, blendParam);
        dx_SetDrawBright(bright.red, bright.green, bright.blue);
        Vector d = Vector(length/2,0);
        d.dir = dir;
        Vector dp = Vector(thickness/2,0);
        dp.dir = dir+PI/2;

        Vector[4] main = [pos-d+dp, pos-d-dp,
            pos+d-dp, pos+d+dp];
        bool res = false;
        if(this.drawFloat){
            res = 0==dx_DrawModiGraphF(main[0].x, main[0].y, main[3].x, main[3].y, 
                    main[2].x, main[2].y, main[1].x, main[1].y, surface.dxhandle, true);
        }else{
            res = 0==dx_DrawModiGraph(
                    cast(int)main[0].x, cast(int)main[0].y,
                    cast(int)main[3].x, cast(int)main[3].y, 
                    cast(int)main[2].x, cast(int)main[2].y,
                    cast(int)main[1].x, cast(int)main[1].y,
                    surface.dxhandle, true);
        }
        return res;
    }

    bool laser2(Surface surface, Surface edgeSurface, Vector pos, double dir, double length,
            double lengthEdge, double width,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255))
    in{
        assert(blendParam >= 0, to!(string)(blendParam));
        assert(blendParam < 256, to!(string)(blendParam));
    }body{
        dx_SetDrawBlendMode(blendMode, blendParam);
        dx_SetDrawBright(bright.red, bright.green, bright.blue);
        Vector d = Vector(1,0);
        d.dir = dir;
        Vector dp = Vector(1,0);
        dp.dir = dir+PI/2;
        Vector[3] tri = [pos,
            pos+d*lengthEdge+dp*width/2, pos+d*lengthEdge-dp*width/2];
        Vector[4] qua = [pos+d*lengthEdge+dp*width/2, pos+d*lengthEdge-dp*width/2,
            pos+d*length-dp*width/2, pos+d*length+dp*width/2];
        bool res1 = 0==dx_DrawModiGraphF(tri[0].x, tri[0].y, tri[1].x, tri[1].y, 
                tri[2].x, tri[2].y, tri[0].x, tri[0].y, edgeSurface.dxhandle, false);
        bool res2 = 0==dx_DrawModiGraphF(qua[1].x, qua[1].y, qua[2].x, qua[2].y, 
                qua[3].x, qua[3].y, qua[0].x, qua[0].y, surface.dxhandle, false);
        return res1;
    }
    void drawArea(Rect rect){
        dx_SetDrawArea(rect.left, rect.top, rect.right, rect.bottom);
    }
    Rect drawArea(){
        RECT r;
        dx_GetDrawArea(&r);
        return mylib.rect.box(r.left, r.top, r.right, r.bottom);
    }
    void clearDrawArea(){
        dx_SetDrawArea(0,0,this.screen.width, this.screen.height);
    }
    void movie_rect(Movie movie, Rect rect, 
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255)){
        dx_SetDrawBlendMode(blendMode, blendParam);
        dx_SetDrawBright(bright.red, bright.green, bright.blue);
        dx_DrawExtendGraph( rect.left , rect.top , rect.right , rect.bottom , movie.dxhandle , false ) ;
    }
    alias movie_rect movie;
    void movie(Movie movie, 
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255)){
        this.movie(movie, this.screen.rect, blendMode, blendParam, bright);
    }
    /// 描画処理時に描画する画像とブレンドするαチャンネル付き画像をセットする( BlendGraph を -1 でブレンド機能を無効 )
    void blendSurface(BlendSurface bs, double par){
        dx_SetBlendGraph( bs.dxhandle, cast(int)(par*255), 1 ) ;
    }
    void clearBlendSurface(){
        dx_SetBlendGraph( 0, -1, 1 ) ;
    }
    void blend(int x, int y, Surface surface, bool isTranslate, BlendSurface blendSurface,
            double border_param, BorderRange br){
        dx_DrawBlendGraph( x, y, surface.dxhandle, isTranslate,
                blendSurface.dxhandle, cast(int)(border_param*255), br ) ;                        // ブレンド画像と合成して画像を描画する
    }
}
enum BorderRange{
    border1 = 1,
    border64 = 64,
    border128 = 128,
    border255 = 255,
}

void DrawExRotaGraphF(float ex, float ey, float xScale, float yScale, float Angle, int GrHandle, int TransFlag, int TurnFlag) {
 int gx,gy;
 float ix,iy,ca=cos(Angle),sa=sin(Angle);
 dx_GetGraphSize(GrHandle,&gx,&gy);
 gx*=xScale/2; gy*=yScale/2;
 Vector[4] pos = [ { -gx, -gy}, { +gx, -gy}, { +gx, +gy}, { -gx, +gy} ];
 for (int i=0;i<4;i++) {
  ix = pos[i].x*ca - pos[i].y*sa;
  iy = pos[i].x*sa + pos[i].y*ca;
  pos[i].x=ix+ex; pos[i].y=iy+ey;
 }
 if (!TurnFlag) dx_DrawModiGraph(cast(int)pos[0].x, cast(int)pos[0].y, cast(int)pos[1].x, cast(int)pos[1].y,
          cast(int)pos[2].x, cast(int)pos[2].y, cast(int)pos[3].x, cast(int)pos[3].y, GrHandle, TransFlag);
 else   dx_DrawModiGraph(cast(int)pos[1].x, cast(int)pos[1].y, cast(int)pos[0].x, cast(int)pos[0].y,
          cast(int)pos[3].x, cast(int)pos[3].y, cast(int)pos[2].x, cast(int)pos[2].y, GrHandle, TransFlag);
}
