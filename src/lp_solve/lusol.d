/* Converted to D from lpsolve55/lusol.h by htod */
module lp_solve.lusol;
//C     #ifndef HEADER_LUSOL
//C     #define HEADER_LUSOL

/* Include necessary libraries                                               */
/* ------------------------------------------------------------------------- */
//C     #include <stdio.h>
import std.c.stdio;
//C     #include "commonlib.h"
//import commonlib;

/* Version information                                                       */
/* ------------------------------------------------------------------------- */
//C     #define LUSOL_VERMAJOR   2
//C     #define LUSOL_VERMINOR   2
const LUSOL_VERMAJOR = 2;
//C     #define LUSOL_RELEASE    2
const LUSOL_VERMINOR = 2;
//C     #define LUSOL_BUILD      0
const LUSOL_RELEASE = 2;

const LUSOL_BUILD = 0;
/* Dynamic memory management macros                                          */
/* ------------------------------------------------------------------------- */
//C     #ifdef MATLAB
//C       #define LUSOL_MALLOC(bytesize)        mxMalloc(bytesize)
//C       #define LUSOL_CALLOC(count, recsize)  mxCalloc(count, recsize)
//C       #define LUSOL_REALLOC(ptr, bytesize)  mxRealloc((void *) ptr, bytesize)
//C       #define LUSOL_FREE(ptr)               {mxFree(ptr); ptr=NULL;}
//C     #else
//C       #define LUSOL_MALLOC(bytesize)        malloc(bytesize)
//C       #define LUSOL_CALLOC(count, recsize)  calloc(count, recsize)
//C       #define LUSOL_REALLOC(ptr, bytesize)  realloc((void *) ptr, bytesize)
//C       #define LUSOL_FREE(ptr)               {free(ptr); ptr=NULL;}
//C     #endif

/* Performance compiler options                                              */
/* ------------------------------------------------------------------------- */
//C     #if 1
//C       #define ForceInitialization      /* Satisfy compilers, check during debugging! */
//C       #define LUSOLFastDenseIndex           /* Increment the linearized dense address */
//C       #define LUSOLFastClear           /* Use intrinsic functions for memory zeroing */
//C       #define LUSOLFastMove              /* Use intrinsic functions for memory moves */
//C       #define LUSOLFastCopy               /* Use intrinsic functions for memory copy */
//C       #define LUSOLFastSolve           /* Use pointer operations in equation solving */
//C       #define LUSOLSafeFastUpdate      /* Use separate array for LU6L result storage */
/*#define UseOld_LU6CHK_20040510 */
/*#define AlwaysSeparateHamaxR */
       /* Enabled when the pivot model is fixed */
//C       #if 0
//C         #define ForceRowBasedL0                  /* Create a row-sorted version of L0 */
//C       #endif
/*  #define SetSmallToZero*/
/*  #define DoTraceL0 */
//C     #endif
/*#define UseTimer */


/* Legacy compatibility and testing options (Fortran-LUSOL)                  */
/* ------------------------------------------------------------------------- */
//C     #if 0
//C       #define LegacyTesting
//C       #define StaticMemAlloc           /* Preallocated vs. dynamic memory allocation */
//C       #define ClassicdiagU                                  /* Store diagU at end of a */
//C       #define ClassicHamaxR                    /* Store H+AmaxR at end of a/indc/indr */
//C     #endif


/* General constants and data type definitions                               */
/* ------------------------------------------------------------------------- */
//C     #define LUSOL_ARRAYOFFSET            1
//C     #ifndef ZERO
const LUSOL_ARRAYOFFSET = 1;
//C       #define ZERO                       0
//C     #endif
const ZERO = 0;
//C     #ifndef ONE
//C       #define ONE                        1
//C     #endif
const ONE = 1;
//C     #ifndef FALSE
//C       #define FALSE                      0
//C     #endif
//C     #ifndef TRUE
//C       #define TRUE                       1
//C     #endif
//C     #ifndef NULL
//C       #define NULL                       0
//C     #endif
//C     #ifndef REAL
//C       #define REAL double
//C     #endif
//C     #ifndef REALXP
//C       #define REALXP long double
//C     #endif
//C     #ifndef MYBOOL
//C       #define MYBOOL unsigned char
//C     #endif


