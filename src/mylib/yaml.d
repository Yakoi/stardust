module mylib.yaml;

import mylib.utils;
import mylib.list;
import yaml.all;
import std.stdio;
import std.string;
import std.conv;
import std.file;
import std.encoding;
import std.c.stdio;
import std.c.stdlib;
import std.c.string;


/// SCALARのタイプ(yaml_scalarStyle_tのラッパー)
enum ScalarStyle
{
    ANY           = yaml_scalar_style_t.YAML_ANY_SCALAR_STYLE,
    PLAIN         = yaml_scalar_style_t.YAML_PLAIN_SCALAR_STYLE,
    SINGLE_QUOTED = yaml_scalar_style_t.YAML_SINGLE_QUOTED_SCALAR_STYLE,
    DOUBLE_QUOTED = yaml_scalar_style_t.YAML_DOUBLE_QUOTED_SCALAR_STYLE,
    LITERAL       = yaml_scalar_style_t.YAML_LITERAL_SCALAR_STYLE,
    FOLDED        = yaml_scalar_style_t.YAML_FOLDED_SCALAR_STYLE,
}
class YamlParseException : Exception{
    this(string str){super(str);}
}
class YamlAccessException : Exception{
    this(string str){super(str);}
}
/// 
const string YAML_NULL_TAG = "tag:yaml.org,2002:null";
const string YAML_BOOL_TAG = "tag:yaml.org,2002:bool";
const string YAML_STR_TAG = "tag:yaml.org,2002:str";
const string YAML_INT_TAG = "tag:yaml.org,2002:int";
const string YAML_FLOAT_TAG = "tag:yaml.org,2002:float";
const string YAML_TIMESTAMP_TAG = "tag:yaml.org,2002:timestamp";
const string YAML_SEQ_TAG = "tag:yaml.org,2002:seq";
const string YAML_MAP_TAG = "tag:yaml.org,2002:map";
alias YAML_STR_TAG YAML_DEFAULT_SCALAR_TAG;
alias YAML_SEQ_TAG YAML_DEFAULT_SEQUENCE_TAG;
alias YAML_MAP_TAG YAML_DEFAULT_MAPPING_TAG;

/// YAMLデータを全て表示
version(none)
void printall(YamlNode node, int intend = 0){
    final switch(node.type){
        case NodeType.SCALAR:
            foreach(i; 0..intend-1){ write("  "); }
            writeln(node.str);
            break;
        case NodeType.SEQUENCE:
            foreach(uint idx,YamlNode n; node){
                foreach(i; 0..intend-1){ write("  "); }
                writeln("- #",idx);
                printall(n, intend+1);
            }
            break;
        case NodeType.MAPPING:
            foreach(string k,YamlNode n; node){
                foreach(i; 0..intend-1){ write("  "); }
                writeln(k,":");
                printall(n, intend+1);
            }
            break;
    }
}
private string toStringYaml(Yaml yaml){
    string res = "";
    foreach(uint i, YamlNode n; yaml){
        if(i!=0){res ~= "---\n";}
        res ~= toStringYamlNode(n, "  ", 0);
    }
    return res;
}
private string toStringYamlNode(YamlNode n, in string intend = "  ", in int ilevel = 0){
    const bool printTag = !true;
    const bool printStyle = !true;
    string rec(YamlNode node, in int ilevel){
        string res = "";
        final switch(node.type){
            case NodeType.SCALAR:
                foreach(i; 0..ilevel){ res ~= intend; }
                if(printTag){
                    res ~= "!" ~ (node.tag);
                    res ~= " ";
                }
                if(printStyle){
                    res ~= to!(string)(node.scalarStyle);
                    res ~= " ";
                }
                res ~= (node.str);
                res ~= "\n";
                return res;
            case NodeType.SEQUENCE:
                foreach(uint idx,YamlNode n; node){
                    foreach(i; 0..ilevel){ res ~= intend; }
                    if(printTag){
                        res ~= "!" ~ (n.tag);
                        res ~= " ";
                    }
                    res ~= "- #" ~ to!(string)(idx) ~ "\n";
                    res ~= rec(n, ilevel+1);
                }
                return res;
            case NodeType.MAPPING:
                foreach(string k,YamlNode n; node){
                    foreach(i; 0..ilevel){ res ~= intend; }
                    if(printTag){
                        res ~= "!" ~ (n.tag);
                        res ~= " ";
                    }
                    res ~= k ~ ":" ~ "\n";
                    res ~= rec(n, ilevel+1);
                }
                return res;
        }
    }
    return rec(n, ilevel);
}








