Shader "ProjectH/NothingAlpha" 
{
	Properties 
	{
		_Color ("Color", Color) = (1.0, 1.0, 1.0, 1.0)
	}

	SubShader
	{
		Tags { "RenderType"="Transparent" }
		Lighting Off 
		Cull Off 
		Fog { Mode Off }

		Pass
		{
			ZTest LEqual 
			ZWrite Off 
			AlphaTest Off
			Blend SrcAlpha OneMinusSrcAlpha
		
			CGPROGRAM
			#pragma surface surf Nothing

			float4 _Color;

			struct Input
			{
				float3 viewDir;
			};

			float4 LightingNothing(SurfaceOutput s, float3 lightDir, float atten)
			{
				return float4(s.Albedo, s.Alpha);
			}

			void surf(Input In, inout SurfaceOutput Out)
			{
				Out.Albedo = _Color.rgb;
				Out.Alpha = _Color.a;
			}
			ENDCG
		}
	} 

	Fallback "Transparent/Diffuse"
}
