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

float4 param;


sampler sampler0 : register( s0 ) ;

PS_OUTPUT main( PS_INPUT psin )
{
	PS_OUTPUT psout ;
	float4 texc ;

	texc  = tex2D( sampler0, psin.TexCoords0 ) ; 

	psout.Output.r = (1-param.r)*texc.r + param.r*(texc.r+texc.g+texc.b)/3;
	psout.Output.g = (1-param.g)*texc.g + param.g*(texc.r+texc.g+texc.b)/3;
	psout.Output.b = (1-param.b)*texc.b + param.b*(texc.r+texc.g+texc.b)/3;
	psout.Output.a = texc.a ;

	return psout ;
}
