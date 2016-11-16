Shader "ProjectH/CostMeterBack"
{
	Properties
	{
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Main Texture", 2D) = "white" {}
		_VMax ("VMax", Range(0.0, 0.1)) = 1.0
	}

	SubShader
	{
		Tags { "IgnoreProjector"="True" "RenderType"="Transparent" } //"Queue"="Overlay+1000"
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

			uniform float4 _Color;
			uniform sampler2D _MainTex;
			uniform float _VMax;
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
			{																																														clip(_VMax - i.texcoord.y);
				float4 col = tex2D(_MainTex, i.texcoord);
				col *= i.color;

				return col;
			}
			ENDCG 
		}

	} 	

	Fallback "Transparent/Diffuse"
}
