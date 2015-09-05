// D import file generated from 'yaml\yaml.d'
module yaml.yaml;
import std.c.stdlib;
import std.c.stdio;
import std.c.string;
extern (C) 
{
    char* yaml_get_version_string();
    void yaml_get_version(int* major, int* minor, int* patch);
    alias ubyte yaml_char_t;
    struct yaml_version_directive_s
{
    int major;
    int minor;
}
    alias yaml_version_directive_s yaml_version_directive_t;
    struct yaml_tag_directive_s
{
    yaml_char_t* handle;
    yaml_char_t* prefix;
}
    alias yaml_tag_directive_s yaml_tag_directive_t;
    enum yaml_encoding_e 
{
YAML_ANY_ENCODING,
YAML_UTF8_ENCODING,
YAML_UTF16LE_ENCODING,
YAML_UTF16BE_ENCODING,
}
    alias yaml_encoding_e yaml_encoding_t;
    enum yaml_break_e 
{
YAML_ANY_BREAK,
YAML_CR_BREAK,
YAML_LN_BREAK,
YAML_CRLN_BREAK,
}
    alias yaml_break_e yaml_break_t;
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
    struct yaml_mark_s
{
    size_t index;
    size_t line;
    size_t column;
}
    alias yaml_mark_s yaml_mark_t;
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
    enum yaml_sequence_style_e 
{
YAML_ANY_SEQUENCE_STYLE,
YAML_BLOCK_SEQUENCE_STYLE,
YAML_FLOW_SEQUENCE_STYLE,
}
    alias yaml_sequence_style_e yaml_sequence_style_t;
    enum yaml_mapping_style_e 
{
YAML_ANY_MAPPING_STYLE,
YAML_BLOCK_MAPPING_STYLE,
YAML_FLOW_MAPPING_STYLE,
}
    alias yaml_mapping_style_e yaml_mapping_style_t;
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
    struct _N2
{
    yaml_encoding_t encoding;
}
    struct _N3
{
    yaml_char_t* value;
}
    struct _N4
{
    yaml_char_t* value;
}
    struct _N5
{
    yaml_char_t* handle;
    yaml_char_t* suffix;
}
    struct _N6
{
    yaml_char_t* value;
    size_t length;
    yaml_scalar_style_t style;
}
    struct _N7
{
    int major;
    int minor;
}
    struct _N8
{
    yaml_char_t* handle;
    yaml_char_t* prefix;
}
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
    struct yaml_token_s
{
    yaml_token_type_t type;
    _N1 data;
    yaml_mark_t start_mark;
    yaml_mark_t end_mark;
}
    alias yaml_token_s yaml_token_t;
    void yaml_token_delete(yaml_token_t* token);
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
    struct _N10
{
    yaml_encoding_t encoding;
}
    struct _N12
{
    yaml_tag_directive_t* start;
    yaml_tag_directive_t* end;
}
    struct _N11
{
    yaml_version_directive_t* version_directive;
    _N12 tag_directives;
    int implicit;
}
    struct _N13
{
    int implicit;
}
    struct _N14
{
    yaml_char_t* anchor;
}
    struct _N15
{
    yaml_char_t* anchor;
    yaml_char_t* tag;
    yaml_char_t* value;
    size_t length;
    int plain_implicit;
    int quoted_implicit;
    yaml_scalar_style_t style;
}
    struct _N16
{
    yaml_char_t* anchor;
    yaml_char_t* tag;
    int implicit;
    yaml_sequence_style_t style;
}
    struct _N17
{
    yaml_char_t* anchor;
    yaml_char_t* tag;
    int implicit;
    yaml_mapping_style_t style;
}
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
    struct yaml_event_s
{
    yaml_event_type_t type;
    _N9 data;
    yaml_mark_t start_mark;
    yaml_mark_t end_mark;
}
    alias yaml_event_s yaml_event_t;
    int yaml_stream_start_event_initialize(yaml_event_t* event, yaml_encoding_t encoding);
    int yaml_stream_end_event_initialize(yaml_event_t* event);
    int yaml_document_start_event_initialize(yaml_event_t* event, yaml_version_directive_t* version_directive, yaml_tag_directive_t* tag_directives_start, yaml_tag_directive_t* tag_directives_end, int implicit);
    int yaml_document_end_event_initialize(yaml_event_t* event, int implicit);
    int yaml_alias_event_initialize(yaml_event_t* event, yaml_char_t* anchor);
    int yaml_scalar_event_initialize(yaml_event_t* event, yaml_char_t* anchor, yaml_char_t* tag, yaml_char_t* value, int length, int plain_implicit, int quoted_implicit, yaml_scalar_style_t style);
    int yaml_sequence_start_event_initialize(yaml_event_t* event, yaml_char_t* anchor, yaml_char_t* tag, int implicit, yaml_sequence_style_t style);
    int yaml_sequence_end_event_initialize(yaml_event_t* event);
    int yaml_mapping_start_event_initialize(yaml_event_t* event, yaml_char_t* anchor, yaml_char_t* tag, int implicit, yaml_mapping_style_t style);
    int yaml_mapping_end_event_initialize(yaml_event_t* event);
    void yaml_event_delete(yaml_event_t* event);
    const string YAML_NULL_TAG = "tag:yaml.org,2002:null";

    const string YAML_BOOL_TAG = "tag:yaml.org,2002:bool";

    const string YAML_STR_TAG = "tag:yaml.org,2002:str";

    const string YAML_INT_TAG = "tag:yaml.org,2002:int";

    const string YAML_FLOAT_TAG = "tag:yaml.org,2002:float";

    const string YAML_TIMESTAMP_TAG = "tag:yaml.org,2002:timestamp";

    const string YAML_SEQ_TAG = "tag:yaml.org,2002:seq";

    const string YAML_MAP_TAG = "tag:yaml.org,2002:map";

    alias YAML_STR_TAG YAML_DEFAULT_SCALAR_TAG;
    alias YAML_SEQ_TAG YAML_DEFAULT_SEQUENCE_TAG;
    alias YAML_MAP_TAG YAML_DEFAULT_MAPPING_TAG;
    enum yaml_node_type_e 
{
YAML_NO_NODE,
YAML_SCALAR_NODE,
YAML_SEQUENCE_NODE,
YAML_MAPPING_NODE,
}
    alias yaml_node_type_e yaml_node_type_t;
    alias yaml_node_s yaml_node_t;
    alias int yaml_node_item_t;
    struct yaml_node_pair_s
{
    int key;
    int value;
}
    alias yaml_node_pair_s yaml_node_pair_t;
    struct _N19
{
    yaml_char_t* value;
    size_t length;
    yaml_scalar_style_t style;
}
    struct _N21
{
    yaml_node_item_t* start;
    yaml_node_item_t* end;
    yaml_node_item_t* top;
}
    struct _N20
{
    _N21 items;
    yaml_sequence_style_t style;
}
    struct _N23
{
    yaml_node_pair_t* start;
    yaml_node_pair_t* end;
    yaml_node_pair_t* top;
}
    struct _N22
{
    _N23 pairs;
    yaml_mapping_style_t style;
}
    union _N18
{
    _N19 scalar;
    _N20 sequence;
    _N22 mapping;
}
    struct yaml_node_s
{
    yaml_node_type_t type;
    yaml_char_t* tag;
    _N18 data;
    yaml_mark_t start_mark;
    yaml_mark_t end_mark;
}
    struct _N24
{
    yaml_node_t* start;
    yaml_node_t* end;
    yaml_node_t* top;
}
    struct _N25
{
    yaml_tag_directive_t* start;
    yaml_tag_directive_t* end;
}
    struct yaml_document_s
{
    _N24 nodes;
    yaml_version_directive_t* version_directive;
    _N25 tag_directives;
    int start_implicit;
    int end_implicit;
    yaml_mark_t start_mark;
    yaml_mark_t end_mark;
}
    alias yaml_document_s yaml_document_t;
    int yaml_document_initialize(yaml_document_t* document, yaml_version_directive_t* version_directive, yaml_tag_directive_t* tag_directives_start, yaml_tag_directive_t* tag_directives_end, int start_implicit, int end_implicit);
    void yaml_document_delete(yaml_document_t* document);
    yaml_node_t* yaml_document_get_node(yaml_document_t* document, int index);
    yaml_node_t* yaml_document_get_root_node(yaml_document_t* document);
    int yaml_document_add_scalar(yaml_document_t* document, yaml_char_t* tag, yaml_char_t* value, int length, yaml_scalar_style_t style);
    int yaml_document_add_sequence(yaml_document_t* document, yaml_char_t* tag, yaml_sequence_style_t style);
    int yaml_document_add_mapping(yaml_document_t* document, yaml_char_t* tag, yaml_mapping_style_t style);
    int yaml_document_append_sequence_item(yaml_document_t* document, int sequence, int item);
    int yaml_document_append_mapping_pair(yaml_document_t* document, int mapping, int key, int value);
    alias int function(void* data, ubyte* buffer, size_t size, size_t* size_read) yaml_read_handler_t;
    struct yaml_simple_key_s
{
    int possible;
    int required;
    size_t token_number;
    yaml_mark_t mark;
}
    alias yaml_simple_key_s yaml_simple_key_t;
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
    struct yaml_alias_data_s
{
    yaml_char_t* anchor;
    int index;
    yaml_mark_t mark;
}
    alias yaml_alias_data_s yaml_alias_data_t;
    struct _N27
{
    ubyte* start;
    ubyte* end;
    ubyte* current;
}
    union _N26
{
    _N27 string;
    FILE* file;
}
    struct _N28
{
    yaml_char_t* start;
    yaml_char_t* end;
    yaml_char_t* pointer;
    yaml_char_t* last;
}
    struct _N29
{
    ubyte* start;
    ubyte* end;
    ubyte* pointer;
    ubyte* last;
}
    struct _N30
{
    yaml_token_t* start;
    yaml_token_t* end;
    yaml_token_t* head;
    yaml_token_t* tail;
}
    struct _N31
{
    int* start;
    int* end;
    int* top;
}
    struct _N32
{
    yaml_simple_key_t* start;
    yaml_simple_key_t* end;
    yaml_simple_key_t* top;
}
    struct _N33
{
    yaml_parser_state_t* start;
    yaml_parser_state_t* end;
    yaml_parser_state_t* top;
}
    struct _N34
{
    yaml_mark_t* start;
    yaml_mark_t* end;
    yaml_mark_t* top;
}
    struct _N35
{
    yaml_tag_directive_t* start;
    yaml_tag_directive_t* end;
    yaml_tag_directive_t* top;
}
    struct _N36
{
    yaml_alias_data_t* start;
    yaml_alias_data_t* end;
    yaml_alias_data_t* top;
}
    struct yaml_parser_s
{
    yaml_error_type_t error;
    char* problem;
    size_t problem_offset;
    int problem_value;
    yaml_mark_t problem_mark;
    char* context;
    yaml_mark_t context_mark;
    int function(void* data, ubyte* buffer, size_t size, size_t* size_read) read_handler;
    void* read_handler_data;
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
    yaml_document_t* document;
}
    alias yaml_parser_s yaml_parser_t;
    int yaml_parser_initialize(yaml_parser_t* parser);
    void yaml_parser_delete(yaml_parser_t* parser);
    void yaml_parser_set_input_string(yaml_parser_t* parser, ubyte* input, size_t size);
    void yaml_parser_set_input_file(yaml_parser_t* parser, FILE* file);
    void yaml_parser_set_input(yaml_parser_t* parser, int function(void* data, ubyte* buffer, size_t size, size_t* size_read) handler, void* data);
    void yaml_parser_set_encoding(yaml_parser_t* parser, yaml_encoding_t encoding);
    int yaml_parser_scan(yaml_parser_t* parser, yaml_token_t* token);
    int yaml_parser_parse(yaml_parser_t* parser, yaml_event_t* event);
    int yaml_parser_load(yaml_parser_t* parser, yaml_document_t* document);
    alias int function(void* data, ubyte* buffer, size_t size) yaml_write_handler_t;
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
    struct _N38
{
    ubyte* buffer;
    size_t size;
    size_t* size_written;
}
    union _N37
{
    _N38 string;
    FILE* file;
}
    struct _N39
{
    yaml_char_t* start;
    yaml_char_t* end;
    yaml_char_t* pointer;
    yaml_char_t* last;
}
    struct _N40
{
    ubyte* start;
    ubyte* end;
    ubyte* pointer;
    ubyte* last;
}
    struct _N41
{
    yaml_emitter_state_t* start;
    yaml_emitter_state_t* end;
    yaml_emitter_state_t* top;
}
    struct _N42
{
    yaml_event_t* start;
    yaml_event_t* end;
    yaml_event_t* head;
    yaml_event_t* tail;
}
    struct _N43
{
    int* start;
    int* end;
    int* top;
}
    struct _N44
{
    yaml_tag_directive_t* start;
    yaml_tag_directive_t* end;
    yaml_tag_directive_t* top;
}
    struct _N45
{
    yaml_char_t* anchor;
    size_t anchor_length;
    int alias_;
}
    struct _N46
{
    yaml_char_t* handle;
    size_t handle_length;
    yaml_char_t* suffix;
    size_t suffix_length;
}
    struct _N47
{
    yaml_char_t* value;
    size_t length;
    int multiline;
    int flow_plain_allowed;
    int block_plain_allowed;
    int single_quoted_allowed;
    int block_allowed;
    yaml_scalar_style_t style;
}
    struct _N48
{
    int references;
    int anchor;
    int serialized;
}
    struct yaml_emitter_s
{
    yaml_error_type_t error;
    char* problem;
    int function(void* data, ubyte* buffer, size_t size) write_handler;
    void* write_handler_data;
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
    _N48* anchors;
    int last_anchor_id;
    yaml_document_t* document;
}
    alias yaml_emitter_s yaml_emitter_t;
    int yaml_emitter_initialize(yaml_emitter_t* emitter);
    void yaml_emitter_delete(yaml_emitter_t* emitter);
    void yaml_emitter_set_output_string(yaml_emitter_t* emitter, ubyte* output, size_t size, size_t* size_written);
    void yaml_emitter_set_output_file(yaml_emitter_t* emitter, FILE* file);
    void yaml_emitter_set_output(yaml_emitter_t* emitter, int function(void* data, ubyte* buffer, size_t size) handler, void* data);
    void yaml_emitter_set_encoding(yaml_emitter_t* emitter, yaml_encoding_t encoding);
    void yaml_emitter_set_canonical(yaml_emitter_t* emitter, int canonical);
    void yaml_emitter_set_indent(yaml_emitter_t* emitter, int indent);
    void yaml_emitter_set_width(yaml_emitter_t* emitter, int width);
    void yaml_emitter_set_unicode(yaml_emitter_t* emitter, int unicode);
    void yaml_emitter_set_break(yaml_emitter_t* emitter, yaml_break_t line_break);
    int yaml_emitter_emit(yaml_emitter_t* emitter, yaml_event_t* event);
    int yaml_emitter_open(yaml_emitter_t* emitter);
    int yaml_emitter_close(yaml_emitter_t* emitter);
    int yaml_emitter_dump(yaml_emitter_t* emitter, yaml_document_t* document);
    int yaml_emitter_flush(yaml_emitter_t* emitter);
}
