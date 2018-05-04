Shader "TheBookOfShaders/PolarShape"
{
	Properties
	{
		_PolygonNumber("PolygonNumber",Range(3,15)) = 3
		_Position("Position",Vector) = (0.5,0.5,0,0) // center = (0.5,0.5)
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

			float4 _Position;
			int _PolygonNumber;
			
			fixed4 frag (v2f i) : SV_Target
			{
			float2 st = i.uv;
			float3 color = float3(0,0,0);

			float2 pos = _Position-st;

			float r = length(pos)*2.0;
			float a = atan2(pos.x,pos.y);

			float f = cos(a*_PolygonNumber);
			// f = abs(cos(a*_PolygonNumber));
			// f = abs(cos(a*2.5))*.5+0.3;
			// f = abs(cos(a*12.)*sin(a*_PolygonNumber))*.8+.1;
			// f = smoothstep(-.5,1., cos(a*10.))*0.2+0.5;

			color = float3(1,1,1)*smoothstep(f+0.02,f,r);

			return float4( color, 1.0 );
			}
			ENDCG
		}
	}
}
