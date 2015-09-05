// D import file generated from 'gamelib\imageeditor.d'
module gamelib.imageeditor;
import gamelib.all;
import std.stdio;
import dxlib.all;
import std.string;
int white_silhouette(int src_image);
int silhouette(int src_image, Color color);
Surface load_silhouettesurface(string path, Color color)
{
int src_image = dx_LoadSoftImage(toWStringz(path));
int res_image = silhouette(src_image,color);
int graph_handle = dx_CreateGraphFromSoftImage(res_image);
dx_DeleteSoftImage(src_image);
dx_DeleteSoftImage(res_image);
return new Surface(graph_handle,true);
}
