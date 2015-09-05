module gamelib.img;

import gamelib.all;
import mylib.list;
import std.stdio;

alias VariableList!(Img) ImgList;
class Img : Position, Direction{
    Vector _pos;
    double _scale;
    bool _is_visible;
    bool _is_rotate;
    bool _is_enable;
    BlendMode _blend_mode;
    ubyte _blend_param;
    double _dir;
    Figure _figure;  //for FigureImg
    ImgList _img_list;  //for AnimationImg
    double _animation_count;  //for AnimationImg
    double _animation_fps;  //for AnimationImg
    this(){
        _img_list = new ImgList;
    }
    protected void init(Vector pos, double dir,
            BlendMode blend_mode, ubyte blend_param,
            double scale, bool is_rotate, bool is_visible, bool is_enable
            ){
        this.pos        = pos;
        this.is_visible = is_visible;
        this.is_enable  = is_enable;
        this.is_rotate  = is_rotate;
        this.blend_mode = blend_mode;
        this.blend_param = blend_param;
        //拡大率 scale_x, scale_yより優先
        this.scale      = scale;
        //回転する角度。デグリーで指定。時計回り
        this.dir        = dir;
    }
    void init_figure(Vector pos, double dir,
            BlendMode blend_mode, ubyte blend_param,
            double scale, bool is_rotate, bool is_visible, bool is_enable,
            Figure figure){
        this.init(pos, dir, blend_mode, blend_param, 
                scale, is_rotate, is_visible, is_enable);
        this._figure = figure;
    }
    void pos(Vector val){_pos = val;}
    pure const override Vector pos(){return _pos;}
    void x(double val){_pos.x = val;}
    pure const override double x(){return pos.x;}
    void y(double val){_pos.y = val;}
    pure const override double y(){return pos.y;}
    void dir(double val){_dir = val;}
    const pure override double dir(){return _dir;}
    void scale(double val){_scale = val;}
    double scale(){return _scale;}
    void is_visible(bool val){_is_visible = val;}
    bool is_visible(){return _is_visible;}
    void is_enable(bool val){_is_enable = val;}
    bool is_enable(){return _is_enable;}
    void is_rotate(bool val){_is_rotate = val;}
    bool is_rotate(){return _is_rotate;}
    void blend_param(ubyte val){_blend_param = val;}
    ubyte blend_param(){return _blend_param;}
    void blend_mode(BlendMode val){_blend_mode = val;}
    Figure figure(){return _figure;}
    BlendMode blend_mode(){return _blend_mode;}

    bool draw(Drawer drawer){
        if(is_visible && is_enable){
            return this.figure.draw(drawer,
                    this.pos, this.dir, this.scale, 
                    this.blend_mode, this.blend_param, Color(255,255,255),this.is_rotate, 0);
        }else{
            return false;
        }
    }
}

    /+

##@brief SurfaceImgの回転できる版
#@since 2008/10/22(Wed)
#@date 2008/10/22(Wed)
#@version 0.1.0.0
#@author N
class RotatableSurfaceImg(Img):
    def __init__(self, surface_list, pos, dir, alpha, scale, is_rotate, is_visible, is_enable, relative=True):
        assert(isinstance(surface_list,list))
        assert(len(surface_list)>0)
        assert(isinstance(surface_list[0],pygame.Surface))
        x, y = pos
        Img.__init__(self,
                pos = pos,
                dir = dir,
                scale = scale,
                alpha = alpha,
                is_rotate = is_rotate,
                is_visible = is_visible,
                is_enable = is_enable)
        self._surface_list = surface_list
        ##コピー元の画像の中から切り出す範囲
        self._source_rect = surface_list[0].get_rect()
        w = self._source_rect.w
        h = self._source_rect.h
        #RectFigure.__init__(self, x-w/2, y-h/2, w, h)
        ##画像を変形しなかった場合のコピー先の幅
        self._w = self._source_rect.w
        ##画像を変形しなかった場合のコピー先の高さ
        self._h = self._source_rect.h
        ##回転するかどうか
        self._rotate = False
        ##回転する場合の、向きの角度(ラジアン)
        self._direction_rad = 0*-1.5*3.141592

