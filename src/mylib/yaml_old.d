module mylib.yaml;

import yaml.all;
import std.stdio;
import std.string;
import std.conv;
import std.file;
import std.encoding;
import std.c.stdio;
import std.c.stdlib;
import std.c.string;

/// YAMLデータを全て表示
void printall(YamlNode node, int intend = 0){
    switch(node.type){
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
        default:
            assert(false);
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
    string rec(YamlNode node, int ilevel){
        string res = "";
        switch(node.type){
            case NodeType.scalar:
                foreach(i; 0..ilevel-1){ res ~= intend; }
                res ~= (node.str) ~ "\n";
                return res;
            case NodeType.sequence:
                foreach(uint idx,YamlNode n; node){
                    foreach(i; 0..ilevel-1){ res ~= intend; }
                    res ~= "- #" ~ to!(string)(idx) ~ "\n";
                    res ~= rec(n, ilevel+1);
                }
                return res;
            case NodeType.mapping:
                foreach(string k,YamlNode n; node){
                    foreach(i; 0..ilevel-1){ res ~= intend; }
                    res ~= k ~ ":" ~ "\n";
                    res ~= rec(n, ilevel+1);
                }
                return res;
            default:
                assert(false);

        }
    }
    return rec(n, ilevel);
}











/// YAMLデータをファイルからロード
Yaml load_yaml(string path){
    ubyte[] input = cast(ubyte[])(std.file.read(path));
    return new Yaml(input);
}
/// YAMLデータのトップレベル
class Yaml{
private:
    ubyte[] input_data;
    yaml_document_t document;
    YamlNode[] root_nodes;
    
    yaml_parser_t parser;
public:
    /// あらかじめロードされたデータからYAMLデータを生成する
    this(ubyte[] input_data){
        this.input_data = input_data;
        memset(&this.parser, 0, yaml_parser_t.sizeof);
        memset(&this.document, 0, yaml_document_t.sizeof);
        if (!yaml_parser_initialize(&parser)){assert(false);}
        parse();
    }
    /// 作ったらまずこれをすべき
    private void parse(){
        yaml_parser_set_input_string(&this.parser,
                this.input_data.ptr, this.input_data.length);
        while(true){
            if(!yaml_parser_load(&this.parser, &this.document)){assert(false);}
            auto res = yaml_document_get_root_node(&this.document);
            if(res is null){break;}
            this.root_nodes ~= create_yaml_node(res, this.document);
        }
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
    switch(node.type){
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
        default:
            assert(false);
    }
}
/// YAMLNodeの種類
enum NodeType{ scalar, sequence, mapping}
/// YAMLのノードの抽象型
abstract class YamlNode{
private:
    string _tag;
    this(string tag){
        this._tag = tag;
    }
public:
    /// sequence
    /// インデックスを指定子供ノードを取得
    YamlNode opIndex(int idx){assert(false);}
    /// mapping
    /// キー文字を指定して子供ノードを取得
    YamlNode opIndex(string key){assert(false);}
    /// scalar
    /// データを文字列として取得
    string str(){assert(false);}
    /// ノードの種類を取得
    /// See_also: NodeType
    NodeType type(){assert(false);}
    /// foreach用
    int opApply(int delegate(ref YamlNode) dg){assert(false);}
    /// foreach_reverse用
    int opApplyReverse(int delegate(ref YamlNode) dg){assert(false);}
    /// foreach用
    int opApply(int delegate(ref uint, ref YamlNode) dg){assert(false);}
    /// foreach_reverse用
    int opApplyReverse(int delegate(ref uint, ref YamlNode) dg){assert(false);}
    /// foreach用
    int opApply(int delegate(ref string, ref YamlNode) dg){assert(false);}
    /// foreach_reverse用
    int opApplyReverse(int delegate(ref string, ref YamlNode) dg){assert(false);}
    /// 文字列に直す
    override string toString(){
        return toStringYamlNode(this);
    }
    /// 子ノードの数
    int length(){ assert(false); }
    /// 
    final string tag(){return this._tag;}
}
/// スカラー
class ScalarYamlNode : YamlNode{
private:
    yaml_char_t* value; // データ本体(文字列として)
    size_t length;      // valueの長さ
    yaml_scalar_style_t style; // スカラーの型
    this(yaml_node_t* node){
        this.value  = node.data.scalar.value;
        this.length = node.data.scalar.length;
        this.style  = node.data.scalar.style;
        super(to!(string)(node.tag));
    }
public:
    /// データをstr型として取り出す
    override string str(){
        switch(this.style){
            case yaml_scalar_style_t.YAML_ANY_SCALAR_STYLE:
                assert(false);
            case yaml_scalar_style_t.YAML_PLAIN_SCALAR_STYLE:
                return (to!(string)(cast(char*)value));
            case yaml_scalar_style_t.YAML_SINGLE_QUOTED_SCALAR_STYLE:
                return (to!(string)(cast(char*)value))~"single";
            case yaml_scalar_style_t.YAML_DOUBLE_QUOTED_SCALAR_STYLE:
                return (to!(string)(cast(char*)value))~"double";
            case yaml_scalar_style_t.YAML_LITERAL_SCALAR_STYLE:
                assert(false);
            case yaml_scalar_style_t.YAML_FOLDED_SCALAR_STYLE:
                assert(false);
            default:
                assert(false);
        }
        //return (to!(string)(cast(char*)value));
    }
    /// Nodetype.scalarを返す
    override NodeType type(){return NodeType.scalar;}

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
        super(to!(string)(node.tag));
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
    override NodeType type(){return NodeType.sequence;}
    /// 子ノードの数
    override int length(){
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
        super(to!(string)(node.tag));
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

