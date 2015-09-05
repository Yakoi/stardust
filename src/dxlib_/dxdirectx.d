module dxlib.dxdirectx;
// ----------------------------------------------------------------------------
//
//		ＤＸライブラリ		DirectX 関連定義用ヘッダファイル
//
//				Ver2.24c
//
// ----------------------------------------------------------------------------


	
import dxlib.all;
import core.sys.windows.windows;
    //typedef uint DWORD;
    //typedef bool BOOL;
    //typedef long LONGLONG;
    //typedef wchar WCHAR;
    //typedef ushort WORD;
    //typedef long LONG;
    //typedef void* LPVOID;
	typedef void *D_HMONITOR ;

	// ＤｉｒｅｃｔＳｏｕｎｄ -----------------------------------------------------

//	const int D_DS_OK = (S_OK);

	const int D_DSBVOLUME_MIN = (-10000);
	const int D_DSBVOLUME_MAX = (0);

	const int D_DSSCL_NORMAL = (0x00000001);
	const int D_DSSCL_PRIORITY = (0x00000002);
	const int D_DSSCL_EXCLUSIVE = (0x00000003);
	const int D_DSSCL_WRITEPRIMARY = (0x00000004);

	const int D_DSBPLAY_LOOPING = (0x00000001);
	const int D_DSBSTATUS_PLAYING = (0x00000001);
	const int D_DSBFREQUENCY_ORIGINAL = (0);

	const int D_DSBCAPS_PRIMARYBUFFER = (0x00000001);
	const int D_DSBCAPS_STATIC = (0x00000002);
	const int D_DSBCAPS_CTRLFREQUENCY = (0x00000020);
	const int D_DSBCAPS_CTRLPAN = (0x00000040);
	const int D_DSBCAPS_CTRLVOLUME = (0x00000080);
	const int D_DSBCAPS_GLOBALFOCUS = (0x00008000);
	const int D_DSBCAPS_GETCURRENTPOSITION2 = (0x00010000);

	const int D_DSCAPS_PRIMARYMONO = (0x00000001);
	const int D_DSCAPS_PRIMARYSTEREO = (0x00000002);
	const int D_DSCAPS_PRIMARY8BIT = (0x00000004);
	const int D_DSCAPS_PRIMARY16BIT = (0x00000008);
	const int D_DSCAPS_SECONDARYMONO = (0x00000100);
	const int D_DSCAPS_SECONDARYSTEREO = (0x00000200);
	const int D_DSCAPS_SECONDARY8BIT = (0x00000400);
	const int D_DSCAPS_SECONDARY16BIT = (0x00000800);

	struct D_DSCAPS
	{
		DWORD										dwSize;
		DWORD										dwFlags;
		DWORD										dwMinSecondarySampleRate;
		DWORD										dwMaxSecondarySampleRate;
		DWORD										dwPrimaryBuffers;
		DWORD										dwMaxHwMixingAllBuffers;
		DWORD										dwMaxHwMixingStaticBuffers;
		DWORD										dwMaxHwMixingStreamingBuffers;
		DWORD										dwFreeHwMixingAllBuffers;
		DWORD										dwFreeHwMixingStaticBuffers;
		DWORD										dwFreeHwMixingStreamingBuffers;
		DWORD										dwMaxHw3DAllBuffers;
		DWORD										dwMaxHw3DStaticBuffers;
		DWORD										dwMaxHw3DStreamingBuffers;
		DWORD										dwFreeHw3DAllBuffers;
		DWORD										dwFreeHw3DStaticBuffers;
		DWORD										dwFreeHw3DStreamingBuffers;
		DWORD										dwTotalHwMemBytes;
		DWORD										dwFreeHwMemBytes;
		DWORD										dwMaxContigFreeHwMemBytes;
		DWORD										dwUnlockTransferRateHwBuffers;
		DWORD										dwPlayCpuOverheadSwBuffers;
		DWORD										dwReserved1;
		DWORD										dwReserved2;
	}

/+
	struct D_DSBUFFERDESC
	{
		DWORD										dwSize;
		DWORD										dwFlags;
		DWORD										dwBufferBytes;
		DWORD										dwReserved;
		LPWAVEFORMATEX								lpwfxFormat;

		GUID										guid3DAlgorithm;
	}
alias D_DSBUFFERDESC D_DSBUFFERDESC ;

	struct D_DSBPOSITIONNOTIFY
	{
		DWORD										dwOffset;
		HANDLE										hEventNotify;
	}
alias D_DSBPOSITIONNOTIFY D_DSBPOSITIONNOTIFY ;

	typedef BOOL ( *LPD_DSENUMCALLBACKA )	( LPGUID, LPCSTR, LPCSTR, LPVOID ) ;
	typedef BOOL ( *LPD_DSENUMCALLBACKW )	( LPGUID, LPCWSTR, LPCWSTR, LPVOID ) ;
+/

    /+
	class D_IDirectSound : public IUnknown
	{
	public :
		virtual HRESULT __stdcall CreateSoundBuffer			( const D_DSBUFFERDESC *pcDSBufferDesc, class D_IDirectSoundBuffer **ppDSBuffer, IUnknown *pUnkOuter ) = 0 ;
		virtual HRESULT __stdcall GetCaps					( D_DSCAPS *pDSCaps ) = 0 ;
//		virtual HRESULT __stdcall NonUse00					( void ) = 0 ;				// DuplicateSoundBuffer( LPDIRECTSOUNDBUFFER pDSBufferOriginal, LPDIRECTSOUNDBUFFER *ppDSBufferDuplicate ) = 0 ;
		virtual HRESULT __stdcall DuplicateSoundBuffer		( class D_IDirectSoundBuffer *pDSBufferOriginal, class D_IDirectSoundBuffer **ppDSBufferDuplicate ) = 0 ;
		virtual HRESULT __stdcall SetCooperativeLevel		( HWND hwnd, DWORD dwLevel ) = 0 ;
		virtual HRESULT __stdcall NonUse01					( void ) = 0 ;				// Compact( void ) = 0 ;
		virtual HRESULT __stdcall NonUse02					( void ) = 0 ;				// GetSpeakerConfig( LPDWORD pdwSpeakerConfig ) = 0 ;
		virtual HRESULT __stdcall NonUse03					( void ) = 0 ;				// SetSpeakerConfig( DWORD dwSpeakerConfig ) = 0 ;
		virtual HRESULT __stdcall Initialize				( const GUID *pcGuidDevice ) = 0 ;
	} ;
+/
/+

	class D_IDirectSound8 : public D_IDirectSound
	{
	public :
		virtual HRESULT __stdcall NonUse00					( void ) = 0 ;				// VerifyCertification( LPDWORD pdwCertified ) = 0 ;
	} ;
+/

/+
	class D_IDirectSoundBuffer : public IUnknown
	{
	public :
		virtual HRESULT __stdcall GetCaps					( void ) = 0 ;				// GetCaps( LPDSBCAPS pDSBufferCaps ) = 0 ;
		virtual HRESULT __stdcall GetCurrentPosition		( DWORD *pdwCurrentPlayCursor, DWORD *pdwCurrentWriteCursor ) = 0 ;
		virtual HRESULT __stdcall NonUse00					( void ) = 0 ;				// GetFormat( LPWAVEFORMATEX pwfxFormat, DWORD dwSizeAllocated, LPDWORD pdwSizeWritten ) = 0 ;
		virtual HRESULT __stdcall GetVolume					( LPLONG plVolume ) = 0 ;
		virtual HRESULT __stdcall NonUse02					( void ) = 0 ;				// GetPan( LPLONG plPan ) = 0 ;
		virtual HRESULT __stdcall NonUse03					( void ) = 0 ;				// GetFrequency( LPDWORD pdwFrequency ) = 0 ;
		virtual HRESULT __stdcall GetStatus					( DWORD *pdwStatus ) = 0 ;
		virtual HRESULT __stdcall NonUse04					( void ) = 0 ;				// Initialize( LPDIRECTSOUND pDirectSound, LPCDSBUFFERDESC pcDSBufferDesc ) = 0 ;
		virtual HRESULT __stdcall Lock						( DWORD dwOffset, DWORD dwBytes, void **ppvAudioPtr1, DWORD *pdwAudioBytes1, void **ppvAudioPtr2, DWORD *pdwAudioBytes2, DWORD dwFlags ) = 0 ;
		virtual HRESULT __stdcall Play						( DWORD dwReserved1, DWORD dwPriority, DWORD dwFlags ) = 0 ;
		virtual HRESULT __stdcall SetCurrentPosition		( DWORD dwNewPosition ) = 0 ;
		virtual HRESULT __stdcall SetFormat					( const WAVEFORMATEX *pcfxFormat ) = 0 ;
		virtual HRESULT __stdcall SetVolume					( LONG lVolume ) = 0 ;
		virtual HRESULT __stdcall SetPan					( LONG lPan ) = 0 ;
		virtual HRESULT __stdcall SetFrequency				( DWORD dwFrequency ) = 0 ;
		virtual HRESULT __stdcall Stop						( void ) = 0 ;
		virtual HRESULT __stdcall Unlock					( void *pvAudioPtr1, DWORD dwAudioBytes1, void *pvAudioPtr2, DWORD dwAudioBytes2 ) = 0 ;
		virtual HRESULT __stdcall NonUse05					( void ) = 0 ;				// Restore( void ) = 0 ;
	} ;
+/
/+

	class D_IDirectSoundBuffer8 : public D_IDirectSoundBuffer
	{
	public :
		virtual HRESULT __stdcall NonUse00					( void ) = 0 ;				// SetFX( DWORD dwEffectsCount, LPDSEFFECTDESC pDSFXDesc, LPDWORD pdwResultCodes ) = 0 ;
		virtual HRESULT __stdcall NonUse01					( void ) = 0 ;				// AcquireResources( DWORD dwFlags, DWORD dwEffectsCount, LPDWORD pdwResultCodes ) = 0 ;
		virtual HRESULT __stdcall NonUse02					( void ) = 0 ;				// GetObjectInPath( REFGUID rguidObject, DWORD dwIndex, REFGUID rguidInterface, LPVOID *ppObject ) = 0 ;
	} ;
+/

/+
	class D_IDirectSoundNotify : public IUnknown
	{
	public :
		virtual HRESULT __stdcall SetNotificationPositions	( DWORD dwPositionNotifies, const D_DSBPOSITIONNOTIFY *pcPositionNotifies ) = 0 ;
	} ;
