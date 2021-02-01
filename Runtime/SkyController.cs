using Toorah.ScriptableVariables;
using UnityEngine;

[ExecuteAlways]
public class SkyController : MonoBehaviour
{
    public Material skyMaterial;
    public Light sunLight;
    //public AnimationCurve sunIntensity = new AnimationCurve(new Keyframe(0, 0), new Keyframe(0.5f, 1), new Keyframe(1, 0));
    public AnimationCurveVariable sunIntensity;

    //[GradientUsage(true, ColorSpace.Linear)]
    //public Gradient sunColor;

    public GradientVariable sunColor;ffff

    [Range(0, 1)]
    public float sunSize = 0.15f;
    //public AnimationCurve skyIntensity = new AnimationCurve(new Keyframe(0, 0), new Keyframe(0.5f, 1), new Keyframe(1, 0));
    public AnimationCurveVariable skyIntensity;

    [Space]
    [Range(0, 1)]
    public float timeOfDay;

    public float timeSpeed = 0;


    Vector3 SunRotation
    {
        get
        {
            var r = new Vector3(timeOfDay * 360f - 90f, 0, 0);

            return r;
        }
    }

    private void Update()
    {
        if(Application.isPlaying)
            timeOfDay = (timeOfDay + timeSpeed * Time.deltaTime) % 1f;

        if (sunLight && sunIntensity)
        {
            sunLight.transform.rotation = Quaternion.Euler(SunRotation);
            sunLight.intensity = sunIntensity.Value.Evaluate(timeOfDay);
            sunLight.color = sunColor.Value.Evaluate(timeOfDay);
        }
        if (skyMaterial && skyIntensity)
        {
            skyMaterial.SetFloat("_SunSize", sunSize * sunSize);
            skyMaterial.SetFloat("_SkyIntensity", skyIntensity.Value.Evaluate(timeOfDay));
            if (sunLight)
            {
                skyMaterial.SetVector("_Axis", sunLight.transform.right);
                skyMaterial.SetFloat("_Angle", -timeOfDay * 360f);
            }
        }
    }
}