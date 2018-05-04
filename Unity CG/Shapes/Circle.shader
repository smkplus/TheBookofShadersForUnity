Shader "TheBookOfShaders/Circle"
{
	Properties
	{
		_Position("Position",Vector) = (0.5,0.5,0,0) // center = (0.5,0.5)
		_Radius("Radius",Range(0,1)) = 0.5
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
			float _Radius;
			
			fixed4 frag (v2f i) : SV_Target
			{
			float2 st = i.uv;
				float pct = 0.0;

				// a. The DISTANCE from the pixel to the center
				pct = distance(st,_Position.xy);

				// b. The LENGTH of the floattor
				//    from the pixel to the center
				// float2 toCenter = _Position-st;
				// pct = length(toCenter);

				// c. The SQUARE ROOT of the floattor
				//    from the pixel to the center
				// float2 tC = _Position-st;
				// pct = sqrt(tC.x*tC.x+tC.y*tC.y);

				pct = step(pct,_Radius);

				float3 color = float3(1,1,1)*pct;

				return float4( color, 1.0 );
			}
			ENDCG
		}
	}
}
