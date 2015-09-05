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

float4 threshold;
float4 color1;
float4 color2;

sampler sampler0 : register( s0 ) ;

PS_OUTPUT main( PS_INPUT psin )
{
	PS_OUTPUT psout ;
	float4 texc ;

	texc  = tex2D( sampler0, psin.TexCoords0 ) ; 

    bool condi;
    float y = (texc.r+texc.g+texc.b)/3;
    if(y<threshold.r){
        psout.Output = color1;
    }else{
        psout.Output = color2;
    }

	return psout ;
}

