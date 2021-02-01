using UnityEngine;

[RequireComponent(typeof(Camera))]
public class SkyboxCamera : MonoBehaviour
{
    public Camera cam;
    public Cubemap rt;

    public void Render()
    {
        if (!cam)
            cam = GetComponent<Camera>();
        if (!rt)
        {
            rt = new Cubemap(512, UnityEngine.Experimental.Rendering.DefaultFormat.HDR, UnityEngine.Experimental.Rendering.TextureCreationFlags.None);
        }

        if (cam && rt)
        {
            cam.RenderToCubemap(rt);
            RenderSettings.customReflection = rt;
        }
    }

}