/* User-settable default parameter values                                    */
/* ------------------------------------------------------------------------- */
//C     #define LUSOL_DEFAULT_GAMMA        2.0
//C     #define LUSOL_SMALLNUM         1.0e-20  /* IAEE doubles have precision 2.22e-16 */
const LUSOL_DEFAULT_GAMMA = 2.0;
//C     #define LUSOL_BIGNUM           1.0e+20
const LUSOL_SMALLNUM = 1.0e-20;
//C     #define LUSOL_MINDELTA_FACTOR        4
const LUSOL_BIGNUM = 1.0e+20;
//C     #define LUSOL_MINDELTA_a         10000
const LUSOL_MINDELTA_FACTOR = 4;
//C     #if 1
const LUSOL_MINDELTA_a = 10000;
//C       #define LUSOL_MULT_nz_a            2  /* Suggested by Yin Zhang */
//C     #else
const LUSOL_MULT_nz_a = 2;
//C       #define LUSOL_MULT_nz_a            5  /* Could consider 6 or 7 */
//C     #endif
//C     #define LUSOL_MINDELTA_rc         1000
//C     #define LUSOL_DEFAULT_SMARTRATIO 0.667
const LUSOL_MINDELTA_rc = 1000;

const LUSOL_DEFAULT_SMARTRATIO = 0.667;
/* Fixed system parameters (changeable only by developers)                   */
/* ------------------------------------------------------------------------- */

/* parmlu INPUT parameters: */
//C     #define LUSOL_RP_SMARTRATIO          0
//C     #define LUSOL_RP_FACTORMAX_Lij       1
const LUSOL_RP_SMARTRATIO = 0;
//C     #define LUSOL_RP_UPDATEMAX_Lij       2
const LUSOL_RP_FACTORMAX_Lij = 1;
//C     #define LUSOL_RP_ZEROTOLERANCE       3
const LUSOL_RP_UPDATEMAX_Lij = 2;
//C     #define LUSOL_RP_SMALLDIAG_U         4
const LUSOL_RP_ZEROTOLERANCE = 3;
//C     #define LUSOL_RP_EPSDIAG_U           5
const LUSOL_RP_SMALLDIAG_U = 4;
//C     #define LUSOL_RP_COMPSPACE_U         6
const LUSOL_RP_EPSDIAG_U = 5;
//C     #define LUSOL_RP_MARKOWITZ_CONLY     7
const LUSOL_RP_COMPSPACE_U = 6;
//C     #define LUSOL_RP_MARKOWITZ_DENSE     8
const LUSOL_RP_MARKOWITZ_CONLY = 7;
//C     #define LUSOL_RP_GAMMA               9
const LUSOL_RP_MARKOWITZ_DENSE = 8;

const LUSOL_RP_GAMMA = 9;
/* parmlu OUPUT parameters: */
//C     #define LUSOL_RP_MAXELEM_A          10
//C     #define LUSOL_RP_MAXMULT_L          11
const LUSOL_RP_MAXELEM_A = 10;
//C     #define LUSOL_RP_MAXELEM_U          12
const LUSOL_RP_MAXMULT_L = 11;
//C     #define LUSOL_RP_MAXELEM_DIAGU      13
const LUSOL_RP_MAXELEM_U = 12;
//C     #define LUSOL_RP_MINELEM_DIAGU      14
const LUSOL_RP_MAXELEM_DIAGU = 13;
//C     #define LUSOL_RP_MAXELEM_TCP        15
const LUSOL_RP_MINELEM_DIAGU = 14;
//C     #define LUSOL_RP_GROWTHRATE         16
const LUSOL_RP_MAXELEM_TCP = 15;
//C     #define LUSOL_RP_USERDATA_1         17
const LUSOL_RP_GROWTHRATE = 16;
//C     #define LUSOL_RP_USERDATA_2         18
const LUSOL_RP_USERDATA_1 = 17;
//C     #define LUSOL_RP_USERDATA_3         19
const LUSOL_RP_USERDATA_2 = 18;
//C     #define LUSOL_RP_RESIDUAL_U         20
const LUSOL_RP_USERDATA_3 = 19;
//C     #define LUSOL_RP_LASTITEM            LUSOL_RP_RESIDUAL_U
const LUSOL_RP_RESIDUAL_U = 20;