/// YAMLデータをファイルからロード
Yaml loadYaml(string path){
    if(!exists(path) ||!isFile(path)){throw new Exception("yaml.loadYaml Load Error : " ~ path);}

    //if(!check_dxfile(path, "dxa")){throw new Exception("yaml.loadYaml Load Error : " ~ path);}
    ubyte[] input = cast(ubyte[])(std.file.read(path));
    return new Yaml(input);
}
void saveYaml(string path, Yaml yaml){
    std.file.write(path, yaml.toString);
}
void saveYaml(string path, YamlNode node){
    saveYaml(path, new Yaml([node]));
}
/// YAMLデータのトップレベル
class Yaml{
private:
    ubyte[] inputData;
    yaml_document_t document;
    YamlNode[] rootNodes;
public:
    /// あらかじめロードされたデータからYAMLデータを生成する
    this(ubyte[] inputData){
        this.inputData = inputData;
        memset(&this.document, 0, yaml_document_t.sizeof);
        parse();
    }
    this(YamlNode[] nodeArray){
        this.rootNodes = nodeArray;
    }
    /// デストラクタ
    ~this(){
        yaml_document_delete(&this.document);
    }
    /// 作ったらまずこれをすべき
    private void parse(){
        yaml_parser_t parser;
        memset(&parser, 0, yaml_parser_t.sizeof);
        if (!yaml_parser_initialize(&parser)){assert(false);}
        yaml_parser_set_input_string(&parser,
                this.inputData.ptr, this.inputData.length);
        while(true){
            if(!yaml_parser_load(&parser, &this.document)){
                throw new YamlParseException("Parse Error");
            }
            auto res = yaml_document_get_root_node(&this.document);
            if(res is null){break;}
            this.rootNodes ~= createYamlNode(res, this.document);
        }
        yaml_parser_delete(&parser);
    }
    /// ノードデータを取り出す
    YamlNode opIndex(int idx)
    in{
        assert(0<=idx && idx<this.rootNodes.length,
                to!(string)(idx)~"/"~to!(string)(this.rootNodes.length));
    }body{
        return this.rootNodes[idx];
    }
    /// foreach用
    int opApply(int delegate(ref YamlNode) dg)
    {
        int result = 0;
        foreach (n; this.rootNodes)
        {
            result = dg(n);
            if (result){ break;}
        }
        return result;
    }
    /// foreach用
    int opApply(int delegate(ref uint, ref YamlNode) dg)
    {
        int result = 0;
        foreach (uint i, n; this.rootNodes)
        {
            result = dg(i, n);
            if (result){ break;}
        }
        return result;
    }
    /// foreach_reverse用
    int opApplyReverse(int delegate(ref YamlNode) dg)
    {
        int result = 0;
        foreach_reverse (n; this.rootNodes)
        {
            result = dg(n);
            if (result){ break;}
        }
        return result;
    }
    /// foreach_reverse用
    int opApplyReverse(int delegate(ref uint, ref YamlNode) dg)
    {
        int result = 0;
        foreach_reverse (uint i, n; this.rootNodes)
        {
            result = dg(i, n);
            if (result){ break;}
        }
        return result;
    }
    /// 文字列に変換
    /// バグが無ければそのままYAMLデータとして利用可能
    override string toString(){
        return toStringYaml(this);
    }
    /// 子ノードの数
    const pure int length(){
        return this.rootNodes.length;
    }
}
// YamlNodeを作ります
private YamlNode createYamlNode(yaml_node_t* node, yaml_document_t document){
    final switch(node.type){
        /** An empty node. */
        case yaml_node_type_t.YAML_NO_NODE:
            assert(false);
        /** A SCALAR node. */
        case yaml_node_type_t.YAML_SCALAR_NODE:
            return new ScalarYamlNode(node);
        /** A SEQUENCE node. */
        case yaml_node_type_t.YAML_SEQUENCE_NODE:
            return new SequenceYamlNode(node, document);
        /** A MAPPING node. */
        case yaml_node_type_t.YAML_MAPPING_NODE:
            return new MappingYamlNode(node, document);
    }
}
/// YAMLNodeの種類
enum NodeType{ SCALAR, SEQUENCE, MAPPING}
/// YAMLのノードの抽象型
abstract class YamlNode{
private:
    string _tag;
protected:
    this(string tag){
        this._tag = tag;
    }
public:
    /// SEQUENCE
    /// インデックスを指定子供ノードを取得
    YamlNode opIndex(int idx) 
    in{
        // no contract
    }body{
        throw new YamlAccessException("YamlNode.opIndex(int)");
    }
    /// MAPPING
    /// キー文字を指定して子供ノードを取得
    YamlNode opIndex(string key) 
    in{
        // no contract
    }body{
        throw new YamlAccessException("YamlNode.opIndex(key)");
    }
    /// SCALAR
    /// データを文字列として取得
    const pure string str() {
        throw new YamlAccessException("YamlNode.str()");
    }
    alias str s;
    /// データをdoubleとして取得
    double num(){
        throw new YamlAccessException("YamlNode.num()");
    }
    alias num r;
    /// データをintとして取得
    int i(){
        throw new YamlAccessException("YamlNode.num()");
    }
    /// データをboolとして取得
    const pure bool b(){
        throw new YamlAccessException("YamlNode.b()");
    }
    /// ノードの種類を取得
    /// See_also: NodeType
    const pure NodeType type(){
        throw new YamlAccessException("YamlNode.type()");
    }
    /// foreach用
    int opApply(int delegate(ref YamlNode) dg){
        throw new YamlAccessException("YamlNode.foreach(YamlNode)");
    }
    /// foreach_reverse用
    int opApplyReverse(int delegate(ref YamlNode) dg){
        throw new YamlAccessException("YamlNode.foreach_reverse(YamlNode)");
    }
    /// foreach用
    int opApply(int delegate(ref uint, ref YamlNode) dg){
        throw new YamlAccessException("YamlNode.foreach(uint, YamlNode)");
    }
    /// foreach_reverse用
    int opApplyReverse(int delegate(ref uint, ref YamlNode) dg){
        throw new YamlAccessException("YamlNode.foreach_reverse(uint, YamlNode)");
    }
    /// foreach用
    int opApply(int delegate(ref string, ref YamlNode) dg){
        throw new YamlAccessException("YamlNode.foreach(string, YamlNode)");
    }
    /// foreach_reverse用
    int opApplyReverse(int delegate(ref string, ref YamlNode) dg){
        throw new YamlAccessException("YamlNode.foreach_reverse(string, YamlNode)");
    }
    /// 文字列に直す
    override string toString(){
        return toStringYamlNode(this);
    }
    /// 子ノードの数
    int length(){
        throw new YamlAccessException("YamlNode.length()");
    }
    /// tag
    pure const final string tag(){return this._tag;}
    /// SCALAR style
    ScalarStyle scalarStyle(){
        throw new YamlAccessException("YamlNode.scalarStyle()");
    }
    /// MAPPINGにおいて，keyをハッシュキーに持つ要素があるかどうか
    bool opIn_r(string key){
        throw new YamlAccessException("YamlNode.opIn()");
    }
}
/// スカラー
class ScalarYamlNode : YamlNode{
private:
    string value; // データ本体(文字列として)
    ScalarStyle _scalarStyle; // スカラーの型
    this(yaml_node_t* node){
        this.value  = to!(string)(cast(char*)node.data.scalar.value);
        this._scalarStyle  = cast(ScalarStyle)node.data.scalar.style;
        super(to!(string)(cast(char*)node.tag));
    }
public:
    this(string data){
        this.value = data;
        this._scalarStyle = ScalarStyle.ANY; //???
        super(YAML_STR_TAG);
    }
    this(int data){
        this(text(data));
    }
    this(real data){
        this(text(data));
    }
    /// データをstr型として取り出す
    const pure override string str(){
        return this.value;
    }
    /// データをdoubleとして取得
    override double num(){
        return to!(double)(this.value);
    }
    /// データをintとして取得
    override int i(){
        return to!(int)(this.value);
    }
    /// データをboolとして取得
    const pure override bool b(){
        const string[6] t = ["true", "True", "on", "On", "yes", "Yes"];
        const string[6] f = ["false", "False", "off", "Off", "no", "No"];
        if(contain!(string)(t,this.value)){return true;}
        if(contain!(string)(f,this.value)){return false;}
        throw new Exception("ScalarYamlNode.b() : " ~ this.value ~ " is not bool type");
    }
    /// Nodetype.SCALARを返す
    const pure override NodeType type(){return NodeType.SCALAR;}
    /// SCALARの種類
    override ScalarStyle scalarStyle(){return this._scalarStyle;}

}
/// シークエンス(配列)
class SequenceYamlNode : YamlNode{
private:
    YamlNode[] nodeSequence;    // 子ノード
    yaml_sequence_style_t style; // シーケンスのタイプ
    this(yaml_node_t* node, yaml_document_t document){
        void rec(
                in yaml_node_item_t* st,
                in yaml_node_item_t* en,
                in yaml_node_item_t* tp){
            if(st == tp){
                return;
            }else{
                yaml_node_t* node = (yaml_document_get_node(&document, *st));
                if(node !is null){
                    this.nodeSequence ~= createYamlNode(node, document);
                }else{
                    assert(false, to!(string)(this.nodeSequence.length));
                }
                rec(st+1, en, tp);
            }
        }
        auto start  = node.data.sequence.items.start;
        auto end    = node.data.sequence.items.end;
        auto top    = node.data.sequence.items.top;
        style  = node.data.sequence.style;
        rec(start, end, top);
        super(to!(string)(cast(char*)node.tag));
    }
public:
    this(YamlNode[] dataArray){
        this.nodeSequence = dataArray;
        //this.style = yaml_sequence_style_e.YAML_ANY_SEQUENCE_STYLE; // ???
        super(YAML_SEQ_TAG);
    }
    /// 子ノード取得
    override YamlNode opIndex(int idx)
    in{
        assert(0<=idx && idx<nodeSequence.length, 
                to!(string)(nodeSequence.length));
    }body{
        return nodeSequence[idx];
    }
    /// NodeType.SEQUENCEを返す
    const pure override NodeType type(){return NodeType.SEQUENCE;}
    /// 子ノードの数
    const pure override int length(){
        return this.nodeSequence.length;
    }
    /// foreach用
    override int opApply(int delegate(ref YamlNode) dg)
    {
        int result = 0;
        foreach (n; this.nodeSequence)
        {
            result = dg(n);
            if (result){ break;}
        }
        return result;
    }
    /// foreach用
    override int opApply(int delegate(ref uint, ref YamlNode) dg)
    {
        int result = 0;
        foreach (uint i, n; this.nodeSequence)
        {
            result = dg(i, n);
            if (result){ break;}
        }
        return result;
    }
    /// foreach_reverse用
    override int opApplyReverse(int delegate(ref YamlNode) dg)
    {
        int result = 0;
        foreach_reverse (n; this.nodeSequence)
        {
            result = dg(n);
            if (result){ break;}
        }
        return result;
    }
    /// foreach_reverse用
    override int opApplyReverse(int delegate(ref uint, ref YamlNode) dg)
    {
        int result = 0;
        foreach_reverse (uint i, n; this.nodeSequence)
        {
            result = dg(i, n);
            if (result){ break;}
        }
        return result;
    }
}
/// マッピング(連想配列、ハッシュ、辞書)
class MappingYamlNode : YamlNode{
private:
    YamlNode[string] nodeMapping;
    yaml_mapping_style_t style;
    
