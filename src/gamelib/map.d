module gamelib.map;

import gamelib.all;
import mylib.utils;

import std.stdio;
import fmf.fmfmap;
import std.conv;

import dxlib.all;


/// マップのレイヤー
/// ベースクラス
abstract class MapLayerBase(T){
    this(){
    }
    /// チップデータをチップ座標で指定して取得
    /// Params:
    ///     x = チップ座標x(何個目のチップか)
    ///     y = チップ座標y(何個目のチップか)
    const pure nothrow abstract T chipId(int xChipNum, int yChipNum);
    /// チップデータをピクセル座標で指定して取得
    /// チップサイズを持たないものはchipと同じになる…のかな？
    /// Params:
    ///     x = 座標x(ピクセル単位で)
    ///     y = 座標y(ピクセル単位で)
    const pure nothrow abstract T getChip(int x, int y);
    /// getChip(int, int)と同じ
    /// Vectorで位置指定
    const pure nothrow T getChip(Vector p){
        return this.getChip(cast(int)p.x, cast(int)p.y);
    }
    /// getChip(int, int)と同じ
    /// IntVectorで位置指定
    const pure nothrow final T getChip(IntVector p){
        return this.getChip(p.x, p.y);
    }
    /// (x,y)座標のchipを書き換える
    abstract void setChip(int x, int y, T chip);
    /// destの範囲に描画
    abstract void draw(Drawer drawer, Rect dest, int x, int y,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255));
    /// 画面全体に描画
    final void draw(Drawer drawer, int x, int y,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255)){
        Rect r = rect(0,0,drawer.screen.width, drawer.screen.height);
        this.draw(drawer, r, x, y, blendMode, blendParam, bright);
    }
}
/// もっと具体的にしたMapLayer
/// チップは大きさを持つと仮定
/// チップパレットが存在して大きさがあると仮定
abstract class MapLayer(T) : MapLayerBase!(T){
private:
    int _chipWidth;
    int _chipHeight;
    int _mapWidthChipNum;
    int _mapHeightChipNum;
    int _paletteWidthChipNum;
    int _paletteHeightChipNum;
public:
    /// コンストラクタ
    /// Params:
    ///     chipWidth = ひとつのチップの横幅
    ///     chipHeight = ひとつのチップの高さ
    ///     mapWidthChipNum = マップの横幅をチップの数で指定
    ///     mapHeightChipNum = マップの高さをチップの数で指定
    ///     paletteWidthChipNum = 
    ///     paletteHeightChipNum = 
    this(int chipWidth, int chipHeight, int mapWidthChipNum, int mapHeightChipNum,
            int paletteWidthChipNum, int paletteHeightChipNum){
        this._chipWidth = chipWidth;
        this._chipHeight = chipHeight;
        this._mapWidthChipNum = mapWidthChipNum;
        this._mapHeightChipNum = mapHeightChipNum;
        this._paletteWidthChipNum = paletteWidthChipNum;
        this._paletteHeightChipNum = paletteHeightChipNum;
    }
    /// ひとつのチップの横幅を取得
    const pure nothrow final int chipWidth(){ return this._chipWidth; }
    //final void chipWidth(int val){ this._chipWidth = val; }
    /// ひとつのチップの高さを取得
    const pure nothrow final int chipHeight(){ return this._chipHeight; }
    //final void chipHeight(int val){ this._chipHeight = val; }
    /// マップの横幅をチップの数で取得
    const pure nothrow final int mapWidthChipNum(){ return this._mapWidthChipNum; }
    //final void mapWidthChipNum(int val){ this._mapWidthChipNum = val; }
    /// マップの高さをチップの数で取得
    const pure nothrow final int mapHeightChipNum(){ return this._mapHeightChipNum; }
    //final void map_chipnum_y(int val){ this._map_chipnum_y = val; }
    /// パレットの横幅をチップの数で取得
    const pure nothrow final int paletteWidthChipNum(){ return this._paletteWidthChipNum; }
    /// パレットの高さをチップの数で取得
    const pure nothrow final int paletteHeightChipNum(){ return this._paletteHeightChipNum; }
    /// パレットの横幅をピクセル数で取得
    const pure nothrow final int paletteWidth(){ return this.paletteWidthChipNum * this.chipWidth; }
    /// パレットの高さをピクセル数で取得
    const pure nothrow final int paletteHeight(){ return this.paletteHeightChipNum * this.chipHeight; }
    /// チップナンバーの最大値-1を求める
    const pure nothrow final int chipNoMax(){
        return this.paletteHeightChipNum * this.paletteWidthChipNum;
    }
    /// マップの横幅をピクセル数でで取得
    const pure nothrow final int map_width(){return this.chipWidth * this.mapWidthChipNum;}
    /// マップの高さをピクセル数でで取得
    const pure nothrow final int map_height(){return this.chipHeight * this.mapHeightChipNum;}

