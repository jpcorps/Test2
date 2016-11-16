Shader "Custom/SimpleColor"
{
	Properties
	{
		_Color ("Color", Color) = (0.0, 1.0, 1.0, 1.0)
	}

	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100
		
		CGPROGRAM
		#pragma surface surf Lambert

		struct Input
		{
			float4 color : COLOR; 
		};

		float4 _Color;

		void surf (Input In, inout SurfaceOutput Out)
		{
			Out.Albedo = _Color.rgb;
			Out.Alpha = 1.0;
		}
		ENDCG
	}

	Fallback "Diffuse"
}
