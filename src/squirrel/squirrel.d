/* Converted to D from squirrel.h by htod */
module squirrel.squirrel;
/*
Copyright (c) 2003-2008 Alberto Demichelis

This software is provided 'as-is', without any 
express or implied warranty. In no event will the 
authors be held liable for any damages arising from 
the use of this software.

Permission is granted to anyone to use this software 
for any purpose, including commercial applications, 
and to alter it and redistribute it freely, subject 
to the following restrictions:

		1. The origin of this software must not be 
		misrepresented; you must not claim that 
		you wrote the original software. If you 
		use this software in a product, an 
		acknowledgment in the product 
		documentation would be appreciated but is 
		not required.

		2. Altered source versions must be plainly 
		marked as such, and must not be 
		misrepresented as being the original 
		software.

		3. This notice may not be removed or 
		altered from any source distribution.

*/
//C     #ifndef _SQUIRREL_H_
//C     #define _SQUIRREL_H_

//C     #ifdef __cplusplus
//C     extern "C" {
//C     #endif

//C     #ifndef SQUIRREL_API
//C     #define SQUIRREL_API  __declspec(dllexport) 
//C     #endif

//C     #ifndef FLUG
//C     #define FLUG __stdcall
//C     #endif

//C     #if (defined(_WIN64) || defined(_LP64))
//C     #define _SQ64
//C     #endif

//C     #ifdef _SQ64
//C     #ifdef _MSC_VER
//C     typedef __int64 SQInteger;
//C     typedef unsigned __int64 SQUnsignedInteger;
//C     typedef unsigned __int64 SQHash; /*should be the same size of a pointer*/
//C     #else
//C     typedef long SQInteger;
//C     typedef unsigned long SQUnsignedInteger;
//C     typedef unsigned long SQHash; /*should be the same size of a pointer*/
//C     #endif
//C     typedef int SQInt32; 
//C     #else 
//C     typedef int SQInteger;
extern (C):
alias int SQInteger;
//C     typedef int SQInt32; /*must be 32 bits(also on 64bits processors)*/
alias int SQInt32;
//C     typedef unsigned int SQUnsignedInteger;
alias uint SQUnsignedInteger;
//C     typedef unsigned int SQHash; /*should be the same size of a pointer*/
alias uint SQHash;
//C     #endif


//C     typedef float SQFloat;
alias float SQFloat;
//C     typedef void* SQUserPointer;
alias void *SQUserPointer;
//C     typedef SQUnsignedInteger SQBool;
alias SQUnsignedInteger SQBool;
//C     typedef SQInteger SQRESULT;
alias SQInteger SQRESULT;

//C     #define SQTrue	(1)
//C     #define SQFalse	(0)
const uint SQTrue =(1);
const uint SQFalse=(0);

     struct SQVM;
     struct SQTable;
     struct SQArray;
     struct SQString;
     struct SQClosure;
     struct SQGenerator;
     struct SQNativeClosure;
     struct SQUserData;
     struct SQFunctionProto;
     struct SQRefCounted;
     struct SQClass;
     struct SQInstance;
     struct SQDelegable;
     struct SQWeakRef;

//C     #ifdef _UNICODE
//C     #define SQUNICODE
//C     #endif

//C     #ifdef SQUNICODE
//C     #if (defined(_MSC_VER) && _MSC_VER >= 1400) // 1400 = VS8

//C     #if defined(wchar_t) //this is if the compiler considers wchar_t as native type
//C     #define wchar_t unsigned short
//C     #endif

//C     #else
//C     typedef unsigned short wchar_t;
//C     #endif

//C     typedef wchar_t SQChar;
//C     #define _SC(a) L##a
//C     #define	scstrcmp	wcscmp
//C     #define scsprintf	swprintf
//C     #define scstrlen	wcslen
//C     #define scstrtod	wcstod
//C     #define scstrtol	wcstol
//C     #define scatoi		_wtoi
//C     #define scstrtoul	wcstoul
//C     #define scvsprintf	vswprintf
//C     #define scstrstr	wcsstr
//C     #define scisspace	iswspace
//C     #define scisdigit	iswdigit
//C     #define scisxdigit	iswxdigit
//C     #define scisalpha	iswalpha
//C     #define sciscntrl	iswcntrl
//C     #define scisalnum	iswalnum
//C     #define scprintf	wprintf
//C     #define MAX_CHAR 0xFFFF
//C     #else
//C     typedef char SQChar;
alias char SQChar;
//C     #define _SC(a) a
T _SC(T)(T a){return a;}
//C     #define	scstrcmp	strcmp
//C     #define scsprintf	sprintf
//C     #endif
const MAX_CHAR = 0xFF;

//C     #define SQUIRREL_VERSION	_SC("Squirrel 2.2.2 stable")
const char* SQUIRREL_VERSION = _SC("Squirrel 2.2.2 stable");
//C     #define SQUIRREL_COPYRIGHT	_SC("Copyright (C) 2003-2008 Alberto Demichelis")
const char* SQUIRREL_COPYRIGHT = _SC("Copyright (C) 2003-2008 Alberto Demichelis");
//C     #define SQUIRREL_AUTHOR		_SC("Alberto Demichelis")

//C     #define SQ_VMSTATE_IDLE			0
//C     #define SQ_VMSTATE_RUNNING		1
const SQ_VMSTATE_IDLE = 0;
//C     #define SQ_VMSTATE_SUSPENDED	2
const SQ_VMSTATE_RUNNING = 1;

