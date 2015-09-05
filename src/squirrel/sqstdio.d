/* Converted to D from sqstdio.h by htod */
module squirrel.sqstdio;
/*	see copyright notice in squirrel.h */
//C     #ifndef _SQSTDIO_H_
//C     #define _SQSTDIO_H_

//C     #ifdef __cplusplus

//C     #define SQSTD_STREAM_TYPE_TAG 0x80000000

//C     struct SQStream {
//C     	virtual SQInteger Read(void *buffer, SQInteger size) = 0;
//C     	virtual SQInteger Write(void *buffer, SQInteger size) = 0;
//C     	virtual SQInteger Flush() = 0;
//C     	virtual SQInteger Tell() = 0;
//C     	virtual SQInteger Len() = 0;
//C     	virtual SQInteger Seek(SQInteger offset, SQInteger origin) = 0;
//C     	virtual bool IsValid() = 0;
//C     	virtual bool EOS() = 0;
//C     };

//C     extern "C" {
//C     #endif
//C     #include "squirrel.h"
import squirrel.squirrel;

//C     #define SQ_SEEK_CUR 0
//C     #define SQ_SEEK_END 1
const SQ_SEEK_CUR = 0;
//C     #define SQ_SEEK_SET 2
const SQ_SEEK_END = 1;

const SQ_SEEK_SET = 2;
//C     typedef void* SQFILE;
extern (C):
alias void *SQFILE;

//C     SQUIRREL_API SQFILE FLUG sqstd_fopen(const SQChar *,const SQChar *);
extern (Windows):
SQFILE  sqstd_fopen(SQChar *, SQChar *);
//C     SQUIRREL_API SQInteger FLUG sqstd_fread(SQUserPointer, SQInteger, SQInteger, SQFILE);
SQInteger  sqstd_fread(SQUserPointer , SQInteger , SQInteger , SQFILE );
//C     SQUIRREL_API SQInteger FLUG sqstd_fwrite(const SQUserPointer, SQInteger, SQInteger, SQFILE);
SQInteger  sqstd_fwrite(SQUserPointer , SQInteger , SQInteger , SQFILE );
//C     SQUIRREL_API SQInteger FLUG sqstd_fseek(SQFILE , SQInteger , SQInteger);
SQInteger  sqstd_fseek(SQFILE , SQInteger , SQInteger );
//C     SQUIRREL_API SQInteger FLUG sqstd_ftell(SQFILE);
SQInteger  sqstd_ftell(SQFILE );
//C     SQUIRREL_API SQInteger FLUG sqstd_fflush(SQFILE);
SQInteger  sqstd_fflush(SQFILE );
//C     SQUIRREL_API SQInteger FLUG sqstd_fclose(SQFILE);
SQInteger  sqstd_fclose(SQFILE );
//C     SQUIRREL_API SQInteger FLUG sqstd_feof(SQFILE);
SQInteger  sqstd_feof(SQFILE );

//C     SQUIRREL_API SQRESULT FLUG sqstd_createfile(HSQUIRRELVM v, SQFILE file,SQBool own);
SQRESULT  sqstd_createfile(HSQUIRRELVM v, SQFILE file, SQBool own);
//C     SQUIRREL_API SQRESULT FLUG sqstd_getfile(HSQUIRRELVM v, SQInteger idx, SQFILE *file);
SQRESULT  sqstd_getfile(HSQUIRRELVM v, SQInteger idx, SQFILE *file);

//compiler helpers
//C     SQUIRREL_API SQRESULT FLUG sqstd_loadfile(HSQUIRRELVM v,const SQChar *filename,SQBool printerror);
SQRESULT  sqstd_loadfile(HSQUIRRELVM v, SQChar *filename, SQBool printerror);
//C     SQUIRREL_API SQRESULT FLUG sqstd_dofile(HSQUIRRELVM v,const SQChar *filename,SQBool retval,SQBool printerror);
SQRESULT  sqstd_dofile(HSQUIRRELVM v, SQChar *filename, SQBool retval, SQBool printerror);
//C     SQUIRREL_API SQRESULT FLUG sqstd_writeclosuretofile(HSQUIRRELVM v,const SQChar *filename);
SQRESULT  sqstd_writeclosuretofile(HSQUIRRELVM v, SQChar *filename);

//C     SQUIRREL_API SQRESULT FLUG sqstd_register_iolib(HSQUIRRELVM v);
SQRESULT  sqstd_register_iolib(HSQUIRRELVM v);

//C     #ifdef __cplusplus
//C     } /*extern "C"*/
//C     #endif

//C     #endif /*_SQSTDIO_H_*/

