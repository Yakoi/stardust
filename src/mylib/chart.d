
module mylib.chart;
import mylib.utils;
import mylib.vector2d;
import mylib.primitives;
import std.conv;

class Chart : Rectangle{
private:
    ChartColumn[] columns;
    ChartRow[] rows;
    Cell[] cells;
public:
    Vector2d pos;
    int distanceColumn = 2;
    int distanceRow    = 2;
    int characterWidth = 12;
    this(int column, int row, int characterWidth, int columnWidth = 16, int rowHeight = 12, Vector2d pos = vecpos(0,0)){
        this.columns = new ChartColumn[column];
        foreach(ref col; columns){
            col = new ChartColumn;
            col.width = columnWidth;
        }
        this.rows = new ChartRow[row];
        foreach(ref rw; rows){
            rw = new ChartRow;
            rw.height = rowHeight;
        }
        this.cells = new Cell[column * row];
        foreach(i,ref cell; this.cells){
            cell = new Cell(this, i%columns.length, i/columns.length);
        }
        this.characterWidth = characterWidth;
        this.pos = pos;
    }
    const pure string getData(in int x, in int y){
        return this.cells[x+this.columns.length*y].data;
    }
    void setData(in int x, in int y, in string data)
    in{
        assert(0<=x, to!(string)(x));
        assert(0<=y, to!(string)(y));
        assert(x<this.columns.length, to!(string)(x));
        assert(y<this.rows.length,    to!(string)(y));
    }body{
        this.cells[x+this.columns.length*y].data = data;
    }
    const pure Cell getCell(in int x, in int y){
        return cast(Cell)this.cells[x+this.columns.length*y];
    }
    void autoSetCellWidth(){
        foreach(x; 0..this.columns.length){
            int maxCharacterNum = 0;
            foreach(y; 0..this.rows.length){
                maxCharacterNum = max!(int)(this.getData(x,y).length, maxCharacterNum);
            }
            this.columns[x].width = maxCharacterNum * this.characterWidth;
        }
    }
    @property override const pure double left(){             /// 左
        return this.center.x - this.width/2;
    }
    @property override const pure double right(){            /// 右
        return this.center.x + this.width/2;
    }
    @property override const pure double top(){              /// 上
        return this.center.y - this.height/2;
    }
    @property override const pure double bottom(){           /// 下
        return this.center.y + this.height/2;
    }
    @property override const pure double width(){            /// 幅(right - left)
        int size=0;
        foreach(c; this.columns){
            size += c.width;
        }
        size += distanceColumn*(this.columns.length-1);
        return size;
    }
    @property override const pure double height(){           /// 高さ(bottom - top)
        int size=0;
        foreach(r; this.rows){
            size += r.height;
        }
        size += distanceRow*(this.rows.length-1);
        return size;
    }
    @property override const pure double cx(){               /// 中心x座標((left + right)/2)
        return this.center.x;
    }
    @property override const pure double cy(){               /// 中心y座標((top + bottom)/2)
        return this.center.y;
    }
    @property override const pure Vector2d center(){               /// 中心y座標((top + bottom)/2)
        return this.pos;
    }
    /// foreach用
    int opApply(int delegate(ref Cell) dg)
    {
        int result = 0;
        foreach (n; this.cells)
        {
            result = dg(n);
            if (result){ break;}
        }
        return result;
    }

    mixin RectangleVectorTemplate2;
}
private class Cell : Rectangle{
    const Chart parentChart;
    string data;
    int x;
    int y;
    this(Chart parentChart, int x, int y){
        this.parentChart = parentChart;
        this.x = x;
        this.y = y;
        data = "";
    }
    @property override const pure double left(){             /// 左
        double res = parentChart.left;
        foreach(i; 0..this.x){
            res += this.parentChart.columns[i].width;
        }
        res += this.parentChart.distanceColumn*this.x;
        return res;
    }
    @property override const pure double top(){              /// 上
        double res = parentChart.top;
        foreach(i; 0..this.y){
            res += this.parentChart.rows[i].height;
        }
        res += this.parentChart.distanceRow*this.y;
        return res;
    }
    @property override const pure double width(){            /// 幅(right - left)
        return this.parentChart.columns[x].width;
    }
    @property override const pure double height(){           /// 高さ(bottom - top)
        return this.parentChart.rows[x].height;
    }
    mixin RectangleRBTemplate;
    mixin RectangleCxCyByLTWHTemplate;
    mixin RectangleVectorTemplate;
}
private class ChartColumn{
    int width;
}
private class ChartRow{
    int height;
}