const SQ_VMSTATE_SUSPENDED = 2;
//C     #define SQUIRREL_EOB 0
//C     #define SQ_BYTECODE_STREAM_TAG	0xFAFA
const SQUIRREL_EOB = 0;

const SQ_BYTECODE_STREAM_TAG = 0xFAFA;
//C     #define SQOBJECT_REF_COUNTED	0x08000000
//C     #define SQOBJECT_NUMERIC		0x04000000
const SQOBJECT_REF_COUNTED = 0x08000000;
//C     #define SQOBJECT_DELEGABLE		0x02000000
const SQOBJECT_NUMERIC = 0x04000000;
//C     #define SQOBJECT_CANBEFALSE		0x01000000
const SQOBJECT_DELEGABLE = 0x02000000;

const SQOBJECT_CANBEFALSE = 0x01000000;
//C     #define SQ_MATCHTYPEMASKSTRING (-99999)

//C     #define _RT_MASK 0x00FFFFFF
//C     #define _RAW_TYPE(type) (type&_RT_MASK)
const _RT_MASK = 0x00FFFFFF;

//C     #define _RT_NULL			0x00000001
//C     #define _RT_INTEGER			0x00000002
const _RT_NULL = 0x00000001;
//C     #define _RT_FLOAT			0x00000004
const _RT_INTEGER = 0x00000002;
//C     #define _RT_BOOL			0x00000008
const _RT_FLOAT = 0x00000004;
//C     #define _RT_STRING			0x00000010
const _RT_BOOL = 0x00000008;
//C     #define _RT_TABLE			0x00000020
const _RT_STRING = 0x00000010;
//C     #define _RT_ARRAY			0x00000040
const _RT_TABLE = 0x00000020;
//C     #define _RT_USERDATA		0x00000080
const _RT_ARRAY = 0x00000040;
//C     #define _RT_CLOSURE			0x00000100
const _RT_USERDATA = 0x00000080;
//C     #define _RT_NATIVECLOSURE	0x00000200
const _RT_CLOSURE = 0x00000100;
//C     #define _RT_GENERATOR		0x00000400
const _RT_NATIVECLOSURE = 0x00000200;
//C     #define _RT_USERPOINTER		0x00000800
const _RT_GENERATOR = 0x00000400;
//C     #define _RT_THREAD			0x00001000
const _RT_USERPOINTER = 0x00000800;
//C     #define _RT_FUNCPROTO		0x00002000
const _RT_THREAD = 0x00001000;
//C     #define _RT_CLASS			0x00004000
const _RT_FUNCPROTO = 0x00002000;
//C     #define _RT_INSTANCE		0x00008000
const _RT_CLASS = 0x00004000;
//C     #define _RT_WEAKREF			0x00010000
const _RT_INSTANCE = 0x00008000;

const _RT_WEAKREF = 0x00010000;
//C     typedef enum tagSQObjectType{
//C     	OT_NULL =			(_RT_NULL|SQOBJECT_CANBEFALSE),
//C     	OT_INTEGER =		(_RT_INTEGER|SQOBJECT_NUMERIC|SQOBJECT_CANBEFALSE),
//C     	OT_FLOAT =			(_RT_FLOAT|SQOBJECT_NUMERIC|SQOBJECT_CANBEFALSE),
//C     	OT_BOOL =			(_RT_BOOL|SQOBJECT_CANBEFALSE),
//C     	OT_STRING =			(_RT_STRING|SQOBJECT_REF_COUNTED),
//C     	OT_TABLE =			(_RT_TABLE|SQOBJECT_REF_COUNTED|SQOBJECT_DELEGABLE),
//C     	OT_ARRAY =			(_RT_ARRAY|SQOBJECT_REF_COUNTED),
//C     	OT_USERDATA =		(_RT_USERDATA|SQOBJECT_REF_COUNTED|SQOBJECT_DELEGABLE),
//C     	OT_CLOSURE =		(_RT_CLOSURE|SQOBJECT_REF_COUNTED),
//C     	OT_NATIVECLOSURE =	(_RT_NATIVECLOSURE|SQOBJECT_REF_COUNTED),
//C     	OT_GENERATOR =		(_RT_GENERATOR|SQOBJECT_REF_COUNTED),
//C     	OT_USERPOINTER =	_RT_USERPOINTER,
//C     	OT_THREAD =			(_RT_THREAD|SQOBJECT_REF_COUNTED) ,
//C     	OT_FUNCPROTO =		(_RT_FUNCPROTO|SQOBJECT_REF_COUNTED), //internal usage only
//C     	OT_CLASS =			(_RT_CLASS|SQOBJECT_REF_COUNTED),
//C     	OT_INSTANCE =		(_RT_INSTANCE|SQOBJECT_REF_COUNTED|SQOBJECT_DELEGABLE),
//C     	OT_WEAKREF =		(_RT_WEAKREF|SQOBJECT_REF_COUNTED)
//C     }SQObjectType;
enum tagSQObjectType
{
    OT_NULL = 16777217,
    OT_INTEGER = 83886082,
    OT_FLOAT = 83886084,
    OT_BOOL = 16777224,
    OT_STRING = 134217744,
    OT_TABLE = 167772192,
    OT_ARRAY = 134217792,
    OT_USERDATA = 167772288,
    OT_CLOSURE = 134217984,
    OT_NATIVECLOSURE = 134218240,
    OT_GENERATOR = 134218752,
    OT_USERPOINTER = 2048,
    OT_THREAD = 134221824,
    OT_FUNCPROTO = 134225920,
    OT_CLASS = 134234112,
    OT_INSTANCE = 167804928,
    OT_WEAKREF = 134283264,
}
alias tagSQObjectType SQObjectType;

