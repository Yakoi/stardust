/* Converted to D from lp_utils.h by htod */
module lp_solve.lp_utils;
//C     #ifndef HEADER_lp_utils
//C     #define HEADER_lp_utils

//C     #ifdef FORTIFY

//C     #include "lp_fortify.h"

//C     #define allocCHAR allocCHAR_FORTIFY
//C     #define allocMYBOOL allocMYBOOL_FORTIFY
//C     #define allocINT allocINT_FORTIFY
//C     #define allocREAL allocREAL_FORTIFY
//C     #define allocLREAL allocLREAL_FORTIFY

//C     #endif

//C     #include "lp_types.h"
import lp_solve.lp_types;

/* Temporary data storage arrays */
//C     typedef struct _workarraysrec
//C     {
//C       lprec     *lp;
//C       int       size;
//C       int       count;
//C       char      **vectorarray;
//C       int       *vectorsize;
//C     } workarraysrec;
struct _workarraysrec
{
    lprec *lp;
    int size;
    int count;
    char **vectorarray;
    int *vectorsize;
}
extern (C):
alias _workarraysrec workarraysrec;

//C     typedef struct _LLrec
//C     {
//C       int       size;               /* The allocated list size */
//C       int       count;              /* The current entry count */
//C       int       firstitem;
//C       int       lastitem;
//C       int       *map;               /* The list of forward and backward-mapped entries */
//C     } LLrec;
struct _LLrec
{
    int size;
    int count;
    int firstitem;
    int lastitem;
    int *map;
}
alias _LLrec LLrec;

//C     typedef struct _PVrec
//C     {
//C       int       count;              /* The allocated list item count */
//C       int       *startpos;          /* Starting index of the current value */
//C       REAL      *value;             /* The list of forward and backward-mapped entries */
//C       struct   _PVrec *parent;     /* The parent record in a pushed chain */
//C     } PVrec;
struct _PVrec
{
    int count;
    int *startpos;
    double *value;
    _PVrec *parent;
}
alias _PVrec PVrec;


//C     #ifdef __cplusplus
//C     extern "C" {
//C     #endif

/* Put function headers here */
//C     STATIC MYBOOL allocCHAR(lprec *lp, char **ptr, int size, MYBOOL clear);
ubyte  allocCHAR(lprec *lp, char **ptr, int size, ubyte clear);
//C     STATIC MYBOOL allocMYBOOL(lprec *lp, MYBOOL **ptr, int size, MYBOOL clear);
ubyte  allocMYBOOL(lprec *lp, ubyte **ptr, int size, ubyte clear);
//C     STATIC MYBOOL allocINT(lprec *lp, int **ptr, int size, MYBOOL clear);
ubyte  allocINT(lprec *lp, int **ptr, int size, ubyte clear);
//C     STATIC MYBOOL allocREAL(lprec *lp, REAL **ptr, int size, MYBOOL clear);
ubyte  allocREAL(lprec *lp, double **ptr, int size, ubyte clear);
//C     STATIC MYBOOL allocLREAL(lprec *lp, LREAL **ptr, int size, MYBOOL clear);
ubyte  allocLREAL(lprec *lp, double **ptr, int size, ubyte clear);
//C     STATIC MYBOOL allocFREE(lprec *lp, void **ptr);
ubyte  allocFREE(lprec *lp, void **ptr);
//C     REAL *cloneREAL(lprec *lp, REAL *origlist, int size);
double * cloneREAL(lprec *lp, double *origlist, int size);
//C     MYBOOL *cloneMYBOOL(lprec *lp, MYBOOL *origlist, int size);
ubyte * cloneMYBOOL(lprec *lp, ubyte *origlist, int size);
//C     int *cloneINT(lprec *lp, int *origlist, int size);
int * cloneINT(lprec *lp, int *origlist, int size);

//C     int comp_bits(MYBOOL *bitarray1, MYBOOL *bitarray2, int items);
int  comp_bits(ubyte *bitarray1, ubyte *bitarray2, int items);