+/

	// ＤｉｒｅｃｔＭｕｓｉｃ -----------------------------------------------------

	const int D_DMUS_APATH_SHARED_STEREOPLUSREVERB = (1);
	const int D_DMUS_AUDIOF_ALL = (0x3F);
	const int D_DMUS_PC_OUTPUTCLASS = (1);
	const int D_DMUS_SEG_REPEAT_INFINITE = (0xFFFFFFFF);

	const int D_DMUS_MAX_DESCRIPTION = (128);
	const int D_DMUS_MAX_CATEGORY = (64);
	const int D_DMUS_MAX_NAME = (64);
	//const int D_DMUS_MAX_FILENAME = MAX_PATH;

	const int D_DMUS_AUDIOPARAMS_FEATURES = (0x00000001);
	const int D_DMUS_AUDIOPARAMS_SAMPLERATE = (0x00000004);
	const int D_DMUS_AUDIOPARAMS_DEFAULTSYNTH = (0x00000008);

	const int D_DMUS_OBJ_CLASS = (1 << 1);
	const int D_DMUS_OBJ_MEMORY = (1 << 10);

	enum D_DMUS_SEGF_FLAGS
	{
		D_DMUS_SEGF_REFTIME							= 1 << 6,
	} 


	typedef long									D_MUSIC_TIME ;
	typedef LONGLONG								D_REFERENCE_TIME ;

    /+
	struct D_DMUS_PORTCAPS
	{
		DWORD										dwSize;
		DWORD										dwFlags;
		GUID										guidPort;
		DWORD										dwClass;
		DWORD										dwType;
		DWORD										dwMemorySize;
		DWORD										dwMaxChannelGroups;
		DWORD										dwMaxVoices;	
		DWORD										dwMaxAudioChannels;
		DWORD										dwEffectFlags;
		WCHAR										wszDescription[D_DMUS_MAX_DESCRIPTION];
	} 

	struct D_DMUS_VERSION
	{
		DWORD										dwVersionMS;
		DWORD										dwVersionLS;
	}

	struct D_DMUS_OBJECTDESC
	{
		DWORD										dwSize;
		DWORD										dwValidData;
		GUID										guidObject;
		GUID										guidClass;
		FILETIME									ftDate;
		D_DMUS_VERSION								vVersion;
		WCHAR										wszName[D_DMUS_MAX_NAME];
		WCHAR										wszCategory[D_DMUS_MAX_CATEGORY];
		WCHAR										wszFileName[D_DMUS_MAX_FILENAME];
		LONGLONG									llMemLength;
		LPBYTE										pbMemData;
		IStream 									*pStream;
	} ;

	struct D_DMUS_AUDIOPARAMS
	{
		DWORD										dwSize;
		BOOL										fInitNow;
		DWORD 										dwValidData;
		DWORD										dwFeatures;
		DWORD										dwVoices;
		DWORD										dwSampleRate;
		CLSID										clsidDefaultSynth;
	} ;
+/



	// ＤｉｒｅｃｔＤｒａｗ -------------------------------------------------------

	//const int D_DD_OK = S_OK;

	const int D_DD_ROP_SPACE = (256/32);
	const int D_MAX_DDDEVICEID_STRING = (512);

	const int D_DDPF_ALPHAPIXELS = (0x00000001L);
	const int D_DDPF_ALPHA = (0x00000002L);
	const int D_DDPF_FOURCC = (0x00000004L);
	const int D_DDPF_RGB = (0x00000040L);
	const int D_DDPF_ZBUFFER = (0x00000400L);
	const int D_DDPF_LUMINANCE = (0x00020000L);
	const int D_DDPF_BUMPLUMINANCE = (0x00040000L);
	const int D_DDPF_BUMPDUDV = (0x00080000L);

	const int D_DDWAITVB_BLOCKBEGIN = (0x00000001L);

	const int D_DDCAPS_ALIGNBOUNDARYDEST = (0x00000002L);
	const int D_DDCAPS_ALIGNSIZEDEST = (0x00000004L);
	const int D_DDCAPS_ALIGNBOUNDARYSRC = (0x00000008L);
	const int D_DDCAPS_ALIGNSIZESRC = (0x00000010L);

	const int D_DDOVER_SHOW = (0x00004000L);
	const int D_DDOVER_HIDE = (0x00000200L);

	const int D_DDSCAPS_BACKBUFFER = (0x00000004L);
	const int D_DDSCAPS_COMPLEX = (0x00000008L);
	const int D_DDSCAPS_FLIP = (0x00000010L);
	const int D_DDSCAPS_OFFSCREENPLAIN = (0x00000040L);
	const int D_DDSCAPS_OVERLAY = (0x00000080L);
	const int D_DDSCAPS_PRIMARYSURFACE = (0x00000200L);
	const int D_DDSCAPS_SYSTEMMEMORY = (0x00000800L);
	const int D_DDSCAPS_TEXTURE = (0x00001000L);
	const int D_DDSCAPS_3DDEVICE = (0x00002000L);
	const int D_DDSCAPS_VIDEOMEMORY = (0x00004000L);
	const int D_DDSCAPS_ZBUFFER = (0x00020000L);
	const int D_DDSCAPS_LOCALVIDMEM = (0x10000000L);

	const int D_DDCKEY_SRCBLT = (0x00000008L);

	const int D_DDFLIP_NOVSYNC = (0x00000008L);
	const int D_DDFLIP_WAIT = (0x00000001L);

	const int D_DDPCAPS_8BIT = (0x00000004L);

	const int D_DDSCAPS2_TEXTUREMANAGE = (0x00000010L);

	const int D_DDBLT_COLORFILL = (0x00000400L);
	const int D_DDBLT_WAIT = (0x01000000L);
	const int D_DDBLT_DEPTHFILL = (0x02000000L);

	const int D_DDENUM_ATTACHEDSECONDARYDEVICES = (0x00000001L);
	const int D_DDENUMRET_CANCEL = (0);
	const int D_DDENUMRET_OK = (1);

	const int D_DDLOCK_WAIT = (0x00000001L);
	const int D_DDLOCK_READONLY = (0x00000010L);
	const int D_DDLOCK_WRITEONLY = (0x00000020L);

	const int D_DDBLTFAST_NOCOLORKEY = (0x00000000);
	const int D_DDBLTFAST_SRCCOLORKEY = (0x00000001);
	const int D_DDBLTFAST_DESTCOLORKEY = (0x00000002);
	const int D_DDBLTFAST_WAIT = (0x00000010);
	const int D_DDBLTFAST_DONOTWAIT = (0x00000020);

	const int D_DDSD_CAPS = (0x00000001L);
	const int D_DDSD_HEIGHT = (0x00000002L);
	const int D_DDSD_WIDTH = (0x00000004L);
	const int D_DDSD_PITCH = (0x00000008L);
	const int D_DDSD_BACKBUFFERCOUNT = (0x00000020L);
	const int D_DDSD_PIXELFORMAT = (0x00001000L);
	const int D_DDSD_TEXTURESE = (0x00100000L);

	const int D_DDBD_16 = (0x00000400L);
	const int D_DDBD_32 = (0x00000100L);

	const int D_DDSCL_FULLSCREEN = (0x00000001L);
	const int D_DDSCL_NORMAL = (0x00000008L);
	const int D_DDSCL_EXCLUSIVE = (0x00000010L);
	const int D_DDSCL_MULTITHREADED = (0x00000400L);

	//int D_MAKE_DDHRESULT(int code ) {return MAKE_HRESULT( 1, 0x876, code );}
	//const int D_DDERR_SURFACEBUSY = D_MAKE_DDHRESULT( 430 );
	//const int D_DDERR_SURFACELOST = D_MAKE_DDHRESULT( 450 );
	//const int D_DDERR_HWNDSUBCLASSED = D_MAKE_DDHRESULT( 570 );
	//const int D_DDERR_HWNDALREADYSET = D_MAKE_DDHRESULT( 571 );
	//const int D_DDERR_EXCLUSIVEMODEALREADYSET = D_MAKE_DDHRESULT( 581 );

	struct D_DDSCAPS2
	{
		DWORD										dwCaps;
		DWORD										dwCaps2;
		DWORD										dwCaps3;
		union
		{
			DWORD									dwCaps4;
			DWORD									dwVolumeDepth;
		} ;
	}

	struct D_DDSCAPS
	{
		DWORD										dwCaps;
	}

	struct D_DDCAPS
	{
		DWORD										dwSize;
		DWORD										dwCaps;
		DWORD										dwCaps2;
		DWORD										dwCKeyCaps;
		DWORD										dwFXCaps;
		DWORD										dwFXAlphaCaps;
		DWORD										dwPalCaps;
		DWORD										dwSVCaps;
		DWORD										dwAlphaBltConstBitDepths;
		DWORD										dwAlphaBltPixelBitDepths;
		DWORD										dwAlphaBltSurfaceBitDepths;
		DWORD										dwAlphaOverlayConstBitDepths;
		DWORD										dwAlphaOverlayPixelBitDepths;
		DWORD										dwAlphaOverlaySurfaceBitDepths;
		DWORD										dwZBufferBitDepths;
		DWORD										dwVidMemTotal;
		DWORD										dwVidMemFree;
		DWORD										dwMaxVisibleOverlays;
		DWORD										dwCurrVisibleOverlays;
		DWORD										dwNumFourCCCodes;
		DWORD										dwAlignBoundarySrc;
		DWORD										dwAlignSizeSrc;
		DWORD										dwAlignBoundaryDest;
		DWORD										dwAlignSizeDest;
		DWORD										dwAlignStrideAlign;
		DWORD										dwRops[D_DD_ROP_SPACE];
		D_DDSCAPS									ddsOldCaps;
		DWORD										dwMinOverlayStretch;
		DWORD										dwMaxOverlayStretch;
		DWORD										dwMinLiveVideoStretch;
		DWORD										dwMaxLiveVideoStretch;
		DWORD										dwMinHwCodecStretch;
		DWORD										dwMaxHwCodecStretch;
		DWORD										dwReserved1;
		DWORD										dwReserved2;
		DWORD										dwReserved3;
		DWORD										dwSVBCaps;
		DWORD										dwSVBCKeyCaps;
		DWORD										dwSVBFXCaps;
		DWORD										dwSVBRops[D_DD_ROP_SPACE];
		DWORD										dwVSBCaps;
		DWORD										dwVSBCKeyCaps;
		DWORD										dwVSBFXCaps;
		DWORD										dwVSBRops[D_DD_ROP_SPACE];
		DWORD										dwSSBCaps;
		DWORD										dwSSBCKeyCaps;
		DWORD										dwSSBFXCaps;
		DWORD										dwSSBRops[D_DD_ROP_SPACE];
		DWORD										dwMaxVideoPorts;
		DWORD										dwCurrVideoPorts;
		DWORD										dwSVBCaps2;
		DWORD										dwNLVBCaps;
		DWORD										dwNLVBCaps2;
		DWORD										dwNLVBCKeyCaps;
		DWORD										dwNLVBFXCaps;
		DWORD										dwNLVBRops[D_DD_ROP_SPACE];
		// DirectX6
		D_DDSCAPS2									ddsCaps;
	} 
	struct D_DDPIXELFORMAT
	{
		DWORD										dwSize;
		DWORD										dwFlags;
		DWORD										dwFourCC;
		union
		{
			DWORD									dwRGBBitCount;
			DWORD									dwYUVBitCount;
			DWORD									dwZBufferBitDepth;
			DWORD									dwAlphaBitDepth;
			DWORD									dwLuminanceBitCount;
			DWORD									dwBumpBitCount;
			DWORD									dwPrivateFormatBitCount;
		} ;
		union
		{
			DWORD									dwRBitMask;
			DWORD									dwYBitMask;
			DWORD									dwStencilBitDepth;
			DWORD									dwLuminanceBitMask;
			DWORD									dwBumpDuBitMask;
			DWORD									dwOperations;
		} ;
		union
		{
			DWORD									dwGBitMask;
			DWORD									dwUBitMask;
			DWORD									dwZBitMask;
			DWORD									dwBumpDvBitMask;
			struct MultiSampleCaps
			{
				WORD								wFlipMSTypes;
				WORD								wBltMSTypes;
			} ;

		} ;
		union
		{
			DWORD									dwBBitMask;
			DWORD									dwVBitMask;
			DWORD									dwStencilBitMask;
			DWORD									dwBumpLuminanceBitMask;
		} ;
		union
		{
			DWORD									dwRGBAlphaBitMask;
			DWORD									dwYUVAlphaBitMask;
			DWORD									dwLuminanceAlphaBitMask;
			DWORD									dwRGBZBitMask;
			DWORD									dwYUVZBitMask;
		} ;
	} 

	struct D_DDCOLORKEY
	{
		DWORD										dwColorSpaceLowValue;
		DWORD										dwColorSpaceHighValue;
	} 

	struct D_DDSURFACEDESC
	{
		DWORD										dwSize;
		DWORD										dwFlags;
		DWORD										dwHeight;
		DWORD										dwWidth;
		union
		{
			LONG									lPitch;
			DWORD									dwLinearSize;
		} ;
		DWORD										dwBackBufferCount;
		union
		{
			DWORD									dwMipMapCount;
			DWORD									dwZBufferBitDepth;
			DWORD									dwRefreshRate;
		} ;
		DWORD										dwAlphaBitDepth;
		DWORD										dwReserved;
		LPVOID										lpSurface;
		D_DDCOLORKEY								ddckCKDestOverlay;
		D_DDCOLORKEY								ddckCKDestBlt;
		D_DDCOLORKEY								ddckCKSrcOverlay;
		D_DDCOLORKEY								ddckCKSrcBlt;
		D_DDPIXELFORMAT								ddpfPixelFormat;
		D_DDSCAPS									ddsCaps;
    }