alias LUSOL_RP_RESIDUAL_U LUSOL_RP_LASTITEM;
/* luparm INPUT parameters: */
//C     #define LUSOL_IP_USERDATA_0          0
//C     #define LUSOL_IP_PRINTUNIT           1
const LUSOL_IP_USERDATA_0 = 0;
//C     #define LUSOL_IP_PRINTLEVEL          2
const LUSOL_IP_PRINTUNIT = 1;
//C     #define LUSOL_IP_MARKOWITZ_MAXCOL    3
const LUSOL_IP_PRINTLEVEL = 2;
//C     #define LUSOL_IP_SCALAR_NZA          4
const LUSOL_IP_MARKOWITZ_MAXCOL = 3;
//C     #define LUSOL_IP_UPDATELIMIT         5
const LUSOL_IP_SCALAR_NZA = 4;
//C     #define LUSOL_IP_PIVOTTYPE           6
const LUSOL_IP_UPDATELIMIT = 5;
//C     #define LUSOL_IP_ACCELERATION        7
const LUSOL_IP_PIVOTTYPE = 6;
//C     #define LUSOL_IP_KEEPLU              8
const LUSOL_IP_ACCELERATION = 7;
//C     #define LUSOL_IP_SINGULARLISTSIZE    9
const LUSOL_IP_KEEPLU = 8;

const LUSOL_IP_SINGULARLISTSIZE = 9;
/* luparm OUTPUT parameters: */
//C     #define LUSOL_IP_INFORM             10
//C     #define LUSOL_IP_SINGULARITIES      11
const LUSOL_IP_INFORM = 10;
//C     #define LUSOL_IP_SINGULARINDEX      12
const LUSOL_IP_SINGULARITIES = 11;
//C     #define LUSOL_IP_MINIMUMLENA        13
const LUSOL_IP_SINGULARINDEX = 12;
//C     #define LUSOL_IP_MAXLEN             14
const LUSOL_IP_MINIMUMLENA = 13;
//C     #define LUSOL_IP_UPDATECOUNT        15
const LUSOL_IP_MAXLEN = 14;
//C     #define LUSOL_IP_RANK_U             16
const LUSOL_IP_UPDATECOUNT = 15;
//C     #define LUSOL_IP_COLCOUNT_DENSE1    17
const LUSOL_IP_RANK_U = 16;
//C     #define LUSOL_IP_COLCOUNT_DENSE2    18
const LUSOL_IP_COLCOUNT_DENSE1 = 17;
//C     #define LUSOL_IP_COLINDEX_DUMIN     19
const LUSOL_IP_COLCOUNT_DENSE2 = 18;
//C     #define LUSOL_IP_COLCOUNT_L0        20
const LUSOL_IP_COLINDEX_DUMIN = 19;
//C     #define LUSOL_IP_NONZEROS_L0        21
const LUSOL_IP_COLCOUNT_L0 = 20;
//C     #define LUSOL_IP_NONZEROS_U0        22
const LUSOL_IP_NONZEROS_L0 = 21;
//C     #define LUSOL_IP_NONZEROS_L         23
const LUSOL_IP_NONZEROS_U0 = 22;
//C     #define LUSOL_IP_NONZEROS_U         24
const LUSOL_IP_NONZEROS_L = 23;
//C     #define LUSOL_IP_NONZEROS_ROW       25
const LUSOL_IP_NONZEROS_U = 24;
//C     #define LUSOL_IP_COMPRESSIONS_LU    26
const LUSOL_IP_NONZEROS_ROW = 25;
//C     #define LUSOL_IP_MARKOWITZ_MERIT    27
const LUSOL_IP_COMPRESSIONS_LU = 26;
//C     #define LUSOL_IP_TRIANGROWS_U       28
const LUSOL_IP_MARKOWITZ_MERIT = 27;
//C     #define LUSOL_IP_TRIANGROWS_L       29
const LUSOL_IP_TRIANGROWS_U = 28;
//C     #define LUSOL_IP_FTRANCOUNT         30
const LUSOL_IP_TRIANGROWS_L = 29;
//C     #define LUSOL_IP_BTRANCOUNT         31
const LUSOL_IP_FTRANCOUNT = 30;
//C     #define LUSOL_IP_ROWCOUNT_L0        32
const LUSOL_IP_BTRANCOUNT = 31;
//C     #define LUSOL_IP_LASTITEM            LUSOL_IP_ROWCOUNT_L0
const LUSOL_IP_ROWCOUNT_L0 = 32;

