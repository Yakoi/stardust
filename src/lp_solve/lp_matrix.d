/* Converted to D from lp_matrix.h by htod */
module lp_solve.lp_matrix;
//C     #ifndef HEADER_lp_matrix
//C     #define HEADER_lp_matrix

//C     #include "lp_types.h"
import lp_solve.lp_types;
//C     #include "lp_utils.h"
import lp_solve.lp_utils;


/* Sparse matrix element (ordered columnwise) */
//C     typedef struct _MATitem
//C     {
//C       int  rownr;
//C       int  colnr;
//C       REAL value;
//C     } MATitem;
struct _MATitem
{
    int rownr;
    int colnr;
    double value;
}
extern (C):
alias _MATitem MATitem;

/* Constants for matrix product rounding options */
//C     #define MAT_ROUNDNONE             0
//C     #define MAT_ROUNDABS              1
const MAT_ROUNDNONE = 0;
//C     #define MAT_ROUNDREL              2
const MAT_ROUNDABS = 1;
//C     #define MAT_ROUNDABSREL          (MAT_ROUNDABS + MAT_ROUNDREL)
const MAT_ROUNDREL = 2;
//C     #define MAT_ROUNDRC               4
//C     #define MAT_ROUNDRCMIN            1.0 /* lp->epspivot */
const MAT_ROUNDRC = 4;
//C     #if 1
const MAT_ROUNDRCMIN = 1.0;
//C      #define MAT_ROUNDDEFAULT         MAT_ROUNDREL  /* Typically increases performance */
//C     #else
alias MAT_ROUNDREL MAT_ROUNDDEFAULT;
//C      #define MAT_ROUNDDEFAULT         MAT_ROUNDABS  /* Probably gives more precision */
//C     #endif

/* Compiler option development features */
/*#define DebugInv*/
               /* Report array values at factorization/inversion */
//C     #define NoLoopUnroll              /* Do not do loop unrolling */
//C     #define DirectArrayOF             /* Reference lp->obj[] array instead of function call */


/* Matrix column access macros to be able to easily change storage model */
//C     #define CAM_Record                0
//C     #define CAM_Vector                1
const CAM_Record = 0;
//C     #if 0
const CAM_Vector = 1;
//C      #define MatrixColAccess           CAM_Record
//C     #else
//C      #define MatrixColAccess           CAM_Vector
//C     #endif
alias CAM_Vector MatrixColAccess;

//C     #if MatrixColAccess==CAM_Record
//C     #define SET_MAT_ijA(item,i,j,A)   mat->col_mat[item].rownr = i;                                   mat->col_mat[item].colnr = j;                                   mat->col_mat[item].value = A
//C     #define COL_MAT_COLNR(item)       (mat->col_mat[item].colnr)
//C     #define COL_MAT_ROWNR(item)       (mat->col_mat[item].rownr)
//C     #define COL_MAT_VALUE(item)       (mat->col_mat[item].value)
//C     #define COL_MAT_COPY(left,right)  mat->col_mat[left] = mat->col_mat[right]
//C     #define COL_MAT_MOVE(to,from,rec) MEMMOVE(&(mat->col_mat[to]),&(mat->col_mat[from]),rec)
//C     #define COL_MAT2_COLNR(item)      (mat2->col_mat[item].colnr)
//C     #define COL_MAT2_ROWNR(item)      (mat2->col_mat[item].rownr)
//C     #define COL_MAT2_VALUE(item)      (mat2->col_mat[item].value)
//C     #define matRowColStep             (sizeof(MATitem)/sizeof(int))
//C     #define matValueStep              (sizeof(MATitem)/sizeof(REAL))

