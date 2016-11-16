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
		//														//LightmapMode : ����Ʈ��, Inspector���� �������� ����.
		//_RectText("Un2Power", Rect) = "black" {} //���簢�� (2�� ������ �ƴ�) �ؽ��� �Ӽ��� �����մϴ�.
		//_Cubemap("CubeMap", Cube) = "gray" {}
	}

	//Category //SubShader���� ���� �����̰� ���Ե� ��� SubShader�� ���� ������ �����ϰ� ����.
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
		//"Queue" : ������ ���� ����. 
		//�̹����ǵ� ť : Background = 1000, Geometry(default) = 2000, Transparent = 3000, Overlay = 4000
		//"IgnoreProjector" : 
		//"RenderType" : ������ Ÿ��
		//���ǵ� Ÿ�� : Opaque, Transparent

		//Lighting Off Cull Off ZTest Always ZWrite On Fog { Mode Off }
		//ZTest Less | Greater | LEqual | GEqual | Equal | NotEqual | Always 
//////////////////////////////////////////////

CGPROGRAM
		#pragma surface surf Lambert
		struct Input 
		{
			float4 color : COLOR;
		};

		//unity�� ���ǵ� output
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

		//UsePass "Reflective/Bumped Unlit/BASE" //�ٸ� ���̴��� Ư�� �н��� ����Ѵٴ� �ǹ�.

		//Pass
		//{
			//Name "Pass0" //UsePass���� ���۷����ϱ� ����. �̸��� ��� ����.

			//Tags { "LightMode"="Always" "RequireOptions"="Fantastic"}
			//LightMode tag
			// Deferred Lighting����, PrepassBase �� PrepassFinal �н��� ���˴ϴ�. 
			// Forward Rendering����, ForwardBase �� ForwardAdd �н��� ���˴ϴ�. 
			// In Vertex Lit����, Vertex, VertexLMRGBM �׸��� VertexLM �н��� ���˴ϴ�.

			//Always: �׻� �����˴ϴ�; ������ ������� �ʽ��ϴ�. 
			//ForwardBase: Forward rendering���� ���˴ϴ�, �ֺ��� �ֿ��� ���⼺�ִ� �����vertex/SH ������ ����˴ϴ�. 
			//ForwardAdd: Forward rendering���� ���˴ϴ�; ÷���Ǵ� �ȼ��� ������ ����˴ϴ�, ����� �� ���� �н�. 
			//PrepassBase: Deferred Lighting���� ���˴ϴ�, normals & specular ��ǥ�ڸ� �����մϴ�. 
			//PrepassFinal: Deferred Lighting���� ���˴ϴ�, �ؽ���, ���� �׸��� ��縦 �����ؼ� ������ ������ �����մϴ�. 
			//Vertex: ��ü�� ���� ���ε��� ���� �� Vertex Lit rendering���� ���˴ϴ�; ��� ���� ������ ����˴ϴ�. 
			//VertexLMRGBM: ��ü�� ���� ���ε��� ���� �� Vertex Lit rendering ���� ���˴ϴ�; lightmap�� RGBM���� ���ڵ��Ǵ� �÷���.
			//VertexLM: ��ü�� ���� ���ε��� ���� �� Vertex Lit rendering ���� ���˴ϴ�; lightmap��double-LDR���� ���ڵ��Ǵ� �÷��� (�Ϲ������� ����� �÷��� & ������ ����ũž GPUs).
			//ShadowCaster: �׸��� ĳ���ͷ� ��ü�� �����մϴ�. 
			//ShadowCollector: Forward ������ ��θ� ���ؼ� ��ũ�� ���� ���۷� ��ü�� �׸��ڸ� �����ϴ�. 

			//RequireOptions tag
			//Quality Settings���� ���õ� �±��̸� ������.