alias LUSOL_IP_ROWCOUNT_L0 LUSOL_IP_LASTITEM;

/* Macros for matrix-based access for dense part of A and timer mapping      */
/* ------------------------------------------------------------------------- */
//C     #define DAPOS(row, col)   (row + (col-1)*LDA)
//C     #define timer(text, id)   LUSOL_timer(LUSOL, id, text)


/* Parameter/option defines                                                  */
/* ------------------------------------------------------------------------- */
//C     #define LUSOL_MSG_NONE              -1
//C     #define LUSOL_MSG_SINGULARITY        0
const LUSOL_MSG_NONE = -1;
//C     #define LUSOL_MSG_STATISTICS        10
const LUSOL_MSG_SINGULARITY = 0;
//C     #define LUSOL_MSG_PIVOT             50
const LUSOL_MSG_STATISTICS = 10;

const LUSOL_MSG_PIVOT = 50;
//C     #define LUSOL_BASEORDER              0
//C     #define LUSOL_OTHERORDER             1
const LUSOL_BASEORDER = 0;
//C     #define LUSOL_AUTOORDER              2
const LUSOL_OTHERORDER = 1;
//C     #define LUSOL_ACCELERATE_L0          4
const LUSOL_AUTOORDER = 2;
//C     #define LUSOL_ACCELERATE_U           8
const LUSOL_ACCELERATE_L0 = 4;

const LUSOL_ACCELERATE_U = 8;
//C     #define LUSOL_PIVMOD_NOCHANGE       -2  /* Don't change active pivoting model */
//C     #define LUSOL_PIVMOD_DEFAULT        -1  /* Set pivoting model to default */
const LUSOL_PIVMOD_NOCHANGE = -2;
//C     #define LUSOL_PIVMOD_TPP             0  /* Threshold Partial   pivoting (normal) */
const LUSOL_PIVMOD_DEFAULT = -1;
//C     #define LUSOL_PIVMOD_TRP             1  /* Threshold Rook      pivoting */
const LUSOL_PIVMOD_TPP = 0;
//C     #define LUSOL_PIVMOD_TCP             2  /* Threshold Complete  pivoting */
const LUSOL_PIVMOD_TRP = 1;
//C     #define LUSOL_PIVMOD_TSP             3  /* Threshold Symmetric pivoting */
const LUSOL_PIVMOD_TCP = 2;
//C     #define LUSOL_PIVMOD_MAX             LUSOL_PIVMOD_TSP
const LUSOL_PIVMOD_TSP = 3;

