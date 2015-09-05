module figuretable;

import gamelib.all;

class FigureTable : Table!(Figure){
public:
    Figure my;
    Figure my_w;
    Figure ball_blue;
    //weapon
    Figure bara;
    Figure weapon_thimble;
    //chara
    Figure dorobou;
    Figure dorobou_w;
    Figure chiba;
    Figure chiba_w;
    Figure endappeal;
    Figure shimi;
    Figure shimi_w;
    Figure tomas;
    Figure tomas_arrow;
    Figure dia;
    Figure kemuri;
    Figure hashimo;
    Figure hashimo_w;
    Figure umeo;
    Figure umeo_w;
    Figure mori;
    Figure mori_w;
    Figure yama;
    Figure yama_w;
    Figure kasai;
    Figure kasai_w;
    Figure owa;
    Figure owa_w;
    Figure heri;
    Figure heri_w;
    //Figure shimi_shot;
    SimpleLaserFigure laser;
    Figure usa;
    Figure usa_w;
    Figure zeki;
    Figure zeki_w;
    Figure chiba_mark;
    //
    Figure slow_icon;
    Figure pinspot_icon;
    //effect
    Figure thiun;
    Figure bigbaku;
    Figure bomb;
    //item
    Figure item_thimble;
    Figure item_gumtama;
    Figure item_flag;
    Figure item_dove;
    Figure item_heal;


    this(){
    }
}

/+
private SurfaceFigure sf(SurfaceTable st, string key){
    return new SurfaceFigure(st[key]);
}
private AnimationFigure af(string key, int w, int h, double speed, bool loop=true){
        return create_animationfigure_from_surface(
                System.surface_table[key], w,h,speed,loop);
}
private AnimationFigure af(string key, int wh, double speed, bool loop=true){
        return create_animationfigure_from_surface(
                System.surface_table[key], wh,wh,speed,loop);
}
+/
