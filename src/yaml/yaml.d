/* Converted to D from yaml.h by htod */
module yaml.yaml;

/**
 * @file yaml.h
 * @brief Public interface for libyaml.
 * 
 * Include the header file with the code:
 * @code
 * #include <yaml.h>
 * @endcode
 */

//C     #ifndef YAML_H
//C     #define YAML_H

//C     #ifdef __cplusplus
//C     extern "C" {
//C     #endif

//C     #include <stdlib.h>
import std.c.stdlib;
//C     #include <stdio.h>
import std.c.stdio;
//C     #include <string.h>
import std.c.string;

/**
 * @defgroup export Export Definitions
 * @{
 */

/** The public API declaration. */

//#ifdef WIN32
//C     #   if defined(YAML_DECLARE_STATIC)
//C     #       define  YAML_DECLARE(type)  type
//C     #   elif defined(YAML_DECLARE_EXPORT)
//C     #       define  YAML_DECLARE(type)  __declspec(dllexport) type
//C     #   else
//C     #       define  YAML_DECLARE(type)  __declspec(dllimport) type
//C     #   endif
//#else
//#   define  YAML_DECLARE(type)  type
//#endif

/** @} */

/**
 * @defgroup version Version Information
 * @{
 */

/**
 * Get the library version as a string.
 *
 * @returns The function returns the pointer to a static string of the form
 * @c "X.Y.Z", where @c X is the major version number, @c Y is a minor version
 * number, and @c Z is the patch version number.
 */

//C     YAML_DECLARE(const char *)
//C     yaml_get_version_string(void);
extern (C):
char * yaml_get_version_string();

/**
 * Get the library version numbers.
 *
 * @param[out]      major   Major version number.
 * @param[out]      minor   Minor version number.
 * @param[out]      patch   Patch version number.
 */

//C     YAML_DECLARE(void)
//C     yaml_get_version(int *major, int *minor, int *patch);
void  yaml_get_version(int *major, int *minor, int *patch);

/** @} */

/**
 * @defgroup basic Basic Types
 * @{
 */

/** The character type (UTF-8 octet). */
//C     typedef unsigned char yaml_char_t;
alias ubyte yaml_char_t;

/** The version directive data. */
//C     typedef struct yaml_version_directive_s {
    /** The major version number. */
//C         int major;
    /** The minor version number. */
//C         int minor;
//C     } yaml_version_directive_t;
struct yaml_version_directive_s
{
    int major;
    int minor;
}
alias yaml_version_directive_s yaml_version_directive_t;

/** The tag directive data. */
//C     typedef struct yaml_tag_directive_s {
    /** The tag handle. */
//C         yaml_char_t *handle;
    /** The tag prefix. */
//C         yaml_char_t *prefix;
//C     } yaml_tag_directive_t;
struct yaml_tag_directive_s
{
    yaml_char_t *handle;
    yaml_char_t *prefix;
}
alias yaml_tag_directive_s yaml_tag_directive_t;

/** The stream encoding. */
//C     typedef enum yaml_encoding_e {
    /** Let the parser choose the encoding. */
//C         YAML_ANY_ENCODING,
    /** The default UTF-8 encoding. */
//C         YAML_UTF8_ENCODING,
    /** The UTF-16-LE encoding with BOM. */
//C         YAML_UTF16LE_ENCODING,
    /** The UTF-16-BE encoding with BOM. */
//C         YAML_UTF16BE_ENCODING
//C     } yaml_encoding_t;
enum yaml_encoding_e
{
    YAML_ANY_ENCODING,
    YAML_UTF8_ENCODING,
    YAML_UTF16LE_ENCODING,
    YAML_UTF16BE_ENCODING,
}
alias yaml_encoding_e yaml_encoding_t;

/** Line break types. */

//C     typedef enum yaml_break_e {
    /** Let the parser choose the break type. */
//C         YAML_ANY_BREAK,
    /** Use CR for line breaks (Mac style). */
//C         YAML_CR_BREAK,
    /** Use LN for line breaks (Unix style). */
//C         YAML_LN_BREAK,
    /** Use CR LN for line breaks (DOS style). */
//C         YAML_CRLN_BREAK
//C     } yaml_break_t;
enum yaml_break_e
{
    YAML_ANY_BREAK,
    YAML_CR_BREAK,
    YAML_LN_BREAK,
    YAML_CRLN_BREAK,
}
alias yaml_break_e yaml_break_t;

/** Many bad things could happen with the parser and emitter. */
//C     typedef enum yaml_error_type_e {
    /** No error is produced. */
//C         YAML_NO_ERROR,

    /** Cannot allocate or reallocate a block of memory. */
//C         YAML_MEMORY_ERROR,

    /** Cannot read or decode the input stream. */
//C         YAML_READER_ERROR,
    /** Cannot scan the input stream. */
//C         YAML_SCANNER_ERROR,
    /** Cannot parse the input stream. */
//C         YAML_PARSER_ERROR,
    /** Cannot compose a YAML document. */
//C         YAML_COMPOSER_ERROR,

    /** Cannot write to the output stream. */
//C         YAML_WRITER_ERROR,
    /** Cannot emit a YAML stream. */
//C         YAML_EMITTER_ERROR
//C     } yaml_error_type_t;
enum yaml_error_type_e
{
    YAML_NO_ERROR,
    YAML_MEMORY_ERROR,
    YAML_READER_ERROR,
    YAML_SCANNER_ERROR,
    YAML_PARSER_ERROR,
    YAML_COMPOSER_ERROR,
    YAML_WRITER_ERROR,
    YAML_EMITTER_ERROR,
}
alias yaml_error_type_e yaml_error_type_t;

/** The pointer position. */
//C     typedef struct yaml_mark_s {
    /** The position index. */
//C         size_t index;

    /** The position line. */
//C         size_t line;

    /** The position column. */
//C         size_t column;
//C     } yaml_mark_t;
struct yaml_mark_s
{
    size_t index;
    size_t line;
    size_t column;
}
alias yaml_mark_s yaml_mark_t;

/** @} */

/**
 * @defgroup styles Node Styles
 * @{
 */

/** Scalar styles. */
//C     typedef enum yaml_scalar_style_e {
    /** Let the emitter choose the style. */
//C         YAML_ANY_SCALAR_STYLE,

    /** The plain scalar style. */
//C         YAML_PLAIN_SCALAR_STYLE,

    /** The single-quoted scalar style. */
//C         YAML_SINGLE_QUOTED_SCALAR_STYLE,
    /** The double-quoted scalar style. */
//C         YAML_DOUBLE_QUOTED_SCALAR_STYLE,

    /** The literal scalar style. */
//C         YAML_LITERAL_SCALAR_STYLE,
    /** The folded scalar style. */
//C         YAML_FOLDED_SCALAR_STYLE
//C     } yaml_scalar_style_t;
enum yaml_scalar_style_e
{
    YAML_ANY_SCALAR_STYLE,
    YAML_PLAIN_SCALAR_STYLE,
    YAML_SINGLE_QUOTED_SCALAR_STYLE,
    YAML_DOUBLE_QUOTED_SCALAR_STYLE,
    YAML_LITERAL_SCALAR_STYLE,
    YAML_FOLDED_SCALAR_STYLE,
}
alias yaml_scalar_style_e yaml_scalar_style_t;

/** Sequence styles. */
//C     typedef enum yaml_sequence_style_e {
    /** Let the emitter choose the style. */
//C         YAML_ANY_SEQUENCE_STYLE,

    /** The block sequence style. */
//C         YAML_BLOCK_SEQUENCE_STYLE,
    /** The flow sequence style. */
//C         YAML_FLOW_SEQUENCE_STYLE
//C     } yaml_sequence_style_t;
enum yaml_sequence_style_e
{
    YAML_ANY_SEQUENCE_STYLE,
    YAML_BLOCK_SEQUENCE_STYLE,
    YAML_FLOW_SEQUENCE_STYLE,
}
alias yaml_sequence_style_e yaml_sequence_style_t;

/** Mapping styles. */
//C     typedef enum yaml_mapping_style_e {
    /** Let the emitter choose the style. */
//C         YAML_ANY_MAPPING_STYLE,

    /** The block mapping style. */
//C         YAML_BLOCK_MAPPING_STYLE,
    /** The flow mapping style. */
//C         YAML_FLOW_MAPPING_STYLE
/*    YAML_FLOW_SET_MAPPING_STYLE   */
//C     } yaml_mapping_style_t;
enum yaml_mapping_style_e
{
    YAML_ANY_MAPPING_STYLE,
    YAML_BLOCK_MAPPING_STYLE,
    YAML_FLOW_MAPPING_STYLE,
}
alias yaml_mapping_style_e yaml_mapping_style_t;

/** @} */

/**
 * @defgroup tokens Tokens
 * @{
 */

/** Token types. */
//C     typedef enum yaml_token_type_e {
    /** An empty token. */
//C         YAML_NO_TOKEN,

    /** A STREAM-START token. */
//C         YAML_STREAM_START_TOKEN,
    /** A STREAM-END token. */
//C         YAML_STREAM_END_TOKEN,

    /** A VERSION-DIRECTIVE token. */
//C         YAML_VERSION_DIRECTIVE_TOKEN,
    /** A TAG-DIRECTIVE token. */
//C         YAML_TAG_DIRECTIVE_TOKEN,
    /** A DOCUMENT-START token. */
//C         YAML_DOCUMENT_START_TOKEN,
    /** A DOCUMENT-END token. */
//C         YAML_DOCUMENT_END_TOKEN,

    /** A BLOCK-SEQUENCE-START token. */
//C         YAML_BLOCK_SEQUENCE_START_TOKEN,
    /** A BLOCK-SEQUENCE-END token. */
//C         YAML_BLOCK_MAPPING_START_TOKEN,
    /** A BLOCK-END token. */
//C         YAML_BLOCK_END_TOKEN,

    /** A FLOW-SEQUENCE-START token. */
//C         YAML_FLOW_SEQUENCE_START_TOKEN,
    /** A FLOW-SEQUENCE-END token. */
//C         YAML_FLOW_SEQUENCE_END_TOKEN,
    /** A FLOW-MAPPING-START token. */
//C         YAML_FLOW_MAPPING_START_TOKEN,
    /** A FLOW-MAPPING-END token. */
//C         YAML_FLOW_MAPPING_END_TOKEN,

    /** A BLOCK-ENTRY token. */