//C     #define ISREFCOUNTED(t) (t&SQOBJECT_REF_COUNTED)


//C     typedef union tagSQObjectValue
//C     {
//C     	struct SQTable *pTable;
//C     	struct SQArray *pArray;
//C     	struct SQClosure *pClosure;
//C     	struct SQGenerator *pGenerator;
//C     	struct SQNativeClosure *pNativeClosure;
//C     	struct SQString *pString;
//C     	struct SQUserData *pUserData;
//C     	SQInteger nInteger;
//C     	SQFloat fFloat;
//C     	SQUserPointer pUserPointer;
//C     	struct SQFunctionProto *pFunctionProto;
//C     	struct SQRefCounted *pRefCounted;
//C     	struct SQDelegable *pDelegable;
//C     	struct SQVM *pThread;
//C     	struct SQClass *pClass;
//C     	struct SQInstance *pInstance;
//C     	struct SQWeakRef *pWeakRef;
//C     }SQObjectValue;
union tagSQObjectValue
{
    SQTable *pTable;
    SQArray *pArray;
    SQClosure *pClosure;
    SQGenerator *pGenerator;
    SQNativeClosure *pNativeClosure;
    SQString *pString;
    SQUserData *pUserData;
    SQInteger nInteger;
    SQFloat fFloat;
    SQUserPointer pUserPointer;
    SQFunctionProto *pFunctionProto;
    SQRefCounted *pRefCounted;
    SQDelegable *pDelegable;
    SQVM *pThread;
    SQClass *pClass;
    SQInstance *pInstance;
    SQWeakRef *pWeakRef;
}
alias tagSQObjectValue SQObjectValue;


//C     typedef struct tagSQObject
//C     {
//C     	SQObjectType _type;
//C     	SQObjectValue _unVal;
//C     }SQObject;
struct tagSQObject
{
    SQObjectType _type;
    SQObjectValue _unVal;
}
alias tagSQObject SQObject;

//C     typedef struct tagSQStackInfos{
//C     	const SQChar* funcname;
//C     	const SQChar* source;
//C     	SQInteger line;
//C     }SQStackInfos;
struct tagSQStackInfos
{
    SQChar *funcname;
    SQChar *source;
    SQInteger line;
}
alias tagSQStackInfos SQStackInfos;

//C     typedef struct SQVM* HSQUIRRELVM;
alias SQVM *HSQUIRRELVM;
//C     typedef SQObject HSQOBJECT;
alias SQObject HSQOBJECT;
//C     typedef SQInteger (*SQFUNCTION)(HSQUIRRELVM);
alias SQInteger  function(HSQUIRRELVM )SQFUNCTION;
//C     typedef SQInteger (*SQRELEASEHOOK)(SQUserPointer,SQInteger size);
alias SQInteger  function(SQUserPointer , SQInteger size)SQRELEASEHOOK;
//C     typedef void (*SQCOMPILERERROR)(HSQUIRRELVM,const SQChar * /*desc*/,const SQChar * /*source*/,SQInteger /*line*/,SQInteger /*column*/);
alias void  function(HSQUIRRELVM , SQChar *, SQChar *, SQInteger , SQInteger )SQCOMPILERERROR;
//C     typedef void (*SQPRINTFUNCTION)(HSQUIRRELVM,const SQChar * ,...);
alias void  function(HSQUIRRELVM , SQChar *,...)SQPRINTFUNCTION;

//C     typedef SQInteger (*SQWRITEFUNC)(SQUserPointer,SQUserPointer,SQInteger);
alias SQInteger  function(SQUserPointer , SQUserPointer , SQInteger )SQWRITEFUNC;
//C     typedef SQInteger (*SQREADFUNC)(SQUserPointer,SQUserPointer,SQInteger);
alias SQInteger  function(SQUserPointer , SQUserPointer , SQInteger )SQREADFUNC;

//C     typedef SQInteger (*SQLEXREADFUNC)(SQUserPointer);
alias SQInteger  function(SQUserPointer )SQLEXREADFUNC;

//C     typedef struct tagSQRegFunction{
//C     	const SQChar *name;
//C     	SQFUNCTION f;
//C     	SQInteger nparamscheck;
//C     	const SQChar *typemask;
//C     }SQRegFunction;
struct tagSQRegFunction
{
    SQChar *name;
    SQFUNCTION f;
    SQInteger nparamscheck;
    SQChar *typemask;
}
alias tagSQRegFunction SQRegFunction;