    /// チップデータの取得(チップ数指定)
    const pure nothrow override abstract T chipId(int xChipNum, int yChipNum);
    /// チップデータを指定
    override abstract void setChip(int x, int y, T chip);
    /// 描画
    override abstract void draw(Drawer drawer, Rect dest, int x, int y,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255));
    /// チップデータの取得(ピクセル指定)
    const pure nothrow override final T getChip(int x, int y){
        return this.chipId(x/this.chipWidth, y/this.chipHeight);
    }
    /// getChip(int, int)と同じ
    /// Vectorで位置指定
    const pure nothrow override final T getChip(Vector p){
        return this.getChip(cast(int)p.x, cast(int)p.y);
    }

    /// (x,y)がマップ内の位置かどうかを判定
    /// x,yはピクセル指定
    const pure nothrow final bool inMapPos(int x, int y){
        bool bx = 0<=x && x<this.map_width;
        bool by = 0<=y && y<this.map_height;
        return bx && by;
    }
    /// pがマップ内の位置かどうかを判定
    const pure nothrow final bool inMapPos(Vector p){ return inMapPos(cast(int)p.x, cast(int)p.y); }
    /// pがマップ内の位置かどうかを判定
    const pure nothrow final bool inMapPos(IntVector p){ return inMapPos(p.x, p.y); }
    /// (xChipNum,yChipNum)がマップ内の位置かどうかを判定
    /// xChipNum,yChipNumはチップ数指定
    const pure nothrow final bool inMapChipNum(int xChipNum, int yChipNum){
        bool bx = 0<=xChipNum && xChipNum<this.mapWidthChipNum;
        bool by = 0<=yChipNum && yChipNum<this.mapHeightChipNum;
        return bx && by;
    }
    /// (xChipNum, yChipNum)がパレットの中かどうかを判定
    /// xChipNum,yChipNumはチップ数指定
    const pure nothrow final bool inPaletteChipNum(int xChipNum, int yChipNum){
        bool bx = 0<=xChipNum && xChipNum<this.paletteWidthChipNum;
        bool by = 0<=yChipNum && yChipNum<this.paletteHeightChipNum;
        return bx && by;
    }

    /// chip noが有効かどうか
    const pure nothrow final bool in_palette_chipNo(int chipNo){
        return 0<= chipNo && chipNo < chipNoMax;
    }

    /// チップNoからパレット中の位置のx座標を得る
    /// 戻り値はチップ数
    const pure nothrow final int chipNo2PaletteXChipNum(int chipNo)
    in{
        static if(true){
            assert(0<=chipNo && chipNo<this.paletteWidthChipNum*this.paletteHeightChipNum);
        }else{
            assert(0<=chipNo && chipNo<this.paletteWidthChipNum*this.paletteHeightChipNum,
                to!(string)(chipNo));
        }
    } body{ return chipNo%this.paletteWidthChipNum; }

    /// チップNoからパレット中の位置のy座標を得る
    /// 戻り値はチップ数
    const pure nothrow final int chipNo2PaletteYChipNum(int chipNo)
    in{
        static if(true){
            assert(0<=chipNo && chipNo<this.paletteWidthChipNum*this.paletteHeightChipNum);
        }else{
            assert(0<=chipNo && chipNo<this.paletteWidthChipNum*this.paletteHeightChipNum,
            to!(string)(chipNo));
        }
    } body{ return chipNo/this.paletteWidthChipNum; }

    /// チップNoからパレット中の位置のx座標を得る
    /// 戻り値はピクセル
    const pure nothrow final int chipNo2PaletteX(int chipNo)
    in{
        static if(true){
            assert(0<=chipNo && chipNo<this.paletteWidthChipNum*this.paletteHeightChipNum);
        }else{
            assert(0<=chipNo && chipNo<this.paletteWidthChipNum*this.paletteHeightChipNum,
            to!(string)(chipNo));
        }
    }
    body{ return this.chipNo2PaletteXChipNum(chipNo) * this.chipWidth; }
    /// チップNoからパレット中の位置のy座標を得る
    /// 戻り値はピクセル
    const pure nothrow final int chipNo2PaletteY(int chipNo)
    in{
        static if(true){
            assert(0<=chipNo && chipNo<this.paletteWidthChipNum*this.paletteHeightChipNum);
        }else{
            assert(0<=chipNo && chipNo<this.paletteWidthChipNum*this.paletteHeightChipNum,
            to!(string)(chipNo));
        }
    }
    body{ return this.chipNo2PaletteYChipNum(chipNo) * this.chipHeight; }
    /// チップNoからパレット中の位置を得る
    /// 戻り値はピクセル
    const pure nothrow final IntVector chipNo2palette_pos(int chipNo)
    in{
        static if(true){
            assert(0<=chipNo && chipNo<this.paletteWidthChipNum*this.paletteHeightChipNum);
        }else{
            assert(0<=chipNo && chipNo<this.paletteWidthChipNum*this.paletteHeightChipNum,
            to!(string)(chipNo));
        }
    }
    body{ return IntVector(this.chipNo2PaletteX(chipNo), this.chipNo2PaletteY(chipNo)); }
    /// パレットのチップ座標からチップNoを得る
    const pure nothrow final int paletteXYChipNum2ChipNo(int xChipNum, int yChipNum)
        in{assert(this.inPaletteChipNum(xChipNum,yChipNum));}
        out(res){
            auto xx = this.chipNo2PaletteXChipNum(res);
            static if(true){
                assert(xx==xChipNum);
            }else{
                assert(xx==xChipNum,
                        "x  "~to!(string)(xx)~ " and " ~
                        to!(string)(xChipNum));
            }
            auto yy = this.chipNo2PaletteYChipNum(res);
            static if(true){
                assert(yy==yChipNum);
            }else{
                assert(yy==yChipNum,
                    "y  "~to!(string)(yy)~ " and " ~
                    to!(string)(yChipNum));
            }
        }
        body{ return xChipNum+yChipNum*this.paletteWidthChipNum;}

    /// foreach用
    int opApply(int delegate(ref int, ref int, T) dg)
    {
        int result = 0;
        for (int iycn=0; iycn < this.mapHeightChipNum; iycn++){
            for (int ixcn=0; ixcn < this.mapWidthChipNum; ixcn++)
            {
                result = dg(ixcn,iycn, this.chipId(ixcn,iycn));
                if (result){ break;}
            }
        }
        return result;
    }
    /// foreach_reverse用
    int opApplyReverse(int delegate(ref int, ref int, T) dg)
    {
        int result = 0;
        for (int iycn=0; iycn < this.mapHeightChipNum; iycn++){
            for (int ixcn=0; ixcn < this.mapWidthChipNum; ixcn++)
            {
                result = dg(ixcn,iycn, 
                        this.chipId(this.mapWidthChipNum-ixcn-1,this.mapHeightChipNum-iycn-1));
                if (result){ break;}
            }
        }
        return result;
    }
}
alias uint ChipId;
/// Fmfマップ
class FmfMapLayer : MapLayer!(ChipId){
private:
    CFmfMap fm;
    ubyte layer;
    Surface _chipSurface;
    ChipId _defaultChip;
    bool _drawDefaultChip;
public:
    ///
    this(CFmfMap fm, Surface chipSurface, ubyte layer){
        auto bc = fm.GetLayerBitCount;
        auto chip_size = (bc == 8) ? 16 : ((bc == 16) ? 256 : 0);
        //writeln(chip_size);
        super(fm.GetChipWidth, fm.GetChipHeight, fm.GetMapWidth, fm.GetMapHeight,
                chip_size, chip_size);
        this.fm = fm;
        this.layer = layer;
        this._chipSurface = chipSurface;
        this.defaultChip = 0;
        this.drawDefaultChip = true;
    }
    ///
    void defaultChip(ChipId val){
        this._defaultChip = val;
    }
    ///
    const pure nothrow ChipId defaultChip(){
        return this._defaultChip;
    }
    ///
    const pure nothrow bool drawDefaultChip(){
        return this._drawDefaultChip;
    }
    ///
    void drawDefaultChip(bool val){
        this._drawDefaultChip = val;
    }
    /+
    this(string path, ubyte layer){
        CFmfMap fm = new CFmfMap;
        fm.Open(cast(char*)path);
        this(fm, layer);
    }+/
    ///
    const pure nothrow override ChipId chipId(int xChipNum, int yChipNum){
        if(this.inMapChipNum(xChipNum, yChipNum)){
            return cast(ChipId)fm.GetValue(layer, cast(uint)xChipNum, cast(uint)yChipNum);
        }else{
            return this.defaultChip;
        }
    }
    ///
    const pure nothrow uint chip(int xChipNum, int yChipNum){
        if(this.inMapChipNum(xChipNum, yChipNum)){
            return cast(uint)fm.GetValue(layer, cast(uint)xChipNum, cast(uint)yChipNum);
        }else{
            return cast(uint)this.defaultChip;
        }
    }
    override void setChip(int x, int y, ChipId chip){}
    /// 表示
    /// Params:
    ///     drawer = いつもの
    ///     dest = 描画先の範囲
    ///     x = 描画元の左上x座標
    ///     y = 描画元の左上y座標
    override void draw(Drawer drawer, Rect dest, int x, int y,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255)){
        Vector pos = dest.top_left.toVector;
        int iyMin;
        int iyMax;
        int ixMin;
        int ixMax;
        if(this.drawDefaultChip){
            iyMin = y/chipHeight-1;
            iyMax = (y+dest.height)/chipHeight+1;
            ixMin = x/chipWidth-1;
            ixMax = (x+dest.width)/chipWidth+1;
        }else{
            iyMin = max(y/chipHeight-1, 0);
            iyMax = min((y+dest.height)/chipHeight+1, this.mapHeightChipNum);
            ixMin = max(x/chipWidth-1, 0);
            ixMax = min((x+dest.width)/chipWidth+1, this.mapWidthChipNum);
        }
        Rect tmpRect = drawer.drawArea;
        drawer.drawArea = dest;
        for(int iy=iyMin; iy<iyMax; iy++){
            for(int ix=ixMin; ix<ixMax; ix++){
                int v = this.chip(ix, iy);
                int cx = this.chipNo2PaletteXChipNum(v);
                int cy = this.chipNo2PaletteYChipNum(v);
                assert(v==this.paletteXYChipNum2ChipNo(cx,cy));
                int cw = this.chipWidth;
                int ch = this.chipHeight;
                Rect r = Rect(cx*cw, cy*ch,cw,ch);
                Vector p = pos + vecpos(ix*cw-x, iy*ch-y);
                drawer.surface_rect(_chipSurface, p, r,
                        blendMode, blendParam, bright);
            }
        }
        drawer.drawArea = tmpRect;
    }
    ///
    void draw(Drawer drawer, int x, int y,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255)){
        Rect r = rect(0,0,drawer.screen.width, drawer.screen.height);
        this.draw(drawer, r, x, y, blendMode, blendParam, bright);
    }
    ///
    void drawLine(Drawer drawer, Color color, Rect dest, int x, int y,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255)){
        int xnum = dest.width / this.chipWidth + 1;
        int ynum = dest.height / this.chipHeight + 1;
        int xp = x%this.chipWidth;
        int yp = y%this.chipHeight;
        Rect tmpRect = drawer.drawArea;
        drawer.drawArea = dest;
        for(int ix = -1; ix <= xnum; ix++){
            int xx = ix * chipWidth - xp + dest.left;
            int y1 = dest.top;
            int y2 = dest.bottom;
            //assert(xx < dest.left+chipWidth, to!(string)(xx));
            //assert(xx > dest.right-chipWidth, to!(string)(xx));
            drawer.line(color, xx, y1, xx, y2, 1, blendMode, blendParam, bright);
            drawer.line(color, xx-1, y1, xx-1, y2, 1, blendMode, blendParam, bright);
        }
        for(int iy = -1; iy <= ynum; iy++){
            int yy = iy * chipHeight - yp + dest.top;
            int x1 = dest.left;
            int x2 = dest.right;
            drawer.line(color, x1, yy, x2, yy, 1, blendMode, blendParam, bright);
            drawer.line(color, x1, yy-1, x2, yy-1, 1, blendMode, blendParam, bright);
        }
        drawer.drawArea = tmpRect;
    }
    /// 画面いっぱいに描画
    void drawLine(Drawer drawer, Color color, int x, int y,
            BlendMode blendMode=BlendMode.NOBLEND, int blendParam=255,
            Color bright = col(255,255,255)){
        Rect r = rect(0,0,drawer.screen.width, drawer.screen.height);
        this.drawLine(drawer, color, r, x, y, blendMode, blendParam, bright);
    }
    ///
    const pure nothrow Surface chipSurface(){return cast(Surface)this._chipSurface;}
}
/// Fmfファイルのlayer番目のマップを読み込んでFmfMapLayerを作る
FmfMapLayer loadFmfMapLayer(string path, string surface_path, ubyte layer){
    byte[] buf;
    int dxfp = dx_FileRead_open( toWStringz(path)) ;
    int size = dx_FileRead_size( toWStringz(path)) ;
    buf.length = size;
    dx_FileRead_read( buf.ptr , size , dxfp ) ;		/// ファイルからデータを読み込む
    dx_FileRead_close( dxfp ) ;									/// ファイルを閉じる
    auto fm = new CFmfMap(buf);
    auto sur = loadSurface(surface_path);
    auto res = new FmfMapLayer(fm, sur, layer);
    return res;
}
/// Fmfファイルを読み込んで各レイヤーのFmfMapLayerを作る
FmfMapLayer[] loadFmfMapLayers(string path, string surface_path){
    byte[] buf;
    int dxfp = dx_FileRead_open( toWStringz(path)) ;
    int size = dx_FileRead_size( toWStringz(path)) ;
    buf.length = size;
    dx_FileRead_read( buf.ptr , size , dxfp ) ;		/// ファイルからデータを読み込む
    dx_FileRead_close( dxfp ) ;									/// ファイルを閉じる
    auto fm = new CFmfMap(buf);
    auto sur = loadSurface(surface_path);
    FmfMapLayer[] res;
    res.length = fm.GetLayerCount;
    foreach(ubyte i, ref fml; res){
        fml = new FmfMapLayer(fm, sur, i);
    }
    return res;
}
unittest{

}
version(none){
class TestMapLayerBase(T) : MapLayer!(T){
    this(){
        super(16,16, 20, 20, 16, 16);
    }
}
class TestMapLayer : TestMapLayerBase!(int){
    this(){
        super();
    }
    override int chip(int x, int y){
        return 0;
    }
    override void setChip(int x, int y, int chip){
        writeln("set chip");
    }
    override void draw(Drawer drawer, Rect dest, int x, int y){
        
    }
}
class TestMapThroughLayer : TestMapLayerBase!(bool){
    this(){
        super();
    }
    const pure nothrow override bool chip(int x, int y){
        return true;
    }
    override void setChip(int x, int y, bool chip){
        writeln("set chip");
    }
    override void draw(Drawer drawer, Rect dest, int x, int y){
    }
}
}