alias LUSOL_PIVMOD_TSP LUSOL_PIVMOD_MAX;
//C     #define LUSOL_PIVTOL_NOCHANGE        0
//C     #define LUSOL_PIVTOL_BAGGY           1
const LUSOL_PIVTOL_NOCHANGE = 0;
//C     #define LUSOL_PIVTOL_LOOSE           2
const LUSOL_PIVTOL_BAGGY = 1;
//C     #define LUSOL_PIVTOL_NORMAL          3
const LUSOL_PIVTOL_LOOSE = 2;
//C     #define LUSOL_PIVTOL_SLIM            4
const LUSOL_PIVTOL_NORMAL = 3;
//C     #define LUSOL_PIVTOL_TIGHT           5
const LUSOL_PIVTOL_SLIM = 4;
//C     #define LUSOL_PIVTOL_SUPER           6
const LUSOL_PIVTOL_TIGHT = 5;
//C     #define LUSOL_PIVTOL_CORSET          7
const LUSOL_PIVTOL_SUPER = 6;
//C     #define LUSOL_PIVTOL_DEFAULT         LUSOL_PIVTOL_SLIM
const LUSOL_PIVTOL_CORSET = 7;
//C     #define LUSOL_PIVTOL_MAX             LUSOL_PIVTOL_CORSET
alias LUSOL_PIVTOL_SLIM LUSOL_PIVTOL_DEFAULT;

alias LUSOL_PIVTOL_CORSET LUSOL_PIVTOL_MAX;
//C     #define LUSOL_UPDATE_OLDEMPTY        0  /* No/empty current column. */
//C     #define LUSOL_UPDATE_OLDNONEMPTY     1  /* Current column need not have been empty. */
const LUSOL_UPDATE_OLDEMPTY = 0;
//C     #define LUSOL_UPDATE_NEWEMPTY        0  /* New column is taken to be zero. */
const LUSOL_UPDATE_OLDNONEMPTY = 1;
//C     #define LUSOL_UPDATE_NEWNONEMPTY     1  
/* v(*) contains the new column;
const LUSOL_UPDATE_NEWEMPTY = 0;
                                           on exit,  v(*)  satisfies  L*v = a(new). */
//C     #define LUSOL_UPDATE_USEPREPARED     2  /* v(*)  must satisfy  L*v = a(new). */
const LUSOL_UPDATE_NEWNONEMPTY = 1;

const LUSOL_UPDATE_USEPREPARED = 2;
//C     #define LUSOL_SOLVE_Lv_v             1  /* v  solves   L v = v(input). w  is not touched. */
//C     #define LUSOL_SOLVE_Ltv_v            2  /* v  solves   L'v = v(input). w  is not touched. */
const LUSOL_SOLVE_Lv_v = 1;
//C     #define LUSOL_SOLVE_Uw_v             3  /* w  solves   U w = v.        v  is not altered. */
const LUSOL_SOLVE_Ltv_v = 2;
//C     #define LUSOL_SOLVE_Utv_w            4  /* v  solves   U'v = w.        w  is destroyed. */
const LUSOL_SOLVE_Uw_v = 3;
//C     #define LUSOL_SOLVE_Aw_v             5  /* w  solves   A w = v.        v  is altered as in 1. */
const LUSOL_SOLVE_Utv_w = 4;
//C     #define LUSOL_FTRAN   LUSOL_SOLVE_Aw_v
const LUSOL_SOLVE_Aw_v = 5;
//C     #define LUSOL_SOLVE_Atv_w            6  /* v  solves   A'v = w.        w  is destroyed. */
alias LUSOL_SOLVE_Aw_v LUSOL_FTRAN;
//C     #define LUSOL_BTRAN  LUSOL_SOLVE_Atv_w
const LUSOL_SOLVE_Atv_w = 6;

alias LUSOL_SOLVE_Atv_w LUSOL_BTRAN;
/* If mode = 3,4,5,6, v and w must not be the same arrays.
   If lu1fac has just been used to factorize a symmetric matrix A
   (which must be definite or quasi-definite), the factors A = L U
   may be regarded as A = LDL', where D = diag(U).  In such cases,
   the following (faster) solve codes may be used:                  */