//C     #else /* if MatrixColAccess==CAM_Vector */
//C     #define SET_MAT_ijA(item,i,j,A)   mat->col_mat_rownr[item] = i;                                   mat->col_mat_colnr[item] = j;                                   mat->col_mat_value[item] = A
//C     #define COL_MAT_COLNR(item)       (mat->col_mat_colnr[item])
//C     #define COL_MAT_ROWNR(item)       (mat->col_mat_rownr[item])
//C     #define COL_MAT_VALUE(item)       (mat->col_mat_value[item])
//C     #define COL_MAT_COPY(left,right)  COL_MAT_COLNR(left) = COL_MAT_COLNR(right);                                   COL_MAT_ROWNR(left) = COL_MAT_ROWNR(right);                                   COL_MAT_VALUE(left) = COL_MAT_VALUE(right)
//C     #define COL_MAT_MOVE(to,from,rec) MEMMOVE(&COL_MAT_COLNR(to),&COL_MAT_COLNR(from),rec);                                   MEMMOVE(&COL_MAT_ROWNR(to),&COL_MAT_ROWNR(from),rec);                                   MEMMOVE(&COL_MAT_VALUE(to),&COL_MAT_VALUE(from),rec)
//C     #define COL_MAT2_COLNR(item)      (mat2->col_mat_colnr[item])
//C     #define COL_MAT2_ROWNR(item)      (mat2->col_mat_rownr[item])
//C     #define COL_MAT2_VALUE(item)      (mat2->col_mat_value[item])
//C     #define matRowColStep             1
//C     #define matValueStep              1
const matRowColStep = 1;

const matValueStep = 1;
//C     #endif


/* Matrix row access macros to be able to easily change storage model */
//C     #define RAM_Index                 0
//C     #define RAM_FullCopy              1
const RAM_Index = 0;
//C     #define MatrixRowAccess           RAM_Index
const RAM_FullCopy = 1;

alias RAM_Index MatrixRowAccess;
//C     #if MatrixRowAccess==RAM_Index
//C     #define ROW_MAT_COLNR(item)       COL_MAT_COLNR(mat->row_mat[item])
//C     #define ROW_MAT_ROWNR(item)       COL_MAT_ROWNR(mat->row_mat[item])
//C     #define ROW_MAT_VALUE(item)       COL_MAT_VALUE(mat->row_mat[item])

//C     #elif MatrixColAccess==CAM_Record
//C     #define ROW_MAT_COLNR(item)       (mat->row_mat[item].colnr)
//C     #define ROW_MAT_ROWNR(item)       (mat->row_mat[item].rownr)
//C     #define ROW_MAT_VALUE(item)       (mat->row_mat[item].value)

//C     #else /* if MatrixColAccess==CAM_Vector */
//C     #define ROW_MAT_COLNR(item)       (mat->row_mat_colnr[item])
//C     #define ROW_MAT_ROWNR(item)       (mat->row_mat_rownr[item])
//C     #define ROW_MAT_VALUE(item)       (mat->row_mat_value[item])

//C     #endif


//C     typedef struct _MATrec
//C     {
  /* Owner reference */
//C       lprec     *lp;

  /* Active dimensions */
//C       int       rows;
//C       int       columns;

  /* Allocated memory */
//C       int       rows_alloc;
//C       int       columns_alloc;
//C       int       mat_alloc;          /* The allocated size for matrix sized structures */

  /* Sparse problem matrix storage */
//C     #if MatrixColAccess==CAM_Record  
//C       MATitem   *col_mat;           /* mat_alloc : The sparse data storage */
//C     #else /*MatrixColAccess==CAM_Vector*/
//C       int       *col_mat_colnr;
//C       int       *col_mat_rownr;
//C       REAL      *col_mat_value;
//C     #endif  
//C       int       *col_end;           
/* columns_alloc+1 : col_end[i] is the index of the
                                   first element after column i; column[i] is stored
                                   in elements col_end[i-1] to col_end[i]-1 */
//C       int       *col_tag;           /* user-definable tag associated with each column */

//C     #if MatrixRowAccess==RAM_Index
//C       int       *row_mat;           
/* mat_alloc : From index 0, row_mat contains the
                                   row-ordered index of the elements of col_mat */
//C     #elif MatrixColAccess==CAM_Record
//C       MATitem   *row_mat;           
/* mat_alloc : From index 0, row_mat contains the
                                   row-ordered copy of the elements in col_mat */