    this(yaml_node_t* node, yaml_document_t document){
        void rec(
                in yaml_node_pair_t* st,
                in yaml_node_pair_t* en,
                in yaml_node_pair_t* tp){
            if(st == tp){
                return;
            }else{
                yaml_node_t* node = (yaml_document_get_node(&document, st.value));
                if(node !is null){
                    auto key_ = yaml_document_get_node(&document, st.key);
                    auto key = createYamlNode(key_, document);
                    this.nodeMapping[key.str] = createYamlNode(node, document);
                }else{
                    assert(false, to!(string)(this.nodeMapping.length));
                }
                rec(st+1, en, tp);
            }
        }
        auto start  = node.data.mapping.pairs.start;
        auto end    = node.data.mapping.pairs.end;
        auto top    = node.data.mapping.pairs.top;
        style       = node.data.mapping.style;
        rec(start, end, top);
        super(to!(string)(cast(char*)node.tag));
    }
public:
    this(YamlNode[string] nodeMapping){
        this.nodeMapping = nodeMapping;
        this.style = yaml_mapping_style_e.YAML_ANY_MAPPING_STYLE;
        super(YAML_MAP_TAG);
    }
    /// 子ノード取得
    override YamlNode opIndex(string key)
    in{
        assert(key in this.nodeMapping, key ~ " is not in " ~ text(nodeMapping));
    }body{
        return this.nodeMapping[key];
    }
    /// NodeType.MAPPING を返す
    const pure override NodeType type(){return NodeType.MAPPING;}
    /// 子ノードの数
    override int length(){
        return this.nodeMapping.length;
    }
    override bool opIn_r(string key){
        return (key in this.nodeMapping)!is null;
    }
    /// foreach用
    override int opApply(int delegate(ref YamlNode) dg)
    {
        int result = 0;
        foreach (n; this.nodeMapping)
        {
            result = dg(n);
            if (result){ break;}
        }
        return result;
    }
    /// foreach用
    override int opApply(int delegate(ref string, ref YamlNode) dg)
    {
        int result = 0;
        foreach (string k, n; this.nodeMapping)
        {
            result = dg(k, n);
            if (result){ break;}
        }
        return result;
    }
    /// foreach_reverse用
    override int opApplyReverse(int delegate(ref YamlNode) dg)
    {
        int result = 0;
        foreach (n; this.nodeMapping)
        {
            result = dg(n);
            if (result){ break;}
        }
        return result;
    }
    /// foreach_reverse用
    override int opApplyReverse(int delegate(ref string, ref YamlNode) dg)
    {
        int result = 0;
        foreach (string k, n; this.nodeMapping)
        {
            result = dg(k, n);
            if (result){ break;}
        }
        return result;
    }
}