/*vm*/
//C     SQUIRREL_API HSQUIRRELVM FLUG sq_open(SQInteger initialstacksize);
extern (Windows):
HSQUIRRELVM  sq_open(SQInteger initialstacksize);
//C     SQUIRREL_API HSQUIRRELVM FLUG sq_newthread(HSQUIRRELVM friendvm, SQInteger initialstacksize);
HSQUIRRELVM  sq_newthread(HSQUIRRELVM friendvm, SQInteger initialstacksize);
//C     SQUIRREL_API void FLUG sq_seterrorhandler(HSQUIRRELVM v);
void  sq_seterrorhandler(HSQUIRRELVM v);
//C     SQUIRREL_API void FLUG sq_close(HSQUIRRELVM v);
void  sq_close(HSQUIRRELVM v);
//C     SQUIRREL_API void FLUG sq_setforeignptr(HSQUIRRELVM v,SQUserPointer p);
void  sq_setforeignptr(HSQUIRRELVM v, SQUserPointer p);
//C     SQUIRREL_API SQUserPointer FLUG sq_getforeignptr(HSQUIRRELVM v);
SQUserPointer  sq_getforeignptr(HSQUIRRELVM v);
//C     SQUIRREL_API void FLUG sq_setprintfunc(HSQUIRRELVM v, SQPRINTFUNCTION printfunc);
void  sq_setprintfunc(HSQUIRRELVM v, SQPRINTFUNCTION printfunc);
//C     SQUIRREL_API SQPRINTFUNCTION FLUG sq_getprintfunc(HSQUIRRELVM v);
SQPRINTFUNCTION  sq_getprintfunc(HSQUIRRELVM v);
//C     SQUIRREL_API SQRESULT FLUG sq_suspendvm(HSQUIRRELVM v);
SQRESULT  sq_suspendvm(HSQUIRRELVM v);
//C     SQUIRREL_API SQRESULT FLUG sq_wakeupvm(HSQUIRRELVM v,SQBool resumedret,SQBool retval,SQBool raiseerror);
SQRESULT  sq_wakeupvm(HSQUIRRELVM v, SQBool resumedret, SQBool retval, SQBool raiseerror);
//C     SQUIRREL_API SQInteger FLUG sq_getvmstate(HSQUIRRELVM v);
SQInteger  sq_getvmstate(HSQUIRRELVM v);

/*compiler*/
//C     SQUIRREL_API SQRESULT FLUG sq_compile(HSQUIRRELVM v,SQLEXREADFUNC read,SQUserPointer p,const SQChar *sourcename,SQBool raiseerror);
SQRESULT  sq_compile(HSQUIRRELVM v, SQLEXREADFUNC read, SQUserPointer p, SQChar *sourcename, SQBool raiseerror);
//C     SQUIRREL_API SQRESULT FLUG sq_compilebuffer(HSQUIRRELVM v,const SQChar *s,SQInteger size,const SQChar *sourcename,SQBool raiseerror);
SQRESULT  sq_compilebuffer(HSQUIRRELVM v, SQChar *s, SQInteger size, SQChar *sourcename, SQBool raiseerror);
//C     SQUIRREL_API void FLUG sq_enabledebuginfo(HSQUIRRELVM v, SQBool enable);
void  sq_enabledebuginfo(HSQUIRRELVM v, SQBool enable);
//C     SQUIRREL_API void FLUG sq_notifyallexceptions(HSQUIRRELVM v, SQBool enable);
void  sq_notifyallexceptions(HSQUIRRELVM v, SQBool enable);
//C     SQUIRREL_API void FLUG sq_setcompilererrorhandler(HSQUIRRELVM v,SQCOMPILERERROR f);
void  sq_setcompilererrorhandler(HSQUIRRELVM v, SQCOMPILERERROR f);

/*stack operations*/
//C     SQUIRREL_API void FLUG sq_push(HSQUIRRELVM v,SQInteger idx);
void  sq_push(HSQUIRRELVM v, SQInteger idx);
//C     SQUIRREL_API void FLUG sq_pop(HSQUIRRELVM v,SQInteger nelemstopop);
void  sq_pop(HSQUIRRELVM v, SQInteger nelemstopop);
//C     SQUIRREL_API void FLUG sq_poptop(HSQUIRRELVM v);
void  sq_poptop(HSQUIRRELVM v);
//C     SQUIRREL_API void FLUG sq_remove(HSQUIRRELVM v,SQInteger idx);
void  sq_remove(HSQUIRRELVM v, SQInteger idx);
//C     SQUIRREL_API SQInteger FLUG sq_gettop(HSQUIRRELVM v);
SQInteger  sq_gettop(HSQUIRRELVM v);
//C     SQUIRREL_API void FLUG sq_settop(HSQUIRRELVM v,SQInteger newtop);
void  sq_settop(HSQUIRRELVM v, SQInteger newtop);
//C     SQUIRREL_API void FLUG sq_reservestack(HSQUIRRELVM v,SQInteger nsize);
void  sq_reservestack(HSQUIRRELVM v, SQInteger nsize);
//C     SQUIRREL_API SQInteger FLUG sq_cmp(HSQUIRRELVM v);
SQInteger  sq_cmp(HSQUIRRELVM v);
//C     SQUIRREL_API void FLUG sq_move(HSQUIRRELVM dest,HSQUIRRELVM src,SQInteger idx);
void  sq_move(HSQUIRRELVM dest, HSQUIRRELVM src, SQInteger idx);

