Shader "ProjectH/FontShadow"
{
	Properties
	{
		_Color ("Text Color", Color) = (1,1,1,1)
		_ShadowColor ("Shadow Color", Color) = (1,1,1,1)
		_MainTex ("Font Texture", 2D) = "white" {}
	}

	SubShader
	{
		Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
		Lighting Off Cull Off ZTest LEqual ZWrite Off Fog { Mode Off }
		Blend SrcAlpha OneMinusSrcAlpha

		Pass 
		{	
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
			float4 _ShadowColor;
			sampler2D _MainTex;
			
			v2f vert(appdata_t v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex + float4(0.0, -1.5, 0.0, 0.0));
				o.texcoord = v.texcoord;
				return o;
			}

			float4 frag(v2f i):COLOR
			{
				float4 col = _ShadowColor;
				float alpha = tex2D(_MainTex, i.texcoord).a;
				//if(alpha < 0.2)
				//{
				//	alpha = 0.0;
				//}
				//else
				//{
				//	//alpha = min((alpha - 0.2) * 1.5, 1.0);
				//	alpha = min(alpha + 0.1, 1.0);
				//}
				col.a *= alpha;
				return col;
				//return col * tex2D(_MainTex, i.texcoord);
			}
			ENDCG 
		}

		Pass 
		{	
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
			float4 _ShadowColor;
			sampler2D _MainTex;
			
			v2f vert(appdata_t v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex + float4(1.5, 0.0, 0.0, 0.0));
				o.texcoord = v.texcoord;
				return o;
			}

			float4 frag(v2f i):COLOR
			{
				float4 col = _ShadowColor;
				float alpha = tex2D(_MainTex, i.texcoord).a;
				//if(alpha < 0.2)
				//{
				//	alpha = 0.0;
				//}
				//else
				//{
				//	//alpha = min((alpha - 0.2) * 1.5, 1.0);
				//	alpha = min(alpha + 0.1, 1.0);
				//}
				col.a *= alpha;
				return col;
				//return col * tex2D(_MainTex, i.texcoord);
			}
			ENDCG 
		}

		Pass 
		{	
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
			float4 _ShadowColor;
			sampler2D _MainTex;
			
			v2f vert(appdata_t v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex + float4(1.5, -1.5, 0.0, 0.0));
				o.texcoord = v.texcoord;
				return o;
			}

			float4 frag(v2f i):COLOR
			{
				float4 col = _ShadowColor;
				float alpha = tex2D(_MainTex, i.texcoord).a;
				//if(alpha < 0.2)
				//{
				//	alpha = 0.0;
				//}
				//else
				//{
				//	//alpha = min((alpha - 0.2) * 1.5, 1.0);
				//	alpha = min(alpha + 0.1, 1.0);
				//}
				col.a *= alpha;
				return col;
				//return col * tex2D(_MainTex, i.texcoord);
			}
			ENDCG 
		}

		Pass 
		{	
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
			float4 _ShadowColor;
			sampler2D _MainTex;
			
			v2f vert(appdata_t v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.color = v.color * _Color;
				o.texcoord = v.texcoord;
				return o;
			}

			float4 frag(v2f i):COLOR
			{
				float4 col = i.color;
				float alpha = tex2D(_MainTex, i.texcoord).a;
				//if(alpha < 0.2)
				//{
				//	alpha = 0.0;
				//}
				//else
				//{
					//alpha = min((alpha - 0.2) * 1.5, 1.0);
				//	alpha = min(alpha + 0.1, 1.0);
				//}
				col.a *= alpha;
				//col.a *= alpha * 1.2;
				return col;
				//return col * tex2D(_MainTex, i.texcoord);
			}
			ENDCG 
		}
	} 	

	Fallback "Transparent/Diffuse"
}