//////////////////////////////////////////////

			//BindChannels //�Է� �����Ϳ� unity ���̴� �����͸� ����
			//{
			//	Bind "Vertex", vertex
			//	Bind "normal", normal
			//	Bind "texcoord1", texcoord0 // lightmap uses 2nd uv
			//	Bind "texcoord", texcoord1 // main uses 1st uv
			//}
			//Bind "source", target 
			//source
			//Vertex: ������ ��ġ 
			//Normal: ������ normal 
			//Tangent: ������ ź��Ʈ 
			//Texcoord: �ֿ� UV ��ǥ 
			//Texcoord1: �ΰ����� UV ��ǥ 
			//Color: �ȼ��� ���� 

			//Target
			//Vertex: ������ ��ġ 
			//Normal: ������ normal 
			//Tangent: ������ ź��Ʈ 
			//Texcoord0, Texcoord1, ...: �ش� �ؽ��� ���������� ���� �ؽ��� ��ǥ 
			//Texcoord: ��� �ؽ��� ������������ ���� �ؽ��� ��ǥ�� 
			//Color: ������ ���� 

//////////////////////////////////////////////

			//Material //���� ������ ����ϴ� ����
			//{
			//	Diffuse[_Color] // (1.0, 1.0, 0.0, 1.0) or [_Color]
			//	Ambient[_Color] // (1.0, 1.0, 0.0, 1.0) or [_Color] //�ָ��� ���� ������Ʈ. �ֺ� ���� ���ÿ� ���� �װ��� �ε��� �� ��ü�� ������ ����.
			//	Shininess[_Shininess] // 0.5 of [_Shin] //������ ��ī�ο��� 0�� 1 ���� ������ ǥ��. 0���� ����ڴ� �����ִ� ����ó�� ���̴� Ŀ�ٶ� ���̶���Ʈ�� ���� ���̰� 1������ ���� ���� ���� �ڱ��� ����ϴ�. 
			//	Specular[_SpecColor] // (1.0, 1.0, 0.0, 1.0) or [_Color] //��ü�� ������ ���̶���Ʈ ����. 
			//	Emission[_Emission] // (1.0, 1.0, 0.0, 1.0) or [_Color] //��� �������� �ε����� ���� �� ��ü�� ����. 
			//}
			//Material ��� : Ambient * RenderSettings ambient setting + (Light Color * Diffuse + Light Color * Specular) + Emission
			//Color (1.0, 0.0, 0.0, 0.0) // (R, G, B, A) of [_Color]- ������ �������� ���Ǵ� ����.
			//ColorMaterial // AmbientAndDiffuse | Emission
			//SeparateSpecular On // On | Off //�ݻ����� ������ ���� ���ٴ� ���� ��� �Ŀ� �ݻ����� ������ ������ ���Դϴ�
			//Lighting On // On | Off

//////////////////////////////////////////////

			//Cull Back // Back | Front | Off
			//ZTest Less // Less | Greater | LEqual | GEqual | Equal | NotEqual | Always
			//ZWrite On // On | Off
			//Fog
			//{
			//	Mode Global // Off | Global | Linear | Exp | Exp2
			//	Color [_Color] // (1.0, 1.0, 0.0, 1.0) or [_Color]
			//	Density [_FogDensity] //���ϱ޼����� fog�� ���� �е�.
				//Range NearValue, FarValue //���� fog�� ���� �ٰŸ� �׸��� ���Ÿ��� ����.
			//}
			//AlphaTest Greater 0.5 //Less | Greater | LEqual | GEqual | Equal | NotEqual | Always
						//Blend Off // Off | SrcFactor DstFactor
						//One	1�� �� ? �ҽ� �Ǵ� ����Ƽ���̼� ������ ������ ���� �մϴ�.
						//Zero 0�� �� ? �ҽ� �Ǵµ���Ƽ���̼� ���� �����ϰ� �մϴ�.
						//SrcColor �� ���������� ���� �ҽ� ���� ���� ���� �������ϴ�.
						//SrcAlpha �� ���������� ���� �ҽ� ���� ���� ���� �������ϴ�.
						//DstColor �� ���������� ���� ������ ���� �ҽ� ���� ���� ���� �������ϴ�.
						//DstAlpha �� ���������� ���� ������ ���� �ҽ� ���� ���� ���� �������ϴ�.
						//OneMinusSrcColor �� ���������� ���� (1 ? �ҽ� ����)�� ���� �������ϴ�.
						//OneMinusSrcAlpha �� ���������� ���� (1 ? �ҽ� ����)�� ���� �������ϴ�.
						//OneMinusDstColor �� ���������� ���� (1 ? ����Ƽ���̼� ����)�� ���� �������ϴ�.
						//OneMinusDstAlpha �� ���������� ���� (1 ? ����Ƽ���̼� ����)�� ���� �������ϴ�.