//C     #define LUSOL_SOLVE_Av_v             7  /* v  solves   A v = L D L'v = v(input). w  is not touched. */
//C     #define LUSOL_SOLVE_LDLtv_v          8  /* v  solves       L |D| L'v = v(input). w  is not touched. */
const LUSOL_SOLVE_Av_v = 7;

const LUSOL_SOLVE_LDLtv_v = 8;
//C     #define LUSOL_INFORM_RANKLOSS       -1
//C     #define LUSOL_INFORM_LUSUCCESS       0
const LUSOL_INFORM_RANKLOSS = -1;
//C     #define LUSOL_INFORM_LUSINGULAR      1
const LUSOL_INFORM_LUSUCCESS = 0;
//C     #define LUSOL_INFORM_LUUNSTABLE      2
const LUSOL_INFORM_LUSINGULAR = 1;
//C     #define LUSOL_INFORM_ADIMERR         3
const LUSOL_INFORM_LUUNSTABLE = 2;
//C     #define LUSOL_INFORM_ADUPLICATE      4
const LUSOL_INFORM_ADIMERR = 3;
//C     #define LUSOL_INFORM_ANEEDMEM        7  /* Set lena >= luparm[LUSOL_IP_MINIMUMLENA] */
const LUSOL_INFORM_ADUPLICATE = 4;
//C     #define LUSOL_INFORM_FATALERR        8
const LUSOL_INFORM_ANEEDMEM = 7;
//C     #define LUSOL_INFORM_NOPIVOT         9  /* No diagonal pivot found with TSP or TDP. */
const LUSOL_INFORM_FATALERR = 8;
//C     #define LUSOL_INFORM_NOMEMLEFT      10
const LUSOL_INFORM_NOPIVOT = 9;

const LUSOL_INFORM_NOMEMLEFT = 10;
//C     #define LUSOL_INFORM_MIN             LUSOL_INFORM_RANKLOSS
//C     #define LUSOL_INFORM_MAX             LUSOL_INFORM_NOMEMLEFT
alias LUSOL_INFORM_RANKLOSS LUSOL_INFORM_MIN;

alias LUSOL_INFORM_NOMEMLEFT LUSOL_INFORM_MAX;
//C     #define LUSOL_INFORM_GETLAST        10  /* Code for LUSOL_informstr. */
//C     #define LUSOL_INFORM_SERIOUS         LUSOL_INFORM_LUUNSTABLE
const LUSOL_INFORM_GETLAST = 10;

alias LUSOL_INFORM_LUUNSTABLE LUSOL_INFORM_SERIOUS;

/* Prototypes for call-back functions                                        */
/* ------------------------------------------------------------------------- */
//C     typedef void LUSOLlogfunc(void *lp, void *userhandle, char *buf);
extern (C):
alias void function(void *lp, void *userhandle, char *buf)LUSOLlogfunc;


/* Sparse matrix data */
//C     typedef struct _LUSOLmat {
//C       REAL *a;
//C       int  *lenx, *indr, *indc, *indx;
//C     } LUSOLmat;
struct _LUSOLmat
{
    double *a;
    int *lenx;
    int *indr;
    int *indc;
    int *indx;
}
alias _LUSOLmat LUSOLmat;


/* The main LUSOL data record */
/* ------------------------------------------------------------------------- */
//C     typedef struct _LUSOLrec {

  /* General data */
//C       FILE         *outstream;           /* Output stream, initialized to STDOUT */
//C       LUSOLlogfunc *writelog;
//C         void       *loghandle;
//C       LUSOLlogfunc *debuginfo;

  /* Parameter storage arrays */
//C       int    luparm[LUSOL_IP_LASTITEM + 1];
//C       REAL   parmlu[LUSOL_RP_LASTITEM + 1];

  /* Arrays of length lena+1 */
