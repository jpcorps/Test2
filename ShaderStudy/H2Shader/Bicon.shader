Shader "ProjectH/Bicon"
{
	Properties
	{
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Main Texture", 2D) = "white" {}
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
			};

			uniform float4 _LightColor0; 

			uniform float4 _Color;
			uniform sampler2D _MainTex;
			//uniform float4 _MainTex_ST;
			
			v2f vert(appdata_t v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.color = v.color;
				o.texcoord = v.texcoord;//TRANSFORM_TEX(v.texcoord,_MainTex);
				return o;
			}

			float4 frag(v2f i):COLOR
			{
				float intensity = 0.25;
				float4 col = tex2D(_MainTex, i.texcoord);
				
				if((i.color.r + i.color.g + i.color.b + i.color.a) == 0.0)
				{ col.rgb = col.r * 0.2 + col.g * 0.45 + col.b * 0.12; }
				else
				{ col *= i.color; }
				
				//float3 invColor = float3(1.0, 1.0, 1.0) - _Color.rgb;
				//col.rgb -= invColor * intensity;
				//col.a *= _Color.a;

				float3 invLightColor = min(float3(0.3, 0.3, 0.3), float3(1.0, 1.0, 1.0) - _LightColor0.rgb);
				col.rgb -= invLightColor * intensity;

				return col;
			}
			ENDCG 
		}

	} 	

	FallBack "Transparent/Diffuse"
}