//C         YAML_BLOCK_ENTRY_TOKEN,
    /** A FLOW-ENTRY token. */
//C         YAML_FLOW_ENTRY_TOKEN,
    /** A KEY token. */
//C         YAML_KEY_TOKEN,
    /** A VALUE token. */
//C         YAML_VALUE_TOKEN,

    /** An ALIAS token. */
//C         YAML_ALIAS_TOKEN,
    /** An ANCHOR token. */
//C         YAML_ANCHOR_TOKEN,
    /** A TAG token. */
//C         YAML_TAG_TOKEN,
    /** A SCALAR token. */
//C         YAML_SCALAR_TOKEN
//C     } yaml_token_type_t;
enum yaml_token_type_e
{
    YAML_NO_TOKEN,
    YAML_STREAM_START_TOKEN,
    YAML_STREAM_END_TOKEN,
    YAML_VERSION_DIRECTIVE_TOKEN,
    YAML_TAG_DIRECTIVE_TOKEN,
    YAML_DOCUMENT_START_TOKEN,
    YAML_DOCUMENT_END_TOKEN,
    YAML_BLOCK_SEQUENCE_START_TOKEN,
    YAML_BLOCK_MAPPING_START_TOKEN,
    YAML_BLOCK_END_TOKEN,
    YAML_FLOW_SEQUENCE_START_TOKEN,
    YAML_FLOW_SEQUENCE_END_TOKEN,
    YAML_FLOW_MAPPING_START_TOKEN,
    YAML_FLOW_MAPPING_END_TOKEN,
    YAML_BLOCK_ENTRY_TOKEN,
    YAML_FLOW_ENTRY_TOKEN,
    YAML_KEY_TOKEN,
    YAML_VALUE_TOKEN,
    YAML_ALIAS_TOKEN,
    YAML_ANCHOR_TOKEN,
    YAML_TAG_TOKEN,
    YAML_SCALAR_TOKEN,
}
alias yaml_token_type_e yaml_token_type_t;

/** The token structure. */
//C     typedef struct yaml_token_s {

    /** The token type. */
//C         yaml_token_type_t type;

    /** The token data. */
//C         union {

        /** The stream start (for @c YAML_STREAM_START_TOKEN). */
//C             struct {
            /** The stream encoding. */
//C                 yaml_encoding_t encoding;
//C             } stream_start;
struct _N2
{
    yaml_encoding_t encoding;
}

        /** The alias (for @c YAML_ALIAS_TOKEN). */
//C             struct {
            /** The alias value. */
//C                 yaml_char_t *value;
//C             } alias;
struct _N3
{
    yaml_char_t *value;
}

        /** The anchor (for @c YAML_ANCHOR_TOKEN). */
//C             struct {
            /** The anchor value. */
//C                 yaml_char_t *value;
//C             } anchor;
struct _N4
{
    yaml_char_t *value;
}

        /** The tag (for @c YAML_TAG_TOKEN). */
//C             struct {
            /** The tag handle. */
//C                 yaml_char_t *handle;
            /** The tag suffix. */
//C                 yaml_char_t *suffix;
//C             } tag;
struct _N5
{
    yaml_char_t *handle;
    yaml_char_t *suffix;
}

        /** The scalar value (for @c YAML_SCALAR_TOKEN). */
//C             struct {
            /** The scalar value. */
//C                 yaml_char_t *value;
            /** The length of the scalar value. */
//C                 size_t length;
            /** The scalar style. */
//C                 yaml_scalar_style_t style;
//C             } scalar;
struct _N6
{
    yaml_char_t *value;
    size_t length;
    yaml_scalar_style_t style;
}

        /** The version directive (for @c YAML_VERSION_DIRECTIVE_TOKEN). */
//C             struct {
            /** The major version number. */
//C                 int major;
            /** The minor version number. */
//C                 int minor;
//C             } version_directive;
struct _N7
{
    int major;
    int minor;
}

        /** The tag directive (for @c YAML_TAG_DIRECTIVE_TOKEN). */
//C             struct {
            /** The tag handle. */
//C                 yaml_char_t *handle;
            /** The tag prefix. */
//C                 yaml_char_t *prefix;
//C             } tag_directive;
struct _N8
{
    yaml_char_t *handle;
    yaml_char_t *prefix;
}

//C         } data;
union _N1
{
    _N2 stream_start;
    _N3 alias_;
    _N4 anchor;
    _N5 tag;
    _N6 scalar;
    _N7 version_directive;
    _N8 tag_directive;
}

    /** The beginning of the token. */
//C         yaml_mark_t start_mark;
    /** The end of the token. */
//C         yaml_mark_t end_mark;

//C     } yaml_token_t;
struct yaml_token_s
{
    yaml_token_type_t type;
    _N1 data;
    yaml_mark_t start_mark;
    yaml_mark_t end_mark;
}
alias yaml_token_s yaml_token_t;

/**
 * Free any memory allocated for a token object.
 *
 * @param[in,out]   token   A token object.
 */

//C     YAML_DECLARE(void)
//C     yaml_token_delete(yaml_token_t *token);
void  yaml_token_delete(yaml_token_t *token);

/** @} */

/**
 * @defgroup events Events
 * @{
 */

/** Event types. */
//C     typedef enum yaml_event_type_e {
    /** An empty event. */
//C         YAML_NO_EVENT,

    /** A STREAM-START event. */
//C         YAML_STREAM_START_EVENT,
    /** A STREAM-END event. */
//C         YAML_STREAM_END_EVENT,

    /** A DOCUMENT-START event. */
//C         YAML_DOCUMENT_START_EVENT,
    /** A DOCUMENT-END event. */
//C         YAML_DOCUMENT_END_EVENT,

    /** An ALIAS event. */
//C         YAML_ALIAS_EVENT,
    /** A SCALAR event. */
//C         YAML_SCALAR_EVENT,

    /** A SEQUENCE-START event. */
//C         YAML_SEQUENCE_START_EVENT,
    /** A SEQUENCE-END event. */
//C         YAML_SEQUENCE_END_EVENT,

    /** A MAPPING-START event. */
//C         YAML_MAPPING_START_EVENT,
    /** A MAPPING-END event. */
//C         YAML_MAPPING_END_EVENT
//C     } yaml_event_type_t;
enum yaml_event_type_e
{
    YAML_NO_EVENT,
    YAML_STREAM_START_EVENT,
    YAML_STREAM_END_EVENT,
    YAML_DOCUMENT_START_EVENT,
    YAML_DOCUMENT_END_EVENT,
    YAML_ALIAS_EVENT,
    YAML_SCALAR_EVENT,
    YAML_SEQUENCE_START_EVENT,
    YAML_SEQUENCE_END_EVENT,
    YAML_MAPPING_START_EVENT,
    YAML_MAPPING_END_EVENT,
}
alias yaml_event_type_e yaml_event_type_t;

/** The event structure. */
//C     typedef struct yaml_event_s {

    /** The event type. */
//C         yaml_event_type_t type;

    /** The event data. */
//C         union {
        
        /** The stream parameters (for @c YAML_STREAM_START_EVENT). */
//C             struct {
            /** The document encoding. */
//C                 yaml_encoding_t encoding;
//C             } stream_start;
struct _N10
{
    yaml_encoding_t encoding;
}

        /** The document parameters (for @c YAML_DOCUMENT_START_EVENT). */
//C             struct {
            /** The version directive. */
//C                 yaml_version_directive_t *version_directive;

            /** The list of tag directives. */
//C                 struct {
                /** The beginning of the tag directives list. */
//C                     yaml_tag_directive_t *start;
                /** The end of the tag directives list. */
//C                     yaml_tag_directive_t *end;
//C                 } tag_directives;
struct _N12
{
    yaml_tag_directive_t *start;
    yaml_tag_directive_t *end;
}

            /** Is the document indicator implicit? */
//C                 int implicit;
//C             } document_start;
struct _N11
{
    yaml_version_directive_t *version_directive;
    _N12 tag_directives;
    int implicit;
}

        /** The document end parameters (for @c YAML_DOCUMENT_END_EVENT). */
//C             struct {
            /** Is the document end indicator implicit? */
//C                 int implicit;
//C             } document_end;
struct _N13
{
    int implicit;
}

        /** The alias parameters (for @c YAML_ALIAS_EVENT). */
//C             struct {
            /** The anchor. */
//C                 yaml_char_t *anchor;
//C             } alias;
struct _N14
{
    yaml_char_t *anchor;
}

        /** The scalar parameters (for @c YAML_SCALAR_EVENT). */
//C             struct {
            /** The anchor. */
//C                 yaml_char_t *anchor;
            /** The tag. */
//C                 yaml_char_t *tag;
            /** The scalar value. */
//C                 yaml_char_t *value;
            /** The length of the scalar value. */
//C                 size_t length;
            /** Is the tag optional for the plain style? */
//C                 int plain_implicit;
            /** Is the tag optional for any non-plain style? */
//C                 int quoted_implicit;
            /** The scalar style. */
//C                 yaml_scalar_style_t style;
//C             } scalar;
struct _N15
{
    yaml_char_t *anchor;
    yaml_char_t *tag;
    yaml_char_t *value;
    size_t length;
    int plain_implicit;
    int quoted_implicit;
    yaml_scalar_style_t style;
}

        /** The sequence parameters (for @c YAML_SEQUENCE_START_EVENT). */
//C             struct {
            /** The anchor. */
//C                 yaml_char_t *anchor;
            /** The tag. */
//C                 yaml_char_t *tag;
            /** Is the tag optional? */
//C                 int implicit;
            /** The sequence style. */
//C                 yaml_sequence_style_t style;
//C             } sequence_start;
struct _N16
{
    yaml_char_t *anchor;
    yaml_char_t *tag;
    int implicit;
    yaml_sequence_style_t style;
}

        /** The mapping parameters (for @c YAML_MAPPING_START_EVENT). */
//C             struct {
            /** The anchor. */
//C                 yaml_char_t *anchor;
            /** The tag. */
//C                 yaml_char_t *tag;
            /** Is the tag optional? */
//C                 int implicit;
            /** The mapping style. */
//C                 yaml_mapping_style_t style;
//C             } mapping_start;
struct _N17
{
    yaml_char_t *anchor;
    yaml_char_t *tag;
    int implicit;
    yaml_mapping_style_t style;
}