//C     STATIC workarraysrec *mempool_create(lprec *lp);
workarraysrec * mempool_create(lprec *lp);
//C     STATIC char *mempool_obtainVector(workarraysrec *mempool, int count, int unitsize);
char * mempool_obtainVector(workarraysrec *mempool, int count, int unitsize);
//C     STATIC MYBOOL mempool_releaseVector(workarraysrec *mempool, char *memvector, MYBOOL forcefree);
ubyte  mempool_releaseVector(workarraysrec *mempool, char *memvector, ubyte forcefree);
//C     STATIC MYBOOL mempool_free(workarraysrec **mempool);
ubyte  mempool_free(workarraysrec **mempool);

//C     STATIC void roundVector(LREAL *myvector, int endpos, LREAL roundzero);
void  roundVector(double *myvector, int endpos, double roundzero);
//C     STATIC REAL normalizeVector(REAL *myvector, int endpos);
double  normalizeVector(double *myvector, int endpos);

//C     STATIC void swapINT(int *item1, int *item2);
void  swapINT(int *item1, int *item2);
//C     STATIC void swapREAL(REAL *item1, REAL *item2);
void  swapREAL(double *item1, double *item2);
//C     STATIC void swapPTR(void **item1, void **item2);
void  swapPTR(void **item1, void **item2);
//C     STATIC REAL restoreINT(REAL valREAL, REAL epsilon);
double  restoreINT(double valREAL, double epsilon);
//C     STATIC REAL roundToPrecision(REAL value, REAL precision);
double  roundToPrecision(double value, double precision);

//C     STATIC int searchFor(int target, int *attributes, int size, int offset, MYBOOL absolute);
int  searchFor(int target, int *attributes, int size, int offset, ubyte absolute);

//C     STATIC MYBOOL isINT(lprec *lp, REAL value);
ubyte  isINT(lprec *lp, double value);
//C     STATIC MYBOOL isOrigFixed(lprec *lp, int varno);
ubyte  isOrigFixed(lprec *lp, int varno);
//C     STATIC void chsign_bounds(REAL *lobound, REAL *upbound);
void  chsign_bounds(double *lobound, double *upbound);
//C     STATIC REAL rand_uniform(lprec *lp, REAL range);
double  rand_uniform(lprec *lp, double range);

/* Doubly linked list routines */
//C     STATIC int createLink(int size, LLrec **linkmap, MYBOOL *usedpos);
int  createLink(int size, LLrec **linkmap, ubyte *usedpos);
//C     STATIC MYBOOL freeLink(LLrec **linkmap);
ubyte  freeLink(LLrec **linkmap);
//C     STATIC int sizeLink(LLrec *linkmap);
int  sizeLink(LLrec *linkmap);
//C     STATIC MYBOOL isActiveLink(LLrec *linkmap, int itemnr);
ubyte  isActiveLink(LLrec *linkmap, int itemnr);
//C     STATIC int countActiveLink(LLrec *linkmap);
int  countActiveLink(LLrec *linkmap);
//C     STATIC int countInactiveLink(LLrec *linkmap);
int  countInactiveLink(LLrec *linkmap);
//C     STATIC int firstActiveLink(LLrec *linkmap);
int  firstActiveLink(LLrec *linkmap);
//C     STATIC int lastActiveLink(LLrec *linkmap);
int  lastActiveLink(LLrec *linkmap);
//C     STATIC MYBOOL appendLink(LLrec *linkmap, int newitem);
ubyte  appendLink(LLrec *linkmap, int newitem);
//C     STATIC MYBOOL insertLink(LLrec *linkmap, int afteritem, int newitem);
ubyte  insertLink(LLrec *linkmap, int afteritem, int newitem);
//C     STATIC MYBOOL setLink(LLrec *linkmap, int newitem);
ubyte  setLink(LLrec *linkmap, int newitem);
//C     STATIC MYBOOL fillLink(LLrec *linkmap);
ubyte  fillLink(LLrec *linkmap);
//C     STATIC int nextActiveLink(LLrec *linkmap, int backitemnr);
int  nextActiveLink(LLrec *linkmap, int backitemnr);
//C     STATIC int prevActiveLink(LLrec *linkmap, int forwitemnr);
int  prevActiveLink(LLrec *linkmap, int forwitemnr);
//C     STATIC int firstInactiveLink(LLrec *linkmap);
int  firstInactiveLink(LLrec *linkmap);
//C     STATIC int lastInactiveLink(LLrec *linkmap);
int  lastInactiveLink(LLrec *linkmap);
//C     STATIC int nextInactiveLink(LLrec *linkmap, int backitemnr);
int  nextInactiveLink(LLrec *linkmap, int backitemnr);
//C     STATIC int prevInactiveLink(LLrec *linkmap, int forwitemnr);
int  prevInactiveLink(LLrec *linkmap, int forwitemnr);
//C     STATIC int removeLink(LLrec *linkmap, int itemnr);
int  removeLink(LLrec *linkmap, int itemnr);
//C     STATIC LLrec *cloneLink(LLrec *sourcemap, int newsize, MYBOOL freesource);
LLrec * cloneLink(LLrec *sourcemap, int newsize, ubyte freesource);
//C     STATIC int compareLink(LLrec *linkmap1, LLrec *linkmap2);
int  compareLink(LLrec *linkmap1, LLrec *linkmap2);
//C     STATIC MYBOOL verifyLink(LLrec *linkmap, int itemnr, MYBOOL doappend);
ubyte  verifyLink(LLrec *linkmap, int itemnr, ubyte doappend);