/*object creation handling*/
//C     SQUIRREL_API SQUserPointer FLUG sq_newuserdata(HSQUIRRELVM v,SQUnsignedInteger size);
SQUserPointer  sq_newuserdata(HSQUIRRELVM v, SQUnsignedInteger size);
//C     SQUIRREL_API void FLUG sq_newtable(HSQUIRRELVM v);
void  sq_newtable(HSQUIRRELVM v);
//C     SQUIRREL_API void FLUG sq_newarray(HSQUIRRELVM v,SQInteger size);
void  sq_newarray(HSQUIRRELVM v, SQInteger size);
//C     SQUIRREL_API void FLUG sq_newclosure(HSQUIRRELVM v,SQFUNCTION func,SQUnsignedInteger nfreevars);
void  sq_newclosure(HSQUIRRELVM v, SQFUNCTION func, SQUnsignedInteger nfreevars);
//C     SQUIRREL_API SQRESULT FLUG sq_setparamscheck(HSQUIRRELVM v,SQInteger nparamscheck,const SQChar *typemask);
SQRESULT  sq_setparamscheck(HSQUIRRELVM v, SQInteger nparamscheck, SQChar *typemask);
//C     SQUIRREL_API SQRESULT FLUG sq_bindenv(HSQUIRRELVM v,SQInteger idx);
SQRESULT  sq_bindenv(HSQUIRRELVM v, SQInteger idx);
//C     SQUIRREL_API void FLUG sq_pushstring(HSQUIRRELVM v,const SQChar *s,SQInteger len);
void  sq_pushstring(HSQUIRRELVM v, SQChar *s, SQInteger len);
//C     SQUIRREL_API void FLUG sq_pushfloat(HSQUIRRELVM v,SQFloat f);
void  sq_pushfloat(HSQUIRRELVM v, SQFloat f);
//C     SQUIRREL_API void FLUG sq_pushinteger(HSQUIRRELVM v,SQInteger n);
void  sq_pushinteger(HSQUIRRELVM v, SQInteger n);
//C     SQUIRREL_API void FLUG sq_pushbool(HSQUIRRELVM v,SQBool b);
void  sq_pushbool(HSQUIRRELVM v, SQBool b);
//C     SQUIRREL_API void FLUG sq_pushuserpointer(HSQUIRRELVM v,SQUserPointer p);
void  sq_pushuserpointer(HSQUIRRELVM v, SQUserPointer p);
//C     SQUIRREL_API void FLUG sq_pushnull(HSQUIRRELVM v);
void  sq_pushnull(HSQUIRRELVM v);
//C     SQUIRREL_API SQObjectType FLUG sq_gettype(HSQUIRRELVM v,SQInteger idx);
SQObjectType  sq_gettype(HSQUIRRELVM v, SQInteger idx);
//C     SQUIRREL_API SQInteger FLUG sq_getsize(HSQUIRRELVM v,SQInteger idx);
SQInteger  sq_getsize(HSQUIRRELVM v, SQInteger idx);
//C     SQUIRREL_API SQRESULT FLUG sq_getbase(HSQUIRRELVM v,SQInteger idx);
SQRESULT  sq_getbase(HSQUIRRELVM v, SQInteger idx);
//C     SQUIRREL_API SQBool FLUG sq_instanceof(HSQUIRRELVM v);
SQBool  sq_instanceof(HSQUIRRELVM v);
//C     SQUIRREL_API void FLUG sq_tostring(HSQUIRRELVM v,SQInteger idx);
void  sq_tostring(HSQUIRRELVM v, SQInteger idx);
//C     SQUIRREL_API void FLUG sq_tobool(HSQUIRRELVM v, SQInteger idx, SQBool *b);
void  sq_tobool(HSQUIRRELVM v, SQInteger idx, SQBool *b);
//C     SQUIRREL_API SQRESULT FLUG sq_getstring(HSQUIRRELVM v,SQInteger idx,const SQChar **c);
SQRESULT  sq_getstring(HSQUIRRELVM v, SQInteger idx, SQChar **c);
//C     SQUIRREL_API SQRESULT FLUG sq_getinteger(HSQUIRRELVM v,SQInteger idx,SQInteger *i);
SQRESULT  sq_getinteger(HSQUIRRELVM v, SQInteger idx, SQInteger *i);
//C     SQUIRREL_API SQRESULT FLUG sq_getfloat(HSQUIRRELVM v,SQInteger idx,SQFloat *f);
SQRESULT  sq_getfloat(HSQUIRRELVM v, SQInteger idx, SQFloat *f);
//C     SQUIRREL_API SQRESULT FLUG sq_getbool(HSQUIRRELVM v,SQInteger idx,SQBool *b);
SQRESULT  sq_getbool(HSQUIRRELVM v, SQInteger idx, SQBool *b);
//C     SQUIRREL_API SQRESULT FLUG sq_getthread(HSQUIRRELVM v,SQInteger idx,HSQUIRRELVM *thread);
SQRESULT  sq_getthread(HSQUIRRELVM v, SQInteger idx, HSQUIRRELVM *thread);
//C     SQUIRREL_API SQRESULT FLUG sq_getuserpointer(HSQUIRRELVM v,SQInteger idx,SQUserPointer *p);
SQRESULT  sq_getuserpointer(HSQUIRRELVM v, SQInteger idx, SQUserPointer *p);
//C     SQUIRREL_API SQRESULT FLUG sq_getuserdata(HSQUIRRELVM v,SQInteger idx,SQUserPointer *p,SQUserPointer *typetag);
SQRESULT  sq_getuserdata(HSQUIRRELVM v, SQInteger idx, SQUserPointer *p, SQUserPointer *typetag);
//C     SQUIRREL_API SQRESULT FLUG sq_settypetag(HSQUIRRELVM v,SQInteger idx,SQUserPointer typetag);
SQRESULT  sq_settypetag(HSQUIRRELVM v, SQInteger idx, SQUserPointer typetag);
//C     SQUIRREL_API SQRESULT FLUG sq_gettypetag(HSQUIRRELVM v,SQInteger idx,SQUserPointer *typetag);
SQRESULT  sq_gettypetag(HSQUIRRELVM v, SQInteger idx, SQUserPointer *typetag);
//C     SQUIRREL_API void FLUG sq_setreleasehook(HSQUIRRELVM v,SQInteger idx,SQRELEASEHOOK hook);
void  sq_setreleasehook(HSQUIRRELVM v, SQInteger idx, SQRELEASEHOOK hook);
//C     SQUIRREL_API SQChar* FLUG sq_getscratchpad(HSQUIRRELVM v,SQInteger minsize);
SQChar * sq_getscratchpad(HSQUIRRELVM v, SQInteger minsize);
//C     SQUIRREL_API SQRESULT FLUG sq_getclosureinfo(HSQUIRRELVM v,SQInteger idx,SQUnsignedInteger *nparams,SQUnsignedInteger *nfreevars);
SQRESULT  sq_getclosureinfo(HSQUIRRELVM v, SQInteger idx, SQUnsignedInteger *nparams, SQUnsignedInteger *nfreevars);
//C     SQUIRREL_API SQRESULT FLUG sq_setnativeclosurename(HSQUIRRELVM v,SQInteger idx,const SQChar *name);
SQRESULT  sq_setnativeclosurename(HSQUIRRELVM v, SQInteger idx, SQChar *name);
//C     SQUIRREL_API SQRESULT FLUG sq_setinstanceup(HSQUIRRELVM v, SQInteger idx, SQUserPointer p);
SQRESULT  sq_setinstanceup(HSQUIRRELVM v, SQInteger idx, SQUserPointer p);
//C     SQUIRREL_API SQRESULT FLUG sq_getinstanceup(HSQUIRRELVM v, SQInteger idx, SQUserPointer *p,SQUserPointer typetag);
SQRESULT  sq_getinstanceup(HSQUIRRELVM v, SQInteger idx, SQUserPointer *p, SQUserPointer typetag);
//C     SQUIRREL_API SQRESULT FLUG sq_setclassudsize(HSQUIRRELVM v, SQInteger idx, SQInteger udsize);
SQRESULT  sq_setclassudsize(HSQUIRRELVM v, SQInteger idx, SQInteger udsize);
//C     SQUIRREL_API SQRESULT FLUG sq_newclass(HSQUIRRELVM v,SQBool hasbase);
SQRESULT  sq_newclass(HSQUIRRELVM v, SQBool hasbase);
//C     SQUIRREL_API SQRESULT FLUG sq_createinstance(HSQUIRRELVM v,SQInteger idx);
SQRESULT  sq_createinstance(HSQUIRRELVM v, SQInteger idx);
//C     SQUIRREL_API SQRESULT FLUG sq_setattributes(HSQUIRRELVM v,SQInteger idx);
SQRESULT  sq_setattributes(HSQUIRRELVM v, SQInteger idx);
//C     SQUIRREL_API SQRESULT FLUG sq_getattributes(HSQUIRRELVM v,SQInteger idx);
SQRESULT  sq_getattributes(HSQUIRRELVM v, SQInteger idx);
//C     SQUIRREL_API SQRESULT FLUG sq_getclass(HSQUIRRELVM v,SQInteger idx);
SQRESULT  sq_getclass(HSQUIRRELVM v, SQInteger idx);
//C     SQUIRREL_API void FLUG sq_weakref(HSQUIRRELVM v,SQInteger idx);
void  sq_weakref(HSQUIRRELVM v, SQInteger idx);
//C     SQUIRREL_API SQRESULT FLUG sq_getdefaultdelegate(HSQUIRRELVM v,SQObjectType t);
SQRESULT  sq_getdefaultdelegate(HSQUIRRELVM v, SQObjectType t);

