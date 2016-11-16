Shader "ProjectH/CharacterBlend" 
{
	Properties
	{
		_Color ("Color", Color) = (1.0, 1.0, 1.0, 1.0)
		_MainTex ("Base (RGBA)", 2D) = "white" {}
		_RimMin ("RimMin", Range(0.0, 1.0)) = 0.3
		_RimMax ("RimMax", Range(0.0, 1.0)) = 0.7
		_RimMinPower ("RimMinPower", Range(0.0, 1.0)) = 0.0
		_RimMaxPower ("RimMaxPower", Range(0.0, 1.0)) = 0.5
		//_EdgeMin ("EdgeMin", Range(0.0, 0.5)) = 0.3
	}

	SubShader
	{
		Tags { "IgnoreProjector"="True" "LightMode"="ForwardBase" "RenderType"="Transparent" }
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
				float3 normal : NORMAL;
				float2 texcoord : TEXCOORD0;
			};

			struct v2f 
			{
				float4 vertex : POSITION;
				//float3 normal : TEXCOORD0;
				float2 texcoord : TEXCOORD0;
				//float3 viewdir : TEXCOORD2;
				float2 pre_dot : TEXCOORD1;
			};

			uniform float4 _LightColor0; 

			uniform float4 _Color;
			uniform sampler2D _MainTex;
			uniform float _RimMin;
			uniform float _RimMax;
			uniform float _RimMinPower;
			uniform float _RimMaxPower;
			//uniform float _EdgeMin;
			
			v2f vert(appdata_t v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.texcoord = v.texcoord;//TRANSFORM_TEX(v.texcoord, _MainTex);

				float3 normal = normalize(mul((float3x3)_Object2World, SCALED_NORMAL));
				float3 worldpos = mul(_Object2World, v.vertex).xyz;
				float3 viewdir = normalize(_WorldSpaceCameraPos - worldpos);
				o.pre_dot.x = dot(viewdir, normal);

				o.pre_dot.y = dot(_WorldSpaceLightPos0.xyz, normal);

				return o;
			}

			float4 frag(v2f i):COLOR
			{
				float intensity = 0.25;
				float4 col = tex2D(_MainTex, i.texcoord);		
																																														//clip(col.a - 0.5);
				float3 invColor = float3(1.0, 1.0, 1.0) - _Color.rgb;
				col.rgb -= invColor * intensity;
				col.a *= _Color.a;

				float view_dot_nor = i.pre_dot.x;//dot(i.viewdir, i.normal);

				float rim = 0.0;
				if((view_dot_nor > _RimMin) && (view_dot_nor < _RimMax))
				{
					rim = (_RimMaxPower - _RimMinPower) / (_RimMax - _RimMin) * (_RimMin - view_dot_nor) + _RimMaxPower;
				}

				if(view_dot_nor > -0.1)
				{
					col.rgb += rim * 0.5;

					float edge_step = step(0.3, view_dot_nor);
					float edge = min(1.0, (edge_step + view_dot_nor));
					//float edge = smoothstep(0.0, 0.3, view_dot_nor);
					col.rgb *= edge;
				}
				else col.rgb *= 0.5f;

				float3 invLightColor = min(float3(0.3, 0.3, 0.3), float3(1.0, 1.0, 1.0) - _LightColor0.rgb);
				col.rgb -= invLightColor * intensity;
	
				return col;
			}

			ENDCG 
		}
	}

	Fallback "ProjectH/NothingTexture"
}
