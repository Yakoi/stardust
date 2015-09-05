module mylib.sincos;

import std.math;
import std.stdio;
import std.conv;


/// サインをインデックスで求める
private pure real sin_idx(in int n){
    return sin_table[n%sin_table.length];
}
/// サイン
pure real sin(in real rad){
    int i = cast(int)(rad*sin_table.length/(2*PI));
    return sin_idx(i);
}
///コサイン
pure real cos(in real rad){
    return sin(PI/4 - rad);
}
/// タンジェント
pure real tan(in real rad){
    return sin(rad)/cos(rad);
}
void main_(){
    int n = 12*7*5;
    for(int i=0; i<n; i++){
        real rad = ((i+2*n)*2*PI)/n;
        //writefln("%.30f",(std.math.sin(rad)));
        if(true){
            //writeln(sin(rad)==std.math.sin(rad));
            writeln(rad);
            writefln("%.30f",(std.math.sin(rad)));
            writefln("%.30f",(         sin(rad)));
        }else{
            writeln(cos(rad)==std.math.cos(rad));
            writefln("%.30f",(std.math.cos(rad)));
            writefln("%.30f",(         cos(rad)));
        }
        //writeln(std.math.sin(rad));
        //writeln(sin(rad));
    }
}
static assert(sin_table.length > 0);
static assert(sin_table.length == 12*5*7);

