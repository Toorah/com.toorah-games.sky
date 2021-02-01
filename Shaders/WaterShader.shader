// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "WaterShader"
{
	Properties
	{
		_Smoothness("Smoothness", Range( 0 , 1)) = 0
		_Tiles("Tiles", Float) = 1
		_Waves("Waves", Vector) = (0,0,0,0)
		_Texture0("Texture 0", 2D) = "bump" {}
		_Color0("Color 0", Color) = (0,0,0,0)
		_Color1("Color 1", Color) = (0,0,0,0)
		_NormalStrength("Normal Strength", Float) = 1
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IgnoreProjector" = "True" }
		Cull Back
		ZWrite On
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#pragma target 4.6
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows exclude_path:deferred vertex:vertexDataFunc 
		struct Input
		{
			float3 worldPos;
			float4 screenPosition36;
		};

		uniform sampler2D _Texture0;
		uniform float4 _Waves;
		uniform float _Tiles;
		uniform float _NormalStrength;
		uniform float4 _Color0;
		uniform float4 _Color1;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _Smoothness;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 vertexPos36 = ase_vertex3Pos;
			float4 ase_screenPos36 = ComputeScreenPos( UnityObjectToClipPos( vertexPos36 ) );
			o.screenPosition36 = ase_screenPos36;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 appendResult10 = (float2(_Waves.x , _Waves.y));
			float3 ase_worldPos = i.worldPos;
			float2 appendResult18 = (float2(ase_worldPos.x , ase_worldPos.z));
			float2 temp_output_5_0 = (appendResult18*_Tiles + 0.0);
			float2 panner7 = ( 1.0 * _Time.y * appendResult10 + temp_output_5_0);
			float2 appendResult14 = (float2(_Waves.z , _Waves.w));
			float2 panner13 = ( 1.0 * _Time.y * appendResult14 + temp_output_5_0);
			float cos19 = cos( radians( 32.0 ) );
			float sin19 = sin( radians( 32.0 ) );
			float2 rotator19 = mul( panner13 - float2( 0,0 ) , float2x2( cos19 , -sin19 , sin19 , cos19 )) + float2( 0,0 );
			o.Normal = BlendNormals( UnpackScaleNormal( tex2D( _Texture0, panner7 ), _NormalStrength ) , UnpackScaleNormal( tex2D( _Texture0, rotator19 ), _NormalStrength ) );
			float4 ase_screenPos36 = i.screenPosition36;
			float4 ase_screenPosNorm36 = ase_screenPos36 / ase_screenPos36.w;
			ase_screenPosNorm36.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm36.z : ase_screenPosNorm36.z * 0.5 + 0.5;
			float screenDepth36 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm36.xy ));
			float distanceDepth36 = saturate( ( screenDepth36 - LinearEyeDepth( ase_screenPosNorm36.z ) ) / ( 2.0 ) );
			float4 lerpResult39 = lerp( _Color0 , _Color1 , distanceDepth36);
			o.Albedo = lerpResult39.rgb;
			o.Smoothness = _Smoothness;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18712
4008.667;580;2399.333;1367;3142.982;4.237244;1;True;False
Node;AmplifyShaderEditor.WorldPosInputsNode;17;-3082.667,53.5;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;18;-2893.667,65.5;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector4Node;9;-1726.667,387.5;Inherit;False;Property;_Waves;Waves;2;0;Create;True;0;0;0;False;0;False;0,0,0,0;0.1,0.05,-0.02,-0.09;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;6;-2596.667,471.5;Inherit;False;Property;_Tiles;Tiles;1;0;Create;True;0;0;0;False;0;False;1;0.15;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;5;-2277.667,109.5;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;14;-1453.667,429.5;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-1309.667,537.5;Inherit;False;Constant;_Float0;Float 0;5;0;Create;True;0;0;0;False;0;False;32;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;13;-1150.667,337.5;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;10;-1453.667,333.5;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RadiansOpNode;21;-1114.667,539.5;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;33;-419.3024,486.6975;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;66;-1149.918,-237.0961;Inherit;False;Property;_NormalStrength;Normal Strength;6;0;Create;True;0;0;0;False;0;False;1;1.94;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;7;-1027.667,99.5;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RotatorNode;19;-972.6672,347.5;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;11;-2015.667,-224.5;Inherit;True;Property;_Texture0;Texture 0;3;0;Create;True;0;0;0;False;0;False;None;dd2fd2df93418444c8e280f1d34deeb5;True;bump;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SamplerNode;12;-767.6672,295.5;Inherit;True;Property;_TextureSample1;Texture Sample 1;4;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-811.6672,6.5;Inherit;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;0;False;0;False;-1;None;dd2fd2df93418444c8e280f1d34deeb5;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;38;-423.3024,-226.3025;Inherit;False;Property;_Color1;Color 1;5;0;Create;True;0;0;0;False;0;False;0,0,0,0;0.06378274,0.1704814,0.2358486,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DepthFade;36;-58.30237,429.6975;Inherit;False;True;True;False;2;1;FLOAT3;0,0,0;False;0;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;37;-415.3024,-395.3025;Inherit;False;Property;_Color0;Color 0;4;0;Create;True;0;0;0;False;0;False;0,0,0,0;0.1245994,0.1566962,0.1981131,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;75;-2545.787,259.2775;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.01;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;74;-2756.787,262.2775;Inherit;False;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;39;521.6976,-191.3025;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;2;-146.6672,141.5;Inherit;False;Property;_Smoothness;Smoothness;0;0;Create;True;0;0;0;False;0;False;0;0.896;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.BlendNormalsNode;15;-340.6672,45.5;Inherit;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;69;291.0813,593.9039;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;70;776.0808,148.9039;Inherit;False;Constant;_Float1;Float 1;8;0;Create;True;0;0;0;False;0;False;1.33;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1090,-24;Float;False;True;-1;6;ASEMaterialInspector;0;0;Standard;WaterShader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;1;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;ForwardOnly;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;18;0;17;1
WireConnection;18;1;17;3
WireConnection;5;0;18;0
WireConnection;5;1;6;0
WireConnection;14;0;9;3
WireConnection;14;1;9;4
WireConnection;13;0;5;0
WireConnection;13;2;14;0
WireConnection;10;0;9;1
WireConnection;10;1;9;2
WireConnection;21;0;20;0
WireConnection;7;0;5;0
WireConnection;7;2;10;0
WireConnection;19;0;13;0
WireConnection;19;2;21;0
WireConnection;12;0;11;0
WireConnection;12;1;19;0
WireConnection;12;5;66;0
WireConnection;1;0;11;0
WireConnection;1;1;7;0
WireConnection;1;5;66;0
WireConnection;36;1;33;0
WireConnection;75;0;74;0
WireConnection;74;0;18;0
WireConnection;39;0;37;0
WireConnection;39;1;38;0
WireConnection;39;2;36;0
WireConnection;15;0;1;0
WireConnection;15;1;12;0
WireConnection;0;0;39;0
WireConnection;0;1;15;0
WireConnection;0;4;2;0
ASEEND*/
//CHKSM=501C77C2D7330B15F2F87CD7917C1B372F05ED1A