module sha.sha1;

import std.stream;

ubyte[] hash( uint seed ){
	// make message
	union _Seed{
		uint		integer;
		ubyte	parts[4];
	}
	_Seed Seed;
	
	Seed.integer = seed;
	
	ubyte[] msg;
	msg ~= Seed.parts[0];
	msg ~= Seed.parts[1];
	msg ~= Seed.parts[2];
	msg ~= Seed.parts[3];
	//
	SHA1 hash = new SHA1( msg );
	return hash.hash();
}

ubyte[] hash( char[] msg ){
	SHA1 hash = new SHA1( cast(ubyte[])msg );
	return hash.hash();
}

uint[] hashUInts( uint seed ){
	union _u32u8{
		uint		u32[5];
		ubyte	u8[20];
	}
	_u32u8	value;
	ubyte tmp[] = hash( seed );
	foreach( int i, ubyte val; tmp ){
		value.u8[i] = val;
	}
	return value.u32;
}

uint[] hashUInts( char[] msg ){
	SHA1 hash = new SHA1( cast(ubyte[])msg );
	union _u32u8{
		uint		u32[5];
		ubyte	u8[20];
	}
	_u32u8	value;
	ubyte tmp[] = hash.hash();
	foreach( int i, ubyte val; tmp ){
		value.u8[i] = val;
	}
	return value.u32;
}
uint hashUInt( uint seed ){
	uint value[];
	value = hashUInts( seed );
	return (value[0]^value[1]^value[2]^value[3]^value[4]);
}

uint hashUInt( char[] msg ){
	SHA1 hash = new SHA1( cast(ubyte[])msg );
	ubyte tmp[] = hash.hash();
	union _u32u8{
		uint		u32[5];
		ubyte	u8[20];
	}
	_u32u8	value;
	foreach( int i, ubyte val; tmp ){
		value.u8[i] = val;
	}
	return (value.u32[0]^value.u32[1]^value.u32[2]^value.u32[3]^value.u32[4]);
}

