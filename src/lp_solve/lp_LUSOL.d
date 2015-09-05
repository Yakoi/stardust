/* Converted to D from lp_LUSOL.h by htod */
module lp_solve.lp_lusol;
//C     #ifndef HEADER_lp_LUSOL
//C     #define HEADER_lp_LUSOL

/* Include libraries for this inverse system */
//C     #include "lp_types.h"
import lp_solve.lp_types;
//C     #include "lusol.h"
import lp_solve.lusol;

/* LUSOL defines */
//C     #ifdef WIN32
//C     # define LUSOL_UseBLAS
//C     #endif
/*#define MAPSINGULARCOLUMN*/
//C     #define MATINDEXBASE LUSOL_ARRAYOFFSET /* Inversion engine index start for arrays */
//C     #define LU_START_SIZE           10000  /* Start size of LU; realloc'ed if needed */
alias LUSOL_ARRAYOFFSET MATINDEXBASE;
//C     #define DEF_MAXPIVOT              250  /* Maximum number of pivots before refactorization */
const LU_START_SIZE = 10000;
//C     #define MAX_DELTAFILLIN           2.0  /* Do refactorizations based on sparsity considerations */
const DEF_MAXPIVOT = 250;
//C     #define TIGHTENAFTER               10  /* Tighten LU pivot criteria only after this number of singularities */
const MAX_DELTAFILLIN = 2.0;

const TIGHTENAFTER = 10;
/* typedef */
//C      struct _INVrec
//C     {
//C       int       status;                 /* Last operation status code */
//C       int       dimcount;               /* The actual number of LU rows/columns */
//C       int       dimalloc;               /* The allocated LU rows/columns size */
//C       int       user_colcount;          /* The number of user LU columns */
//C       LUSOLrec  *LUSOL;
//C       int       col_enter;              /* The full index of the entering column */
//C       int       col_leave;              /* The full index of the leaving column */
//C       int       col_pos;                /* The B column to be changed at the next update using data in value[.]*/
//C       REAL      *value;
//C       REAL      *pcol;                  /* Reference to the elimination vector */
//C       REAL      theta_enter;            /* Value of the entering column theta */

//C       int       max_Bsize;              /* The largest B matrix of user variables */
//C       int       max_colcount;           /* The maximum number of user columns in LU */
//C       int       max_LUsize;             /* The largest NZ-count of LU-files generated */
//C       int       num_refact;             /* Number of times the basis was refactored */
//C       int       num_timed_refact;
//C       int       num_dense_refact;
//C       double    time_refactstart;       /* Time since start of last refactorization-pivots cyle */
//C       double    time_refactnext;        /* Time estimated to next refactorization */
//C       int       num_pivots;             /* Number of pivots since last refactorization */
//C       int       num_singular;           /* The total number of singular updates */
//C       char      *opts;
//C       MYBOOL    is_dirty;               /* Specifies if a column is incompletely processed */
//C       MYBOOL    force_refact;           /* Force refactorization at the next opportunity */
//C       MYBOOL    timed_refact;           /* Set if timer-driven refactorization should be active */
//C       MYBOOL    set_Bidentity;          /* Force B to be the identity matrix at the next refactorization */
//C     } /* INVrec */;
struct _INVrec
{
    int status;
    int dimcount;
    int dimalloc;
    int user_colcount;
    LUSOLrec *LUSOL;
    int col_enter;
    int col_leave;
    int col_pos;
    double *value;
    double *pcol;
    double theta_enter;
    int max_Bsize;
    int max_colcount;
    int max_LUsize;
    int num_refact;
    int num_timed_refact;
    int num_dense_refact;
    double time_refactstart;
    double time_refactnext;
    int num_pivots;
    int num_singular;
    char *opts;
    ubyte is_dirty;
    ubyte force_refact;
    ubyte timed_refact;
    ubyte set_Bidentity;
}


//C     #ifdef __cplusplus
/* namespace LUSOL */
//C     extern "C" {
//C     #endif

/* Put function headers here */
//C     #include "lp_BFP.h"
//import lp_BFP;

//C     #ifdef __cplusplus
//C      }
//C     #endif

//C     #endif /* HEADER_lp_LUSOL */
