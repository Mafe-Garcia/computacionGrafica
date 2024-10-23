using System.Collections;
using System.Collections.Generic;
using System.Linq.Expressions;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

public class ValorantSmokeFogFeature : ScriptableRendererFeature
{
    [SerializeField] private RenderPassEvent passEvent;
    [SerializeField] private Material smokeFogMaterial;

    private valorantSmokeFogPass pass;

    public override 
}
