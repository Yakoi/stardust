// D import file generated from 'mylib\list.d'
module mylib.list;
import std.stdio;
import std.conv;
template List(T)
{
class List
{
    const abstract pure uint length();

    const final pure uint size()
{
return this.length();
}

    abstract int opApply(int delegate(ref T) dg);

    abstract int opApply(int delegate(ref uint, ref T) dg);

    abstract int opApplyReverse(int delegate(ref T) dg);

    abstract int opApplyReverse(int delegate(ref uint, ref T) dg);

    const abstract pure bool empty();

    const final pure bool empty_()
{
return this.empty();
}

    abstract void pushFront(T data);

    abstract void pushBack(T data);

    abstract T popFront();

    abstract T popBack();

    abstract T front_();

    abstract T back_();

    abstract void clear();

    final void erase()
{
this.clear();
}

    final void extend(List!(T) l2)
{
foreach (d; l2)
{
this.pushBack(d);
}
}

    abstract void remove(bool delegate(T) con);

    abstract void leave(bool delegate(T) con);

    final template filter(S)
{
void filter(S delegate(T) func)
{
foreach (d; this)
{
func(d);
}
}
}

    final template filter(S)
{
void filter(S delegate(T) func, bool delegate(T) con)
{
foreach (d; this)
{
if (con(d))
{
func(d);
}
}
}
}

    abstract override string toString();

}
}
template VariableList(T)
{
class VariableList : List!(T)
{
    Iterator _head = null;
    Iterator _toe = null;
    uint _length = 0;
    this()
{
_head = null;
_toe = null;
_length = 0;
}
    override private int _getLength()
{
int __getLength(Iterator iteHead)
{
if (iteHead is null)
{
return 0;
}
else
{
return 1 + __getLength(iteHead.next);
}
}
return __getLength(_head);
}


        const override pure uint length()
{
return _length;
}

    override int opApply(int delegate(ref T) dg)
{
int _foreach(Iterator iteHead)
{
if (iteHead is null)
{
return 0;
}
else
{
int res = dg(iteHead.data);
if (res == 0)
{
return _foreach(iteHead.next);
}
else
{
return res;
}
}
}
return _foreach(_head);
}

    override int opApply(int delegate(ref uint, ref T) dg)
{
int _foreach(uint i, Iterator iteHead)
{
if (iteHead is null)
{
return 0;
}
else
{
int res = dg(i,iteHead.data);
if (res == 0)
{
return _foreach(i + 1,iteHead.next);
}
else
{
return res;
}
}
}
return _foreach(0,_head);
}

    override int opApplyReverse(int delegate(ref T) dg)
{
int _foreach(Iterator iteToe)
{
if (iteToe is null)
{
return 0;
}
else
{
const int res = dg(iteToe.data);
if (res == 0)
{
return _foreach(iteToe.prev);
}
else
{
return res;
}
}
}
return _foreach(_toe);
}

    override int opApplyReverse(int delegate(ref uint, ref T) dg)
{
int _foreach(uint i, Iterator iteToe)
{
if (iteToe is null)
{
return 0;
}
else
{
const int res = dg(i,iteToe.data);
if (res == 0)
{
return _foreach(i - 1,iteToe.prev);
}
else
{
return res;
}
}
}
return _foreach(this.length - 1,this._toe);
}

    private bool _empty()
{
return _length == 0;
}

    const override pure bool empty()
{
return _length == 0;
}

    override void pushFront(T data)
{
Iterator newIte = new Iterator(data,null,_head);
if (_toe is null)
{
_head = newIte;
_toe = newIte;
}
else
{
_head.prev = newIte;
}
_head = newIte;
_length++;
}

    override void pushBack(T data)
{
Iterator newIte = new Iterator(data,_toe,null);
if (_toe is null)
{
_head = newIte;
_toe = newIte;
}
else
{
_toe.next = newIte;
}
_toe = newIte;
_length++;
}

    override T popFront()
{
if (empty_())
{
throw new Exception("List.popFront");
}
Iterator resIte = _head;
assert(resIte !is null);
_head = resIte.next;
if (_head is null)
{
assert(this._length == 1,text(this._length));
this._toe = null;
}
else
{
_head.prev = null;
}
_length--;
return resIte.data;
}

    override T popBack()
{
if (empty_())
{
throw new Exception("List.popBack");
}
Iterator resIte = _toe;
_toe = resIte.prev;
_toe.next = null;
_length--;
return resIte.data;
}

    override T front_()
{
return _head.data;
}

    override T back_()
{
return _toe.data;
}

    override void clear()
{
_head = null;
_toe = null;
_length = 0;
}

    override void remove(bool delegate(T) con)
{
void _remove(Iterator head)
{
if (head is null)
{
return ;
}
else
{
if (con(head.data))
{
_pop(head);
}
_remove(head.next);
}
}
_remove(this._head);
}

    override void leave(bool delegate(T) con)
{
void _leave(Iterator head)
{
if (head is null)
{
return ;
}
else
{
if (!con(head.data))
{
_pop(head);
}
_leave(head.next);
}
}
_leave(this._head);
}

    private void _pop(Iterator ite)
{
if (this.empty_())
{
throw new Exception("List._pop");
}
Iterator iprev = ite.prev;
Iterator inext = ite.next;
if (iprev is null)
{
this._head = ite.next;
}
else
{
iprev.next = inext;
}
if (inext is null)
{
this._toe = ite.prev;
}
else
{
inext.prev = iprev;
}
_length--;
}

    override string toString()
{
string _toString(Iterator iteHead)
{
if (iteHead is null)
{
return "";
}
else
{
const string s1 = iteHead.toString();
const string s2 = ", ";
const string s3 = _toString(iteHead.next);
if (s3 == "")
{
return s1;
}
else
{
return s1 ~ s2 ~ s3;
}
}
}
return "List[" ~ _toString(_head) ~ "]";
}

    private class Iterator
{
    T data;
    Iterator prev;
    Iterator next;
    this(T data, Iterator prev, Iterator next)
{
this.data = data;
this.prev = prev;
this.next = next;
}
    override string toString()
{
return text(data);
}

}

}
}
template FixedList(T)
{
class FixedList : List!(T)
{
    const int _allSize;

    int _length;
    Iterator[] _iteratorArray;
    Iterator _usingHead;
    Iterator _usingToe;
    Iterator _unuseHead;
    this(in int allSize)
in
{
assert(allSize > 0);
}
body
{
this._allSize = allSize;
this._length = 0;
this._iteratorArray.length = this._allSize;
foreach (ref i; this._iteratorArray)
{
i = new Iterator;
}
{
for (int i = 0;
 i < this._iteratorArray.length; i++)
{
{
Iterator prev = i - 1 >= 0 ? this._iteratorArray[i - 1] : null;
Iterator current = this._iteratorArray[i];
Iterator next = i + 1 < this._iteratorArray.length ? this._iteratorArray[i + 1] : null;
current.prev = prev;
current.next = next;
}
}
}
this._unuseHead = this._iteratorArray[0];
this._usingHead = null;
}
            private int iteListSize(Iterator ite)
{
if (ite is null)
{
return 0;
}
else
{
return 1 + iteListSize(ite.next);
}
}

    const override pure uint length()
{
return this._length;
}

    const pure uint allSize()
{
return this._allSize;
}

    const pure uint restLength()
{
return this.allSize() - this.length();
}

    const override pure bool empty()
{
return this.length == 0;
}

    const pure bool full()
{
return this.restLength == 0;
}

    override void pushFront(T data)
{
Iterator newIte = this._unuseHead;
if (newIte.next !is null)
{
newIte.next.prev = null;
}
this._unuseHead = newIte.next;
newIte.data = data;
newIte.next = this._usingHead;
newIte.prev = null;
if (this._usingHead !is null)
{
this._usingHead.prev = newIte;
}
else
{
this._usingToe = newIte;
}
this._usingHead = newIte;
assert(newIte.prev is null);
this._length += 1;
}

    override void pushBack(T data)
{
Iterator newIte = this._popUnuse();
newIte.data = data;
newIte.prev = this._usingToe;
newIte.next = null;
if (this._usingToe !is null)
{
this._usingToe.next = newIte;
}
else
{
this._usingHead = newIte;
}
this._usingToe = newIte;
assert(newIte.next is null,to!(string)(this));
this._length += 1;
}

    override T popFront()
{
if (this.empty())
{
throw new Exception("List.popFront");
}
Iterator delIte = this._usingHead;
T res = delIte.data;
if (delIte.next !is null)
{
delIte.next.prev = null;
}
else
{
assert(this.length == 1);
this._usingToe = null;
}
this._usingHead = delIte.next;
static if(is(typeof(delIte.data) == class))
{
delIte.data = null;
}
else
{
delIte.data = (typeof(delIte.data)).init;
}

delIte.prev = null;
delIte.next = this._unuseHead;
if (delIte.next !is null)
{
delIte.next.prev = delIte;
}
this._unuseHead = delIte;
this._length -= 1;
return res;
}

    override T popBack()
{
if (this.empty())
{
throw new Exception("List.popBack");
}
Iterator delIte = this._usingToe;
T res = delIte.data;
if (delIte.prev !is null)
{
delIte.prev.next = null;
}
else
{
assert(this.length == 1);
this._usingHead = null;
}
this._usingToe = delIte.prev;
static if(is(typeof(delIte.data) == class))
{
delIte.data = null;
}
else
{
delIte.data = (typeof(delIte.data)).init;
}

delIte.prev = null;
delIte.next = this._unuseHead;
if (delIte.next !is null)
{
delIte.next.prev = delIte;
}
this._unuseHead = delIte;
this._length -= 1;
return res;
}

    override T front_()
{
if (this._usingHead is null)
{
throw new Exception("");
}
return this._usingHead.data;
}

    override T back_()
{
if (this._usingToe is null)
{
throw new Exception("");
}
return this._usingToe.data;
}

    override int opApply(int delegate(ref T) dg)
{
int _foreach(Iterator iteHead)
{
if (iteHead is null)
{
return 0;
}
else
{
int res = dg(iteHead.data);
if (res == 0)
{
return _foreach(iteHead.next);
}
else
{
return res;
}
}
}
return _foreach(this._usingHead);
}

    override int opApply(int delegate(ref uint, ref T) dg)
{
int _foreach(uint i, Iterator iteHead)
{
if (iteHead is null)
{
return 0;
}
else
{
int res = dg(i,iteHead.data);
if (res == 0)
{
return _foreach(i + 1,iteHead.next);
}
else
{
return res;
}
}
}
return _foreach(0,this._usingHead);
}

    override int opApplyReverse(int delegate(ref T) dg)
{
int _foreach(Iterator iteToe)
{
if (iteToe is null)
{
return 0;
}
else
{
int res = dg(iteToe.data);
if (res == 0)
{
return _foreach(iteToe.prev);
}
else
{
return res;
}
}
}
return _foreach(this._usingToe);
}

    override int opApplyReverse(int delegate(ref uint, ref T) dg)
{
int _foreach(uint i, Iterator iteToe)
{
if (iteToe is null)
{
return 0;
}
else
{
int res = dg(i,iteToe.data);
if (res == 0)
{
return _foreach(i - 1,iteToe.prev);
}
else
{
return res;
}
}
}
return _foreach(this.length - 1,this._usingToe);
}

    override void clear()
out
{
assert(this._length == 0,to!(string)(this));
}
body
{
int l = this.length;
{
for (int i = 0;
 i < l; i++)
{
{
this.popFront();
}
}
}
}

    override void remove(bool delegate(T) con)
{
void _remove(Iterator head)
{
if (head is null)
{
return ;
}
else
{
static if(is(head.data == struct))
{
assert(head.data !is null);
}

Iterator next = head.next;
if (con(head.data))
{
_popUsing(head);
this._length -= 1;
}
_remove(next);
}
}
_remove(this._usingHead);
}

    override void leave(bool delegate(T) con)
{
void _leave(Iterator head)
{
if (head is null)
{
return ;
}
else
{
Iterator next = head.next;
if (!con(head.data))
{
_popUsing(head);
this._length -= 1;
}
_leave(next);
}
}
_leave(this._usingHead);
}

    private void _popUsing(Iterator ite)
in
{
assert(ite !is null);
}
body
{
if (this.empty_())
{
throw new Exception("List._popUsing");
}
Iterator iprev = ite.prev;
Iterator inext = ite.next;
if (iprev is null)
{
this._usingHead = ite.next;
}
else
{
iprev.next = inext;
}
if (inext is null)
{
this._usingToe = ite.prev;
}
else
{
inext.prev = iprev;
}
ite.next = this._unuseHead;
ite.prev = null;
static if(is(typeof(ite.data) == class))
{
ite.data = null;
}
else
{
ite.data = (typeof(ite.data)).init;
}

if (ite.next !is null)
{
ite.next.prev = ite;
}
this._unuseHead = ite;
}

    private Iterator _popUnuse()
{
if (this._unuseHead is null)
{
throw new Exception("FixedList._popUsing");
}
Iterator ite = this._unuseHead;
if (ite.next !is null)
{
ite.next.prev = null;
}
this._unuseHead = ite.next;
return ite;
}

    override string toString()
{
string res = "";
res ~= "List[";
foreach (i, d; this)
{
if (i != 0)
{
res ~= ", ";
}
res ~= to!(string)(d);
}
res ~= "]";
res ~= to!(string)(this.length);
return res;
}

    private class Iterator
{
    T data;
    Iterator prev;
    Iterator next;
        this()
{
this.prev = null;
this.next = null;
}
    this(T data, Iterator prev, Iterator next)
{
this.data = data;
this.prev = prev;
this.next = next;
}
    override string toString()
{
return to!(string)(data);
}

}

}
}
alias VariableList LinkedList;
alias FixedList ArrayList;
version (none)
{
    class Test
{
    int x;
    this(int x)
{
this.x = x;
}
    override string toString()
{
return to!(string)(x);
}

    bool is_enable()
{
return x == 0;
}
}
    alias VariableList!(Test) VTestList;
    alias FixedList!(Test) FTestList;
    class FTestList2 : FTestList
{
    this()
{
super(5);
}
    void remove_notenable();
    void remove_odd();
    void remove_even();
    void filter_twice();
}
    int main_();
}