/*object manipulation*/
//C     SQUIRREL_API void FLUG sq_pushroottable(HSQUIRRELVM v);
void  sq_pushroottable(HSQUIRRELVM v);
//C     SQUIRREL_API void FLUG sq_pushregistrytable(HSQUIRRELVM v);
void  sq_pushregistrytable(HSQUIRRELVM v);
//C     SQUIRREL_API void FLUG sq_pushconsttable(HSQUIRRELVM v);
void  sq_pushconsttable(HSQUIRRELVM v);
//C     SQUIRREL_API SQRESULT FLUG sq_setroottable(HSQUIRRELVM v);
SQRESULT  sq_setroottable(HSQUIRRELVM v);
//C     SQUIRREL_API SQRESULT FLUG sq_setconsttable(HSQUIRRELVM v);
SQRESULT  sq_setconsttable(HSQUIRRELVM v);
//C     SQUIRREL_API SQRESULT FLUG sq_newslot(HSQUIRRELVM v, SQInteger idx, SQBool bstatic);
SQRESULT  sq_newslot(HSQUIRRELVM v, SQInteger idx, SQBool bstatic);
//C     SQUIRREL_API SQRESULT FLUG sq_deleteslot(HSQUIRRELVM v,SQInteger idx,SQBool pushval);
SQRESULT  sq_deleteslot(HSQUIRRELVM v, SQInteger idx, SQBool pushval);
//C     SQUIRREL_API SQRESULT FLUG sq_set(HSQUIRRELVM v,SQInteger idx);
SQRESULT  sq_set(HSQUIRRELVM v, SQInteger idx);
//C     SQUIRREL_API SQRESULT FLUG sq_get(HSQUIRRELVM v,SQInteger idx);
SQRESULT  sq_get(HSQUIRRELVM v, SQInteger idx);
//C     SQUIRREL_API SQRESULT FLUG sq_rawget(HSQUIRRELVM v,SQInteger idx);
SQRESULT  sq_rawget(HSQUIRRELVM v, SQInteger idx);
//C     SQUIRREL_API SQRESULT FLUG sq_rawset(HSQUIRRELVM v,SQInteger idx);
SQRESULT  sq_rawset(HSQUIRRELVM v, SQInteger idx);
//C     SQUIRREL_API SQRESULT FLUG sq_rawdeleteslot(HSQUIRRELVM v,SQInteger idx,SQBool pushval);
SQRESULT  sq_rawdeleteslot(HSQUIRRELVM v, SQInteger idx, SQBool pushval);
//C     SQUIRREL_API SQRESULT FLUG sq_arrayappend(HSQUIRRELVM v,SQInteger idx);
SQRESULT  sq_arrayappend(HSQUIRRELVM v, SQInteger idx);
//C     SQUIRREL_API SQRESULT FLUG sq_arraypop(HSQUIRRELVM v,SQInteger idx,SQBool pushval); 
SQRESULT  sq_arraypop(HSQUIRRELVM v, SQInteger idx, SQBool pushval);
//C     SQUIRREL_API SQRESULT FLUG sq_arrayresize(HSQUIRRELVM v,SQInteger idx,SQInteger newsize); 
SQRESULT  sq_arrayresize(HSQUIRRELVM v, SQInteger idx, SQInteger newsize);
//C     SQUIRREL_API SQRESULT FLUG sq_arrayreverse(HSQUIRRELVM v,SQInteger idx); 
SQRESULT  sq_arrayreverse(HSQUIRRELVM v, SQInteger idx);
//C     SQUIRREL_API SQRESULT FLUG sq_arrayremove(HSQUIRRELVM v,SQInteger idx,SQInteger itemidx);
SQRESULT  sq_arrayremove(HSQUIRRELVM v, SQInteger idx, SQInteger itemidx);
//C     SQUIRREL_API SQRESULT FLUG sq_arrayinsert(HSQUIRRELVM v,SQInteger idx,SQInteger destpos);
SQRESULT  sq_arrayinsert(HSQUIRRELVM v, SQInteger idx, SQInteger destpos);
//C     SQUIRREL_API SQRESULT FLUG sq_setdelegate(HSQUIRRELVM v,SQInteger idx);
SQRESULT  sq_setdelegate(HSQUIRRELVM v, SQInteger idx);
//C     SQUIRREL_API SQRESULT FLUG sq_getdelegate(HSQUIRRELVM v,SQInteger idx);
SQRESULT  sq_getdelegate(HSQUIRRELVM v, SQInteger idx);
//C     SQUIRREL_API SQRESULT FLUG sq_clone(HSQUIRRELVM v,SQInteger idx);
SQRESULT  sq_clone(HSQUIRRELVM v, SQInteger idx);
//C     SQUIRREL_API SQRESULT FLUG sq_setfreevariable(HSQUIRRELVM v,SQInteger idx,SQUnsignedInteger nval);
SQRESULT  sq_setfreevariable(HSQUIRRELVM v, SQInteger idx, SQUnsignedInteger nval);
//C     SQUIRREL_API SQRESULT FLUG sq_next(HSQUIRRELVM v,SQInteger idx);
SQRESULT  sq_next(HSQUIRRELVM v, SQInteger idx);
//C     SQUIRREL_API SQRESULT FLUG sq_getweakrefval(HSQUIRRELVM v,SQInteger idx);
SQRESULT  sq_getweakrefval(HSQUIRRELVM v, SQInteger idx);
//C     SQUIRREL_API SQRESULT FLUG sq_clear(HSQUIRRELVM v,SQInteger idx);
SQRESULT  sq_clear(HSQUIRRELVM v, SQInteger idx);