//C         } data;
union _N9
{
    _N10 stream_start;
    _N11 document_start;
    _N13 document_end;
    _N14 alias_;
    _N15 scalar;
    _N16 sequence_start;
    _N17 mapping_start;
}

    /** The beginning of the event. */
//C         yaml_mark_t start_mark;
    /** The end of the event. */
//C         yaml_mark_t end_mark;

//C     } yaml_event_t;
struct yaml_event_s
{
    yaml_event_type_t type;
    _N9 data;
    yaml_mark_t start_mark;
    yaml_mark_t end_mark;
}
alias yaml_event_s yaml_event_t;

/**
 * Create the STREAM-START event.
 *
 * @param[out]      event       An empty event object.
 * @param[in]       encoding    The stream encoding.
 *
 * @returns @c 1 if the function succeeded, @c 0 on error.
 */

//C     YAML_DECLARE(int)
//C     yaml_stream_start_event_initialize(yaml_event_t *event,
//C             yaml_encoding_t encoding);
int  yaml_stream_start_event_initialize(yaml_event_t *event, yaml_encoding_t encoding);

/**
 * Create the STREAM-END event.
 *
 * @param[out]      event       An empty event object.
 *
 * @returns @c 1 if the function succeeded, @c 0 on error.
 */

//C     YAML_DECLARE(int)
//C     yaml_stream_end_event_initialize(yaml_event_t *event);
int  yaml_stream_end_event_initialize(yaml_event_t *event);

/**
 * Create the DOCUMENT-START event.
 *
 * The @a implicit argument is considered as a stylistic parameter and may be
 * ignored by the emitter.
 *
 * @param[out]      event                   An empty event object.
 * @param[in]       version_directive       The %YAML directive value or
 *                                          @c NULL.
 * @param[in]       tag_directives_start    The beginning of the %TAG
 *                                          directives list.
 * @param[in]       tag_directives_end      The end of the %TAG directives
 *                                          list.
 * @param[in]       implicit                If the document start indicator is
 *                                          implicit.
 *
 * @returns @c 1 if the function succeeded, @c 0 on error.
 */

//C     YAML_DECLARE(int)
//C     yaml_document_start_event_initialize(yaml_event_t *event,
//C             yaml_version_directive_t *version_directive,
//C             yaml_tag_directive_t *tag_directives_start,
//C             yaml_tag_directive_t *tag_directives_end,
//C             int implicit);
int  yaml_document_start_event_initialize(yaml_event_t *event, yaml_version_directive_t *version_directive, yaml_tag_directive_t *tag_directives_start, yaml_tag_directive_t *tag_directives_end, int implicit);

/**
 * Create the DOCUMENT-END event.
 *
 * The @a implicit argument is considered as a stylistic parameter and may be
 * ignored by the emitter.
 *
 * @param[out]      event       An empty event object.
 * @param[in]       implicit    If the document end indicator is implicit.
 *
 * @returns @c 1 if the function succeeded, @c 0 on error.
 */

//C     YAML_DECLARE(int)
//C     yaml_document_end_event_initialize(yaml_event_t *event, int implicit);
int  yaml_document_end_event_initialize(yaml_event_t *event, int implicit);

/**
 * Create an ALIAS event.
 *
 * @param[out]      event       An empty event object.
 * @param[in]       anchor      The anchor value.
 *
 * @returns @c 1 if the function succeeded, @c 0 on error.
 */

//C     YAML_DECLARE(int)
//C     yaml_alias_event_initialize(yaml_event_t *event, yaml_char_t *anchor);
int  yaml_alias_event_initialize(yaml_event_t *event, yaml_char_t *anchor);

/**
 * Create a SCALAR event.
 *
 * The @a style argument may be ignored by the emitter.
 *
 * Either the @a tag attribute or one of the @a plain_implicit and
 * @a quoted_implicit flags must be set.
 *
 * @param[out]      event           An empty event object.
 * @param[in]       anchor          The scalar anchor or @c NULL.
 * @param[in]       tag             The scalar tag or @c NULL.
 * @param[in]       value           The scalar value.
 * @param[in]       length          The length of the scalar value.
 * @param[in]       plain_implicit  If the tag may be omitted for the plain
 *                                  style.
 * @param[in]       quoted_implicit If the tag may be omitted for any
 *                                  non-plain style.
 * @param[in]       style           The scalar style.
 *
 * @returns @c 1 if the function succeeded, @c 0 on error.
 */

//C     YAML_DECLARE(int)
//C     yaml_scalar_event_initialize(yaml_event_t *event,
//C             yaml_char_t *anchor, yaml_char_t *tag,
//C             yaml_char_t *value, int length,
//C             int plain_implicit, int quoted_implicit,
//C             yaml_scalar_style_t style);
int  yaml_scalar_event_initialize(yaml_event_t *event, yaml_char_t *anchor, yaml_char_t *tag, yaml_char_t *value, int length, int plain_implicit, int quoted_implicit, yaml_scalar_style_t style);

/**
 * Create a SEQUENCE-START event.
 *
 * The @a style argument may be ignored by the emitter.
 *
 * Either the @a tag attribute or the @a implicit flag must be set.
 *
 * @param[out]      event       An empty event object.
 * @param[in]       anchor      The sequence anchor or @c NULL.
 * @param[in]       tag         The sequence tag or @c NULL.
 * @param[in]       implicit    If the tag may be omitted.
 * @param[in]       style       The sequence style.
 *
 * @returns @c 1 if the function succeeded, @c 0 on error.
 */

//C     YAML_DECLARE(int)
//C     yaml_sequence_start_event_initialize(yaml_event_t *event,
//C             yaml_char_t *anchor, yaml_char_t *tag, int implicit,
//C             yaml_sequence_style_t style);
int  yaml_sequence_start_event_initialize(yaml_event_t *event, yaml_char_t *anchor, yaml_char_t *tag, int implicit, yaml_sequence_style_t style);

/**
 * Create a SEQUENCE-END event.
 *
 * @param[out]      event       An empty event object.
 *
 * @returns @c 1 if the function succeeded, @c 0 on error.
 */

//C     YAML_DECLARE(int)
//C     yaml_sequence_end_event_initialize(yaml_event_t *event);
int  yaml_sequence_end_event_initialize(yaml_event_t *event);

/**
 * Create a MAPPING-START event.
 *
 * The @a style argument may be ignored by the emitter.
 *
 * Either the @a tag attribute or the @a implicit flag must be set.
 *
 * @param[out]      event       An empty event object.
 * @param[in]       anchor      The mapping anchor or @c NULL.
 * @param[in]       tag         The mapping tag or @c NULL.
 * @param[in]       implicit    If the tag may be omitted.
 * @param[in]       style       The mapping style.
 *
 * @returns @c 1 if the function succeeded, @c 0 on error.
 */

//C     YAML_DECLARE(int)
//C     yaml_mapping_start_event_initialize(yaml_event_t *event,
//C             yaml_char_t *anchor, yaml_char_t *tag, int implicit,
//C             yaml_mapping_style_t style);
int  yaml_mapping_start_event_initialize(yaml_event_t *event, yaml_char_t *anchor, yaml_char_t *tag, int implicit, yaml_mapping_style_t style);

/**
 * Create a MAPPING-END event.
 *
 * @param[out]      event       An empty event object.
 *
 * @returns @c 1 if the function succeeded, @c 0 on error.
 */

//C     YAML_DECLARE(int)
//C     yaml_mapping_end_event_initialize(yaml_event_t *event);
int  yaml_mapping_end_event_initialize(yaml_event_t *event);

/**
 * Free any memory allocated for an event object.
 *
 * @param[in,out]   event   An event object.
 */

//C     YAML_DECLARE(void)
//C     yaml_event_delete(yaml_event_t *event);
void  yaml_event_delete(yaml_event_t *event);

/** @} */

/**
 * @defgroup nodes Nodes
 * @{
 */

/** The tag @c !!null with the only possible value: @c null. */
//C     #define YAML_NULL_TAG       "tag:yaml.org,2002:null"
const string YAML_NULL_TAG = "tag:yaml.org,2002:null";
/** The tag @c !!bool with the values: @c true and @c falce. */
//C     #define YAML_BOOL_TAG       "tag:yaml.org,2002:bool"
const string YAML_BOOL_TAG = "tag:yaml.org,2002:bool";
/** The tag @c !!str for string values. */
//C     #define YAML_STR_TAG        "tag:yaml.org,2002:str"
const string YAML_STR_TAG = "tag:yaml.org,2002:str";
/** The tag @c !!int for integer values. */
//C     #define YAML_INT_TAG        "tag:yaml.org,2002:int"
const string YAML_INT_TAG = "tag:yaml.org,2002:int";
/** The tag @c !!float for float values. */
//C     #define YAML_FLOAT_TAG      "tag:yaml.org,2002:float"
const string YAML_FLOAT_TAG = "tag:yaml.org,2002:float";
/** The tag @c !!timestamp for date and time values. */
//C     #define YAML_TIMESTAMP_TAG  "tag:yaml.org,2002:timestamp"
const string YAML_TIMESTAMP_TAG = "tag:yaml.org,2002:timestamp";

/** The tag @c !!seq is used to denote sequences. */
//C     #define YAML_SEQ_TAG        "tag:yaml.org,2002:seq"
const string YAML_SEQ_TAG = "tag:yaml.org,2002:seq";
/** The tag @c !!map is used to denote mapping. */
//C     #define YAML_MAP_TAG        "tag:yaml.org,2002:map"
const string YAML_MAP_TAG = "tag:yaml.org,2002:map";

/** The default scalar tag is @c !!str. */
//C     #define YAML_DEFAULT_SCALAR_TAG     YAML_STR_TAG
/** The default sequence tag is @c !!seq. */
alias YAML_STR_TAG YAML_DEFAULT_SCALAR_TAG;
//C     #define YAML_DEFAULT_SEQUENCE_TAG   YAML_SEQ_TAG
/** The default mapping tag is @c !!map. */
alias YAML_SEQ_TAG YAML_DEFAULT_SEQUENCE_TAG;
//C     #define YAML_DEFAULT_MAPPING_TAG    YAML_MAP_TAG

alias YAML_MAP_TAG YAML_DEFAULT_MAPPING_TAG;
/** Node types. */
//C     typedef enum yaml_node_type_e {
    /** An empty node. */
