#include <bnb/glsl.vert>
#include <bnb/decode_int1010102.glsl>
#include <bnb/matrix_operations.glsl>
#include <bnb/transform_uv.glsl>
#include <bnb/transform_camera_uv.glsl>

#define bnb_IDX_OFFSET 0
#ifdef BNB_VK_1
#ifdef gl_VertexID
#undef gl_VertexID
#endif
#ifdef gl_InstanceID
#undef gl_InstanceID
#endif
#define gl_VertexID gl_VertexIndex
#define gl_InstanceID gl_InstanceIndex
#endif

#define EYES_HIGHLIGHT
#define SOFT_LIGHT_LAYER
#define NORMAL_LAYER
#define SOFT_SKIN
#define skinSoftIntensity 0.7
#define SHARPEN_TEETH
#define teethSharpenIntensity 0.2
#define SHARPEN_EYES
#define eyesSharpenIntensity 0.3
#define PSI 0.1

BNB_LAYOUT_LOCATION(0) BNB_IN vec3 attrib_pos;
BNB_LAYOUT_LOCATION(1) BNB_IN vec3 attrib_pos_static;
BNB_LAYOUT_LOCATION(2) BNB_IN vec2 attrib_uv;
BNB_LAYOUT_LOCATION(3) BNB_IN vec4 attrib_red_mask;


BNB_OUT(0) vec3 maskColor;
BNB_OUT(1) vec4 var_uv_bg_uv;
BNB_OUT(2) vec2 transformed_bg_uv;

invariant gl_Position;

#ifdef GLFX_OCCLUSION
BNB_OUT(3) vec2 glfx_OCCLUSION_UV;
#endif

void main()
{
    gl_Position = bnb_MVP * vec4( attrib_pos, 1. );
    maskColor = attrib_red_mask.xyz;
    vec2 bg_uv  = (gl_Position.xy / gl_Position.w) * 0.5 + 0.5;
    var_uv_bg_uv = vec4(attrib_uv,bg_uv);
#ifdef GLFX_OCCLUSION
    glfx_OCCLUSION_UV = (gl_Position.xy / gl_Position.w - glfx_OCCLUSION_RECT.xy) / glfx_OCCLUSION_RECT.zw;
    glfx_OCCLUSION_UV = glfx_OCCLUSION_UV * 0.5 + 0.5;
    glfx_OCCLUSION_UV.y = 1.0 - glfx_OCCLUSION_UV.y;
#endif

    /* apply scale and offset to transformed_bg_uv to cut everything outside the texture */
    transformed_bg_uv = gl_Position.xy / gl_Position.w;
    transformed_bg_uv = bnb_transform_camera_uv(transformed_bg_uv);
    
#ifdef BNB_VK_1
    var_uv_bg_uv.w = 1. - var_uv_bg_uv.w;
    transformed_bg_uv.y = 1. - transformed_bg_uv.y;
#endif
}
