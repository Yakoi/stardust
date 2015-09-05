module mylib.yaml;

import mylib.utils;
import yaml.all;
import std.stdio;
import std.string;
import std.conv;
import std.file;
import std.encoding;
import std.c.stdio;
import std.c.stdlib;
import std.c.string;


/// scalarのタイプ(yaml_scalar_style_tのラッパー)
enum ScalarStyle
{
    any           = yaml_scalar_style_t.YAML_ANY_SCALAR_STYLE,
    plain         = yaml_scalar_style_t.YAML_PLAIN_SCALAR_STYLE,
    single_quoted = yaml_scalar_style_t.YAML_SINGLE_QUOTED_SCALAR_STYLE,
    double_quoted = yaml_scalar_style_t.YAML_DOUBLE_QUOTED_SCALAR_STYLE,
    literal       = yaml_scalar_style_t.YAML_LITERAL_SCALAR_STYLE,
    folded        = yaml_scalar_style_t.YAML_FOLDED_SCALAR_STYLE,
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
void printall(YamlNode node, int intend = 0){
    final switch(node.type){
        case NodeType.scalar:
            foreach(i; 0..intend-1){ write("  "); }
            writeln(node.str);
            break;
        case NodeType.sequence:
            foreach(uint idx,YamlNode n; node){
                foreach(i; 0..intend-1){ write("  "); }
                writeln("- #",idx);
                printall(n, intend+1);
            }
            break;
        case NodeType.mapping:
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
        res ~= toStringYamlNode(n, "  ", 1);
    }
    return res;
}
private string toStringYamlNode(YamlNode n, string intend = "  ", int ilevel = 0){
    bool print_tag = true;
    bool print_style = true;
    string rec(YamlNode node, int ilevel){
        string res = "";
        final switch(node.type){
            case NodeType.scalar:
                foreach(i; 0..ilevel-1){ res ~= intend; }
                if(print_tag){
                    res ~= "!" ~ (node.tag);
                    res ~= " ";
                }
                if(print_style){
                    res ~= to!(string)(node.scalar_style);
                    res ~= " ";
                }
                res ~= (node.str);
                res ~= "\n";
                return res;
            case NodeType.sequence:
                foreach(uint idx,YamlNode n; node){
                    foreach(i; 0..ilevel-1){ res ~= intend; }
                    if(print_tag){
                        res ~= "!" ~ (n.tag);
                        res ~= " ";
                    }
                    res ~= "- #" ~ to!(string)(idx) ~ "\n";
                    res ~= rec(n, ilevel+1);
                }
                return res;
            case NodeType.mapping:
                foreach(string k,YamlNode n; node){
                    foreach(i; 0..ilevel-1){ res ~= intend; }
                    if(print_tag){
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
Yaml load_yaml(string path){
    if(!exists(path) ||!isfile(path)){throw new Exception("yaml.load_yaml Load Error : " ~ path);}

    //if(!check_dxfile(path, "dxa")){throw new Exception("yaml.load_yaml Load Error : " ~ path);}
    ubyte[] input = cast(ubyte[])(std.file.read(path));
    return new Yaml(input);
}
/// YAMLデータのトップレベル
class Yaml{
private:
    ubyte[] input_data;
    yaml_document_t document;
    YamlNode[] root_nodes;
public:
    /// あらかじめロードされたデータからYAMLデータを生成する
    this(ubyte[] input_data){
        this.input_data = input_data;
        memset(&this.document, 0, yaml_document_t.sizeof);
        parse();
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
                this.input_data.ptr, this.input_data.length);
        while(true){
            if(!yaml_parser_load(&parser, &this.document)){
                throw new YamlParseException("Parse Error");
            }
            auto res = yaml_document_get_root_node(&this.document);
            if(res is null){break;}
            this.root_nodes ~= create_yaml_node(res, this.document);
        }
        yaml_parser_delete(&parser);
    }
    /// ノードデータを取り出す
    YamlNode opIndex(int idx)
    in{
        assert(0<=idx && idx<this.root_nodes.length,
                to!(string)(idx)~"/"~to!(string)(this.root_nodes.length));
    }body{
        return this.root_nodes[idx];
    }
    /// foreach用
    int opApply(int delegate(ref YamlNode) dg)
    {
        int result = 0;
        foreach (n; this.root_nodes)
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
        foreach (uint i, n; this.root_nodes)
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
        foreach_reverse (n; this.root_nodes)
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
        foreach_reverse (uint i, n; this.root_nodes)
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
    int length(){
        return this.root_nodes.length;
    }
}
// YamlNodeを作ります
private YamlNode create_yaml_node(yaml_node_t* node, yaml_document_t document){
    final switch(node.type){
        /** An empty node. */
        case yaml_node_type_t.YAML_NO_NODE:
            assert(false);
        /** A scalar node. */
        case yaml_node_type_t.YAML_SCALAR_NODE:
            return new ScalarYamlNode(node);
        /** A sequence node. */
        case yaml_node_type_t.YAML_SEQUENCE_NODE:
            return new SequenceYamlNode(node, document);
        /** A mapping node. */
        case yaml_node_type_t.YAML_MAPPING_NODE:
            return new MappingYamlNode(node, document);
    }
}
/// YAMLNodeの種類
enum NodeType{ scalar, sequence, mapping}
/// YAMLのノードの抽象型
abstract class YamlNode{
private:
    string _tag;
protected:
    this(string tag){
        this._tag = tag;
    }
public:
    /// sequence
    /// インデックスを指定子供ノードを取得
    YamlNode opIndex(int idx) {
        throw new YamlAccessException("YamlNode.opIndex(int)");
    }
    /// mapping
    /// キー文字を指定して子供ノードを取得
    YamlNode opIndex(string key) {
        throw new YamlAccessException("YamlNode.opIndex(key)");
    }
    /// scalar
    /// データを文字列として取得
    string str() {
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
    bool b(){
        throw new YamlAccessException("YamlNode.b()");
    }
    /// ノードの種類を取得
    /// See_also: NodeType
    NodeType type(){
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
    /// scalar style
    ScalarStyle scalar_style(){
        throw new YamlAccessException("YamlNode.scalar_style()");
    }
    /// Mappingにおいて，keyをハッシュキーに持つ要素があるかどうか
    bool opIn_r(string key){
        throw new YamlAccessException("YamlNode.opIn()");
    }
}
/// スカラー
class ScalarYamlNode : YamlNode{
private:
    string value; // データ本体(文字列として)
    ScalarStyle _scalar_style; // スカラーの型
    this(yaml_node_t* node){
        this.value  = to!(string)(cast(char*)node.data.scalar.value);
        this._scalar_style  = cast(ScalarStyle)node.data.scalar.style;
        super(to!(string)(cast(char*)node.tag));
    }
public:
    /// データをstr型として取り出す
    override string str(){
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
    override bool b(){
        const string[6] t = ["true", "True", "on", "On", "yes", "Yes"];
        const string[6] f = ["false", "False", "off", "Off", "no", "No"];
        if(contain!(string)(t,this.value)){return true;}
        if(contain!(string)(f,this.value)){return false;}
        throw new Exception("ScalarYamlNode.b() : " ~ this.value ~ " is not bool type");
    }
    /// Nodetype.scalarを返す
    override NodeType type(){return NodeType.scalar;}
    /// scalarの種類
    override ScalarStyle scalar_style(){return this._scalar_style;}

}
/// シークエンス(配列)
class SequenceYamlNode : YamlNode{
private:
    YamlNode[] node_sequence;    // 子ノード
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
                    this.node_sequence ~= create_yaml_node(node, document);
                }else{
                    assert(false, to!(string)(this.node_sequence.length));
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
    /// 子ノード取得
    override YamlNode opIndex(int idx)
    in{
        assert(0<=idx && idx<node_sequence.length, 
                to!(string)(node_sequence.length));
    }body{
        return node_sequence[idx];
    }
    /// NodeType.sequenceを返す
    const pure override NodeType type(){return NodeType.sequence;}
    /// 子ノードの数
    const pure override int length(){
        return this.node_sequence.length;
    }
    /// foreach用
    override int opApply(int delegate(ref YamlNode) dg)
    {
        int result = 0;
        foreach (n; this.node_sequence)
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
        foreach (uint i, n; this.node_sequence)
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
        foreach_reverse (n; this.node_sequence)
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
        foreach_reverse (uint i, n; this.node_sequence)
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
    YamlNode[string] node_mapping;
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
                    auto key = create_yaml_node(key_, document);
                    this.node_mapping[key.str] = create_yaml_node(node, document);
                }else{
                    assert(false, to!(string)(this.node_mapping.length));
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
    /// 子ノード取得
    override YamlNode opIndex(string key)
    in{
        assert(key in this.node_mapping);
    }body{
        return this.node_mapping[key];
    }
    /// NodeType.mapping を返す
    override NodeType type(){return NodeType.mapping;}
    /// 子ノードの数
    override int length(){
        return this.node_mapping.length;
    }
    override bool opIn_r(string key){
        return (key in this.node_mapping)!is null;
    }
    /// foreach用
    override int opApply(int delegate(ref YamlNode) dg)
    {
        int result = 0;
        foreach (n; this.node_mapping)
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
        foreach (string k, n; this.node_mapping)
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
        foreach (n; this.node_mapping)
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
        foreach (string k, n; this.node_mapping)
        {
            result = dg(k, n);
            if (result){ break;}
        }
        return result;
    }
}