//C         YAML_NO_NODE,

    /** A scalar node. */
//C         YAML_SCALAR_NODE,
    /** A sequence node. */
//C         YAML_SEQUENCE_NODE,
    /** A mapping node. */
//C         YAML_MAPPING_NODE
//C     } yaml_node_type_t;
enum yaml_node_type_e
{
    YAML_NO_NODE,
    YAML_SCALAR_NODE,
    YAML_SEQUENCE_NODE,
    YAML_MAPPING_NODE,
}
alias yaml_node_type_e yaml_node_type_t;

/** The forward definition of a document node structure. */
//C     typedef struct yaml_node_s yaml_node_t;
alias yaml_node_s yaml_node_t;

/** An element of a sequence node. */
//C     typedef int yaml_node_item_t;
alias int yaml_node_item_t;

/** An element of a mapping node. */
//C     typedef struct yaml_node_pair_s {
    /** The key of the element. */
//C         int key;
    /** The value of the element. */
//C         int value;
//C     } yaml_node_pair_t;
struct yaml_node_pair_s
{
    int key;
    int value;
}
alias yaml_node_pair_s yaml_node_pair_t;

/** The node structure. */
//C     struct yaml_node_s {

    /** The node type. */
//C         yaml_node_type_t type;

    /** The node tag. */
//C         yaml_char_t *tag;

    /** The node data. */
//C         union {
        
        /** The scalar parameters (for @c YAML_SCALAR_NODE). */
//C             struct {
            /** The scalar value. */
//C                 yaml_char_t *value;
            /** The length of the scalar value. */
//C                 size_t length;
            /** The scalar style. */
//C                 yaml_scalar_style_t style;
//C             } scalar;
struct _N19
{
    yaml_char_t *value;
    size_t length;
    yaml_scalar_style_t style;
}

        /** The sequence parameters (for @c YAML_SEQUENCE_NODE). */
//C             struct {
            /** The stack of sequence items. */
//C                 struct {
                /** The beginning of the stack. */
//C                     yaml_node_item_t *start;
                /** The end of the stack. */
//C                     yaml_node_item_t *end;
                /** The top of the stack. */
//C                     yaml_node_item_t *top;
//C                 } items;
struct _N21
{
    yaml_node_item_t *start;
    yaml_node_item_t *end;
    yaml_node_item_t *top;
}
            /** The sequence style. */
//C                 yaml_sequence_style_t style;
//C             } sequence;
struct _N20
{
    _N21 items;
    yaml_sequence_style_t style;
}

        /** The mapping parameters (for @c YAML_MAPPING_NODE). */
//C             struct {
            /** The stack of mapping pairs (key, value). */
//C                 struct {
                /** The beginning of the stack. */
//C                     yaml_node_pair_t *start;
                /** The end of the stack. */
//C                     yaml_node_pair_t *end;
                /** The top of the stack. */
//C                     yaml_node_pair_t *top;
//C                 } pairs;
struct _N23
{
    yaml_node_pair_t *start;
    yaml_node_pair_t *end;
    yaml_node_pair_t *top;
}
            /** The mapping style. */
//C                 yaml_mapping_style_t style;
//C             } mapping;
struct _N22
{
    _N23 pairs;
    yaml_mapping_style_t style;
}

//C         } data;
union _N18
{
    _N19 scalar;
    _N20 sequence;
    _N22 mapping;
}

    /** The beginning of the node. */
//C         yaml_mark_t start_mark;
    /** The end of the node. */
//C         yaml_mark_t end_mark;

//C     };
struct yaml_node_s
{
    yaml_node_type_t type;
    yaml_char_t *tag;
    _N18 data;
    yaml_mark_t start_mark;
    yaml_mark_t end_mark;
}

/** The document structure. */
//C     typedef struct yaml_document_s {

    /** The document nodes. */
//C         struct {
        /** The beginning of the stack. */
//C             yaml_node_t *start;
        /** The end of the stack. */
//C             yaml_node_t *end;
        /** The top of the stack. */
//C             yaml_node_t *top;
//C         } nodes;
struct _N24
{
    yaml_node_t *start;
    yaml_node_t *end;
    yaml_node_t *top;
}

    /** The version directive. */
//C         yaml_version_directive_t *version_directive;

    /** The list of tag directives. */
//C         struct {
        /** The beginning of the tag directives list. */
//C             yaml_tag_directive_t *start;
        /** The end of the tag directives list. */
//C             yaml_tag_directive_t *end;
//C         } tag_directives;
struct _N25
{
    yaml_tag_directive_t *start;
    yaml_tag_directive_t *end;
}

    /** Is the document start indicator implicit? */
//C         int start_implicit;
    /** Is the document end indicator implicit? */
//C         int end_implicit;

    /** The beginning of the document. */
//C         yaml_mark_t start_mark;
    /** The end of the document. */
//C         yaml_mark_t end_mark;

//C     } yaml_document_t;
struct yaml_document_s
{
    _N24 nodes;
    yaml_version_directive_t *version_directive;
    _N25 tag_directives;
    int start_implicit;
    int end_implicit;
    yaml_mark_t start_mark;
    yaml_mark_t end_mark;
}
alias yaml_document_s yaml_document_t;

/**
 * Create a YAML document.
 *
 * @param[out]      document                An empty document object.
 * @param[in]       version_directive       The %YAML directive value or
 *                                          @c NULL.
 * @param[in]       tag_directives_start    The beginning of the %TAG
 *                                          directives list.
 * @param[in]       tag_directives_end      The end of the %TAG directives
 *                                          list.
 * @param[in]       start_implicit          If the document start indicator is
 *                                          implicit.
 * @param[in]       end_implicit            If the document end indicator is
 *                                          implicit.
 *
 * @returns @c 1 if the function succeeded, @c 0 on error.
 */

//C     YAML_DECLARE(int)
//C     yaml_document_initialize(yaml_document_t *document,
//C             yaml_version_directive_t *version_directive,
//C             yaml_tag_directive_t *tag_directives_start,
//C             yaml_tag_directive_t *tag_directives_end,
//C             int start_implicit, int end_implicit);
int  yaml_document_initialize(yaml_document_t *document, yaml_version_directive_t *version_directive, yaml_tag_directive_t *tag_directives_start, yaml_tag_directive_t *tag_directives_end, int start_implicit, int end_implicit);

/**
 * Delete a YAML document and all its nodes.
 *
 * @param[in,out]   document        A document object.
 */

//C     YAML_DECLARE(void)
//C     yaml_document_delete(yaml_document_t *document);
void  yaml_document_delete(yaml_document_t *document);

/**
 * Get a node of a YAML document.
 *
 * The pointer returned by this function is valid until any of the functions
 * modifying the documents are called.
 *
 * @param[in]       document        A document object.
 * @param[in]       index           The node id.
 *
 * @returns the node objct or @c NULL if @c node_id is out of range.
 */

//C     YAML_DECLARE(yaml_node_t *)
//C     yaml_document_get_node(yaml_document_t *document, int index);
yaml_node_t * yaml_document_get_node(yaml_document_t *document, int index);

/**
 * Get the root of a YAML document node.
 *
 * The root object is the first object added to the document.
 *
 * The pointer returned by this function is valid until any of the functions
 * modifying the documents are called.
 *
 * An empty document produced by the parser signifies the end of a YAML
 * stream.
 *
 * @param[in]       document        A document object.
 *
 * @returns the node object or @c NULL if the document is empty.
 */

//C     YAML_DECLARE(yaml_node_t *)
//C     yaml_document_get_root_node(yaml_document_t *document);
yaml_node_t * yaml_document_get_root_node(yaml_document_t *document);

/**
 * Create a SCALAR node and attach it to the document.
 *
 * The @a style argument may be ignored by the emitter.
 *
 * @param[in,out]   document        A document object.
 * @param[in]       tag             The scalar tag.
 * @param[in]       value           The scalar value.
 * @param[in]       length          The length of the scalar value.
 * @param[in]       style           The scalar style.
 *
 * @returns the node id or @c 0 on error.
 */

//C     YAML_DECLARE(int)
//C     yaml_document_add_scalar(yaml_document_t *document,
//C             yaml_char_t *tag, yaml_char_t *value, int length,
//C             yaml_scalar_style_t style);
int  yaml_document_add_scalar(yaml_document_t *document, yaml_char_t *tag, yaml_char_t *value, int length, yaml_scalar_style_t style);

/**
 * Create a SEQUENCE node and attach it to the document.
 *
 * The @a style argument may be ignored by the emitter.
 *
 * @param[in,out]   document    A document object.
 * @param[in]       tag         The sequence tag.
 * @param[in]       style       The sequence style.
 *
 * @returns the node id or @c 0 on error.
 */

//C     YAML_DECLARE(int)
//C     yaml_document_add_sequence(yaml_document_t *document,
//C             yaml_char_t *tag, yaml_sequence_style_t style);
int  yaml_document_add_sequence(yaml_document_t *document, yaml_char_t *tag, yaml_sequence_style_t style);

/**
 * Create a MAPPING node and attach it to the document.
 *
 * The @a style argument may be ignored by the emitter.
 *
 * @param[in,out]   document    A document object.
 * @param[in]       tag         The sequence tag.
 * @param[in]       style       The sequence style.
 *
 * @returns the node id or @c 0 on error.
 */

//C     YAML_DECLARE(int)
//C     yaml_document_add_mapping(yaml_document_t *document,
//C             yaml_char_t *tag, yaml_mapping_style_t style);
int  yaml_document_add_mapping(yaml_document_t *document, yaml_char_t *tag, yaml_mapping_style_t style);

/**
 * Add an item to a SEQUENCE node.
 *
 * @param[in,out]   document    A document object.
 * @param[in]       sequence    The sequence node id.
 * @param[in]       item        The item node id.
*
 * @returns @c 1 if the function succeeded, @c 0 on error.
 */

//C     YAML_DECLARE(int)
//C     yaml_document_append_sequence_item(yaml_document_t *document,
//C             int sequence, int item);
int  yaml_document_append_sequence_item(yaml_document_t *document, int sequence, int item);

/**
 * Add a pair of a key and a value to a MAPPING node.
 *
 * @param[in,out]   document    A document object.
 * @param[in]       mapping     The mapping node id.
 * @param[in]       key         The key node id.
 * @param[in]       value       The value node id.
*
 * @returns @c 1 if the function succeeded, @c 0 on error.
 */

