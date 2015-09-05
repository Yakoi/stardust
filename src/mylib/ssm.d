module mylib.ssm;

import std.stdio;
import std.conv;

import mylib.yaml;




enum NodeType{ SCALAR, SEQUENCE, MAPPING}
/// Scalar and Sequence and Mapping
template Ssm(T){
    version(none) Node yamlNodeToSsm(YamlNode yn, T delegate(YamlNode) fun){
        final switch(yn.type){
            case mylib.yaml.NodeType.SCALAR:
                return new ScalarNode(fun(yn));
            case mylib.yaml.NodeType.SEQUENCE:
                Node[] nodes;
                nodes.length = yn.length;
                foreach(uint i,YamlNode n; yn){
                    nodes[i] = yamlNodeToSsm(yn[i], fun);
                }
                return new SequenceNode(nodes);
            case mylib.yaml.NodeType.MAPPING:
                Node[string] nodes;
                foreach(string s,YamlNode n; yn){
                    nodes[s] = yamlNodeToSsm(yn[s], fun);
                }
                return new MappingNode(nodes);
        }
    } // version
    /// Base type
    private abstract class Node{
        /// sequence
        /// インデックスを指定子供ノードを取得
        pure Node opIndex(int idx) {
            throw new Exception("Node.opIndex(int)");
        }
        /// mapping
        /// キー文字を指定して子供ノードを取得
        pure Node opIndex(string key) {
            throw new Exception("Node.opIndex(string)");
        }
        /// scalar
        /// データを取得
        @property const pure T data() {
            throw new Exception("Node.data()");
        }
        /// sequence or mapping
        /// 子ノードの数
        @property const int length(){
            throw new Exception("Node.length()");
        }
        /// sequence or mapping
        /// foreach用
        int opApply(int delegate(ref Node) dg){
            throw new Exception("Node.foreach(Node)");
        }
        /// sequence or mapping
        /// foreach_reverse用
        int opApplyReverse(int delegate(ref Node) dg){
            throw new Exception("Node.foreach_reverse(Node)");
        }
        /// sequence
        /// foreach用
        int opApply(int delegate(ref uint, ref Node) dg){
            throw new Exception("Node.foreach(uint, Node)");
        }
        /// sequence
        /// foreach_reverse用
        int opApplyReverse(int delegate(ref uint, ref Node) dg){
            throw new Exception("Node.foreach_reverse(uint, Node)");
        }
        /// mapping
        /// foreach用
        int opApply(int delegate(ref string, ref Node) dg){
            throw new Exception("Node.foreach(string, Node)");
        }
        /// mapping
        /// foreach_reverse用
        int opApplyReverse(int delegate(ref string, ref Node) dg){
            throw new Exception("Node.foreach_reverse(string, Node)");
        }
        /// mapping
        /// MAPPINGにおいて，keyをハッシュキーに持つ要素があるかどうか
        const pure bool opIn_r(string key){
            throw new Exception("Node.opIn_r(string)");
        }
        /// all
        /// ノードの種類を取得
        /// See_also: NodeType
        @property abstract const pure NodeType type();
        /// all
        /// 文字列に直す
        @property override abstract string toString();

    } // class Node
    /// scalar
    final class ScalarNode : Node{
    private:
        T d;
    public:
        this(T d){
            this.d = d;
        }
        /// scalar
        /// データを取得
        @property override const pure nothrow T data() {
            return cast(T)this.d;
        }
        /// ノードの種類を取得
        /// See_also: NodeType
        const pure nothrow override NodeType type(){return NodeType.SCALAR;}
        /// 文字列に直す
        @property override string toString(){
            return text(this.data);
        }
    } // class ScalarNode
    /// sequence
    final class SequenceNode : Node{
    private:
        Node[] nodeArray;
    public:
        this(Node[] nodeArray){
            this.nodeArray = nodeArray;
        }
        /// sequence
        /// インデックスを指定子供ノードを取得
        override pure Node opIndex(int idx) {
            return cast(Node)this.nodeArray[idx];
        }
        /// 子ノードの数
        override @property const int length(){
            return this.nodeArray.length;
        }
        /// foreach用
        override int opApply(int delegate(ref Node) dg)
        {
            int result = 0;
            foreach (n; this.nodeArray)
            {
                result = dg(n);
                if (result){ break;}
            }
            return result;
        }
        /// foreach用
        override int opApply(int delegate(ref uint, ref Node) dg)
        {
            int result = 0;
            foreach (uint i, n; this.nodeArray)
            {
                result = dg(i, n);
                if (result){ break;}
            }
            return result;
        }
        /// foreach_reverse用
        override int opApplyReverse(int delegate(ref Node) dg)
        {
            int result = 0;
            foreach_reverse (n; this.nodeArray)
            {
                result = dg(n);
                if (result){ break;}
            }
            return result;
        }
        /// foreach_reverse用
        override int opApplyReverse(int delegate(ref uint, ref Node) dg)
        {
            int result = 0;
            foreach_reverse (uint i, n; this.nodeArray)
            {
                result = dg(i, n);
                if (result){ break;}
            }
            return result;
        }
        /// ノードの種類を取得
        /// See_also: NodeType
        @property const pure nothrow override NodeType type(){return NodeType.SEQUENCE;}
        /// 文字列に直す
        @property override string toString(){
            string res = "";
            res ~= "[";
            foreach(uint i, Node node; this.nodeArray){
                res ~= node.toString() ~ ", ";
            }
            res = res[0..$-2] ~ "]";
            return res;
        }
    } // class SequenceNode
    /// mapping
    final class MappingNode : Node{
    private:
        Node[string] nodeMapping;
    public:
        nothrow this(Node[string] nodeMapping){
            this.nodeMapping = nodeMapping;
        }
        /// mapping
        /// キー文字を指定して子供ノードを取得
        override pure Node opIndex(string key) {
            return cast(Node)this.nodeMapping[key];
        }
        /// 子ノードの数
        override @property const int length(){
            return this.nodeMapping.length;
        }
        /// foreach用
        override int opApply(int delegate(ref Node) dg)
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
        override int opApply(int delegate(ref string, ref Node) dg)
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
        override int opApplyReverse(int delegate(ref Node) dg)
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
        override int opApplyReverse(int delegate(ref string, ref Node) dg)
        {
            int result = 0;
            foreach (string k, n; this.nodeMapping)
            {
                result = dg(k, n);
                if (result){ break;}
            }
            return result;
        }
        /// MAPPINGにおいて，keyをハッシュキーに持つ要素があるかどうか
        override const pure bool opIn_r(string key){
            return cast(bool)(key in this.nodeMapping);
        }
        /// ノードの種類を取得
        /// See_also: NodeType
        @property const pure override NodeType type(){return NodeType.MAPPING;}
        /// 文字列に直す
        @property override string toString(){
            string res = "";
            res ~= "[";
            foreach(string s, Node node; this.nodeMapping){
                res ~= s ~ " : " ~ node.toString() ~ ", ";
            }
            res = res[0..$-2] ~ "]";
            return res;
        }
    } // class MappingNode
} // template Ssm(T)



version(all){

class Data{
    int a=0;
    this(int a){
        this.a = a;
    }
    override string toString(){
        return to!(string)(this.a);
    }
}

alias Ssm!(Data) DSsm;
alias DSsm.Node DNode;
alias DSsm.ScalarNode DScalar;
alias DSsm.SequenceNode DSeq;
alias DSsm.MappingNode DMap;
int main(string[] args){
    DNode a = new DScalar(new Data(3));
    DNode b = new DScalar(new Data(4));
    DNode c = new DScalar(new Data(6));
    DNode d = new DScalar(new Data(5));
    auto f = new DSeq([a,c]);
    DSsm.Node[] ggg = [a,b,c,d,f,a];

    auto e = new DSeq(ggg);
    foreach_reverse(i,d; e){
        if(d.type == NodeType.SCALAR){
            writeln(i," ", d.data);
        }
    }

    return 0;
}


}// version
