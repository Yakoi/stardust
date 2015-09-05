
import std.stdio;
import std.conv;


enum NodeType{ SCALAR, SEQUENCE, MAPPING}
/// Scalar and Sequence and Mapping
template Ssm(T){
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
            throw new Exception("Node.opIndex(key)");
        }
        /// scalar
        /// データを取得
        @property const pure T data() {
            throw new Exception("Node.data()");
        }
        /// 子ノードの数
        @property const int length(){
            throw new Exception("Node.length()");
        }
        /// foreach用
        int opApply(int delegate(ref Node) dg){
            throw new Exception("Node.foreach(Node)");
        }
        /// foreach_reverse用
        int opApplyReverse(int delegate(ref Node) dg){
            throw new Exception("Node.foreach_reverse(Node)");
        }
        /// foreach用
        int opApply(int delegate(ref uint, ref Node) dg){
            throw new Exception("Node.foreach(uint, Node)");
        }
        /// foreach_reverse用
        int opApplyReverse(int delegate(ref uint, ref Node) dg){
            throw new Exception("Node.foreach_reverse(uint, Node)");
        }
        /// foreach用
        int opApply(int delegate(ref string, ref Node) dg){
            throw new Exception("Node.foreach(string, Node)");
        }
        /// foreach_reverse用
        int opApplyReverse(int delegate(ref string, ref Node) dg){
            throw new Exception("Node.foreach_reverse(string, Node)");
        }
        /// ノードの種類を取得
        /// See_also: NodeType
        @property abstract const pure NodeType type();

    }
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
    }
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
        pure Node opIndex(int idx) {
            return cast(Node)this.nodeArray[idx];
        }
        /// 子ノードの数
        @property const int length(){
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
    }
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
        pure Node opIndex(string key) {
            return cast(Node)this.nodeMapping[key];
        }
        /// 子ノードの数
        @property const int length(){
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
        /// ノードの種類を取得
        /// See_also: NodeType
        @property const pure override NodeType type(){return NodeType.MAPPING;}
    }
}

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