//C       int    lena, nelem;
//C       int    *indc, *indr;
//C       REAL   *a;

  /* Arrays of length maxm+1 (row storage) */
//C       int    maxm, m;
//C       int    *lenr, *ip, *iqloc, *ipinv, *locr;

  /* Arrays of length maxn+1 (column storage) */
//C       int    maxn, n;
//C       int    *lenc, *iq, *iploc, *iqinv, *locc;
//C       REAL   *w, *vLU6L;

  /* List of singular columns, with dynamic size allocation */
//C       int    *isingular;

  /* Extra arrays of length n for TCP and keepLU == FALSE */
//C       REAL   *Ha, *diagU;
//C       int    *Hj, *Hk;

  /* Extra arrays of length m for TRP*/
//C       REAL   *amaxr;

  /* Extra array for L0 and U stored by row/column for faster btran/ftran */
//C       LUSOLmat *L0;
//C       LUSOLmat *U;

  /* Miscellaneous data */
//C       int    expanded_a;
//C       int    replaced_c;
//C       int    replaced_r;

//C     } LUSOLrec;
struct _LUSOLrec
{
    FILE *outstream;
    void  function(void *lp, void *userhandle, char *buf)writelog;
    void *loghandle;
    void  function(void *lp, void *userhandle, char *buf)debuginfo;
    int [33]luparm;
    double [21]parmlu;
    int lena;
    int nelem;
    int *indc;
    int *indr;
    double *a;
    int maxm;
    int m;
    int *lenr;
    int *ip;
    int *iqloc;
    int *ipinv;
    int *locr;
    int maxn;
    int n;
    int *lenc;
    int *iq;
    int *iploc;
    int *iqinv;
    int *locc;
    double *w;
    double *vLU6L;
    int *isingular;
    double *Ha;
    double *diagU;
    int *Hj;
    int *Hk;
    double *amaxr;
    LUSOLmat *L0;
    LUSOLmat *U;
    int expanded_a;
    int replaced_c;
    int replaced_r;
}
alias _LUSOLrec LUSOLrec;


//C     LUSOLrec *LUSOL_create(FILE *outstream, int msgfil, int pivotmodel, int updatelimit);
LUSOLrec * LUSOL_create(FILE *outstream, int msgfil, int pivotmodel, int updatelimit);
//C     MYBOOL LUSOL_sizeto(LUSOLrec *LUSOL, int init_r, int init_c, int init_a);
ubyte  LUSOL_sizeto(LUSOLrec *LUSOL, int init_r, int init_c, int init_a);
//C     MYBOOL LUSOL_assign(LUSOLrec *LUSOL, int iA[], int jA[], REAL Aij[],
//C                                          int nzcount, MYBOOL istriplet);
ubyte  LUSOL_assign(LUSOLrec *LUSOL, int *iA, int *jA, double *Aij, int nzcount, ubyte istriplet);
//C     void LUSOL_clear(LUSOLrec *LUSOL, MYBOOL nzonly);
void  LUSOL_clear(LUSOLrec *LUSOL, ubyte nzonly);
//C     void LUSOL_free(LUSOLrec *LUSOL);
void  LUSOL_free(LUSOLrec *LUSOL);

//C     LUSOLmat *LUSOL_matcreate(int dim, int nz);
LUSOLmat * LUSOL_matcreate(int dim, int nz);
//C     void LUSOL_matfree(LUSOLmat **mat);
void  LUSOL_matfree(LUSOLmat **mat);

//C     int LUSOL_loadColumn(LUSOLrec *LUSOL, int iA[], int jA, REAL Aij[], int nzcount, int offset1);
int  LUSOL_loadColumn(LUSOLrec *LUSOL, int *iA, int jA, double *Aij, int nzcount, int offset1);
//C     void LUSOL_setpivotmodel(LUSOLrec *LUSOL, int pivotmodel, int initlevel);
void  LUSOL_setpivotmodel(LUSOLrec *LUSOL, int pivotmodel, int initlevel);
//C     int LUSOL_factorize(LUSOLrec *LUSOL);
int  LUSOL_factorize(LUSOLrec *LUSOL);
//C     int LUSOL_replaceColumn(LUSOLrec *LUSOL, int jcol, REAL v[]);
int  LUSOL_replaceColumn(LUSOLrec *LUSOL, int jcol, double *v);

