/* Converted to D from sqstdblob.h by htod */
module squirrel.sqstdblob;
/*	see copyright notice in squirrel.h */
//C     #ifndef _SQSTDBLOB_H_
//C     #define _SQSTDBLOB_H_

//C     #ifdef __cplusplus
//C     extern "C" {
//C     #endif
//C     #include "squirrel.h"
import squirrel.squirrel;

//C     SQUIRREL_API SQUserPointer FLUG sqstd_createblob(HSQUIRRELVM v, SQInteger size);
extern (Windows):
SQUserPointer  sqstd_createblob(HSQUIRRELVM v, SQInteger size);
//C     SQUIRREL_API SQRESULT FLUG  sqstd_getblob(HSQUIRRELVM v,SQInteger idx,SQUserPointer *ptr);
SQRESULT  sqstd_getblob(HSQUIRRELVM v, SQInteger idx, SQUserPointer *ptr);
//C     SQUIRREL_API SQInteger FLUG  sqstd_getblobsize(HSQUIRRELVM v,SQInteger idx);
SQInteger  sqstd_getblobsize(HSQUIRRELVM v, SQInteger idx);

//C     SQUIRREL_API SQRESULT FLUG  sqstd_register_bloblib(HSQUIRRELVM v);
SQRESULT  sqstd_register_bloblib(HSQUIRRELVM v);

//C     #ifdef __cplusplus
//C     } /*extern "C"*/
//C     #endif

//C     #endif /*_SQSTDBLOB_H_*/

