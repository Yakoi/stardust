/* Converted to D from lp_types.h by htod */
module lp_solve.lp_types;
//C     #ifndef HEADER_lp_types
//C     #define HEADER_lp_types

//C     #ifdef WIN32
//C       #include <windows.h>
import core.sys.windows.windows;
import lp_solve.lp_lib;
//C     #endif

/* Define data types                                                         */
/* ------------------------------------------------------------------------- */
//C     #ifndef LLONG
//C       #if defined __BORLANDC__
//C         #define LLONG __int64
//C       #elif !defined _MSC_VER || _MSC_VER >= 1310
//C         #define LLONG long long
//C       #else
//C         #define LLONG __int64
//C       #endif
//C     #endif

//C     #ifndef COUNTER
//C       #define COUNTER LLONG
//C     #endif
alias long LLONG;
alias LLONG COUNTER;

//C     #ifndef REAL
//C       #define REAL    double
//C     #endif
alias double REAL;

//C     #ifndef REALXP
//C       #if 1
//C         #define REALXP long double  /* Set local accumulation variable as long double */
//C       #else
//C         #define REALXP REAL          /* Set local accumulation as default precision */
//C       #endif
//C     #endif

//C     #ifndef LREAL
//C       #if 0
//C         #define LREAL long double   /* Set global solution update variable as long double */
//C       #else
//C         #define LREAL REAL           /* Set global solution update variable as default precision */
//C       #endif
alias REAL LREAL;
//C     #endif

//C     #define RESULTVALUEMASK "%18.12g" 
/* Set fixed-format real-valued output precision;
                                  suggested width: ABS(exponent of DEF_EPSVALUE)+6. */
//C     #define INDEXVALUEMASK  "%8d"     /* Set fixed-format integer-valued output width */

//C     #ifndef DEF_STRBUFSIZE
//C       #define DEF_STRBUFSIZE   512
//C     #endif
const DEF_STRBUFSIZE = 512;
//C     #ifndef MAXINT32
//C       #define MAXINT32  2147483647
//C     #endif
const MAXINT32 = 2147483647;
//C     #ifndef MAXUINT32
//C       #define MAXUINT32 4294967295
//C     #endif
const MAXUINT32 = 4294967295;

//C     #ifndef MAXINT64
//C       #if defined _LONGLONG || defined __LONG_LONG_MAX__ || defined LLONG_MAX
//C         #define MAXINT64   9223372036854775807ll
//C       #else
//C         #define MAXINT64   9223372036854775807l
//C       #endif
const MAXINT64 = 9223372036854775807;
//C     #endif
//C     #ifndef MAXUINT64
//C       #if defined _LONGLONG || defined __LONG_LONG_MAX__ || defined LLONG_MAX
//C         #define MAXUINT64 18446744073709551615ll
//C       #else
//C         #define MAXUINT64 18446744073709551615l
//C       #endif
const real MAXUINT64 = 18446744073709551615.0;
//C     #endif

//C     #ifndef CHAR_BIT
//C       #define CHAR_BIT  8
//C     #endif
const CHAR_BIT = 8;
//C     #ifndef MYBOOL
//C       #define MYBOOL  unsigned char    /* Conserve memory, could be unsigned int */
//C     #endif


/* Constants                                                                 */
/* ------------------------------------------------------------------------- */
//C     #ifndef NULL
//C       #define NULL                   0
//C     #endif

/* Byte-sized Booleans and extended options */
//C     #define FALSE                    0
//C     #define TRUE                     1
const FALSE = 0;
//C     #define AUTOMATIC                2
const TRUE = 1;
//C     #define DYNAMIC                  4
const AUTOMATIC = 2;

const DYNAMIC = 4;
/* Sorting and comparison constants */
//C     #define COMP_PREFERCANDIDATE     1
//C     #define COMP_PREFERNONE          0
const COMP_PREFERCANDIDATE = 1;
//C     #define COMP_PREFERINCUMBENT    -1
const COMP_PREFERNONE = 0;

