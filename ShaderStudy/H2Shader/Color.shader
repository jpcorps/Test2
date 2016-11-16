Shader "ProjectH/Color" 
{
	Properties 
	{
		_Color ("Color", Color) = (1.0, 1.0, 1.0, 1.0)
	}

	SubShader
	{
		Pass 
		{	
			Tags { "RenderType"="Opaque" }
			Lighting Off Cull Back ZTest Less ZWrite On Fog { Mode Off }
			//Blend SrcAlpha OneMinusSrcAlpha
			//AlphaTest Greater 0.5
			Blend Off

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest

			#include "UnityCG.cginc"

			struct appdata_t 
			{
				float4 vertex : POSITION;
			};

			struct v2f 
			{
				float4 vertex : POSITION;
			};

			float4 _Color;
			
			v2f vert(appdata_t v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				return o;
			}

			float4 frag(v2f i):COLOR
			{
				float4 result = _Color;
				result.a = 1.0;

				return result;
			}
			ENDCG 
		}
		//Tags { "RenderType"="Opaque" }
		//Lighting Off Cull Off ZTest LEqual ZWrite On Fog { Mode Off }
		////Blend SrcAlpha OneMinusSrcAlpha
		//AlphaTest Greater 0.5
		//Blend Off

		//CGPROGRAM
		//#pragma surface surf Nothing

		//float4 _Color;

		//struct Input
		//{
		//	float3 viewDir;
		//};

		//float4 LightingNothing(SurfaceOutput s, float3 lightDir, float atten)
		//{
		//	return float4(s.Albedo, s.Alpha);
		//}

		//void surf(Input In, inout SurfaceOutput Out)
		//{																																																clip(_Color.a - 0.5);
		//	Out.Albedo = _Color.rgb;
		//	Out.Alpha = _Color.a;
		//}
		//ENDCG
	} 
}