SequenceYamlNode sequence(T)(T[] dataArray){
    static if(!is(T : YamlNode)){
        YamlNode[] nodeArray;
        nodeArray.length = dataArray.length;
        foreach(i,d; dataArray){
            nodeArray[i] = new ScalarYamlNode(text(d));
        }
        SequenceYamlNode res = new SequenceYamlNode(nodeArray);
        return res;
    }else{
        return new SequenceYamlNode(dataArray);
    }
}
SequenceYamlNode yn(T)(T[] dataArray){
    return sequence!(T)(dataArray);
}
SequenceYamlNode sequenceList(T)(List!(T) dataList){
    static assert(!is(T : YamlNode));
    YamlNode[] nodeArray;
    nodeArray.length = dataList.length;
    foreach(i,d; dataList){
        nodeArray[i] = new ScalarYamlNode(text(d));
    }
    SequenceYamlNode res = new SequenceYamlNode(nodeArray);
    return res;
}
SequenceYamlNode yn(T)(List!(T) dataList){
    return sequenceList!(T)(dataList);
}
MappingYamlNode mapping(T)(T[string] dataArray){
    static if(!is(T : YamlNode)){
        YamlNode[string] nodeMapping;
        foreach(s,d; dataArray){
            nodeMapping[s] = new ScalarYamlNode(text(d));
        }
        MappingYamlNode res = new MappingYamlNode(nodeMapping);
        return res;
    }else{
        return new MappingYamlNode(dataArray);
    }
}
MappingYamlNode yn(T)(T[string] dataArray){
    return mapping!(T)(dataArray);
}
ScalarYamlNode scalar(T)(T data){
    return new ScalarYamlNode(data);
}
