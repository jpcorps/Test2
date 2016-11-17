Shader "Custom/BehindOutline" {
	Properties{
		_Color("Color", Color) = (1,1,1,1)
		_MainTex("Albedo (RGB)", 2D) = "white" {}

	_OutlineColor("Outline Color", Color) = (0,0,0,1)
		_Outline("Outline width", Range(0.0, 0.5)) = .05
	}

	SubShader{
		Tags{ "RenderType" = "Opaque" }
		LOD 200

		//-------------------------------------------------------------------
		// 모델 렌더.

		cull back
		Blend Off
		zwrite on // 뎁스버퍼 기록.
		ztest LEqual // 뎁스테스트 디폴트.


		/*
		스텐실 항상 성공.
		해당하는 모든 스텐실 버퍼를 8로 갱신.
		*/
		Stencil{
			Ref 8
			ReadMask 255
			WriteMask 255

			Comp Always

			Pass replace
			fail replace
			zfail replace
		}

		CGPROGRAM

#pragma surface surf Standard fullforwardshadows 
#pragma target 3.0 

		sampler2D _MainTex;


		struct Input {
			float2 uv_MainTex;
		};

		fixed4 _Color;

		void surf(Input IN, inout SurfaceOutputStandard o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}

		ENDCG


		//-------------------------------------------------------------------
		// 외곽선 렌더.
		// ztest를 greater로 하여 다른 픽셀보다 z값이 높은 픽셀(가려져야할 픽셀)이면서
		// 모델스텐실 값(8)이 아닌 픽셀만 렌더.

		cull back
		Blend One Zero
		zwrite off // 뎁스버퍼 기록 끔.
		ztest greater // 다른 픽셀에 가려지는 픽셀만 성공.

		Stencil{
			Ref 8
			ReadMask 255

			Comp notEqual

			Pass keep
			fail keep
			zfail keep
		}

		CGPROGRAM

#pragma surface surf Lambert  vertex:vert noambient

		float _Outline;
		float4 _OutlineColor;

		void vert(inout appdata_full v) {
			v.vertex.xyz += v.normal*_Outline;
		}

		struct Input {
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutput o) {
			o.Emission = _OutlineColor;
		}

		ENDCG


	}
	FallBack "Diffuse"
}
