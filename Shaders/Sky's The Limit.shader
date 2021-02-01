// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Toorah/Skys The Limit"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Background"  "Queue" = "Background+0" "IgnoreProjector" = "True" "ForceNoShadowCasting" = "True" "PreviewType"="Skybox" }
		Cull Off
		ZWrite On
		CGPROGRAM
		#include "UnityPBSLighting.cginc"
		#pragma target 2.0
		#pragma surface surf StandardCustomLighting keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nometa noforwardadd 
		struct Input
		{
			half filler;
		};

		struct SurfaceOutputCustomLightingCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			half Alpha;
			Input SurfInput;
			UnityGIInput GIData;
		};


		float3 RotateAroundAxis( float3 center, float3 original, float3 u, float angle )
		{
			original -= center;
			float C = cos( angle );
			float S = sin( angle );
			float t = 1 - C;
			float m00 = t * u.x * u.x + C;
			float m01 = t * u.x * u.y - S * u.z;
			float m02 = t * u.x * u.z + S * u.y;
			float m10 = t * u.x * u.y + S * u.z;
			float m11 = t * u.y * u.y + C;
			float m12 = t * u.y * u.z - S * u.x;
			float m20 = t * u.x * u.z - S * u.y;
			float m21 = t * u.y * u.z + S * u.x;
			float m22 = t * u.z * u.z + C;
			float3x3 finalMatrix = float3x3( m00, m01, m02, m10, m11, m12, m20, m21, m22 );
			return mul( finalMatrix, original ) + center;
		}


		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			c.rgb = 0;
			c.a = 1;
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
			o.Normal = float3(0,0,1);
			float3 rotatedValue210 = RotateAroundAxis( float3( 0,0,0 ), float3(0,1,0), float3(1,0,0), radians( 0.0 ) );
			o.Emission = rotatedValue210 + 1E-5;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18712