// sinテーブル
private immutable real[] sin_table = [
    0.000000000000000000000000000000,
    0.014959407015263618690000000000,
    0.029915466169398454841000000000,
    0.044864830350514925461000000000,
    0.059804153945034169577000000000,
    0.074730093586424254296000000000,
    0.089639308903433499772000000000,
    0.104528463267653471400000000000,
    0.119394224540244337210000000000,
    0.134233265817655476040000000000,
    0.149042266176174446930000000000,
    0.163817911415137692460000000000,
    0.178556894798636648030000000000,
    0.193255917795553265890000000000,
    0.207911690817759337110000000000,
    0.222520933956314404300000000000,
    0.237080377715497507590000000000,
    0.251586763744508489550000000000,
    0.266036845566675107400000000000,
    0.280427389306002757870000000000,
    0.294755174410904216850000000000,
    0.309016994374947424110000000000,
    0.323209657454460013700000000000,
    0.337329987382829991830000000000,
    0.351374824081342704910000000000,
    0.365341024366395014520000000000,
    0.379225462652928408090000000000,
    0.393025031653923618200000000000,
    0.406736643075800207740000000000,
    0.420357228309565491900000000000,
    0.433883739117558120480000000000,
    0.447313148315632630370000000000,
    0.460642450450632297310000000000,
    0.473868662472998670730000000000,
    0.486988824404367264850000000000,
    0.500000000000000000000000000000,
    0.512899277405906143940000000000,
    0.525683769810504692570000000000,
    0.538350616090682350120000000000,
    0.550896981452102522730000000000,
    0.563320058063622027760000000000,
    0.575617065685673537710000000000,
    0.587785252292473129210000000000,
    0.599821894687913689800000000000,
    0.611724299115006347150000000000,
    0.623489801858733530540000000000,
    0.635115769842178747200000000000,
    0.646599601215799663590000000000,
    0.657938725939712612360000000000,
    0.669130606358858213800000000000,
    0.680172737770919390210000000000,
    0.691062648986864675940000000000,
    0.701797902883991375850000000000,
    0.712376096951344802300000000000,
    0.722794863827391528570000000000,
    0.733051871829826328550000000000,
    0.743144825477394235010000000000,
    0.753071466003610933510000000000,
    0.762829571862266523530000000000,
    0.772416959224599517080000000000,
    0.781831482468029808750000000000,
    0.791071034656341241040000000000,
    0.800133548011206301070000000000,
    0.809016994374947424110000000000,
    0.817719385664431338150000000000,
    0.826238774315994871970000000000,
    0.834573253721302650910000000000,
    0.842720958654039140140000000000,
    0.850680065687339540320000000000,
    0.858448793601866118500000000000,
    0.866025403784438646720000000000,
    0.873408200617129737250000000000,
    0.880595531856737995240000000000,
    0.887585789004554065630000000000,
    0.894377407666336820490000000000,
    0.900968867902419126220000000000,
    0.907358694567864837960000000000,
    0.913545457642600895560000000000,
    0.919527772551450638290000000000,
    0.925304300473996717100000000000,
    0.930873748644204255640000000000,
    0.936234870639737209480000000000,
    0.941386466660903171560000000000,
    0.946327383799164199410000000000,
    0.951056516295153572120000000000,
    0.955572805786140732830000000000,
    0.959875241542889036210000000000,
    0.963962860695853291850000000000,
    0.967834748450666483210000000000,
    0.971490038292867433790000000000,
    0.974927912181823607020000000000,
    0.978147600733805637910000000000,
    0.981148383394172626020000000000,
    0.983929588598629655410000000000,
    0.986490593923521452090000000000,
    0.988830826225128545030000000000,
    0.990949761767934755250000000000,
    0.992846926341837307960000000000,
    0.994521895368273336870000000000,
    0.995974293995239029570000000000,
    0.997203797181180148250000000000,
    0.998210129767735153050000000000,
    0.998993066541314647400000000000,
    0.999552432283503363300000000000,
    0.999888101810273408750000000000,
    1.000000000000000000000000000000,
    0.999888101810273408750000000000,
    0.999552432283503363300000000000,
    0.998993066541314647400000000000,
    0.998210129767735153050000000000,
    0.997203797181180148250000000000,
    0.995974293995239029570000000000,
    0.994521895368273336870000000000,
    0.992846926341837307960000000000,
    0.990949761767934755250000000000,
    0.988830826225128545030000000000,
    0.986490593923521452090000000000,
    0.983929588598629655410000000000,
    0.981148383394172626020000000000,
    0.978147600733805637910000000000,
    0.974927912181823607020000000000,
    0.971490038292867433710000000000,
    0.967834748450666483130000000000,
    0.963962860695853291850000000000,
    0.959875241542889036210000000000,
    0.955572805786140732830000000000,
    0.951056516295153572120000000000,
    0.946327383799164199410000000000,
    0.941386466660903171560000000000,
    0.936234870639737209480000000000,
    0.930873748644204255640000000000,
    0.925304300473996717010000000000,
    0.919527772551450638290000000000,
    0.913545457642600895480000000000,
    0.907358694567864837960000000000,
    0.900968867902419126220000000000,
    0.894377407666336820490000000000,
    0.887585789004554065630000000000,
    0.880595531856737995240000000000,
    0.873408200617129737170000000000,
    0.866025403784438646800000000000,
    0.858448793601866118590000000000,
    0.850680065687339540240000000000,
    0.842720958654039140230000000000,
    0.834573253721302650820000000000,
    0.826238774315994871970000000000,
    0.817719385664431338240000000000,
    0.809016994374947424020000000000,
    0.800133548011206301160000000000,
    0.791071034656341240910000000000,
    0.781831482468029808620000000000,
    0.772416959224599516950000000000,
    0.762829571862266523490000000000,
    0.753071466003610933640000000000,
    0.743144825477394234960000000000,
    0.733051871829826328420000000000,
    0.722794863827391528480000000000,
    0.712376096951344802250000000000,
    0.701797902883991375720000000000,
    0.691062648986864675810000000000,
    0.680172737770919390120000000000,
    0.669130606358858213760000000000,
    0.657938725939712612310000000000,
    0.646599601215799663510000000000,
    0.635115769842178747200000000000,
    0.623489801858733530460000000000,
    0.611724299115006347110000000000,
    0.599821894687913689710000000000,
    0.587785252292473129120000000000,
    0.575617065685673537670000000000,
    0.563320058063622027680000000000,
    0.550896981452102522680000000000,
    0.538350616090682349860000000000,
    0.525683769810504692570000000000,
    0.512899277405906143900000000000,
    0.500000000000000000000000000000,
    0.486988824404367264850000000000,
    0.473868662472998670520000000000,
    0.460642450450632297310000000000,
    0.447313148315632630410000000000,
    0.433883739117558120480000000000,
    0.420357228309565491940000000000,
    0.406736643075800207570000000000,
    0.393025031653923618220000000000,
    0.379225462652928408110000000000,
    0.365341024366395014590000000000,
    0.351374824081342704710000000000,
    0.337329987382829991660000000000,
    0.323209657454460013530000000000,
    0.309016994374947424150000000000,
    0.294755174410904216900000000000,
    0.280427389306002757720000000000,
    0.266036845566675107230000000000,
    0.251586763744508489420000000000,
    0.237080377715497507680000000000,
    0.222520933956314404360000000000,
    0.207911690817759336980000000000,
    0.193255917795553265770000000000,
    0.178556894798636647900000000000,
    0.163817911415137692570000000000,
    0.149042266176174447040000000000,
    0.134233265817655475930000000000,
    0.119394224540244337120000000000,
    0.104528463267653471310000000000,
    0.089639308903433499685000000000,
    0.074730093586424254426000000000,
    0.059804153945034169504000000000,
    0.044864830350514925388000000000,
    0.029915466169398454779000000000,
    0.014959407015263618631000000000,
    0.000000000000000000162630325872,
    -0.014959407015263618739000000000,
    -0.029915466169398454887000000000,
    -0.044864830350514925496000000000,
    -0.059804153945034169612000000000,
    -0.074730093586424254535000000000,
    -0.089639308903433499789000000000,
    -0.104528463267653471410000000000,
    -0.119394224540244337230000000000,
    -0.134233265817655476040000000000,
    -0.149042266176174447150000000000,
    -0.163817911415137692680000000000,
    -0.178556894798636648000000000000,
    -0.193255917795553265880000000000,
    -0.207911690817759337080000000000,
    -0.222520933956314404470000000000,
    -0.237080377715497507760000000000,
    -0.251586763744508489530000000000,
    -0.266036845566675107340000000000,
    -0.280427389306002757830000000000,
    -0.294755174410904216980000000000,
    -0.309016994374947424260000000000,
    -0.323209657454460013660000000000,
    -0.337329987382829991770000000000,
    -0.351374824081342704820000000000,
    -0.365341024366395014670000000000,
    -0.379225462652928408200000000000,
    -0.393025031653923618310000000000,
    -0.406736643075800207660000000000,
    -0.420357228309565491810000000000,
    -0.433883739117558120570000000000,
    -0.447313148315632630500000000000,
    -0.460642450450632297400000000000,
    -0.473868662472998670600000000000,
    -0.486988824404367264940000000000,
    -0.500000000000000000080000000000,
    -0.512899277405906143990000000000,
    -0.525683769810504692610000000000,
    -0.538350616090682349950000000000,
    -0.550896981452102522730000000000,
    -0.563320058063622027810000000000,
    -0.575617065685673537750000000000,
    -0.587785252292473129250000000000,
    -0.599821894687913689800000000000,
    -0.611724299115006347370000000000,
    -0.623489801858733530590000000000,
    -0.635115769842178747240000000000,
    -0.646599601215799663590000000000,
    -0.657938725939712612360000000000,
    -0.669130606358858213970000000000,
    -0.680172737770919390210000000000,
    -0.691062648986864675940000000000,
    -0.701797902883991375850000000000,
    -0.712376096951344802300000000000,
    -0.722794863827391528700000000000,
    -0.733051871829826328550000000000,
    -0.743144825477394235010000000000,
    -0.753071466003610933510000000000,
    -0.762829571862266523530000000000,
    -0.772416959224599517040000000000,
    -0.781831482468029808660000000000,
    -0.791071034656341241000000000000,
    -0.800133548011206301070000000000,
    -0.809016994374947424280000000000,
    -0.817719385664431338150000000000,
    -0.826238774315994871880000000000,
    -0.834573253721302650910000000000,
    -0.842720958654039140140000000000,
    -0.850680065687339540500000000000,
    -0.858448793601866118500000000000,
    -0.866025403784438646720000000000,
    -0.873408200617129737170000000000,
    -0.880595531856737995150000000000,
    -0.887585789004554065800000000000,
    -0.894377407666336820660000000000,
    -0.900968867902419126220000000000,
    -0.907358694567864837870000000000,
    -0.913545457642600895390000000000,
    -0.919527772551450638460000000000,
    -0.925304300473996717190000000000,
    -0.930873748644204255550000000000,
    -0.936234870639737209480000000000,
    -0.941386466660903171560000000000,
    -0.946327383799164199500000000000,
    -0.951056516295153572200000000000,
    -0.955572805786140732750000000000,
    -0.959875241542889036030000000000,
    -0.963962860695853291850000000000,
    -0.967834748450666483300000000000,
    -0.971490038292867433790000000000,
    -0.974927912181823607110000000000,
    -0.978147600733805637830000000000,
    -0.981148383394172626100000000000,
    -0.983929588598629655410000000000,
    -0.986490593923521452180000000000,
    -0.988830826225128545110000000000,
    -0.990949761767934755160000000000,
    -0.992846926341837307960000000000,
    -0.994521895368273336950000000000,
    -0.995974293995239029570000000000,
    -0.997203797181180148250000000000,
    -0.998210129767735153050000000000,
    -0.998993066541314647400000000000,
    -0.999552432283503363300000000000,
    -0.999888101810273408750000000000,
    -1.000000000000000000000000000000,
    -0.999888101810273408750000000000,
    -0.999552432283503363220000000000,
    -0.998993066541314647400000000000,
    -0.998210129767735153050000000000,
    -0.997203797181180148250000000000,
    -0.995974293995239029570000000000,
    -0.994521895368273336870000000000,
    -0.992846926341837307960000000000,
    -0.990949761767934755160000000000,
    -0.988830826225128545030000000000,
    -0.986490593923521452090000000000,
    -0.983929588598629655410000000000,
    -0.981148383394172626020000000000,
    -0.978147600733805637910000000000,
    -0.974927912181823607020000000000,
    -0.971490038292867433710000000000,
    -0.967834748450666483130000000000,
    -0.963962860695853291940000000000,
    -0.959875241542889036120000000000,
    -0.955572805786140732830000000000,
    -0.951056516295153572120000000000,
    -0.946327383799164199410000000000,
    -0.941386466660903171560000000000,
    -0.936234870639737209480000000000,
    -0.930873748644204255640000000000,
    -0.925304300473996717010000000000,
    -0.919527772551450638290000000000,
    -0.913545457642600895300000000000,
    -0.907358694567864837790000000000,
    -0.900968867902419126220000000000,
    -0.894377407666336820490000000000,
    -0.887585789004554065630000000000,
    -0.880595531856737995150000000000,
    -0.873408200617129737170000000000,
    -0.866025403784438646720000000000,
    -0.858448793601866118500000000000,
    -0.850680065687339540320000000000,
    -0.842720958654039139880000000000,
    -0.834573253721302650650000000000,
    -0.826238774315994871710000000000,
    -0.817719385664431338150000000000,
    -0.809016994374947424110000000000,
    -0.800133548011206301160000000000,
    -0.791071034656341241040000000000,
    -0.781831482468029808750000000000,
    -0.772416959224599517080000000000,
    -0.762829571862266523570000000000,
    -0.753071466003610933290000000000,
    -0.743144825477394234750000000000,
    -0.733051871829826328250000000000,
    -0.722794863827391528610000000000,
    -0.712376096951344802340000000000,
    -0.701797902883991375890000000000,
    -0.691062648986864675980000000000,
    -0.680172737770919390250000000000,
    -0.669130606358858213890000000000,
    -0.657938725939712612100000000000,
    -0.646599601215799663290000000000,
    -0.635115769842178746980000000000,
    -0.623489801858733530240000000000,
    -0.611724299115006346890000000000,
    -0.599821894687913689880000000000,
    -0.587785252292473129250000000000,
    -0.575617065685673537750000000000,
    -0.563320058063622027850000000000,
    -0.550896981452102522770000000000,
    -0.538350616090682349820000000000,
    -0.525683769810504692310000000000,
    -0.512899277405906143640000000000,
    -0.499999999999999999730000000000,
    -0.486988824404367264630000000000,
    -0.473868662472998670470000000000,
    -0.460642450450632297440000000000,
    -0.447313148315632630540000000000,
    -0.433883739117558120660000000000,
    -0.420357228309565492070000000000,
    -0.406736643075800207530000000000,
    -0.393025031653923617940000000000,
    -0.379225462652928407870000000000,
    -0.365341024366395014300000000000,
    -0.351374824081342704670000000000,
    -0.337329987382829991620000000000,
    -0.323209657454460013900000000000,
    -0.309016994374947424330000000000,
    -0.294755174410904217030000000000,
    -0.280427389306002757660000000000,
    -0.266036845566675107190000000000,
    -0.251586763744508489380000000000,
    -0.237080377715497507390000000000,
    -0.222520933956314404100000000000,
    -0.207911690817759336910000000000,
    -0.193255917795553265720000000000,
    -0.178556894798636647850000000000,
    -0.163817911415137692740000000000,
    -0.149042266176174447190000000000,
    -0.134233265817655475880000000000,
    -0.119394224540244337070000000000,
    -0.104528463267653471250000000000,
    -0.089639308903433499633000000000,
    -0.074730093586424254162000000000,
    -0.059804153945034169447000000000,
    -0.044864830350514925336000000000,
    -0.029915466169398454725000000000,
    -0.014959407015263618576000000000
];
