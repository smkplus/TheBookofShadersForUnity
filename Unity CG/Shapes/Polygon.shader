Shader "TheBookOfShaders/Triangle"
{
	Properties{
		_PolygonNumber("PolygonNumber",Range(3,15)) = 3
	}
	SubShader
	{

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			#define PI 3.14159265359
			#define TWO_PI 6.28318530718

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

			// Number of sides of your shape
			int _PolygonNumber = 3;
			
			fixed4 frag (v2f i) : SV_Target
			{
			float2 st = i.uv;
			float3 color = float3(0,0,0);
			float d = 0.0;

			// Remap the space to -1. to 1.
			st = st *2.-1.;


			// Angle and radius from the current pixel
			float a = atan2(st.y,st.x)+PI;
			float r = TWO_PI/float(_PolygonNumber);

			// Shaping function that modulate the distance
			d = cos(floor(.5+a/r)*r-a)*length(st);

			color = float3(1,1,1)*smoothstep(.41,.4,d);
			//color = float3(1,1,1)*d;

			return float4(color,1.0);
			}
			ENDCG
		}
	}
}
