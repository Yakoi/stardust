/* Converted to D from sqstdstring.h by htod */
module squirrel.sqstdstring;
/*	see copyright notice in squirrel.h */
//C     #include "squirrel.h"
import squirrel.squirrel;
//C     #ifndef _SQSTD_STRING_H_
//C     #define _SQSTD_STRING_H_

//C     #ifdef __cplusplus
//C     extern "C" {
//C     #endif

//C     typedef unsigned int SQRexBool;
extern (C):
alias uint SQRexBool;
//C     typedef struct SQRex SQRex;
struct SQRex;

//C     typedef struct {
//C     	const SQChar *begin;
//C     	SQInteger len;
//C     } SQRexMatch;
struct _N1
{
    SQChar *begin;
    SQInteger len;
}
alias _N1 SQRexMatch;

//C     SQUIRREL_API SQRex * FLUG sqstd_rex_compile(const SQChar *pattern,const SQChar **error);
extern (Windows):
SQRex * sqstd_rex_compile(SQChar *pattern, SQChar **error);
//C     SQUIRREL_API void FLUG sqstd_rex_free(SQRex *exp);
void  sqstd_rex_free(SQRex *exp);
//C     SQUIRREL_API SQBool FLUG sqstd_rex_match(SQRex* exp,const SQChar* text);
SQBool  sqstd_rex_match(SQRex *exp, SQChar *text);
//C     SQUIRREL_API SQBool FLUG sqstd_rex_search(SQRex* exp,const SQChar* text, const SQChar** out_begin, const SQChar** out_end);
SQBool  sqstd_rex_search(SQRex *exp, SQChar *text, SQChar **out_begin, SQChar **out_end);
//C     SQUIRREL_API SQBool FLUG sqstd_rex_searchrange(SQRex* exp,const SQChar* text_begin,const SQChar* text_end,const SQChar** out_begin, const SQChar** out_end);
SQBool  sqstd_rex_searchrange(SQRex *exp, SQChar *text_begin, SQChar *text_end, SQChar **out_begin, SQChar **out_end);
//C     SQUIRREL_API SQInteger FLUG sqstd_rex_getsubexpcount(SQRex* exp);
SQInteger  sqstd_rex_getsubexpcount(SQRex *exp);
//C     SQUIRREL_API SQBool FLUG sqstd_rex_getsubexp(SQRex* exp, SQInteger n, SQRexMatch *subexp);
SQBool  sqstd_rex_getsubexp(SQRex *exp, SQInteger n, SQRexMatch *subexp);

//C     SQUIRREL_API SQRESULT FLUG sqstd_register_stringlib(HSQUIRRELVM v);
SQRESULT  sqstd_register_stringlib(HSQUIRRELVM v);

//C     #ifdef __cplusplus
//C     } /*extern "C"*/
//C     #endif

//C     #endif /*_SQSTD_STRING_H_*/