/*calls*/
//C     SQUIRREL_API SQRESULT FLUG sq_call(HSQUIRRELVM v,SQInteger params,SQBool retval,SQBool raiseerror);
SQRESULT  sq_call(HSQUIRRELVM v, SQInteger params, SQBool retval, SQBool raiseerror);
//C     SQUIRREL_API SQRESULT FLUG sq_resume(HSQUIRRELVM v,SQBool retval,SQBool raiseerror);
SQRESULT  sq_resume(HSQUIRRELVM v, SQBool retval, SQBool raiseerror);
//C     SQUIRREL_API const SQChar* FLUG sq_getlocal(HSQUIRRELVM v,SQUnsignedInteger level,SQUnsignedInteger idx);
SQChar * sq_getlocal(HSQUIRRELVM v, SQUnsignedInteger level, SQUnsignedInteger idx);
//C     SQUIRREL_API const SQChar* FLUG sq_getfreevariable(HSQUIRRELVM v,SQInteger idx,SQUnsignedInteger nval);
SQChar * sq_getfreevariable(HSQUIRRELVM v, SQInteger idx, SQUnsignedInteger nval);
//C     SQUIRREL_API SQRESULT FLUG sq_throwerror(HSQUIRRELVM v,const SQChar *err);
SQRESULT  sq_throwerror(HSQUIRRELVM v, SQChar *err);
//C     SQUIRREL_API void FLUG sq_reseterror(HSQUIRRELVM v);
void  sq_reseterror(HSQUIRRELVM v);
//C     SQUIRREL_API void FLUG sq_getlasterror(HSQUIRRELVM v);
void  sq_getlasterror(HSQUIRRELVM v);

