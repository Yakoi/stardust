/* Converted to D from lpsolve55\lp_mipbb.h by htod */
module lp_solve.lp_mipbb;
//C     #ifndef HEADER_lp_mipbb
//C     #define HEADER_lp_mipbb

//C     #include "lp_types.h"
import lp_solve.lp_types;
//C     #include "lp_utils.h"
import lp_solve.lp_utils;


/* Bounds storage for B&B routines */
//C     typedef struct _BBrec
//C     {
//C       struct    _BBrec *parent;
//C       struct    _BBrec *child;
//C       lprec     *lp;
//C       int       varno;
//C       int       vartype;
//C       int       lastvarcus;            /* Count of non-int variables of the previous branch */
//C       int       lastrcf;
//C       int       nodesleft;
//C       int       nodessolved;
//C       int       nodestatus;
//C       REAL      noderesult;
//C       REAL      lastsolution;          /* Optimal solution of the previous branch */
//C       REAL      sc_bound;
//C       REAL      *upbo,   *lowbo;
//C       REAL      UPbound, LObound;
//C       int       UBtrack, LBtrack;      /* Signals that incoming bounds were changed */
//C       MYBOOL    contentmode;           /* Flag indicating if we "own" the bound vectors */
//C       MYBOOL    sc_canset;
//C       MYBOOL    isSOS;
//C       MYBOOL    isGUB;
//C       int       *varmanaged;           /* Extended list of variables managed by this B&B level */
//C       MYBOOL    isfloor;               /* State variable indicating the active B&B bound */
//C       MYBOOL    UBzerobased;           /* State variable indicating if bounds have been rebased */
//C     } BBrec;
struct _BBrec
{
    _BBrec *parent;
    _BBrec *child;
    lprec *lp;
    int varno;
    int vartype;
    int lastvarcus;
    int lastrcf;
    int nodesleft;
    int nodessolved;
    int nodestatus;
    double noderesult;
    double lastsolution;
    double sc_bound;
    double *upbo;
    double *lowbo;
    double UPbound;
    double LObound;
    int UBtrack;
    int LBtrack;
    ubyte contentmode;
    ubyte sc_canset;
    ubyte isSOS;
    ubyte isGUB;
    int *varmanaged;
    ubyte isfloor;
    ubyte UBzerobased;
}
extern (C):
alias _BBrec BBrec;

//C     #ifdef __cplusplus
//C     extern "C" {
//C     #endif

//C     STATIC BBrec *create_BB(lprec *lp, BBrec *parentBB, MYBOOL dofullcopy);
BBrec * create_BB(lprec *lp, BBrec *parentBB, ubyte dofullcopy);
//C     STATIC BBrec *push_BB(lprec *lp, BBrec *parentBB, int varno, int vartype, int varcus);
BBrec * push_BB(lprec *lp, BBrec *parentBB, int varno, int vartype, int varcus);
//C     STATIC MYBOOL initbranches_BB(BBrec *BB);
ubyte  initbranches_BB(BBrec *BB);
//C     STATIC MYBOOL fillbranches_BB(BBrec *BB);
ubyte  fillbranches_BB(BBrec *BB);
//C     STATIC MYBOOL nextbranch_BB(BBrec *BB);
ubyte  nextbranch_BB(BBrec *BB);
//C     STATIC MYBOOL strongbranch_BB(lprec *lp, BBrec *BB, int varno, int vartype, int varcus);
ubyte  strongbranch_BB(lprec *lp, BBrec *BB, int varno, int vartype, int varcus);
//C     STATIC MYBOOL initcuts_BB(lprec *lp);
ubyte  initcuts_BB(lprec *lp);
//C     STATIC int updatecuts_BB(lprec *lp);
int  updatecuts_BB(lprec *lp);
//C     STATIC MYBOOL freecuts_BB(lprec *lp);
ubyte  freecuts_BB(lprec *lp);
//C     STATIC BBrec *findself_BB(BBrec *BB);
BBrec * findself_BB(BBrec *BB);
//C     STATIC int solve_LP(lprec *lp, BBrec *BB);
int  solve_LP(lprec *lp, BBrec *BB);
//C     STATIC int rcfbound_BB(BBrec *BB, int varno, MYBOOL isINT, REAL *newbound, MYBOOL *isfeasible);
int  rcfbound_BB(BBrec *BB, int varno, ubyte isINT, double *newbound, ubyte *isfeasible);
//C     STATIC MYBOOL findnode_BB(BBrec *BB, int *varno, int *vartype, int *varcus);
ubyte  findnode_BB(BBrec *BB, int *varno, int *vartype, int *varcus);
//C     STATIC int solve_BB(BBrec *BB);
int  solve_BB(BBrec *BB);
//C     STATIC MYBOOL free_BB(BBrec **BB);
ubyte  free_BB(BBrec **BB);
//C     STATIC BBrec *pop_BB(BBrec *BB);
BBrec * pop_BB(BBrec *BB);

//C     STATIC int run_BB(lprec *lp);
int  run_BB(lprec *lp);

//C     #ifdef __cplusplus
//C      }
//C     #endif

//C     #endif /* HEADER_lp_mipbb */

