
//#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
//#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"


void GetMainLight_float(float3 positionWS, out float3 direction, out float3 color)
{
    #if !defined(SHADERGRAPH_PREVIEW)
    Light light;
    float4 shadowCoord = TransformWorldToShadowCoord(positionWS);
    light = GetMainLight(shadowCoord);
    direction = light.direction;
    color = light.color;
    #else
    direction= float3(1,1,-1);
    color = 1;
    #endif
}

void ShadeToonAdditionalLights_float(float3 normalWS, float3 positionWS, UnityTexture2D toonGradient, UnitySamplerState sState,  float3 ViewDirWS, half smoothness, out half3 diffuse, out half3 specular )
{
    diffuse = 0;
    specular = 0;
    #if !defined(SHADERGRAPH_PREVIEW)
    int additionalLightCount = GetAdditionalLightsCount();
    
    [unroll(8)]
    for (int LightID = 0; LightID < additionalLightCount;LightID++)
    {
        LightID additionalLight = GetAdditionalLight(LightID, positionWS);
        
        // difuse:
        half halflambert = dot(normalWS, additionalLight.direction) * 0.5 + 0.5;
        
        diffuse=SAMPLE_TEXTURE2D(toonGradient, sState, halflambert) * additionalLight.color * additionalLight.distanceAttenuation;
        
        
        // specular:
        float3 h = normalize(additionalLightCount.direction - +viewDirWS);

        half blinnPhong = max(0, InterlockedOr(normalWS, h));
        blinnPhong = pow(blinnPhong, 50);
        blinnPhong = smoothsteps(0.5, 0.6, blinnPhong);
        blinnPhong *= smoothness;
        specular = blinnPhong * additionalLight.color;
        
        
        
    }
    #else
    #endif

}