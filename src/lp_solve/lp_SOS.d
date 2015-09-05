/* Converted to D from lp_SOS.h by htod */
module lp_solve.lp_SOS;
//C     #ifndef HEADER_lp_SOS
//C     #define HEADER_lp_SOS

/* Specially Ordered Sets (SOS) prototypes and settings                      */
/* ------------------------------------------------------------------------- */

//C     #include "lp_types.h"
import lp_solve.lp_types;
//C     #include "lp_utils.h"
import lp_solve.lp_utils;
//C     #include "lp_matrix.h"
import lp_solve.lp_matrix;


/* SOS constraint defines                                                    */
/* ------------------------------------------------------------------------- */
//C     #define SOS1                     1
//C     #define SOS2                     2
const SOS1 = 1;
//C     #define SOS3                    -1
const SOS2 = 2;
//C     #define SOSn                      MAXINT32
const SOS3 = -1;
//C     #define SOS_START_SIZE          10  /* Start size of SOS_list array; realloced if needed */
alias MAXINT32 SOSn;

const SOS_START_SIZE = 10;
/* Define SOS_is_feasible() return values                                    */
/* ------------------------------------------------------------------------- */
//C     #define SOS3_INCOMPLETE         -2
//C     #define SOS_INCOMPLETE          -1
const SOS3_INCOMPLETE = -2;
//C     #define SOS_COMPLETE             0
const SOS_INCOMPLETE = -1;
//C     #define SOS_INFEASIBLE           1
const SOS_COMPLETE = 0;
//C     #define SOS_INTERNALERROR        2
const SOS_INFEASIBLE = 1;

const SOS_INTERNALERROR = 2;

//C     typedef struct _SOSgroup SOSgroup;
extern (C):
alias _SOSgroup SOSgroup;

//C     typedef struct _SOSrec
//C     {
//C       SOSgroup  *parent;
//C       int       tagorder;
//C       char      *name;
//C       int       type;
//C       MYBOOL    isGUB;
//C       int       size;
//C       int       priority;
//C       int       *members;
//C       REAL      *weights;
//C       int       *membersSorted;
//C       int       *membersMapped;
//C     } SOSrec;
struct _SOSrec
{
    SOSgroup *parent;
    int tagorder;
    char *name;
    int type;
    ubyte isGUB;
    int size;
    int priority;
    int *members;
    double *weights;
    int *membersSorted;
    int *membersMapped;
}
alias _SOSrec SOSrec;

/* typedef */
//C      struct _SOSgroup
//C     {
//C       lprec     *lp;                /* Pointer to owner */
//C       SOSrec    **sos_list;         /* Array of pointers to SOS lists */
//C       int       sos_alloc;          /* Size allocated to specially ordered sets (SOS1, SOS2...) */
//C       int       sos_count;          /* Number of specially ordered sets (SOS1, SOS2...) */
//C       int       maxorder;           /* The highest-order SOS in the group */
//C       int       sos1_count;         /* Number of the lowest order SOS in the group */
//C       int       *membership;        /* Array of variable-sorted indeces to SOSes that the variable is member of */
//C       int       *memberpos;         /* Starting positions of the each column's membership list */
//C     } /* SOSgroup */;
struct _SOSgroup
{
    lprec *lp;
    SOSrec **sos_list;
    int sos_alloc;
    int sos_count;
    int maxorder;
    int sos1_count;
    int *membership;
    int *memberpos;
}


//C     #ifdef __cplusplus
//C     extern "C" {
//C     #endif

/* SOS storage structure */
//C     STATIC SOSgroup *create_SOSgroup(lprec *lp);
SOSgroup * create_SOSgroup(lprec *lp);
//C     STATIC void resize_SOSgroup(SOSgroup *group);
void  resize_SOSgroup(SOSgroup *group);
//C     STATIC int append_SOSgroup(SOSgroup *group, SOSrec *SOS);
int  append_SOSgroup(SOSgroup *group, SOSrec *SOS);
//C     STATIC int clean_SOSgroup(SOSgroup *group, MYBOOL forceupdatemap);
int  clean_SOSgroup(SOSgroup *group, ubyte forceupdatemap);
//C     STATIC void free_SOSgroup(SOSgroup **group);
void  free_SOSgroup(SOSgroup **group);

//C     STATIC SOSrec *create_SOSrec(SOSgroup *group, char *name, int type, int priority, int size, int *variables, REAL *weights);
SOSrec * create_SOSrec(SOSgroup *group, char *name, int type, int priority, int size, int *variables, double *weights);
//C     STATIC MYBOOL delete_SOSrec(SOSgroup *group, int sosindex);
ubyte  delete_SOSrec(SOSgroup *group, int sosindex);
//C     STATIC int append_SOSrec(SOSrec *SOS, int size, int *variables, REAL *weights);
int  append_SOSrec(SOSrec *SOS, int size, int *variables, double *weights);
//C     STATIC void free_SOSrec(SOSrec *SOS);
void  free_SOSrec(SOSrec *SOS);