const COMP_PREFERINCUMBENT = -1;
/* Library load status values */
//C     #define LIB_LOADED               0
//C     #define LIB_NOTFOUND             1
const LIB_LOADED = 0;
//C     #define LIB_NOINFO               2
const LIB_NOTFOUND = 1;
//C     #define LIB_NOFUNCTION           3
const LIB_NOINFO = 2;
//C     #define LIB_VERINVALID           4
const LIB_NOFUNCTION = 3;
//C     #define LIB_STR_LOADED           "Successfully loaded"
const LIB_VERINVALID = 4;
//C     #define LIB_STR_NOTFOUND         "File not found"
//C     #define LIB_STR_NOINFO           "No version data"
//C     #define LIB_STR_NOFUNCTION       "Missing function header"
//C     #define LIB_STR_VERINVALID       "Incompatible version"
//C     #define LIB_STR_MAXLEN           23

const LIB_STR_MAXLEN = 23;

/* Compiler/target settings                                                  */
/* ------------------------------------------------------------------------- */
//C     #if (defined _WIN32) || (defined WIN32) || (defined _WIN64) || (defined WIN64)
//C     # define __WINAPI WINAPI
//C     #else
//alias WINAPI __WINAPI;
//C     # define __WINAPI
//C     #endif

//C     #if (defined _WIN32) || (defined WIN32) || (defined _WIN64) || (defined WIN64)
//C     # define __VACALL __cdecl
//C     #else
//alias __cdecl __VACALL;
//C     # define __VACALL
//C     #endif

//C     #ifndef __BORLANDC__

//C       #ifdef _USRDLL

//C         #if 1
//C           #define __EXPORT_TYPE 
//C         #else
     /* Set up for the Microsoft compiler */
//C           #ifdef LP_SOLVE_EXPORTS
//C             #define __EXPORT_TYPE __declspec(dllexport)
//C           #else
//C             #define __EXPORT_TYPE __declspec(dllimport)
//C           #endif
//C         #endif

//C       #else

//C         #define __EXPORT_TYPE

//C       #endif

//C       #ifdef __cplusplus
//C         #define __EXTERN_C extern "C"
//C       #else
//C         #define __EXTERN_C
//C       #endif

//C     #else  /* Otherwise set up for the Borland compiler */

//C       #ifdef __DLL__

//C         #define _USRDLL
//C         #define __EXTERN_C extern "C"

//C         #ifdef __READING_THE_DLL
//C           #define __EXPORT_TYPE __import
//C         #else
//C           #define __EXPORT_TYPE __export
//C         #endif

//C       #else

//C         #define __EXPORT_TYPE
//C         #define __EXTERN_C extern "C"

//C       #endif

//C     #endif


//C     #if 0
//C       #define STATIC static
//C     #else
//C       #define STATIC
//C     #endif

//C     #if !defined INLINE
//C       #if defined __cplusplus
//C         #define INLINE inline
//C       #elif (defined _WIN32) || (defined WIN32) || (defined _WIN64) || (defined WIN64)
//C         #define INLINE __inline
//C       #else
//alias __inline INLINE;
//C         #define INLINE static
//C       #endif
//C     #endif

/* Function macros                                                           */
/* ------------------------------------------------------------------------- */
//C     #define my_limitrange(x, lo, hi) ((x) < (lo) ? (lo) : ((x) > (hi) ? (hi) : (x)))
//C     #ifndef my_mod
//C       #define my_mod(n, m)          ((n) % (m))
//C     #endif
//C     #define my_if(t, x, y)          ((t) ? (x) : (y))
//C     #define my_sign(x)              ((x) < 0 ? -1 : 1)
//C     #if 0
//C       #define my_chsign(t, x)       ( ((t) && ((x) != 0)) ? -(x) : (x))
//C     #else
//C       #define my_chsign(t, x)       ( (2*((t) == 0) - 1) * (x) )  /* "Pipelined" */
//C     #endif
//C     #define my_flipsign(x)          ( fabs((REAL) (x)) == 0 ? 0 : -(x) )
//C     #define my_roundzero(val, eps)  if (fabs((REAL) (val)) < eps) val = 0
//C     #define my_avoidtiny(val, eps)  (fabs((REAL) (val)) < eps ? 0 : val)

