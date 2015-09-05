// D import file generated from 'dxlib\dxlib.d'
module dxlib.dxlib;
version (Tango)
{
    public import tango.sys.win32.UserGdi;

    import tango.stdc.stdio;
    const int TRUE = 1;

}
else
{
    public import std.c.windows.windows;

    public import std.windows.iunknown;

    import std.c.stdio;
}
version (all)
{
    alias WCHAR TCHAR;
    alias LPWSTR LPTSTR;
    alias LPWSTR PTSTR;
    alias LPCWSTR LPCTSTR;
    alias LPCWSTR PCTSTR;
}
else
{
    alias CHAR TCHAR;
    alias LPSTR LPTSTR;
    alias LPSTR PTSTR;
    alias LPCSTR LPCTSTR;
    alias LPCSTR PCTSTR;
}
version (D_Version2)
{
    mixin("alias const(int)* LPCINT;");
}
else
{
    alias int* LPCINT;
}
alias long LONGLONG;
alias ulong ULONGLONG;
extern (C) 
{
    enum 
{
DXLIB_VERSION = 12368,
}
    const TCHAR[] DXLIB_VERSION_STR = "3.05";

    enum 
{
DIRECTINPUT_VERSION = 1792,
}
    struct D_IDirectDrawSurface7;
    struct D_IDirect3DDevice7;
    enum 
{
D_D3DSHADE_FLAT = 1,
D_D3DSHADE_GOURAUD = 2,
D_D3DSHADE_PHONG = 3,
D_D3DSHADE_FORCE_DWORD = 2147483647,
}
    alias int D_D3DSHADEMODE;
    enum 
{
D_D3DFOG_NONE = 0,
D_D3DFOG_EXP = 1,
D_D3DFOG_EXP2 = 2,
D_D3DFOG_LINEAR = 3,
D_D3DFOG_FORCE_DWORD = 2147483647,
}
    alias int D_D3DFOGMODE;
    enum 
{
D_D3DTADDRESS_WRAP = 1,
D_D3DTADDRESS_MIRROR = 2,
D_D3DTADDRESS_CLAMP = 3,
D_D3DTADDRESS_BORDER = 4,
D_D3DTADDRESS_MIRRORONCE = 5,
D_D3DTADDRESS_FORCE_DWORD = 2147483647,
}
    alias int D_D3DTEXTUREADDRESS;
    enum 
{
D_D3DPT_POINTLIST = 1,
D_D3DPT_LINELIST = 2,
D_D3DPT_LINESTRIP = 3,
D_D3DPT_TRIANGLELIST = 4,
D_D3DPT_TRIANGLESTRIP = 5,
D_D3DPT_TRIANGLEFAN = 6,
D_D3DPT_FORCE_DWORD = 2147483647,
}
    alias int D_D3DPRIMITIVETYPE;
    enum 
{
D_D3DLIGHT_POINT = 1,
D_D3DLIGHT_SPOT = 2,
D_D3DLIGHT_DIRECTIONAL = 3,
D_D3DLIGHT_PARALLELPOINT = 4,
D_D3DLIGHT_GLSPOT = 5,
D_D3DLIGHT_FORCE_DWORD = 2147483647,
}
    alias int D_D3DLIGHTTYPE;
    enum 
{
D_DIK_ESCAPE = 1,
D_DIK_1 = 2,
D_DIK_2 = 3,
D_DIK_3 = 4,
D_DIK_4 = 5,
D_DIK_5 = 6,
D_DIK_6 = 7,
D_DIK_7 = 8,
D_DIK_8 = 9,
D_DIK_9 = 10,
D_DIK_0 = 11,
D_DIK_MINUS = 12,
D_DIK_EQUALS = 13,
D_DIK_BACK = 14,
D_DIK_TAB = 15,
D_DIK_Q = 16,
D_DIK_W = 17,
D_DIK_E = 18,
D_DIK_R = 19,
D_DIK_T = 20,
D_DIK_Y = 21,
D_DIK_U = 22,
D_DIK_I = 23,
D_DIK_O = 24,
D_DIK_P = 25,
D_DIK_LBRACKET = 26,
D_DIK_RBRACKET = 27,
D_DIK_RETURN = 28,
D_DIK_LCONTROL = 29,
D_DIK_A = 30,
D_DIK_S = 31,
D_DIK_D = 32,
D_DIK_F = 33,
D_DIK_G = 34,
D_DIK_H = 35,
D_DIK_J = 36,
D_DIK_K = 37,
D_DIK_L = 38,
D_DIK_SEMICOLON = 39,
D_DIK_APOSTROPHE = 40,
D_DIK_GRAVE = 41,
D_DIK_LSHIFT = 42,
D_DIK_BACKSLASH = 43,
D_DIK_Z = 44,
D_DIK_X = 45,
D_DIK_C = 46,
D_DIK_V = 47,
D_DIK_B = 48,
D_DIK_N = 49,
D_DIK_M = 50,
D_DIK_COMMA = 51,
D_DIK_PERIOD = 52,
D_DIK_SLASH = 53,
D_DIK_RSHIFT = 54,
D_DIK_MULTIPLY = 55,
D_DIK_LMENU = 56,
D_DIK_SPACE = 57,
D_DIK_CAPITAL = 58,
D_DIK_F1 = 59,
D_DIK_F2 = 60,
D_DIK_F3 = 61,
D_DIK_F4 = 62,
D_DIK_F5 = 63,
D_DIK_F6 = 64,
D_DIK_F7 = 65,
D_DIK_F8 = 66,
D_DIK_F9 = 67,
D_DIK_F10 = 68,
D_DIK_NUMLOCK = 69,
D_DIK_SCROLL = 70,
D_DIK_NUMPAD7 = 71,
D_DIK_NUMPAD8 = 72,
D_DIK_NUMPAD9 = 73,
D_DIK_SUBTRACT = 74,
D_DIK_NUMPAD4 = 75,
D_DIK_NUMPAD5 = 76,
D_DIK_NUMPAD6 = 77,
D_DIK_ADD = 78,
D_DIK_NUMPAD1 = 79,
D_DIK_NUMPAD2 = 80,
D_DIK_NUMPAD3 = 81,
D_DIK_NUMPAD0 = 82,
D_DIK_DECIMAL = 83,
D_DIK_OEM_102 = 86,
D_DIK_F11 = 87,
D_DIK_F12 = 88,
D_DIK_F13 = 100,
D_DIK_F14 = 101,
D_DIK_F15 = 102,
D_DIK_KANA = 112,
D_DIK_ABNT_C1 = 115,
D_DIK_CONVERT = 121,
D_DIK_NOCONVERT = 123,
D_DIK_YEN = 125,
D_DIK_ABNT_C2 = 126,
D_DIK_NUMPADEQUALS = 141,
D_DIK_PREVTRACK = 144,
D_DIK_AT = 145,
D_DIK_COLON = 146,
D_DIK_UNDERLINE = 147,
D_DIK_KANJI = 148,
D_DIK_STOP = 149,
D_DIK_AX = 150,
D_DIK_UNLABELED = 151,
D_DIK_NEXTTRACK = 153,
D_DIK_NUMPADENTER = 156,
D_DIK_RCONTROL = 157,
D_DIK_MUTE = 160,
D_DIK_CALCULATOR = 161,
D_DIK_PLAYPAUSE = 162,
D_DIK_MEDIASTOP = 164,
D_DIK_VOLUMEDOWN = 174,
D_DIK_VOLUMEUP = 176,
D_DIK_WEBHOME = 178,
D_DIK_NUMPADCOMMA = 179,
D_DIK_DIVIDE = 181,
D_DIK_SYSRQ = 183,
D_DIK_RMENU = 184,
D_DIK_PAUSE = 197,
D_DIK_HOME = 199,
D_DIK_UP = 200,
D_DIK_PRIOR = 201,
D_DIK_LEFT = 203,
D_DIK_RIGHT = 205,
D_DIK_END = 207,
D_DIK_DOWN = 208,
D_DIK_NEXT = 209,
D_DIK_INSERT = 210,
D_DIK_DELETE = 211,
D_DIK_LWIN = 219,
D_DIK_RWIN = 220,
D_DIK_APPS = 221,
D_DIK_POWER = 222,
D_DIK_SLEEP = 223,
D_DIK_WAKE = 227,
D_DIK_WEBSEARCH = 229,
D_DIK_WEBFAVORITES = 230,
D_DIK_WEBREFRESH = 231,
D_DIK_WEBSTOP = 232,
D_DIK_WEBFORWARD = 233,
D_DIK_WEBBACK = 234,
D_DIK_MYCOMPUTER = 235,
D_DIK_MAIL = 236,
D_DIK_MEDIASELECT = 237,
D_DIK_BACKSPACE = D_DIK_BACK,
D_DIK_NUMPADSTAR = D_DIK_MULTIPLY,
D_DIK_LALT = D_DIK_LMENU,
D_DIK_CAPSLOCK = D_DIK_CAPITAL,
D_DIK_NUMPADMINUS = D_DIK_SUBTRACT,
D_DIK_NUMPADPLUS = D_DIK_ADD,
D_DIK_NUMPADPERIOD = D_DIK_DECIMAL,
D_DIK_NUMPADSLASH = D_DIK_DIVIDE,
D_DIK_RALT = D_DIK_RMENU,
D_DIK_UPARROW = D_DIK_UP,
D_DIK_PGUP = D_DIK_PRIOR,
D_DIK_LEFTARROW = D_DIK_LEFT,
D_DIK_RIGHTARROW = D_DIK_RIGHT,
D_DIK_DOWNARROW = D_DIK_DOWN,
D_DIK_PGDN = D_DIK_NEXT,
}
    struct SIZE
{
    LONG cx;
    LONG cy;
}
    alias SIZE* LPSIZE;
    struct WAVEFORMATEX
{
    WORD wFormatTag;
    WORD nChannels;
    DWORD nSamplesPerSec;
    DWORD nAvgBytesPerSec;
    WORD nBlockAlign;
    WORD wBitsPerSample;
    WORD cbSize;
}
    alias WAVEFORMATEX* PWAVEFORMATEX;
    enum 
{
D_DD_ROP_SPACE = 256 / 32,
}
    struct D_DDSCAPS2
{
    DWORD dwCaps;
    DWORD dwCaps2;
    DWORD dwCaps3;
    union
{
DWORD dwCaps4;
DWORD dwVolumeDepth;
}
}
    struct D_DDSCAPS
{
    DWORD dwCaps;
}
    struct D_DDCAPS
{
    DWORD dwSize;
    DWORD dwCaps;
    DWORD dwCaps2;
    DWORD dwCKeyCaps;
    DWORD dwFXCaps;
    DWORD dwFXAlphaCaps;
    DWORD dwPalCaps;
    DWORD dwSVCaps;
    DWORD dwAlphaBltConstBitDepths;
    DWORD dwAlphaBltPixelBitDepths;
    DWORD dwAlphaBltSurfaceBitDepths;
    DWORD dwAlphaOverlayConstBitDepths;
    DWORD dwAlphaOverlayPixelBitDepths;
    DWORD dwAlphaOverlaySurfaceBitDepths;
    DWORD dwZBufferBitDepths;
    DWORD dwVidMemTotal;
    DWORD dwVidMemFree;
    DWORD dwMaxVisibleOverlays;
    DWORD dwCurrVisibleOverlays;
    DWORD dwNumFourCCCodes;
    DWORD dwAlignBoundarySrc;
    DWORD dwAlignSizeSrc;
    DWORD dwAlignBoundaryDest;
    DWORD dwAlignSizeDest;
    DWORD dwAlignStrideAlign;
    DWORD[D_DD_ROP_SPACE] dwRops;
    D_DDSCAPS ddsOldCaps;
    DWORD dwMinOverlayStretch;
    DWORD dwMaxOverlayStretch;
    DWORD dwMinLiveVideoStretch;
    DWORD dwMaxLiveVideoStretch;
    DWORD dwMinHwCodecStretch;
    DWORD dwMaxHwCodecStretch;
    DWORD dwReserved1;
    DWORD dwReserved2;
    DWORD dwReserved3;
    DWORD dwSVBCaps;
    DWORD dwSVBCKeyCaps;
    DWORD dwSVBFXCaps;
    DWORD[D_DD_ROP_SPACE] dwSVBRops;
    DWORD dwVSBCaps;
    DWORD dwVSBCKeyCaps;
    DWORD dwVSBFXCaps;
    DWORD[D_DD_ROP_SPACE] dwVSBRops;
    DWORD dwSSBCaps;
    DWORD dwSSBCKeyCaps;
    DWORD dwSSBFXCaps;
    DWORD[D_DD_ROP_SPACE] dwSSBRops;
    DWORD dwMaxVideoPorts;
    DWORD dwCurrVideoPorts;
    DWORD dwSVBCaps2;
    DWORD dwNLVBCaps;
    DWORD dwNLVBCaps2;
    DWORD dwNLVBCKeyCaps;
    DWORD dwNLVBFXCaps;
    DWORD[D_DD_ROP_SPACE] dwNLVBRops;
    D_DDSCAPS2 ddsCaps;
}
    struct D_DDPIXELFORMAT
{
    DWORD dwSize;
    DWORD dwFlags;
    DWORD dwFourCC;
    union
{
DWORD dwRGBBitCount;
DWORD dwYUVBitCount;
DWORD dwZBufferBitDepth;
DWORD dwAlphaBitDepth;
DWORD dwLuminanceBitCount;
DWORD dwBumpBitCount;
DWORD dwPrivateFormatBitCount;
}
    union
{
DWORD dwRBitMask;
DWORD dwYBitMask;
DWORD dwStencilBitDepth;
DWORD dwLuminanceBitMask;
DWORD dwBumpDuBitMask;
DWORD dwOperations;
}
    union
{
DWORD dwGBitMask;
DWORD dwUBitMask;
DWORD dwZBitMask;
DWORD dwBumpDvBitMask;
struct _MSTypes
{
    WORD wFlipMSTypes;
    WORD wBltMSTypes;
}
_MSTypes MultiSampleCaps;
}
    union
{
DWORD dwBBitMask;
DWORD dwVBitMask;
DWORD dwStencilBitMask;
DWORD dwBumpLuminanceBitMask;
}
    union
{
DWORD dwRGBAlphaBitMask;
DWORD dwYUVAlphaBitMask;
DWORD dwLuminanceAlphaBitMask;
DWORD dwRGBZBitMask;
DWORD dwYUVZBitMask;
}
}
    version (D_Version2)
{
    mixin("alias const(D_DDPIXELFORMAT)* LPCD_DDPIXELFORMAT;");
}
else
{
    alias D_DDPIXELFORMAT* LPCD_DDPIXELFORMAT;
}
    const double PHI = 0x1.921fb54442d18468p+1;

    const float PHI_F = 0x1.921fb54442d18468p+1F;

    const double TWO_PHI = 0x1.921fb54442d18468p+1 * 2;

    const float TWO_PHI_F = 0x1.921fb54442d18468p+1F * 2F;

    alias char DX_CHAR;
    enum 
{
MAX_IMAGE_NUM = 32768,
MAX_2DSURFACE_NUM = 32768,
MAX_3DSURFACE_NUM = 65536,
MAX_IMAGE_DIVNUM = 64,
MAX_SURFACE_NUM = 65536,
MAX_SOFTIMAGE_NUM = 8192,
MAX_SOUND_NUM = 32768,
MAX_SOFTSOUND_NUM = 8192,
MAX_MUSIC_NUM = 256,
MAX_MOVIE_NUM = 100,
MAX_MASK_NUM = 512,
MAX_FONT_NUM = 40,
MAX_INPUT_NUM = 256,
MAX_SOCKET_NUM = 8192,
MAX_LIGHT_NUM = 4096,
MAX_SHADER_NUM = 4096,
MAX_VERTEX_BUFFER_NUM = 16384,
MAX_INDEX_BUFFER_NUM = 16384,
MAX_JOYPAD_NUM = 16,
MAX_EVENTPROCESS_NUM = 5,
DEFAULT_SCREEN_SIZE_X = 640,
DEFAULT_SCREEN_SIZE_Y = 480,
DEFAULT_COLOR_BITDEPTH = 16,
}
    const float DEFAULT_FOV = 60F * 0x1.921fb54442d18468p+1F / 180F;

    const float DEFAULT_TAN_FOV_HALF = 0x1.279a74590331c4dp-1F;

    const float DEFAULT_NEAR = 0F;

    const float DEFAULT_FAR = 20000F;

    enum 
{
DX_FONTTYPE_NORMAL = 0,
DX_FONTTYPE_EDGE = 1,
DX_FONTTYPE_ANTIALIASING = 2,
DX_FONTTYPE_ANTIALIASING_EDGE = 3,
}
    enum 
{
DEFAULT_FONT_SIZE = 16,
DEFAULT_FONT_THINCK = 6,
DEFAULT_FONT_TYPE = DX_FONTTYPE_NORMAL,
DEFAULT_FONT_EDGESIZE = 1,
FONT_CACHE_MAXNUM = 2024,
FONT_CACHE_MEMORYSIZE = 327680,
FONT_CACHE_MAX_YLENGTH = 16384,
MAX_USERIMAGEREAD_FUNCNUM = 10,
}
    enum 
{
DX_HANDLEINDEX_MASK = 65535,
DX_HANDLECHECKBIT_MASK = 134152192,
DX_HANDLECHECKBIT_ADDRESS = 16,
DX_HANDLETYPE_MASK = 2013265920,
DX_HANDLEERROR_MASK = -2147483648u,
DX_HANDLEERROR_OR_TYPE_MASK = -134217728u,
}
    enum 
{
DX_HANDLETYPE_GRAPH = 134217728,
DX_HANDLETYPE_SOUND = 268435456,
DX_HANDLETYPE_MOVIE = 402653184,
DX_HANDLETYPE_FONT = 536870912,
DX_HANDLETYPE_GMASK = 671088640,
DX_HANDLETYPE_NETWORK = 805306368,
DX_HANDLETYPE_KEYINPUT = 939524096,
DX_HANDLETYPE_MUSIC = 1073741824,
DX_HANDLETYPE_LIGHT = 1207959552,
DX_HANDLETYPE_MODEL = 1342177280,
DX_HANDLETYPE_SOFTIMAGE = 1476395008,
DX_HANDLETYPE_SHADER = 1610612736,
DX_HANDLETYPE_SOFTSOUND = 1744830464,
DX_HANDLETYPE_VERTEX_BUFFER = 1879048192,
DX_HANDLETYPE_INDEX_BUFFER = 2013265920,
}
    enum 
{
DX_WINDOWSVERSION_31 = 0,
DX_WINDOWSVERSION_95 = 1,
DX_WINDOWSVERSION_98 = 2,
DX_WINDOWSVERSION_ME = 3,
DX_WINDOWSVERSION_NT31 = 260,
DX_WINDOWSVERSION_NT40 = 261,
DX_WINDOWSVERSION_2000 = 262,
DX_WINDOWSVERSION_XP = 263,
DX_WINDOWSVERSION_VISTA = 264,
DX_WINDOWSVERSION_7 = 265,
DX_WINDOWSVERSION_NT_TYPE = 256,
}
    enum 
{
DX_DIRECTXVERSION_NON = 0,
DX_DIRECTXVERSION_1 = 65536,
DX_DIRECTXVERSION_2 = 131072,
DX_DIRECTXVERSION_3 = 196608,
DX_DIRECTXVERSION_4 = 262144,
DX_DIRECTXVERSION_5 = 327680,
DX_DIRECTXVERSION_6 = 393216,
DX_DIRECTXVERSION_6_1 = 393472,
DX_DIRECTXVERSION_7 = 458752,
DX_DIRECTXVERSION_8 = 524288,
DX_DIRECTXVERSION_8_1 = 524544,
}
    enum 
{
DX_CHARSET_DEFAULT = 0,
DX_CHARSET_SHFTJIS = 1,
DX_CHARSET_HANGEUL = 2,
DX_CHARSET_BIG5 = 3,
DX_CHARSET_GB2312 = 4,
}
    enum 
{
DX_MIDIMODE_MCI = 0,
DX_MIDIMODE_DM = 1,
}
    enum 
{
DX_DRAWMODE_NEAREST = 0,
DX_DRAWMODE_BILINEAR = 1,
DX_DRAWMODE_ANISOTROPIC = 2,
DX_DRAWMODE_OTHER = 3,
}
    enum 
{
DX_BLENDMODE_NOBLEND = 0,
DX_BLENDMODE_ALPHA = 1,
DX_BLENDMODE_ADD = 2,
DX_BLENDMODE_SUB = 3,
DX_BLENDMODE_MUL = 4,
DX_BLENDMODE_SUB2 = 5,
DX_BLENDMODE_XOR = 6,
DX_BLENDMODE_DESTCOLOR = 8,
DX_BLENDMODE_INVDESTCOLOR = 9,
DX_BLENDMODE_INVSRC = 10,
DX_BLENDMODE_MULA = 11,
DX_BLENDMODE_ALPHA_X4 = 12,
DX_BLENDMODE_ADD_X4 = 13,
}
    enum 
{
DX_CULLING_NONE = 0,
DX_CULLING_LEFT = 1,
DX_CULLING_RIGHT = 2,
}
    enum 
{
DX_SCREEN_FRONT = -4u,
DX_SCREEN_BACK = -2u,
DX_SCREEN_WORK = -3u,
DX_SCREEN_TEMPFRONT = -5u,
DX_NONE_GRAPH = -5u,
}
    enum 
{
DX_SHAVEDMODE_NONE = 0,
DX_SHAVEDMODE_DITHER = 1,
DX_SHAVEDMODE_DIFFUS = 2,
}
    enum 
{
DX_IMAGESAVETYPE_BMP = 0,
DX_IMAGESAVETYPE_JPEG = 1,
DX_IMAGESAVETYPE_PNG = 2,
}
    enum 
{
DX_PLAYTYPE_LOOPBIT = 2,
DX_PLAYTYPE_BACKBIT = 1,
DX_PLAYTYPE_NORMAL = 0,
DX_PLAYTYPE_BACK = DX_PLAYTYPE_BACKBIT,
DX_PLAYTYPE_LOOP = DX_PLAYTYPE_LOOPBIT | DX_PLAYTYPE_BACKBIT,
}
    enum 
{
DX_MOVIEPLAYTYPE_BCANCEL = 0,
DX_MOVIEPLAYTYPE_NORMAL = 1,
}
    enum 
{
DX_SOUNDTYPE_NORMAL = 0,
DX_SOUNDTYPE_STREAMSTYLE = 1,
}
    enum 
{
DX_SOUNDDATATYPE_MEMNOPRESS = 0,
DX_SOUNDDATATYPE_MEMNOPRESS_PLUS = 1,
DX_SOUNDDATATYPE_MEMPRESS = 2,
DX_SOUNDDATATYPE_FILE = 3,
}
    enum 
{
DX_READSOUNDFUNCTION_PCM = 1,
DX_READSOUNDFUNCTION_ACM = 2,
DX_READSOUNDFUNCTION_OGG = 4,
DX_READSOUNDFUNCTION_MP3 = 8,
DX_READSOUNDFUNCTION_DSMP3 = 16,
}
    enum 
{
DX_MASKTRANS_WHITE = 0,
DX_MASKTRANS_BLACK = 1,
DX_MASKTRANS_NONE = 2,
}
    enum 
{
DX_ZWRITE_MASK = 0,
DX_ZWRITE_CLEAR = 1,
}
    enum 
{
DX_CMP_NEVER = 1,
DX_CMP_LESS = 2,
DX_CMP_EQUAL = 3,
DX_CMP_LESSEQUAL = 4,
DX_CMP_GREATER = 5,
DX_CMP_NOTEQUAL = 6,
DX_CMP_GREATEREQUAL = 7,
DX_CMP_ALWAYS = 8,
DX_ZCMP_DEFAULT = DX_CMP_LESSEQUAL,
DX_ZCMP_REVERSE = DX_CMP_GREATEREQUAL,
}
    enum 
{
DX_SHADEMODE_FLAT = D_D3DSHADE_FLAT,
DX_SHADEMODE_GOURAUD = D_D3DSHADE_GOURAUD,
}
    enum 
{
DX_FOGMODE_NONE = D_D3DFOG_NONE,
DX_FOGMODE_EXP = D_D3DFOG_EXP,
DX_FOGMODE_EXP2 = D_D3DFOG_EXP2,
DX_FOGMODE_LINEAR = D_D3DFOG_LINEAR,
}
    enum 
{
DX_MATERIAL_TYPE_NORMAL = 0,
DX_MATERIAL_TYPE_TOON = 1,
DX_MATERIAL_TYPE_TOON_2 = 2,
}
    enum 
{
DX_MATERIAL_BLENDTYPE_TRANSLUCENT = 0,
DX_MATERIAL_BLENDTYPE_ADDITIVE = 1,
DX_MATERIAL_BLENDTYPE_MODULATE = 2,
}
    enum 
{
DX_TEXADDRESS_WRAP = D_D3DTADDRESS_WRAP,
DX_TEXADDRESS_MIRROR = D_D3DTADDRESS_MIRROR,
DX_TEXADDRESS_CLAMP = D_D3DTADDRESS_CLAMP,
DX_TEXADDRESS_BORDER = D_D3DTADDRESS_BORDER,
}
    enum 
{
DX_VERTEX_TYPE_NORMAL_3D = 0,
}
    enum 
{
DX_INDEX_TYPE_16BIT = 0,
}
    enum 
{
DX_PRIMTYPE_POINTLIST = D_D3DPT_POINTLIST,
DX_PRIMTYPE_LINELIST = D_D3DPT_LINELIST,
DX_PRIMTYPE_LINESTRIP = D_D3DPT_LINESTRIP,
DX_PRIMTYPE_TRIANGLELIST = D_D3DPT_TRIANGLELIST,
DX_PRIMTYPE_TRIANGLESTRIP = D_D3DPT_TRIANGLESTRIP,
DX_PRIMTYPE_TRIANGLEFAN = D_D3DPT_TRIANGLEFAN,
}
    enum 
{
DX_LIGHTTYPE_D3DLIGHT_POINT = D_D3DLIGHT_POINT,
DX_LIGHTTYPE_D3DLIGHT_SPOT = D_D3DLIGHT_SPOT,
DX_LIGHTTYPE_D3DLIGHT_DIRECTIONAL = D_D3DLIGHT_DIRECTIONAL,
DX_LIGHTTYPE_D3DLIGHT_FORCEDWORD = D_D3DLIGHT_FORCE_DWORD,
DX_LIGHTTYPE_POINT = D_D3DLIGHT_POINT,
DX_LIGHTTYPE_SPOT = D_D3DLIGHT_SPOT,
DX_LIGHTTYPE_DIRECTIONAL = D_D3DLIGHT_DIRECTIONAL,
}
    enum 
{
DX_GRAPHICSIMAGE_FORMAT_3D_RGB16 = 0,
DX_GRAPHICSIMAGE_FORMAT_3D_RGB32 = 1,
DX_GRAPHICSIMAGE_FORMAT_3D_ALPHA_RGB16 = 2,
DX_GRAPHICSIMAGE_FORMAT_3D_ALPHA_RGB32 = 3,
DX_GRAPHICSIMAGE_FORMAT_3D_ALPHATEST_RGB16 = 4,
DX_GRAPHICSIMAGE_FORMAT_3D_ALPHATEST_RGB32 = 5,
DX_GRAPHICSIMAGE_FORMAT_3D_DXT1 = 6,
DX_GRAPHICSIMAGE_FORMAT_3D_DXT2 = 7,
DX_GRAPHICSIMAGE_FORMAT_3D_DXT3 = 8,
DX_GRAPHICSIMAGE_FORMAT_3D_DXT4 = 9,
DX_GRAPHICSIMAGE_FORMAT_3D_DXT5 = 10,
DX_GRAPHICSIMAGE_FORMAT_3D_DRAWVALID_RGB16 = 11,
DX_GRAPHICSIMAGE_FORMAT_3D_DRAWVALID_RGB32 = 12,
DX_GRAPHICSIMAGE_FORMAT_3D_DRAWVALID_ALPHA_RGB32 = 13,
DX_GRAPHICSIMAGE_FORMAT_3D_NUM = 14,
DX_GRAPHICSIMAGE_FORMAT_2D = 14,
DX_GRAPHICSIMAGE_FORMAT_R5G6B5 = 15,
DX_GRAPHICSIMAGE_FORMAT_X8A8R5G6B5 = 16,
DX_GRAPHICSIMAGE_FORMAT_X8R8G8B8 = 17,
DX_GRAPHICSIMAGE_FORMAT_A8R8G8B8 = 18,
DX_GRAPHICSIMAGE_FORMAT_NUM = 19,
}
    enum 
{
DX_BASEIMAGE_FORMAT_NORMAL = 0,
DX_BASEIMAGE_FORMAT_DXT1 = 1,
DX_BASEIMAGE_FORMAT_DXT2 = 2,
DX_BASEIMAGE_FORMAT_DXT3 = 3,
DX_BASEIMAGE_FORMAT_DXT4 = 4,
DX_BASEIMAGE_FORMAT_DXT5 = 5,
}
    enum 
{
TOOLBUTTON_STATE_ENABLE = 0,
TOOLBUTTON_STATE_PRESSED = 1,
TOOLBUTTON_STATE_DISABLE = 2,
TOOLBUTTON_STATE_PRESSED_DISABLE = 3,
TOOLBUTTON_STATE_NUM = 4,
}
    enum 
{
TOOLBUTTON_TYPE_NORMAL = 0,
TOOLBUTTON_TYPE_CHECK = 1,
TOOLBUTTON_TYPE_GROUP = 2,
TOOLBUTTON_TYPE_SEP = 3,
TOOLBUTTON_TYPE_NUM = 4,
}
    enum 
{
MENUITEM_IDTOP = -1414812757u,
}
    enum 
{
MENUITEM_ADD_CHILD = 0,
MENUITEM_ADD_INSERT = 1,
}
    enum 
{
MENUITEM_MARK_NONE = 0,
MENUITEM_MARK_CHECK = 1,
MENUITEM_MARK_RADIO = 2,
}
    enum 
{
DX_NUMMODE_10 = 0,
DX_NUMMODE_16 = 1,
DX_STRMODE_NOT0 = 2,
DX_STRMODE_USE0 = 3,
}
    enum 
{
DX_CHECKINPUT_KEY = 1,
DX_CHECKINPUT_PAD = 2,
DX_CHECKINPUT_MOUSE = 4,
DX_CHECKINPUT_ALL = DX_CHECKINPUT_KEY | DX_CHECKINPUT_PAD | DX_CHECKINPUT_MOUSE,
}
    enum 
{
DX_INPUT_KEY_PAD1 = 4097,
DX_INPUT_PAD1 = 1,
DX_INPUT_PAD2 = 2,
DX_INPUT_PAD3 = 3,
DX_INPUT_PAD4 = 4,
DX_INPUT_PAD5 = 5,
DX_INPUT_PAD6 = 6,
DX_INPUT_PAD7 = 7,
DX_INPUT_PAD8 = 8,
DX_INPUT_PAD9 = 9,
DX_INPUT_PAD10 = 10,
DX_INPUT_PAD11 = 11,
DX_INPUT_PAD12 = 12,
DX_INPUT_PAD13 = 13,
DX_INPUT_PAD14 = 14,
DX_INPUT_PAD15 = 15,
DX_INPUT_PAD16 = 16,
DX_INPUT_KEY = 4096,
}
    enum 
{
DX_MOVIESURFACE_NORMAL = 0,
DX_MOVIESURFACE_OVERLAY = 1,
DX_MOVIESURFACE_FULLCOLOR = 2,
}
    enum 
{
PAD_INPUT_DOWN = 1,
PAD_INPUT_LEFT = 2,
PAD_INPUT_RIGHT = 4,
PAD_INPUT_UP = 8,
PAD_INPUT_A = 16,
PAD_INPUT_B = 32,
PAD_INPUT_C = 64,
PAD_INPUT_X = 128,
PAD_INPUT_Y = 256,
PAD_INPUT_Z = 512,
PAD_INPUT_L = 1024,
PAD_INPUT_R = 2048,
PAD_INPUT_START = 4096,
PAD_INPUT_M = 8192,
PAD_INPUT_D = 16384,
PAD_INPUT_F = 32768,
PAD_INPUT_G = 65536,
PAD_INPUT_H = 131072,
PAD_INPUT_I = 262144,
PAD_INPUT_J = 524288,
PAD_INPUT_K = 1048576,
PAD_INPUT_LL = 2097152,
PAD_INPUT_N = 4194304,
PAD_INPUT_O = 8388608,
PAD_INPUT_P = 16777216,
PAD_INPUT_RR = 33554432,
PAD_INPUT_S = 67108864,
PAD_INPUT_T = 134217728,
PAD_INPUT_U = 268435456,
PAD_INPUT_V = 536870912,
PAD_INPUT_W = 1073741824,
PAD_INPUT_XX = -2147483648u,
}
    enum 
{
PAD_INPUT_1 = 16,
PAD_INPUT_2 = 32,
PAD_INPUT_3 = 64,
PAD_INPUT_4 = 128,
PAD_INPUT_5 = 256,
PAD_INPUT_6 = 512,
PAD_INPUT_7 = 1024,
PAD_INPUT_8 = 2048,
PAD_INPUT_9 = 4096,
PAD_INPUT_10 = 8192,
PAD_INPUT_11 = 16384,
PAD_INPUT_12 = 32768,
PAD_INPUT_13 = 65536,
PAD_INPUT_14 = 131072,
PAD_INPUT_15 = 262144,
PAD_INPUT_16 = 524288,
PAD_INPUT_17 = 1048576,
PAD_INPUT_18 = 2097152,
PAD_INPUT_19 = 4194304,
PAD_INPUT_20 = 8388608,
PAD_INPUT_21 = 16777216,
PAD_INPUT_22 = 33554432,
PAD_INPUT_23 = 67108864,
PAD_INPUT_24 = 134217728,
PAD_INPUT_25 = 268435456,
PAD_INPUT_26 = 536870912,
PAD_INPUT_27 = 1073741824,
PAD_INPUT_28 = -2147483648u,
}
    enum 
{
MOUSE_INPUT_LEFT = 1,
MOUSE_INPUT_RIGHT = 2,
MOUSE_INPUT_MIDDLE = 4,
MOUSE_INPUT_1 = 1,
MOUSE_INPUT_2 = 2,
MOUSE_INPUT_3 = 4,
MOUSE_INPUT_4 = 8,
MOUSE_INPUT_5 = 16,
MOUSE_INPUT_6 = 32,
MOUSE_INPUT_7 = 64,
MOUSE_INPUT_8 = 128,
}
    enum 
{
KEY_INPUT_BACK = D_DIK_BACK,
KEY_INPUT_TAB = D_DIK_TAB,
KEY_INPUT_RETURN = D_DIK_RETURN,
KEY_INPUT_LSHIFT = D_DIK_LSHIFT,
KEY_INPUT_RSHIFT = D_DIK_RSHIFT,
KEY_INPUT_LCONTROL = D_DIK_LCONTROL,
KEY_INPUT_RCONTROL = D_DIK_RCONTROL,
KEY_INPUT_ESCAPE = D_DIK_ESCAPE,
KEY_INPUT_SPACE = D_DIK_SPACE,
KEY_INPUT_PGUP = D_DIK_PGUP,
KEY_INPUT_PGDN = D_DIK_PGDN,
KEY_INPUT_END = D_DIK_END,
KEY_INPUT_HOME = D_DIK_HOME,
KEY_INPUT_LEFT = D_DIK_LEFT,
KEY_INPUT_UP = D_DIK_UP,
KEY_INPUT_RIGHT = D_DIK_RIGHT,
KEY_INPUT_DOWN = D_DIK_DOWN,
KEY_INPUT_INSERT = D_DIK_INSERT,
KEY_INPUT_DELETE = D_DIK_DELETE,
KEY_INPUT_MINUS = D_DIK_MINUS,
KEY_INPUT_YEN = D_DIK_YEN,
KEY_INPUT_PREVTRACK = D_DIK_PREVTRACK,
KEY_INPUT_PERIOD = D_DIK_PERIOD,
KEY_INPUT_SLASH = D_DIK_SLASH,
KEY_INPUT_LALT = D_DIK_LALT,
KEY_INPUT_RALT = D_DIK_RALT,
KEY_INPUT_SCROLL = D_DIK_SCROLL,
KEY_INPUT_SEMICOLON = D_DIK_SEMICOLON,
KEY_INPUT_COLON = D_DIK_COLON,
KEY_INPUT_LBRACKET = D_DIK_LBRACKET,
KEY_INPUT_RBRACKET = D_DIK_RBRACKET,
KEY_INPUT_AT = D_DIK_AT,
KEY_INPUT_BACKSLASH = D_DIK_BACKSLASH,
KEY_INPUT_COMMA = D_DIK_COMMA,
KEY_INPUT_KANJI = D_DIK_KANJI,
KEY_INPUT_CONVERT = D_DIK_CONVERT,
KEY_INPUT_NOCONVERT = D_DIK_NOCONVERT,
KEY_INPUT_KANA = D_DIK_KANA,
KEY_INPUT_APPS = D_DIK_APPS,
KEY_INPUT_CAPSLOCK = D_DIK_CAPSLOCK,
KEY_INPUT_SYSRQ = D_DIK_SYSRQ,
KEY_INPUT_PAUSE = D_DIK_PAUSE,
KEY_INPUT_LWIN = D_DIK_LWIN,
KEY_INPUT_RWIN = D_DIK_RWIN,
KEY_INPUT_NUMLOCK = D_DIK_NUMLOCK,
KEY_INPUT_NUMPAD0 = D_DIK_NUMPAD0,
KEY_INPUT_NUMPAD1 = D_DIK_NUMPAD1,
KEY_INPUT_NUMPAD2 = D_DIK_NUMPAD2,
KEY_INPUT_NUMPAD3 = D_DIK_NUMPAD3,
KEY_INPUT_NUMPAD4 = D_DIK_NUMPAD4,
KEY_INPUT_NUMPAD5 = D_DIK_NUMPAD5,
KEY_INPUT_NUMPAD6 = D_DIK_NUMPAD6,
KEY_INPUT_NUMPAD7 = D_DIK_NUMPAD7,
KEY_INPUT_NUMPAD8 = D_DIK_NUMPAD8,
KEY_INPUT_NUMPAD9 = D_DIK_NUMPAD9,
KEY_INPUT_MULTIPLY = D_DIK_MULTIPLY,
KEY_INPUT_ADD = D_DIK_ADD,
KEY_INPUT_SUBTRACT = D_DIK_SUBTRACT,
KEY_INPUT_DECIMAL = D_DIK_DECIMAL,
KEY_INPUT_DIVIDE = D_DIK_DIVIDE,
KEY_INPUT_NUMPADENTER = D_DIK_NUMPADENTER,
KEY_INPUT_F1 = D_DIK_F1,
KEY_INPUT_F2 = D_DIK_F2,
KEY_INPUT_F3 = D_DIK_F3,
KEY_INPUT_F4 = D_DIK_F4,
KEY_INPUT_F5 = D_DIK_F5,
KEY_INPUT_F6 = D_DIK_F6,
KEY_INPUT_F7 = D_DIK_F7,
KEY_INPUT_F8 = D_DIK_F8,
KEY_INPUT_F9 = D_DIK_F9,
KEY_INPUT_F10 = D_DIK_F10,
KEY_INPUT_F11 = D_DIK_F11,
KEY_INPUT_F12 = D_DIK_F12,
KEY_INPUT_A = D_DIK_A,
KEY_INPUT_B = D_DIK_B,
KEY_INPUT_C = D_DIK_C,
KEY_INPUT_D = D_DIK_D,
KEY_INPUT_E = D_DIK_E,
KEY_INPUT_F = D_DIK_F,
KEY_INPUT_G = D_DIK_G,
KEY_INPUT_H = D_DIK_H,
KEY_INPUT_I = D_DIK_I,
KEY_INPUT_J = D_DIK_J,
KEY_INPUT_K = D_DIK_K,
KEY_INPUT_L = D_DIK_L,
KEY_INPUT_M = D_DIK_M,
KEY_INPUT_N = D_DIK_N,
KEY_INPUT_O = D_DIK_O,
KEY_INPUT_P = D_DIK_P,
KEY_INPUT_Q = D_DIK_Q,
KEY_INPUT_R = D_DIK_R,
KEY_INPUT_S = D_DIK_S,
KEY_INPUT_T = D_DIK_T,
KEY_INPUT_U = D_DIK_U,
KEY_INPUT_V = D_DIK_V,
KEY_INPUT_W = D_DIK_W,
KEY_INPUT_X = D_DIK_X,
KEY_INPUT_Y = D_DIK_Y,
KEY_INPUT_Z = D_DIK_Z,
KEY_INPUT_0 = D_DIK_0,
KEY_INPUT_1 = D_DIK_1,
KEY_INPUT_2 = D_DIK_2,
KEY_INPUT_3 = D_DIK_3,
KEY_INPUT_4 = D_DIK_4,
KEY_INPUT_5 = D_DIK_5,
KEY_INPUT_6 = D_DIK_6,
KEY_INPUT_7 = D_DIK_7,
KEY_INPUT_8 = D_DIK_8,
KEY_INPUT_9 = D_DIK_9,
}
    enum 
{
CTRL_CODE_BS = 8,
CTRL_CODE_TAB = 9,
CTRL_CODE_CR = 13,
CTRL_CODE_DEL = 16,
CTRL_CODE_COPY = 3,
CTRL_CODE_PASTE = 22,
CTRL_CODE_CUT = 24,
CTRL_CODE_ALL = 1,
CTRL_CODE_LEFT = 29,
CTRL_CODE_RIGHT = 28,
CTRL_CODE_UP = 30,
CTRL_CODE_DOWN = 31,
CTRL_CODE_HOME = 26,
CTRL_CODE_END = 25,
CTRL_CODE_PAGE_UP = 23,
CTRL_CODE_PAGE_DOWN = 21,
CTRL_CODE_ESC = 27,
CTRL_CODE_CMP = 32,
}
    enum 
{
DX_CHANGESCREEN_OK = 0,
DX_CHANGESCREEN_RETURN = -1,
DX_CHANGESCREEN_DEFAULT = -2,
DX_CHANGESCREEN_REFRESHNORMAL = -3,
}
    LONG STTELL(STREAMDATA* st)
{
return st.ReadShred.Tell(st.DataPoint);
}
    int STSEEK(STREAMDATA* st, LONG pos, int type)
{
return st.ReadShred.Seek(st.DataPoint,pos,type);
}
    size_t STREAD(void* buf, size_t length, size_t num, STREAMDATA* st)
{
return st.ReadShred.Read(buf,length,num,st.DataPoint);
}
    int STEOF(STREAMDATA* st)
{
return st.ReadShred.Eof(st.DataPoint);
}
    int STCLOSE(STREAMDATA* st)
{
return st.ReadShred.Close(st.DataPoint);
}
    enum 
{
STREAM_SEEKTYPE_SET = SEEK_SET,
STREAM_SEEKTYPE_END = SEEK_END,
STREAM_SEEKTYPE_CUR = SEEK_CUR,
}
    enum 
{
LOADIMAGE_TYPE_FILE = 0,
LOADIMAGE_TYPE_MEM = 1,
LOADIMAGE_TYPE_NONE = -1,
}
    enum 
{
DRAWPREP_TRANS = 1,
DRAWPREP_VECTORINT = 2,
DRAWPREP_GOURAUDSHADE = 8,
DRAWPREP_PERSPECTIVE = 16,
DRAWPREP_DIFFUSERGB = 32,
DRAWPREP_DIFFUSEALPHA = 64,
DRAWPREP_FOG = 128,
DRAWPREP_NOBLENDSETTING = 256,
DRAWPREP_LIGHTING = 512,
DRAWPREP_SPECULAR = 1024,
DRAWPREP_3D = 2048,
DRAWPREP_TEXADDRESS = 4096,
DRAWPREP_NOTSHADERRESET = 8192,
}
    enum 
{
HTTP_ERR_SERVER = 0,
HTTP_ERR_NOTFOUND = 1,
HTTP_ERR_MEMORY = 2,
HTTP_ERR_LOST = 3,
HTTP_ERR_NONE = -1,
}
    enum 
{
HTTP_RES_COMPLETE = 0,
HTTP_RES_STOP = 1,
HTTP_RES_ERROR = 2,
HTTP_RES_NOW = -1,
}
    struct IMEINPUTCLAUSEDATA
{
    int Position;
    int Length;
}
    alias IMEINPUTCLAUSEDATA* LPIMEINPUTCLAUSEDATA;
    version (D_Version2)
{
    mixin("alias const(IMEINPUTCLAUSEDATA)* LPCIMEINPUTCLAUSEDATA;");
}
else
{
    alias IMEINPUTCLAUSEDATA* LPCIMEINPUTCLAUSEDATA;
}
    struct IMEINPUTDATA
{
    LPCTSTR InputString;
    int CursorPosition;
    LPCIMEINPUTCLAUSEDATA ClauseData;
    int ClauseNum;
    int SelectClause;
    int CandidateNum;
    LPCTSTR* CandidateList;
    int SelectCandidate;
    int ConvertFlag;
}
    alias IMEINPUTDATA* LPIMEINPUTDATA;
    struct DATEDATA
{
    int Year;
    int Mon;
    int Day;
    int Hour;
    int Min;
    int Sec;
}
    alias DATEDATA* LPDATEDATA;
    struct DISPLAYMODEDATA
{
    int Width;
    int Height;
    int ColorBitDepth;
    int RefreshRate;
}
    alias DISPLAYMODEDATA* LPDISPLAYMODEDATA;
    struct FILEINFO
{
    TCHAR[260] Name;
    int DirFlag;
    LONGLONG Size;
    DATEDATA CreationTime;
    DATEDATA LastWriteTime;
}
    alias FILEINFO* LPFILEINFO;
    struct MATRIX
{
    float[4][4] m;
}
    alias MATRIX* LPMATRIX;
    struct VECTOR
{
    float x;
    float y;
    float z;
}
    alias VECTOR* LPVECTOR;
    alias VECTOR XYZ;
    alias VECTOR* LPXYZ;
    struct FLOAT2
{
    float u;
    float v;
}
    alias FLOAT2 UV;
    struct COLOR_F
{
    float r;
    float g;
    float b;
    float a;
}
    alias COLOR_F* LPCOLOR_F;
    struct COLOR_U8
{
    ubyte b;
    ubyte g;
    ubyte r;
    ubyte a;
}
    struct FLOAT4
{
    float x;
    float y;
    float z;
    float w;
}
    alias FLOAT4* LPFLOAT4;
    struct INT4
{
    int x;
    int y;
    int z;
    int w;
}
    struct VERTEX_NOTEX_2D
{
    VECTOR pos;
    float rhw;
    int color;
}
    alias VERTEX_NOTEX_2D* LPVERTEX_NOTEX_2D;
    struct VERTEX_2D
{
    VECTOR pos;
    float rhw;
    int color;
    float u;
    float v;
}
    alias VERTEX_2D* LPVERTEX_2D;
    struct VERTEX2D
{
    VECTOR pos;
    float rhw;
    COLOR_U8 dif;
    float u;
    float v;
}
    alias VERTEX2D* LPVERTEX2D;
    struct VERTEX2DSHADER
{
    VECTOR pos;
    float rhw;
    COLOR_U8 dif;
    COLOR_U8 spc;
    float u;
    float v;
    float su;
    float sv;
}
    alias VERTEX2DSHADER* LPVERTEX2DSHADER;
    struct VERTEX
{
    float x;
    float y;
    float u;
    float v;
    ubyte b;
    ubyte g;
    ubyte r;
    ubyte a;
}
    struct VERTEX_NOTEX_3D
{
    VECTOR pos;
    ubyte b;
    ubyte g;
    ubyte r;
    ubyte a;
}
    alias VERTEX_NOTEX_3D* LPVERTEX_NOTEX_3D;
    struct VERTEX_3D
{
    VECTOR pos;
    ubyte b;
    ubyte g;
    ubyte r;
    ubyte a;
    float u;
    float v;
}
    alias VERTEX_3D* LPVERTEX_3D;
    struct VERTEX3D
{
    VECTOR pos;
    VECTOR norm;
    COLOR_U8 dif;
    COLOR_U8 spc;
    float u;
    float v;
    float su;
    float sv;
}
    alias VERTEX3D* LPVERTEX3D;
    struct VERTEX3DSHADER
{
    VECTOR pos;
    VECTOR norm;
    COLOR_U8 dif;
    COLOR_U8 spc;
    float u;
    float v;
    float su;
    float sv;
}
    alias VERTEX3DSHADER* LPVERTEX3DSHADER;
    struct LIGHTPARAM
{
    int LightType;
    COLOR_F Diffuse;
    COLOR_F Specular;
    COLOR_F Ambient;
    VECTOR Position;
    VECTOR Direction;
    float Range;
    float Falloff;
    float Attenuation0;
    float Attenuation1;
    float Attenuation2;
    float Theta;
    float Phi;
}
    struct MATERIALPARAM
{
    COLOR_F Diffuse;
    COLOR_F Ambient;
    COLOR_F Specular;
    COLOR_F Emissive;
    float Power;
}
    struct HITRESULT_LINE
{
    int HitFlag;
    VECTOR Position;
}
    struct MV1_COLL_RESULT_POLY
{
    int HitFlag;
    VECTOR HitPosition;
    int FrameIndex;
    int PolygonIndex;
    int MaterialIndex;
    VECTOR[3] Position;
    VECTOR Normal;
}
    struct MV1_COLL_RESULT_POLY_DIM
{
    int HitNum;
    MV1_COLL_RESULT_POLY* Dim;
}
    struct MV1_REF_VERTEX
{
    VECTOR Position;
    VECTOR Normal;
    UV[2] TexCoord;
    COLOR_U8 DiffuseColor;
    COLOR_U8 SpecularColor;
}
    struct MV1_REF_POLYGON
{
    ushort FrameIndex;
    ushort MaterialIndex;
    int VIndexTarget;
    int[3] VIndex;
    VECTOR MinPosition;
    VECTOR MaxPosition;
}
    struct MV1_REF_POLYGONLIST
{
    int PolygonNum;
    int VertexNum;
    VECTOR MinPosition;
    VECTOR MaxPosition;
    MV1_REF_POLYGON* Polygons;
    MV1_REF_VERTEX* Vertexs;
}
    struct STREAMDATASHREDTYPE2
{
    int function(LPCTSTR Path, int UseCacheFlag, int BlockReadFlag, int UseASyncReadFlag) Open;
    int function(int Handle) Close;
    LONG function(int Handle) Tell;
    int function(int Handle, LONG SeekPoint, int SeekType) Seek;
    size_t function(void* Buffer, size_t BlockSize, size_t DataNum, int Handle) Read;
    int function(int Handle) Eof;
    int function(int Handle) IdleCheck;
    int function(LPCTSTR Path) ChDir;
    int function(TCHAR* Buffer) GetDir;
    int function(LPCTSTR FilePath, FILEINFO* Buffer) FindFirst;
    int function(int FindHandle, FILEINFO* Buffer) FindNext;
    int function(int FindHandle) FindClose;
}
    struct STREAMDATASHRED
{
    LONG function(void* StreamDataPoint) Tell;
    int function(void* StreamDataPoint, LONG SeekPoint, int SeekType) Seek;
    size_t function(void* Buffer, size_t BlockSize, size_t DataNum, void* StreamDataPoint) Read;
    int function(void* StreamDataPoint) Eof;
    int function(void* StreamDataPoint) IdleCheck;
    int function(void* StreamDataPoint) Close;
}
    alias STREAMDATASHRED* LPSTREAMDATASHRED;
    struct STREAMDATA
{
    STREAMDATASHRED ReadShred;
    void* DataPoint;
}
    struct MEMSTREAMDATA
{
    ubyte* DataBuffer;
    uint DataSize;
    int DataPoint;
    int EOFFlag;
}
    alias MEMSTREAMDATA* LPMEMSTREAMDATA;
    struct COLORPALETTEDATA
{
    ubyte Blue;
    ubyte Green;
    ubyte Red;
    ubyte Alpha;
}
    struct COLORDATA
{
    ushort ColorBitDepth;
    ushort PixelByte;
    ubyte RedWidth;
    ubyte GreenWidth;
    ubyte BlueWidth;
    ubyte AlphaWidth;
    ubyte RedLoc;
    ubyte GreenLoc;
    ubyte BlueLoc;
    ubyte AlphaLoc;
    uint RedMask;
    uint GreenMask;
    uint BlueMask;
    uint AlphaMask;
    uint NoneMask;
    COLORPALETTEDATA[256] Palette;
    ubyte NoneLoc;
    ubyte NoneWidth;
    int Format;
}
    alias COLORDATA* LPCOLORDATA;
    struct BASEIMAGE
{
    COLORDATA ColorData;
    int Width;
    int Height;
    int Pitch;
    void* GraphData;
    int MipMapCount;
}
    alias BASEIMAGE GRAPHIMAGE;
    alias BASEIMAGE* LPGRAPHIMAGE;
    struct LINEDATA
{
    int x1;
    int y1;
    int x2;
    int y2;
    int color;
    int pal;
}
    alias LINEDATA* LPLINEDATA;
    struct POINTDATA
{
    int x;
    int y;
    int color;
    int pal;
}
    alias POINTDATA* LPPOINTDATA;
    struct IMAGEFORMATDESC
{
    ubyte TextureFlag;
    ubyte AlphaChFlag;
    ubyte DrawValidFlag;
    ubyte SystemMemFlag;
    ubyte NotManagedTextureFlag;
    ubyte BaseFormat;
    ubyte MipMapCount;
    ubyte AlphaTestFlag;
    ubyte ColorBitDepth;
    ubyte BlendGraphFlag;
    ubyte UsePaletteFlag;
}
    struct DINPUT_JOYSTATE
{
    int X;
    int Y;
    int Z;
    int Rx;
    int Ry;
    int Rz;
    int[2] Slider;
    uint[4] POV;
    ubyte[32] Buttons;
}
    struct IPDATA
{
    union
{
struct
{
ubyte d1;
ubyte d2;
ubyte d3;
ubyte d4;
}
uint dall;
}
}
    alias IPDATA* LPIPDATA;
    extern int DxLib_Init();

    extern int DxLib_End();

    extern int DxLib_GlobalStructInitialize();

    extern int DxLib_IsInit();

    extern int ErrorLogAdd(LPCTSTR ErrorStr);

    extern int ErrorLogFmtAdd(LPCTSTR FormatString,...);

    extern int ErrorLogTabAdd();

    extern int ErrorLogTabSub();

    extern int SetUseTimeStampFlag(int UseFlag);

    extern int AppLogAdd(LPCTSTR String,...);

    extern void* DxAlloc(size_t AllocSize, LPCSTR File = null, int Line = -1);

    extern void* DxCalloc(size_t AllocSize, LPCSTR File = null, int Line = -1);

    extern void* DxRealloc(void* Memory, size_t AllocSize, LPCSTR File = null, int Line = -1);

    extern void DxFree(void* Memory);

    extern size_t DxSetAllocSizeTrap(size_t Size);

    extern int DxSetAllocPrintFlag(int Flag);

    extern size_t DxGetAllocSize();

    extern int DxGetAllocNum();

    extern void DxDumpAlloc();

    extern int DxErrorCheckAlloc();

    extern int DxSetAllocSizeOutFlag(int Flag);

    extern int DxSetAllocMemoryErrorCheckFlag(int Flag);

    extern int SetLogDrawOutFlag(int DrawFlag);

    extern int GetLogDrawFlag();

    extern int printfDx(LPCTSTR FormatString,...);

    extern int clsDx();

    extern int FileRead_open(LPCTSTR FilePath, int ASync = FALSE);

    extern int FileRead_size(LPCTSTR FilePath);

    extern int FileRead_close(int FileHandle);

    extern int FileRead_tell(int FileHandle);

    extern int FileRead_seek(int FileHandle, int Offset, int Origin);

    extern int FileRead_read(void* Buffer, int ReadSize, int FileHandle);

    extern int FileRead_idle_chk(int FileHandle);

    extern int FileRead_eof(int FileHandle);

    extern int FileRead_gets(TCHAR* Buffer, int BufferSize, int FileHandle);

    extern TCHAR FileRead_getc(int FileHandle);

    extern int FileRead_scanf(int FileHandle, LPCTSTR Format,...);

    extern int FileRead_createInfo(LPCTSTR ObjectPath);

    extern int FileRead_getInfoNum(int FileInfoHandle);

    extern int FileRead_getInfo(int Index, FILEINFO* Buffer, int FileInfoHandle);

    extern int FileRead_deleteInfo(int FileInfoHandle);

    extern int FileRead_findFirst(LPCTSTR FilePath, FILEINFO* Buffer);

    extern int FileRead_findNext(int FindHandle, FILEINFO* Buffer);

    extern int FileRead_findClose(int FindHandle);

    extern int GetResourceInfo(LPCTSTR ResourceName, LPCTSTR ResourceType, void** DataPointerP, int* DataSizeP);

    extern LPCTSTR GetResourceIDString(int ResourceID);

    extern int ProcessMessage();

    extern int GetWindowCRect(RECT* RectBuf);

    extern int GetWindowActiveFlag();

    extern HWND GetMainWindowHandle();

    extern int GetWindowModeFlag();

    extern int GetDefaultState(int* SizeX, int* SizeY, int* ColorBitDepth);

    extern int GetActiveFlag();

    extern int GetNoActiveState(int ResetFlag = TRUE);

    extern int GetMouseDispFlag();

    extern int GetAlwaysRunFlag();

    extern int _GetSystemInfo(int* DxLibVer, int* DirectXVer, int* WindowsVer);

    extern int GetPcInfo(TCHAR* OSString, TCHAR* DirectXString, TCHAR* CPUString, int* CPUSpeed, double* FreeMemorySize, double* TotalMemorySize, TCHAR* VideoDriverFileName, TCHAR* VideoDriverString, double* FreeVideoMemorySize, double* TotalVideoMemorySize);

    extern int GetUseMMXFlag();

    extern int GetUseSSEFlag();

    extern int GetUseSSE2Flag();

    extern int GetWindowCloseFlag();

    extern HINSTANCE GetTaskInstance();

    extern int GetUseWindowRgnFlag();

    extern int GetWindowSizeChangeEnableFlag(int* FitScreen = null);

    extern double GetWindowSizeExtendRate(double* ExRateX = null, double* ExRateY = null);

    extern int GetWindowSize(int* Width, int* Height);

    extern int GetWindowPosition(int* x, int* y);

    extern int GetWindowUserCloseFlag(int StateResetFlag = FALSE);

    extern int GetNotDrawFlag();

    extern int GetPaintMessageFlag();

    extern int GetValidHiPerformanceCounter();

    extern int ChangeWindowMode(int Flag);

    extern int SetUseCharSet(int CharSet);

    extern int LoadPauseGraph(LPCTSTR FileName);

    extern int LoadPauseGraphFromMem(void* MemImage, int MemImageSize);

    extern int SetActiveStateChangeCallBackFunction(int function(int ActiveState, void* UserData) CallBackFunction, void* UserData);

    extern int SetWindowText(LPCTSTR WindowText);

    extern int SetMainWindowText(LPCTSTR WindowText);

    extern int SetMainWindowClassName(LPCTSTR ClassName);

    extern int SetOutApplicationLogValidFlag(int Flag);

    extern int SetApplicationLogSaveDirectory(LPCTSTR DirectoryPath);

    extern int SetAlwaysRunFlag(int Flag);

    extern int SetWindowIconID(int ID);

    extern int SetUseASyncChangeWindowModeFunction(int Flag, void function(void*) CallBackFunction, void* Data);

    extern int SetWindowStyleMode(int Mode);

    extern int SetWindowSizeChangeEnableFlag(int Flag, int FitScreen = TRUE);

    extern int SetWindowSizeExtendRate(double ExRateX, double ExRateY = -1);

    extern int SetWindowSize(int Width, int Height);

    extern int SetWindowPosition(int x, int y);

    extern int SetSysCommandOffFlag(int Flag, LPCTSTR HookDllPath = null);

    extern int SetHookWinProc(WNDPROC WinProc);

    extern int SetDoubleStartValidFlag(int Flag);

    extern int AddMessageTakeOverWindow(HWND Window);

    extern int SubMessageTakeOverWindow(HWND Window);

    extern int SetWindowInitPosition(int x, int y);

    extern int SetNotWinFlag(int Flag);

    extern int SetNotDrawFlag(int Flag);

    extern int SetNotSoundFlag(int Flag);

    extern int SetNotInputFlag(int Flag);

    extern int SetDialogBoxHandle(HWND WindowHandle);

    extern int ChangeStreamFunction(STREAMDATASHREDTYPE2* StreamThread);

    extern int GetStreamFunctionDefault();

    extern int SetWindowVisibleFlag(int Flag);

    extern int SetWindowUserCloseEnableFlag(int Flag);

    extern int SetDxLibEndPostQuitMessageFlag(int Flag);

    extern int SetUserWindow(HWND WindowHandle);

    extern int SetUserWindowMessageProcessDXLibFlag(int Flag);

    extern int SetUseDXArchiveFlag(int Flag);

    extern int SetDXArchivePriority(int Priority = 0);

    extern int SetDXArchiveExtension(LPCTSTR Extension = null);

    extern int SetDXArchiveKeyString(LPCTSTR KeyString = null);

    extern int SetUseDateNameLogFile(int Flag);

    extern int SetBackgroundColor(int Red, int Green, int Blue);

    extern int SetLogFontSize(int Size);

    extern int SetUseFPUPreserveFlag(int Flag);

    extern int SetValidMousePointerWindowOutClientAreaMoveFlag(int Flag);

    extern int SetUseBackBufferTransColorFlag(int Flag);

    extern int SetResourceModule(HMODULE ResourceModule);

    extern int GetClipboardText(TCHAR* DestBuffer);

    extern int SetClipboardText(LPCTSTR Text);

    extern int SetDragFileValidFlag(int Flag);

    extern int DragFileInfoClear();

    extern int GetDragFilePath(TCHAR* FilePathBuffer);

    extern int GetDragFileNum();

    extern HRGN CreateRgnFromGraph(int Width, int Height, void* MaskData, int Pitch, int Byte);

    extern HRGN CreateRgnFromBaseImage(BASEIMAGE* BaseImage, int TransColorR, int TransColorG, int TransColorB);

    extern int SetWindowRgnGraph(LPCTSTR FileName);

    extern int UpdateTransColorWindowRgn();

    extern int SetupToolBar(LPCTSTR BitmapName, int DivNum, int ResourceID = -1);

    extern int AddToolBarButton(int Type, int State, int ImageIndex, int ID);

    extern int AddToolBarSep();

    extern int GetToolBarButtonState(int ID);

    extern int SetToolBarButtonState(int ID, int State);

    extern int DeleteAllToolBarButton();

    extern int SetUseMenuFlag(int Flag);

    extern int SetUseKeyAccelFlag(int Flag);

    extern int AddKeyAccel(LPCTSTR ItemName, int ItemID, int KeyCode, int CtrlFlag, int AltFlag, int ShiftFlag);

    extern int AddKeyAccel_Name(LPCTSTR ItemName, int KeyCode, int CtrlFlag, int AltFlag, int ShiftFlag);

    extern int AddKeyAccel_ID(int ItemID, int KeyCode, int CtrlFlag, int AltFlag, int ShiftFlag);

    extern int ClearKeyAccel();

    extern int AddMenuItem(int AddType, LPCTSTR ItemName, int ItemID, int SeparatorFlag, LPCTSTR NewItemName = null, int NewItemID = -1);

    extern int DeleteMenuItem(LPCTSTR ItemName, int ItemID);

    extern int CheckMenuItemSelect(LPCTSTR ItemName, int ItemID);

    extern int SetMenuItemEnable(LPCTSTR ItemName, int ItemID, int EnableFlag);

    extern int SetMenuItemMark(LPCTSTR ItemName, int ItemID, int Mark);

    extern int CheckMenuItemSelectAll();

    extern int AddMenuItem_Name(LPCTSTR ParentItemName, LPCTSTR NewItemName);

    extern int AddMenuLine_Name(LPCTSTR ParentItemName);

    extern int InsertMenuItem_Name(LPCTSTR ItemName, LPCTSTR NewItemName);

    extern int InsertMenuLine_Name(LPCTSTR ItemName);

    extern int DeleteMenuItem_Name(LPCTSTR ItemName);

    extern int CheckMenuItemSelect_Name(LPCTSTR ItemName);

    extern int SetMenuItemEnable_Name(LPCTSTR ItemName, int EnableFlag);

    extern int SetMenuItemMark_Name(LPCTSTR ItemName, int Mark);

    extern int AddMenuItem_ID(int ParentItemID, LPCTSTR NewItemName, int NewItemID = -1);

    extern int AddMenuLine_ID(int ParentItemID);

    extern int InsertMenuItem_ID(int ItemID, int NewItemID);

    extern int InsertMenuLine_ID(int ItemID, int NewItemID);

    extern int DeleteMenuItem_ID(int ItemID);

    extern int CheckMenuItemSelect_ID(int ItemID);

    extern int SetMenuItemEnable_ID(int ItemID, int EnableFlag);

    extern int SetMenuItemMark_ID(int ItemID, int Mark);

    extern int DeleteMenuItemAll();

    extern int ClearMenuItemSelect();

    extern int GetMenuItemID(LPCTSTR ItemName);

    extern int GetMenuItemName(int ItemID, TCHAR* NameBuffer);

    extern int LoadMenuResource(int MenuResourceID);

    extern int SetMenuItemSelectCallBackFunction(void function(LPCTSTR ItemName, int ItemID) CallBackFunction);

    extern int SetWindowMenu(int MenuID, int function(WORD ID) MenuProc);

    extern int SetDisplayMenuFlag(int Flag);

    extern int GetDisplayMenuFlag();

    extern int GetUseMenuFlag();

    extern int SetAutoMenuDisplayFlag(int Flag);

    extern int SetMouseDispFlag(int DispFlag);

    extern int GetMousePoint(int* XBuf, int* YBuf);

    extern int SetMousePoint(int PointX, int PointY);

    extern int GetMouseInput();

    extern int GetMouseWheelRotVol(int CounterReset = TRUE);

    extern int GetMouseInputLog(int* Button, int* ClickX, int* ClickY, int LogDelete = TRUE);

    extern int WaitTimer(int WaitTime);

    extern int WaitKey();

    extern int GetNowCount(int UseRDTSCFlag = FALSE);

    extern LONGLONG GetNowHiPerformanceCount(int UseRDTSCFlag = FALSE);

    extern int GetDateTime(DATEDATA* DateBuf);

    extern int GetRand(int RandMax);

    extern int SRand(int Seed);

    extern int ProcessNetMessage(int RunReleaseProcess = FALSE);

    extern int GetHostIPbyName(LPCTSTR HostName, IPDATA* IPDataBuf);

    extern int ConnectNetWork(IPDATA IPData, int Port = -1);

    extern int PreparationListenNetWork(int Port = -1);

    extern int StopListenNetWork();

    extern int CloseNetWork(int NetHandle);

    extern int GetNetWorkAcceptState(int NetHandle);

    extern int GetNetWorkDataLength(int NetHandle);

    extern int GetNetWorkSendDataLength(int NetHandle);

    extern int GetNewAcceptNetWork();

    extern int GetLostNetWork();

    extern int GetNetWorkIP(int NetHandle, IPDATA* IpBuf);

    extern int GetMyIPAddress(IPDATA* IpBuf);

    extern int SetConnectTimeOutWait(int Time);

    extern int SetUseDXNetWorkProtocol(int Flag);

    extern int GetUseDXNetWorkProtocol();

    extern int SetUseDXProtocol(int Flag);

    extern int GetUseDXProtocol();

    extern int SetNetWorkCloseAfterLostFlag(int Flag);

    extern int GetNetWorkCloseAfterLostFlag();

    extern int NetWorkRecv(int NetHandle, void* Buffer, int Length);

    extern int NetWorkRecvToPeek(int NetHandle, void* Buffer, int Length);

    extern int NetWorkRecvBufferClear(int NetHandle);

    extern int NetWorkSend(int NetHandle, void* Buffer, int Length);

    extern int MakeUDPSocket(int RecvPort = -1);

    extern int DeleteUDPSocket(int NetUDPHandle);

    extern int NetWorkSendUDP(int NetUDPHandle, IPDATA SendIP, int SendPort, void* Buffer, int Length);

    extern int NetWorkRecvUDP(int NetUDPHandle, IPDATA* RecvIP, int* RecvPort, void* Buffer, int Length, int Peek);

    extern int CheckNetWorkRecvUDP(int NetUDPHandle);

    extern int StockInputChar(TCHAR CharCode);

    extern int ClearInputCharBuf();

    extern TCHAR GetInputChar(int DeleteFlag);

    extern TCHAR GetInputCharWait(int DeleteFlag);

    extern int GetOneChar(TCHAR* CharBuffer, int DeleteFlag);

    extern int GetOneCharWait(TCHAR* CharBuffer, int DeleteFlag);

    extern int GetCtrlCodeCmp(TCHAR Char);

    extern int DrawIMEInputString(int x, int y, int SelectStringNum);

    extern int SetUseIMEFlag(int UseFlag);

    extern int SetInputStringMaxLengthIMESync(int Flag);

    extern int SetIMEInputStringMaxLength(int Length);

    extern int GetStringPoint(LPCTSTR String, int Point);

    extern int GetStringPoint2(LPCTSTR String, int Point);

    extern int DrawObtainsString(int x, int y, int AddY, LPCTSTR String, int StrColor, int StrEdgeColor = 0, int FontHandle = -1, int SelectBackColor = -1, int SelectStrColor = 0, int SelectStrEdgeColor = -1, int SelectStart = -1, int SelectEnd = -1);

    extern int DrawObtainsBox(int x1, int y1, int x2, int y2, int AddY, int Color, int FillFlag);

    extern int InputStringToCustom(int x, int y, int BufLength, TCHAR* StrBuffer, int CancelValidFlag, int SingleCharOnlyFlag, int NumCharOnlyFlag);

    extern int KeyInputString(int x, int y, int CharMaxLength, TCHAR* StrBuffer, int CancelValidFlag);

    extern int KeyInputSingleCharString(int x, int y, int CharMaxLength, TCHAR* StrBuffer, int CancelValidFlag);

    extern int KeyInputNumber(int x, int y, int MaxNum, int MinNum, int CancelValidFlag);

    extern int GetIMEInputModeStr(TCHAR* GetBuffer);

    extern IMEINPUTDATA* GetIMEInputData();

    extern int SetKeyInputStringColor(ULONGLONG NmlStr, ULONGLONG NmlCur, ULONGLONG IMEStr, ULONGLONG IMECur, ULONGLONG IMELine, ULONGLONG IMESelectStr, ULONGLONG IMEModeStr, ULONGLONG NmlStrE = 0, ULONGLONG IMESelectStrE = 0, ULONGLONG IMEModeStrE = 0, ULONGLONG IMESelectWinE = 18446744073709551615LU, ULONGLONG IMESelectWinF = 18446744073709551615LU, ULONGLONG SelectStrBackColor = 18446744073709551615LU, ULONGLONG SelectStrColor = 18446744073709551615LU, ULONGLONG SelectStrEdgeColor = 18446744073709551615LU);

    extern int SetKeyInputStringFont(int FontHandle);

    extern int DrawKeyInputModeString(int x, int y);

    extern int InitKeyInput();

    extern int MakeKeyInput(int MaxStrLength, int CancelValidFlag, int SingleCharOnlyFlag, int NumCharOnlyFlag);

    extern int DeleteKeyInput(int InputHandle);

    extern int SetActiveKeyInput(int InputHandle);

    extern int GetActiveKeyInput();

    extern int CheckKeyInput(int InputHandle);

    extern int ReStartKeyInput(int InputHandle);

    extern int ProcessActKeyInput();

    extern int DrawKeyInputString(int x, int y, int InputHandle);

    extern int SetKeyInputSelectArea(int SelectStart, int SelectEnd, int InputHandle);

    extern int GetKeyInputSelectArea(int* SelectStart, int* SelectEnd, int InputHandle);

    extern int SetKeyInputDrawStartPos(int DrawStartPos, int InputHandle);

    extern int GetKeyInputDrawStartPos(int InputHandle);

    extern int SetKeyInputCursorBrinkTime(int Time);

    extern int SetKeyInputCursorBrinkFlag(int Flag);

    extern int SetKeyInputString(LPCTSTR String, int InputHandle);

    extern int SetKeyInputNumber(int Number, int InputHandle);

    extern int SetKeyInputNumberToFloat(float Number, int InputHandle);

    extern int GetKeyInputString(TCHAR* StrBuffer, int InputHandle);

    extern int GetKeyInputNumber(int InputHandle);

    extern float GetKeyInputNumberToFloat(int InputHandle);

    extern int SetKeyInputCursorPosition(int Position, int InputHandle);

    extern int GetKeyInputCursorPosition(int InputHandle);

    extern void* MemStreamOpen(void* DataBuffer, uint DataSize);

    extern int MemStreamClose(void* StreamDataPoint);

    extern int CheckHitKey(int KeyCode);

    extern int CheckHitKeyAll(int CheckType = DX_CHECKINPUT_ALL);

    extern int GetHitKeyStateAll(DX_CHAR* KeyStateBuf);

    extern int SetKeyExclusiveCooperativeLevelFlag(int Flag);

    extern int GetJoypadNum();

    extern int GetJoypadInputState(int InputType);

    extern int GetJoypadAnalogInput(int* XBuf, int* YBuf, int InputType);

    extern int GetJoypadAnalogInputRight(int* XBuf, int* YBuf, int InputType);

    extern int GetJoypadDirectInputState(int InputType, DINPUT_JOYSTATE* DInputState);

    extern int KeyboradBufferProcess();

    extern int GetJoypadGUID(int PadIndex, GUID* GuidBuffer);

    extern int ConvertKeyCodeToVirtualKey(int KeyCode);

    extern int SetJoypadInputToKeyInput(int InputType, int PadInput, int KeyInput1, int KeyInput2 = -1, int KeyInput3 = -1, int KeyInput4 = -1);

    extern int SetJoypadDeadZone(int InputType, double Zone);

    extern int StartJoypadVibration(int InputType, int Power, int Time);

    extern int StopJoypadVibration(int InputType);

    extern int GetJoypadPOVState(int InputType, int POVNumber);

    extern int GetJoypadName(int InputType, TCHAR* InstanceNameBuffer, TCHAR* ProductNameBuffer);

    extern int ReSetupJoypad();

    extern int SetKeyboardNotDirectInputFlag(int Flag);

    extern int SetUseDirectInputFlag(int Flag);

    extern int SetUseJoypadVibrationFlag(int Flag);

    extern int Set2D3DKyouzonFlag(int Flag);

    extern int SetNotUse3DFlag(int Flag);

    extern int SetBasicBlendFlag(int Flag);

    extern int SetScreenMemToVramFlag(int Flag);

    extern int SetUseSoftwareRenderModeFlag(int Flag);

    extern int SetUseDirectDrawFlag(int Flag);

    extern int SetUseGDIFlag(int Flag);

    extern int SetDDrawUseGuid(GUID* Guid);

    extern int SetDisplayRefreshRate(int RefreshRate);

    extern int SetMultiThreadFlag(int Flag);

    extern int SetUseDirectDrawDeviceIndex(int Index);

    extern int SetUseTempFrontScreen(int Flag);

    extern int GetDrawScreenSize(int* XBuf, int* YBuf);

    extern int GetScreenBitDepth();

    extern int GetBmpSurf3DRenderingValidState(int BmpIndex);

    extern void* GetDrawTargetSurface();

    extern void* GetPrimarySurface();

    extern void* GetBackSurface();

    extern void* GetWorkSurface();

    extern int GetDesktopDrawCmp();

    extern void* GetUseDDrawObj();

    extern int GetUseDirectDrawFlag();

    extern int GetColorBitDepth();

    extern int GetChangeDisplayFlag();

    extern COLORDATA* GetDispColorData();

    extern LPCD_DDPIXELFORMAT GetPixelFormat();

    extern int GetScreenMemToSystemMemFlag();

    extern LPCD_DDPIXELFORMAT GetOverlayPixelFormat();

    extern D_DDCAPS GetDirectDrawCaps();

    extern int GetVideoMemorySize(int* AllSize, int* FreeSize);

    extern int GetUseGDIFlag();

    extern int GetNotDraw3DFlag();

    extern HDC GetDrawScreenDC();

    extern int ReleaseDrawScreenDC(HDC Dc);

    extern GUID* GetDirectDrawDeviceGUID(int Number);

    extern int GetDirectDrawDeviceDescription(int Number, char* StringBuffer);

    extern int GetDirectDrawDeviceNum();

    extern int GetUseMEMIMGFlag();

    extern int GetVSyncTime();

    extern int GetRefreshRate();

    extern int GetDisplayModeNum();

    extern DISPLAYMODEDATA GetDisplayMode(int ModeIndex);

    extern int SetPalette(int PalIndex, int Red, int Green, int Blue);

    extern int ReflectionPalette();

    extern int GetPalette(int PalIndex, int* Red, int* Green, int* Blue);

    extern int SetBmpPal(LPCTSTR FileName);

    extern int SetBmpPalPart(LPCTSTR FileName, int StartNum, int GetNum, int SetNum);

    extern int GetGraphPalette(int GrHandle, int ColorIndex, int* Red, int* Green, int* Blue);

    extern int GetGraphOriginalPalette(int GrHandle, int ColorIndex, int* Red, int* Green, int* Blue);

    extern int SetGraphPalette(int GrHandle, int ColorIndex, int Color);

    extern int ResetGraphPalette(int GrHandle);

    extern int GetPixel(int x, int y);

    extern int Paint(int x, int y, int FillColor, int BoundaryColor = -1);

    extern int BltFastOrBitBlt(D_IDirectDrawSurface7* Dest, D_IDirectDrawSurface7* Src, int DestX, int DestY, RECT* SrcRect, int BltType = -1);

    extern int WaitVSync(int SyncNum);

    extern int ScreenFlip();

    extern int ScreenCopy();

    extern int BltBackScreenToWindow(HWND Window, int ClientX, int ClientY);

    extern int BltRectBackScreenToWindow(HWND Window, RECT BackScreenRect, RECT WindowClientRect);

    extern int GraphCopy(RECT* SrcRect, RECT* DestRect, int SrcHandle, int DestHandle = DX_SCREEN_BACK);

    extern int SetGraphMode(int ScreenSizeX, int ScreenSizeY, int ColorBitDepth, int RefreshRate = 60);

    extern int SetGraphDisplayArea(int x1, int y1, int x2, int y2);

    extern int SetChangeScreenModeGraphicsSystemResetFlag(int Flag);

    extern int SaveDrawScreen(int x1, int y1, int x2, int y2, LPCTSTR FileName, int SaveType = DX_IMAGESAVETYPE_BMP, int Jpeg_Quality = 80, int Jpeg_Sample2x1 = TRUE, int Png_CompressionLevel = -1);

    extern int SaveDrawScreenToBMP(int x1, int y1, int x2, int y2, LPCTSTR FileName);

    extern int SaveDrawScreenToJPEG(int x1, int y1, int x2, int y2, LPCTSTR FileName, int Quality = 80, int Sample2x1 = TRUE);

    extern int SaveDrawScreenToPNG(int x1, int y1, int x2, int y2, LPCTSTR FileName, int CompressionLevel = -1);

    extern D_IDirect3DDevice7* GetUseD3DDevObj();

    extern int SetUseDivGraphFlag(int Flag);

    extern int SetUseMaxTextureSize(int Size);

    extern int SetUseVertexBufferFlag(int Flag);

    extern int SetUseOldDrawModiGraphCodeFlag(int Flag);

    extern D_DDPIXELFORMAT* GetTexPixelFormat(int AlphaCh, int AlphaTest, int ColorBitDepth, int DrawValid = FALSE);

    extern COLORDATA* GetTexColorData(int AlphaCh, int AlphaTest, int ColorBitDepth, int DrawValid = FALSE);

    extern D_DDPIXELFORMAT* b2_GetTexPixelFormat(IMAGEFORMATDESC* Format);

    extern COLORDATA* b2_GetTexColorData(IMAGEFORMATDESC* Format);

    extern D_DDPIXELFORMAT* b3_GetTexPixelFormat(int FormatIndex);

    extern COLORDATA* b3_GetTexColorData(int FormatIndex);

    extern D_DDPIXELFORMAT* GetZBufferPixelFormat(int BitDepth);

    extern int MakeGraph(int SizeX, int SizeY, int NotUse3DFlag = FALSE);

    extern int MakeScreen(int SizeX, int SizeY);

    extern int DeleteGraph(int GrHandle, int LogOutFlag = FALSE);

    extern int DeleteSharingGraph(int GrHandle);

    extern int GetGraphNum();

    extern int SetGraphLostFlag(int GrHandle, int* LostFlag);

    extern int InitGraph(int LogOutFlag = FALSE);

    extern int BltBmpToGraph(COLORDATA* SrcColor, HBITMAP Bmp, HBITMAP AlphaMask, LPCTSTR GraphName, int CopyPointX, int CopyPointY, int GrHandle, int ReverseFlag);

    extern int BltBmpToDivGraph(COLORDATA* SrcColor, HBITMAP Bmp, HBITMAP AlphaMask, LPCTSTR GraphName, int AllNum, int XNum, int YNum, int Width, int Height, int* GrHandle, int ReverseFlag);

    extern int BltBmpOrGraphImageToGraph(COLORDATA* SrcColorData, HBITMAP Bmp, HBITMAP AlphaMask, LPCTSTR GraphName, int BmpFlag, BASEIMAGE* RgbImage, BASEIMAGE* AlphaImage, int CopyPointX, int CopyPointY, int GrHandle, int ReverseFlag);

    extern int BltBmpOrGraphImageToGraph2(COLORDATA* SrcColorData, HBITMAP Bmp, HBITMAP AlphaMask, LPCTSTR GraphName, int BmpFlag, BASEIMAGE* RgbImage, BASEIMAGE* AlphaImage, RECT* SrcRect, int DestX, int DestY, int GrHandle, int ReverseFlag);

    extern int BltBmpOrGraphImageToDivGraph(COLORDATA* SrcColor, HBITMAP Bmp, HBITMAP AlphaMask, LPCTSTR GraphName, int BmpFlag, BASEIMAGE* RgbImage, BASEIMAGE* AlphaImage, int AllNum, int XNum, int YNum, int Width, int Height, int* GrHandle, int ReverseFlag);

    extern int OpenMovieToOverlay(LPCTSTR FileName);

    extern int UpdateMovieToOverlay(int x, int y, int ExRate, int ShowFlag, int MovieHandle);

    extern int CloseMovieToOverlay(int MovieHandle);

    extern int ReloadFileGraphAll();

    extern int SetGraphTransColor(int GrHandle, int Red, int Green, int Blue);

    extern int RestoreGraph(int GrHandle);

    extern int AllRestoreGraph();

    extern int ClearDrawScreen(RECT* ClearRect = null);

    extern int ClearDrawScreenZBuffer(RECT* ClearRect = null);

    extern int ClsDrawScreen();

    extern int LoadGraphScreen(int x, int y, LPCTSTR GraphName, int TransFlag);

    extern int DrawGraph(int x, int y, int GrHandle, int TransFlag);

    extern int DrawGraphF(float xf, float yf, int GrHandle, int TransFlag);

    extern int DrawExtendGraph(int x1, int y1, int x2, int y2, int GrHandle, int TransFlag);

    extern int DrawExtendGraphF(float x1f, float y1f, float x2f, float y2, int GrHandle, int TransFlag);

    extern int DrawRotaGraph(int x, int y, double ExRate, double Angle, int GrHandle, int TransFlag, int TurnFlag = FALSE);

    extern int DrawRotaGraphF(float xf, float yf, double ExRate, double Angle, int GrHandle, int TransFlag, int TurnFlag = FALSE);

    extern int DrawRotaGraph2(int x, int y, int cx, int cy, double ExtRate, double Angle, int GrHandle, int TransFlag, int TurnFlag = FALSE);

    extern int DrawRotaGraph2F(float xf, float yf, float cxf, float cyf, double ExtRate, double Angle, int GrHandle, int TransFlag, int TurnFlag = FALSE);

    extern int DrawModiGraph(int x1, int y1, int x2, int y2, int x3, int y3, int x4, int y4, int GrHandle, int TransFlag);

    extern int DrawModiGraphF(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4, int GrHandle, int TransFlag);

    extern int DrawTurnGraph(int x, int y, int GrHandle, int TransFlag);

    extern int DrawTurnGraphF(float xf, float yf, int GrHandle, int TransFlag);

    extern int DrawChipMap(int Sx, int Sy, int XNum, int YNum, int* MapData, int ChipTypeNum, int MapDataPitch, int* GrHandle, int TransFlag);

    extern int b2_DrawChipMap(int MapWidth, int MapHeight, int* MapData, int ChipTypeNum, int* ChipGrHandle, int TransFlag, int MapDrawPointX, int MapDrawPointY, int MapDrawWidth, int MapDrawHeight, int ScreenX, int ScreenY);

    extern int DrawTile(int x1, int y1, int x2, int y2, int Tx, int Ty, double ExtRate, double Angle, int GrHandle, int TransFlag);

    extern int DrawRectGraph(int DestX, int DestY, int SrcX, int SrcY, int Width, int Height, int GraphHandle, int TransFlag, int TurnFlag);

    extern int DrawRectExtendGraph(int DestX1, int DestY1, int DestX2, int DestY2, int SrcX, int SrcY, int SrcWidth, int SrcHeight, int GraphHandle, int TransFlag);

    extern int DrawRectRotaGraph(int X, int Y, int SrcX, int SrcY, int Width, int Height, double ExtRate, double Angle, int GraphHandle, int TransFlag, int TurnFlag);

    extern int DrawRectGraphF(float DestX, float DestY, int SrcX, int SrcY, int Width, int Height, int GraphHandle, int TransFlag, int TurnFlag);

    extern int DrawRectExtendGraphF(float DestX1, float DestY1, float DestX2, float DestY2, int SrcX, int SrcY, int SrcWidth, int SrcHeight, int GraphHandle, int TransFlag);

    extern int DrawRectRotaGraphF(float X, float Y, int SrcX, int SrcY, int Width, int Height, double ExtRate, double Angle, int GraphHandle, int TransFlag, int TurnFlag);

    extern int DrawBlendGraph(int x, int y, int GrHandle, int TransFlag, int BlendGraph, int BorderParam, int BorderRange);

    extern int DrawBlendGraphPos(int x, int y, int GrHandle, int TransFlag, int bx, int by, int BlendGraph, int BorderParam, int BorderRange);

    extern int DrawCircleGauge(int CenterX, int CenterY, double Percent, int GrHandle);

    extern int DrawGraphToZBuffer(int X, int Y, int GrHandle, int WriteZMode);

    extern int DrawTurnGraphToZBuffer(int x, int y, int GrHandle, int WriteZMode);

    extern int DrawExtendGraphToZBuffer(int x1, int y1, int x2, int y2, int GrHandle, int WriteZMode);

    extern int DrawRotaGraphToZBuffer(int x, int y, double ExRate, double Angle, int GrHandle, int WriteZMode, int TurnFlag = FALSE);

    extern int DrawModiGraphToZBuffer(int x1, int y1, int x2, int y2, int x3, int y3, int x4, int y4, int GrHandle, int WriteZMode);

    extern int DrawBoxToZBuffer(int x1, int y1, int x2, int y2, int FillFlag, int WriteZMode);

    extern int DrawCircleToZBuffer(int x, int y, int r, int FillFlag, int WriteZMode);

    extern int DrawStringToZBuffer(int x, int y, LPCTSTR String, int WriteZMode);

    extern int DrawVStringToZBuffer(int x, int y, LPCTSTR String, int WriteZMode);

    extern int DrawStringToHandleToZBuffer(int x, int y, LPCTSTR String, int FontHandle, int WriteZMode, int VerticalFlag = FALSE);

    extern int DrawVStringToHandleToZBuffer(int x, int y, LPCTSTR String, int FontHandle, int WriteZMode);

    extern int DrawFormatStringToZBuffer(int x, int y, int WriteZMode, LPCTSTR FormatString,...);

    extern int DrawFormatVStringToZBuffer(int x, int y, int WriteZMode, LPCTSTR FormatString,...);

    extern int DrawFormatStringToHandleToZBuffer(int x, int y, int FontHandle, int WriteZMode, LPCTSTR FormatString,...);

    extern int DrawFormatVStringToHandleToZBuffer(int x, int y, int FontHandle, int WriteZMode, LPCTSTR FormatString,...);

    extern int DrawExtendStringToZBuffer(int x, int y, double ExRateX, double ExRateY, LPCTSTR String, int WriteZMode);

    extern int DrawExtendVStringToZBuffer(int x, int y, double ExRateX, double ExRateY, LPCTSTR String, int WriteZMode);

    extern int DrawExtendStringToHandleToZBuffer(int x, int y, double ExRateX, double ExRateY, LPCTSTR String, int FontHandle, int WriteZMode, int VerticalFlag = FALSE);

    extern int DrawExtendVStringToHandleToZBuffer(int x, int y, double ExRateX, double ExRateY, LPCTSTR String, int FontHandle, int WriteZMode);

    extern int DrawExtendFormatStringToZBuffer(int x, int y, double ExRateX, double ExRateY, int WriteZMode, LPCTSTR FormatString,...);

    extern int DrawExtendFormatVStringToZBuffer(int x, int y, double ExRateX, double ExRateY, int WriteZMode, LPCTSTR FormatString,...);

    extern int DrawExtendFormatStringToHandleToZBuffer(int x, int y, double ExRateX, double ExRateY, int FontHandle, int WriteZMode, LPCTSTR FormatString,...);

    extern int DrawExtendFormatVStringToHandleToZBuffer(int x, int y, double ExRateX, double ExRateY, int FontHandle, int WriteZMode, LPCTSTR FormatString,...);

    extern int DrawPolygonBase(VERTEX* Vertex, int VertexNum, int PrimitiveType, int GrHandle, int TransFlag, int UVScaling = FALSE);

    extern int DrawPolygon(VERTEX* Vertex, int PolygonNum, int GrHandle, int TransFlag, int UVScaling = FALSE);

    extern int DrawPrimitive2D(VERTEX2D* Vertex, int VertexNum, int PrimitiveType, int GrHandle, int TransFlag);

    extern int DrawPrimitiveIndexed2D(VERTEX2D* Vertex, int VertexNum, ushort* Indices, int IndexNum, int PrimitiveType, int GrHandle, int TransFlag);

    extern int DrawPrimitive3D(VERTEX3D* Vertex, int VertexNum, int PrimitiveType, int GrHandle, int TransFlag);

    extern int DrawPrimitiveIndexed3D(VERTEX3D* Vertex, int VertexNum, ushort* Indices, int IndexNum, int PrimitiveType, int GrHandle, int TransFlag);

    extern int DrawPrimitive3D_UseVertexBuffer(int VertexBufHandle, int PrimitiveType, int GrHandle, int TransFlag);

    extern int DrawPrimitive3D_UseVertexBuffer2(int VertexBufHandle, int PrimitiveType, int StartVertex, int UseVertexNum, int GrHandle, int TransFlag);

    extern int DrawPrimitiveIndexed3D_UseVertexBuffer(int VertexBufHandle, int IndexBufHandle, int PrimitiveType, int GrHandle, int TransFlag);

    extern int DrawPrimitiveIndexed3D_UseVertexBuffer2(int VertexBufHandle, int IndexBufHandle, int PrimitiveType, int BaseVertex, int StartVertex, int UseVertexNum, int StartIndex, int UseIndexNum, int GrHandle, int TransFlag);

    extern int DrawPolygon3D(VERTEX3D* Vertex, int PolygonNum, int GrHandle, int TransFlag);

    extern int DrawPolygonIndexed3D(VERTEX3D* Vertex, int VertexNum, ushort* Indices, int PolygonNum, int GrHandle, int TransFlag);

    extern int DrawPolygon3D_UseVertexBuffer(int VertexBufHandle, int GrHandle, int TransFlag);

    extern int DrawPolygonIndexed3D_UseVertexBuffer(int VertexBufHandle, int IndexBufHandle, int GrHandle, int TransFlag);

    extern int DrawPolygon3DBase(VERTEX_3D* Vertex, int VertexNum, int PrimitiveType, int GrHandle, int TransFlag);

    extern int b2_DrawPolygon3D(VERTEX_3D* Vertex, int PolygonNum, int GrHandle, int TransFlag);

    extern int DrawGraph3D(float x, float y, float z, int GrHandle, int TransFlag);

    extern int DrawExtendGraph3D(float x, float y, float z, double ExRateX, double ExRateY, int GrHandle, int TransFlag);

    extern int DrawRotaGraph3D(float x, float y, float z, double ExRate, double Angle, int GrHandle, int TransFlag, int TurnFlag = FALSE);

    extern int DrawRota2Graph3D(float x, float y, float z, float cx, float cy, double ExtRateX, double ExtRateY, double Angle, int GrHandle, int TransFlag, int TurnFlag = FALSE);

    extern int DrawModiBillboard3D(VECTOR Pos, float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4, int GrHandle, int TransFlag);

    extern int DrawBillboard3D(VECTOR Pos, float cx, float cy, float Size, float Angle, int GrHandle, int TransFlag, int TurnFlag = FALSE);

    extern int FillGraph(int GrHandle, int Red, int Green, int Blue, int Alpha = 255);

    extern int DrawLine(int x1, int y1, int x2, int y2, int Color, int Thickness = 1);

    extern int DrawBox(int x1, int y1, int x2, int y2, int Color, int FillFlag);

    extern int DrawFillBox(int x1, int y1, int x2, int y2, int Color);

    extern int DrawLineBox(int x1, int y1, int x2, int y2, int Color);

    extern int DrawCircle(int x, int y, int r, int Color, int FillFlag = TRUE);

    extern int DrawOval(int x, int y, int rx, int ry, int Color, int FillFlag);

    extern int DrawTriangle(int x1, int y1, int x2, int y2, int x3, int y3, int Color, int FillFlag);

    extern int DrawQuadrangle(int x1, int y1, int x2, int y2, int x3, int y3, int x4, int y4, int Color, int FillFlag);

    extern int DrawPixel(int x, int y, int Color);

    extern int DrawPixelSet(POINTDATA* PointData, int Num);

    extern int DrawLineSet(LINEDATA* LineData, int Num);

    extern int DrawPixel3D(VECTOR Pos, int Color);

    extern int DrawLine3D(VECTOR Pos1, VECTOR Pos2, int Color);

    extern int DrawTriangle3D(VECTOR Pos1, VECTOR Pos2, VECTOR Pos3, int Color, int FillFlag);

    extern int DrawCube3D(VECTOR Pos1, VECTOR Pos2, int DifColor, int SpcColor, int FillFlag);

    extern int DrawSphere3D(VECTOR CenterPos, float r, int DivNum, int DifColor, int SpcColor, int FillFlag);

    extern int DrawCapsule3D(VECTOR Pos1, VECTOR Pos2, float r, int DivNum, int DifColor, int SpcColor, int FillFlag);

    extern int DrawCone3D(VECTOR TopPos, VECTOR BottomPos, float r, int DivNum, int DifColor, int SpcColor, int FillFlag);

    extern int DrawString(int x, int y, LPCTSTR String, int Color, int EdgeColor = 0);

    extern int DrawVString(int x, int y, LPCTSTR String, int Color, int EdgeColor = 0);

    extern int DrawStringToHandle(int x, int y, LPCTSTR String, int Color, int FontHandle, int EdgeColor = 0, int VerticalFlag = FALSE);

    extern int DrawVStringToHandle(int x, int y, LPCTSTR String, int Color, int FontHandle, int EdgeColor = 0);

    extern int DrawFormatString(int x, int y, int Color, LPCTSTR FormatString,...);

    extern int DrawFormatVString(int x, int y, int Color, LPCTSTR FormatString,...);

    extern int DrawFormatStringToHandle(int x, int y, int Color, int FontHandle, LPCTSTR FormatString,...);

    extern int DrawFormatVStringToHandle(int x, int y, int Color, int FontHandle, LPCTSTR FormatString,...);

    extern int DrawExtendString(int x, int y, double ExRateX, double ExRateY, LPCTSTR String, int Color, int EdgeColor = 0);

    extern int DrawExtendVString(int x, int y, double ExRateX, double ExRateY, LPCTSTR String, int Color, int EdgeColor = 0);

    extern int DrawExtendStringToHandle(int x, int y, double ExRateX, double ExRateY, LPCTSTR String, int Color, int FontHandle, int EdgeColor = 0, int VerticalFlag = FALSE);

    extern int DrawExtendVStringToHandle(int x, int y, double ExRateX, double ExRateY, LPCTSTR String, int Color, int FontHandle, int EdgeColor = 0);

    extern int DrawExtendFormatString(int x, int y, double ExRateX, double ExRateY, int Color, LPCTSTR FormatString,...);

    extern int DrawExtendFormatVString(int x, int y, double ExRateX, double ExRateY, int Color, LPCTSTR FormatString,...);

    extern int DrawExtendFormatStringToHandle(int x, int y, double ExRateX, double ExRateY, int Color, int FontHandle, LPCTSTR FormatString,...);

    extern int DrawExtendFormatVStringToHandle(int x, int y, double ExRateX, double ExRateY, int Color, int FontHandle, LPCTSTR FormatString,...);

    extern int DrawNumberToI(int x, int y, int Num, int RisesNum, int Color, int EdgeColor = 0);

    extern int DrawNumberToF(int x, int y, double Num, int Length, int Color, int EdgeColor = 0);

    extern int DrawNumberPlusToI(int x, int y, LPCTSTR NoteString, int Num, int RisesNum, int Color, int EdgeColor = 0);

    extern int DrawNumberPlusToF(int x, int y, LPCTSTR NoteString, double Num, int Length, int Color, int EdgeColor = 0);

    extern int DrawNumberToIToHandle(int x, int y, int Num, int RisesNum, int Color, int FontHandle, int EdgeColor = 0);

    extern int DrawNumberToFToHandle(int x, int y, double Num, int Length, int Color, int FontHandle, int EdgeColor = 0);

    extern int DrawNumberPlusToIToHandle(int x, int y, LPCTSTR NoteString, int Num, int RisesNum, int Color, int FontHandle, int EdgeColor = 0);

    extern int DrawNumberPlusToFToHandle(int x, int y, LPCTSTR NoteString, double Num, int Length, int Color, int FontHandle, int EdgeColor = 0);

    extern int CreateVertexBuffer(int VertexNum, int VertexType);

    extern int DeleteVertexBuffer(int VertexBufHandle);

    extern int InitVertexBuffer();

    extern int SetVertexBufferData(int SetIndex, void* VertexData, int VertexNum, int VertexBufHandle);

    extern int CreateIndexBuffer(int IndexNum, int IndexType);

    extern int DeleteIndexBuffer(int IndexBufHandle);

    extern int InitIndexBuffer();

    extern int SetIndexBufferData(int SetIndex, void* IndexData, int IndexNum, int IndexBufHandle);

    extern int GetValidShaderVersion();

    extern int LoadVertexShader(LPCTSTR FileName);

    extern int LoadVertexShaderFromMem(void* ImageAddress, int ImageSize);

    extern int LoadPixelShader(LPCTSTR FileName);

    extern int LoadPixelShaderFromMem(void* ImageAddress, int ImageSize);

    extern int DeleteShader(int ShaderHandle);

    extern int InitShader();

    extern int GetConstIndexToShader(LPCTSTR ConstantName, int ShaderHandle);

    extern int SetVSConstF(int ConstantIndex, FLOAT4 Param);

    extern int SetVSConstFMtx(int ConstantIndex, MATRIX Param);

    extern int SetVSConstI(int ConstantIndex, INT4 Param);

    extern int SetVSConstB(int ConstantIndex, BOOL Param);

    extern int SetVSConstFArray(int ConstantIndex, FLOAT4* ParamArray, int ParamNum);

    extern int SetVSConstFMtxArray(int ConstantIndex, MATRIX* ParamArray, int ParamNum);

    extern int SetVSConstIArray(int ConstantIndex, INT4* ParamArray, int ParamNum);

    extern int SetVSConstBArray(int ConstantIndex, BOOL* ParamArray, int ParamNum);

    extern int SetPSConstF(int ConstantIndex, FLOAT4 Param);

    extern int SetPSConstFMtx(int ConstantIndex, MATRIX Param);

    extern int SetPSConstI(int ConstantIndex, INT4 Param);

    extern int SetPSConstB(int ConstantIndex, BOOL Param);

    extern int SetPSConstFArray(int ConstantIndex, FLOAT4* ParamArray, int ParamNum);

    extern int SetPSConstFMtxArray(int ConstantIndex, MATRIX* ParamArray, int ParamNum);

    extern int SetPSConstIArray(int ConstantIndex, INT4* ParamArray, int ParamNum);

    extern int SetPSConstBArray(int ConstantIndex, BOOL* ParamArray, int ParamNum);

    extern int SetUseTextureToShader(int StageIndex, int GraphHandle);

    extern int SetUseVertexShader(int ShaderHandle);

    extern int SetUsePixelShader(int ShaderHandle);

    extern int DrawPrimitive2DToShader(VERTEX2DSHADER* Vertex, int VertexNum, int PrimitiveType);

    extern int DrawPrimitive3DToShader(VERTEX3DSHADER* Vertex, int VertexNum, int PrimitiveType);

    extern int DrawPrimitiveIndexed2DToShader(VERTEX2DSHADER* Vertex, int VertexNum, ushort* Indices, int IndexNum, int PrimitiveType);

    extern int DrawPrimitiveIndexed3DToShader(VERTEX3DSHADER* Vertex, int VertexNum, ushort* Indices, int IndexNum, int PrimitiveType);

    extern int SetDrawMode(int DrawMode);

    extern int SetMaxAnisotropy(int MaxAnisotropy);

    extern int SetDrawBlendMode(int BlendMode, int BlendParam);

    extern int SetDrawAlphaTest(int TestMode, int TestParam);

    extern int SetBlendGraph(int BlendGraph, int BorderParam, int BorderRange);

    extern int SetBlendGraphPosition(int x, int y);

    extern int SetDrawBright(int RedBright, int GreenBright, int BlueBright);

    extern int SetDrawScreen(int DrawScreen);

    extern int SetDrawArea(int x1, int y1, int x2, int y2);

    extern int SetDraw3DScale(float Scale);

    extern int SetDrawAreaFull();

    extern int SetUse3DFlag(int Flag);

    extern int SetUseHardwareVertexProcessing(int Flag);

    extern int SetRestoreShredPoint(void function() ShredPoint);

    extern int SetRestoreGraphCallback(void function() Callback);

    extern int RunRestoreShred();

    extern int SetGraphicsDeviceRestoreCallbackFunction(void function(void* Data) Callback, void* CallbackData);

    extern int SetTransformToWorld(MATRIX* Matrix);

    extern int SetTransformToView(MATRIX* Matrix);

    extern int SetTransformToProjection(MATRIX* Matrix);

    extern int SetTransformToViewport(MATRIX* Matrix);

    extern int SetUseCullingFlag(int Flag);

    extern int SetUseBackCulling(int Flag);

    extern int SetTextureAddressMode(int Mode, int Stage = -1);

    extern int SetTextureAddressModeUV(int ModeU, int ModeV, int Stage = -1);

    extern int SetTextureAddressTransform(float TransU, float TransV, float ScaleU, float ScaleV, float RotCenterU, float RotCenterV, float Rotate);

    extern int SetTextureAddressTransformMatrix(MATRIX Matrix);

    extern int ResetTextureAddressTransform();

    extern int SetFogEnable(int Flag);

    extern int SetFogMode(int Mode);

    extern int SetFogColor(int r, int g, int b);

    extern int SetFogStartEnd(float start, float end);

    extern int SetFogDensity(float density);

    extern int SetUseSystemMemGraphCreateFlag(int Flag);

    extern int SetUseVramFlag(int Flag);

    extern int RestoreGraphSystem();

    extern int SetAeroDisableFlag(int Flag);

    extern int GetDrawScreenGraph(int x1, int y1, int x2, int y2, int GrHandle, int UseClientFlag = TRUE);

    extern DWORD* GetFullColorImage(int GrHandle);

    extern int GraphLock(int GrHandle, int* PitchBuf, void** DataPointBuf, COLORDATA** ColorDataPP = null);

    extern int GraphUnLock(int GrHandle);

    extern int SetUseGraphZBuffer(int GrHandle, int UseFlag);

    extern int GetGraphSize(int GrHandle, int* SizeXBuf, int* SizeYBuf);

    extern int GetScreenState(int* SizeX, int* SizeY, int* ColorBitDepth);

    extern int GetUse3DFlag();

    extern int GetValidRestoreShredPoint();

    extern int GetTransformToViewMatrix(MATRIX* MatBuf);

    extern int GetTransformToWorldMatrix(MATRIX* MatBuf);

    extern int GetTransformToProjectionMatrix(MATRIX* MatBuf);

    extern int GetTransformPosition(VECTOR* LocalPos, float* x, float* y);

    extern float GetBillboardPixelSize(VECTOR WorldPos, float WorldSize);

    extern VECTOR ConvWorldPosToScreenPos(VECTOR WorldPos);

    extern VECTOR ConvScreenPosToWorldPos(VECTOR ScreenPos);

    extern VECTOR ConvScreenPosToWorldPos_ZLinear(VECTOR ScreenPos);

    extern int GetUseVramFlag();

    extern int GetCreateGraphColorData(COLORDATA* ColorData, IMAGEFORMATDESC* Format);

    extern int CreateDXGraph(BASEIMAGE* RgbImage, BASEIMAGE* AlphaImage, int TextureFlag);

    extern int DerivationGraph(int SrcX, int SrcY, int Width, int Height, int SrcGraphHandle);

    extern int PlayMovie(LPCTSTR FileName, int ExRate, int PlayType);

    extern int OpenMovieToGraph(LPCTSTR FileName, int FullColor = TRUE);

    extern int PlayMovieToGraph(int GraphHandle, int PlayType = DX_PLAYTYPE_BACK, int SysPlay = 0);

    extern int PauseMovieToGraph(int GraphHandle, int SysPause = 0);

    extern int AddMovieFrameToGraph(int GraphHandle, uint FrameNum);

    extern int SeekMovieToGraph(int GraphHandle, int Time);

    extern int GetMovieStateToGraph(int GraphHandle);

    extern int SetMovieVolumeToGraph(int Volume, int GraphHandle);

    extern BASEIMAGE* GetMovieBaseImageToGraph(int GraphHandle);

    extern int GetMovieTotalFrameToGraph(int GraphHandle);

    extern int TellMovieToGraph(int GraphHandle);

    extern int TellMovieToGraphToFrame(int GraphHandle);

    extern int SeekMovieToGraphToFrame(int GraphHandle, int Frame);

    extern LONGLONG GetOneFrameTimeMovieToGraph(int GraphHandle);

    extern int GetLastUpdateTimeMovieToGraph(int GraphHandle);

    extern int LoadBmpToGraph(LPCTSTR GraphName, int TextureFlag, int ReverseFlag, int SurfaceMode = DX_MOVIESURFACE_NORMAL);

    extern int LoadGraph(LPCTSTR FileName, int NotUse3DFlag = FALSE);

    extern int LoadReverseGraph(LPCTSTR FileName, int NotUse3DFlag = FALSE);

    extern int LoadDivGraph(LPCTSTR FileName, int AllNum, int XNum, int YNum, int XSize, int YSize, int* HandleBuf, int NotUse3DFlag = FALSE);

    extern int LoadDivBmpToGraph(LPCTSTR FileName, int AllNum, int XNum, int YNum, int SizeX, int SizeY, int* HandleBuf, int TextureFlag, int ReverseFlag);

    extern int LoadReverseDivGraph(LPCTSTR FileName, int AllNum, int XNum, int YNum, int XSize, int YSize, int* HandleBuf, int NotUse3DFlag = FALSE);

    extern int LoadBlendGraph(LPCTSTR FileName);

    extern int LoadGraphToResource(int ResourceID);

    extern int LoadDivGraphToResource(int ResourceID, int AllNum, int XNum, int YNum, int XSize, int YSize, int* HandleBuf);

    extern int b2_LoadGraphToResource(LPCTSTR ResourceName, LPCTSTR ResourceType);

    extern int b2_LoadDivGraphToResource(LPCTSTR ResourceName, LPCTSTR ResourceType, int AllNum, int XNum, int YNum, int XSize, int YSize, int* HandleBuf);

    extern int CreateGraphFromMem(void* MemImage, int MemImageSize, void* AlphaImage = null, int AlphaImageSize = 0, int TextureFlag = TRUE, int ReverseFlag = FALSE);

    extern int ReCreateGraphFromMem(void* MemImage, int MemImageSize, int GrHandle, void* AlphaImage = null, int AlphaImageSize = 0, int TextureFlag = TRUE, int ReverseFlag = FALSE);

    extern int CreateDivGraphFromMem(void* MemImage, int MemImageSize, int AllNum, int XNum, int YNum, int SizeX, int SizeY, int* HandleBuf, int TextureFlag = TRUE, int ReverseFlag = FALSE, void* AlphaImage = null, int AlphaImageSize = 0);

    extern int ReCreateDivGraphFromMem(void* MemImage, int MemImageSize, int AllNum, int XNum, int YNum, int SizeX, int SizeY, int* HandleBuf, int TextureFlag = TRUE, int ReverseFlag = FALSE, void* AlphaImage = null, int AlphaImageSize = 0);

    extern int CreateGraphFromBmp(BITMAPINFO* BmpInfo, void* GraphData, BITMAPINFO* AlphaInfo = null, void* AlphaData = null, int TextureFlag = TRUE, int ReverseFlag = FALSE);

    extern int ReCreateGraphFromBmp(BITMAPINFO* BmpInfo, void* GraphData, int GrHandle, BITMAPINFO* AlphaInfo = null, void* AlphaData = null, int TextureFlag = TRUE, int ReverseFlag = FALSE);

    extern int CreateDivGraphFromBmp(BITMAPINFO* BmpInfo, void* GraphData, int AllNum, int XNum, int YNum, int SizeX, int SizeY, int* HandleBuf, int TextureFlag = TRUE, int ReverseFlag = FALSE, BITMAPINFO* AlphaInfo = null, void* AlphaData = null);

    extern int ReCreateDivGraphFromBmp(BITMAPINFO* BmpInfo, void* GraphData, int AllNum, int XNum, int YNum, int SizeX, int SizeY, int* HandleBuf, int TextureFlag = TRUE, int ReverseFlag = FALSE, BITMAPINFO* AlphaInfo = null, void* AlphaData = null);

    extern int CreateGraphFromGraphImage(BASEIMAGE* Image, int TextureFlag = TRUE, int ReverseFlag = FALSE, int DataReverseFlag = TRUE);

    extern int b2_CreateGraphFromGraphImage(BASEIMAGE* Image, BASEIMAGE* AlphaImage, int TextureFlag = TRUE, int ReverseFlag = FALSE, int DataReverseFlag = TRUE);

    extern int ReCreateGraphFromGraphImage(BASEIMAGE* Image, int GrHandle, int TextureFlag = TRUE, int ReverseFlag = FALSE, int DataReverseFlag = TRUE);

    extern int b2_ReCreateGraphFromGraphImage(BASEIMAGE* Image, BASEIMAGE* AlphaImage, int GrHandle, int TextureFlag = TRUE, int ReverseFlag = FALSE, int DataReverseFlag = TRUE);

    extern int CreateDivGraphFromGraphImage(BASEIMAGE* Image, int AllNum, int XNum, int YNum, int SizeX, int SizeY, int* HandleBuf, int TextureFlag = TRUE, int ReverseFlag = FALSE, int DataReverseFlag = TRUE);

    extern int b2_CreateDivGraphFromGraphImage(BASEIMAGE* Image, BASEIMAGE* AlphaImage, int AllNum, int XNum, int YNum, int SizeX, int SizeY, int* HandleBuf, int TextureFlag = TRUE, int ReverseFlag = FALSE, int DataReverseFlag = TRUE);

    extern int ReCreateDivGraphFromGraphImage(BASEIMAGE* Image, int AllNum, int XNum, int YNum, int SizeX, int SizeY, int* HandleBuf, int TextureFlag = TRUE, int ReverseFlag = FALSE, int DataReverseFlag = TRUE);

    extern int b2_ReCreateDivGraphFromGraphImage(BASEIMAGE* Image, BASEIMAGE* AlphaImage, int AllNum, int XNum, int YNum, int SizeX, int SizeY, int* HandleBuf, int TextureFlag = TRUE, int ReverseFlag = FALSE, int DataReverseFlag = TRUE);

    extern int CreateGraph(int Width, int Height, int Pitch, void* GraphData, void* AlphaData = null, int GrHandle = -1);

    extern int CreateDivGraph(int Width, int Height, int Pitch, void* GraphData, int AllNum, int XNum, int YNum, int SizeX, int SizeY, int* HandleBuf, void* AlphaData = null);

    extern int ReCreateGraph(int Width, int Height, int Pitch, void* GraphData, int GrHandle, void* AlphaData = null);

    extern int CreateBlendGraphFromSoftImage(int SIHandle);

    extern int CreateGraphFromSoftImage(int SIHandle);

    extern int CreateGraphFromRectSoftImage(int SIHandle, int x, int y, int SizeX, int SizeY);

    extern int ReCreateGraphFromSoftImage(int SIHandle, int GrHandle);

    extern int ReCreateGraphFromRectSoftImage(int SIHandle, int x, int y, int SizeX, int SizeY, int GrHandle);

    extern int CreateDivGraphFromSoftImage(int SIHandle, int AllNum, int XNum, int YNum, int SizeX, int SizeY, int* HandleBuf);

    extern int CreateGraphFromBaseImage(BASEIMAGE* BaseImage);

    extern int CreateGraphFromRectBaseImage(BASEIMAGE* BaseImage, int x, int y, int SizeX, int SizeY);

    extern int ReCreateGraphFromBaseImage(BASEIMAGE* BaseImage, int GrHandle);

    extern int ReCreateGraphFromRectBaseImage(BASEIMAGE* BaseImage, int x, int y, int SizeX, int SizeY, int GrHandle);

    extern int CreateDivGraphFromBaseImage(BASEIMAGE* BaseImage, int AllNum, int XNum, int YNum, int SizeX, int SizeY, int* HandleBuf);

    extern int ReloadGraph(LPCTSTR FileName, int GrHandle, int ReverseFlag = FALSE);

    extern int ReloadDivGraph(LPCTSTR FileName, int AllNum, int XNum, int YNum, int XSize, int YSize, int* HandleBuf, int ReverseFlag = FALSE);

    extern int ReloadReverseGraph(LPCTSTR FileName, int GrHandle);

    extern int ReloadReverseDivGraph(LPCTSTR FileName, int AllNum, int XNum, int YNum, int XSize, int YSize, int* HandleBuf);

    extern int DrawBaseImage(int x, int y, BASEIMAGE* BaseImage);

    extern int SetCameraNearFar(float Near, float Far);

    extern int SetCameraPositionAndTarget_UpVecY(VECTOR Position, VECTOR Target);

    extern int SetCameraPositionAndTargetAndUpVec(VECTOR Position, VECTOR Target, VECTOR Up);

    extern int SetCameraPositionAndAngle(VECTOR Position, float VRotate, float HRotate, float TRotate);

    extern int SetCameraViewMatrix(MATRIX ViewMatrix);

    extern int SetCameraScreenCenter(float x, float y);

    extern int SetupCamera_Perspective(float Fov);

    extern int SetupCamera_Ortho(float Size);

    extern int SetupCamera_ProjectionMatrix(MATRIX ProjectionMatrix);

    extern int SetCameraDotAspect(float DotAspect);

    extern float GetCameraNear();

    extern float GetCameraFar();

    extern VECTOR GetCameraPosition();

    extern VECTOR GetCameraTarget();

    extern VECTOR GetCameraUpVector();

    extern float GetCameraAngleHRotate();

    extern float GetCameraAngleVRotate();

    extern float GetCameraAngleTRotate();

    extern MATRIX GetCameraViewMatrix();

    extern float GetCameraFov();

    extern float GetCameraSize();

    extern MATRIX GetCameraProjectionMatrix();

    extern float GetCameraDotAspect();

    extern int SetUseLighting(int Flag);

    extern int SetMaterialUseVertDifColor(int UseFlag);

    extern int SetMaterialUseVertSpcColor(int UseFlag);

    extern int SetMaterialParam(MATERIALPARAM Material);

    extern int SetUseSpecular(int UseFlag);

    extern int SetGlobalAmbientLight(COLOR_F Color);

    extern int ChangeLightTypeDir(VECTOR Direction);

    extern int ChangeLightTypeSpot(VECTOR Position, VECTOR Direction, float OutAngle, float InAngle, float Range, float Atten0, float Atten1, float Atten2);

    extern int ChangeLightTypePoint(VECTOR Position, float Range, float Atten0, float Atten1, float Atten2);

    extern int SetLightEnable(int EnableFlag);

    extern int SetLightDifColor(COLOR_F Color);

    extern int SetLightSpcColor(COLOR_F Color);

    extern int SetLightAmbColor(COLOR_F Color);

    extern int SetLightDirection(VECTOR Direction);

    extern int SetLightPosition(VECTOR Position);

    extern int SetLightRangeAtten(float Range, float Atten0, float Atten1, float Atten2);

    extern int SetLightAngle(float OutAngle, float InAngle);

    extern int GetLightType();

    extern int GetLightEnable();

    extern COLOR_F GetLightDifColor();

    extern COLOR_F GetLightSpcColor();

    extern COLOR_F GetLightAmbColor();

    extern VECTOR GetLightDirection();

    extern VECTOR GetLightPosition();

    extern int GetLightRangeAtten(float* Range, float* Atten0, float* Atten1, float* Atten2);

    extern int GetLightAngle(float* OutAngle, float* InAngle);

    extern int CreateDirLightHandle(VECTOR Direction);

    extern int CreateSpotLightHandle(VECTOR Position, VECTOR Direction, float OutAngle, float InAngle, float Range, float Atten0, float Atten1, float Atten2);

    extern int CreatePointLightHandle(VECTOR Position, float Range, float Atten0, float Atten1, float Atten2);

    extern int DeleteLightHandle(int LHandle);

    extern int DeleteLightHandleAll();

    extern int SetLightTypeHandle(int LHandle, int LightType);

    extern int SetLightEnableHandle(int LHandle, int EnableFlag);

    extern int SetLightDifColorHandle(int LHandle, COLOR_F Color);

    extern int SetLightSpcColorHandle(int LHandle, COLOR_F Color);

    extern int SetLightAmbColorHandle(int LHandle, COLOR_F Color);

    extern int SetLightDirectionHandle(int LHandle, VECTOR Direction);

    extern int SetLightPositionHandle(int LHandle, VECTOR Position);

    extern int SetLightRangeAttenHandle(int LHandle, float Range, float Atten0, float Atten1, float Atten2);

    extern int SetLightAngleHandle(int LHandle, float OutAngle, float InAngle);

    extern int GetLightTypeHandle(int LHandle);

    extern int GetLightEnableHandle(int LHandle);

    extern COLOR_F GetLightDifColorHandle(int LHandle);

    extern COLOR_F GetLightSpcColorHandle(int LHandle);

    extern COLOR_F GetLightAmbColorHandle(int LHandle);

    extern VECTOR GetLightDirectionHandle(int LHandle);

    extern VECTOR GetLightPositionHandle(int LHandle);

    extern int GetLightRangeAttenHandle(int LHandle, float* Range, float* Atten0, float* Atten1, float* Atten2);

    extern int GetLightAngleHandle(int LHandle, float* OutAngle, float* InAngle);

    extern int SetGraphColorBitDepth(int ColorBitDepth);

    extern int SetCreateGraphColorBitDepth(int BitDepth);

    extern int GetCreateGraphColorBitDepth();

    extern int GetGraphColorBitDepth();

    extern int SetDrawValidGraphCreateFlag(int Flag);

    extern int GetDrawValidGraphCreateFlag();

    extern int SetLeftUpColorIsTransColorFlag(int Flag);

    extern int GetUseBlendGraphCreateFlag();

    extern int GetUseSystemMemGraphCreateFlag();

    extern int SetUseBlendGraphCreateFlag(int Flag);

    extern int SetUseAlphaTestGraphCreateFlag(int Flag);

    extern int SetUseAlphaTestFlag(int Flag);

    extern int SetUseNoBlendModeParam(int Flag);

    extern int SetDrawValidFlagOf3DGraph(int Flag);

    extern int GetUseAlphaTestFlag();

    extern int GetUseAlphaTestGraphCreateFlag();

    extern int SetDrawValidAlphaChannelGraphCreateFlag(int Flag);

    extern int SetUseZBufferFlag(int Flag);

    extern int SetWriteZBufferFlag(int Flag);

    extern int SetZBufferCmpType(int CmpType);

    extern int SetZBias(int Bias);

    extern int SetUseZBuffer3D(int Flag);

    extern int SetWriteZBuffer3D(int Flag);

    extern int SetZBufferCmpType3D(int CmpType);

    extern int SetZBias3D(int Bias);

    extern int SetDrawZ(float Z);

    extern int SetUseTransColor(int Flag);

    extern int SetUseTransColorGraphCreateFlag(int Flag);

    extern int SetUseAlphaChannelGraphCreateFlag(int Flag);

    extern int SetUseGraphAlphaChannel(int Flag);

    extern int GetUseAlphaChannelGraphCreateFlag();

    extern int GetUseGraphAlphaChannel();

    extern int SetUseNotManageTextureFlag(int Flag);

    extern int SetTransColor(int Red, int Green, int Blue);

    extern int GetTransColor(int* Red, int* Green, int* Blue);

    extern int GetDrawArea(RECT* Rect);

    extern int GetUseNotManageTextureFlag();

    extern int SetUseBasicGraphDraw3DDeviceMethodFlag(int Flag);

    extern int SetWindowDrawRect(RECT* DrawRect);

    extern int GetDrawBlendMode(int* BlendMode, int* BlendParam);

    extern int GetDrawMode();

    extern int GetDrawBright(int* Red, int* Green, int* Blue);

    extern int GetActiveGraph();

    extern int GetTexFormatIndex(IMAGEFORMATDESC* Format);

    extern int SetWaitVSyncFlag(int Flag);

    extern int GetWaitVSyncFlag();

    extern int ColorKaiseki(void* PixelData, COLORDATA* ColorData);

    extern int SetDefTransformMatrix();

    extern int CreatePixelFormat(D_DDPIXELFORMAT* PixelFormatBuf, int ColorBitDepth, DWORD RedMask, DWORD GreenMask, DWORD BlueMask, DWORD AlphaMask);

    extern int SetEmulation320x240(int Flag);

    extern int CreateMaskScreen();

    extern int DeleteMaskScreen();

    extern void* GetMaskSurface();

    extern int DrawMaskToDirectData(int x, int y, int Width, int Height, void* MaskData, int TransMode);

    extern int DrawFillMaskToDirectData(int x1, int y1, int x2, int y2, int Width, int Height, void* MaskData);

    extern int SetUseMaskScreenFlag(int ValidFlag);

    extern int GetUseMaskScreenFlag();

    extern int FillMaskScreen(int Flag);

    extern int InitMask();

    extern int MakeMask(int Width, int Height);

    extern int GetMaskSize(int* WidthBuf, int* HeightBuf, int MaskHandle);

    extern int SetDataToMask(int Width, int Height, void* MaskData, int MaskHandle);

    extern int DeleteMask(int MaskHandle);

    extern int BmpBltToMask(HBITMAP Bmp, int BmpPointX, int BmpPointY, int MaskHandle);

    extern int LoadMask(LPCTSTR FileName);

    extern int LoadDivMask(LPCTSTR FileName, int AllNum, int XNum, int YNum, int XSize, int YSize, int* HandleBuf);

    extern int DrawMask(int x, int y, int MaskHandle, int TransMode);

    extern int DrawFormatStringMask(int x, int y, int Flag, LPCTSTR FormatString,...);

    extern int DrawFormatStringMaskToHandle(int x, int y, int Flag, int FontHandle, LPCTSTR FormatString,...);

    extern int DrawStringMask(int x, int y, int Flag, LPCTSTR String);

    extern int DrawStringMaskToHandle(int x, int y, int Flag, int FontHandle, LPCTSTR String);

    extern int DrawFillMask(int x1, int y1, int x2, int y2, int MaskHandle);

    extern int SetMaskTransColor(int ColorCode);

    extern int SetMaskReverseEffectFlag(int ReverseFlag);

    extern int GetMaskScreenData(int x1, int y1, int x2, int y2, int MaskHandle);

    extern int GetMaskUseFlag();

    extern int SetMovieRightImageAlphaFlag(int Flag);

    extern int EnumFontName(TCHAR* NameBuffer, int NameBufferNum, int JapanOnlyFlag = TRUE);

    extern int EnumFontNameEx(TCHAR* NameBuffer, int NameBufferNum, int CharSet = -1);

    extern int InitFontToHandle();

    extern int CreateFontToHandle(LPCTSTR FontName, int Size, int Thick, int FontType = -1, int CharSet = -1, int EdgeSize = -1, int Italic = FALSE, int DataIndex = -1, int ID = -1);

    extern int SetFontSpaceToHandle(int Point, int FontHandle);

    extern int SetDefaultFontState(LPCTSTR FontName, int Size, int Thick);

    extern int DeleteFontToHandle(int FontHandle);

    extern int SetFontLostFlag(int FontHandle, int* LostFlag);

    extern int SetFontSize(int FontSize);

    extern int SetFontThickness(int ThickPal);

    extern int SetFontSpace(int Point);

    extern int SetFontCacheToTextureFlag(int Flag);

    extern int SetFontChacheToTextureFlag(int Flag);

    extern int SetFontCacheCharNum(int CharNum);

    extern int ChangeFont(LPCTSTR FontName, int CharSet = -1);

    extern int ChangeFontType(int FontType);

    extern int FontCacheStringDrawToHandle(int x, int y, LPCTSTR StrData, int Color, int EdgeColor, BASEIMAGE* DestImage, RECT* ClipRect, int FontHandle, int VerticalFlag = FALSE, SIZE* DrawSizeP = null);

    extern int FontBaseImageBlt(int x, int y, LPCTSTR StrData, BASEIMAGE* DestImage, BASEIMAGE* DestEdgeImage, int VerticalFlag = FALSE);

    extern int FontBaseImageBltToHandle(int x, int y, LPCTSTR StrData, BASEIMAGE* DestImage, BASEIMAGE* DestEdgeImage, int FontHandle, int VerticalFlag = FALSE);

    extern int GetFontMaxWidth();

    extern int GetFontMaxWidthToHandle(int FontHandle);

    extern int GetFontCharInfo(int FontHandle, LPCTSTR Char, int* DrawX, int* DrawY, int* NextCharX, int* SizeX, int* SizeY);

    extern int GetDrawStringWidth(LPCTSTR String, int StrLen, int VerticalFlag = FALSE);

    extern int GetDrawFormatStringWidth(LPCTSTR FormatString,...);

    extern int GetDrawStringWidthToHandle(LPCTSTR String, int StrLen, int FontHandle, int VerticalFlag = FALSE);

    extern int GetDrawFormatStringWidthToHandle(int FontHandle, LPCTSTR FormatString,...);

    extern int GetDrawExtendStringWidth(double ExRateX, LPCTSTR String, int StrLen, int VerticalFlag = FALSE);

    extern int GetDrawExtendFormatStringWidth(double ExRateX, LPCTSTR FormatString,...);

    extern int GetDrawExtendStringWidthToHandle(double ExRateX, LPCTSTR String, int StrLen, int FontHandle, int VerticalFlag = FALSE);

    extern int GetDrawExtendFormatStringWidthToHandle(double ExRateX, int FontHandle, LPCTSTR FormatString,...);

    extern int GetFontStateToHandle(TCHAR* FontName, int* Size, int* Thick, int FontHandle);

    extern int GetDefaultFontHandle();

    extern int GetFontChacheToTextureFlag();

    extern int GetFontCacheToTextureFlag();

    extern int CheckFontChacheToTextureFlag(int FontHandle);

    extern int CheckFontCacheToTextureFlag(int FontHandle);

    extern int CheckFontHandleValid(int FontHandle);

    extern int MultiByteCharCheck(LPCSTR Buf, int CharSet);

    extern int GetFontCacheCharNum();

    extern int GetFontSize();

    extern int GetFontSizeToHandle(int FontHandle);

    extern int CreateIdentityMatrix(MATRIX* Out);

    extern int CreateLookAtMatrix(MATRIX* Out, VECTOR* Eye, VECTOR* At, VECTOR* Up);

    extern int CreateLookAtMatrix2(MATRIX* Out, VECTOR* Eye, double XZAngle, double Oira);

    extern int CreateLookAtMatrixRH(MATRIX* Out, VECTOR* Eye, VECTOR* At, VECTOR* Up);

    extern int CreateMultiplyMatrix(MATRIX* Out, MATRIX* In1, MATRIX* In2);

    extern int CreatePerspectiveFovMatrix(MATRIX* Out, float fov, float zn, float zf, float aspect = -1F);

    extern int CreatePerspectiveFovMatrixRH(MATRIX* Out, float fov, float zn, float zf, float aspect = -1F);

    extern int CreateOrthoMatrix(MATRIX* Out, float size, float zn, float zf, float aspect = -1F);

    extern int CreateOrthoMatrixRH(MATRIX* Out, float size, float zn, float zf, float aspect = -1F);

    extern int CreateScalingMatrix(MATRIX* Out, float sx, float sy, float sz);

    extern int CreateRotationXMatrix(MATRIX* Out, float Angle);

    extern int CreateRotationYMatrix(MATRIX* Out, float Angle);

    extern int CreateRotationZMatrix(MATRIX* Out, float Angle);

    extern int CreateTranslationMatrix(MATRIX* Out, float x, float y, float z);

    extern int CreateTransposeMatrix(MATRIX* Out, MATRIX* In);

    extern int CreateInverseMatrix(MATRIX* Out, MATRIX* In);

    extern int CreateViewportMatrix(MATRIX* Out, float CenterX, float CenterY, float Width, float Height);

    extern int CreateRotationXYZMatrix(MATRIX* Out, float XRot, float YRot, float ZRot);

    extern int CreateRotationXZYMatrix(MATRIX* Out, float XRot, float YRot, float ZRot);

    extern int CreateRotationYXZMatrix(MATRIX* Out, float XRot, float YRot, float ZRot);

    extern int CreateRotationYZXMatrix(MATRIX* Out, float XRot, float YRot, float ZRot);

    extern int CreateRotationZXYMatrix(MATRIX* Out, float XRot, float YRot, float ZRot);

    extern int CreateRotationZYXMatrix(MATRIX* Out, float XRot, float YRot, float ZRot);

    extern int GetMatrixXYZRotation(MATRIX* In, float* OutXRot, float* OutYRot, float* OutZRot);

    extern int GetMatrixXZYRotation(MATRIX* In, float* OutXRot, float* OutYRot, float* OutZRot);

    extern int GetMatrixYXZRotation(MATRIX* In, float* OutXRot, float* OutYRot, float* OutZRot);

    extern int GetMatrixYZXRotation(MATRIX* In, float* OutXRot, float* OutYRot, float* OutZRot);

    extern int GetMatrixZXYRotation(MATRIX* In, float* OutXRot, float* OutYRot, float* OutZRot);

    extern int GetMatrixZYXRotation(MATRIX* In, float* OutXRot, float* OutYRot, float* OutZRot);

    extern int VectorNormalize(VECTOR* Out, VECTOR* In);

    extern int VectorScale(VECTOR* Out, VECTOR* In, float Scale);

    extern int VectorMultiply(VECTOR* Out, VECTOR* In1, VECTOR* In2);

    extern int VectorSub(VECTOR* Out, VECTOR* In1, VECTOR* In2);

    extern int VectorAdd(VECTOR* Out, VECTOR* In1, VECTOR* In2);

    extern int VectorOuterProduct(VECTOR* Out, VECTOR* In1, VECTOR* In2);

    extern float VectorInnerProduct(VECTOR* In1, VECTOR* In2);

    extern int VectorRotationX(VECTOR* Out, VECTOR* In, double Angle);

    extern int VectorRotationY(VECTOR* Out, VECTOR* In, double Angle);

    extern int VectorRotationZ(VECTOR* Out, VECTOR* In, double Angle);

    extern int VectorTransform(VECTOR* Out, VECTOR* InVec, MATRIX* InMatrix);

    extern int VectorTransform4(VECTOR* Out, float* V4Out, VECTOR* InVec, float* V4In, MATRIX* InMatrix);

    extern void TriangleBarycenter(VECTOR TrianglePos1, VECTOR TrianglePos2, VECTOR TrianglePos3, VECTOR Position, float* u, float* v, float* w);

    extern float Segment_Segment_MinLength(VECTOR SegmentAPos1, VECTOR SegmentAPos2, VECTOR SegmentBPos1, VECTOR SegmentBPos2);

    extern float Segment_Segment_MinLength_Square(VECTOR SegmentAPos1, VECTOR SegmentAPos2, VECTOR SegmentBPos1, VECTOR SegmentBPos2);

    extern float Segment_Triangle_MinLength(VECTOR SegmentPos1, VECTOR SegmentPos2, VECTOR TrianglePos1, VECTOR TrianglePos2, VECTOR TrianglePos3);

    extern float Segment_Triangle_MinLength_Square(VECTOR SegmentPos1, VECTOR SegmentPos2, VECTOR TrianglePos1, VECTOR TrianglePos2, VECTOR TrianglePos3);

    extern float Segment_Point_MinLength(VECTOR SegmentPos1, VECTOR SegmentPos2, VECTOR PointPos);

    extern float Segment_Point_MinLength_Square(VECTOR SegmentPos1, VECTOR SegmentPos2, VECTOR PointPos);

    extern float Triangle_Point_MinLength(VECTOR TrianglePos1, VECTOR TrianglePos2, VECTOR TrianglePos3, VECTOR PointPos);

    extern float Triangle_Point_MinLength_Square(VECTOR TrianglePos1, VECTOR TrianglePos2, VECTOR TrianglePos3, VECTOR PointPos);

    extern HITRESULT_LINE HitCheck_Line_Triangle(VECTOR LinePos1, VECTOR LinePos2, VECTOR TrianglePos1, VECTOR TrianglePos2, VECTOR TrianglePos3);

    extern int HitCheck_Triangle_Triangle(VECTOR Triangle1Pos1, VECTOR Triangle1Pos2, VECTOR Triangle1Pos3, VECTOR Triangle2Pos1, VECTOR Triangle2Pos2, VECTOR Triangle2Pos3);

    extern int HitCheck_Line_Sphere(VECTOR LinePos1, VECTOR LinePos2, VECTOR SphereCenterPos, float SphereR);

    extern int HitCheck_Sphere_Sphere(VECTOR Sphere1CenterPos, float Sphere1R, VECTOR Sphere2CenterPos, float Sphere2R);

    extern int HitCheck_Sphere_Triangle(VECTOR SphereCenterPos, float SphereR, VECTOR TrianglePos1, VECTOR TrianglePos2, VECTOR TrianglePos3);

    extern int HitCheck_Capsule_Capsule(VECTOR Cap1Pos1, VECTOR Cap1Pos2, float Cap1R, VECTOR Cap2Pos1, VECTOR Cap2Pos2, float Cap2R);

    extern int HitCheck_Capsule_Triangle(VECTOR CapPos1, VECTOR CapPos2, float CapR, VECTOR TrianglePos1, VECTOR TrianglePos2, VECTOR TrianglePos3);

    extern int RectClipping(RECT* MotoRect, RECT* ClippuRect);

    extern int RectAdjust(RECT* Rect);

    extern int GetRectSize(RECT* Rect, int* Width, int* Height);

    extern MATRIX MGetIdent();

    extern MATRIX MMult(MATRIX In1, MATRIX In2);

    extern MATRIX MScale(MATRIX InM, float Scale);

    extern MATRIX MAdd(MATRIX In1, MATRIX In2);

    extern MATRIX MGetScale(VECTOR Scale);

    extern MATRIX MGetRotX(float XAxisRotate);

    extern MATRIX MGetRotY(float YAxisRotate);

    extern MATRIX MGetRotZ(float ZAxisRotate);

    extern MATRIX MGetRotAxis(VECTOR RotateAxis, float Rotate);

    extern MATRIX MGetRotVec2(VECTOR In1, VECTOR In2);

    extern MATRIX MGetTranslate(VECTOR Trans);

    extern MATRIX MGetAxis1(VECTOR XAxis, VECTOR YAxis, VECTOR ZAxis, VECTOR Pos);

    extern MATRIX MGetAxis2(VECTOR XAxis, VECTOR YAxis, VECTOR ZAxis, VECTOR Pos);

    extern MATRIX MTranspose(MATRIX InM);

    extern MATRIX MInverse(MATRIX InM);

    extern VECTOR MGetSize(MATRIX InM);

    extern (D) VECTOR VGet(float x, float y, float z)
{
return VECTOR(x,y,z);
}

    extern (D) VECTOR VAdd(ref VECTOR In1, ref VECTOR In2)
{
return VECTOR(In1.x + In2.x,In1.y + In2.y,In1.z + In2.z);
}

    extern (D) VECTOR VSub(ref VECTOR In1, ref VECTOR In2)
{
return VECTOR(In1.x - In2.x,In1.y - In2.y,In1.z - In2.z);
}

    extern (D) float VDot(ref VECTOR In1, ref VECTOR In2)
{
return In1.x * In2.x + In1.y * In2.y + In1.z * In2.z;
}

    extern (D) VECTOR VCross(ref VECTOR In1, ref VECTOR In2)
{
return VECTOR(In1.y * In2.z - In1.z * In2.y,In1.z * In2.x - In1.x * In2.z,In1.x * In2.y - In1.y * In2.x);
}

    extern (D) VECTOR VScale(ref VECTOR In, float Scale)
{
return VECTOR(In.x * Scale,In.y * Scale,In.z * Scale);
}

    extern VECTOR VNorm(VECTOR In);

    extern float VSize(VECTOR In);

    extern (D) float VSquareSize(ref VECTOR In)
{
return In.x * In.x + In.y * In.y + In.z * In.z;
}

    extern (D) VECTOR VTransform(ref VECTOR InV, ref MATRIX InM)
{
return VECTOR(InV.x * InM.m[0][0] + InV.y * InM.m[1][0] + InV.z * InM.m[2][0] + InM.m[3][0],InV.x * InM.m[0][1] + InV.y * InM.m[1][1] + InV.z * InM.m[2][1] + InM.m[3][1],InV.x * InM.m[0][2] + InV.y * InM.m[1][2] + InV.z * InM.m[2][2] + InM.m[3][2]);
}

    extern (D) VECTOR VTransformSR(ref VECTOR InV, ref MATRIX InM)
{
return VECTOR(InV.x * InM.m[0][0] + InV.y * InM.m[1][0] + InV.z * InM.m[2][0],InV.x * InM.m[0][1] + InV.y * InM.m[1][1] + InV.z * InM.m[2][1],InV.x * InM.m[0][2] + InV.y * InM.m[1][2] + InV.z * InM.m[2][2]);
}

    extern float VCos(VECTOR In1, VECTOR In2);

    extern float VRad(VECTOR In1, VECTOR In2);

    extern int CreateGraphImageOrDIBGraph(LPCTSTR FileName, void* DataImage, int DataImageSize, int DataImageType, int BmpFlag, int ReverseFlag, BASEIMAGE* Image, BITMAPINFO** BmpInfo, void** GraphData);

    extern int CreateGraphImageType2(STREAMDATA* Src, BASEIMAGE* Dest);

    extern int CreateBmpInfo(BITMAPINFO* BmpInfo, int Width, int Height, int Pitch, void* SrcGrData, void** DestGrData);

    extern HBITMAP CreateDIBGraphVer2(LPCTSTR FileName, void* MemImage, int MemImageSize, int ImageType, int ReverseFlag, COLORDATA* SrcColor);

    extern int CreateDIBGraphVer2_plus_Alpha(LPCTSTR FileName, void* MemImage, int MemImageSize, void* AlphaImage, int AlphaImageSize, int ImageType, HBITMAP* RGBBmp, HBITMAP* AlphaBmp, int ReverseFlag, COLORDATA* SrcColor);

    extern DWORD GetGraphImageFullColorCode(BASEIMAGE* GraphImage, int x, int y);

    extern int CreateGraphImage_plus_Alpha(LPCTSTR FileName, void* RgbImage, int RgbImageSize, int RgbImageType, void* AlphaImage, int AlphaImageSize, int AlphaImageType, BASEIMAGE* RgbGraphImage, BASEIMAGE* AlphaGraphImage, int ReverseFlag);

    extern int ReverseGraphImage(BASEIMAGE* GraphImage);

    extern int ConvBitmapToGraphImage(BITMAPINFO* BmpInfo, void* GraphData, BASEIMAGE* GraphImage, int CopyFlag);

    extern int ConvGraphImageToBitmap(BASEIMAGE* GraphImage, BITMAPINFO* BmpInfo, void** GraphData, int CopyFlag, int FullColorConv = TRUE);

    extern HBITMAP CreateDIBGraph(LPCTSTR FileName, int ReverseFlag, COLORDATA* SrcColor);

    extern HBITMAP CreateDIBGraphToMem(BITMAPINFO* BmpInfo, void* GraphData, int ReverseFlag, COLORDATA* SrcColor);

    extern int CreateDIBGraph_plus_Alpha(LPCTSTR FileName, HBITMAP* RGBBmp, HBITMAP* AlphaBmp, int ReverseFlag = FALSE, COLORDATA* SrcColor = null);

    extern int AddUserGraphLoadFunction4(int function(STREAMDATA* Src, BASEIMAGE* Image) UserLoadFunc);

    extern int SubUserGraphLoadFunction4(int function(STREAMDATA* Src, BASEIMAGE* Image) UserLoadFunc);

    extern int SetUseFastLoadFlag(int Flag);

    extern int GetGraphDataShavedMode();

    extern int SetGraphDataShavedMode(int ShavedMode);

    extern int InitSoftImage();

    extern int LoadSoftImage(LPCTSTR FileName);

    extern int LoadSoftImageToMem(void* FileImage, int FileImageSize);

    extern int MakeSoftImage(int SizeX, int SizeY);

    extern int MakeARGB8ColorSoftImage(int SizeX, int SizeY);

    extern int MakeXRGB8ColorSoftImage(int SizeX, int SizeY);

    extern int MakeARGB4ColorSoftImage(int SizeX, int SizeY);

    extern int MakeRGB8ColorSoftImage(int SizeX, int SizeY);

    extern int MakePAL8ColorSoftImage(int SizeX, int SizeY);

    extern int DeleteSoftImage(int SIHandle);

    extern int GetSoftImageSize(int SIHandle, int* Width, int* Height);

    extern int CheckPaletteSoftImage(int SIHandle);

    extern int CheckAlphaSoftImage(int SIHandle);

    extern int CheckPixelAlphaSoftImage(int SIHandle);

    extern int GetDrawScreenSoftImage(int x1, int y1, int x2, int y2, int SIHandle);

    extern int UpdateLayerdWindowForSoftImage(int SIHandle);

    extern int FillSoftImage(int SIHandle, int r, int g, int b, int a);

    extern int ClearRectSoftImage(int SIHandle, int x, int y, int w, int h);

    extern int GetPaletteSoftImage(int SIHandle, int PaletteNo, int* r, int* g, int* b, int* a);

    extern int SetPaletteSoftImage(int SIHandle, int PaletteNo, int r, int g, int b, int a);

    extern int DrawPixelPalCodeSoftImage(int SIHandle, int x, int y, int palNo);

    extern int GetPixelPalCodeSoftImage(int SIHandle, int x, int y);

    extern void* GetImageAddressSoftImage(int SIHandle);

    extern int DrawPixelSoftImage(int SIHandle, int x, int y, int r, int g, int b, int a);

    extern int GetPixelSoftImage(int SIHandle, int x, int y, int* r, int* g, int* b, int* a);

    extern int DrawLineSoftImage(int SIHandle, int x1, int y1, int x2, int y2, int r, int g, int b, int a);

    extern int BltSoftImage(int SrcX, int SrcY, int SrcSizeX, int SrcSizeY, int SrcSIHandle, int DestX, int DestY, int DestSIHandle);

    extern int BltSoftImageWithTransColor(int SrcX, int SrcY, int SrcSizeX, int SrcSizeY, int SrcSIHandle, int DestX, int DestY, int DestSIHandle, int Tr, int Tg, int Tb, int Ta);

    extern int BltSoftImageWithAlphaBlend(int SrcX, int SrcY, int SrcSizeX, int SrcSizeY, int SrcSIHandle, int DestX, int DestY, int DestSIHandle, int Opacity = 255);

    extern int ReverseSoftImageH(int SIHandle);

    extern int ReverseSoftImageV(int SIHandle);

    extern int ReverseSoftImage(int SIHandle);

    extern int BltStringSoftImage(int x, int y, LPCTSTR StrData, int DestSIHandle, int DestEdgeSIHandle = -1, int VerticalFlag = FALSE);

    extern int BltStringSoftImageToHandle(int x, int y, LPCTSTR StrData, int DestSIHandle, int DestEdgeSIHandle, int FontHandle, int VerticalFlag = FALSE);

    extern int DrawSoftImage(int x, int y, int SIHandle);

    extern int SaveSoftImageToBmp(LPCTSTR FilePath, int SIHandle);

    extern int SaveSoftImageToPng(LPCTSTR FilePath, int SIHandle, int CompressionLevel);

    extern int SaveSoftImageToJpeg(LPCTSTR FilePath, int SIHandle, int Quality, int Sample2x1);

    extern int CreateBaseImage(LPCTSTR FileName, void* FileImage, int FileImageSize, int DataType, BASEIMAGE* BaseImage, int ReverseFlag);

    extern int CreateGraphImage(LPCTSTR FileName, void* DataImage, int DataImageSize, int DataImageType, BASEIMAGE* GraphImage, int ReverseFlag);

    extern int CreateBaseImageToFile(LPCTSTR FileName, BASEIMAGE* BaseImage, int ReverseFlag = FALSE);

    extern int CreateBaseImageToMem(void* FileImage, int FileImageSize, BASEIMAGE* BaseImage, int ReverseFlag = FALSE);

    extern int CreateARGB8ColorBaseImage(int SizeX, int SizeY, BASEIMAGE* BaseImage);

    extern int CreateXRGB8ColorBaseImage(int SizeX, int SizeY, BASEIMAGE* BaseImage);

    extern int CreateRGB8ColorBaseImage(int SizeX, int SizeY, BASEIMAGE* BaseImage);

    extern int CreateARGB4ColorBaseImage(int SizeX, int SizeY, BASEIMAGE* BaseImage);

    extern int CreatePAL8ColorBaseImage(int SizeX, int SizeY, BASEIMAGE* BaseImage);

    extern int CreateColorDataBaseImage(int SizeX, int SizeY, COLORDATA* ColorData, BASEIMAGE* BaseImage);

    extern int ReleaseBaseImage(BASEIMAGE* BaseImage);

    extern int ReleaseGraphImage(BASEIMAGE* GraphImage);

    extern int ConvertNormalFormatBaseImage(BASEIMAGE* BaseImage);

    extern int GetDrawScreenBaseImage(int x1, int y1, int x2, int y2, BASEIMAGE* BaseImage);

    extern int UpdateLayerdWindowForBaseImage(BASEIMAGE* BaseImage);

    extern int FillBaseImage(BASEIMAGE* BaseImage, int r, int g, int b, int a);

    extern int ClearRectBaseImage(BASEIMAGE* BaseImage, int x, int y, int w, int h);

    extern int GetPaletteBaseImage(BASEIMAGE* BaseImage, int PaletteNo, int* r, int* g, int* b, int* a);

    extern int SetPaletteBaseImage(BASEIMAGE* BaseImage, int PaletteNo, int r, int g, int b, int a);

    extern int SetPixelPalCodeBaseImage(BASEIMAGE* BaseImage, int x, int y, int palNo);

    extern int GetPixelPalCodeBaseImage(BASEIMAGE* BaseImage, int x, int y);

    extern int SetPixelBaseImage(BASEIMAGE* BaseImage, int x, int y, int r, int g, int b, int a);

    extern int GetPixelBaseImage(BASEIMAGE* BaseImage, int x, int y, int* r, int* g, int* b, int* a);

    extern int DrawLineBaseImage(BASEIMAGE* BaseImage, int x1, int y1, int x2, int y2, int r, int g, int b, int a);

    extern int BltBaseImage(int SrcX, int SrcY, int SrcSizeX, int SrcSizeY, int DestX, int DestY, BASEIMAGE* SrcBaseImage, BASEIMAGE* DestBaseImage);

    extern int b2_BltBaseImage(int DestX, int DestY, BASEIMAGE* SrcBaseImage, BASEIMAGE* DestBaseImage);

    extern int BltBaseImageWithTransColor(int SrcX, int SrcY, int SrcSizeX, int SrcSizeY, int DestX, int DestY, BASEIMAGE* SrcBaseImage, BASEIMAGE* DestBaseImage, int Tr, int Tg, int Tb, int Ta);

    extern int BltBaseImageWithAlphaBlend(int SrcX, int SrcY, int SrcSizeX, int SrcSizeY, int DestX, int DestY, BASEIMAGE* SrcBaseImage, BASEIMAGE* DestBaseImage, int Opacity = 255);

    extern int ReverseBaseImageH(BASEIMAGE* BaseImage);

    extern int ReverseBaseImageV(BASEIMAGE* BaseImage);

    extern int ReverseBaseImage(BASEIMAGE* BaseImage);

    extern int CheckPixelAlphaBaseImage(BASEIMAGE* BaseImage);

    extern int SaveBaseImageToBmp(LPCTSTR FilePath, BASEIMAGE* BaseImage);

    extern int SaveBaseImageToPng(LPCTSTR FilePath, BASEIMAGE* BaseImage, int CompressionLevel);

    extern int SaveBaseImageToJpeg(LPCTSTR FilePath, BASEIMAGE* BaseImage, int Quality, int Sample2x1);

    extern int GraphColorMatchBltVer2(void* DestGraphData, int DestPitch, COLORDATA* DestColorData, void* SrcGraphData, int SrcPitch, COLORDATA* SrcColorData, void* AlphaMask, int AlphaPitch, COLORDATA* AlphaColorData, POINT DestPoint, RECT* SrcRect, int ReverseFlag, int TransColorAlphaTestFlag, uint TransColor, int ImageShavedMode, int AlphaOnlyFlag = FALSE, int RedIsAlphaFlag = FALSE, int TransColorNoMoveFlag = FALSE, int Pal8ColorMatch = FALSE);

    extern COLOR_F GetColorF(float Red, float Green, float Blue, float Alpha);

    extern COLOR_U8 GetColorU8(int Red, int Green, int Blue, int Alpha);

    extern DWORD GetColor(int Red, int Green, int Blue);

    extern int GetColor2(int Color, int* Red, int* Green, int* Blue);

    extern int GetColor3(COLORDATA* ColorData, int Red, int Green, int Blue, int Alpha = 255);

    extern int GetColor4(COLORDATA* DestColorData, COLORDATA* SrcColorData, int SrcColor);

    extern int GetColor5(COLORDATA* ColorData, int Color, int* Red, int* Green, int* Blue, int* Alpha = null);

    extern int CreatePaletteColorData(COLORDATA* ColorDataBuf);

    extern int CreateXRGB8ColorData(COLORDATA* ColorDataBuf);

    extern int CreateARGB8ColorData(COLORDATA* ColorDataBuf);

    extern int CreateARGB4ColorData(COLORDATA* ColorDataBuf);

    extern int CreateFullColorData(COLORDATA* ColorDataBuf);

    extern int CreateGrayColorData(COLORDATA* ColorDataBuf);

    extern int CreatePal8ColorData(COLORDATA* ColorDataBuf);

    extern int CreateColorData(COLORDATA* ColorDataBuf, int ColorBitDepth, DWORD RedMask, DWORD GreenMask, DWORD BlueMask, DWORD AlphaMask);

    extern void SetColorDataNoneMask(COLORDATA* ColorData);

    extern int CmpColorData(COLORDATA* ColorData1, COLORDATA* ColorData2);

    extern int InitSoundMem(int LogOutFlag = FALSE);

    extern int AddSoundData(int Handle = -1);

    extern int AddStreamSoundMem(STREAMDATA* Stream, int LoopNum, int SoundHandle, int StreamDataType, int* CanStreamCloseFlag, int UnionHandle = -1);

    extern int AddStreamSoundMemToMem(void* FileImageBuffer, int ImageSize, int LoopNum, int SoundHandle, int StreamDataType, int UnionHandle = -1);

    extern int AddStreamSoundMemToFile(LPCTSTR WaveFile, int LoopNum, int SoundHandle, int StreamDataType, int UnionHandle = -1);

    extern int SetupStreamSoundMem(int SoundHandle);

    extern int PlayStreamSoundMem(int SoundHandle, int PlayType = DX_PLAYTYPE_LOOP, int TopPositionFlag = TRUE);

    extern int CheckStreamSoundMem(int SoundHandle);

    extern int StopStreamSoundMem(int SoundHandle);

    extern int SetStreamSoundCurrentPosition(int Byte, int SoundHandle);

    extern int GetStreamSoundCurrentPosition(int SoundHandle);

    extern int SetStreamSoundCurrentTime(int Time, int SoundHandle);

    extern int GetStreamSoundCurrentTime(int SoundHandle);

    extern int ProcessStreamSoundMem(int SoundHandle);

    extern int ProcessStreamSoundMemAll();

    extern int LoadSoundMem2(LPCTSTR WaveName1, LPCTSTR WaveName2);

    extern int LoadBGM(LPCTSTR WaveName);

    extern int LoadSoundMemBase(LPCTSTR WaveName, int BufferNum, int UnionHandle = -1);

    extern int LoadSoundMem(LPCTSTR WaveName, int BufferNum = 3, int UnionHandle = -1);

    extern int LoadSoundMemToBufNumSitei(LPCTSTR WaveName, int BufferNum);

    extern int LoadSoundMemByResource(LPCTSTR ResourceName, LPCTSTR ResourceType, int BufferNum = 1);

    extern int DuplicateSoundMem(int SrcSoundHandle, int BufferNum = 3);

    extern int LoadSoundMemByMemImageBase(void* FileImageBuffer, int ImageSize, int BufferNum, int UnionHandle = -1);

    extern int LoadSoundMemByMemImage(void* FileImageBuffer, int ImageSize, int UnionHandle = -1);

    extern int LoadSoundMemByMemImage2(void* UData, int UDataSize, WAVEFORMATEX* UFormat, int UHeaderSize);

    extern int LoadSoundMemByMemImageToBufNumSitei(void* FileImageBuffer, int ImageSize, int BufferNum);

    extern int LoadSoundMem2ByMemImage(void* FileImageBuffer1, int ImageSize1, void* FileImageBuffer2, int ImageSize2);

    extern int LoadSoundMemFromSoftSound(int SoftSoundHandle, int BufferNum = 3);

    extern int DeleteSoundMem(int SoundHandle, int LogOutFlag = FALSE);

    extern int PlaySoundMem(int SoundHandle, int PlayType, int TopPositionFlag = TRUE);

    extern int StopSoundMem(int SoundHandle);

    extern int CheckSoundMem(int SoundHandle);

    extern int SetPanSoundMem(int PanPal, int SoundHandle);

    extern int GetPanSoundMem(int SoundHandle);

    extern int SetVolumeSoundMem(int VolumePal, int SoundHandle);

    extern int ChangeVolumeSoundMem(int VolumePal, int SoundHandle);

    extern int GetVolumeSoundMem(int SoundHandle);

    extern int SetFrequencySoundMem(int FrequencyPal, int SoundHandle);

    extern int GetFrequencySoundMem(int SoundHandle);

    extern int SetNextPlayPanSoundMem(int PanPal, int SoundHandle);

    extern int SetNextPlayVolumeSoundMem(int VolumePal, int SoundHandle);

    extern int ChangeNextPlayVolumeSoundMem(int VolumePal, int SoundHandle);

    extern int SetNextPlayFrequencySoundMem(int FrequencyPal, int SoundHandle);

    extern int SetCurrentPositionSoundMem(int SamplePosition, int SoundHandle);

    extern int GetCurrentPositionSoundMem(int SoundHandle);

    extern int SetSoundCurrentPosition(int Byte, int SoundHandle);

    extern int GetSoundCurrentPosition(int SoundHandle);

    extern int SetSoundCurrentTime(int Time, int SoundHandle);

    extern int GetSoundCurrentTime(int SoundHandle);

    extern int GetSoundTotalSample(int SoundHandle);

    extern int GetSoundTotalTime(int SoundHandle);

    extern int SetLoopPosSoundMem(int LoopTime, int SoundHandle);

    extern int SetLoopTimePosSoundMem(int LoopTime, int SoundHandle);

    extern int SetLoopSamplePosSoundMem(int LoopSamplePosition, int SoundHandle);

    extern int SetLoopStartTimePosSoundMem(int LoopStartTime, int SoundHandle);

    extern int SetLoopStartSamplePosSoundMem(int LoopStartSamplePosition, int SoundHandle);

    extern int SetCreateSoundDataType(int SoundDataType);

    extern int GetCreateSoundDataType();

    extern int SetDisableReadSoundFunctionMask(int Mask);

    extern int GetDisableReadSoundFunctionMask();

    extern int SetEnableSoundCaptureFlag(int Flag);

    extern int SetUseSoftwareMixingSoundFlag(int Flag);

    extern void* GetDSoundObj();

    extern int SetBeepFrequency(int Freq);

    extern int PlayBeep();

    extern int StopBeep();

    extern int PlaySoundFile(LPCTSTR FileName, int PlayType);

    extern int PlaySound(LPCTSTR FileName, int PlayType);

    extern int CheckSoundFile();

    extern int CheckSound();

    extern int StopSoundFile();

    extern int StopSound();

    extern int SetVolumeSoundFile(int VolumePal);

    extern int SetVolumeSound(int VolumePal);

    extern int InitSoftSound();

    extern int LoadSoftSound(LPCTSTR FileName);

    extern int LoadSoftSoundFromMemImage(LPCVOID FileImageBuffer, int FileImageSize);

    extern int MakeSoftSound(int UseFormat_SoftSoundHandle, int SampleNum);

    extern int MakeSoftSound2Ch16Bit44KHz(int SampleNum);

    extern int MakeSoftSound2Ch16Bit22KHz(int SampleNum);

    extern int MakeSoftSound2Ch8Bit44KHz(int SampleNum);

    extern int MakeSoftSound2Ch8Bit22KHz(int SampleNum);

    extern int MakeSoftSound1Ch16Bit44KHz(int SampleNum);

    extern int MakeSoftSound1Ch16Bit22KHz(int SampleNum);

    extern int MakeSoftSound1Ch8Bit44KHz(int SampleNum);

    extern int MakeSoftSound1Ch8Bit22KHz(int SampleNum);

    extern int DeleteSoftSound(int SoftSoundHandle);

    extern int SaveSoftSound(int SoftSoundHandle, LPCTSTR FileName);

    extern int GetSoftSoundSampleNum(int SoftSoundHandle);

    extern int GetSoftSoundFormat(int SoftSoundHandle, int* Channels, int* BitsPerSample, int* SamplesPerSec);

    extern int ReadSoftSoundData(int SoftSoundHandle, int SamplePosition, int* Channel1, int* Channel2);

    extern int WriteSoftSoundData(int SoftSoundHandle, int SamplePosition, int Channel1, int Channel2);

    extern void* GetSoftSoundDataImage(int SoftSoundHandle);

    extern int InitSoftSoundPlayer();

    extern int MakeSoftSoundPlayer(int UseFormat_SoftSoundHandle);

    extern int MakeSoftSoundPlayer2Ch16Bit44KHz();

    extern int MakeSoftSoundPlayer2Ch16Bit22KHz();

    extern int MakeSoftSoundPlayer2Ch8Bit44KHz();

    extern int MakeSoftSoundPlayer2Ch8Bit22KHz();

    extern int MakeSoftSoundPlayer1Ch16Bit44KHz();

    extern int MakeSoftSoundPlayer1Ch16Bit22KHz();

    extern int MakeSoftSoundPlayer1Ch8Bit44KHz();

    extern int MakeSoftSoundPlayer1Ch8Bit22KHz();

    extern int DeleteSoftSoundPlayer(int SSoundPlayerHandle);

    extern int AddDataSoftSoundPlayer(int SSoundPlayerHandle, int SoftSoundHandle, int AddSamplePosition, int AddSampleNum);

    extern int AddDirectDataSoftSoundPlayer(int SSoundPlayerHandle, void* SoundData, int AddSampleNum);

    extern int AddOneDataSoftSoundPlayer(int SSoundPlayerHandle, int Channel1, int Channel2);

    extern int GetSoftSoundPlayerFormat(int SSoundPlayerHandle, int* Channels, int* BitsPerSample, int* SamplesPerSec);

    extern int StartSoftSoundPlayer(int SSoundPlayerHandle);

    extern int CheckStartSoftSoundPlayer(int SSoundPlayerHandle);

    extern int StopSoftSoundPlayer(int SSoundPlayerHandle);

    extern int ResetSoftSoundPlayer(int SSoundPlayerHandle);

    extern int GetStockDataLengthSoftSoundPlayer(int SSoundPlayerHandle);

    extern int CheckSoftSoundPlayerNoneData(int SSoundPlayerHandle);

    extern int AddMusicData();

    extern int DeleteMusicMem(int MusicHandle);

    extern int LoadMusicMem(LPCTSTR FileName);

    extern int LoadMusicMemByMemImage(void* FileImageBuffer, int FileImageSize);

    extern int LoadMusicMemByResource(LPCTSTR ResourceName, LPCTSTR ResourceType);

    extern int PlayMusicMem(int MusicHandle, int PlayType);

    extern int StopMusicMem(int MusicHandle);

    extern int CheckMusicMem(int MusicHandle);

    extern int GetMusicMemPosition(int MusicHandle);

    extern int InitMusicMem();

    extern int ProcessMusicMem();

    extern int PlayMusic(LPCTSTR FileName, int PlayType);

    extern int PlayMusicByMemImage(void* FileImageBuffer, int FileImageSize, int PlayType);

    extern int PlayMusicByResource(LPCTSTR ResourceName, LPCTSTR ResourceType, int PlayType);

    extern int SetVolumeMusic(int Volume);

    extern int StopMusic();

    extern int CheckMusic();

    extern int GetMusicPosition();

    extern int SelectMidiMode(int Mode);

    extern int DXArchivePreLoad(LPCTSTR FilePath, int ASync = FALSE);

    extern int DXArchiveCheckIdle(LPCTSTR FilePath);

    extern int DXArchiveRelease(LPCTSTR FilePath);

    extern int DXArchiveCheckFile(LPCTSTR FilePath, LPCTSTR TargetFilePath);

    extern int MV1LoadModel(LPCTSTR FileName);

    extern int MV1LoadModelFromMem(void* FileImage, int FileSize, int function(LPCTSTR FilePath, void** FileImageAddr, int* FileSize, void* FileReadFuncData) FileReadFunc, int function(void* MemoryAddr, void* FileReadFuncData) FileReleaseFunc, void* FileReadFuncData = null);

    extern int MV1DuplicateModel(int SrcMHandle);

    extern int MV1CreateCloneModel(int SrcMHandle);

    extern int MV1DeleteModel(int MHandle);

    extern int MV1SetLoadModelReMakeNormal(int Flag);

    extern int MV1SetLoadModelReMakeNormalSmoothingAngle(float SmoothingAngle = 0x1.8fe3c105186db50ep+0F);

    extern int MV1SetLoadModelPositionOptimize(int Flag);

    extern int MV1DrawModel(int MHandle);

    extern int MV1DrawFrame(int MHandle, int FrameIndex);

    extern int MV1DrawMesh(int MHandle, int MeshIndex);

    extern int MV1DrawModelDebug(int MHandle, int Color, int IsNormalLine, float NormalLineLength, int IsPolyLine, int IsCollisionBox);

    extern MATRIX MV1GetLocalWorldMatrix(int MHandle);

    extern int MV1SetPosition(int MHandle, VECTOR Position);

    extern VECTOR MV1GetPosition(int MHandle);

    extern int MV1SetScale(int MHandle, VECTOR Scale);

    extern VECTOR MV1GetScale(int MHandle);

    extern int MV1SetRotationXYZ(int MHandle, VECTOR Rotate);

    extern VECTOR MV1GetRotationXYZ(int MHandle);

    extern int MV1SetRotationZYAxis(int MHandle, VECTOR ZAxisDirection, VECTOR YAxisDirection, float ZAxisTwistRotate);

    extern int MV1SetRotationMatrix(int MHandle, MATRIX Matrix);

    extern MATRIX MV1GetRotationMatrix(int MHandle);

    extern int MV1SetMatrix(int MHandle, MATRIX Matrix);

    extern MATRIX MV1GetMatrix(int MHandle);

    extern int MV1SetVisible(int MHandle, int VisibleFlag);

    extern int MV1GetVisible(int MHandle);

    extern int MV1SetDifColorScale(int MHandle, COLOR_F Scale);

    extern COLOR_F MV1GetDifColorScale(int MHandle);

    extern int MV1SetSpcColorScale(int MHandle, COLOR_F Scale);

    extern COLOR_F MV1GetSpcColorScale(int MHandle);

    extern int MV1SetEmiColorScale(int MHandle, COLOR_F Scale);

    extern COLOR_F MV1GetEmiColorScale(int MHandle);

    extern int MV1SetAmbColorScale(int MHandle, COLOR_F Scale);

    extern COLOR_F MV1GetAmbColorScale(int MHandle);

    extern int MV1GetSemiTransState(int MHandle);

    extern int MV1SetOpacityRate(int MHandle, float Rate);

    extern float MV1GetOpacityRate(int MHandle);

    extern int MV1SetUseZBuffer(int MHandle, int Flag);

    extern int MV1SetWriteZBuffer(int MHandle, int Flag);

    extern int MV1SetZBufferCmpType(int MHandle, int CmpType);

    extern int MV1SetZBias(int MHandle, int Bias);

    extern int MV1SetUseVertDifColor(int MHandle, int UseFlag);

    extern int MV1SetUseVertSpcColor(int MHandle, int UseFlag);

    extern int MV1SetSampleFilterMode(int MHandle, int FilterMode);

    extern int MV1SetMaxAnisotropy(int MHandle, int MaxAnisotropy);

    extern int MV1SetWireFrameDrawFlag(int MHandle, int Flag);

    extern int MV1RefreshVertColorFromMaterial(int MHandle);

    extern int MV1AttachAnim(int MHandle, int AnimIndex, int AnimSrcMHandle = -1, int NameCheck = TRUE);

    extern int MV1DetachAnim(int MHandle, int AttachIndex);

    extern int MV1SetAttachAnimTime(int MHandle, int AttachIndex, float Time);

    extern float MV1GetAttachAnimTime(int MHandle, int AttachIndex);

    extern float MV1GetAttachAnimTotalTime(int MHandle, int AttachIndex);

    extern int MV1SetAttachAnimBlendRate(int MHandle, int AttachIndex, float Rate = 1F);

    extern float MV1GetAttachAnimBlendRate(int MHandle, int AttachIndex);

    extern int MV1SetAttachAnimBlendRateToFrame(int MHandle, int AttachIndex, int FrameIndex, float Rate, int SetChild = TRUE);

    extern float MV1GetAttachAnimBlendRateToFrame(int MHandle, int AttachIndex, int FrameIndex);

    extern int MV1GetAttachAnim(int MHandle, int AttachIndex);

    extern int MV1GetAnimNum(int MHandle);

    extern LPCTSTR MV1GetAnimName(int MHandle, int AnimIndex);

    extern int MV1GetAnimIndex(int MHandle, LPCTSTR AnimName);

    extern float MV1GetAnimTotalTime(int MHandle, int AnimIndex);

    extern int MV1GetAnimTargetFrameNum(int MHandle, int AnimIndex);

    extern LPCTSTR MV1GetAnimTargetFrameName(int MHandle, int AnimIndex, int AnimFrameIndex);

    extern int MV1GetAnimTargetFrame(int MHandle, int AnimIndex, int AnimFrameIndex);

    extern int MV1GetAnimTargetFrameKeySetNum(int MHandle, int AnimIndex, int AnimFrameIndex);

    extern int MV1GetAnimTargetFrameKeySet(int MHandle, int AnimIndex, int AnimFrameIndex, int Index);

    extern int MV1GetAnimKeySetNum(int MHandle);

    extern int MV1GetAnimKeySetType(int MHandle, int AnimKeySetIndex);

    extern int MV1GetAnimKeySetDataType(int MHandle, int AnimKeySetIndex);

    extern int MV1GetAnimKeySetTimeType(int MHandle, int AnimKeySetIndex);

    extern int MV1GetAnimKeySetDataNum(int MHandle, int AnimKeySetIndex);

    extern float MV1GetAnimKeyDataTime(int MHandle, int AnimKeySetIndex, int Index);

    extern FLOAT4 MV1GetAnimKeyDataToQuaternion(int MHandle, int AnimKeySetIndex, int Index);

    extern FLOAT4 MV1GetAnimKeyDataToQuaternionFromTime(int MHandle, int AnimKeySetIndex, float Time);

    extern VECTOR MV1GetAnimKeyDataToVector(int MHandle, int AnimKeySetIndex, int Index);

    extern VECTOR MV1GetAnimKeyDataToVectorFromTime(int MHandle, int AnimKeySetIndex, float Time);

    extern MATRIX MV1GetAnimKeyDataToMatrix(int MHandle, int AnimKeySetIndex, int Index);

    extern MATRIX MV1GetAnimKeyDataToMatrixFromTime(int MHandle, int AnimKeySetIndex, float Time);

    extern float MV1GetAnimKeyDataToFlat(int MHandle, int AnimKeySetIndex, int Index);

    extern float MV1GetAnimKeyDataToFlatFromTime(int MHandle, int AnimKeySetIndex, float Time);

    extern float MV1GetAnimKeyDataToLinear(int MHandle, int AnimKeySetIndex, int Index);

    extern float MV1GetAnimKeyDataToLinearFromTime(int MHandle, int AnimKeySetIndex, float Time);

    extern int MV1GetMaterialNum(int MHandle);

    extern LPCTSTR MV1GetMaterialName(int MHandle, int MaterialIndex);

    extern int MV1SetMaterialType(int MHandle, int MaterialIndex, int Type);

    extern int MV1GetMaterialType(int MHandle, int MaterialIndex);

    extern int MV1SetMaterialDifColor(int MHandle, int MaterialIndex, COLOR_F Color);

    extern COLOR_F MV1GetMaterialDifColor(int MHandle, int MaterialIndex);

    extern int MV1SetMaterialSpcColor(int MHandle, int MaterialIndex, COLOR_F Color);

    extern COLOR_F MV1GetMaterialSpcColor(int MHandle, int MaterialIndex);

    extern int MV1SetMaterialEmiColor(int MHandle, int MaterialIndex, COLOR_F Color);

    extern COLOR_F MV1GetMaterialEmiColor(int MHandle, int MaterialIndex);

    extern int MV1SetMaterialAmbColor(int MHandle, int MaterialIndex, COLOR_F Color);

    extern COLOR_F MV1GetMaterialAmbColor(int MHandle, int MaterialIndex);

    extern int MV1SetMaterialSpcPower(int MHandle, int MaterialIndex, float Power);

    extern float MV1GetMaterialSpcPower(int MHandle, int MaterialIndex);

    extern int MV1SetMaterialDifMapTexture(int MHandle, int MaterialIndex, int TexIndex);

    extern int MV1GetMaterialDifMapTexture(int MHandle, int MaterialIndex);

    extern int MV1SetMaterialSpcMapTexture(int MHandle, int MaterialIndex, int TexIndex);

    extern int MV1GetMaterialSpcMapTexture(int MHandle, int MaterialIndex);

    extern int MV1GetMaterialNormalMapTexture(int MHandle, int MaterialIndex);

    extern int MV1SetMaterialDifGradTexture(int MHandle, int MaterialIndex, int TexIndex);

    extern int MV1GetMaterialDifGradTexture(int MHandle, int MaterialIndex);

    extern int MV1SetMaterialSpcGradTexture(int MHandle, int MaterialIndex, int TexIndex);

    extern int MV1GetMaterialSpcGradTexture(int MHandle, int MaterialIndex);

    extern int MV1SetMaterialDifGradBlendType(int MHandle, int MaterialIndex, int BlendType);

    extern int MV1GetMaterialDifGradBlendType(int MHandle, int MaterialIndex);

    extern int MV1SetMaterialSpcGradBlendType(int MHandle, int MaterialIndex, int BlendType);

    extern int MV1GetMaterialSpcGradBlendType(int MHandle, int MaterialIndex);

    extern int MV1SetMaterialOutLineWidth(int MHandle, int MaterialIndex, float Width);

    extern float MV1GetMaterialOutLineWidth(int MHandle, int MaterialIndex);

    extern int MV1SetMaterialOutLineDotWidth(int MHandle, int MaterialIndex, float Width);

    extern float MV1GetMaterialOutLineDotWidth(int MHandle, int MaterialIndex);

    extern int MV1SetMaterialOutLineColor(int MHandle, int MaterialIndex, COLOR_F Color);

    extern COLOR_F MV1GetMaterialOutLineColor(int MHandle, int MaterialIndex);

    extern int MV1SetMaterialDrawBlendMode(int MHandle, int MaterialIndex, int BlendMode);

    extern int MV1GetMaterialDrawBlendMode(int MHandle, int MaterialIndex);

    extern int MV1SetMaterialDrawBlendParam(int MHandle, int MaterialIndex, int BlendParam);

    extern int MV1GetMaterialDrawBlendParam(int MHandle, int MaterialIndex);

    extern int MV1GetTextureNum(int MHandle);

    extern LPCTSTR MV1GetTextureName(int MHandle, int TexIndex);

    extern int MV1SetTextureColorFilePath(int MHandle, int TexIndex, LPCTSTR FilePath);

    extern LPCTSTR MV1GetTextureColorFilePath(int MHandle, int TexIndex);

    extern int MV1SetTextureAlphaFilePath(int MHandle, int TexIndex, LPCTSTR FilePath);

    extern LPCTSTR MV1GetTextureAlphaFilePath(int MHandle, int TexIndex);

    extern int MV1SetTextureGraphHandle(int MHandle, int TexIndex, int GrHandle, int SemiTransFlag);

    extern int MV1GetTextureGraphHandle(int MHandle, int TexIndex);

    extern int MV1SetTextureAddressMode(int MHandle, int TexIndex, int AddrUMode, int AddrVMode);

    extern int MV1GetTextureAddressModeU(int MHandle, int TexIndex);

    extern int MV1GetTextureAddressModeV(int MHandle, int TexIndex);

    extern int MV1GetTextureWidth(int MHandle, int TexIndex);

    extern int MV1GetTextureHeight(int MHandle, int TexIndex);

    extern int MV1GetTextureSemiTransState(int MHandle, int TexIndex);

    extern int MV1SetTextureBumpImageFlag(int MHandle, int TexIndex, int Flag);

    extern int MV1GetTextureBumpImageFlag(int MHandle, int TexIndex);

    extern int MV1SetTextureBumpImageNextPixelLength(int MHandle, int TexIndex, float Length);

    extern float MV1GetTextureBumpImageNextPixelLength(int MHandle, int TexIndex);

    extern int MV1SetTextureSampleFilterMode(int MHandle, int TexIndex, int FilterMode);

    extern int MV1GetTextureSampleFilterMode(int MHandle, int TexIndex);

    extern int MV1LoadTexture(LPCTSTR FilePath);

    extern int MV1GetFrameNum(int MHandle);

    extern int MV1SearchFrame(int MHandle, LPCTSTR FrameName);

    extern int MV1SearchFrameChild(int MHandle, int FrameIndex = -1, LPCTSTR ChildName = null);

    extern LPCTSTR MV1GetFrameName(int MHandle, int FrameIndex);

    extern int MV1GetFrameParent(int MHandle, int FrameIndex);

    extern int MV1GetFrameChildNum(int MHandle, int FrameIndex = -1);

    extern int MV1GetFrameChild(int MHandle, int FrameIndex = -1, int ChildIndex = 0);

    extern VECTOR MV1GetFramePosition(int MHandle, int FrameIndex);

    extern MATRIX MV1GetFrameBaseLocalMatrix(int MHandle, int FrameIndex);

    extern MATRIX MV1GetFrameLocalMatrix(int MHandle, int FrameIndex);

    extern MATRIX MV1GetFrameLocalWorldMatrix(int MHandle, int FrameIndex);

    extern int MV1SetFrameUserLocalMatrix(int MHandle, int FrameIndex, MATRIX Matrix);

    extern int MV1ResetFrameUserLocalMatrix(int MHandle, int FrameIndex);

    extern VECTOR MV1GetFrameMaxVertexLocalPosition(int MHandle, int FrameIndex);

    extern VECTOR MV1GetFrameMinVertexLocalPosition(int MHandle, int FrameIndex);

    extern VECTOR MV1GetFrameAvgVertexLocalPosition(int MHandle, int FrameIndex);

    extern int MV1GetFrameTriangleNum(int MHandle, int FrameIndex);

    extern int MV1GetFrameMeshNum(int MHandle, int FrameIndex);

    extern int MV1GetFrameMesh(int MHandle, int FrameIndex, int Index);

    extern int MV1SetFrameVisible(int MHandle, int FrameIndex, int VisibleFlag);

    extern int MV1GetFrameVisible(int MHandle, int FrameIndex);

    extern int MV1SetFrameDifColorScale(int MHandle, int FrameIndex, COLOR_F Scale);

    extern int MV1SetFrameSpcColorScale(int MHandle, int FrameIndex, COLOR_F Scale);

    extern int MV1SetFrameEmiColorScale(int MHandle, int FrameIndex, COLOR_F Scale);

    extern int MV1SetFrameAmbColorScale(int MHandle, int FrameIndex, COLOR_F Scale);

    extern COLOR_F MV1GetFrameDifColorScale(int MHandle, int FrameIndex);

    extern COLOR_F MV1GetFrameSpcColorScale(int MHandle, int FrameIndex);

    extern COLOR_F MV1GetFrameEmiColorScale(int MHandle, int FrameIndex);

    extern COLOR_F MV1GetFrameAmbColorScale(int MHandle, int FrameIndex);

    extern int MV1GetFrameSemiTransState(int MHandle, int FrameIndex);

    extern int MV1SetFrameOpacityRate(int MHandle, int FrameIndex, float Rate);

    extern float MV1GetFrameOpacityRate(int MHandle, int FrameIndex);

    extern int MV1SetFrameBaseVisible(int MHandle, int FrameIndex, int VisibleFlag);

    extern int MV1GetFrameBaseVisible(int MHandle, int FrameIndex);

    extern int MV1SetFrameTextureAddressTransform(int MHandle, int FrameIndex, float TransU, float TransV, float ScaleU, float ScaleV, float RotCenterU, float RotCenterV, float Rotate);

    extern int MV1SetFrameTextureAddressTransformMatrix(int MHandle, int FrameIndex, MATRIX Matrix);

    extern int MV1ResetFrameTextureAddressTransform(int MHandle, int FrameIndex);

    extern int MV1GetMeshNum(int MHandle);

    extern int MV1GetMeshMaterial(int MHandle, int MeshIndex);

    extern int MV1GetMeshTriangleNum(int MHandle, int MeshIndex);

    extern int MV1SetMeshVisible(int MHandle, int MeshIndex, int VisibleFlag);

    extern int MV1GetMeshVisible(int MHandle, int MeshIndex);

    extern int MV1SetMeshDifColorScale(int MHandle, int MeshIndex, COLOR_F Scale);

    extern int MV1SetMeshSpcColorScale(int MHandle, int MeshIndex, COLOR_F Scale);

    extern int MV1SetMeshEmiColorScale(int MHandle, int MeshIndex, COLOR_F Scale);

    extern int MV1SetMeshAmbColorScale(int MHandle, int MeshIndex, COLOR_F Scale);

    extern COLOR_F MV1GetMeshDifColorScale(int MHandle, int MeshIndex);

    extern COLOR_F MV1GetMeshSpcColorScale(int MHandle, int MeshIndex);

    extern COLOR_F MV1GetMeshEmiColorScale(int MHandle, int MeshIndex);

    extern COLOR_F MV1GetMeshAmbColorScale(int MHandle, int MeshIndex);

    extern int MV1SetMeshOpacityRate(int MHandle, int MeshIndex, float Rate);

    extern float MV1GetMeshOpacityRate(int MHandle, int MeshIndex);

    extern int MV1SetMeshDrawBlendMode(int MHandle, int MeshIndex, int BlendMode);

    extern int MV1SetMeshDrawBlendParam(int MHandle, int MeshIndex, int BlendParam);

    extern int MV1GetMeshDrawBlendMode(int MHandle, int MeshIndex);

    extern int MV1GetMeshDrawBlendParam(int MHandle, int MeshIndex);

    extern int MV1SetMeshBaseVisible(int MHandle, int MeshIndex, int VisibleFlag);

    extern int MV1GetMeshBaseVisible(int MHandle, int MeshIndex);

    extern int MV1SetMeshBackCulling(int MHandle, int MeshIndex, int CullingFlag);

    extern int MV1GetMeshBackCulling(int MHandle, int MeshIndex);

    extern VECTOR MV1GetMeshMaxPosition(int MHandle, int MeshIndex);

    extern VECTOR MV1GetMeshMinPosition(int MHandle, int MeshIndex);

    extern int MV1GetMeshTListNum(int MHandle, int MeshIndex);

    extern int MV1GetMeshTList(int MHandle, int MeshIndex, int Index);

    extern int MV1GetMeshSemiTransState(int MHandle, int MeshIndex);

    extern int MV1SetMeshUseVertDifColor(int MHandle, int MeshIndex, int UseFlag);

    extern int MV1SetMeshUseVertSpcColor(int MHandle, int MeshIndex, int UseFlag);

    extern int MV1GetMeshUseVertDifColor(int MHandle, int MeshIndex);

    extern int MV1GetMeshUseVertSpcColor(int MHandle, int MeshIndex);

    extern int MV1GetTriangleListNum(int MHandle);

    extern int MV1GetTriangleListVertexType(int MHandle, int TListIndex);

    extern int MV1GetTriangleListPolygonNum(int MHandle, int TListIndex);

    extern int MV1GetTriangleListVertexNum(int MHandle, int TListIndex);

    extern int MV1SetupCollInfo(int MHandle, int FrameIndex = -1, int XDivNum = 32, int YDivNum = 8, int ZDivNum = 32);

    extern int MV1TerminateCollInfo(int MHandle, int FrameIndex = -1);

    extern int MV1RefreshCollInfo(int MHandle, int FrameIndex = -1);

    extern MV1_COLL_RESULT_POLY MV1CollCheck_Line(int MHandle, int FrameIndex, VECTOR PosStart, VECTOR PosEnd);

    extern MV1_COLL_RESULT_POLY_DIM MV1CollCheck_LineDim(int MHandle, int FrameIndex, VECTOR PosStart, VECTOR PosEnd);

    extern MV1_COLL_RESULT_POLY_DIM MV1CollCheck_Sphere(int MHandle, int FrameIndex, VECTOR CenterPos, float r);

    extern MV1_COLL_RESULT_POLY_DIM MV1CollCheck_Capsule(int MHandle, int FrameIndex, VECTOR Pos1, VECTOR Pos2, float r);

    extern MV1_COLL_RESULT_POLY MV1CollCheck_GetResultPoly(MV1_COLL_RESULT_POLY_DIM ResultPolyDim, int PolyNo);

    extern int MV1CollResultPolyDimTerminate(MV1_COLL_RESULT_POLY_DIM ResultPolyDim);

    extern int MV1SetupReferenceMesh(int MHandle, int FrameIndex, int IsTransform);

    extern int MV1TerminateReferenceMesh(int MHandle, int FrameIndex, int IsTransform);

    extern int MV1RefreshReferenceMesh(int MHandle, int FrameIndex, int IsTransform);

    extern MV1_REF_POLYGONLIST MV1GetReferenceMesh(int MHandle, int FrameIndex, int IsTransform);

    alias b2_GetTexPixelFormat GetTexPixelFormat;
    alias b2_GetTexColorData GetTexColorData;
    alias b3_GetTexPixelFormat GetTexPixelFormat;
    alias b3_GetTexColorData GetTexColorData;
    alias b2_DrawChipMap DrawChipMap;
    alias b2_DrawPolygon3D DrawPolygon3D;
    alias b2_LoadGraphToResource LoadGraphToResource;
    alias b2_LoadDivGraphToResource LoadDivGraphToResource;
    alias b2_CreateGraphFromGraphImage CreateGraphFromGraphImage;
    alias b2_ReCreateGraphFromGraphImage ReCreateGraphFromGraphImage;
    alias b2_CreateDivGraphFromGraphImage CreateDivGraphFromGraphImage;
    alias b2_ReCreateDivGraphFromGraphImage ReCreateDivGraphFromGraphImage;
    alias b2_BltBaseImage BltBaseImage;
}