//C     #else /*if MatrixColAccess==CAM_Vector*/
//C       int       *row_mat_colnr;
//C       int       *row_mat_rownr;
//C       REAL      *row_mat_value;
//C     #endif
//C       int       *row_end;           
/* rows_alloc+1 : row_end[i] is the index of the
                                   first element in row_mat after row i */
//C       int       *row_tag;           /* user-definable tag associated with each row */

//C       REAL      *colmax;            /* Array of maximum values of each column */
//C       REAL      *rowmax;            /* Array of maximum values of each row */

//C       REAL      epsvalue;           /* Zero element rejection threshold */
//C       REAL      infnorm;            /* The largest absolute value in the matrix */
//C       REAL      dynrange;
//C       MYBOOL    row_end_valid;      /* TRUE if row_end & row_mat are valid */
//C       MYBOOL    is_roworder;        /* TRUE if the current (temporary) matrix order is row-wise */

//C     } MATrec;
struct _MATrec
{
    lprec *lp;
    int rows;
    int columns;
    int rows_alloc;
    int columns_alloc;
    int mat_alloc;
    int *col_mat_colnr;
    int *col_mat_rownr;
    double *col_mat_value;
    int *col_end;
    int *col_tag;
    int *row_mat;
    int *row_end;
    int *row_tag;
    double *colmax;
    double *rowmax;
    double epsvalue;
    double infnorm;
    double dynrange;
    ubyte row_end_valid;
    ubyte is_roworder;
}
alias _MATrec MATrec;

//C     typedef struct _DeltaVrec
//C     {
//C       lprec     *lp;
//C       int       activelevel;
//C       MATrec    *tracker;
//C     } DeltaVrec;
struct _DeltaVrec
{
    lprec *lp;
    int activelevel;
    MATrec *tracker;
}
alias _DeltaVrec DeltaVrec;


//C     #ifdef __cplusplus
//C     __EXTERN_C {
//C     #endif

