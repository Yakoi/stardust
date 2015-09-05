// D import file generated from 'sqlite3\sqlite3.d'
module sqlite3.sqlite3;
extern (C) 
{
    version (Tango)
{
    import tango.stdc.stdarg;
    import tango.stdc.inttypes;
}
else
{
    import std.c.stdarg;
    import std.stdint;
}
    version (build)
{
    pragma (link, "sqlite3");
}
    const char[] SQLITE_VERSION = "3.5.1";

    const SQLITE_VERSION_NUMBER = 3005001;
    char* sqlite3_version;
    char* sqlite3_libversion();
    int sqlite3_libversion_number();
    int sqlite3_threadsafe();
    struct sqlite3;
    alias int64_t sqlite3_int64;
    alias uint64_t sqlite3_uint64;
    int sqlite3_close(sqlite3*);
    alias int function(void*, int, char**, char**) sqlite3_callback;
    int sqlite3_exec(sqlite3*, char* sql, int function(void*, int, char**, char**) callback, void*, char** errmsg);
    const SQLITE_OK = 0;
    const SQLITE_ERROR = 1;
    const SQLITE_INTERNAL = 2;
    const SQLITE_PERM = 3;
    const SQLITE_ABORT = 4;
    const SQLITE_BUSY = 5;
    const SQLITE_LOCKED = 6;
    const SQLITE_NOMEM = 7;
    const SQLITE_READONLY = 8;
    const SQLITE_INTERRUPT = 9;
    const SQLITE_IOERR = 10;
    const SQLITE_CORRUPT = 11;
    const SQLITE_NOTFOUND = 12;
    const SQLITE_FULL = 13;
    const SQLITE_CANTOPEN = 14;
    const SQLITE_PROTOCOL = 15;
    const SQLITE_EMPTY = 16;
    const SQLITE_SCHEMA = 17;
    const SQLITE_TOOBIG = 18;
    const SQLITE_CONSTRAINT = 19;
    const SQLITE_MISMATCH = 20;
    const SQLITE_MISUSE = 21;
    const SQLITE_NOLFS = 22;
    const SQLITE_AUTH = 23;
    const SQLITE_FORMAT = 24;
    const SQLITE_RANGE = 25;
    const SQLITE_NOTADB = 26;
    const SQLITE_ROW = 100;
    const SQLITE_DONE = 101;
    const SQLITE_IOERR_READ = SQLITE_IOERR | 1 << 8;
    const SQLITE_IOERR_SHORT_READ = SQLITE_IOERR | 2 << 8;
    const SQLITE_IOERR_WRITE = SQLITE_IOERR | 3 << 8;
    const SQLITE_IOERR_FSYNC = SQLITE_IOERR | 4 << 8;
    const SQLITE_IOERR_DIR_FSYNC = SQLITE_IOERR | 5 << 8;
    const SQLITE_IOERR_TRUNCATE = SQLITE_IOERR | 6 << 8;
    const SQLITE_IOERR_FSTAT = SQLITE_IOERR | 7 << 8;
    const SQLITE_IOERR_UNLOCK = SQLITE_IOERR | 8 << 8;
    const SQLITE_IOERR_RDLOCK = SQLITE_IOERR | 9 << 8;
    const SQLITE_IOERR_DELETE = SQLITE_IOERR | 10 << 8;
    const SQLITE_IOERR_BLOCKED = SQLITE_IOERR | 11 << 8;
    const SQLITE_IOERR_NOMEM = SQLITE_IOERR | 12 << 8;
    const SQLITE_OPEN_READONLY = 1;
    const SQLITE_OPEN_READWRITE = 2;
    const SQLITE_OPEN_CREATE = 4;
    const SQLITE_OPEN_DELETEONCLOSE = 8;
    const SQLITE_OPEN_EXCLUSIVE = 16;
    const SQLITE_OPEN_MAIN_DB = 256;
    const SQLITE_OPEN_TEMP_DB = 512;
    const SQLITE_OPEN_TRANSIENT_DB = 1024;
    const SQLITE_OPEN_MAIN_JOURNAL = 2048;
    const SQLITE_OPEN_TEMP_JOURNAL = 4096;
    const SQLITE_OPEN_SUBJOURNAL = 8192;
    const SQLITE_OPEN_MASTER_JOURNAL = 16384;
    const SQLITE_IOCAP_ATOMIC = 1;
    const SQLITE_IOCAP_ATOMIC512 = 2;
    const SQLITE_IOCAP_ATOMIC1K = 4;
    const SQLITE_IOCAP_ATOMIC2K = 8;
    const SQLITE_IOCAP_ATOMIC4K = 16;
    const SQLITE_IOCAP_ATOMIC8K = 32;
    const SQLITE_IOCAP_ATOMIC16K = 64;
    const SQLITE_IOCAP_ATOMIC32K = 128;
    const SQLITE_IOCAP_ATOMIC64K = 256;
    const SQLITE_IOCAP_SAFE_APPEND = 512;
    const SQLITE_IOCAP_SEQUENTIAL = 1024;
    const SQLITE_LOCK_NONE = 0;
    const SQLITE_LOCK_SHARED = 1;
    const SQLITE_LOCK_RESERVED = 2;
    const SQLITE_LOCK_PENDING = 3;
    const SQLITE_LOCK_EXCLUSIVE = 4;
    const SQLITE_SYNC_NORMAL = 2;
    const SQLITE_SYNC_FULL = 3;
    const SQLITE_SYNC_DATAONLY = 16;
    struct sqlite3_file
{
    sqlite3_io_methods* pMethods;
}
    struct sqlite3_io_methods
{
    int iVersion;
    int function(sqlite3_file*) xClose;
    int function(sqlite3_file*, void*, int iAmt, sqlite3_int64 iOfst) xRead;
    int function(sqlite3_file*, void*, int iAmt, sqlite3_int64 iOfst) xWrite;
    int function(sqlite3_file*, sqlite3_int64 size) xTruncate;
    int function(sqlite3_file*, int flags) xSync;
    int function(sqlite3_file*, sqlite3_int64* pSize) xFileSize;
    int function(sqlite3_file*, int) xLock;
    int function(sqlite3_file*, int) xUnlock;
    int function(sqlite3_file*) xCheckReservedLock;
    int function(sqlite3_file*, int op, void* pArg) xFileControl;
    int function(sqlite3_file*) xSectorSize;
    int function(sqlite3_file*) xDeviceCharacteristics;
}
    const SQLITE_FCNTL_LOCKSTATE = 1;
    struct sqlite3_mutex;
    struct sqlite3_vfs
{
    int iVersion;
    int szOsFile;
    int mxPathname;
    sqlite3_vfs* pNext;
    char* zName;
    void* pAppData;
    int function(sqlite3_vfs*, char* zName, sqlite3_file*, int flags, int* pOutFlags) xOpen;
    int function(sqlite3_vfs*, char* zName, int syncDir) xDelete;
    int function(sqlite3_vfs*, char* zName, int flags) xAccess;
    int function(sqlite3_vfs*, int nOut, char* zOut) xGetTempName;
    int function(sqlite3_vfs*, char* zName, int nOut, char* zOut) xFullPathname;
    void* function(sqlite3_vfs*, char* zFileName) xDlOpen;
    void* function(sqlite3_vfs*, int nByte, char* zErrMsg) xDlError;
    void* function(sqlite3_vfs*, void*, char* zSymbol) xDlSym;
    void function(sqlite3_vfs*, void*) xDlClose;
    int function(sqlite3_vfs*, int nByte, char* zOut) xRandomness;
    int function(sqlite3_vfs*, int microseconds) xSleep;
    int function(sqlite3_vfs, double*) xCurrentTime;
}
    const SQLITE_ACCESS_EXISTS = 0;
    const SQLITE_ACCESS_READWRITE = 1;
    const SQLITE_ACCESS_READ = 2;
    int sqlite3_extended_result_codes(sqlite3*, int onoff);
    sqlite3_int64 sqlite3_last_insert_rowid(sqlite3*);
    int sqlite3_changes(sqlite3*);
    int sqlite3_total_changes(sqlite3*);
    void sqlite3_interrupt(sqlite3*);
    int sqlite3_complete(char* sql);
    int sqlite3_complete16(void* sql);
    int sqlite3_busy_handler(sqlite3*, int function(void*, int), void*);
    int sqlite3_busy_timeout(sqlite3*, int ms);
    int sqlite3_get_table(sqlite3*, char* sql, char*** resultp, int* nrow, int* ncolumn, char** errmsg);
    void sqlite3_free_table(char** result);
    char* sqlite3_mprintf(char*,...);
    char* sqlite3_vmprintf(char*, va_list);
    char* sqlite3_snprintf(int, char*, char*,...);
    void* sqlite3_malloc(int);
    void* sqlite3_realloc(void*, int);
    void sqlite3_free(void*);
    sqlite3_int64 sqlite3_memory_used();
    sqlite3_int64 sqlite3_memory_highwater(int resetFlag);
    int sqlite3_memory_alarm(void function(void* pArg, sqlite3_int64 used, int N) xCallback, void* pArg, sqlite3_int64 iThreshold);
    int sqlite3_set_authorizer(sqlite3*, int function(void*, int, char*, char*, char*, char*) xAuth, void* pUserData);
    const SQLITE_DENY = 1;
    const SQLITE_IGNORE = 2;
    const SQLITE_CREATE_INDEX = 1;
    const SQLITE_CREATE_TABLE = 2;
    const SQLITE_CREATE_TEMP_INDEX = 3;
    const SQLITE_CREATE_TEMP_TABLE = 4;
    const SQLITE_CREATE_TEMP_TRIGGER = 5;
    const SQLITE_CREATE_TEMP_VIEW = 6;
    const SQLITE_CREATE_TRIGGER = 7;
    const SQLITE_CREATE_VIEW = 8;
    const SQLITE_DELETE = 9;
    const SQLITE_DROP_INDEX = 10;
    const SQLITE_DROP_TABLE = 11;
    const SQLITE_DROP_TEMP_INDEX = 12;
    const SQLITE_DROP_TEMP_TABLE = 13;
    const SQLITE_DROP_TEMP_TRIGGER = 14;
    const SQLITE_DROP_TEMP_VIEW = 15;
    const SQLITE_DROP_TRIGGER = 16;
    const SQLITE_DROP_VIEW = 17;
    const SQLITE_INSERT = 18;
    const SQLITE_PRAGMA = 19;
    const SQLITE_READ = 20;
    const SQLITE_SELECT = 21;
    const SQLITE_TRANSACTION = 22;
    const SQLITE_UPDATE = 23;
    const SQLITE_ATTACH = 24;
    const SQLITE_DETACH = 25;
    const SQLITE_ALTER_TABLE = 26;
    const SQLITE_REINDEX = 27;
    const SQLITE_ANALYZE = 28;
    const SQLITE_CREATE_VTABLE = 29;
    const SQLITE_DROP_VTABLE = 30;
    const SQLITE_FUNCTION = 31;
    const SQLITE_COPY = 0;
    void* sqlite3_trace(sqlite3*, void function(void*, char*) xTrace, void*);
    void* sqlite3_profile(sqlite3*, void function(void*, char*, sqlite3_uint64) xProfile, void*);
    void sqlite3_progress_handler(sqlite3*, int, int function(void*), void*);
    int sqlite3_open(char* filename, sqlite3** ppDb);
    int sqlite3_open16(void* filename, sqlite3** ppDb);
    int sqlite3_open_v2(char* filename, sqlite3** ppDb, int flags, char* zVfs);
    int sqlite3_errcode(sqlite3* db);
    char* sqlite3_errmsg(sqlite3*);
    void* sqlite3_errmsg16(sqlite3*);
    struct sqlite3_stmt;
    int sqlite3_prepare(sqlite3* db, char* zSql, int nByte, sqlite3_stmt** ppStmt, char** pzTail);
    int sqlite3_prepare_v2(sqlite3* db, char* zSql, int nByte, sqlite3_stmt** ppStmt, char** pzTail);
    int sqlite3_prepare16(sqlite3* db, void* zSql, int nByte, sqlite3_stmt** ppStmt, void** pzTail);
    int sqlite3_prepare16_v2(sqlite3* db, void* zSql, int nByte, sqlite3_stmt** ppStmt, void** pzTail);
    struct sqlite3_value;
    struct sqlite3_context;
    int sqlite3_bind_blob(sqlite3_stmt*, int, void*, int n, void function(void*));
    int sqlite3_bind_double(sqlite3_stmt*, int, double);
    int sqlite3_bind_int(sqlite3_stmt*, int, int);
    int sqlite3_bind_int64(sqlite3_stmt*, int, sqlite3_int64);
    int sqlite3_bind_null(sqlite3_stmt*, int);
    int sqlite3_bind_text(sqlite3_stmt*, int, char*, int n, void function(void*));
    int sqlite3_bind_text16(sqlite3_stmt*, int, void*, int, void function(void*));
    int sqlite3_bind_value(sqlite3_stmt*, int, sqlite3_value*);
    int sqlite3_bind_zeroblob(sqlite3_stmt*, int, int n);
    int sqlite3_bind_parameter_count(sqlite3_stmt*);
    char* sqlite3_bind_parameter_name(sqlite3_stmt*, int);
    int sqlite3_bind_parameter_index(sqlite3_stmt*, char* zName);
    int sqlite3_clear_bindings(sqlite3_stmt*);
    int sqlite3_column_count(sqlite3_stmt* pStmt);
    char* sqlite3_column_name(sqlite3_stmt*, int N);
    void* sqlite3_column_name16(sqlite3_stmt*, int N);
    char* sqlite3_column_database_name(sqlite3_stmt*, int);
    void* sqlite3_column_database_name16(sqlite3_stmt*, int);
    char* sqlite3_column_table_name(sqlite3_stmt*, int);
    void* sqlite3_column_table_name16(sqlite3_stmt*, int);
    char* sqlite3_column_origin_name(sqlite3_stmt*, int);
    void* sqlite3_column_origin_name16(sqlite3_stmt*, int);
    char* sqlite3_column_decltype(sqlite3_stmt*, int i);
    void* sqlite3_column_decltype16(sqlite3_stmt*, int);
    int sqlite3_step(sqlite3_stmt*);
    int sqlite3_data_count(sqlite3_stmt* pStmt);
    const SQLITE_INTEGER = 1;
    const SQLITE_FLOAT = 2;
    const SQLITE_BLOB = 4;
    const SQLITE_NULL = 5;
    const SQLITE_TEXT = 3;
    const SQLITE3_TEXT = 3;
    void* sqlite3_column_blob(sqlite3_stmt*, int iCol);
    int sqlite3_column_bytes(sqlite3_stmt*, int iCol);
    int sqlite3_column_bytes16(sqlite3_stmt*, int iCol);
    double sqlite3_column_double(sqlite3_stmt*, int iCol);
    int sqlite3_column_int(sqlite3_stmt*, int iCol);
    sqlite3_int64 sqlite3_column_int64(sqlite3_stmt*, int iCol);
    char* sqlite3_column_text(sqlite3_stmt*, int iCol);
    void* sqlite3_column_text16(sqlite3_stmt*, int iCol);
    int sqlite3_column_type(sqlite3_stmt*, int iCol);
    sqlite3_value* sqlite3_column_value(sqlite3_stmt*, int iCol);
    int sqlite3_finalize(sqlite3_stmt* pStmt);
    int sqlite3_reset(sqlite3_stmt* pStmt);
    int sqlite3_create_function(sqlite3*, char* zFunctionName, int nArg, int eTextRep, void*, void function(sqlite3_context*, int, sqlite3_value**) xFunc, void function(sqlite3_context*, int, sqlite3_value**) xStep, void function(sqlite3_context*) xFinal);
    int sqlite3_create_function16(sqlite3*, void* zFunctionName, int nArg, int eTextRep, void*, void function(sqlite3_context*, int, sqlite3_value**) xFunc, void function(sqlite3_context*, int, sqlite3_value**) xStep, void function(sqlite3_context*) xFinal);
    const SQLITE_UTF8 = 1;
    const SQLITE_UTF16LE = 2;
    const SQLITE_UTF16BE = 3;
    const SQLITE_UTF16 = 4;
    const SQLITE_ANY = 5;
    const SQLITE_UTF16_ALIGNED = 8;
    int sqlite3_aggregate_count(sqlite3_context*);
    int sqlite3_expired(sqlite3_stmt*);
    int sqlite3_transfer_bindings(sqlite3_stmt*, sqlite3_stmt*);
    int sqlite3_global_recover();
    void sqlite3_thread_cleanup();
    void* sqlite3_value_blob(sqlite3_value*);
    int sqlite3_value_bytes(sqlite3_value*);
    int sqlite3_value_bytes16(sqlite3_value*);
    double sqlite3_value_double(sqlite3_value*);
    int sqlite3_value_int(sqlite3_value*);
    sqlite3_int64 sqlite3_value_int64(sqlite3_value*);
    char* sqlite3_value_text(sqlite3_value*);
    void* sqlite3_value_text16(sqlite3_value*);
    void* sqlite3_value_text16le(sqlite3_value*);
    void* sqlite3_value_text16be(sqlite3_value*);
    int sqlite3_value_type(sqlite3_value*);
    int sqlite3_value_numeric_type(sqlite3_value*);
    void* sqlite3_aggregate_context(sqlite3_context*, int nBytes);
    void* sqlite3_user_data(sqlite3_context*);
    void* sqlite3_get_auxdata(sqlite3_context*, int);
    void sqlite3_set_auxdata(sqlite3_context*, int, void*, void function(void*));
    alias void function(void*) sqlite3_destructor_type;
    const SQLITE_STATIC = cast(sqlite3_destructor_type)0;
    const SQLITE_TRANSIENT = cast(sqlite3_destructor_type)-1;
    void sqlite3_result_blob(sqlite3_context*, void*, int, void function(void*));
    void sqlite3_result_double(sqlite3_context*, double);
    void sqlite3_result_error(sqlite3_context*, char*, int);
    void sqlite3_result_error16(sqlite3_context*, void*, int);
    void sqlite3_result_error_toobig(sqlite3_context*);
    void sqlite3_result_error_nomem(sqlite3_context*);
    void sqlite3_result_int(sqlite3_context*, int);
    void sqlite3_result_int64(sqlite3_context*, sqlite3_int64);
    void sqlite3_result_null(sqlite3_context*);
    void sqlite3_result_text(sqlite3_context*, char*, int, void function(void*));
    void sqlite3_result_text16(sqlite3_context*, void*, int, void function(void*));
    void sqlite3_result_text16le(sqlite3_context*, void*, int, void function(void*));
    void sqlite3_result_text16be(sqlite3_context*, void*, int, void function(void*));
    void sqlite3_result_value(sqlite3_context*, sqlite3_value*);
    void sqlite3_result_zeroblob(sqlite3_context*, int n);
    int sqlite3_create_collation(sqlite3*, char* zName, int eTextRep, void*, int function(void*, int, void*, int, void*) xCompare);
    int sqlite3_create_collation_v2(sqlite3*, char* zName, int eTextRep, void*, int function(void*, int, void*, int, void*) xCompare, void function(void*) xDestroy);
    int sqlite3_create_collation16(sqlite3*, char* zName, int eTextRep, void*, int function(void*, int, void*, int, void*) xCompare);
    int sqlite3_collation_needed(sqlite3*, void*, void function(void*, sqlite3*, int eTextRep, char*));
    int sqlite3_collation_needed16(sqlite3*, void*, void function(void*, sqlite3*, int eTextRep, void*));
    int sqlite3_key(sqlite3* db, void* pKey, int nKey);
    int sqlite3_rekey(sqlite3* db, void* pKey, int nKey);
    int sqlite3_sleep(int);
    char* sqlite3_temp_directory;
    int sqlite3_get_autocommit(sqlite3*);
    sqlite3* sqlite3_db_handle(sqlite3_stmt*);
    void* sqlite3_commit_hook(sqlite3*, int function(void*), void*);
    void* sqlite3_rollback_hook(sqlite3*, void function(void*), void*);
    void* sqlite3_update_hook(sqlite3*, void function(void*, int, char*, char*, sqlite3_int64), void*);
    int sqlite3_enable_shared_cache(int);
    int sqlite3_release_memory(int);
    void sqlite3_soft_heap_limit(int);
    int sqlite3_table_column_metadata(sqlite3* db, char* zDbName, char* zTableName, char* zColumnName, char** pzDataType, char** pzCollSeq, int* pNotNull, int* pPrimaryKey, int* pAutoinc);
    int sqlite3_load_extension(sqlite3* db, char* zFile, char* zProc, char** pzErrMsg);
    int sqlite3_enable_load_extension(sqlite3* db, int onoff);
    int sqlite3_auto_extension(void* xEntryPoint);
    void sqlite3_reset_auto_extension();
    struct sqlite3_module
{
    int iVersion;
    int function(sqlite3*, void* pAux, int argc, char** argv, sqlite3_vtab** ppVTab, char**) xCreate;
    int function(sqlite3*, void* pAux, int argc, char** argv, sqlite3_vtab** ppVTab, char**) xConnect;
    int function(sqlite3_vtab* pVTab, sqlite3_index_info*) xBestIndex;
    int function(sqlite3_vtab* pVTab) xDisconnect;
    int function(sqlite3_vtab* pVTab) xDestroy;
    int function(sqlite3_vtab* pVTab, sqlite3_vtab_cursor** ppCursor) xOpen;
    int function(sqlite3_vtab_cursor*) xClose;
    int function(sqlite3_vtab_cursor*, int idxNum, char* idxStr, int argc, sqlite3_value** argv) xFilter;
    int function(sqlite3_vtab_cursor*) xNext;
    int function(sqlite3_vtab_cursor*) xEof;
    int function(sqlite3_vtab_cursor*, sqlite3_context*, int) xColumn;
    int function(sqlite3_vtab_cursor*, sqlite3_int64* pRowid) xRowid;
    int function(sqlite3_vtab*, int, sqlite3_value**, sqlite3_int64*) xUpdate;
    int function(sqlite3_vtab* pVTab) xBegin;
    int function(sqlite3_vtab* pVTab) xSync;
    int function(sqlite3_vtab* pVTab) xCommit;
    int function(sqlite3_vtab* pVTab) xRollback;
    int function(sqlite3_vtab* pVtab, int nArg, char* zName, void function(sqlite3_context*, int, sqlite3_value**)* pxFunc, void** ppArg) xFindFunction;
    int function(sqlite3_vtab* pVtab, char* zNew) xRename;
}
    struct sqlite3_index_info
{
    int nConstraint;
    struct sqlite3_index_constraint
{
    int iColumn;
    ubyte op;
    ubyte usable;
    int iTermOffset;
}
    sqlite3_index_constraint* aConstraint;
    int nOrderBy;
    struct sqlite3_index_orderby
{
    int iColumn;
    ubyte desc;
}
    sqlite3_index_orderby* aOrderBy;
    struct sqlite3_index_constraint_usage
{
    int argvIndex;
    ubyte omit;
}
    sqlite3_index_constraint_usage* aConstraintUsage;
    int idxNum;
    char* idxStr;
    int needToFreeIdxStr;
    int orderByConsumed;
    double estimatedCost;
}
    const SQLITE_INDEX_CONSTRAINT_EQ = 2;
    const SQLITE_INDEX_CONSTRAINT_GT = 4;
    const SQLITE_INDEX_CONSTRAINT_LE = 8;
    const SQLITE_INDEX_CONSTRAINT_LT = 16;
    const SQLITE_INDEX_CONSTRAINT_GE = 32;
    const SQLITE_INDEX_CONSTRAINT_MATCH = 64;
    int sqlite3_create_module(sqlite3* db, char* zName, sqlite3_module*, void*);
    int sqlite3_create_module_v2(sqlite3* db, char* zName, sqlite3_module*, void*, void function(void*) xDestroy);
    struct sqlite3_vtab
{
    sqlite3_module* pModule;
    int nRef;
    char* zErrMsg;
}
    struct sqlite3_vtab_cursor
{
    sqlite3_vtab* pVtab;
}
    int sqlite3_declare_vtab(sqlite3*, char* zCreateTable);
    int sqlite3_overload_function(sqlite3*, char* zFuncName, int nArg);
    struct sqlite3_blob;
    int sqlite3_blob_open(sqlite3*, char* zDb, char* zTable, char* zColumn, sqlite3_int64 iRow, int flags, sqlite3_blob** ppBlob);
    int sqlite3_blob_close(sqlite3_blob*);
    int sqlite3_blob_bytes(sqlite3_blob*);
    int sqlite3_blob_read(sqlite3_blob*, void* z, int n, int iOffset);
    int sqlite3_blob_write(sqlite3_blob*, void* z, int n, int iOffset);
    sqlite3_vfs* sqlite3_vfs_find(char* zVfsName);
    int sqlite3_vfs_register(sqlite3_vfs*, int makeDflt);
    int sqlite3_vfs_unregister(sqlite3_vfs*);
    sqlite3_mutex* sqlite3_mutex_alloc(int);
    void sqlite3_mutex_free(sqlite3_mutex*);
    void sqlite3_mutex_enter(sqlite3_mutex*);
    int sqlite3_mutex_try(sqlite3_mutex*);
    void sqlite3_mutex_leave(sqlite3_mutex*);
    int sqlite3_mutex_held(sqlite3_mutex*);
    int sqlite3_mutex_notheld(sqlite3_mutex*);
    const SQLITE_MUTEX_FAST = 0;
    const SQLITE_MUTEX_RECURSIVE = 1;
    const SQLITE_MUTEX_STATIC_MASTER = 2;
    const SQLITE_MUTEX_STATIC_MEM = 3;
    const SQLITE_MUTEX_STATIC_MEM2 = 4;
    const SQLITE_MUTEX_STATIC_PRNG = 5;
    const SQLITE_MUTEX_STATIC_LRU = 6;
    int sqlite3_file_control(sqlite3*, char* zDbName, int op, void*);
}
