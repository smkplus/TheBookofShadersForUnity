Shader "TheBookOfShaders/Rectangle"
{
	Properties
	{
		_Left("Left",Range(0,1)) = 0.1
		_Bottom("Bottom",Range(0,1)) = 0.1
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

			float _Left,_Bottom;
			
			fixed4 frag (v2f i) : SV_Target
			{
				float2 uv = i.uv;
				float3 color = float3(1,1,1);

				// Each result will return 1.0 (white) or 0.0 (black).
				float left = step(_Left,uv.x);   // Similar to ( X greater than _Left )
				float bottom = step(_Bottom,uv.y); // Similar to ( Y greater than _Bottom )

				// The multiplication of left*bottom will be similar to the logical AND.
				float result = left * bottom;
				color *= result;

				return float4(color,1.0);
			}
			ENDCG
		}
	}
}
