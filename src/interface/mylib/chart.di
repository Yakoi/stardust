// D import file generated from 'mylib\chart.d'
module mylib.chart;
import mylib.utils;
import mylib.vector2d;
import mylib.primitives;
import std.conv;
class Chart : Rectangle
{
    private 
{
    ChartColumn[] columns;
    ChartRow[] rows;
    Cell[] cells;
    public 
{
    Vector2d pos;
    int distanceColumn = 2;
    int distanceRow = 2;
    int characterWidth = 12;
    this(int column, int row, int characterWidth, int columnWidth = 16, int rowHeight = 12, Vector2d pos = vecpos(0,0));
    const pure string getData(in int x, in int y)
{
return this.cells[x + this.columns.length * y].data;
}

    void setData(in int x, in int y, in string data)
in
{
assert(0 <= x,to!(string)(x));
assert(0 <= y,to!(string)(y));
assert(x < this.columns.length,to!(string)(x));
assert(y < this.rows.length,to!(string)(y));
}
body
{
this.cells[x + this.columns.length * y].data = data;
}
    const pure Cell getCell(in int x, in int y)
{
return cast(Cell)this.cells[x + this.columns.length * y];
}

    void autoSetCellWidth();
    const override pure @property double left()
{
return this.center.x - this.width / 2;
}

    const override pure @property double right()
{
return this.center.x + this.width / 2;
}

    const override pure @property double top()
{
return this.center.y - this.height / 2;
}

    const override pure @property double bottom()
{
return this.center.y + this.height / 2;
}

    const override pure @property double width();

    const override pure @property double height();

    const override pure @property double cx()
{
return this.center.x;
}

    const override pure @property double cy()
{
return this.center.y;
}

    const override pure @property Vector2d center()
{
return this.pos;
}

    int opApply(int delegate(ref Cell) dg);
    mixin RectangleVectorTemplate2!();
}
}
}
private class Cell : Rectangle
{
    const Chart parentChart;

    string data;
    int x;
    int y;
    this(Chart parentChart, int x, int y)
{
this.parentChart = parentChart;
this.x = x;
this.y = y;
data = "";
}
    const override pure @property double left();

    const override pure @property double top();

    const override pure @property double width()
{
return this.parentChart.columns[x].width;
}

    const override pure @property double height()
{
return this.parentChart.rows[x].height;
}

    mixin RectangleRBTemplate!();
    mixin RectangleCxCyByLTWHTemplate!();
    mixin RectangleVectorTemplate!();
}

private class ChartColumn
{
    int width;
}

private class ChartRow
{
    int height;
}

