// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Stars"
{
	Properties
	{
		[PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
		_Color ("Tint", Color) = (1,1,1,1)
		[MaterialToggle] PixelSnap ("Pixel snap", Float) = 0
		[PerRendererData] _AlphaTex ("External Alpha", 2D) = "white" {}
		[IntRange]_Octaves("Octaves", Range( 1 , 8)) = 1
		_Frequency("Frequency", Float) = 10
		_Gain("Gain", Float) = 0.5
		_Jitter("Jitter", Range( 0 , 1)) = 1
		_Seed("Seed", Float) = 0
		_Pow("Pow", Float) = 0

	}

	SubShader
	{
		LOD 0

		Tags { "Queue"="Background+999" "IgnoreProjector"="True" "RenderType"="Transparent" "PreviewType"="Plane" "CanUseSpriteAtlas"="True" }

		Cull Front
		Lighting Off
		ZWrite On
		Blend One One
		
		
		Pass
		{
		CGPROGRAM
			
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile _ PIXELSNAP_ON
			#pragma multi_compile _ ETC1_EXTERNAL_ALPHA
			#include "UnityCG.cginc"
			#include "Assets/com.toorah-games.sky/Shaders/GPUVoronoiNoise4D.cginc"


			struct appdata_t
			{
				float4 vertex   : POSITION;
				float4 color    : COLOR;
				float2 texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				
			};

			struct v2f
			{
				float4 vertex   : SV_POSITION;
				fixed4 color    : COLOR;
				float2 texcoord  : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				float4 ase_texcoord1 : TEXCOORD1;
			};
			
			uniform fixed4 _Color;
			uniform float _EnableExternalAlpha;
			uniform sampler2D _MainTex;
			uniform sampler2D _AlphaTex;
			uniform float _Gain;
			uniform float _Seed;
			uniform float _Octaves;
			uniform float _Pow;
			float MyCustomExpression19( float4 NoiseUV, float Octaves )
			{
				return fBm_F0(NoiseUV, Octaves);
			}
			

			
			v2f vert( appdata_t IN  )
			{
				v2f OUT;
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(OUT);
				UNITY_TRANSFER_INSTANCE_ID(IN, OUT);
				OUT.ase_texcoord1 = IN.vertex;
				
				IN.vertex.xyz +=  float3(0,0,0) ; 
				OUT.vertex = UnityObjectToClipPos(IN.vertex);
				OUT.texcoord = IN.texcoord;
				OUT.color = IN.color * _Color;
				#ifdef PIXELSNAP_ON
				OUT.vertex = UnityPixelSnap (OUT.vertex);
				#endif

				return OUT;
			}

			fixed4 SampleSpriteTexture (float2 uv)
			{
				fixed4 color = tex2D (_MainTex, uv);

#if ETC1_EXTERNAL_ALPHA
				// get the color from an external texture (usecase: Alpha support for ETC1 on android)
				fixed4 alpha = tex2D (_AlphaTex, uv);
				color.a = lerp (color.a, alpha.r, _EnableExternalAlpha);
#endif //ETC1_EXTERNAL_ALPHA

				return color;
			}
			
			fixed4 frag(v2f IN  ) : SV_Target
			{
				float4 appendResult20 = (float4(IN.ase_texcoord1.xyz , _Seed));
				float4 NoiseUV19 = appendResult20;
				float Octaves19 = _Octaves;
				float localMyCustomExpression19 = MyCustomExpression19( NoiseUV19 , Octaves19 );
				float4 temp_cast_0 = (saturate( ( pow( ( 1.0 - saturate( localMyCustomExpression19 ) ) , _Pow ) * _Gain ) )).xxxx;
				
				fixed4 c = temp_cast_0;
				c.rgb *= c.a;
				return c;
			}
		ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=18712
2703.333;10.66667;2399.333;1367;906.4092;532.8303;1;True;False
Node;AmplifyShaderEditor.PosVertexDataNode;21;-1139.134,63.85718;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;30;-1023.134,272.8572;Inherit;False;Property;_Seed;Seed;6;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;20;-784.1337,200.8572;Inherit;False;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;23;-766.1337,381.8572;Inherit;False;Property;_Octaves;Octaves;1;1;[IntRange];Create;True;0;0;0;False;0;False;1;1;1;8;0;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;19;-501.8961,194.8383;Inherit;False;return fBm_F0(NoiseUV, Octaves)@;1;False;2;True;NoiseUV;FLOAT4;0,0,0,0;In;;Inherit;False;True;Octaves;FLOAT;0;In;;Inherit;False;My Custom Expression;True;False;0;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;33;-287.1337,221.8572;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;37;-134.1337,326.8572;Inherit;False;Property;_Pow;Pow;7;0;Create;True;0;0;0;False;0;False;0;7.15;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;32;-135.1337,222.8572;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;36;61.86633,241.8572;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-248.1337,60.85718;Inherit;False;Property;_Gain;Gain;4;0;Create;True;0;0;0;True;0;False;0.5;4.99;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;52;292.5548,237.5535;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RelayNode;31;593.6663,218.6572;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;-217.1337,-100.1428;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;39;717.8528,282.5623;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-771.1337,68.85718;Inherit;False;Property;_Jitter;Jitter;5;0;Fetch;True;0;0;0;True;0;False;1;0.997;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-799.1337,-172.1428;Inherit;False;Property;_Frequency;Frequency;3;0;Fetch;True;0;0;0;True;0;False;10;105.57;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;24;-828.1337,-355.1428;Inherit;False;Property;_Color2;Color2;2;0;Create;True;0;0;0;False;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;56;1099,167;Float;False;True;-1;2;ASEMaterialInspector;0;6;Stars;0f8ba0101102bb14ebf021ddadce9b49;True;SubShader 0 Pass 0;0;0;SubShader 0 Pass 0;2;True;4;1;False;-1;1;False;-1;0;1;False;-1;0;False;-1;False;False;False;False;False;False;False;False;True;1;False;-1;False;False;False;False;False;True;1;False;-1;False;False;True;5;Queue=Background=Queue=999;IgnoreProjector=True;RenderType=Transparent=RenderType;PreviewType=Plane;CanUseSpriteAtlas=True;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;2;Include;;False;;Native;Include;;True;8e4f8a8aa92771149a404d36b77772c4;Custom;;0;0;Standard;0;0;1;True;False;;False;0
WireConnection;20;0;21;0
WireConnection;20;3;30;0
WireConnection;19;0;20;0
WireConnection;19;1;23;0
WireConnection;33;0;19;0
WireConnection;32;0;33;0
WireConnection;36;0;32;0
WireConnection;36;1;37;0
WireConnection;52;0;36;0
WireConnection;52;1;27;0
WireConnection;31;0;52;0
WireConnection;29;0;24;0
WireConnection;39;0;31;0
WireConnection;56;0;39;0
ASEEND*/
//CHKSM=E0F6BC662A83BBD356315BB686BDD418E8EF92B1