/+

	struct D_DDSURFACEDESC2
	{
		DWORD										dwSize;
		DWORD										dwFlags;
		DWORD										dwHeight;
		DWORD										dwWidth;
		union
		{
			LONG									lPitch;
			DWORD									dwLinearSize;
		} ;
		union
		{
			DWORD									dwBackBufferCount;
			DWORD									dwDepth;
		} ;
		union
		{
			DWORD									dwMipMapCount;
			DWORD									dwRefreshRate;
			DWORD									dwSrcVBHandle;
		} ;
		DWORD										dwAlphaBitDepth;
		DWORD										dwReserved;
		LPVOID										lpSurface;
		union
		{
			D_DDCOLORKEY							ddckCKDestOverlay;
			DWORD									dwEmptyFaceColor;
		} ;
		D_DDCOLORKEY								ddckCKDestBlt;
		D_DDCOLORKEY								ddckCKSrcOverlay;
		D_DDCOLORKEY								ddckCKSrcBlt;
		union
		{
			D_DDPIXELFORMAT							ddpfPixelFormat;
			DWORD									dwFVF;
		} ;
		D_DDSCAPS2									ddsCaps;
		DWORD										dwTextureSe;
    }

	struct D_DDDEVICEIDENTIFIER2
	{
		char										szDriver[D_MAX_DDDEVICEID_STRING];
		char										szDescription[D_MAX_DDDEVICEID_STRING];

		LARGE_INTEGER								liDriverVersion;

		DWORD										dwVendorId;
		DWORD										dwDeviceId;
		DWORD										dwSubSysId;
		DWORD										dwRevision;
		GUID										guidDeviceIdentifier;
		DWORD										dwWHQLLevel;

    }
+/

/+
	struct D_DDBLTFX
	{
		DWORD										dwSize;
		DWORD										dwDDFX;
		DWORD										dwROP;
		DWORD										dwDDROP;
		DWORD										dwRotationAngle;
		DWORD										dwZBufferOpCode;
		DWORD										dwZBufferLow;
		DWORD										dwZBufferHigh;
		DWORD										dwZBufferBaseDest;
		DWORD										dwZDestConstBitDepth;
		union
		{
			DWORD									dwZDestConst;
			class D_IDirectDrawSurface 				*lpDDSZBufferDest;
		} ;
		DWORD										dwZSrcConstBitDepth;
		union
		{
			DWORD									dwZSrcConst;
			class D_IDirectDrawSurface 				*lpDDSZBufferSrc;
		} ;
		DWORD										dwAlphaEdgeBlendBitDepth;
		DWORD										dwAlphaEdgeBlend;
		DWORD										dwReserved;
		DWORD										dwAlphaDestConstBitDepth;
		union
		{
			DWORD									dwAlphaDestConst;
			class D_IDirectDrawSurface 				*lpDDSAlphaDest;
		} ;
		DWORD										dwAlphaSrcConstBitDepth;
		union
		{
			DWORD									dwAlphaSrcConst;
			class D_IDirectDrawSurface 				*lpDDSAlphaSrc;
		} ;
		union
		{
			DWORD									dwFillColor;
			DWORD									dwFillDepth;
			DWORD									dwFillPixel;
			class D_IDirectDrawSurface 				*lpDDSPattern;
		} ;
		D_DDCOLORKEY								ddckDestColorkey;
		D_DDCOLORKEY								ddckSrcColorkey;
    }
+/

/+
	struct D_DDOVERLAYFX
	{
		DWORD										dwSize;
		DWORD										dwAlphaEdgeBlendBitDepth;
		DWORD										dwAlphaEdgeBlend;
		DWORD										dwReserved;
		DWORD										dwAlphaDestConstBitDepth;
		union
		{
			DWORD									dwAlphaDestConst;
			class D_IDirectDrawSurface 				*lpDDSAlphaDest;
		} ;
		DWORD										dwAlphaSrcConstBitDepth;
		union
		{
			DWORD									dwAlphaSrcConst;
			class D_IDirectDrawSurface 				*lpDDSAlphaSrc;
		} ;
		D_DDCOLORKEY								dckDestColorkey;
		D_DDCOLORKEY								dckSrcColorkey;
		DWORD										dwDDFX;
		DWORD										dwFlags;
    }
+/


