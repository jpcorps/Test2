Shader "ProjectH/CivilWater"
{
	Properties
	{
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Main Texture", 2D) = "white" {}
		_MaskTex ("Mask Texture", 2D) = "white" {}
		_BumpTex ("Bump Texture", 2D) = "white" {}
	}

	SubShader
	{
		Tags { "IgnoreProjector"="True" "RenderType"="Transparent" } //"Queue"="Overlay+1000"
		Lighting On 
		Cull Off 
		Fog { Mode Off }

		Pass 
		{
			ZTest LEqual 
			ZWrite Off 
			AlphaTest Off
			Blend SrcAlpha OneMinusSrcAlpha

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest

			#include "UnityCG.cginc"

			struct appdata_t 
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				float2 texcoord : TEXCOORD0;
			};

			struct v2f 
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				float2 texcoord : TEXCOORD0;
				float4 localpos : TEXCOORD1;
			};

			//uniform float4 _Time;

			uniform float4 _Color;
			uniform sampler2D _MainTex;
			uniform sampler2D _MaskTex;
			uniform sampler2D _BumpTex;
			//uniform float4 _MainTex_ST;
			
			v2f vert(appdata_t v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.color = v.color;
				o.texcoord = v.texcoord;//TRANSFORM_TEX(v.texcoord,_MainTex);
				o.localpos = v.vertex;
				return o;
			}

			float4 frag(v2f i):COLOR
			{
				float4 mask = tex2D(_MaskTex, i.texcoord);

				float3 bump = tex2D(_BumpTex, (i.localpos.xy * 0.02) + float2(0.7, 0.3) * _Time.y * 0.1).rgb * 2.0f - 1.0f;																																			
				//float4 bump = tex2D(_BumpTex, (i.localpos.xy * 0.02) + float2(0.7, 0.3) * _Time.y * 0.17);

				float dottan = dot(bump, normalize(float3(1.0, 1.0, 1.0)));

				//float4 col = tex2D(_MainTex, i.texcoord + bump.rg);
				float4 col = tex2D(_MainTex, i.texcoord + ((dottan * 0.5) + 0.5) * 0.01);

				//float4 bump = tex2D(_BumpTex, i.texcoord);
				//float2 bumpcoord = i.localpos.xy * 0.1f;

				//float4 bump0 = tex2D(_BumpTex, (i.localpos.xy * 0.11) + float2(0.7, 0.3) * _Time.y * 0.17);
				//float4 bump1 = tex2D(_BumpTex, (i.localpos.xy * 0.09) + float2(0.7, 0.3) * _Time.y * 0.20);
				//col.rgb = (bump0.rgb + bump1.rgb) * 0.5;

				//col.rgb *= bump.rgb;
				float3 invbump = float3(1.0, 1.0, 1.0) - bump.b;
				col.rgb -= invbump * 0.1;

				col *= _Color;
				col.a *= mask.a;

				return col;
			}
			ENDCG 
		}

	} 	

	Fallback "Transparent/Diffuse"
}