//C     YAML_DECLARE(int)
//C     yaml_document_append_mapping_pair(yaml_document_t *document,
//C             int mapping, int key, int value);
int  yaml_document_append_mapping_pair(yaml_document_t *document, int mapping, int key, int value);

/** @} */

/**
 * @defgroup parser Parser Definitions
 * @{
 */

/**
 * The prototype of a read handler.
 *
 * The read handler is called when the parser needs to read more bytes from the
 * source.  The handler should write not more than @a size bytes to the @a
 * buffer.  The number of written bytes should be set to the @a length variable.
 *
 * @param[in,out]   data        A pointer to an application data specified by
 *                              yaml_parser_set_input().
 * @param[out]      buffer      The buffer to write the data from the source.
 * @param[in]       size        The size of the buffer.
 * @param[out]      size_read   The actual number of bytes read from the source.
 *
 * @returns On success, the handler should return @c 1.  If the handler failed,
 * the returned value should be @c 0.  On EOF, the handler should set the
 * @a size_read to @c 0 and return @c 1.
 */

//C     typedef int yaml_read_handler_t(void *data, unsigned char *buffer, size_t size,
//C             size_t *size_read);
alias int function(void *data, ubyte *buffer, size_t size, size_t *size_read)yaml_read_handler_t;

/**
 * This structure holds information about a potential simple key.
 */

//C     typedef struct yaml_simple_key_s {
    /** Is a simple key possible? */
//C         int possible;

    /** Is a simple key required? */
//C         int required;

    /** The number of the token. */
//C         size_t token_number;

    /** The position mark. */
//C         yaml_mark_t mark;
//C     } yaml_simple_key_t;
struct yaml_simple_key_s
{
    int possible;
    int required;
    size_t token_number;
    yaml_mark_t mark;
}
alias yaml_simple_key_s yaml_simple_key_t;

/**
 * The states of the parser.
 */
//C     typedef enum yaml_parser_state_e {
    /** Expect STREAM-START. */
//C         YAML_PARSE_STREAM_START_STATE,
    /** Expect the beginning of an implicit document. */
//C         YAML_PARSE_IMPLICIT_DOCUMENT_START_STATE,
    /** Expect DOCUMENT-START. */
//C         YAML_PARSE_DOCUMENT_START_STATE,
    /** Expect the content of a document. */
//C         YAML_PARSE_DOCUMENT_CONTENT_STATE,
    /** Expect DOCUMENT-END. */
//C         YAML_PARSE_DOCUMENT_END_STATE,
    /** Expect a block node. */
//C         YAML_PARSE_BLOCK_NODE_STATE,
    /** Expect a block node or indentless sequence. */
//C         YAML_PARSE_BLOCK_NODE_OR_INDENTLESS_SEQUENCE_STATE,
    /** Expect a flow node. */
//C         YAML_PARSE_FLOW_NODE_STATE,
    /** Expect the first entry of a block sequence. */
//C         YAML_PARSE_BLOCK_SEQUENCE_FIRST_ENTRY_STATE,
    /** Expect an entry of a block sequence. */
//C         YAML_PARSE_BLOCK_SEQUENCE_ENTRY_STATE,
    /** Expect an entry of an indentless sequence. */
//C         YAML_PARSE_INDENTLESS_SEQUENCE_ENTRY_STATE,
    /** Expect the first key of a block mapping. */
//C         YAML_PARSE_BLOCK_MAPPING_FIRST_KEY_STATE,
    /** Expect a block mapping key. */
//C         YAML_PARSE_BLOCK_MAPPING_KEY_STATE,
    /** Expect a block mapping value. */
//C         YAML_PARSE_BLOCK_MAPPING_VALUE_STATE,
    /** Expect the first entry of a flow sequence. */
//C         YAML_PARSE_FLOW_SEQUENCE_FIRST_ENTRY_STATE,
    /** Expect an entry of a flow sequence. */
//C         YAML_PARSE_FLOW_SEQUENCE_ENTRY_STATE,
    /** Expect a key of an ordered mapping. */
//C         YAML_PARSE_FLOW_SEQUENCE_ENTRY_MAPPING_KEY_STATE,
    /** Expect a value of an ordered mapping. */
//C         YAML_PARSE_FLOW_SEQUENCE_ENTRY_MAPPING_VALUE_STATE,
    /** Expect the and of an ordered mapping entry. */
//C         YAML_PARSE_FLOW_SEQUENCE_ENTRY_MAPPING_END_STATE,
    /** Expect the first key of a flow mapping. */
//C         YAML_PARSE_FLOW_MAPPING_FIRST_KEY_STATE,
    /** Expect a key of a flow mapping. */
//C         YAML_PARSE_FLOW_MAPPING_KEY_STATE,
    /** Expect a value of a flow mapping. */
//C         YAML_PARSE_FLOW_MAPPING_VALUE_STATE,
    /** Expect an empty value of a flow mapping. */
//C         YAML_PARSE_FLOW_MAPPING_EMPTY_VALUE_STATE,
    /** Expect nothing. */
//C         YAML_PARSE_END_STATE
//C     } yaml_parser_state_t;
enum yaml_parser_state_e
{
    YAML_PARSE_STREAM_START_STATE,
    YAML_PARSE_IMPLICIT_DOCUMENT_START_STATE,
    YAML_PARSE_DOCUMENT_START_STATE,
    YAML_PARSE_DOCUMENT_CONTENT_STATE,
    YAML_PARSE_DOCUMENT_END_STATE,
    YAML_PARSE_BLOCK_NODE_STATE,
    YAML_PARSE_BLOCK_NODE_OR_INDENTLESS_SEQUENCE_STATE,
    YAML_PARSE_FLOW_NODE_STATE,
    YAML_PARSE_BLOCK_SEQUENCE_FIRST_ENTRY_STATE,
    YAML_PARSE_BLOCK_SEQUENCE_ENTRY_STATE,
    YAML_PARSE_INDENTLESS_SEQUENCE_ENTRY_STATE,
    YAML_PARSE_BLOCK_MAPPING_FIRST_KEY_STATE,
    YAML_PARSE_BLOCK_MAPPING_KEY_STATE,
    YAML_PARSE_BLOCK_MAPPING_VALUE_STATE,
    YAML_PARSE_FLOW_SEQUENCE_FIRST_ENTRY_STATE,
    YAML_PARSE_FLOW_SEQUENCE_ENTRY_STATE,
    YAML_PARSE_FLOW_SEQUENCE_ENTRY_MAPPING_KEY_STATE,
    YAML_PARSE_FLOW_SEQUENCE_ENTRY_MAPPING_VALUE_STATE,
    YAML_PARSE_FLOW_SEQUENCE_ENTRY_MAPPING_END_STATE,
    YAML_PARSE_FLOW_MAPPING_FIRST_KEY_STATE,
    YAML_PARSE_FLOW_MAPPING_KEY_STATE,
    YAML_PARSE_FLOW_MAPPING_VALUE_STATE,
    YAML_PARSE_FLOW_MAPPING_EMPTY_VALUE_STATE,
    YAML_PARSE_END_STATE,
}
alias yaml_parser_state_e yaml_parser_state_t;

/**
 * This structure holds aliases data.
 */

//C     typedef struct yaml_alias_data_s {
    /** The anchor. */
//C         yaml_char_t *anchor;
    /** The node id. */
//C         int index;
    /** The anchor mark. */
//C         yaml_mark_t mark;
//C     } yaml_alias_data_t;
struct yaml_alias_data_s
{
    yaml_char_t *anchor;
    int index;
    yaml_mark_t mark;
}
alias yaml_alias_data_s yaml_alias_data_t;

/**
 * The parser structure.
 *
 * All members are internal.  Manage the structure using the @c yaml_parser_
 * family of functions.
 */

//C     typedef struct yaml_parser_s {

    /**
     * @name Error handling
     * @{
     */

    /** Error type. */
//C         yaml_error_type_t error;
    /** Error description. */
//C         const char *problem;
    /** The byte about which the problem occured. */
//C         size_t problem_offset;
    /** The problematic value (@c -1 is none). */
//C         int problem_value;
    /** The problem position. */
//C         yaml_mark_t problem_mark;
    /** The error context. */
//C         const char *context;
    /** The context position. */
//C         yaml_mark_t context_mark;

    /**
     * @}
     */

    /**
     * @name Reader stuff
     * @{
     */

    /** Read handler. */
//C         yaml_read_handler_t *read_handler;

    /** A pointer for passing to the read handler. */
//C         void *read_handler_data;

    /** Standard (string or file) input data. */
//C         union {
        /** String input data. */
//C             struct {
            /** The string start pointer. */
//C                 const unsigned char *start;
            /** The string end pointer. */
//C                 const unsigned char *end;
            /** The string current position. */
//C                 const unsigned char *current;
//C             } string;
struct _N27
{
    ubyte *start;
    ubyte *end;
    ubyte *current;
}

        /** File input data. */
//C             FILE *file;
//C         } input;
union _N26
{
    _N27 string;
    FILE *file;
}

    /** EOF flag */
//C         int eof;

    /** The working buffer. */
//C         struct {
        /** The beginning of the buffer. */
//C             yaml_char_t *start;
        /** The end of the buffer. */
//C             yaml_char_t *end;
        /** The current position of the buffer. */
//C             yaml_char_t *pointer;
        /** The last filled position of the buffer. */
//C             yaml_char_t *last;
//C         } buffer;
struct _N28
{
    yaml_char_t *start;
    yaml_char_t *end;
    yaml_char_t *pointer;
    yaml_char_t *last;
}

    /* The number of unread characters in the buffer. */
//C         size_t unread;

    /** The raw buffer. */
//C         struct {
        /** The beginning of the buffer. */
//C             unsigned char *start;
        /** The end of the buffer. */
//C             unsigned char *end;
        /** The current position of the buffer. */
//C             unsigned char *pointer;
        /** The last filled position of the buffer. */
//C             unsigned char *last;
//C         } raw_buffer;
struct _N29
{
    ubyte *start;
    ubyte *end;
    ubyte *pointer;
    ubyte *last;
}

    /** The input encoding. */
//C         yaml_encoding_t encoding;

    /** The offset of the current position (in bytes). */
//C         size_t offset;

    /** The mark of the current position. */