/*raw object handling*/
//C     SQUIRREL_API SQRESULT FLUG sq_getstackobj(HSQUIRRELVM v,SQInteger idx,HSQOBJECT *po);
SQRESULT  sq_getstackobj(HSQUIRRELVM v, SQInteger idx, HSQOBJECT *po);
//C     SQUIRREL_API void FLUG sq_pushobject(HSQUIRRELVM v,HSQOBJECT obj);
void  sq_pushobject(HSQUIRRELVM v, HSQOBJECT obj);
//C     SQUIRREL_API void FLUG sq_addref(HSQUIRRELVM v,HSQOBJECT *po);
void  sq_addref(HSQUIRRELVM v, HSQOBJECT *po);
//C     SQUIRREL_API SQBool FLUG sq_release(HSQUIRRELVM v,HSQOBJECT *po);
SQBool  sq_release(HSQUIRRELVM v, HSQOBJECT *po);
//C     SQUIRREL_API void FLUG sq_resetobject(HSQOBJECT *po);
void  sq_resetobject(HSQOBJECT *po);
//C     SQUIRREL_API const SQChar* FLUG sq_objtostring(HSQOBJECT *o);
SQChar * sq_objtostring(HSQOBJECT *o);
//C     SQUIRREL_API SQBool FLUG sq_objtobool(HSQOBJECT *o);
SQBool  sq_objtobool(HSQOBJECT *o);
//C     SQUIRREL_API SQInteger FLUG sq_objtointeger(HSQOBJECT *o);
SQInteger  sq_objtointeger(HSQOBJECT *o);
//C     SQUIRREL_API SQFloat FLUG sq_objtofloat(HSQOBJECT *o);
SQFloat  sq_objtofloat(HSQOBJECT *o);
//C     SQUIRREL_API SQRESULT FLUG sq_getobjtypetag(HSQOBJECT *o,SQUserPointer * typetag);
SQRESULT  sq_getobjtypetag(HSQOBJECT *o, SQUserPointer *typetag);

/*GC*/
//C     SQUIRREL_API SQInteger FLUG sq_collectgarbage(HSQUIRRELVM v);
SQInteger  sq_collectgarbage(HSQUIRRELVM v);

/*serialization*/
//C     SQUIRREL_API SQRESULT FLUG sq_writeclosure(HSQUIRRELVM vm,SQWRITEFUNC writef,SQUserPointer up);
SQRESULT  sq_writeclosure(HSQUIRRELVM vm, SQWRITEFUNC writef, SQUserPointer up);
//C     SQUIRREL_API SQRESULT FLUG sq_readclosure(HSQUIRRELVM vm,SQREADFUNC readf,SQUserPointer up);
SQRESULT  sq_readclosure(HSQUIRRELVM vm, SQREADFUNC readf, SQUserPointer up);

/*mem allocation*/
//C     SQUIRREL_API void* FLUG sq_malloc(SQUnsignedInteger size);
void * sq_malloc(SQUnsignedInteger size);
//C     SQUIRREL_API void* FLUG sq_realloc(void* p,SQUnsignedInteger oldsize,SQUnsignedInteger newsize);
void * sq_realloc(void *p, SQUnsignedInteger oldsize, SQUnsignedInteger newsize);
//C     SQUIRREL_API void FLUG sq_free(void *p,SQUnsignedInteger size);
void  sq_free(void *p, SQUnsignedInteger size);

/*debug*/
//C     SQUIRREL_API SQRESULT FLUG sq_stackinfos(HSQUIRRELVM v,SQInteger level,SQStackInfos *si);
SQRESULT  sq_stackinfos(HSQUIRRELVM v, SQInteger level, SQStackInfos *si);
//C     SQUIRREL_API void FLUG sq_setdebughook(HSQUIRRELVM v);
void  sq_setdebughook(HSQUIRRELVM v);

/*UTILITY MACRO*/
//C     #define sq_isnumeric(o) ((o)._type&SQOBJECT_NUMERIC)
//C     #define sq_istable(o) ((o)._type==OT_TABLE)
//C     #define sq_isarray(o) ((o)._type==OT_ARRAY)
//C     #define sq_isfunction(o) ((o)._type==OT_FUNCPROTO)
//C     #define sq_isclosure(o) ((o)._type==OT_CLOSURE)
//C     #define sq_isgenerator(o) ((o)._type==OT_GENERATOR)
//C     #define sq_isnativeclosure(o) ((o)._type==OT_NATIVECLOSURE)
//C     #define sq_isstring(o) ((o)._type==OT_STRING)
//C     #define sq_isinteger(o) ((o)._type==OT_INTEGER)
//C     #define sq_isfloat(o) ((o)._type==OT_FLOAT)
//C     #define sq_isuserpointer(o) ((o)._type==OT_USERPOINTER)
//C     #define sq_isuserdata(o) ((o)._type==OT_USERDATA)
//C     #define sq_isthread(o) ((o)._type==OT_THREAD)
//C     #define sq_isnull(o) ((o)._type==OT_NULL)
//C     #define sq_isclass(o) ((o)._type==OT_CLASS)
//C     #define sq_isinstance(o) ((o)._type==OT_INSTANCE)
//C     #define sq_isbool(o) ((o)._type==OT_BOOL)
//C     #define sq_isweakref(o) ((o)._type==OT_WEAKREF)
//C     #define sq_type(o) ((o)._type)

/* deprecated */
//C     #define sq_createslot(v,n) sq_newslot(v,n,SQFalse)
SQRESULT sq_createslot(HSQUIRRELVM v,SQInteger n){
    return sq_newslot(v,n,SQFalse);
}


//C     #define SQ_OK (0)
//C     #define SQ_ERROR (-1)

//C     #define SQ_FAILED(res) (res<0)
//C     #define SQ_SUCCEEDED(res) (res>=0)
bool SQ_SUCCEEDED(int res) {return res>=0;}
bool SQ_FAILED(int res) {return !SQ_SUCCEEDED(res);}

//C     #ifdef __cplusplus
//C     } /*extern "C"*/
//C     #endif

//C     #endif /*_SQUIRREL_H_*/