//
class SHA1{
private:
	const int		HashSize		= 20;		// Hash size (byte)
	uint				IntermediateHash[HashSize/4];	// Message Digest
	uint				Length;							// Message length
	uint				LengthLow;					// Message length in bits
	uint				LengthHigh;					// Message length in bits
	int				MessageBlockIndex;	// Index into message block array
	ubyte			MessageBlock[64];		// 512-bit message blocks
	int				Computed;						// Is the digest computed?
	int				Corrupted;						// Is the message digest corrupted?
	//
	ubyte[]		Message;
	const uint	K[4] = [								// inner constance
		0x5A827999,
		0x6ED9EBA1,
		0x8F1BBCDC,
		0xCA62C1D6
	];
public:
	this( ubyte[] msg )
	{
		Length						= msg.length;
		LengthLow					= 0;
		LengthHigh				= 0;
		MessageBlockIndex	= 0;
		
		IntermediateHash[0] = 0x67452301;
		IntermediateHash[1] = 0xefcdab89;
		IntermediateHash[2] = 0x98badcfe;
		IntermediateHash[3] = 0x10325476;
		IntermediateHash[4] = 0xc3d2e1f0;
		
		Computed	= 0;
		Corrupted	= 0;
		//
		Message = msg;
	}
	ubyte[] hash(){
		calclation();
		static ubyte Result[HashSize];
		for( int i; i<HashSize; i++ ){
			Result[i] = cast(ubyte)(IntermediateHash[i>>2] >> ( 8 * (3-i%4) ));
		}
		return Result;
	}
private:
	uint shiftCircular( uint bits, uint value ){
		return ( ((value)<<(bits)) | ((value)>>(32-(bits))) );
	}
	void paddingMessage()
	{
		if( MessageBlockIndex > 55 )
		{
			MessageBlock[MessageBlockIndex++] = 0x80;
			while( MessageBlockIndex<64 ){
				MessageBlock[MessageBlockIndex++] = 0;
			}
			processMessageBlock();
			while( MessageBlockIndex<56 ){
				MessageBlock[MessageBlockIndex++] = 0;
			}
		}
		else
		{
			MessageBlock[MessageBlockIndex++] = 0x80;
			while( MessageBlockIndex<56 ){
				MessageBlock[MessageBlockIndex++] = 0;
			}
		}
		// Sore the message length as the last 8 octets
		MessageBlock[56] = LengthHigh >> 24;
		MessageBlock[57] = cast(ubyte)(LengthHigh >> 16);
		MessageBlock[58] = cast(ubyte)(LengthHigh >> 8);
		MessageBlock[59] = cast(ubyte)(LengthHigh);
		MessageBlock[60] = cast(ubyte)(LengthLow >> 24);
		MessageBlock[61] = cast(ubyte)(LengthLow >> 16);
		MessageBlock[62] = cast(ubyte)(LengthLow >> 8);
		MessageBlock[63] = cast(ubyte)(LengthLow);
		
		for( int i=0; i<64; i++ ){
//			if( i%8 == 0 ) printf( "\n" );
//			printf( "%02x", MessageBlock[i] );
		}
		
		processMessageBlock();
	}
	void processMessageBlock()
	{
		int	t;						// Loop counter
		uint	temp;				// Temporary word value
		uint	W[80];				// Word sequence
		uint	A, B, C, D, E;	// Word buffers
		
		// Initialize the first 16 words in the array
		for( t=0; t<16; t++ ){
			W[t] =	MessageBlock[ t*4+0 ] << 24;
			W[t] |=	MessageBlock[ t*4+1 ] << 16;
			W[t] |=	MessageBlock[ t*4+2 ] << 8;
			W[t] |=	MessageBlock[ t*4+3 ];
		}
		
		for( t=16; t<80; t++ ){
			W[t] = shiftCircular( 1, (W[t-3]^W[t-8]^W[t-14]^W[t-16]) );
		}
		
		{
			A	= IntermediateHash[0];
			B	= IntermediateHash[1];
			C	= IntermediateHash[2];
			D	= IntermediateHash[3];
			E	= IntermediateHash[4];
		}

		void innerProcess(){
			E	= D;
			D	= C;
			C	= shiftCircular( 30, B );
			B	= A;
			A	= temp;
		}
		
		for( t=0; t<20; t++ ){
			temp = shiftCircular( 5, A ) + ( (B&C) | ((~B)&D) ) + E + W[t] + K[0];
			innerProcess();
		}
		for( t=20; t<40; t++ ){
			temp = shiftCircular( 5, A ) + (B^C^D) + E + W[t] + K[1];
			innerProcess();
		}
		for( t=40; t<60; t++ ){
			temp = shiftCircular( 5, A ) + ((B & C) | (B & D) | (C & D)) + E + W[t] + K[2];
			innerProcess();
		}
		for( t=60; t<80; t++ ){
			temp = shiftCircular( 5, A ) + (B^C^D) + E + W[t] + K[3];
			innerProcess();
		}
		
		{
			IntermediateHash[0] += A;
			IntermediateHash[1] += B;
			IntermediateHash[2] += C;
			IntermediateHash[3] += D;
			IntermediateHash[4] += E;
		}
		
		MessageBlockIndex = 0;
	}
	void calclation()
	{
		ulong len = 0;
		while( Length-- && !Corrupted )
		{
			MessageBlock[MessageBlockIndex++] = ( Message[cast(uint)len] & 0xFF );
			LengthLow += 8;
			if( LengthLow == 0 )
			{
				LengthHigh++;
				if( LengthHigh == 0 )
				{
					// Message is too long.
					Corrupted = 1;
				}
			}
			if( MessageBlockIndex == 64 )
			{
				processMessageBlock();
			}
			len++;
		}
		paddingMessage();
	}
}