//C         yaml_mark_t mark;

    /**
     * @}
     */

    /**
     * @name Scanner stuff
     * @{
     */

    /** Have we started to scan the input stream? */
//C         int stream_start_produced;

    /** Have we reached the end of the input stream? */
//C         int stream_end_produced;

    /** The number of unclosed '[' and '{' indicators. */
//C         int flow_level;

    /** The tokens queue. */
//C         struct {
        /** The beginning of the tokens queue. */
//C             yaml_token_t *start;
        /** The end of the tokens queue. */
//C             yaml_token_t *end;
        /** The head of the tokens queue. */
//C             yaml_token_t *head;
        /** The tail of the tokens queue. */
//C             yaml_token_t *tail;
//C         } tokens;
struct _N30
{
    yaml_token_t *start;
    yaml_token_t *end;
    yaml_token_t *head;
    yaml_token_t *tail;
}

    /** The number of tokens fetched from the queue. */
//C         size_t tokens_parsed;

    /* Does the tokens queue contain a token ready for dequeueing. */
//C         int token_available;

    /** The indentation levels stack. */
//C         struct {
        /** The beginning of the stack. */
//C             int *start;
        /** The end of the stack. */
//C             int *end;
        /** The top of the stack. */
//C             int *top;
//C         } indents;
struct _N31
{
    int *start;
    int *end;
    int *top;
}

    /** The current indentation level. */
//C         int indent;

    /** May a simple key occur at the current position? */
//C         int simple_key_allowed;

    /** The stack of simple keys. */
//C         struct {
        /** The beginning of the stack. */
//C             yaml_simple_key_t *start;
        /** The end of the stack. */
//C             yaml_simple_key_t *end;
        /** The top of the stack. */
//C             yaml_simple_key_t *top;
//C         } simple_keys;
struct _N32
{
    yaml_simple_key_t *start;
    yaml_simple_key_t *end;
    yaml_simple_key_t *top;
}

    /**
     * @}
     */

    /**
     * @name Parser stuff
     * @{
     */

    /** The parser states stack. */
//C         struct {
        /** The beginning of the stack. */
//C             yaml_parser_state_t *start;
        /** The end of the stack. */
//C             yaml_parser_state_t *end;
        /** The top of the stack. */
//C             yaml_parser_state_t *top;
//C         } states;
struct _N33
{
    yaml_parser_state_t *start;
    yaml_parser_state_t *end;
    yaml_parser_state_t *top;
}

    /** The current parser state. */
//C         yaml_parser_state_t state;

    /** The stack of marks. */
//C         struct {
        /** The beginning of the stack. */
//C             yaml_mark_t *start;
        /** The end of the stack. */
//C             yaml_mark_t *end;
        /** The top of the stack. */
//C             yaml_mark_t *top;
//C         } marks;
struct _N34
{
    yaml_mark_t *start;
    yaml_mark_t *end;
    yaml_mark_t *top;
}

    /** The list of TAG directives. */
//C         struct {
        /** The beginning of the list. */
//C             yaml_tag_directive_t *start;
        /** The end of the list. */
//C             yaml_tag_directive_t *end;
        /** The top of the list. */
//C             yaml_tag_directive_t *top;
//C         } tag_directives;
struct _N35
{
    yaml_tag_directive_t *start;
    yaml_tag_directive_t *end;
    yaml_tag_directive_t *top;
}

    /**
     * @}
     */

    /**
     * @name Dumper stuff
     * @{
     */

    /** The alias data. */
//C         struct {
        /** The beginning of the list. */
//C             yaml_alias_data_t *start;
        /** The end of the list. */
//C             yaml_alias_data_t *end;
        /** The top of the list. */
//C             yaml_alias_data_t *top;
//C         } aliases;
struct _N36
{
    yaml_alias_data_t *start;
    yaml_alias_data_t *end;
    yaml_alias_data_t *top;
}

    /** The currently parsed document. */
//C         yaml_document_t *document;

    /**
     * @}
     */

//C     } yaml_parser_t;
struct yaml_parser_s
{
    yaml_error_type_t error;
    char *problem;
    size_t problem_offset;
    int problem_value;
    yaml_mark_t problem_mark;
    char *context;
    yaml_mark_t context_mark;
    int  function(void *data, ubyte *buffer, size_t size, size_t *size_read)read_handler;
    void *read_handler_data;
    _N26 input;
    int eof;
    _N28 buffer;
    size_t unread;
    _N29 raw_buffer;
    yaml_encoding_t encoding;
    size_t offset;
    yaml_mark_t mark;
    int stream_start_produced;
    int stream_end_produced;
    int flow_level;
    _N30 tokens;
    size_t tokens_parsed;
    int token_available;
    _N31 indents;
    int indent;
    int simple_key_allowed;
    _N32 simple_keys;
    _N33 states;
    yaml_parser_state_t state;
    _N34 marks;
    _N35 tag_directives;
    _N36 aliases;
    yaml_document_t *document;
}
alias yaml_parser_s yaml_parser_t;

/**
 * Initialize a parser.
 *
 * This function creates a new parser object.  An application is responsible
 * for destroying the object using the yaml_parser_delete() function.
 *
 * @param[out]      parser  An empty parser object.
 *
 * @returns @c 1 if the function succeeded, @c 0 on error.
 */

//C     YAML_DECLARE(int)
//C     yaml_parser_initialize(yaml_parser_t *parser);
int  yaml_parser_initialize(yaml_parser_t *parser);

/**
 * Destroy a parser.
 *
 * @param[in,out]   parser  A parser object.
 */

//C     YAML_DECLARE(void)
//C     yaml_parser_delete(yaml_parser_t *parser);
void  yaml_parser_delete(yaml_parser_t *parser);

/**
 * Set a string input.
 *
 * Note that the @a input pointer must be valid while the @a parser object
 * exists.  The application is responsible for destroing @a input after
 * destroying the @a parser.
 *
 * @param[in,out]   parser  A parser object.
 * @param[in]       input   A source data.
 * @param[in]       size    The length of the source data in bytes.
 */

//C     YAML_DECLARE(void)
//C     yaml_parser_set_input_string(yaml_parser_t *parser,
//C             const unsigned char *input, size_t size);
void  yaml_parser_set_input_string(yaml_parser_t *parser, ubyte *input, size_t size);

/**
 * Set a file input.
 *
 * @a file should be a file object open for reading.  The application is
 * responsible for closing the @a file.
 *
 * @param[in,out]   parser  A parser object.
 * @param[in]       file    An open file.
 */

//C     YAML_DECLARE(void)
//C     yaml_parser_set_input_file(yaml_parser_t *parser, FILE *file);
void  yaml_parser_set_input_file(yaml_parser_t *parser, FILE *file);

/**
 * Set a generic input handler.
 *
 * @param[in,out]   parser  A parser object.
 * @param[in]       handler A read handler.
 * @param[in]       data    Any application data for passing to the read
 *                          handler.
 */

//C     YAML_DECLARE(void)
//C     yaml_parser_set_input(yaml_parser_t *parser,
//C             yaml_read_handler_t *handler, void *data);
void  yaml_parser_set_input(yaml_parser_t *parser, int  function(void *data, ubyte *buffer, size_t size, size_t *size_read)handler, void *data);

/**
 * Set the source encoding.
 *
 * @param[in,out]   parser      A parser object.
 * @param[in]       encoding    The source encoding.
 */

//C     YAML_DECLARE(void)
//C     yaml_parser_set_encoding(yaml_parser_t *parser, yaml_encoding_t encoding);
void  yaml_parser_set_encoding(yaml_parser_t *parser, yaml_encoding_t encoding);

/**
 * Scan the input stream and produce the next token.
 *
 * Call the function subsequently to produce a sequence of tokens corresponding
 * to the input stream.  The initial token has the type
 * @c YAML_STREAM_START_TOKEN while the ending token has the type
 * @c YAML_STREAM_END_TOKEN.
 *
 * An application is responsible for freeing any buffers associated with the
 * produced token object using the @c yaml_token_delete function.
 *
 * An application must not alternate the calls of yaml_parser_scan() with the
 * calls of yaml_parser_parse() or yaml_parser_load(). Doing this will break
 * the parser.
 *
 * @param[in,out]   parser      A parser object.
 * @param[out]      token       An empty token object.
 *
 * @returns @c 1 if the function succeeded, @c 0 on error.
 */

//C     YAML_DECLARE(int)
//C     yaml_parser_scan(yaml_parser_t *parser, yaml_token_t *token);
int  yaml_parser_scan(yaml_parser_t *parser, yaml_token_t *token);

/**
 * Parse the input stream and produce the next parsing event.
 *
 * Call the function subsequently to produce a sequence of events corresponding
 * to the input stream.  The initial event has the type
 * @c YAML_STREAM_START_EVENT while the ending event has the type
 * @c YAML_STREAM_END_EVENT.
 *
 * An application is responsible for freeing any buffers associated with the
 * produced event object using the yaml_event_delete() function.
 *
 * An application must not alternate the calls of yaml_parser_parse() with the
 * calls of yaml_parser_scan() or yaml_parser_load(). Doing this will break the
 * parser.
 *
 * @param[in,out]   parser      A parser object.
 * @param[out]      event       An empty event object.
 *
 * @returns @c 1 if the function succeeded, @c 0 on error.
 */

//C     YAML_DECLARE(int)
//C     yaml_parser_parse(yaml_parser_t *parser, yaml_event_t *event);
int  yaml_parser_parse(yaml_parser_t *parser, yaml_event_t *event);

/**
 * Parse the input stream and produce the next YAML document.
 *
 * Call this function subsequently to produce a sequence of documents
 * constituting the input stream.
 *
 * If the produced document has no root node, it means that the document
 * end has been reached.
 *
 * An application is responsible for freeing any data associated with the
 * produced document object using the yaml_document_delete() function.
 *
 * An application must not alternate the calls of yaml_parser_load() with the
 * calls of yaml_parser_scan() or yaml_parser_parse(). Doing this will break
 * the parser.
 *
 * @param[in,out]   parser      A parser object.
 * @param[out]      document    An empty document object.
 *
 * @return @c 1 if the function succeeded, @c 0 on error.
 */

//C     YAML_DECLARE(int)
//C     yaml_parser_load(yaml_parser_t *parser, yaml_document_t *document);
int  yaml_parser_load(yaml_parser_t *parser, yaml_document_t *document);

