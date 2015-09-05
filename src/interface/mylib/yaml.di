// D import file generated from 'mylib\yaml.d'
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
enum ScalarStyle 
{
ANY = yaml_scalar_style_t.YAML_ANY_SCALAR_STYLE,
PLAIN = yaml_scalar_style_t.YAML_PLAIN_SCALAR_STYLE,
SINGLE_QUOTED = yaml_scalar_style_t.YAML_SINGLE_QUOTED_SCALAR_STYLE,
DOUBLE_QUOTED = yaml_scalar_style_t.YAML_DOUBLE_QUOTED_SCALAR_STYLE,
LITERAL = yaml_scalar_style_t.YAML_LITERAL_SCALAR_STYLE,
FOLDED = yaml_scalar_style_t.YAML_FOLDED_SCALAR_STYLE,
}
class YamlParseException : Exception
{
    this(string str)
{
super(str);
}
}
class YamlAccessException : Exception
{
    this(string str)
{
super(str);
}
}
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
version (none)
{
    void printall(YamlNode node, int intend = 0);
}
private string toStringYaml(Yaml yaml);

private string toStringYamlNode(YamlNode n, in string intend = "  ", in int ilevel = 0);

Yaml loadYaml(string path);
void saveYaml(string path, Yaml yaml)
{
std.file.write(path,yaml.toString);
}
void saveYaml(string path, YamlNode node)
{
saveYaml(path,new Yaml([node]));
}
class Yaml
{
    private 
{
    ubyte[] inputData;
    yaml_document_t document;
    YamlNode[] rootNodes;
    public 
{
    this(ubyte[] inputData)
{
this.inputData = inputData;
memset(&this.document,0,yaml_document_t.sizeof);
parse();
}
    this(YamlNode[] nodeArray)
{
this.rootNodes = nodeArray;
}
    ~this()
{
yaml_document_delete(&this.document);
}
    private void parse();

    YamlNode opIndex(int idx)
in
{
assert(0 <= idx && idx < this.rootNodes.length,to!(string)(idx) ~ "/" ~ to!(string)(this.rootNodes.length));
}
body
{
return this.rootNodes[idx];
}
    int opApply(int delegate(ref YamlNode) dg);
    int opApply(int delegate(ref uint, ref YamlNode) dg);
    int opApplyReverse(int delegate(ref YamlNode) dg);
    int opApplyReverse(int delegate(ref uint, ref YamlNode) dg);
    override string toString()
{
return toStringYaml(this);
}

    const pure int length()
{
return this.rootNodes.length;
}

}
}
}
private YamlNode createYamlNode(yaml_node_t* node, yaml_document_t document);

enum NodeType 
{
SCALAR,
SEQUENCE,
MAPPING,
}
abstract class YamlNode
{
    private 
{
    string _tag;
    protected 
{
    this(string tag)
{
this._tag = tag;
}
    public 
{
    YamlNode opIndex(int idx);
    YamlNode opIndex(string key);
    const pure string str();

    alias str s;
    double num();
    alias num r;
    int i();
    const pure bool b();

    const pure NodeType type();

    int opApply(int delegate(ref YamlNode) dg);
    int opApplyReverse(int delegate(ref YamlNode) dg);
    int opApply(int delegate(ref uint, ref YamlNode) dg);
    int opApplyReverse(int delegate(ref uint, ref YamlNode) dg);
    int opApply(int delegate(ref string, ref YamlNode) dg);
    int opApplyReverse(int delegate(ref string, ref YamlNode) dg);
    override string toString()
{
return toStringYamlNode(this);
}

    int length();
    const final pure string tag()
{
return this._tag;
}

    ScalarStyle scalarStyle();
    bool opIn_r(string key);
}
}
}
}