/+
	typedef HRESULT ( FAR PASCAL * LPD_DDENUMSURFACESCALLBACK7 )	( class D_IDirectDrawSurface7 *, D_DDSURFACEDESC2 *, void * ) ;
	typedef HRESULT ( FAR PASCAL * LPD_DDENUMSURFACESCALLBACK2 )	( class D_IDirectDrawSurface4 *, D_DDSURFACEDESC2 *, void * ) ;
	typedef HRESULT ( FAR PASCAL * LPD_DDENUMSURFACESCALLBACK )		( class D_IDirectDrawSurface *,  D_DDSURFACEDESC *,  void * ) ;
	typedef BOOL 	( FAR PASCAL * LPD_DDENUMCALLBACKEXA )			( GUID *, LPSTR,  LPSTR,  void *, void * ) ;
	typedef BOOL 	( FAR PASCAL * LPD_DDENUMCALLBACKEXW )			( GUID *, LPWSTR, LPWSTR, void *, void * ) ;
    +/

    /+
	class D_IDirectDraw : public IUnknown
	{
	public :
		virtual HRESULT __stdcall NonUse00					( void ) = 0 ;				// Compact( void ) = 0 ;
		virtual HRESULT __stdcall NonUse01					( void ) = 0 ;				// CreateClipper( DWORD, LPDIRECTDRAWCLIPPER FAR*, IUnknown FAR * ) = 0 ;
		virtual HRESULT __stdcall NonUse02					( void ) = 0 ;				// CreatePalette( DWORD, LPPALETTEENTRY, LPDIRECTDRAWPALETTE FAR*, IUnknown FAR * ) = 0 ;
		virtual HRESULT __stdcall CreateSurface				( D_DDSURFACEDESC *, D_IDirectDrawSurface **, IUnknown * ) = 0 ;
		virtual HRESULT __stdcall NonUse03					( void ) = 0 ;				// DuplicateSurface( LPDIRECTDRAWSURFACE, LPDIRECTDRAWSURFACE FAR * ) = 0 ;
		virtual HRESULT __stdcall NonUse04					( void ) = 0 ;				// EnumDisplayModes( DWORD, LPDDSURFACEDESC, LPVOID, LPDDENUMMODESCALLBACK ) = 0 ;
		virtual HRESULT __stdcall NonUse05					( void ) = 0 ;				// EnumSurfaces( DWORD, LPDDSURFACEDESC, LPVOID,LPDDENUMSURFACESCALLBACK ) = 0 ;
		virtual HRESULT __stdcall NonUse06					( void ) = 0 ;				// FlipToGDISurface( void ) = 0 ;
		virtual HRESULT __stdcall GetCaps					( D_DDCAPS *, D_DDCAPS * ) = 0 ;
		virtual HRESULT __stdcall NonUse07					( void ) = 0 ;				// GetDisplayMode( LPDDSURFACEDESC ) = 0 ;
		virtual HRESULT __stdcall NonUse08					( void ) = 0 ;				// GetFourCCCodes( LPDWORD, LPDWORD	) = 0 ;
		virtual HRESULT __stdcall NonUse09					( void ) = 0 ;				// GetGDISurface( LPDIRECTDRAWSURFACE FAR * ) = 0 ;
		virtual HRESULT __stdcall NonUse10					( void ) = 0 ;				// GetMonitorFrequency( LPDWORD ) = 0 ;
		virtual HRESULT __stdcall NonUse11					( void ) = 0 ;				// GetScanLine( LPDWORD ) = 0 ;
		virtual HRESULT __stdcall NonUse12					( void ) = 0 ;				// GetVerticalBlankStatus( LPBOOL ) = 0 ;
		virtual HRESULT __stdcall NonUse13					( void ) = 0 ;				// Initialize( GUID FAR * ) = 0 ;
		virtual HRESULT __stdcall NonUse14					( void ) = 0 ;				// RestoreDisplayMode( void ) = 0 ;
		virtual HRESULT __stdcall SetCooperativeLevel		( HWND, DWORD ) = 0 ;
		virtual HRESULT __stdcall NonUse15					( void ) = 0 ;				// SetDisplayMode( DWORD, DWORD,DWORD ) = 0 ;
		virtual HRESULT __stdcall NonUse16					( void ) = 0 ;				// WaitForVerticalBlank( DWORD, HANDLE ) = 0 ;
	} ;

	class D_IDirectDraw2 : public D_IDirectDraw
	{
	public :
		virtual HRESULT __stdcall GetAvailableVidMem		( D_DDSCAPS2 *, DWORD *, DWORD * ) = 0 ;
	} ;

	class D_IDirectDraw4 : public IUnknown
	{
	public :
		virtual HRESULT __stdcall NonUse00					( void ) = 0 ;				// Compact( void ) = 0 ;
		virtual HRESULT __stdcall NonUse01					( void ) = 0 ;				// CreateClipper( DWORD, LPDIRECTDRAWCLIPPER FAR*, IUnknown FAR * ) = 0 ;
		virtual HRESULT __stdcall NonUse02					( void ) = 0 ;				// CreatePalette( DWORD, LPPALETTEENTRY, LPDIRECTDRAWPALETTE FAR*, IUnknown FAR * ) = 0 ;
		virtual HRESULT __stdcall NonUse03					( void ) = 0 ;				// CreateSurface(	LPDDSURFACEDESC2, LPDIRECTDRAWSURFACE4 FAR *, IUnknown FAR * ) = 0 ;
		virtual HRESULT __stdcall NonUse04					( void ) = 0 ;				// DuplicateSurface( LPDIRECTDRAWSURFACE4, LPDIRECTDRAWSURFACE4 FAR * ) = 0 ;
		virtual HRESULT __stdcall NonUse05					( void ) = 0 ;				// EnumDisplayModes( DWORD, LPDDSURFACEDESC2, LPVOID, LPDDENUMMODESCALLBACK2 ) = 0 ;
		virtual HRESULT __stdcall NonUse06					( void ) = 0 ;				// EnumSurfaces( DWORD, LPDDSURFACEDESC2, LPVOID,LPDDENUMSURFACESCALLBACK2 ) = 0 ;
		virtual HRESULT __stdcall NonUse07					( void ) = 0 ;				// FlipToGDISurface( void ) = 0 ;
		virtual HRESULT __stdcall NonUse08					( void ) = 0 ;				// GetCaps( LPDDCAPS, LPDDCAPS ) = 0 ;
		virtual HRESULT __stdcall NonUse09					( void ) = 0 ;				// GetDisplayMode( LPDDSURFACEDESC2 ) = 0 ;
		virtual HRESULT __stdcall NonUse10					( void ) = 0 ;				// GetFourCCCodes( LPDWORD, LPDWORD ) = 0 ;
		virtual HRESULT __stdcall NonUse11					( void ) = 0 ;				// GetGDISurface( LPDIRECTDRAWSURFACE4 FAR * ) = 0 ;
		virtual HRESULT __stdcall NonUse12					( void ) = 0 ;				// GetMonitorFrequency( LPDWORD ) = 0 ;
		virtual HRESULT __stdcall NonUse13					( void ) = 0 ;				// GetScanLine( LPDWORD ) = 0 ;
		virtual HRESULT __stdcall NonUse14					( void ) = 0 ;				// GetVerticalBlankStatus( LPBOOL ) = 0 ;
		virtual HRESULT __stdcall NonUse15					( void ) = 0 ;				// Initialize( GUID FAR * ) = 0 ;
		virtual HRESULT __stdcall NonUse16					( void ) = 0 ;				// RestoreDisplayMode( void ) = 0 ;
		virtual HRESULT __stdcall NonUse17					( void ) = 0 ;				// SetCooperativeLevel( HWND, DWORD ) = 0 ;
		virtual HRESULT __stdcall NonUse18					( void ) = 0 ;				// SetDisplayMode( DWORD, DWORD,DWORD, DWORD, DWORD ) = 0 ;
		virtual HRESULT __stdcall NonUse19					( void ) = 0 ;				// WaitForVerticalBlank( DWORD, HANDLE ) = 0 ;

		virtual HRESULT __stdcall NonUse20					( void ) = 0 ;				// GetAvailableVidMem( LPDDSCAPS2, LPDWORD, LPDWORD ) = 0 ;

		virtual HRESULT __stdcall NonUse21					( void ) = 0 ;				// GetSurfaceFromDC( HDC, LPDIRECTDRAWSURFACE4 * ) = 0 ;
		virtual HRESULT __stdcall NonUse22					( void ) = 0 ;				// RestoreAllSurfaces( void ) = 0 ;
		virtual HRESULT __stdcall NonUse23					( void ) = 0 ;				// TestCooperativeLevel( void ) = 0 ;
		virtual HRESULT __stdcall NonUse24					( void ) = 0 ;				// GetDeviceIdentifier( LPDDDEVICEIDENTIFIER, DWORD ) = 0 ;
	} ;

	class D_IDirectDraw7 : public IUnknown
	{
	public :
		virtual HRESULT __stdcall NonUse00					( void ) = 0 ;				// Compact( void ) = 0 ;
		virtual HRESULT __stdcall CreateClipper				( DWORD, class D_IDirectDrawClipper **, IUnknown * ) = 0 ;
		virtual HRESULT __stdcall CreatePalette				( DWORD, LPPALETTEENTRY, class D_IDirectDrawPalette **, IUnknown * ) = 0 ;
		virtual HRESULT __stdcall CreateSurface				( D_DDSURFACEDESC2 *, D_IDirectDrawSurface7 **, IUnknown * ) = 0 ;
		virtual HRESULT __stdcall NonUse01					( void ) = 0 ;				// DuplicateSurface( D_IDirectDrawSurface7 *, D_IDirectDrawSurface7 * FAR * ) = 0 ;
		virtual HRESULT __stdcall NonUse02					( void ) = 0 ;				// EnumDisplayModes( void ) = 0 ;			// EnumDisplayModes( DWORD, LPDDSURFACEDESC2, LPVOID, LPDDENUMMODESCALLBACK2 ) = 0 ;
		virtual HRESULT __stdcall NonUse03					( void ) = 0 ;				// EnumSurfaces( DWORD, LPDDSURFACEDESC2, LPVOID,LPDDENUMSURFACESCALLBACK7 ) = 0 ;
		virtual HRESULT __stdcall FlipToGDISurface			( void ) = 0 ;
		virtual HRESULT __stdcall GetCaps					( D_DDCAPS *, D_DDCAPS * ) = 0 ;
		virtual HRESULT __stdcall GetDisplayMode			( D_DDSURFACEDESC2 * ) = 0 ;
		virtual HRESULT __stdcall NonUse04					( void ) = 0 ;				// GetFourCCCodes( LPDWORD, LPDWORD ) = 0 ;
		virtual HRESULT __stdcall NonUse05					( void ) = 0 ;				// GetGDISurface( D_IDirectDrawSurface7 * FAR * ) = 0 ;
		virtual HRESULT __stdcall NonUse06					( void ) = 0 ;				// GetMonitorFrequency( LPDWORD ) = 0 ;
		virtual HRESULT __stdcall GetScanLine				( DWORD * ) = 0 ;
		virtual HRESULT __stdcall GetVerticalBlankStatus	( BOOL * ) = 0 ;
		virtual HRESULT __stdcall Initialize				( GUID * ) = 0 ;
		virtual HRESULT __stdcall RestoreDisplayMode		( void ) = 0 ;
		virtual HRESULT __stdcall SetCooperativeLevel		( HWND, DWORD ) = 0 ;
		virtual HRESULT __stdcall SetDisplayMode			( DWORD, DWORD,DWORD, DWORD, DWORD ) = 0 ;
		virtual HRESULT __stdcall WaitForVerticalBlank		( DWORD, HANDLE ) = 0 ;

		virtual HRESULT __stdcall GetAvailableVidMem		( D_DDSCAPS2 *, DWORD *, DWORD * ) = 0 ;

		virtual HRESULT __stdcall NonUse07					( void ) = 0 ;				// GetSurfaceFromDC( HDC, D_IDirectDrawSurface7 * * ) = 0 ;
		virtual HRESULT __stdcall NonUse08					( void ) = 0 ;				// RestoreAllSurfaces( void ) = 0 ;
		virtual HRESULT __stdcall NonUse09					( void ) = 0 ;				// TestCooperativeLevel( void ) = 0 ;
		virtual HRESULT __stdcall GetDeviceIdentifier		( D_DDDEVICEIDENTIFIER2 *, DWORD ) = 0 ;
		virtual HRESULT __stdcall NonUse10					( void ) = 0 ;				// StartModeTest( LPSIZE, DWORD, DWORD ) = 0 ;
		virtual HRESULT __stdcall NonUse11					( void ) = 0 ;				// EvaluateMode( DWORD, DWORD * ) = 0 ;
	} ;

	class D_IDirectDrawSurface : public IUnknown
	{
	public :
		virtual HRESULT __stdcall NonUse00					( void ) = 0 ;				// AddAttachedSurface( LPDIRECTDRAWSURFACE ) = 0 ;
		virtual HRESULT __stdcall NonUse01					( void ) = 0 ;				// AddOverlayDirtyRect( LPRECT ) = 0 ;
		virtual HRESULT __stdcall NonUse02					( void ) = 0 ;				// Blt( LPRECT,LPDIRECTDRAWSURFACE, LPRECT,DWORD, LPDDBLTFX ) = 0 ;
		virtual HRESULT __stdcall NonUse03					( void ) = 0 ;				// BltBatch( LPDDBLTBATCH, DWORD, DWORD	) = 0 ;
		virtual HRESULT __stdcall BltFast					( DWORD, DWORD, D_IDirectDrawSurface *, LPRECT, DWORD ) = 0 ;
		virtual HRESULT __stdcall NonUse04					( void ) = 0 ;				// DeleteAttachedSurface( DWORD,LPDIRECTDRAWSURFACE ) = 0 ;
		virtual HRESULT __stdcall NonUse05					( void ) = 0 ;				// EnumAttachedSurfaces( LPVOID,LPDDENUMSURFACESCALLBACK ) = 0 ;
		virtual HRESULT __stdcall NonUse06					( void ) = 0 ;				// EnumOverlayZOrders( DWORD,LPVOID,LPDDENUMSURFACESCALLBACK7 ) = 0 ;
		virtual HRESULT __stdcall NonUse07					( void ) = 0 ;				// Flip( LPDIRECTDRAWSURFACE, DWORD ) = 0 ;
		virtual HRESULT __stdcall NonUse08					( void ) = 0 ;				// GetAttachedSurface( LPDDSCAPS, LPDIRECTDRAWSURFACE FAR * ) = 0 ;
		virtual HRESULT __stdcall NonUse09					( void ) = 0 ;				// GetBltStatus( DWORD ) = 0 ;
		virtual HRESULT __stdcall GetCaps					( D_DDSCAPS * ) = 0 ;
		virtual HRESULT __stdcall NonUse10					( void ) = 0 ;				// GetClipper( LPDIRECTDRAWCLIPPER FAR* ) = 0 ;
		virtual HRESULT __stdcall NonUse11					( void ) = 0 ;				// GetColorKey( DWORD, LPDDCOLORKEY ) = 0 ;
		virtual HRESULT __stdcall NonUse12					( void ) = 0 ;				// GetDC( HDC FAR * ) = 0 ;
		virtual HRESULT __stdcall NonUse13					( void ) = 0 ;				// GetFlipStatus( DWORD ) = 0 ;
		virtual HRESULT __stdcall NonUse14					( void ) = 0 ;				// GetOverlayPosition( LPLONG, LPLONG	) = 0 ;
		virtual HRESULT __stdcall NonUse15					( void ) = 0 ;				// GetPalette( LPDIRECTDRAWPALETTE FAR* ) = 0 ;
		virtual HRESULT __stdcall GetPixelFormat			( D_DDPIXELFORMAT * ) = 0 ;
		virtual HRESULT __stdcall GetSurfaceDesc			( D_DDSURFACEDESC * ) = 0 ;
		virtual HRESULT __stdcall Initialize				( D_IDirectDraw *, D_DDSURFACEDESC * ) = 0 ;
		virtual HRESULT __stdcall NonUse16					( void ) = 0 ;				// IsLost( void	) = 0 ;
		virtual HRESULT __stdcall Lock						( LPRECT, D_DDSURFACEDESC *, DWORD, HANDLE ) = 0 ;
		virtual HRESULT __stdcall NonUse17					( void ) = 0 ;				// ReleaseDC( HDC ) = 0 ;
		virtual HRESULT __stdcall Restore					( void ) = 0 ;
		virtual HRESULT __stdcall NonUse18					( void ) = 0 ;				// SetClipper( LPDIRECTDRAWCLIPPER ) = 0 ;
		virtual HRESULT __stdcall NonUse19					( void ) = 0 ;				// SetColorKey( DWORD, LPDDCOLORKEY ) = 0 ;
		virtual HRESULT __stdcall NonUse20					( void ) = 0 ;				// SetOverlayPosition( LONG, LONG	) = 0 ;
		virtual HRESULT __stdcall NonUse21					( void ) = 0 ;				// SetPalette( LPDIRECTDRAWPALETTE ) = 0 ;
		virtual HRESULT __stdcall Unlock					( LPRECT ) = 0 ;
		virtual HRESULT __stdcall NonUse22					( void ) = 0 ;				// UpdateOverlay( LPRECT, LPDIRECTDRAWSURFACE,LPRECT,DWORD, LPDDOVERLAYFX ) = 0 ;
		virtual HRESULT __stdcall NonUse23					( void ) = 0 ;				// UpdateOverlayDisplay( DWORD ) = 0 ;
		virtual HRESULT __stdcall NonUse24					( void ) = 0 ;				// UpdateOverlayZOrder( DWORD, LPDIRECTDRAWSURFACE ) = 0 ;
	} ;

	class D_IDirectDrawSurface2 : public D_IDirectDrawSurface
	{
	public :
		virtual HRESULT __stdcall NonUse25					( void ) = 0 ;				// GetDDInterface( LPVOID FAR * ) = 0 ;
		virtual HRESULT __stdcall PageLock					( DWORD ) = 0 ;
		virtual HRESULT __stdcall NonUse27					( void ) = 0 ;				// PageUnlock( DWORD ) = 0 ;
	} ;

	class D_IDirectDrawSurface3 : public D_IDirectDrawSurface2
	{
	public :
		virtual HRESULT __stdcall NonUse28					( void ) = 0 ;				// SetSurfaceDesc( LPDDSURFACEDESC2, DWORD ) = 0 ;
	} ;

	class D_IDirectDrawSurface4 : public IUnknown
	{
	public :
		virtual HRESULT __stdcall NonUse00					( void ) = 0 ;				// AddAttachedSurface( LPDIRECTDRAWSURFACE4 ) = 0 ;
		virtual HRESULT __stdcall NonUse01					( void ) = 0 ;				// AddOverlayDirtyRect( LPRECT ) = 0 ;
		virtual HRESULT __stdcall Blt						( LPRECT, D_IDirectDrawSurface4 *, LPRECT, DWORD, D_DDBLTFX * ) = 0 ;
		virtual HRESULT __stdcall NonUse02					( void ) = 0 ;				// BltBatch( LPDDBLTBATCH, DWORD, DWORD	) = 0 ;
		virtual HRESULT __stdcall NonUse03					( void ) = 0 ;				// BltFast( DWORD,DWORD,LPDIRECTDRAWSURFACE4, LPRECT,DWORD ) = 0 ;
		virtual HRESULT __stdcall NonUse04					( void ) = 0 ;				// DeleteAttachedSurface( DWORD,LPDIRECTDRAWSURFACE4 ) = 0 ;
		virtual HRESULT __stdcall NonUse05					( void ) = 0 ;				// EnumAttachedSurfaces( LPVOID,LPDDENUMSURFACESCALLBACK2 ) = 0 ;
		virtual HRESULT __stdcall NonUse06					( void ) = 0 ;				// EnumOverlayZOrders( DWORD,LPVOID,LPDDENUMSURFACESCALLBACK2 ) = 0 ;
		virtual HRESULT __stdcall NonUse07					( void ) = 0 ;				// Flip( LPDIRECTDRAWSURFACE4, DWORD ) = 0 ;
		virtual HRESULT __stdcall NonUse08					( void ) = 0 ;				// GetAttachedSurface( LPDDSCAPS2, LPDIRECTDRAWSURFACE4 FAR * ) = 0 ;
		virtual HRESULT __stdcall NonUse09					( void ) = 0 ;				// GetBltStatus( DWORD ) = 0 ;
		virtual HRESULT __stdcall GetCaps					( D_DDSCAPS2 * ) = 0 ;
		virtual HRESULT __stdcall NonUse10					( void ) = 0 ;				// GetClipper( LPDIRECTDRAWCLIPPER FAR* ) = 0 ;
		virtual HRESULT __stdcall NonUse11					( void ) = 0 ;				// GetColorKey( DWORD, LPDDCOLORKEY ) = 0 ;
		virtual HRESULT __stdcall NonUse12					( void ) = 0 ;				// GetDC( HDC FAR * ) = 0 ;
		virtual HRESULT __stdcall NonUse13					( void ) = 0 ;				// GetFlipStatus( DWORD ) = 0 ;
		virtual HRESULT __stdcall NonUse14					( void ) = 0 ;				// GetOverlayPosition( LPLONG, LPLONG	) = 0 ;
		virtual HRESULT __stdcall NonUse15					( void ) = 0 ;				// GetPalette( LPDIRECTDRAWPALETTE FAR* ) = 0 ;
		virtual HRESULT __stdcall NonUse16					( void ) = 0 ;				// GetPixelFormat( LPDDPIXELFORMAT ) = 0 ;
		virtual HRESULT __stdcall GetSurfaceDesc			( D_DDSURFACEDESC2 * ) = 0 ;
		virtual HRESULT __stdcall NonUse17					( void ) = 0 ;				// Initialize( LPDIRECTDRAW, LPDDSURFACEDESC2 ) = 0 ;
		virtual HRESULT __stdcall IsLost					( void ) = 0 ;
		virtual HRESULT __stdcall Lock						( LPRECT, D_DDSURFACEDESC2 *, DWORD, HANDLE ) = 0 ;
		virtual HRESULT __stdcall NonUse18					( void ) = 0 ;				// ReleaseDC( HDC ) = 0 ;
		virtual HRESULT __stdcall Restore					( void ) = 0 ;
		virtual HRESULT __stdcall NonUse19					( void ) = 0 ;				// SetClipper( LPDIRECTDRAWCLIPPER ) = 0 ;
		virtual HRESULT __stdcall NonUse20					( void ) = 0 ;				// SetColorKey( DWORD, LPDDCOLORKEY ) = 0 ;
		virtual HRESULT __stdcall NonUse21					( void ) = 0 ;				// SetOverlayPosition( LONG, LONG	) = 0 ;
		virtual HRESULT __stdcall NonUse22					( void ) = 0 ;				// SetPalette( LPDIRECTDRAWPALETTE ) = 0 ;
		virtual HRESULT __stdcall Unlock					( LPRECT ) = 0 ;
		virtual HRESULT __stdcall NonUse23					( void ) = 0 ;				// UpdateOverlay( LPRECT, LPDIRECTDRAWSURFACE4,LPRECT,DWORD, LPDDOVERLAYFX ) = 0 ;
		virtual HRESULT __stdcall NonUse24					( void ) = 0 ;				// UpdateOverlayDisplay( DWORD ) = 0 ;
		virtual HRESULT __stdcall NonUse25					( void ) = 0 ;				// UpdateOverlayZOrder( DWORD, LPDIRECTDRAWSURFACE4 ) = 0 ;

		virtual HRESULT __stdcall NonUse26					( void ) = 0 ;				// GetDDInterface( LPVOID FAR * ) = 0 ;
		virtual HRESULT __stdcall PageLock					( DWORD ) = 0 ;
		virtual HRESULT __stdcall NonUse28					( void ) = 0 ;				// PageUnlock( DWORD ) = 0 ;
		
		virtual HRESULT __stdcall NonUse29					( void ) = 0 ;				// SetSurfaceDesc( LPDDSURFACEDESC2, DWORD ) = 0 ;

		virtual HRESULT __stdcall NonUse30					( void ) = 0 ;				// SetPrivateData( REFGUID, LPVOID, DWORD, DWORD ) = 0 ;
		virtual HRESULT __stdcall NonUse31					( void ) = 0 ;				// GetPrivateData( REFGUID, LPVOID, LPDWORD ) = 0 ;
		virtual HRESULT __stdcall NonUse32					( void ) = 0 ;				// FreePrivateData( REFGUID ) = 0 ;
		virtual HRESULT __stdcall NonUse33					( void ) = 0 ;				// GetUniquenessValue( LPDWORD ) = 0 ;
		virtual HRESULT __stdcall NonUse34					( void ) = 0 ;				// ChangeUniquenessValue( void ) = 0 ;
	} ;

	class D_IDirectDrawSurface7 : public IUnknown
	{
	public :
		virtual HRESULT __stdcall AddAttachedSurface		( D_IDirectDrawSurface7 * ) = 0 ;
		virtual HRESULT __stdcall NonUse00					( void ) = 0 ;				// AddOverlayDirtyRect( LPRECT ) = 0 ;
		virtual HRESULT __stdcall Blt						( LPRECT, D_IDirectDrawSurface7 *, LPRECT, DWORD, D_DDBLTFX * ) = 0 ;
		virtual HRESULT __stdcall NonUse01					( void ) = 0 ;				// BltBatch( LPDDBLTBATCH, DWORD, DWORD	) = 0 ;
		virtual HRESULT __stdcall BltFast					( DWORD, DWORD, D_IDirectDrawSurface7 *, LPRECT, DWORD ) = 0 ;
		virtual HRESULT __stdcall DeleteAttachedSurface		( DWORD, D_IDirectDrawSurface7 * ) = 0 ;
		virtual HRESULT __stdcall EnumAttachedSurfaces		( LPVOID, LPD_DDENUMSURFACESCALLBACK7 ) = 0 ;
		virtual HRESULT __stdcall NonUse02					( void ) = 0 ;				// EnumOverlayZOrders( void ) = 0 ;		// EnumOverlayZOrders( DWORD,LPVOID,LPDDENUMSURFACESCALLBACK7 ) = 0 ;
		virtual HRESULT __stdcall Flip						( D_IDirectDrawSurface7 *, DWORD ) = 0 ;
		virtual HRESULT __stdcall GetAttachedSurface		( D_DDSCAPS2 *, D_IDirectDrawSurface7 ** ) = 0 ;
		virtual HRESULT __stdcall NonUse03					( void ) = 0 ;				// GetBltStatus( DWORD ) = 0 ;
		virtual HRESULT __stdcall GetCaps					( D_DDSCAPS2 * ) = 0 ;
		virtual HRESULT __stdcall NonUse04					( void ) = 0 ;				// GetClipper( LPDIRECTDRAWCLIPPER FAR* ) = 0 ;
		virtual HRESULT __stdcall GetColorKey				( DWORD, D_DDCOLORKEY * ) = 0 ;
		virtual HRESULT __stdcall GetDC						( HDC * ) = 0 ;
		virtual HRESULT __stdcall NonUse05					( void ) = 0 ;				// GetFlipStatus( DWORD ) = 0 ;
		virtual HRESULT __stdcall NonUse06					( void ) = 0 ;				// GetOverlayPosition( LPLONG, LPLONG	) = 0 ;
		virtual HRESULT __stdcall NonUse07					( void ) = 0 ;				// GetPalette( LPDIRECTDRAWPALETTE FAR* ) = 0 ;
		virtual HRESULT __stdcall NonUse08					( void ) = 0 ;				// GetPixelFormat( LPDDPIXELFORMAT ) = 0 ;
		virtual HRESULT __stdcall GetSurfaceDesc			( D_DDSURFACEDESC2 * ) = 0 ;
		virtual HRESULT __stdcall NonUse09					( void ) = 0 ;				// Initialize( LPDIRECTDRAW, LPDDSURFACEDESC2 ) = 0 ;
		virtual HRESULT __stdcall IsLost					( void ) = 0 ;
		virtual HRESULT __stdcall Lock						( LPRECT, D_DDSURFACEDESC2 *, DWORD, HANDLE ) = 0 ;
		virtual HRESULT __stdcall ReleaseDC					( HDC ) = 0 ;
		virtual HRESULT __stdcall Restore					( void	) = 0 ;
		virtual HRESULT __stdcall SetClipper				( class D_IDirectDrawClipper * ) = 0 ;
		virtual HRESULT __stdcall SetColorKey				( DWORD, D_DDCOLORKEY * ) = 0 ;
		virtual HRESULT __stdcall NonUse10					( void ) = 0 ;				// SetOverlayPosition( LONG, LONG	) = 0 ;
		virtual HRESULT __stdcall SetPalette				( class D_IDirectDrawPalette * ) = 0 ;
		virtual HRESULT __stdcall Unlock					( LPRECT ) = 0 ;
		virtual HRESULT __stdcall UpdateOverlay				( LPRECT, D_IDirectDrawSurface7 *, LPRECT, DWORD, D_DDOVERLAYFX * ) = 0 ;
		virtual HRESULT __stdcall NonUse11					( void ) = 0 ;				// UpdateOverlayDisplay( DWORD ) = 0 ;
		virtual HRESULT __stdcall NonUse12					( void ) = 0 ;				// UpdateOverlayZOrder( DWORD, D_IDirectDrawSurface7 * ) = 0 ;

		virtual HRESULT __stdcall NonUse13					( void ) = 0 ;				// GetDDInterface( LPVOID FAR * ) = 0 ;
		virtual HRESULT __stdcall PageLock					( DWORD ) = 0 ;
		virtual HRESULT __stdcall NonUse15					( void ) = 0 ;				// PageUnlock( DWORD ) = 0 ;

		virtual HRESULT __stdcall NonUse16					( void ) = 0 ;				// SetSurfaceDesc( LPDDSURFACEDESC2, DWORD ) = 0 ;

		virtual HRESULT __stdcall NonUse17					( void ) = 0 ;				// SetPrivateData( REFGUID, LPVOID, DWORD, DWORD ) = 0 ;
		virtual HRESULT __stdcall NonUse18					( void ) = 0 ;				// GetPrivateData( REFGUID, LPVOID, LPDWORD ) = 0 ;
		virtual HRESULT __stdcall NonUse19					( void ) = 0 ;				// FreePrivateData( REFGUID ) = 0 ;
		virtual HRESULT __stdcall NonUse20					( void ) = 0 ;				// GetUniquenessValue( LPDWORD ) = 0 ;
		virtual HRESULT __stdcall NonUse21					( void ) = 0 ;				// ChangeUniquenessValue( void ) = 0 ;

		virtual HRESULT __stdcall NonUse22					( void ) = 0 ;				// SetPriority( DWORD ) = 0 ;
		virtual HRESULT __stdcall NonUse23					( void ) = 0 ;				// GetPriority( LPDWORD ) = 0 ;
		virtual HRESULT __stdcall NonUse24					( void ) = 0 ;				// SetLOD( DWORD ) = 0 ;
		virtual HRESULT __stdcall NonUse25					( void ) = 0 ;				// GetLOD( LPDWORD ) = 0 ;
	} ;

	class D_IDirectDrawClipper : public IUnknown
	{
	public :
		virtual HRESULT __stdcall NonUse00					( void ) = 0 ;				// GetClipList( LPRECT, LPRGNDATA, LPDWORD ) = 0 ;
		virtual HRESULT __stdcall NonUse01					( void ) = 0 ;				// GetHWnd( HWND FAR * ) = 0 ;
		virtual HRESULT __stdcall NonUse02					( void ) = 0 ;				// Initialize( LPDIRECTDRAW, DWORD ) = 0 ;
		virtual HRESULT __stdcall NonUse03					( void ) = 0 ;				// IsClipListChanged( BOOL FAR * ) = 0 ;
		virtual HRESULT __stdcall NonUse04					( void ) = 0 ;				// SetClipList( LPRGNDATA,DWORD ) = 0 ;
		virtual HRESULT __stdcall SetHWnd					( DWORD, HWND ) = 0 ;
	} ;

	class D_IDirectDrawPalette : public IUnknown 
	{
	public :
		virtual HRESULT __stdcall NonUse00					( void ) = 0 ;				// GetCaps( LPDWORD ) = 0 ;
		virtual HRESULT __stdcall GetEntries				( DWORD, DWORD, DWORD, LPPALETTEENTRY ) = 0 ;
		virtual HRESULT __stdcall NonUse01					( void ) = 0 ;				// Initialize( LPDIRECTDRAW, DWORD, LPPALETTEENTRY ) = 0 ;
		virtual HRESULT __stdcall SetEntries				( DWORD, DWORD, DWORD, LPPALETTEENTRY ) = 0 ;
	} ;