/** @} */

/**
 * @defgroup emitter Emitter Definitions
 * @{
 */

/**
 * The prototype of a write handler.
 *
 * The write handler is called when the emitter needs to flush the accumulated
 * characters to the output.  The handler should write @a size bytes of the
 * @a buffer to the output.
 *
 * @param[in,out]   data        A pointer to an application data specified by
 *                              yaml_emitter_set_output().
 * @param[in]       buffer      The buffer with bytes to be written.
 * @param[in]       size        The size of the buffer.
 *
 * @returns On success, the handler should return @c 1.  If the handler failed,
 * the returned value should be @c 0.
 */

//C     typedef int yaml_write_handler_t(void *data, unsigned char *buffer, size_t size);
alias int function(void *data, ubyte *buffer, size_t size)yaml_write_handler_t;

/** The emitter states. */
//C     typedef enum yaml_emitter_state_e {
    /** Expect STREAM-START. */
//C         YAML_EMIT_STREAM_START_STATE,
    /** Expect the first DOCUMENT-START or STREAM-END. */
//C         YAML_EMIT_FIRST_DOCUMENT_START_STATE,
    /** Expect DOCUMENT-START or STREAM-END. */
//C         YAML_EMIT_DOCUMENT_START_STATE,
    /** Expect the content of a document. */
//C         YAML_EMIT_DOCUMENT_CONTENT_STATE,
    /** Expect DOCUMENT-END. */
//C         YAML_EMIT_DOCUMENT_END_STATE,
    /** Expect the first item of a flow sequence. */
//C         YAML_EMIT_FLOW_SEQUENCE_FIRST_ITEM_STATE,
    /** Expect an item of a flow sequence. */
//C         YAML_EMIT_FLOW_SEQUENCE_ITEM_STATE,
    /** Expect the first key of a flow mapping. */
//C         YAML_EMIT_FLOW_MAPPING_FIRST_KEY_STATE,
    /** Expect a key of a flow mapping. */
//C         YAML_EMIT_FLOW_MAPPING_KEY_STATE,
    /** Expect a value for a simple key of a flow mapping. */
//C         YAML_EMIT_FLOW_MAPPING_SIMPLE_VALUE_STATE,
    /** Expect a value of a flow mapping. */
//C         YAML_EMIT_FLOW_MAPPING_VALUE_STATE,
    /** Expect the first item of a block sequence. */
//C         YAML_EMIT_BLOCK_SEQUENCE_FIRST_ITEM_STATE,
    /** Expect an item of a block sequence. */
//C         YAML_EMIT_BLOCK_SEQUENCE_ITEM_STATE,
    /** Expect the first key of a block mapping. */
//C         YAML_EMIT_BLOCK_MAPPING_FIRST_KEY_STATE,
    /** Expect the key of a block mapping. */
//C         YAML_EMIT_BLOCK_MAPPING_KEY_STATE,
    /** Expect a value for a simple key of a block mapping. */
//C         YAML_EMIT_BLOCK_MAPPING_SIMPLE_VALUE_STATE,
    /** Expect a value of a block mapping. */
//C         YAML_EMIT_BLOCK_MAPPING_VALUE_STATE,
    /** Expect nothing. */
//C         YAML_EMIT_END_STATE
//C     } yaml_emitter_state_t;
enum yaml_emitter_state_e
{
    YAML_EMIT_STREAM_START_STATE,
    YAML_EMIT_FIRST_DOCUMENT_START_STATE,
    YAML_EMIT_DOCUMENT_START_STATE,
    YAML_EMIT_DOCUMENT_CONTENT_STATE,
    YAML_EMIT_DOCUMENT_END_STATE,
    YAML_EMIT_FLOW_SEQUENCE_FIRST_ITEM_STATE,
    YAML_EMIT_FLOW_SEQUENCE_ITEM_STATE,
    YAML_EMIT_FLOW_MAPPING_FIRST_KEY_STATE,
    YAML_EMIT_FLOW_MAPPING_KEY_STATE,
    YAML_EMIT_FLOW_MAPPING_SIMPLE_VALUE_STATE,
    YAML_EMIT_FLOW_MAPPING_VALUE_STATE,
    YAML_EMIT_BLOCK_SEQUENCE_FIRST_ITEM_STATE,
    YAML_EMIT_BLOCK_SEQUENCE_ITEM_STATE,
    YAML_EMIT_BLOCK_MAPPING_FIRST_KEY_STATE,
    YAML_EMIT_BLOCK_MAPPING_KEY_STATE,
    YAML_EMIT_BLOCK_MAPPING_SIMPLE_VALUE_STATE,
    YAML_EMIT_BLOCK_MAPPING_VALUE_STATE,
    YAML_EMIT_END_STATE,
}
alias yaml_emitter_state_e yaml_emitter_state_t;

/**
 * The emitter structure.
 *
 * All members are internal.  Manage the structure using the @c yaml_emitter_
 * family of functions.
 */

//C     typedef struct yaml_emitter_s {

    /**
     * @name Error handling
     * @{
     */

    /** Error type. */
//C         yaml_error_type_t error;
    /** Error description. */
//C         const char *problem;

    /**
     * @}
     */

    /**
     * @name Writer stuff
     * @{
     */

    /** Write handler. */
//C         yaml_write_handler_t *write_handler;

    /** A pointer for passing to the white handler. */
//C         void *write_handler_data;

    /** Standard (string or file) output data. */
//C         union {
        /** String output data. */
//C             struct {
            /** The buffer pointer. */
//C                 unsigned char *buffer;
            /** The buffer size. */
//C                 size_t size;
            /** The number of written bytes. */
//C                 size_t *size_written;
//C             } string;
struct _N38
{
    ubyte *buffer;
    size_t size;
    size_t *size_written;
}

        /** File output data. */
//C             FILE *file;
//C         } output;
union _N37
{
    _N38 string;
    FILE *file;
}

    /** The working buffer. */
//C         struct {
        /** The beginning of the buffer. */
//C             yaml_char_t *start;
        /** The end of the buffer. */
//C             yaml_char_t *end;
        /** The current position of the buffer. */
//C             yaml_char_t *pointer;
        /** The last filled position of the buffer. */
//C             yaml_char_t *last;
//C         } buffer;
struct _N39
{
    yaml_char_t *start;
    yaml_char_t *end;
    yaml_char_t *pointer;
    yaml_char_t *last;
}

    /** The raw buffer. */
//C         struct {
        /** The beginning of the buffer. */
//C             unsigned char *start;
        /** The end of the buffer. */
//C             unsigned char *end;
        /** The current position of the buffer. */
//C             unsigned char *pointer;
        /** The last filled position of the buffer. */
//C             unsigned char *last;
//C         } raw_buffer;
struct _N40
{
    ubyte *start;
    ubyte *end;
    ubyte *pointer;
    ubyte *last;
}

    /** The stream encoding. */
//C         yaml_encoding_t encoding;

    /**
     * @}
     */

    /**
     * @name Emitter stuff
     * @{
     */

    /** If the output is in the canonical style? */
//C         int canonical;
    /** The number of indentation spaces. */
//C         int best_indent;
    /** The preferred width of the output lines. */
//C         int best_width;
    /** Allow unescaped non-ASCII characters? */
//C         int unicode;
    /** The preferred line break. */
//C         yaml_break_t line_break;

    /** The stack of states. */
//C         struct {
        /** The beginning of the stack. */
//C             yaml_emitter_state_t *start;
        /** The end of the stack. */
//C             yaml_emitter_state_t *end;
        /** The top of the stack. */
//C             yaml_emitter_state_t *top;
//C         } states;
struct _N41
{
    yaml_emitter_state_t *start;
    yaml_emitter_state_t *end;
    yaml_emitter_state_t *top;
}

    /** The current emitter state. */
//C         yaml_emitter_state_t state;

    /** The event queue. */
//C         struct {
        /** The beginning of the event queue. */
//C             yaml_event_t *start;
        /** The end of the event queue. */
//C             yaml_event_t *end;
        /** The head of the event queue. */
//C             yaml_event_t *head;
        /** The tail of the event queue. */
//C             yaml_event_t *tail;
//C         } events;
struct _N42
{
    yaml_event_t *start;
    yaml_event_t *end;
    yaml_event_t *head;
    yaml_event_t *tail;
}

    /** The stack of indentation levels. */
//C         struct {
        /** The beginning of the stack. */
//C             int *start;
        /** The end of the stack. */
//C             int *end;
        /** The top of the stack. */
//C             int *top;
//C         } indents;
struct _N43
{
    int *start;
    int *end;
    int *top;
}

    /** The list of tag directives. */
//C         struct {
        /** The beginning of the list. */
//C             yaml_tag_directive_t *start;
        /** The end of the list. */
//C             yaml_tag_directive_t *end;
        /** The top of the list. */
//C             yaml_tag_directive_t *top;
//C         } tag_directives;
struct _N44
{
    yaml_tag_directive_t *start;
    yaml_tag_directive_t *end;
    yaml_tag_directive_t *top;
}

    /** The current indentation level. */
//C         int indent;

    /** The current flow level. */
//C         int flow_level;

    /** Is it the document root context? */
//C         int root_context;
    /** Is it a sequence context? */
//C         int sequence_context;
    /** Is it a mapping context? */
//C         int mapping_context;
    /** Is it a simple mapping key context? */
//C         int simple_key_context;

    /** The current line. */
//C         int line;
    /** The current column. */
//C         int column;
    /** If the last character was a whitespace? */
//C         int whitespace;
    /** If the last character was an indentation character (' ', '-', '?', ':')? */
//C         int indention;
    /** If an explicit document end is required? */
//C         int open_ended;

    /** Anchor analysis. */
//C         struct {
        /** The anchor value. */
//C             yaml_char_t *anchor;
        /** The anchor length. */
//C             size_t anchor_length;
        /** Is it an alias? */
//C             int alias;
//C         } anchor_data;
struct _N45
{
    yaml_char_t *anchor;
    size_t anchor_length;
    int alias_;
}

    /** Tag analysis. */
//C         struct {
        /** The tag handle. */
//C             yaml_char_t *handle;
        /** The tag handle length. */
//C             size_t handle_length;
        /** The tag suffix. */
//C             yaml_char_t *suffix;
        /** The tag suffix length. */
