module material.transitiontable;

import gamelib.all;

class TransitionTable{
    WipeTransition roll;
    WipeTransition left_blind;
    WipeTransition right_blind;
    WipeTransition fade;
    WipeTransition mist;
    WipeTransition water;
    WipeTransition lines;

    WipeTransition test;
    SurfaceTransition cross;
    SurfaceTransition blend;
    this(Screen screen){
        TileDrawer[string] tdr = create_tile_drawer();
        TileDiffusion[string] tdf = create_tile_diffusion();
        roll = tileWipeTransition(screen, 
                new RollingTileDrawer(RotationDirection.left,1),
                new CircleOutTileDiffusion,
                16, 16, 0.2, 0.5);
        left_blind = verticalWipeTransition(screen,
                new DirectTileDrawer(Direction8.L),
                new DirectTileDiffusion(Direction8.L),
                10, 0.2, 0.5);
        right_blind = verticalWipeTransition(screen,
                new DirectTileDrawer(Direction8.R),
                new DirectTileDiffusion(Direction8.R),
                10,  0.2, 0.5);
        water = horizonWipeTransition(screen,
                new CircleTileDrawer(),
                new CircleInTileDiffusion(),
                20, 0.2, 0.5);
        mist = horizonWipeTransition(screen,
                new UnboxTileDrawer(),
                new CircleInTileDiffusion(),
                10, 0.2, 0.5);
        lines = horizonWipeTransition(screen,
                tdr["left"], tdr["right"],
                tdf["down2"],
                2, 0.2, 0.5);
        test = tileWipeTransition(screen,
                tdr["tl"],
                tdf["br"],
                16,16, 0.2, 0.5);
        cross = new CrossFade(screen);
        //if(st !is null){
        //blend = new BlendTransition(screen, st.blend, BorderRange.border64);
        //}
        /+
        cft["new'"] = horizonWipeTransition(game.screen,new UnboxTileDrawer(), new CircleOutTileDiffusion(), 10,  0.2, 0.5);
        cft["new2"] = cft["left"] /+* cft["new'"]+/ * allWipeTransition(game.screen, new FadeTileDrawer(), 0.2, 0.5);
        +/
        fade = allWipeTransition(screen, new FadeTileDrawer(), 0.2, 0.5);
    }
}
private TileDrawer[string] create_tile_drawer(){
    TileDrawer[string] res;
    res["left"]   = new DirectTileDrawer(Direction8.L);
    res["right"]  = new DirectTileDrawer(Direction8.R);
    res["up"]     = new DirectTileDrawer(Direction8.T);
    res["down"]   = new DirectTileDrawer(Direction8.B);
    res["br"]     = new DirectTileDrawer(Direction8.BR);
    res["bl"]     = new DirectTileDrawer(Direction8.BL);
    res["tl"]     = new DirectTileDrawer(Direction8.TL);
    res["tr"]     = new DirectTileDrawer(Direction8.TR);
    res["fade"]   = new FadeTileDrawer;
    res["box"]    = new BoxTileDrawer;
    res["openv"]  = new OpenVerticalTileDrawer;
    res["closev"] = new CloseVerticalTileDrawer;
    return res;
}
private TileDiffusion[string] create_tile_diffusion(){
    TileDiffusion[string] res;
    res["plain"]  = new PlainTileDiffusion;
    res["left"]   = new DirectTileDiffusion(Direction8.L);
    res["right"]  = new DirectTileDiffusion(Direction8.R);
    res["up"]     = new DirectTileDiffusion(Direction8.T);
    res["down"]   = new DirectTileDiffusion(Direction8.B);
    res["tl"]     = new DirectTileDiffusion(Direction8.TL);
    res["tr"]     = new DirectTileDiffusion(Direction8.TR);
    res["br"]     = new DirectTileDiffusion(Direction8.BR);
    res["bl"]     = new DirectTileDiffusion(Direction8.BL);
    res["left2"]  = new DirectTileDiffusion(Direction8.L, 1.5);
    res["right2"] = new DirectTileDiffusion(Direction8.R, 1.5);
    res["up2"]    = new DirectTileDiffusion(Direction8.T, 1.5);
    res["down2"]  = new DirectTileDiffusion(Direction8.B, 1.5);
    return res;
}