//C     #if 1
//C       #define my_infinite(lp, val)  ( (MYBOOL) (fabs(val) >= lp->infinite) )
//C     #else
//C       #define my_infinite(lp, val)  is_infinite(lp, val)
//C     #endif
//C     #define my_inflimit(lp, val)    ( my_infinite(lp, val) ? lp->infinite * my_sign(val) : (val) )
//C     #if 0
//C       #define my_precision(val, eps) ((fabs((REAL) (val))) < (eps) ? 0 : (val))
//C     #else
//C       #define my_precision(val, eps) restoreINT(val, eps)
//C     #endif
//C     #define my_reldiff(x, y)       (((x) - (y)) / (1.0 + fabs((REAL) (y))))
//C     #define my_boundstr(x)         (fabs(x) < lp->infinite ? sprintf("%g",x) : ((x) < 0 ? "-Inf" : "Inf") )
//C     #ifndef my_boolstr
//C       #define my_boolstr(x)          (!(x) ? "FALSE" : "TRUE")
//C     #endif
//C     #define my_basisstr(isbasic)     ((isbasic) ? "BASIC" : "NON-BASIC")
//C     #define my_simplexstr(isdual)    ((isdual) ? "DUAL" : "PRIMAL")
//C     #define my_plural_std(count)     (count == 1 ? "" : "s")
//C     #define my_plural_y(count)       (count == 1 ? "y" : "ies")
//C     #define my_lowbound(x)           ((FULLYBOUNDEDSIMPLEX) ? (x) : 0)


/* Bound macros usable for both the standard and fully bounded simplex       */
/* ------------------------------------------------------------------------- */
/*
#define my_lowbo(lp, varnr)      ( lp->isfullybounded ? lp->lowbo[varnr] : 0.0 )
#define my_upbo(lp, varnr)       ( lp->isfullybounded ? lp->upbo[varnr]  : lp->lowbo[varnr] + lp->upbo[varnr] )
#define my_rangebo(lp, varnr)    ( lp->isfullybounded ? lp->upbo[varnr] - lp->lowbo[varnr] : lp->upbo[varnr] )
*/
//C     #define my_lowbo(lp, varnr)      ( 0.0 )
//C     #define my_upbo(lp, varnr)       ( lp->lowbo[varnr] + lp->upbo[varnr] )
//C     #define my_rangebo(lp, varnr)    ( lp->upbo[varnr] )

//C     #define my_unbounded(lp, varnr)  ((lp->upbo[varnr] >= lp->infinite) && (lp->lowbo[varnr] <= -lp->infinite))
//C     #define my_bounded(lp, varnr)    ((lp->upbo[varnr] < lp->infinite) && (lp->lowbo[varnr] > -lp->infinite))

/* Forward declarations                                                      */
/* ------------------------------------------------------------------------- */
//C     typedef struct _lprec     lprec;
extern (C):
alias _lprec lprec;
//C     typedef struct _INVrec    INVrec;
//alias _INVrec INVrec;
//C     union  QSORTrec;
union  QSORTrec;

//C     #ifndef UNIONTYPE
//C       #ifdef __cplusplus
//C         #define UNIONTYPE
//C       #else
//C         #define UNIONTYPE union
//C       #endif
//alias union UNIONTYPE;
//C     #endif

/* B4 factorization optimization data */
//C     typedef struct _B4rec
//C     {
//C       int  *B4_var;  /* Position of basic columns in the B4 basis */
//C       int  *var_B4;  /* Variable in the B4 basis */
//C       int  *B4_row;  /* B4 position of the i'th row */
//C       int  *row_B4;  /* Original position of the i'th row */
//C       REAL *wcol;
//C       int  *nzwcol;
//C     } B4rec;
struct _B4rec
{
    int *B4_var;
    int *var_B4;
    int *B4_row;
    int *row_B4;
    double *wcol;
    int *nzwcol;
}
alias _B4rec B4rec;

