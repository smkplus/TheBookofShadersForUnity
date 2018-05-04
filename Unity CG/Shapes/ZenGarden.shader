Shader "TheBookOfShaders/ZenGarden"
{
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

			
			fixed4 frag (v2f i) : SV_Target
			{
			float2 st = i.uv;
			float3 color = float3(0,0,0);
			float d = 0.0;

			// Remap the space to -1. to 1.
			st = st *2.-1.;

			// Make the distance field
			d = length( abs(st)-.3 );
			// d = length( min(abs(st)-.3,0.) );
			// d = length( max(abs(st)-.3,0.) );

			// Visualize the distance field
			return float4(float3(1,1,1)*frac(d*10.0),1.0);

			// Drawing with the distance field
			// return float4(float3(1,1,1)*step(.3,d),1.0);
			// return float4(float3(1,1,1)* (step(.3,d) * step(d,.4)),1.0);
			// return float4(float3(1,1,1)*(smoothstep(.3,.4,d)* smoothstep(.6,.5,d)) ,1.0);
			}
			ENDCG
		}
	}
}
