module gamelib.imageeditor;

import gamelib.all;
import std.stdio;
import dxlib.all;
import std.string;

/// alphaを残したまま真っ白にする
int white_silhouette(int src_image){
    int w, h;
    dx_GetSoftImageSize(src_image, &w, &h);
    int res = dx_MakeARGB8ColorSoftImage(w,h);
    for(int x=0; x<w; x++){
        for(int y=0; y<h; y++){
            int r,g,b,a;
            dx_GetPixelSoftImage(src_image,x,y,&r, &g, &b, &a);
            dx_DrawPixelSoftImage(res, x, y, 255, 255, 255, a);
        }
    }
    return res;
}

/// alphaを残したままcolorで塗りつぶす
/// 透過色が指定されている場合、シルエットになる
int silhouette(int src_image, Color color){
    int w, h;
    dx_GetSoftImageSize(src_image, &w, &h);
    int res = dx_MakeARGB8ColorSoftImage(w,h);
    for(int x=0; x<w; x++){
        for(int y=0; y<h; y++){
            int r,g,b,a;
            dx_GetPixelSoftImage(src_image,x,y,&r, &g, &b, &a);
            dx_DrawPixelSoftImage(res, x, y, color.red, color.green, color.blue, a);
        }
    }
    return res;
}
/// サーフェイスを読み込んだあと、alphaを残したままcolorで塗りつぶす
/// 透過色が指定されている場合、シルエットになる
Surface load_silhouettesurface(string path, Color color){
    int src_image = dx_LoadSoftImage(toWStringz(path));
    int res_image = silhouette(src_image, color);
    int graph_handle = dx_CreateGraphFromSoftImage(res_image);
    dx_DeleteSoftImage(src_image);
    dx_DeleteSoftImage(res_image);
    return new Surface(graph_handle, true);
}