//////////////////////////////////////////////

			//ColorMask RGB // RGB | A | 0 | any combination of R, G, B, A ���� ���� ����ũ�� �����մϴ�. 
							//ColorMask 0 ���� ���� ��� ���� ä�η� �������ϴ� ���� ���ϴ�. 
			//Offset 0, -1 //Factor , Units ����ڰ� �� ���� �Ķ���ͷ� ���� �������� ���ϴ� ���� ����մϴ�.
							//factor�� unitsFactor �� �ִ��� Z ���⸦ �ٰ����� X �Ǵ� Y�� ���� ������ �ϰ� units�� �ּ� ���� ���� ���� ������ �մϴ�.
							//�̰��� ����ڰ� �ٰ������� ���� ��ġ�� �������� �ұ��ϰ� �ϳ��� �ٰ����� �ٸ� �� ������ �׷������� �� �� �ֽ��ϴ�.
							//���� ��� Offset 0, -1 �� �ٰ����� ���⸦ �����ϰ� �ٰ����� ī�޶� �����̷� ���ϴ�.
							//�ݸ� Offset -1, -1 �� ��� ������ �� �� ������ �� ������ �ٰ����� ���� ���ϴ�. 

//////////////////////////////////////////////

			//SetTexture[_MainTex]
			//{
				//matrix [unity_LightmapMatrix]
				//ConstantColor[_Color] 
				//Combine one - Primary * Texture alpha DOUBLE(or QURD)
				//Combine one - Primary * Texture DOUBLE, Primary + Texture
				// Previous �� ���� SetTexture�� ����Դϴ�. 
				// Primary �� lighting calculation �κ����� �����̰ų� �Ǵ� �װ��� bound �Ǿ����� ������ �����Դϴ�. 
				// Texture �� SetTexture���� [TextureName] ���� ������ �ؽ����� �����Դϴ� (���� �����ϼ���). 
				// Constant �� ConstantColor���� ������ �����Դϴ�. 
				// , �� ����� ��� �� RGB �� A

				//combine src1 * src2 src1��src2�� �Բ� ���մϴ�. ����� �Է°����� �� ��ο� ���Դϴ�.
				//combine src1 + src2 src1��src2�� �Բ� ���մϴ�. ����� �Է°����� �� ���� ���Դϴ�.
				//combine src1 - src2 src1���� src2�� ���ϴ�.
				//combine src1 +- src2 src1��src2�� �Բ� ���ϰ��� 0.5�� ���ϴ� (��ȣ�� ����Ǵ� ����).
				//combine src1 lerp (src2) src3 src2�� ���ĸ� ����ؼ� src3��src1 ���̿��� �����մϴ�. ������ �ݴ� �������� �����Ͻñ� �ٶ��ϴ�: ���İ� 1�� ��src1�� ���ǰ� ���İ� 0�� ��src3���� ���˴ϴ�.
				//combine src1 * src2 + src3 src1��src2�� ���� ������Ʈ�� ���ϰ� ���� src3�� ���մϴ�.
				//combine src1 * src2 +- src3 src1��src2�� ���� ������Ʈ�� ���ϰ� ����src3�� �Բ� ��ȣ�� �����ϴ� ������ �մϴ�.
				//combine src1 * src2 - src3 src1��src2�� ���� ������Ʈ�� ���ϰ� ����src3�� ���ϴ�. 
			//}
		//}
	} 

	FallBack "Diffuse"
}