//C             size_t suffix_length;
//C         } tag_data;
struct _N46
{
    yaml_char_t *handle;
    size_t handle_length;
    yaml_char_t *suffix;
    size_t suffix_length;
}

    /** Scalar analysis. */
//C         struct {
        /** The scalar value. */
//C             yaml_char_t *value;
        /** The scalar length. */
//C             size_t length;
        /** Does the scalar contain line breaks? */
//C             int multiline;
        /** Can the scalar be expessed in the flow plain style? */
//C             int flow_plain_allowed;
        /** Can the scalar be expressed in the block plain style? */
//C             int block_plain_allowed;
        /** Can the scalar be expressed in the single quoted style? */
//C             int single_quoted_allowed;
        /** Can the scalar be expressed in the literal or folded styles? */
//C             int block_allowed;
        /** The output style. */
//C             yaml_scalar_style_t style;
//C         } scalar_data;
struct _N47
{
    yaml_char_t *value;
    size_t length;
    int multiline;
    int flow_plain_allowed;
    int block_plain_allowed;
    int single_quoted_allowed;
    int block_allowed;
    yaml_scalar_style_t style;
}

    /**
     * @}
     */

    /**
     * @name Dumper stuff
     * @{
     */

    /** If the stream was already opened? */
//C         int opened;
    /** If the stream was already closed? */
//C         int closed;

    /** The information associated with the document nodes. */
//C         struct {
        /** The number of references. */
//C             int references;
        /** The anchor id. */
//C             int anchor;
        /** If the node has been emitted? */
//C             int serialized;
//C         } *anchors;
struct _N48
{
    int references;
    int anchor;
    int serialized;
}

    /** The last assigned anchor id. */
//C         int last_anchor_id;

    /** The currently emitted document. */
//C         yaml_document_t *document;

    /**
     * @}
     */

//C     } yaml_emitter_t;
struct yaml_emitter_s
{
    yaml_error_type_t error;
    char *problem;
    int  function(void *data, ubyte *buffer, size_t size)write_handler;
    void *write_handler_data;
    _N37 output;
    _N39 buffer;
    _N40 raw_buffer;
    yaml_encoding_t encoding;
    int canonical;
    int best_indent;
    int best_width;
    int unicode;
    yaml_break_t line_break;
    _N41 states;
    yaml_emitter_state_t state;
    _N42 events;
    _N43 indents;
    _N44 tag_directives;
    int indent;
    int flow_level;
    int root_context;
    int sequence_context;
    int mapping_context;
    int simple_key_context;
    int line;
    int column;
    int whitespace;
    int indention;
    int open_ended;
    _N45 anchor_data;
    _N46 tag_data;
    _N47 scalar_data;
    int opened;
    int closed;
    _N48 *anchors;
    int last_anchor_id;
    yaml_document_t *document;
}
alias yaml_emitter_s yaml_emitter_t;

/**
 * Initialize an emitter.
 *
 * This function creates a new emitter object.  An application is responsible
 * for destroying the object using the yaml_emitter_delete() function.
 *
 * @param[out]      emitter     An empty parser object.
 *
 * @returns @c 1 if the function succeeded, @c 0 on error.
 */

//C     YAML_DECLARE(int)
//C     yaml_emitter_initialize(yaml_emitter_t *emitter);
int  yaml_emitter_initialize(yaml_emitter_t *emitter);

/**
 * Destroy an emitter.
 *
 * @param[in,out]   emitter     An emitter object.
 */

//C     YAML_DECLARE(void)
//C     yaml_emitter_delete(yaml_emitter_t *emitter);
void  yaml_emitter_delete(yaml_emitter_t *emitter);

/**
 * Set a string output.
 *
 * The emitter will write the output characters to the @a output buffer of the
 * size @a size.  The emitter will set @a size_written to the number of written
 * bytes.  If the buffer is smaller than required, the emitter produces the
 * YAML_WRITE_ERROR error.
 *
 * @param[in,out]   emitter         An emitter object.
 * @param[in]       output          An output buffer.
 * @param[in]       size            The buffer size.
 * @param[in]       size_written    The pointer to save the number of written
 *                                  bytes.
 */

//C     YAML_DECLARE(void)
//C     yaml_emitter_set_output_string(yaml_emitter_t *emitter,
//C             unsigned char *output, size_t size, size_t *size_written);
void  yaml_emitter_set_output_string(yaml_emitter_t *emitter, ubyte *output, size_t size, size_t *size_written);

/**
 * Set a file output.
 *
 * @a file should be a file object open for writing.  The application is
 * responsible for closing the @a file.
 *
 * @param[in,out]   emitter     An emitter object.
 * @param[in]       file        An open file.
 */

//C     YAML_DECLARE(void)
//C     yaml_emitter_set_output_file(yaml_emitter_t *emitter, FILE *file);
void  yaml_emitter_set_output_file(yaml_emitter_t *emitter, FILE *file);

/**
 * Set a generic output handler.
 *
 * @param[in,out]   emitter     An emitter object.
 * @param[in]       handler     A write handler.
 * @param[in]       data        Any application data for passing to the write
 *                              handler.
 */

//C     YAML_DECLARE(void)
//C     yaml_emitter_set_output(yaml_emitter_t *emitter,
//C             yaml_write_handler_t *handler, void *data);
void  yaml_emitter_set_output(yaml_emitter_t *emitter, int  function(void *data, ubyte *buffer, size_t size)handler, void *data);

/**
 * Set the output encoding.
 *
 * @param[in,out]   emitter     An emitter object.
 * @param[in]       encoding    The output encoding.
 */

//C     YAML_DECLARE(void)
//C     yaml_emitter_set_encoding(yaml_emitter_t *emitter, yaml_encoding_t encoding);
void  yaml_emitter_set_encoding(yaml_emitter_t *emitter, yaml_encoding_t encoding);

/**
 * Set if the output should be in the "canonical" format as in the YAML
 * specification.
 *
 * @param[in,out]   emitter     An emitter object.
 * @param[in]       canonical   If the output is canonical.
 */

//C     YAML_DECLARE(void)
//C     yaml_emitter_set_canonical(yaml_emitter_t *emitter, int canonical);
void  yaml_emitter_set_canonical(yaml_emitter_t *emitter, int canonical);

/**
 * Set the intendation increment.
 *
 * @param[in,out]   emitter     An emitter object.
 * @param[in]       indent      The indentation increment (1 < . < 10).
 */

//C     YAML_DECLARE(void)
//C     yaml_emitter_set_indent(yaml_emitter_t *emitter, int indent);
void  yaml_emitter_set_indent(yaml_emitter_t *emitter, int indent);

/**
 * Set the preferred line width. @c -1 means unlimited.
 *
 * @param[in,out]   emitter     An emitter object.
 * @param[in]       width       The preferred line width.
 */

//C     YAML_DECLARE(void)
//C     yaml_emitter_set_width(yaml_emitter_t *emitter, int width);
void  yaml_emitter_set_width(yaml_emitter_t *emitter, int width);

/**
 * Set if unescaped non-ASCII characters are allowed.
 *
 * @param[in,out]   emitter     An emitter object.
 * @param[in]       unicode     If unescaped Unicode characters are allowed.
 */

//C     YAML_DECLARE(void)
//C     yaml_emitter_set_unicode(yaml_emitter_t *emitter, int unicode);
void  yaml_emitter_set_unicode(yaml_emitter_t *emitter, int unicode);

/**
 * Set the preferred line break.
 *
 * @param[in,out]   emitter     An emitter object.
 * @param[in]       line_break  The preferred line break.
 */

//C     YAML_DECLARE(void)
//C     yaml_emitter_set_break(yaml_emitter_t *emitter, yaml_break_t line_break);
void  yaml_emitter_set_break(yaml_emitter_t *emitter, yaml_break_t line_break);

/**
 * Emit an event.
 *
 * The event object may be generated using the yaml_parser_parse() function.
 * The emitter takes the responsibility for the event object and destroys its
 * content after it is emitted. The event object is destroyed even if the
 * function fails.
 *
 * @param[in,out]   emitter     An emitter object.
 * @param[in,out]   event       An event object.
 *
 * @returns @c 1 if the function succeeded, @c 0 on error.
 */

//C     YAML_DECLARE(int)
//C     yaml_emitter_emit(yaml_emitter_t *emitter, yaml_event_t *event);
int  yaml_emitter_emit(yaml_emitter_t *emitter, yaml_event_t *event);

/**
 * Start a YAML stream.
 *
 * This function should be used before yaml_emitter_dump() is called.
 *
 * @param[in,out]   emitter     An emitter object.
 *
 * @returns @c 1 if the function succeeded, @c 0 on error.
 */

//C     YAML_DECLARE(int)
//C     yaml_emitter_open(yaml_emitter_t *emitter);
int  yaml_emitter_open(yaml_emitter_t *emitter);

/**
 * Finish a YAML stream.
 *
 * This function should be used after yaml_emitter_dump() is called.
 *
 * @param[in,out]   emitter     An emitter object.
 *
 * @returns @c 1 if the function succeeded, @c 0 on error.
 */

//C     YAML_DECLARE(int)
//C     yaml_emitter_close(yaml_emitter_t *emitter);
int  yaml_emitter_close(yaml_emitter_t *emitter);

/**
 * Emit a YAML document.
 *
 * The documen object may be generated using the yaml_parser_load() function
 * or the yaml_document_initialize() function.  The emitter takes the
 * responsibility for the document object and destoys its content after
 * it is emitted. The document object is destroyedeven if the function fails.
 *
 * @param[in,out]   emitter     An emitter object.
 * @param[in,out]   document    A document object.
 *
 * @returns @c 1 if the function succeeded, @c 0 on error.
 */

//C     YAML_DECLARE(int)
//C     yaml_emitter_dump(yaml_emitter_t *emitter, yaml_document_t *document);
int  yaml_emitter_dump(yaml_emitter_t *emitter, yaml_document_t *document);

/**
 * Flush the accumulated characters to the output.
 *
 * @param[in,out]   emitter     An emitter object.
 *
 * @returns @c 1 if the function succeeded, @c 0 on error.
 */

//C     YAML_DECLARE(int)
//C     yaml_emitter_flush(yaml_emitter_t *emitter);
int  yaml_emitter_flush(yaml_emitter_t *emitter);

/** @} */

//C     #ifdef __cplusplus
//C     }
//C     #endif

//C     #endif /* #ifndef YAML_H */

