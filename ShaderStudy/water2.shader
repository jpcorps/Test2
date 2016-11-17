Shader "Custom/water" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_LightDir("LightDir" , Vector) = (0,1,0,1)
		_Cube("Cube" , cube) = ""{}

		_Specpow("SpecularPower", float) = 60
		[Header(small wave)]
		_wave("물결", Range(0,20)) = 5
		_speed("속도" , float) = 3
		_at("진폭" , Range(0,10)) = 1
		[Header(Large wave)]
		_wave2("물결", Range(0,10)) = 5
		_speed2("속도" , float) = 3
		_at2("진폭" , Range(0,10)) = 1

	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf water  vertex:vert

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;
		samplerCUBE _Cube;
		float4 _LightDir;

		float _wave;
		float _speed;
		float _at;

		float _wave2;
		float _speed2;
		float _at2;

		float _Specpow;

		struct Input {
			float2 uv_MainTex;
			float3 worldNormal;
			float3 worldRefl;
			//INTERNAL_DATA
		};
		
		
		void vert( inout appdata_full v){
		 	float vmsinx = (sin(abs((v.texcoord.y*2-1)*_wave)+_Time.y*_speed)*0.5+0.5 );
		 	float vmsiny = (sin(abs((v.texcoord.x*2-1)*_wave)+_Time.y*_speed)*0.5+0.5 );

		 	float vmsinx2 = (sin(abs((v.texcoord.y*2-1)*_wave2)+_Time.y*_speed2)*0.5+0.5 );
		 	float vmsiny2 = (sin(abs((v.texcoord.x*2-1)*_wave2)+_Time.y*_speed2)*0.5+0.5 );
		 	
		 	v.vertex.z += (((vmsinx + vmsiny)/2*_at) + ((vmsinx2+vmsiny2)/2  * _at2))/2;
		 	v.normal.z += (((vmsinx + vmsiny)/2*_at) + ((vmsinx2+vmsiny2)/2  * _at2))/2;
		
		}

		half _Glossiness;
		half _Metallic;
		fixed4 _Color;

		void surf (Input IN, inout SurfaceOutput o) {
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			float4 cubemap = texCUBE(_Cube, IN.worldRefl);

			o.Emission = UNITY_SAMPLE_TEXCUBE(unity_SpecCube0, IN.worldRefl).rgb * unity_SpecCube0_HDR.r;
//			fixed3 blendTarget = UNITY_SAMPLE_TEXCUBE(unity_SpecCube1, IN.worldRefl).rgb * unity_SpecCube1_HDR.r;
//			o.Emission = lerp(blendTarget, o.Emission, unity_SpecCube0_BoxMin.w);


			//o.Normal = float3(0,0,1);
			//float3 worldNormal = WorldNormalVector (IN, o.Normal);
//			o.Albedo = c.rgb;
//			o.Emission = cubemap.rgb;
			//o.Emission = pow(saturate(IN.worldNormal.x*1.9),_Specpow);
//			o.Emission = IN.worldNormal;
			
			o.Alpha = c.a;
		}


		float4 Lightingwater ( SurfaceOutput s, float3 lightDir, float3 viewDir, float atten){

		float3 H = normalize(lightDir+ viewDir);
		float spec = pow(dot(s.Normal, H),_Specpow );
		return 0;
		return float4 (_Color.rgb,s.Alpha);

		}
		ENDCG
	} 
	FallBack "Diffuse"
}
