// Author @patriciogv - 2015
// Converted By SeyedMortezaKamali - 2017

Shader "TheBookOfShaders/Rectangle"
{
	Properties
	{
		_Left("Left",Range(0,1)) = 0.1
		_Bottom("Bottom",Range(0,1)) = 0.1
		_Top("Top",Range(0,1)) = 0.1
		_Right("Right",Range(0,1)) = 0.1
	}
	SubShader
	{

	Pass
	{
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		
		#include "UnityCG.cginc"

		struct appdata
		{
			float4 vertex : POSITION;
			float2 uv : TEXCOORD0;
		};

		struct v2f
		{
			float2 uv : TEXCOORD0;
			float4 vertex : SV_POSITION;
		};

		v2f vert (appdata v)
		{
			v2f o;
			o.vertex = UnityObjectToClipPos(v.vertex);
			o.uv = v.uv;
			return o;
		}

		float _Left,_Bottom,_Top,_Right;
		
		fixed4 frag (v2f i) : SV_Target
		{
			float2 uv = i.uv;
			float3 color = float3(1,1,1);


    // bottom-left
    float2 bl = step(float2(_Left,_Bottom),uv);
    float pct = bl.x * bl.y;

    // top-right
    float2 tr = step(float2(_Right,_Top),1.0-uv);
    pct *= tr.x * tr.y;

    color *= pct;

    return float4(color,1.0);

			}
			ENDCG
		}
	}
}
