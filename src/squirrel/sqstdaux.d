/* Converted to D from sqstdaux.h by htod */
module squirrel.sqstdaux;
/*	see copyright notice in squirrel.h */
//C     #include "squirrel.h"
import squirrel.squirrel;
//C     #ifndef _SQSTD_AUXLIB_H_
//C     #define _SQSTD_AUXLIB_H_

//C     #ifdef __cplusplus
//C     extern "C" {
//C     #endif

//C     SQUIRREL_API void FLUG sqstd_seterrorhandlers(HSQUIRRELVM v);
extern (Windows):
void  sqstd_seterrorhandlers(HSQUIRRELVM v);
//C     SQUIRREL_API void FLUG sqstd_printcallstack(HSQUIRRELVM v);
void  sqstd_printcallstack(HSQUIRRELVM v);

//C     #ifdef __cplusplus
//C     } /*extern "C"*/
//C     #endif

//C     #endif /* _SQSTD_AUXLIB_H_ */