2703.333;10.66667;2399.333;1367;-3784.073;626.5012;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;20;2320.728,20.73119;Inherit;False;Property;_SunSize;Sun Size;12;0;Create;True;0;0;0;False;0;False;0;0.049729;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;157;2704.79,59.55978;Inherit;False;SunDisc;-1;;79;fc7e85e1d4262df4990cf14e537be668;0;1;13;FLOAT;0;False;2;COLOR;0;FLOAT;16
Node;AmplifyShaderEditor.RangedFloatNode;64;2674.108,-61.92266;Inherit;False;Property;_SkyIntensity;Sky Intensity;13;0;Create;True;0;0;0;False;0;False;1;0.1953443;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;195;1699.429,242.8357;Inherit;False;SkyUV;-1;;96;f6aad089b09c8c543885beab4df94a48;1,15,0;2;16;FLOAT;0;False;18;FLOAT3;0,0,0;False;3;FLOAT2;0;FLOAT;11;FLOAT;12
Node;AmplifyShaderEditor.GradientNode;58;2335.749,-325.6241;Inherit;False;0;4;2;0.8076718,0.907751,0.9339623,0;0.6791266,0.846621,0.9150943,0.1382315;0.675,0.8390778,1,0.4147097;0.37,0.7812953,1,0.8088197;1,0;1,1;0;1;OBJECT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;154;3069.532,-65.83093;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;155;3203.532,-152.8309;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GradientSampleNode;59;2717.584,-274.9005;Inherit;True;2;0;OBJECT;;False;1;FLOAT;0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;212;5136.073,164.4988;Inherit;False;Constant;_AngleValue;AngleValue;11;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;61;3216.328,-252.0561;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector3Node;214;5157.073,265.4988;Inherit;False;Constant;_VertexPos;VertexPos;11;0;Create;True;0;0;0;False;0;False;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RadiansOpNode;213;5277.073,176.4988;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;211;5137.073,-24.50122;Inherit;False;Constant;_AxisAngle;AxisAngle;11;0;Create;True;0;0;0;False;0;False;1,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;78;3441.15,432.297;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;159;3327.532,348.1691;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;102;3043.978,158.1302;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;82;1179.523,722.574;Inherit;False;Property;_v;v;18;0;Create;True;0;0;0;False;0;False;0;0.01;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;158;3168.532,246.1691;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;106;2346.14,538.8711;Inherit;False;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.HSVToRGBNode;107;2894.715,506.4664;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0.2;False;2;FLOAT;1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;200;4128.073,242.4988;Inherit;False;Constant;_Vector0;Vector 0;9;0;Create;True;0;0;0;False;0;False;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;204;4730.073,108.4988;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;68;1597.238,782.3154;Inherit;False;Property;_Angle;Angle;15;0;Create;True;0;0;0;False;0;False;2;28.43;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RotateAboutAxisNode;210;5476.073,186.4988;Inherit;False;False;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;108;3235.941,618.0706;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;66;1903.982,-16.10759;Inherit;False;SkyUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;69;1592.238,857.3154;Inherit;False;Property;_Scale;Scale;16;0;Create;True;0;0;0;False;0;False;5;24.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;67;1565.677,473.2018;Inherit;False;66;SkyUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;209;1903.998,654.1345;Inherit;False;Sky Stars;1;;98;cf13c7cedc06f9e4aa979d17ed293507;0;7;15;FLOAT2;0,0;False;14;FLOAT2;0,0;False;16;FLOAT2;0,0;False;17;FLOAT;0;False;18;FLOAT;0;False;19;FLOAT;0;False;20;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;81;1407.524,723.574;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;203;4390.073,24.49884;Inherit;False;True;False;True;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;74;1576.921,556.3896;Inherit;False;Property;_Tiling;Tiling;14;0;Create;True;0;0;0;False;0;False;8,2;5,5;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.FmodOpNode;111;2740.631,559.3213;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;196;3761.431,428.0982;Inherit;False;SkyUV;-1;;99;f6aad089b09c8c543885beab4df94a48;1,15,0;2;16;FLOAT;0;False;18;FLOAT3;0,0,0;False;3;FLOAT2;0;FLOAT;11;FLOAT;12
Node;AmplifyShaderEditor.SimpleAddOpNode;129;3908.89,-128.3069;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.AbsOpNode;208;4920.073,178.4988;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;110;2367.982,665.218;Inherit;False;1;0;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;201;4560.073,244.4988;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;205;4146.073,-12.50116;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;206;4003.073,19.49884;Inherit;False;Property;_SSS;SSS;20;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;198;3775.073,176.4988;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldPosInputsNode;197;3596.073,66.49884;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CustomExpressionNode;125;2644.645,360.3552;Inherit;False;if(UV < 0)$return 0@$else$return 1@;1;False;1;True;UV;FLOAT;0;In;;Inherit;False;My Custom Expression;True;False;0;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;109;2593.177,567.364;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;75;3396.441,-121.265;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;76;1599.311,948.4532;Inherit;False;Property;_Exp;Exp;17;0;Create;True;0;0;0;False;0;False;100;62.7;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;83;1612.527,682.574;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;160;4725.532,522.1691;Inherit;True;Property;_TextureSample0;Texture Sample 0;19;0;Create;True;0;0;0;False;0;False;-1;d01457b88b1c5174ea4235d140b5fab8;d01457b88b1c5174ea4235d140b5fab8;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DotProductOpNode;199;4428.073,237.4988;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;5862.772,-173.6043;Float;False;True;-1;0;ASEMaterialInspector;0;0;Unlit;Toorah/Skys The Limit;False;False;False;False;True;True;True;True;True;False;True;True;False;False;True;True;False;False;False;False;False;Off;1;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Background;;Background;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;1;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;1;PreviewType=Skybox;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;157;13;20;0
WireConnection;154;0;64;0
WireConnection;154;1;157;16
WireConnection;155;0;154;0
WireConnection;59;0;58;0
WireConnection;59;1;195;12
WireConnection;61;0;59;0
WireConnection;61;1;155;0
WireConnection;213;0;212;0
WireConnection;78;0;159;0
WireConnection;78;1;108;0
WireConnection;78;2;125;0
WireConnection;159;0;158;0
WireConnection;102;0;64;0
WireConnection;158;0;102;0
WireConnection;158;1;157;16
WireConnection;106;0;67;0
WireConnection;107;0;111;0
WireConnection;204;0;201;0
WireConnection;204;1;203;0
WireConnection;210;0;211;0
WireConnection;210;1;213;0
WireConnection;210;3;214;0
WireConnection;108;0;107;0
WireConnection;108;1;209;0
WireConnection;66;0;195;0
WireConnection;209;15;67;0
WireConnection;209;14;74;0
WireConnection;209;16;83;0
WireConnection;209;17;68;0
WireConnection;209;18;69;0
WireConnection;209;19;76;0
WireConnection;81;0;82;0
WireConnection;203;0;198;0
WireConnection;111;0;109;0
WireConnection;129;0;61;0
WireConnection;129;1;157;0
WireConnection;208;0;204;0
WireConnection;201;0;199;0
WireConnection;198;0;197;0
WireConnection;125;0;195;12
WireConnection;109;0;106;0
WireConnection;109;1;110;0
WireConnection;75;1;78;0
WireConnection;83;0;81;0
WireConnection;160;1;208;0
WireConnection;199;0;198;0
WireConnection;199;1;200;0
WireConnection;0;2;129;0
WireConnection;0;15;210;0
ASEEND*/
//CHKSM=CDB7A8B4564E6E0AB027BD3089DDA702DAADF24A