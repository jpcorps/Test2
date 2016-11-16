Shader "ProjectH/UIColorA"
{
	Properties
	{
		_Color ("ColorA", Color) = (1,1,1,1)
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
			};

			struct v2f 
			{
				float4 vertex : POSITION;
			};

			float4 _Color;
			
			v2f vert(appdata_t v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				return o;
			}

			float4 frag(v2f i):COLOR
			{
				return _Color;
			}

			ENDCG 
		}
	} 	

	FallBack "ProjectH/UIColor"
}
