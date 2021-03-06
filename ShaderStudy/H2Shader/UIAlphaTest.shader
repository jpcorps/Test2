Shader "ProjectH/UIAlphaTest"
{
	Properties
	{
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Main Texture", 2D) = "white" {}
	}

	SubShader
	{
		Tags { "IgnoreProjector"="True" "RenderType"="Opaque" } //"Queue"="Overlay+1000"
		Lighting Off 
		Cull Off 
		Fog { Mode Off }

		Pass 
		{
			ZTest LEqual 
			ZWrite On 
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
				float4 color : COLOR;
				float2 texcoord : TEXCOORD0;
			};

			struct v2f 
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				float2 texcoord : TEXCOORD0;
			};

			float4 _Color;
			sampler2D _MainTex;
			//uniform float4 _MainTex_ST;
			
			v2f vert(appdata_t v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.color = v.color * _Color;
				o.texcoord = v.texcoord;//TRANSFORM_TEX(v.texcoord,_MainTex);
				return o;
			}

			float4 frag(v2f i):COLOR
			{
				float4 col = tex2D(_MainTex, i.texcoord);																																		//clip(col.a - 0.5);
				
				if((i.color.r + i.color.g + i.color.b + i.color.a) == 0.0)
				{ col.rgb = col.r * 0.2 + col.g * 0.45 + col.b * 0.12; }
				else
				{ col *= i.color; }

				return col;
			}
			ENDCG 
		}

	} 	

	Fallback "Transparent/Diffuse"
}
