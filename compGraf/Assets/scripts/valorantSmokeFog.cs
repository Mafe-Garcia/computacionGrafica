using System.Collections;
using System.Collections.Generic;
using System.Linq.Expressions;
using UnityEngine;
using UnityEngine.Rendering;

public class valorantSmokeFog : VolumeComponent
{
    public ColorParameter FogColor = new ColorParameter(new Color(r:0,98f, g:0,25f, b:1f));
    public FloatParameter Fogstart = new FloatParameter(5f);
    public FloatParameter FogSmoothness = new FloatParameter(5f);

    public bool IsActive() => FogColor.value.a > 0.05f;
    public bool IsTileCompatible() => false;

}