/* Packed vector routines */
//C     STATIC PVrec  *createPackedVector(int size, REAL *values, int *workvector);
PVrec * createPackedVector(int size, double *values, int *workvector);
//C     STATIC void   pushPackedVector(PVrec *PV, PVrec *parent);
void  pushPackedVector(PVrec *PV, PVrec *parent);
//C     STATIC MYBOOL unpackPackedVector(PVrec *PV, REAL **target);
ubyte  unpackPackedVector(PVrec *PV, double **target);
//C     STATIC REAL   getvaluePackedVector(PVrec *PV, int index);
double  getvaluePackedVector(PVrec *PV, int index);
//C     STATIC PVrec  *popPackedVector(PVrec *PV);
PVrec * popPackedVector(PVrec *PV);
//C     STATIC MYBOOL freePackedVector(PVrec **PV);
ubyte  freePackedVector(PVrec **PV);

//C     #ifdef __cplusplus
//C      }
//C     #endif

//C     #endif /* HEADER_lp_utils */

//C     #ifdef FORTIFY

//C     #if defined CODE_lp_utils && !defined CODE_lp_utils_
//C     int _Fortify_ret;
//C     #else
//C     extern int _Fortify_ret;
//C     #endif

//C     #ifdef CODE_lp_utils
//C     #define CODE_lp_utils_
//C     #else
//C     # undef allocCHAR
//C     # undef allocMYBOOL
//C     # undef allocINT
//C     # undef allocREAL
//C     # undef allocLREAL
//C     # define allocCHAR(lp, ptr, size, clear) (Fortify_LINE(__LINE__), Fortify_FILE(__FILE__), _Fortify_ret = allocCHAR_FORTIFY(lp, ptr, size, clear), Fortify_LINE(0), Fortify_FILE(NULL), _Fortify_ret)
//C     # define allocMYBOOL(lp, ptr, size, clear) (Fortify_LINE(__LINE__), Fortify_FILE(__FILE__), _Fortify_ret = allocMYBOOL_FORTIFY(lp, ptr, size, clear), Fortify_LINE(0), Fortify_FILE(NULL), _Fortify_ret)
//C     # define allocINT(lp, ptr, size, clear) (Fortify_LINE(__LINE__), Fortify_FILE(__FILE__), _Fortify_ret = allocINT_FORTIFY(lp, ptr, size, clear), Fortify_LINE(0), Fortify_FILE(NULL), _Fortify_ret)
//C     # define allocREAL(lp, ptr, size, clear) (Fortify_LINE(__LINE__), Fortify_FILE(__FILE__), _Fortify_ret = allocREAL_FORTIFY(lp, ptr, size, clear), Fortify_LINE(0), Fortify_FILE(NULL), _Fortify_ret)
//C     # define allocLREAL(lp, ptr, size, clear) (Fortify_LINE(__LINE__), Fortify_FILE(__FILE__), _Fortify_ret = allocLREAL_FORTIFY(lp, ptr, size, clear), Fortify_LINE(0), Fortify_FILE(NULL), _Fortify_ret)
//C     #endif

//C     #endif