class ScalarYamlNode : YamlNode
{
    private 
{
    string value;
    ScalarStyle _scalarStyle;
    this(yaml_node_t* node)
{
this.value = to!(string)(cast(char*)node.data.scalar.value);
this._scalarStyle = cast(ScalarStyle)node.data.scalar.style;
super(to!(string)(cast(char*)node.tag));
}
    public 
{
    this(string data)
{
this.value = data;
this._scalarStyle = ScalarStyle.ANY;
super(YAML_STR_TAG);
}
    this(int data)
{
this(text(data));
}
    this(real data)
{
this(text(data));
}
    const override pure string str()
{
return this.value;
}

    override double num()
{
return to!(double)(this.value);
}

    override int i()
{
return to!(int)(this.value);
}

    const override pure bool b();

    const override pure NodeType type()
{
return NodeType.SCALAR;
}

    override ScalarStyle scalarStyle()
{
return this._scalarStyle;
}

}
}
}
class SequenceYamlNode : YamlNode
{
    private 
{
    YamlNode[] nodeSequence;
    yaml_sequence_style_t style;
    this(yaml_node_t* node, yaml_document_t document);
    public 
{
    this(YamlNode[] dataArray)
{
this.nodeSequence = dataArray;
super(YAML_SEQ_TAG);
}
    override YamlNode opIndex(int idx)
in
{
assert(0 <= idx && idx < nodeSequence.length,to!(string)(nodeSequence.length));
}
body
{
return nodeSequence[idx];
}

    const override pure NodeType type()
{
return NodeType.SEQUENCE;
}

    const override pure int length()
{
return this.nodeSequence.length;
}

    override int opApply(int delegate(ref YamlNode) dg);

    override int opApply(int delegate(ref uint, ref YamlNode) dg);

    override int opApplyReverse(int delegate(ref YamlNode) dg);

    override int opApplyReverse(int delegate(ref uint, ref YamlNode) dg);

}
}
}
class MappingYamlNode : YamlNode
{
    private 
{
    YamlNode[string] nodeMapping;
    yaml_mapping_style_t style;
    this(yaml_node_t* node, yaml_document_t document);
    public 
{
    this(YamlNode[string] nodeMapping)
{
this.nodeMapping = nodeMapping;
this.style = yaml_mapping_style_e.YAML_ANY_MAPPING_STYLE;
super(YAML_MAP_TAG);
}
    override YamlNode opIndex(string key)
in
{
assert(key in this.nodeMapping,key ~ " is not in " ~ text(nodeMapping));
}
body
{
return this.nodeMapping[key];
}

    const override pure NodeType type()
{
return NodeType.MAPPING;
}

    override int length()
{
return this.nodeMapping.length;
}

    override bool opIn_r(string key)
{
return (key in this.nodeMapping) !is null;
}

    override int opApply(int delegate(ref YamlNode) dg);

    override int opApply(int delegate(ref string, ref YamlNode) dg);

    override int opApplyReverse(int delegate(ref YamlNode) dg);

    override int opApplyReverse(int delegate(ref string, ref YamlNode) dg);

}
}
}
template sequence(T)
{
SequenceYamlNode sequence(T[] dataArray)
{
static if(!is(T : YamlNode))
{
YamlNode[] nodeArray;
nodeArray.length = dataArray.length;
foreach (i, d; dataArray)
{
nodeArray[i] = new ScalarYamlNode(text(d));
}
SequenceYamlNode res = new SequenceYamlNode(nodeArray);
return res;
}
else
{
return new SequenceYamlNode(dataArray);
}

}
}
template yn(T)
{
SequenceYamlNode yn(T[] dataArray)
{
return sequence!(T)(dataArray);
}
}
template sequenceList(T)
{
SequenceYamlNode sequenceList(List!(T) dataList)
{
static assert(!is(T : YamlNode));
YamlNode[] nodeArray;
nodeArray.length = dataList.length;
foreach (i, d; dataList)
{
nodeArray[i] = new ScalarYamlNode(text(d));
}
SequenceYamlNode res = new SequenceYamlNode(nodeArray);
return res;
}
}
template yn(T)
{
SequenceYamlNode yn(List!(T) dataList)
{
return sequenceList!(T)(dataList);
}
}
template mapping(T)
{
MappingYamlNode mapping(T[string] dataArray)
{
static if(!is(T : YamlNode))
{
YamlNode[string] nodeMapping;
foreach (s, d; dataArray)
{
nodeMapping[s] = new ScalarYamlNode(text(d));
}
MappingYamlNode res = new MappingYamlNode(nodeMapping);
return res;
}
else
{
return new MappingYamlNode(dataArray);
}

}
}
template yn(T)
{
MappingYamlNode yn(T[string] dataArray)
{
return mapping!(T)(dataArray);
}
}
template scalar(T)
{
ScalarYamlNode scalar(T data)
{
return new ScalarYamlNode(data);
}
}