//C     MYBOOL LUSOL_tightenpivot(LUSOLrec *LUSOL);
ubyte  LUSOL_tightenpivot(LUSOLrec *LUSOL);
//C     MYBOOL LUSOL_addSingularity(LUSOLrec *LUSOL, int singcol, int *inform);
ubyte  LUSOL_addSingularity(LUSOLrec *LUSOL, int singcol, int *inform);
//C     int LUSOL_getSingularity(LUSOLrec *LUSOL, int singitem);
int  LUSOL_getSingularity(LUSOLrec *LUSOL, int singitem);
//C     int LUSOL_findSingularityPosition(LUSOLrec *LUSOL, int singcol);
int  LUSOL_findSingularityPosition(LUSOLrec *LUSOL, int singcol);

//C     char *LUSOL_pivotLabel(LUSOLrec *LUSOL);
char * LUSOL_pivotLabel(LUSOLrec *LUSOL);
//C     char *LUSOL_informstr(LUSOLrec *LUSOL, int inform);
char * LUSOL_informstr(LUSOLrec *LUSOL, int inform);
//C     REAL LUSOL_vecdensity(LUSOLrec *LUSOL, REAL V[]);
double  LUSOL_vecdensity(LUSOLrec *LUSOL, double *V);
//C     void LUSOL_report(LUSOLrec *LUSOL, int msglevel, char *format, ...);
void  LUSOL_report(LUSOLrec *LUSOL, int msglevel, char *format,...);
//C     void LUSOL_timer(LUSOLrec *LUSOL, int timerid, char *text);
void  LUSOL_timer(LUSOLrec *LUSOL, int timerid, char *text);

//C     int LUSOL_ftran(LUSOLrec *LUSOL, REAL b[], int NZidx[], MYBOOL prepareupdate);
int  LUSOL_ftran(LUSOLrec *LUSOL, double *b, int *NZidx, ubyte prepareupdate);
//C     int LUSOL_btran(LUSOLrec *LUSOL, REAL b[], int NZidx[]);
int  LUSOL_btran(LUSOLrec *LUSOL, double *b, int *NZidx);

//C     void LU1FAC(LUSOLrec *LUSOL, int *INFORM);
void  LU1FAC(LUSOLrec *LUSOL, int *INFORM);
//C     MYBOOL LU1L0(LUSOLrec *LUSOL, LUSOLmat **mat, int *inform);
ubyte  LU1L0(LUSOLrec *LUSOL, LUSOLmat **mat, int *inform);
//C     void LU6SOL(LUSOLrec *LUSOL, int MODE, REAL V[], REAL W[], int NZidx[], int *INFORM);
void  LU6SOL(LUSOLrec *LUSOL, int MODE, double *V, double *W, int *NZidx, int *INFORM);
//C     void LU8RPC(LUSOLrec *LUSOL, int MODE1, int MODE2,
//C                 int JREP, REAL V[], REAL W[],
//C                 int *INFORM, REAL *DIAG, REAL *VNORM);
void  LU8RPC(LUSOLrec *LUSOL, int MODE1, int MODE2, int JREP, double *V, double *W, int *INFORM, double *DIAG, double *VNORM);

//C     void LUSOL_dump(FILE *output, LUSOLrec *LUSOL);
void  LUSOL_dump(FILE *output, LUSOLrec *LUSOL);


//C     void print_L0(LUSOLrec *LUSOL);
void  print_L0(LUSOLrec *LUSOL);


//C     #endif /* HEADER_LUSOL */
