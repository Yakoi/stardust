float pxsizeW = 1.0f / 1024.0f;	// 定数が使いたいけど上手くいかない・・・
float pxsizeH = 1.0f / 1024.0f;

struct PS_INPUT
{
	float4 Diffuse         : COLOR0 ;
	float4 Specular        : COLOR1 ;
	float2 TexCoords0      : TEXCOORD0 ;
	float2 TexCoords1      : TEXCOORD1 ;
} ;

struct PS_OUTPUT
{
	float4 Output          : COLOR0 ;
} ;

sampler sampler0 : register( s0 ) ;

PS_OUTPUT main( PS_INPUT psin )
{
	PS_OUTPUT psout ;
	float4 texc = float4(0, 0, 0, 0);

	for(int i=0; i<8; i++){
		float4 col = tex2D( sampler0, psin.TexCoords0 + float2(1.0f / 1024.0f * i * 2, 1.0f / 1024.0f * i * 2) );
		float Y = 0.257f * col.r + 0.504f * col.g + 0.098f * col.b + 0.0625f;	// 輝度
		if(Y >= 0.6f){
			texc += col * (10 - i) / 36;	// 合計が1.0fになるようにする
		}
	}

	psout.Output = texc;

	return psout ;
}
