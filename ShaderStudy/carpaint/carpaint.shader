Shader "Custom/carpaint" {
	Properties {
		_Color ( "color" , color) = (0.5,0.5,0.5,1)
		_MainTex ("Base", 2D) = "white" {}
		_BumpMap ("Normalmap", 2D ) = "blue" {}
		_MainRef ("Baseref (RGB)", CUBE) = "" {}
		_SpecColor("SpecCol",color) = (0.5,0.5,0.5,1)
		_Shin("Shinness",float) = 1
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf BlinnPhong

		sampler2D _MainTex;
		sampler2D _BumpMap;
		samplerCUBE _MainRef;
		float4 _Color;
		float _Shin;

		struct Input {
			float2 uv_MainTex;
			float2 uv_BumpMap;
			float3 worldRefl;
			float3 viewDir;
			INTERNAL_DATA
		};

		void surf (Input IN, inout SurfaceOutput o) {
			o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
			half3 Ref = texCUBE (_MainRef, WorldReflectionVector (IN, o.Normal));
			o.Albedo = _Color.rgb * tex2D(_MainTex, IN.uv_MainTex).rgb;
			float rim = saturate(dot(normalize(IN.viewDir), o.Normal));
			rim = pow(1-rim,2);
			o.Emission = Ref * o.Albedo * 0.1 + (Ref * rim * 1.5);
			o.Alpha = 1;
			o.Specular = _Shin;
			o.Gloss = 1;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