/* Sparse matrix routines */
//C     STATIC MATrec *mat_create(lprec *lp, int rows, int columns, REAL epsvalue);
MATrec * mat_create(lprec *lp, int rows, int columns, double epsvalue);
//C     STATIC MYBOOL mat_memopt(MATrec *mat, int rowextra, int colextra, int nzextra);
ubyte  mat_memopt(MATrec *mat, int rowextra, int colextra, int nzextra);
//C     STATIC void mat_free(MATrec **matrix);
void  mat_free(MATrec **matrix);
//C     STATIC MYBOOL inc_matrow_space(MATrec *mat, int deltarows);
ubyte  inc_matrow_space(MATrec *mat, int deltarows);
//C     STATIC int mat_mapreplace(MATrec *mat, LLrec *rowmap, LLrec *colmap, MATrec *insmat);
int  mat_mapreplace(MATrec *mat, LLrec *rowmap, LLrec *colmap, MATrec *insmat);
//C     STATIC int mat_matinsert(MATrec *mat, MATrec *insmat);
int  mat_matinsert(MATrec *mat, MATrec *insmat);
//C     STATIC int mat_zerocompact(MATrec *mat);
int  mat_zerocompact(MATrec *mat);
//C     STATIC int mat_rowcompact(MATrec *mat, MYBOOL dozeros);
int  mat_rowcompact(MATrec *mat, ubyte dozeros);
//C     STATIC int mat_colcompact(MATrec *mat, int prev_rows, int prev_cols);
int  mat_colcompact(MATrec *mat, int prev_rows, int prev_cols);
//C     STATIC MYBOOL inc_matcol_space(MATrec *mat, int deltacols);
ubyte  inc_matcol_space(MATrec *mat, int deltacols);
//C     STATIC MYBOOL inc_mat_space(MATrec *mat, int mindelta);
ubyte  inc_mat_space(MATrec *mat, int mindelta);
//C     STATIC int mat_shiftrows(MATrec *mat, int *bbase, int delta, LLrec *varmap);
int  mat_shiftrows(MATrec *mat, int *bbase, int delta, LLrec *varmap);
//C     STATIC int mat_shiftcols(MATrec *mat, int *bbase, int delta, LLrec *varmap);
int  mat_shiftcols(MATrec *mat, int *bbase, int delta, LLrec *varmap);
//C     STATIC MATrec *mat_extractmat(MATrec *mat, LLrec *rowmap, LLrec *colmap, MYBOOL negated);
MATrec * mat_extractmat(MATrec *mat, LLrec *rowmap, LLrec *colmap, ubyte negated);
//C     STATIC int mat_appendrow(MATrec *mat, int count, REAL *row, int *colno, REAL mult, MYBOOL checkrowmode);
int  mat_appendrow(MATrec *mat, int count, double *row, int *colno, double mult, ubyte checkrowmode);
//C     STATIC int mat_appendcol(MATrec *mat, int count, REAL *column, int *rowno, REAL mult, MYBOOL checkrowmode);
int  mat_appendcol(MATrec *mat, int count, double *column, int *rowno, double mult, ubyte checkrowmode);
//C     MYBOOL mat_get_data(lprec *lp, int matindex, MYBOOL isrow, int **rownr, int **colnr, REAL **value);
ubyte  mat_get_data(lprec *lp, int matindex, ubyte isrow, int **rownr, int **colnr, double **value);
//C     MYBOOL mat_set_rowmap(MATrec *mat, int row_mat_index, int rownr, int colnr, int col_mat_index);
ubyte  mat_set_rowmap(MATrec *mat, int row_mat_index, int rownr, int colnr, int col_mat_index);
//C     STATIC MYBOOL mat_indexrange(MATrec *mat, int index, MYBOOL isrow, int *startpos, int *endpos);
ubyte  mat_indexrange(MATrec *mat, int index, ubyte isrow, int *startpos, int *endpos);
//C     STATIC MYBOOL mat_validate(MATrec *mat);
ubyte  mat_validate(MATrec *mat);
//C     STATIC MYBOOL mat_equalRows(MATrec *mat, int baserow, int comprow);
ubyte  mat_equalRows(MATrec *mat, int baserow, int comprow);
//C     STATIC int mat_findelm(MATrec *mat, int row, int column);
int  mat_findelm(MATrec *mat, int row, int column);
//C     STATIC int mat_findins(MATrec *mat, int row, int column, int *insertpos, MYBOOL validate);
int  mat_findins(MATrec *mat, int row, int column, int *insertpos, ubyte validate);
//C     STATIC void mat_multcol(MATrec *mat, int col_nr, REAL mult, MYBOOL DoObj);
void  mat_multcol(MATrec *mat, int col_nr, double mult, ubyte DoObj);
//C     STATIC REAL mat_getitem(MATrec *mat, int row, int column);
double  mat_getitem(MATrec *mat, int row, int column);
//C     STATIC MYBOOL mat_setitem(MATrec *mat, int row, int column, REAL value);
ubyte  mat_setitem(MATrec *mat, int row, int column, double value);
//C     STATIC MYBOOL mat_additem(MATrec *mat, int row, int column, REAL delta);
ubyte  mat_additem(MATrec *mat, int row, int column, double delta);
//C     STATIC MYBOOL mat_setvalue(MATrec *mat, int Row, int Column, REAL Value, MYBOOL doscale);
ubyte  mat_setvalue(MATrec *mat, int Row, int Column, double Value, ubyte doscale);
//C     STATIC int mat_nonzeros(MATrec *mat);
int  mat_nonzeros(MATrec *mat);
//C     STATIC int mat_collength(MATrec *mat, int colnr);
int  mat_collength(MATrec *mat, int colnr);
//C     STATIC int mat_rowlength(MATrec *mat, int rownr);
int  mat_rowlength(MATrec *mat, int rownr);
//C     STATIC void mat_multrow(MATrec *mat, int row_nr, REAL mult);
void  mat_multrow(MATrec *mat, int row_nr, double mult);
//C     STATIC void mat_multadd(MATrec *mat, REAL *lhsvector, int varnr, REAL mult);
void  mat_multadd(MATrec *mat, double *lhsvector, int varnr, double mult);
//C     STATIC MYBOOL mat_setrow(MATrec *mat, int rowno, int count, REAL *row, int *colno, MYBOOL doscale, MYBOOL checkrowmode);
ubyte  mat_setrow(MATrec *mat, int rowno, int count, double *row, int *colno, ubyte doscale, ubyte checkrowmode);
//C     STATIC MYBOOL mat_setcol(MATrec *mat, int colno, int count, REAL *column, int *rowno, MYBOOL doscale, MYBOOL checkrowmode);
ubyte  mat_setcol(MATrec *mat, int colno, int count, double *column, int *rowno, ubyte doscale, ubyte checkrowmode);
//C     STATIC MYBOOL mat_mergemat(MATrec *target, MATrec *source, MYBOOL usecolmap);
ubyte  mat_mergemat(MATrec *target, MATrec *source, ubyte usecolmap);
//C     STATIC int mat_checkcounts(MATrec *mat, int *rownum, int *colnum, MYBOOL freeonexit);
int  mat_checkcounts(MATrec *mat, int *rownum, int *colnum, ubyte freeonexit);
//C     STATIC int mat_expandcolumn(MATrec *mat, int colnr, REAL *column, int *nzlist, MYBOOL signedA);
int  mat_expandcolumn(MATrec *mat, int colnr, double *column, int *nzlist, ubyte signedA);
//C     STATIC MYBOOL mat_computemax(MATrec *mat);
ubyte  mat_computemax(MATrec *mat);
//C     STATIC MYBOOL mat_transpose(MATrec *mat);
ubyte  mat_transpose(MATrec *mat);