+/

	// Ｄｉｒｅｃｔ３Ｄ -----------------------------------------------------------

	//const int D_D3D_OK = (D_DD_OK);

	const int D_D3DENUMRET_CANCEL = D_DDENUMRET_CANCEL;
	const int D_D3DENUMRET_OK = D_DDENUMRET_OK;

	const int D_D3DPTEXTURECAPS_POW2 = (0x00000002L);
	const int D_D3DPTEXTURECAPS_SQUAREONLY = (0x00000020L);

	const int D_D3DTA_DIFFUSE = (0x00000000);
	const int D_D3DTA_CURRENT = (0x00000001);
	const int D_D3DTA_TEXTURE = (0x00000002);
	const int D_D3DTA_TFACTOR = (0x00000003);
	const int D_D3DTA_SPECULAR = (0x00000004);

	const int D_D3DFVF_XYZ = (0x002);
	const int D_D3DFVF_XYZRHW = (0x004);
	const int D_D3DFVF_NORMAL = (0x010);
	const int D_D3DFVF_DIFFUSE = (0x040);
	const int D_D3DFVF_SPECULAR = (0x080);
	const int D_D3DFVF_TEX1 = (0x100);
	const int D_D3DFVF_TEX2 = (0x200);
	const int D_D3DFVF_TEX3 = (0x300);

	//int D_RGBA_MAKE(int r, int g, int b, int a){return (cast(D_D3DCOLOR) (((a) << 24) | ((r) << 16) | ((g) << 8) | (b)));}
