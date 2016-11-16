Shader "ProjectH/UIBackground"
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
			ZWrite Off
			AlphaTest Off
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
				//return tex2D(_MainTex, i.texcoord);
			}
			ENDCG 
		}

	} 	

	FallBack "Diffuse"
}