/* Refactorization and recomputation routine */
//C     MYBOOL __WINAPI invert(lprec *lp, MYBOOL shiftbounds, MYBOOL final);
extern (Windows):
ubyte  invert(lprec *lp, ubyte shiftbounds, ubyte final_);

/* Vector compression and expansion routines */
//C     STATIC MYBOOL vec_compress(REAL *densevector, int startpos, int endpos, REAL epsilon, REAL *nzvector, int *nzindex);
extern (C):
ubyte  vec_compress(double *densevector, int startpos, int endpos, double epsilon, double *nzvector, int *nzindex);
//C     STATIC MYBOOL vec_expand(REAL *nzvector, int *nzindex, REAL *densevector, int startpos, int endpos);
ubyte  vec_expand(double *nzvector, int *nzindex, double *densevector, int startpos, int endpos);

/* Sparse matrix products */
//C     STATIC MYBOOL get_colIndexA(lprec *lp, int varset, int *colindex, MYBOOL append);
ubyte  get_colIndexA(lprec *lp, int varset, int *colindex, ubyte append);
//C     STATIC int prod_Ax(lprec *lp, int *coltarget, REAL *input, int *nzinput, REAL roundzero, REAL ofscalar, REAL *output, int *nzoutput, int roundmode);
int  prod_Ax(lprec *lp, int *coltarget, double *input, int *nzinput, double roundzero, double ofscalar, double *output, int *nzoutput, int roundmode);
//C     STATIC int prod_xA(lprec *lp, int *coltarget, REAL *input, int *nzinput, REAL roundzero, REAL ofscalar, REAL *output, int *nzoutput, int roundmode);
int  prod_xA(lprec *lp, int *coltarget, double *input, int *nzinput, double roundzero, double ofscalar, double *output, int *nzoutput, int roundmode);
//C     STATIC MYBOOL prod_xA2(lprec *lp, int *coltarget, REAL *prow, REAL proundzero, int *pnzprow,
//C                                                       REAL *drow, REAL droundzero, int *dnzdrow, REAL ofscalar, int roundmode);
ubyte  prod_xA2(lprec *lp, int *coltarget, double *prow, double proundzero, int *pnzprow, double *drow, double droundzero, int *dnzdrow, double ofscalar, int roundmode);

