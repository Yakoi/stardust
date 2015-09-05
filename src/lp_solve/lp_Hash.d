/* Converted to D from lp_Hash.h by htod */
module lp_solve.lp_Hash;
//C     #ifndef HEADER_lp_hash
//C     #define HEADER_lp_hash

/* For row and column name hash tables */

//C     typedef struct _hashelem
//C     {
//C       char             *name;
//C       int               index;
//C       struct _hashelem *next;
//C       struct _hashelem *nextelem;
//C     } hashelem;
struct _hashelem
{
    char *name;
    int index;
    _hashelem *next;
    _hashelem *nextelem;
}
extern (C):
alias _hashelem hashelem;

//C     typedef struct /* _hashtable */
//C     {
//C       hashelem         **table;
//C       int              size;
//C       int              base;
//C       int              count;
//C       struct _hashelem *first;
//C       struct _hashelem *last;
//C     } hashtable;
struct _N1
{
    hashelem **table;
    int size;
    int base;
    int count;
    _hashelem *first;
    _hashelem *last;
}
alias _N1 hashtable;

//C     #ifdef __cplusplus
//C     extern "C" {
//C     #endif

//C     STATIC hashtable *create_hash_table(int size, int base);
int STATIC;
//C     STATIC void      free_hash_table(hashtable *ht);
//C     STATIC hashelem  *findhash(const char *name, hashtable *ht);
//C     STATIC hashelem  *puthash(const char *name, int index, hashelem **list, hashtable *ht);
//C     STATIC void      drophash(const char *name, hashelem **list, hashtable *ht);