#        ##x軸に対して線対称にするかどうか
#        self.flip_x = False
#        ##y軸に対して線対称にするかどうか
#        self.flip_y = False
#        ##x軸への拡大率 scaleが優先
#        self._scale_x = 1
#        ##y軸への拡大率 scaleが優先
#        self._scale_y = 1
#        ##拡大縮小の際にアンチエイリアスをかけるかどうか これをオンにするとカラーキーは無効になる
#        self._antialias = False
        ##αブレンド 0が完全透明、255が不透明
        self._alpha = 255
    def get_alpha(self):
        return self._alpha
    def set_alpha(self, alpha):
        self._alpha = alpha
    def get_surface(self, direction_rad):
        rad = -self._direction_rad - direction_rad 
        #pygame.transform.rotateの回転は反時計回りだから-1をかける
        n   = len(self._surface_list)
        idx = int(math.floor(n*(rad+2*math.pi/2/n)/(2*math.pi)))%n
        res = self._surface_list[idx]
        return res
    def get_source_rect(self):
        return self._source_rect
    def get_dest_rect(self):
        return pygame.Rect(self.get_l(), self.get_t(), self.get_w(), self.get_h())
    def get_rotate(self):
        return True #Rotatableだから必ずTrue
    def get_img_type(self):
        return rotatable_surface_img
class AnimationImg(Img):
    def __init__(self, img_list, pos, dir, alpha, scale, is_rotate, is_visible, is_enable, relative=True):
        assert(len(img_list)>0)
        Img.__init__(self,
                pos = pos,
                dir = dir,
                scale = scale,
                alpha = alpha,
                is_rotate = is_rotate,
                is_visible = is_visible,
                is_enable = is_enable)

        self._img_list = []
        change_count   = 0
        for i in img_list:
            assert(isinstance(i, tuple))
            assert(len(i) == 2)
            image        = i[0]
            drawing_time = i[1]
            assert isinstance(image,Img)
            assert drawing_time>0
            self._img_list.append((image, drawing_time, change_count))
            change_count += drawing_time
        self._max_count = change_count
        self._count     = 0
    def next_image(self):
        self._count = (self._count +1) % self._max_count
        assert(self._count<self._max_count)
    def _img_of_count(self, img_list, count, idx, min, max):
        #二分探索 止まらない
        idximg,idxtime,idxcount = img_list[idx]
        if count < idxcount:
            return self._img_of_count(img_list, count, (idx+min)/2, min, idx-1)
        elif idxcount + idxtime < count:
            return self._img_of_count(img_list, count, (idx+max)/2, idx+1, max)
        else:
            return idximg
    def _img_of_count_linear(self, img_list, count):
        #線形探索
        for i in img_list:
            idximg,idxtime,idxcount = i
            if idxcount <= count and count < idxcount+idxtime:
                return idximg
        assert False, (img_list, count)
    def get_current_image(self):
        length = len(self._img_list)
        #return self._img_of_count(
        #        img_list = self._img_list,#+[(None,self._max_count+1,1)],
        #        count    = self._count,
        #        idx      = length/2,
        #        min      = 0,
        #        max      = length-1)
        return self._img_of_count_linear(self._img_list, self._count)
    def get_img_type(self):
        return animation_img

class ImgGroup(Img):
    def __init__(self, img_list, pos, dir, alpha, scale, is_rotate, is_visible, is_enable):
        Img.__init__(self,
            pos        = pos,
            dir        = dir,
            alpha      = alpha,
            scale      = scale,
            is_rotate  = is_rotate,
            is_visible = is_visible,
            is_enable  = is_enable,
        )
        self._img_list = img_list
    def get_img_list(self):
        return self._img_list
    def set_imgelist(self, img_list):
        self._img_list = img_list
    #img_list = property(get_img_list, set_img_list, None)
    def get_img_type(self):
        return img_group
noimg = FigureImg(figure.nofigure, (0,0), 0, 1.0, 1.0, False, False, True)
#####################################################################
if __name__ == '__main__':
    il = lineimg()
    print il.is_visible
    +/