/* Equation solution */
//C     STATIC MYBOOL fimprove(lprec *lp, REAL *pcol, int *nzidx, REAL roundzero);
ubyte  fimprove(lprec *lp, double *pcol, int *nzidx, double roundzero);
//C     STATIC void ftran(lprec *lp, REAL *rhsvector, int *nzidx, REAL roundzero);
void  ftran(lprec *lp, double *rhsvector, int *nzidx, double roundzero);
//C     STATIC MYBOOL bimprove(lprec *lp, REAL *rhsvector, int *nzidx, REAL roundzero);
ubyte  bimprove(lprec *lp, double *rhsvector, int *nzidx, double roundzero);
//C     STATIC void btran(lprec *lp, REAL *rhsvector, int *nzidx, REAL roundzero);
void  btran(lprec *lp, double *rhsvector, int *nzidx, double roundzero);

/* Combined equation solution and matrix product for simplex operations */
//C     STATIC MYBOOL fsolve(lprec *lp, int varin, REAL *pcol, int *nzidx, REAL roundzero, REAL ofscalar, MYBOOL prepareupdate);
ubyte  fsolve(lprec *lp, int varin, double *pcol, int *nzidx, double roundzero, double ofscalar, ubyte prepareupdate);
//C     STATIC MYBOOL bsolve(lprec *lp, int row_nr, REAL *rhsvector, int *nzidx, REAL roundzero, REAL ofscalar);
ubyte  bsolve(lprec *lp, int row_nr, double *rhsvector, int *nzidx, double roundzero, double ofscalar);
//C     STATIC void bsolve_xA2(lprec *lp, int* coltarget, 
//C                                       int row_nr1, REAL *vector1, REAL roundzero1, int *nzvector1,
//C                                       int row_nr2, REAL *vector2, REAL roundzero2, int *nzvector2, int roundmode);
void  bsolve_xA2(lprec *lp, int *coltarget, int row_nr1, double *vector1, double roundzero1, int *nzvector1, int row_nr2, double *vector2, double roundzero2, int *nzvector2, int roundmode);

/* Change-tracking routines (primarily for B&B and presolve) */
//C     STATIC DeltaVrec *createUndoLadder(lprec *lp, int levelitems, int maxlevels);
DeltaVrec * createUndoLadder(lprec *lp, int levelitems, int maxlevels);
//C     STATIC int incrementUndoLadder(DeltaVrec *DV);
int  incrementUndoLadder(DeltaVrec *DV);
//C     STATIC MYBOOL modifyUndoLadder(DeltaVrec *DV, int itemno, REAL target[], REAL newvalue);
ubyte  modifyUndoLadder(DeltaVrec *DV, int itemno, double *target, double newvalue);
//C     STATIC int countsUndoLadder(DeltaVrec *DV);
int  countsUndoLadder(DeltaVrec *DV);
//C     STATIC int restoreUndoLadder(DeltaVrec *DV, REAL target[]);
int  restoreUndoLadder(DeltaVrec *DV, double *target);
//C     STATIC int decrementUndoLadder(DeltaVrec *DV);
int  decrementUndoLadder(DeltaVrec *DV);
//C     STATIC MYBOOL freeUndoLadder(DeltaVrec **DV);
ubyte  freeUndoLadder(DeltaVrec **DV);

/* Specialized presolve undo functions */
//C     STATIC MYBOOL appendUndoPresolve(lprec *lp, MYBOOL isprimal, REAL beta, int colnrDep);
ubyte  appendUndoPresolve(lprec *lp, ubyte isprimal, double beta, int colnrDep);
//C     STATIC MYBOOL addUndoPresolve(lprec *lp, MYBOOL isprimal, int colnrElim, REAL alpha, REAL beta, int colnrDep);
ubyte  addUndoPresolve(lprec *lp, ubyte isprimal, int colnrElim, double alpha, double beta, int colnrDep);


//C     #ifdef __cplusplus
//C     }
//C     #endif

//C     #endif /* HEADER_lp_matrix */