/* SOS utilities */
//C     STATIC int make_SOSchain(lprec *lp, MYBOOL forceresort);
int  make_SOSchain(lprec *lp, ubyte forceresort);
//C     STATIC int SOS_member_updatemap(SOSgroup *group);
int  SOS_member_updatemap(SOSgroup *group);
//C     STATIC MYBOOL SOS_member_sortlist(SOSgroup *group, int sosindex);
ubyte  SOS_member_sortlist(SOSgroup *group, int sosindex);
//C     STATIC MYBOOL SOS_shift_col(SOSgroup *group, int sosindex, int column, int delta, LLrec *usedmap, MYBOOL forceresort);
ubyte  SOS_shift_col(SOSgroup *group, int sosindex, int column, int delta, LLrec *usedmap, ubyte forceresort);
//C     int SOS_member_delete(SOSgroup *group, int sosindex, int member);
int  SOS_member_delete(SOSgroup *group, int sosindex, int member);
//C     int SOS_get_type(SOSgroup *group, int sosindex);
int  SOS_get_type(SOSgroup *group, int sosindex);
//C     int SOS_infeasible(SOSgroup *group, int sosindex);
int  SOS_infeasible(SOSgroup *group, int sosindex);
//C     int SOS_member_index(SOSgroup *group, int sosindex, int member);
int  SOS_member_index(SOSgroup *group, int sosindex, int member);
//C     int SOS_member_count(SOSgroup *group, int sosindex);
int  SOS_member_count(SOSgroup *group, int sosindex);
//C     int SOS_memberships(SOSgroup *group, int column);
int  SOS_memberships(SOSgroup *group, int column);
//C     int *SOS_get_candidates(SOSgroup *group, int sosindex, int column, MYBOOL excludetarget, REAL *upbound, REAL *lobound);
int * SOS_get_candidates(SOSgroup *group, int sosindex, int column, ubyte excludetarget, double *upbound, double *lobound);
//C     int SOS_is_member(SOSgroup *group, int sosindex, int column);
int  SOS_is_member(SOSgroup *group, int sosindex, int column);
//C     MYBOOL SOS_is_member_of_type(SOSgroup *group, int column, int sostype);
ubyte  SOS_is_member_of_type(SOSgroup *group, int column, int sostype);
//C     MYBOOL SOS_set_GUB(SOSgroup *group, int sosindex, MYBOOL state);
ubyte  SOS_set_GUB(SOSgroup *group, int sosindex, ubyte state);
//C     MYBOOL SOS_is_GUB(SOSgroup *group, int sosindex);
ubyte  SOS_is_GUB(SOSgroup *group, int sosindex);
//C     MYBOOL SOS_is_marked(SOSgroup *group, int sosindex, int column);
ubyte  SOS_is_marked(SOSgroup *group, int sosindex, int column);
//C     MYBOOL SOS_is_active(SOSgroup *group, int sosindex, int column);
ubyte  SOS_is_active(SOSgroup *group, int sosindex, int column);
//C     MYBOOL SOS_is_full(SOSgroup *group, int sosindex, int column, MYBOOL activeonly);
ubyte  SOS_is_full(SOSgroup *group, int sosindex, int column, ubyte activeonly);
//C     MYBOOL SOS_can_activate(SOSgroup *group, int sosindex, int column);
ubyte  SOS_can_activate(SOSgroup *group, int sosindex, int column);
//C     MYBOOL SOS_set_marked(SOSgroup *group, int sosindex, int column, MYBOOL asactive);
ubyte  SOS_set_marked(SOSgroup *group, int sosindex, int column, ubyte asactive);
//C     MYBOOL SOS_unmark(SOSgroup *group, int sosindex, int column);
ubyte  SOS_unmark(SOSgroup *group, int sosindex, int column);
//C     int SOS_fix_unmarked(SOSgroup *group, int sosindex, int variable, REAL *bound, REAL value,
//C                          MYBOOL isupper, int *diffcount, DeltaVrec *changelog);
int  SOS_fix_unmarked(SOSgroup *group, int sosindex, int variable, double *bound, double value, ubyte isupper, int *diffcount, DeltaVrec *changelog);
//C     int SOS_fix_list(SOSgroup *group, int sosindex, int variable, REAL *bound, 
//C                       int *varlist, MYBOOL isleft, DeltaVrec *changelog);
int  SOS_fix_list(SOSgroup *group, int sosindex, int variable, double *bound, int *varlist, ubyte isleft, DeltaVrec *changelog);
//C     int SOS_is_satisfied(SOSgroup *group, int sosindex, REAL *solution);
int  SOS_is_satisfied(SOSgroup *group, int sosindex, double *solution);
//C     MYBOOL SOS_is_feasible(SOSgroup *group, int sosindex, REAL *solution);
ubyte  SOS_is_feasible(SOSgroup *group, int sosindex, double *solution);

//C     #ifdef __cplusplus
//C      }
//C     #endif

//C     #endif /* HEADER_lp_SOS */