//                #include <dinput.h>
//                #include <ddraw.h>
//                #include <d3d.h>
            //  #ifndef DX_NON_MOVIE
            //      #include <dshow.h>
            //  #endif
            //  #include <qedit.h>
            //  #include <stdio.h>
//                #include <dsound.h>
//                #include <dmusici.h>
//                
//                #define D_HMONITOR                              HMONITOR
	enum D_D3DCULL
	{
		D_D3DCULL_NONE								= 1,
		D_D3DCULL_CW								= 2,
		D_D3DCULL_CCW								= 3,
		D_D3DCULL_FORCE_DWORD						= 0x7fffffff,
    }

	enum D_D3DZBUFFERTYPE
	{
		D_D3DZB_FALSE								= 0,
		D_D3DZB_TRUE								= 1,
		D_D3DZB_USEW								= 2,
		D_D3DZB_FORCE_DWORD							= 0x7fffffff,
    }

	enum D_D3DBLEND
	{
		D_D3DBLEND_ZERO								= 1,
		D_D3DBLEND_ONE								= 2,
		D_D3DBLEND_SRCCOLOR							= 3,
		D_D3DBLEND_INVSRCCOLOR						= 4,
		D_D3DBLEND_SRCALPHA							= 5,
		D_D3DBLEND_INVSRCALPHA						= 6,
		D_D3DBLEND_DESTALPHA						= 7,
		D_D3DBLEND_INVDESTALPHA						= 8,
		D_D3DBLEND_DESTCOLOR						= 9,
		D_D3DBLEND_INVDESTCOLOR						= 10,
		D_D3DBLEND_SRCALPHASAT						= 11,
		D_D3DBLEND_BOTHSRCALPHA						= 12,
		D_D3DBLEND_BOTHINVSRCALPHA					= 13,
		D_D3DBLEND_FORCE_DWORD						= 0x7fffffff,
    }

	enum D_D3DTEXTUREOP
	{
		D_D3DTOP_DISABLE							= 1,
		D_D3DTOP_SELECTARG1							= 2,
		D_D3DTOP_SELECTARG2							= 3,

		D_D3DTOP_MODULATE							= 4,
		D_D3DTOP_MODULATE2X							= 5,
		D_D3DTOP_MODULATE4X							= 6,

		D_D3DTOP_ADD								= 7,
		D_D3DTOP_ADDSIGNED							= 8,
		D_D3DTOP_ADDSIGNED2X						= 9,
		D_D3DTOP_SUBTRACT							= 10,
		D_D3DTOP_ADDSMOOTH							= 11,

		D_D3DTOP_BLENDDIFFUSEALPHA					= 12,
		D_D3DTOP_BLENDTEXTUREALPHA					= 13,
		D_D3DTOP_BLENDFACTORALPHA					= 14,

		D_D3DTOP_BLENDTEXTUREALPHAPM				= 15,
		D_D3DTOP_BLENDCURRENTALPHA					= 16,

		D_D3DTOP_PREMODULATE						= 17,
		D_D3DTOP_MODULATEALPHA_ADDCOLOR				= 18,
		D_D3DTOP_MODULATECOLOR_ADDALPHA				= 19,
		D_D3DTOP_MODULATEINVALPHA_ADDCOLOR			= 20,
		D_D3DTOP_MODULATEINVCOLOR_ADDALPHA			= 21,

		D_D3DTOP_BUMPENVMAP							= 22,
		D_D3DTOP_BUMPENVMAPLUMINANCE				= 23,
		D_D3DTOP_DOTPRODUCT3						= 24,

		D_D3DTOP_FORCE_DWORD						= 0x7fffffff,
    }

	enum D_D3DSHADEMODE
	{
		D_D3DSHADE_FLAT								= 1,
		D_D3DSHADE_GOURAUD							= 2,
		D_D3DSHADE_PHONG							= 3,
		D_D3DSHADE_FORCE_DWORD						= 0x7fffffff,
    }

	enum D_D3DTEXTUREMAGFILTER
	{
		D_D3DTFG_POINT								= 1,
		D_D3DTFG_LINEAR								= 2,
		D_D3DTFG_FLATCUBIC							= 3,
		D_D3DTFG_GAUSSIANCUBIC						= 4,
		D_D3DTFG_ANISOTROPIC						= 5,
		D_D3DTFG_FORCE_DWORD						= 0x7fffffff,
    }

	enum D_D3DTEXTUREMINFILTER
	{
		D_D3DTFN_POINT								= 1,
		D_D3DTFN_LINEAR								= 2,
		D_D3DTFN_ANISOTROPIC						= 3,
		D_D3DTFN_FORCE_DWORD						= 0x7fffffff,
    }

	enum D_D3DTEXTUREADDRESS
	{
		D_D3DTADDRESS_WRAP							= 1,
		D_D3DTADDRESS_MIRROR						= 2,
		D_D3DTADDRESS_CLAMP							= 3,
		D_D3DTADDRESS_BORDER						= 4,
		D_D3DTADDRESS_FORCE_DWORD					= 0x7fffffff,
    }

	enum D_D3DPRIMITIVETYPE
	{
		D_D3DPT_POINTLIST							= 1,
		D_D3DPT_LINELIST							= 2,
		D_D3DPT_LINESTRIP							= 3,
		D_D3DPT_TRIANGLELIST						= 4,
		D_D3DPT_TRIANGLESTRIP						= 5,
		D_D3DPT_TRIANGLEFAN							= 6,
		D_D3DPT_FORCE_DWORD							= 0x7fffffff,
    }

	enum D_D3DCMPFUNC
	{
		D_D3DCMP_NEVER								= 1, 
		D_D3DCMP_LESS								= 2, 
		D_D3DCMP_EQUAL								= 3, 
		D_D3DCMP_LESSEQUAL							= 4, 
		D_D3DCMP_GREATER							= 5, 
		D_D3DCMP_NOTEQUAL							= 6, 
		D_D3DCMP_GREATEREQUAL						= 7, 
		D_D3DCMP_ALWAYS								= 8, 
		D_D3DCMP_FORCE_DWORD						= 0x7fffffff, 
    }
	
	enum D_D3DRENDERSTATETYPE
	{
		D_D3DRENDERSTATE_ANTIALIAS					= 2,
		D_D3DRENDERSTATE_TEXTUREPERSPECTIVE			= 4,
		D_D3DRENDERSTATE_ZENABLE					= 7,
		D_D3DRENDERSTATE_FILLMODE					= 8,
		D_D3DRENDERSTATE_SHADEMODE					= 9,
		D_D3DRENDERSTATE_LINEPATTERN				= 10,
		D_D3DRENDERSTATE_ZWRITEENABLE				= 14,
		D_D3DRENDERSTATE_ALPHATESTENABLE			= 15,
		D_D3DRENDERSTATE_LASTPIXEL					= 16,
		D_D3DRENDERSTATE_SRCBLEND					= 19,
		D_D3DRENDERSTATE_DESTBLEND					= 20,
		D_D3DRENDERSTATE_CULLMODE					= 22,
		D_D3DRENDERSTATE_ZFUNC						= 23,
		D_D3DRENDERSTATE_ALPHAREF					= 24,
		D_D3DRENDERSTATE_ALPHAFUNC					= 25,
		D_D3DRENDERSTATE_DITHERENABLE				= 26,
		D_D3DRENDERSTATE_ALPHABLENDENABLE			= 27,
		D_D3DRENDERSTATE_FOGENABLE					= 28,
		D_D3DRENDERSTATE_SPECULARENABLE				= 29,
		D_D3DRENDERSTATE_ZVISIBLE					= 30,
		D_D3DRENDERSTATE_STIPPLEDALPHA				= 33,
		D_D3DRENDERSTATE_FOGCOLOR					= 34,
		D_D3DRENDERSTATE_FOGTABLEMODE				= 35,
		D_D3DRENDERSTATE_FOGSTART					= 36,
		D_D3DRENDERSTATE_FOGEND						= 37,
		D_D3DRENDERSTATE_FOGDENSITY					= 38,
		D_D3DRENDERSTATE_EDGEANTIALIAS				= 40,
		D_D3DRENDERSTATE_COLORKEYENABLE				= 41,
		D_D3DRENDERSTATE_ZBIAS						= 47,
		D_D3DRENDERSTATE_RANGEFOGENABLE				= 48,
		D_D3DRENDERSTATE_STENCILENABLE				= 52,
		D_D3DRENDERSTATE_STENCILFAIL				= 53,
		D_D3DRENDERSTATE_STENCILZFAIL				= 54,
		D_D3DRENDERSTATE_STENCILPASS				= 55,
		D_D3DRENDERSTATE_STENCILFUNC				= 56,
		D_D3DRENDERSTATE_STENCILREF					= 57,
		D_D3DRENDERSTATE_STENCILMASK				= 58,
		D_D3DRENDERSTATE_STENCILWRITEMASK			= 59,
		D_D3DRENDERSTATE_TEXTUREFACTOR				= 60,
		D_D3DRENDERSTATE_WRAP0						= 128,
		D_D3DRENDERSTATE_WRAP1						= 129,
		D_D3DRENDERSTATE_WRAP2						= 130,
		D_D3DRENDERSTATE_WRAP3						= 131,
		D_D3DRENDERSTATE_WRAP4						= 132,
		D_D3DRENDERSTATE_WRAP5						= 133,
		D_D3DRENDERSTATE_WRAP6						= 134,
		D_D3DRENDERSTATE_WRAP7						= 135,
		D_D3DRENDERSTATE_CLIPPING					= 136,
		D_D3DRENDERSTATE_LIGHTING					= 137,
		D_D3DRENDERSTATE_EXTENTS					= 138,
		D_D3DRENDERSTATE_AMBIENT					= 139,
		D_D3DRENDERSTATE_FOGVERTEXMODE				= 140,
		D_D3DRENDERSTATE_COLORVERTEX				= 141,
		D_D3DRENDERSTATE_LOCALVIEWER				= 142,
		D_D3DRENDERSTATE_NORMALIZENORMALS			= 143,
		D_D3DRENDERSTATE_COLORKEYBLENDENABLE		= 144,
		D_D3DRENDERSTATE_DIFFUSEMATERIALSOURCE		= 145,
		D_D3DRENDERSTATE_SPECULARMATERIALSOURCE		= 146,
		D_D3DRENDERSTATE_AMBIENTMATERIALSOURCE		= 147,
		D_D3DRENDERSTATE_EMISSIVEMATERIALSOURCE		= 148,
		D_D3DRENDERSTATE_VERTEXBLEND				= 151,
		D_D3DRENDERSTATE_CLIPPLANEENABLE			= 152,

		D_D3DRENDERSTATE_TEXTUREHANDLE				= 1,
		D_D3DRENDERSTATE_TEXTUREADDRESS				= 3,
		D_D3DRENDERSTATE_WRAPU						= 5,
		D_D3DRENDERSTATE_WRAPV						= 6,
		D_D3DRENDERSTATE_MONOENABLE					= 11,
		D_D3DRENDERSTATE_ROP2						= 12,
		D_D3DRENDERSTATE_PLANEMASK					= 13,
		D_D3DRENDERSTATE_TEXTUREMAG					= 17,
		D_D3DRENDERSTATE_TEXTUREMIN					= 18,
		D_D3DRENDERSTATE_TEXTUREMAPBLEND			= 21,
		D_D3DRENDERSTATE_SUBPIXEL					= 31,
		D_D3DRENDERSTATE_SUBPIXELX					= 32,
		D_D3DRENDERSTATE_STIPPLEENABLE				= 39,
		D_D3DRENDERSTATE_BORDERCOLOR				= 43,
		D_D3DRENDERSTATE_TEXTUREADDRESSU			= 44,
		D_D3DRENDERSTATE_TEXTUREADDRESSV			= 45,
		D_D3DRENDERSTATE_MIPMAPLODBIAS				= 46,
		D_D3DRENDERSTATE_ANISOTROPY					= 49,
		D_D3DRENDERSTATE_FLUSHBATCH					= 50,
		D_D3DRENDERSTATE_TRANSLUCENTSORTINDEPENDENT	= 51,
		D_D3DRENDERSTATE_STIPPLEPATTERN00			= 64,
		D_D3DRENDERSTATE_STIPPLEPATTERN01			= 65,
		D_D3DRENDERSTATE_STIPPLEPATTERN02			= 66,
		D_D3DRENDERSTATE_STIPPLEPATTERN03			= 67,
		D_D3DRENDERSTATE_STIPPLEPATTERN04			= 68,
		D_D3DRENDERSTATE_STIPPLEPATTERN05			= 69,
		D_D3DRENDERSTATE_STIPPLEPATTERN06			= 70,
		D_D3DRENDERSTATE_STIPPLEPATTERN07			= 71,
		D_D3DRENDERSTATE_STIPPLEPATTERN08			= 72,
		D_D3DRENDERSTATE_STIPPLEPATTERN09			= 73,
		D_D3DRENDERSTATE_STIPPLEPATTERN10			= 74,
		D_D3DRENDERSTATE_STIPPLEPATTERN11			= 75,
		D_D3DRENDERSTATE_STIPPLEPATTERN12			= 76,
		D_D3DRENDERSTATE_STIPPLEPATTERN13			= 77,
		D_D3DRENDERSTATE_STIPPLEPATTERN14			= 78,
		D_D3DRENDERSTATE_STIPPLEPATTERN15			= 79,
		D_D3DRENDERSTATE_STIPPLEPATTERN16			= 80,
		D_D3DRENDERSTATE_STIPPLEPATTERN17			= 81,
		D_D3DRENDERSTATE_STIPPLEPATTERN18			= 82,
		D_D3DRENDERSTATE_STIPPLEPATTERN19			= 83,
		D_D3DRENDERSTATE_STIPPLEPATTERN20			= 84,
		D_D3DRENDERSTATE_STIPPLEPATTERN21			= 85,
		D_D3DRENDERSTATE_STIPPLEPATTERN22			= 86,
		D_D3DRENDERSTATE_STIPPLEPATTERN23			= 87,
		D_D3DRENDERSTATE_STIPPLEPATTERN24			= 88,
		D_D3DRENDERSTATE_STIPPLEPATTERN25			= 89,
		D_D3DRENDERSTATE_STIPPLEPATTERN26			= 90,
		D_D3DRENDERSTATE_STIPPLEPATTERN27			= 91,
		D_D3DRENDERSTATE_STIPPLEPATTERN28			= 92,
		D_D3DRENDERSTATE_STIPPLEPATTERN29			= 93,
		D_D3DRENDERSTATE_STIPPLEPATTERN30			= 94,
		D_D3DRENDERSTATE_STIPPLEPATTERN31			= 95,

		D_D3DRENDERSTATE_FOGTABLESTART				= 36,
		D_D3DRENDERSTATE_FOGTABLEEND				= 37,
		D_D3DRENDERSTATE_FOGTABLEDENSITY			= 38,

		D_D3DRENDERSTATE_FORCE_DWORD				= 0x7fffffff,
    }

	enum D_D3DTEXTURESESTATETYPE
	{
		D_D3DTSS_COLOROP							= 1,
		D_D3DTSS_COLORARG1							= 2,
		D_D3DTSS_COLORARG2							= 3,
		D_D3DTSS_ALPHAOP							= 4,
		D_D3DTSS_ALPHAARG1							= 5,
		D_D3DTSS_ALPHAARG2							= 6,
		D_D3DTSS_BUMPENVMAT00						= 7,
		D_D3DTSS_BUMPENVMAT01						= 8,
		D_D3DTSS_BUMPENVMAT10						= 9,
		D_D3DTSS_BUMPENVMAT11						= 10,
		D_D3DTSS_TEXCOORDINDEX						= 11,
		D_D3DTSS_ADDRESS							= 12,
		D_D3DTSS_ADDRESSU							= 13,
		D_D3DTSS_ADDRESSV							= 14,
		D_D3DTSS_BORDERCOLOR						= 15,
		D_D3DTSS_MAGFILTER							= 16,
		D_D3DTSS_MINFILTER							= 17,
		D_D3DTSS_MIPFILTER							= 18,
		D_D3DTSS_MIPMAPLODBIAS						= 19,
		D_D3DTSS_MAXMIPLEVEL						= 20,
		D_D3DTSS_MAXANISOTROPY						= 21,
		D_D3DTSS_BUMPENVLSCALE						= 22,
		D_D3DTSS_BUMPENVLOFFSET						= 23,
		D_D3DTSS_TEXTURETRANSFORMFLAGS				= 24,
		D_D3DTSS_FORCE_DWORD						= 0x7fffffff,
    }

	enum D_D3DTRANSFORMSTATETYPE
	{
		D_D3DTRANSFORMSTATE_WORLD					= 1,
		D_D3DTRANSFORMSTATE_VIEW					= 2,
		D_D3DTRANSFORMSTATE_PROJECTION				= 3,
		D_D3DTRANSFORMSTATE_WORLD1					= 4,
		D_D3DTRANSFORMSTATE_WORLD2					= 5,
		D_D3DTRANSFORMSTATE_WORLD3					= 6,
		D_D3DTRANSFORMSTATE_TEXTURE0				= 16,
		D_D3DTRANSFORMSTATE_TEXTURE1				= 17,
		D_D3DTRANSFORMSTATE_TEXTURE2				= 18,
		D_D3DTRANSFORMSTATE_TEXTURE3				= 19,
		D_D3DTRANSFORMSTATE_TEXTURE4				= 20,
		D_D3DTRANSFORMSTATE_TEXTURE5				= 21,
		D_D3DTRANSFORMSTATE_TEXTURE6				= 22,
		D_D3DTRANSFORMSTATE_TEXTURE7				= 23,
		D_D3DTRANSFORMSTATE_FORCE_DWORD				= 0x7fffffff,
    }

	enum D_D3DLIGHTTYPE
	{
		D_D3DLIGHT_POINT							= 1,
		D_D3DLIGHT_SPOT								= 2,
		D_D3DLIGHT_DIRECTIONAL						= 3,
		D_D3DLIGHT_PARALLELPOINT					= 4,
		D_D3DLIGHT_GLSPOT							= 5,
		D_D3DLIGHT_FORCE_DWORD						= 0x7fffffff,
    }
            
                // ＤｉｒｅｃｔＳｏｕｎｄ -----------------------------------------------------
            
    
        // ＤｉｒｅｃｔＤｒａｗ -------------------------------------------------------
    
	// ＤｉｒｅｃｔＩｎｐｕｔ -----------------------------------------------------

	//const int D_DI_OK = (S_OK);
	const int D_DIDEVTYPE_KEYBOARD = (3);
	const int D_DIDEVTYPE_JOYSTICK = (4);
	const int D_DIEDFL_ATTACHEDONLY = (0x00000001);

	const int D_DIENUM_STOP = (0);
	const int D_DIENUM_CONTINUE = (1);

	//int D_DIPROP_BUFFERSIZE(){return (*cast(const GUID *)(1));}
	//int D_DIPROP_RANGE(){return (*cast(const GUID *)(4));}
	//int D_DIPROP_DEADZONE(){return (*cast(const GUID *)(5));}

	//int D_DI_POLLEDDEVICE(){return (cast(HRESULT)0x00000002L);}

	const int D_DISCL_EXCLUSIVE = (0x00000001);
	const int D_DISCL_NONEXCLUSIVE = (0x00000002);
	const int D_DISCL_FOREGROUND = (0x00000004);
	const int D_DISCL_BACKGROUND = (0x00000008);

    /+
	const int D_DIJOFS_X = FIELD_OFFSET(D_DIJOYSTATE, lX);
	const int D_DIJOFS_Y = FIELD_OFFSET(D_DIJOYSTATE, lY);
	const int D_DIJOFS_Z = FIELD_OFFSET(D_DIJOYSTATE, lZ);
	const int D_DIJOFS_RX = FIELD_OFFSET(D_DIJOYSTATE, lRx);
	const int D_DIJOFS_RY = FIELD_OFFSET(D_DIJOYSTATE, lRy);
	const int D_DIJOFS_RZ = FIELD_OFFSET(D_DIJOYSTATE, lRz);
    +/

	const int D_DIPH_DEVICE = (0);
	const int D_DIPH_BYOFFSET = (1);
	int D_DIDFT_ENUMCOLLECTION(int n){return (cast(WORD)(n) << 8);}

	const int D_DIK_ESCAPE = (0x01);
	const int D_DIK_1 = (0x02);
	const int D_DIK_2 = (0x03);
	const int D_DIK_3 = (0x04);
	const int D_DIK_4 = (0x05);
	const int D_DIK_5 = (0x06);
	const int D_DIK_6 = (0x07);
	const int D_DIK_7 = (0x08);
	const int D_DIK_8 = (0x09);
	const int D_DIK_9 = (0x0A);
	const int D_DIK_0 = (0x0B);
	const int D_DIK_MINUS = (0x0C);
	const int D_DIK_EQUALS = (0x0D);
	const int D_DIK_BACK = (0x0E);
	const int D_DIK_TAB = (0x0F);
	const int D_DIK_Q = (0x10);
	const int D_DIK_W = (0x11);
	const int D_DIK_E = (0x12);
	const int D_DIK_R = (0x13);
	const int D_DIK_T = (0x14);
	const int D_DIK_Y = (0x15);
	const int D_DIK_U = (0x16);
	const int D_DIK_I = (0x17);
	const int D_DIK_O = (0x18);
	const int D_DIK_P = (0x19);
	const int D_DIK_LBRACKET = (0x1A);
	const int D_DIK_RBRACKET = (0x1B);
	const int D_DIK_RETURN = (0x1C);
	const int D_DIK_LCONTROL = (0x1D);
	const int D_DIK_A = (0x1E);
	const int D_DIK_S = (0x1F);
	const int D_DIK_D = (0x20);
	const int D_DIK_F = (0x21);
	const int D_DIK_G = (0x22);
	const int D_DIK_H = (0x23);
	const int D_DIK_J = (0x24);
	const int D_DIK_K = (0x25);
	const int D_DIK_L = (0x26);
	const int D_DIK_SEMICOLON = (0x27);
	const int D_DIK_APOSTROPHE = (0x28);
	const int D_DIK_GRAVE = (0x29);
	const int D_DIK_LSHIFT = (0x2A);
	const int D_DIK_BACKSLASH = (0x2B);
	const int D_DIK_Z = (0x2C);
	const int D_DIK_X = (0x2D);
	const int D_DIK_C = (0x2E);
	const int D_DIK_V = (0x2F);
	const int D_DIK_B = (0x30);
	const int D_DIK_N = (0x31);
	const int D_DIK_M = (0x32);
	const int D_DIK_COMMA = (0x33);
	const int D_DIK_PERIOD = (0x34);
	const int D_DIK_SLASH = (0x35);
	const int D_DIK_RSHIFT = (0x36);
	const int D_DIK_MULTIPLY = (0x37);
	const int D_DIK_LMENU = (0x38);
	const int D_DIK_SPACE = (0x39);
	const int D_DIK_CAPITAL = (0x3A);
	const int D_DIK_F1 = (0x3B);
	const int D_DIK_F2 = (0x3C);
	const int D_DIK_F3 = (0x3D);
	const int D_DIK_F4 = (0x3E);
	const int D_DIK_F5 = (0x3F);
	const int D_DIK_F6 = (0x40);
	const int D_DIK_F7 = (0x41);
	const int D_DIK_F8 = (0x42);
	const int D_DIK_F9 = (0x43);
	const int D_DIK_F10 = (0x44);
	const int D_DIK_NUMLOCK = (0x45);
	const int D_DIK_SCROLL = (0x46);
	const int D_DIK_NUMPAD7 = (0x47);
	const int D_DIK_NUMPAD8 = (0x48);
	const int D_DIK_NUMPAD9 = (0x49);
	const int D_DIK_SUBTRACT = (0x4A);
	const int D_DIK_NUMPAD4 = (0x4B);
	const int D_DIK_NUMPAD5 = (0x4C);
	const int D_DIK_NUMPAD6 = (0x4D);
	const int D_DIK_ADD = (0x4E);
	const int D_DIK_NUMPAD1 = (0x4F);
	const int D_DIK_NUMPAD2 = (0x50);
	const int D_DIK_NUMPAD3 = (0x51);
	const int D_DIK_NUMPAD0 = (0x52);
	const int D_DIK_DECIMAL = (0x53);
	const int D_DIK_OEM_102 = (0x56);
	const int D_DIK_F11 = (0x57);
	const int D_DIK_F12 = (0x58);
	const int D_DIK_F13 = (0x64);
	const int D_DIK_F14 = (0x65);
	const int D_DIK_F15 = (0x66);
	const int D_DIK_KANA = (0x70);
	const int D_DIK_ABNT_C1 = (0x73);
	const int D_DIK_CONVERT = (0x79);
	const int D_DIK_NOCONVERT = (0x7B);
	const int D_DIK_YEN = (0x7D);
	const int D_DIK_ABNT_C2 = (0x7E);
	const int D_DIK_NUMPADEQUALS = (0x8D);
	const int D_DIK_PREVTRACK = (0x90);
	const int D_DIK_AT = (0x91);
	const int D_DIK_COLON = (0x92);
	const int D_DIK_UNDERLINE = (0x93);
	const int D_DIK_KANJI = (0x94);
	const int D_DIK_STOP = (0x95);
	const int D_DIK_AX = (0x96);
	const int D_DIK_UNLABELED = (0x97);
	const int D_DIK_NEXTTRACK = (0x99);
	const int D_DIK_NUMPADENTER = (0x9C);
	const int D_DIK_RCONTROL = (0x9D);
	const int D_DIK_MUTE = (0xA0);
	const int D_DIK_CALCULATOR = (0xA1);
	const int D_DIK_PLAYPAUSE = (0xA2);
	const int D_DIK_MEDIASTOP = (0xA4);
	const int D_DIK_VOLUMEDOWN = (0xAE);
	const int D_DIK_VOLUMEUP = (0xB0);
	const int D_DIK_WEBHOME = (0xB2);
	const int D_DIK_NUMPADCOMMA = (0xB3);
	const int D_DIK_DIVIDE = (0xB5);
	const int D_DIK_SYSRQ = (0xB7);
	const int D_DIK_RMENU = (0xB8);
	const int D_DIK_PAUSE = (0xC5);
	const int D_DIK_HOME = (0xC7);
	const int D_DIK_UP = (0xC8);
	const int D_DIK_PRIOR = (0xC9);
	const int D_DIK_LEFT = (0xCB);
	const int D_DIK_RIGHT = (0xCD);
	const int D_DIK_END = (0xCF);
	const int D_DIK_DOWN = (0xD0);
	const int D_DIK_NEXT = (0xD1);
	const int D_DIK_INSERT = (0xD2);
	const int D_DIK_DELETE = (0xD3);
	const int D_DIK_LWIN = (0xDB);
	const int D_DIK_RWIN = (0xDC);
	const int D_DIK_APPS = (0xDD);
	const int D_DIK_POWER = (0xDE);
	const int D_DIK_SLEEP = (0xDF);
	const int D_DIK_WAKE = (0xE3);
	const int D_DIK_WEBSEARCH = (0xE5);
	const int D_DIK_WEBFAVORITES = (0xE6);
	const int D_DIK_WEBREFRESH = (0xE7);
	const int D_DIK_WEBSTOP = (0xE8);
	const int D_DIK_WEBFORWARD = (0xE9);
	const int D_DIK_WEBBACK = (0xEA);
	const int D_DIK_MYCOMPUTER = (0xEB);
	const int D_DIK_MAIL = (0xEC);
	const int D_DIK_MEDIASELECT = (0xED);

	const int D_DIK_BACKSPACE = D_DIK_BACK;
	const int D_DIK_NUMPADSTAR = D_DIK_MULTIPLY;
	const int D_DIK_LALT = D_DIK_LMENU;
	const int D_DIK_CAPSLOCK = D_DIK_CAPITAL;
	const int D_DIK_NUMPADMINUS = D_DIK_SUBTRACT;
	const int D_DIK_NUMPADPLUS = D_DIK_ADD;
	const int D_DIK_NUMPADPERIOD = D_DIK_DECIMAL;
	const int D_DIK_NUMPADSLASH = D_DIK_DIVIDE;
	const int D_DIK_RALT = D_DIK_RMENU;
	const int D_DIK_UPARROW = D_DIK_UP;
	const int D_DIK_PGUP = D_DIK_PRIOR;
	const int D_DIK_LEFTARROW = D_DIK_LEFT;
	const int D_DIK_RIGHTARROW = D_DIK_RIGHT;
	const int D_DIK_DOWNARROW = D_DIK_DOWN;
	const int D_DIK_PGDN = D_DIK_NEXT;

	const int D_DI_DEGREES = (100);
	const int D_DI_FFNOMINALMAX = (10000);
	const int D_DI_SECONDS = (1000000);

	const int D_DIEFF_OBJECTIDS = (0x00000001);
	const int D_DIEFF_OBJECTOFFSETS = (0x00000002);
	const int D_DIEFF_CARTESIAN = (0x00000010);
	const int D_DIEFF_POLAR = (0x00000020);
	const int D_DIEFF_SPHERICAL = (0x00000040);

	//int D_DIJOFS_BUTTON(int n){return (FIELD_OFFSET(D_DIJOYSTATE, rgbButtons) + (n));}

	const int D_DIEP_DURATION = (0x00000001);
	const int D_DIEP_SAMPLEPERIOD = (0x00000002);
	const int D_DIEP_GAIN = (0x00000004);
	const int D_DIEP_TRIGGERBUTTON = (0x00000008);
	const int D_DIEP_TRIGGERREPEATINTERVAL = (0x00000010);
	const int D_DIEP_AXES = (0x00000020);
	const int D_DIEP_DIRECTION = (0x00000040);
	const int D_DIEP_ENVELOPE = (0x00000080);
	const int D_DIEP_TYPESPECIFICPARAMS = (0x00000100);
	const int D_DIEP_START = (0x20000000);
	const int D_DIEP_NORESTART = (0x40000000);
	const int D_DIEP_NODOWNLOAD = (0x80000000);
	const int D_DIEB_NOTRIGGER = (0xFFFFFFFF);

	const int D_DIEFT_ALL = (0x00000000);
	const int D_DIEFT_CONSTANTFORCE = (0x00000001);
	const int D_DIEFT_RAMPFORCE = (0x00000002);
	const int D_DIEFT_PERIODIC = (0x00000003);
	const int D_DIEFT_CONDITION = (0x00000004);
	const int D_DIEFT_CUSTOMFORCE = (0x00000005);
	const int D_DIEFT_HARDWARE = (0x000000FF);
	const int D_DIEFT_FFATTACK = (0x00000200);
	const int D_DIEFT_FFFADE = (0x00000400);
	const int D_DIEFT_SATURATION = (0x00000800);
	const int D_DIEFT_POSNEGCOEFFICIENTS = (0x00001000);
	const int D_DIEFT_POSNEGSATURATION = (0x00002000);
	const int D_DIEFT_DEADBAND = (0x00004000);
	const int D_DIEFT_STARTDELAY = (0x00008000);
