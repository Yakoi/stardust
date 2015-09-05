/* Converted to D from sqstdsystem.h by htod */
module squirrel.sqstdsystem;
/*	see copyright notice in squirrel.h */
//C     #include "squirrel.h"
import squirrel.squirrel;
//C     #ifndef _SQSTD_SYSTEMLIB_H_
//C     #define _SQSTD_SYSTEMLIB_H_

//C     #ifdef __cplusplus
//C     extern "C" {
//C     #endif

//C     SQUIRREL_API SQInteger FLUG sqstd_register_systemlib(HSQUIRRELVM v);
extern (Windows):
SQInteger  sqstd_register_systemlib(HSQUIRRELVM v);

//C     #ifdef __cplusplus
//C     } /*extern "C"*/
//C     #endif

//C     #endif /* _SQSTD_SYSTEMLIB_H_ */