//C     #define OBJ_STEPS   5
//C     typedef struct _OBJmonrec {
const OBJ_STEPS = 5;
//C       lprec  *lp;
//C       int    oldpivstrategy,
//C              oldpivrule, pivrule, ruleswitches,
//C              limitstall[2], limitruleswitches,
//C              idxstep[OBJ_STEPS], countstep, startstep, currentstep,
//C              Rcycle, Ccycle, Ncycle, Mcycle, Icount;
//C       REAL   thisobj, prevobj,
//C              objstep[OBJ_STEPS],
//C              thisinfeas, previnfeas,
//C              epsvalue;
//C       char   spxfunc[10];
//C       MYBOOL pivdynamic;
//C       MYBOOL isdual;
//C       MYBOOL active;
//C     } OBJmonrec;
struct _OBJmonrec
{
    lprec *lp;
    int oldpivstrategy;
    int oldpivrule;
    int pivrule;
    int ruleswitches;
    int [2]limitstall;
    int limitruleswitches;
    int [5]idxstep;
    int countstep;
    int startstep;
    int currentstep;
    int Rcycle;
    int Ccycle;
    int Ncycle;
    int Mcycle;
    int Icount;
    double thisobj;
    double prevobj;
    double [5]objstep;
    double thisinfeas;
    double previnfeas;
    double epsvalue;
    char [10]spxfunc;
    ubyte pivdynamic;
    ubyte isdual;
    ubyte active;
}
alias _OBJmonrec OBJmonrec;

//C     typedef struct _edgerec
//C     {
//C       REAL      *edgeVector;
//C     } edgerec;
struct _edgerec
{
    double *edgeVector;
}
alias _edgerec edgerec;

//C     typedef struct _pricerec
//C     {
//C       REAL   theta;
//C       REAL   pivot;
//C       REAL   epspivot;
//C       int    varno;
//C       lprec  *lp;
//C       MYBOOL isdual;
//C     } pricerec;
struct _pricerec
{
    double theta;
    double pivot;
    double epspivot;
    int varno;
    lprec *lp;
    ubyte isdual;
}
alias _pricerec pricerec;
//C     typedef struct _multirec
//C     {
//C       lprec    *lp;
//C       int      size;                  /* The maximum number of multiply priced rows/columns */
//C       int      used;                  /* The current / active number of multiply priced rows/columns */
//C       int      limit;                 /* The active/used count at which a full update is triggered */
//C       pricerec *items;                /* Array of best multiply priced rows/columns */
//C       int      *freeList;             /* The indeces of available positions in "items" */
//C       UNIONTYPE QSORTrec *sortedList; /* List of pointers to "pricerec" items in sorted order */
//C       REAL     *stepList;             /* Working array (values in sortedList order) */
//C       REAL     *valueList;            /* Working array (values in sortedList order) */
//C       int      *indexSet;             /* The final exported index list of pivot variables */
//C       int      active;                /* Index of currently active multiply priced row/column */
//C       int      retries;
//C       REAL     step_base;
//C       REAL     step_last;
//C       REAL     obj_base;
//C       REAL     obj_last;
//C       REAL     epszero;
//C       REAL     maxpivot;
//C       REAL     maxbound;
//C       MYBOOL   sorted;
//C       MYBOOL   truncinf;
//C       MYBOOL   objcheck;
//C       MYBOOL   dirty;
//C     } multirec;

//C     #endif /* HEADER_lp_types */
struct _multirec
{
    lprec *lp;
    int size;
    int used;
    int limit;
    pricerec *items;
    int *freeList;
    QSORTrec *sortedList;
    double *stepList;
    double *valueList;
    int *indexSet;
    int active;
    int retries;
    double step_base;
    double step_last;
    double obj_base;
    double obj_last;
    double epszero;
    double maxpivot;
    double maxbound;
    ubyte sorted;
    ubyte truncinf;
    ubyte objcheck;
    ubyte dirty;
}
alias _multirec multirec;

//C     #endif /* HEADER_lp_types */
