Shader "Shader-Helper"
{
	Properties
	{
		_Color ("Main Color", Color) = (1.0, 0.5, 0.5, 1.0)
		_FogDensity("Fog Density", Range(0.0, 1.0)) = 0.5
		_MainTex("Base(RGB)", 2D) = "white" { TexGen EyeLinear }
		//_Float("Float", Float) = 0.6
		//_Value("Value", Range(0.0, 1.0)) = 0.3
		//_Vector("Vector", Vector) = (0.3, 0.5, 0.7, 0.9)
		//_Color("Main Color", Color) = (1,0.5,0.5,1)
		//_MainTex("Base(RGB)", 2D) = "white" { TexGen EyeLinear } //TexGen -> ObjectLinear, EyeLinear, SphereMap, CubeReflect, CubeNormal 
		//														//LightmapMode : 라이트맵, Inspector에서 지정하지 않음.
		//_RectText("Un2Power", Rect) = "black" {} //직사각형 (2의 지수가 아닌) 텍스쳐 속성을 정의합니다.
		//_Cubemap("CubeMap", Cube) = "gray" {}
	}

	//Category //SubShader보다 상위 집합이고 포함된 모든 SubShader에 공통 세팅을 동일하게 적용.
	//{ Fog 
	//	{
	//		Mode Off 
	//	}
	//	Blend One One
	//}
	SubShader
	{
		LOD 300

		//VertexLit kind of shaders = 100 
		//Decal, Reflective VertexLit = 150 
		//Diffuse = 200 
		//Diffuse Detail, Reflective Bumped Unlit, Reflective Bumped VertexLit = 250 
		//Bumped, Specular = 300 
		//Bumped Specular = 400 
		//Parallax = 500 
		//Parallax Specular = 600 

		//Tags { "Queue"="Geometry" "IgnoreProjector"="True" "RenderType"="Opaque" }
		//"Queue" : 랜더링 순서 결정. 
		//이미정의된 큐 : Background = 1000, Geometry(default) = 2000, Transparent = 3000, Overlay = 4000
		//"IgnoreProjector" : 
		//"RenderType" : 랜더링 타입
		//정의된 타입 : Opaque, Transparent

		//Lighting Off Cull Off ZTest Always ZWrite On Fog { Mode Off }
		//ZTest Less | Greater | LEqual | GEqual | Equal | NotEqual | Always 
//////////////////////////////////////////////

CGPROGRAM
		#pragma surface surf Lambert
		struct Input 
		{
			float4 color : COLOR;
		};

		//unity에 정의된 output
		//struct SurfaceOutput 
		//{
		//	half3 Albedo;
		//	half3 Normal;
		//	half3 Emission;
		//	half Specular;
		//	half Gloss;
		//	half Alpha;
		//};

		void surf(Input In, inout SurfaceOutput Out)
		{
			Out.Albedo = 1;
		}
ENDCG

//////////////////////////////////////////////

		//UsePass "Reflective/Bumped Unlit/BASE" //다른 쉐이더의 특정 패스를 사용한다는 의미.

		//Pass
		//{
			//Name "Pass0" //UsePass에서 레퍼런스하기 위해. 이름은 없어도 무방.

			//Tags { "LightMode"="Always" "RequireOptions"="Fantastic"}
			//LightMode tag
			// Deferred Lighting에서, PrepassBase 와 PrepassFinal 패스가 사용됩니다. 
			// Forward Rendering에서, ForwardBase 와 ForwardAdd 패스가 사용됩니다. 
			// In Vertex Lit에서, Vertex, VertexLMRGBM 그리고 VertexLM 패스가 사용됩니다.

			//Always: 항상 렌더됩니다; 조명이 적용되지 않습니다. 
			//ForwardBase: Forward rendering에서 사용됩니다, 주변의 주요한 방향성있는 조명과vertex/SH 조명이 적용됩니다. 
			//ForwardAdd: Forward rendering에서 사용됩니다; 첨가되는 픽셀당 조명이 적용됩니다, 조명당 한 번의 패스. 
			//PrepassBase: Deferred Lighting에서 사용됩니다, normals & specular 대표자를 렌더합니다. 
			//PrepassFinal: Deferred Lighting에서 사용됩니다, 텍스쳐, 조명 그리고 방사를 결합해서 마지막 색상을 렌더합니다. 
			//Vertex: 물체가 조명에 매핑되지 않을 때 Vertex Lit rendering에서 사용됩니다; 모든 정점 조명이 적용됩니다. 
			//VertexLMRGBM: 물체가 조명에 매핑되지 않을 때 Vertex Lit rendering 에서 사용됩니다; lightmap이 RGBM으로 인코딩되는 플랫폼.
			//VertexLM: 물체가 조명에 매핑되지 않을 때 Vertex Lit rendering 에서 사용됩니다; lightmap이double-LDR으로 인코딩되는 플랫폼 (일반적으로 모바일 플랫폼 & 오래된 데스크탑 GPUs).
			//ShadowCaster: 그림자 캐스터로 물체를 렌더합니다. 
			//ShadowCollector: Forward 렌더링 경로를 위해서 스크린 공간 버퍼로 물체의 그림자를 모읍니다. 

			//RequireOptions tag
			//Quality Settings에서 선택된 태그이면 랜더링.

//////////////////////////////////////////////

			//BindChannels //입력 데이터와 unity 쉐이더 데이터를 연결
			//{
			//	Bind "Vertex", vertex
			//	Bind "normal", normal
			//	Bind "texcoord1", texcoord0 // lightmap uses 2nd uv
			//	Bind "texcoord", texcoord1 // main uses 1st uv
			//}
			//Bind "source", target 
			//source
			//Vertex: 꼭지점 위치 
			//Normal: 꼭지점 normal 
			//Tangent: 꼭지점 탄젠트 
			//Texcoord: 주요 UV 좌표 
			//Texcoord1: 부가적인 UV 좌표 
			//Color: 픽셀당 색상 

			//Target
			//Vertex: 꼭지점 위치 
			//Normal: 꼭지점 normal 
			//Tangent: 꼭지점 탄젠트 
			//Texcoord0, Texcoord1, ...: 해당 텍스쳐 스테이지를 위한 텍스쳐 좌표 
			//Texcoord: 모든 텍스쳐 스테이지들을 위한 텍스쳐 좌표들 
			//Color: 꼭지점 색상 

//////////////////////////////////////////////

			//Material //정점 조명에서 사용하는 재질
			//{
			//	Diffuse[_Color] // (1.0, 1.0, 0.0, 1.0) or [_Color]
			//	Ambient[_Color] // (1.0, 1.0, 0.0, 1.0) or [_Color] //주명의 색상 컴포넌트. 주변 조명 세팅에 의해 그것이 부딪힐 때 물체가 가지는 색상.
			//	Shininess[_Shininess] // 0.5 of [_Shin] //조명의 날카로움을 0과 1 사이 값으로 표현. 0에서 사용자는 퍼져있는 조명처럼 보이는 커다란 하이라이트를 얻을 것이고 1에서는 아주 작은 얇은 자국을 얻습니다. 
			//	Specular[_SpecColor] // (1.0, 1.0, 0.0, 1.0) or [_Color] //물체의 반적인 하이라이트 색상. 
			//	Emission[_Emission] // (1.0, 1.0, 0.0, 1.0) or [_Color] //어떠한 조명에서도 부딪히지 않을 때 물체의 색상. 
			//}
			//Material 결과 : Ambient * RenderSettings ambient setting + (Light Color * Diffuse + Light Color * Specular) + Emission
			//Color (1.0, 0.0, 0.0, 0.0) // (R, G, B, A) of [_Color]- 조명이 꺼졌을때 사용되는 색상.
			//ColorMaterial // AmbientAndDiffuse | Emission
			//SeparateSpecular On // On | Off //반사적인 색상은 이전 보다는 결합 계산 후에 반사적인 색상이 더해질 것입니다
			//Lighting On // On | Off

//////////////////////////////////////////////

			//Cull Back // Back | Front | Off
			//ZTest Less // Less | Greater | LEqual | GEqual | Equal | NotEqual | Always
			//ZWrite On // On | Off
			//Fog
			//{
			//	Mode Global // Off | Global | Linear | Exp | Exp2
			//	Color [_Color] // (1.0, 1.0, 0.0, 1.0) or [_Color]
			//	Density [_FogDensity] //기하급수적인 fog를 위한 밀도.
				//Range NearValue, FarValue //선형 fog를 위해 근거리 그리고 원거리의 범위.
			//}
			//AlphaTest Greater 0.5 //Less | Greater | LEqual | GEqual | Equal | NotEqual | Always
						//Blend Off // Off | SrcFactor DstFactor
						//One	1의 값 ? 소스 또는 데스티네이션 색상이 온전히 오게 합니다.
						//Zero 0의 값 ? 소스 또는데스티네이션 값을 삭제하게 합니다.
						//SrcColor 이 스테이지의 값은 소스 색상 값에 의해 곱해집니다.
						//SrcAlpha 이 스테이지의 값은 소스 알파 값에 의해 곱해집니다.
						//DstColor 이 스테이지의 값은 프레임 버퍼 소스 색상 값에 의해 곱해집니다.
						//DstAlpha 이 스테이지의 값은 프레임 버퍼 소스 알파 값에 의해 곱해집니다.
						//OneMinusSrcColor 이 스테이지의 값은 (1 ? 소스 색상)에 의해 곱해집니다.
						//OneMinusSrcAlpha 이 스테이지의 값은 (1 ? 소스 알파)에 의해 곱해집니다.
						//OneMinusDstColor 이 스테이지의 값은 (1 ? 데스티네이션 색상)에 의해 곱해집니다.
						//OneMinusDstAlpha 이 스테이지의 값은 (1 ? 데스티네이션 알파)에 의해 곱해집니다.

//////////////////////////////////////////////

			//ColorMask RGB // RGB | A | 0 | any combination of R, G, B, A 색상 쓰기 마스크를 세팅합니다. 
							//ColorMask 0 쓰는 것은 모든 색상 채널로 렌더링하는 것을 끕니다. 
			//Offset 0, -1 //Factor , Units 사용자가 두 개의 파라미터로 깊이 오프셋을 정하는 것을 허락합니다.
							//factor와 unitsFactor 는 최대의 Z 기울기를 다각형의 X 또는 Y에 따라 스케일 하고 units은 최소 깊이 버퍼 값을 스케일 합니다.
							//이것은 사용자가 다각형들이 같은 위치에 있음에도 불구하고 하나의 다각형이 다른 것 위에서 그려지도록 할 수 있습니다.
							//예를 들어 Offset 0, -1 은 다각형의 기울기를 무시하고 다각형을 카메라 가까이로 당깁니다.
							//반면 Offset -1, -1 은 방목 각도를 볼 때 심지어 더 가깝게 다각형을 끌어 당깁니다. 

//////////////////////////////////////////////

			//SetTexture[_MainTex]
			//{
				//matrix [unity_LightmapMatrix]
				//ConstantColor[_Color] 
				//Combine one - Primary * Texture alpha DOUBLE(or QURD)
				//Combine one - Primary * Texture DOUBLE, Primary + Texture
				// Previous 는 이전 SetTexture의 결과입니다. 
				// Primary 는 lighting calculation 로부터의 색상이거나 또는 그것이 bound 되어지면 꼭지점 색상입니다. 
				// Texture 는 SetTexture에서 [TextureName] 에서 지정된 텍스쳐의 색상입니다 (위를 참고하세요). 
				// Constant 는 ConstantColor에서 지정된 색상입니다. 
				// , 를 사용할 경우 앞 RGB 뒤 A

				//combine src1 * src2 src1과src2를 함께 곱합니다. 결과는 입력값보다 더 어두울 것입니다.
				//combine src1 + src2 src1과src2를 함께 더합니다. 결과는 입력값보다 더 밝을 것입니다.
				//combine src1 - src2 src1에서 src2를 뺍니다.
				//combine src1 +- src2 src1과src2를 함께 더하고나서 0.5를 뺍니다 (부호가 적용되는 덧셈).
				//combine src1 lerp (src2) src3 src2의 알파를 사용해서 src3와src1 사이에서 보간합니다. 보간은 반대 방향임을 주의하시기 바랍니다: 알파가 1일 때src1가 사용되고 알파가 0일 때src3에서 사용됩니다.
				//combine src1 * src2 + src3 src1을src2의 알파 컴포넌트에 곱하고 나서 src3을 더합니다.
				//combine src1 * src2 +- src3 src1을src2의 알파 컴포넌트에 곱하고 나서src3과 함께 부호를 적용하는 덧셈을 합니다.
				//combine src1 * src2 - src3 src1을src2의 알파 컴포넌트에 곱하고 나서src3을 뺍니다. 
			//}
		//}
	} 

	FallBack "Diffuse"
}
