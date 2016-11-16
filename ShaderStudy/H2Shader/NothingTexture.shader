Shader "ProjectH/NothingTexture" 
{
	Properties 
	{
		_Color ("Color", Color) = (1.0, 1.0, 1.0, 1.0)
		_MainTex ("Base (RGB)", 2D) = "white" {}
	}

	SubShader
	{
		Pass 
		{	
			Tags { "RenderType"="Opaque" }
			Lighting Off Cull Back ZTest Less ZWrite On Fog { Mode Off }
			//Blend SrcAlpha OneMinusSrcAlpha
			AlphaTest Greater 0.5
			Blend Off

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest

			#include "UnityCG.cginc"

			struct appdata_t 
			{
				float4 vertex : POSITION;
				float2 texcoord : TEXCOORD0;
			};

			struct v2f 
			{
				float4 vertex : POSITION;
				float2 texcoord : TEXCOORD0;
			};

			float4 _Color;
			sampler2D _MainTex;

			//uniform float4 _MainTex_ST;
			
			v2f vert(appdata_t v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.texcoord = v.texcoord;//TRANSFORM_TEX(v.texcoord,_MainTex);
				return o;
			}

			float4 frag(v2f i):COLOR
			{
				float4 col = _Color * tex2D(_MainTex, i.texcoord);
				return col;
			}
			ENDCG 
		}
		
		//CGPROGRAM
		//#pragma surface surf Nothing

		//float4 _Color;
		//sampler2D _MainTex;

		//struct Input
		//{
		//	float2 uv_MainTex;
		//};

		//float4 LightingNothing(SurfaceOutput s, float3 lightDir, float atten)
		//{
		//	return float4(s.Albedo, s.Alpha);
		//}

		//void surf(Input In, inout SurfaceOutput Out)
		//{
		//	Out.Albedo = tex2D(_MainTex, In.uv_MainTex).rgb * _Color.rgb;
		//	Out.Alpha = _Color.a;
		//}

		//ENDCG
/*
		Pass 
		{
			Name "ShadowCaster"
			Tags { "LightMode" = "ShadowCaster" }
		
			Fog {Mode Off}
			ZWrite On ZTest LEqual Cull Off
			Offset 1, 1

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_shadowcaster
			#pragma fragmentoption ARB_precision_hint_fastest
			#include "UnityCG.cginc"

			struct v2f { 
				V2F_SHADOW_CASTER;
			};

			v2f vert( appdata_base v )
			{
				v2f o;
				TRANSFER_SHADOW_CASTER(o)
				return o;
			}

			float4 frag( v2f i ) : COLOR
			{
				SHADOW_CASTER_FRAGMENT(i)
			}
			ENDCG
		}
		
		// Pass to render object as a shadow collector
		Pass 
		{
			Name "ShadowCollector"
			Tags { "LightMode" = "ShadowCollector" }
			
			Fog {Mode Off}
			ZWrite On ZTest LEqual

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest
			#pragma multi_compile_shadowcollector

			#define SHADOW_COLLECTOR_PASS
			#include "UnityCG.cginc"

			struct appdata {
				float4 vertex : POSITION;
			};

			struct v2f {
				V2F_SHADOW_COLLECTOR;
			};

			v2f vert (appdata v)
			{
				v2f o;
				TRANSFER_SHADOW_COLLECTOR(o)
				return o;
			}

			float4 frag (v2f i) : COLOR
			{
				SHADOW_COLLECTOR_FRAGMENT(i)
			}
			ENDCG
		}
*/
	}

	Fallback "Diffuse"
}

