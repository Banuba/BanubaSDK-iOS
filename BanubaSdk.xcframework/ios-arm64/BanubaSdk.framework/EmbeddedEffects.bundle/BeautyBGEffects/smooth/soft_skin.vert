#include <bnb/glsl.vert>
#include <bnb/transform_uv.glsl>

BNB_LAYOUT_LOCATION(0)
BNB_IN vec3 attrib_pos;
BNB_LAYOUT_LOCATION(1)
BNB_IN vec3 attrib_pos_static;
BNB_LAYOUT_LOCATION(2)
BNB_IN vec2 attrib_uv;
BNB_LAYOUT_LOCATION(3)
BNB_IN vec4 attrib_red_mask;

BNB_OUT(0)
vec2 var_uv;
BNB_OUT(1)
vec3 var_red_mask;

BNB_OUT(2)
vec2 transformed_bg_uv;

void main()
{
    gl_Position = bnb_MVP * vec4(attrib_pos, 1.);

    var_uv = (gl_Position.xy / gl_Position.w) * 0.5 + 0.5;
    
    /* apply scale and offset to transformed_bg_uv to cut everything outside the texture */
    transformed_bg_uv = gl_Position.xy / gl_Position.w;
    mat2 ori = mat2(bnb_camera_orientation.xy, bnb_camera_orientation.zw);
    transformed_bg_uv = (ori * vec2(transformed_bg_uv.x * bnb_camera_scale_i420.x, transformed_bg_uv.y)) * 0.5 + 0.5;
    transformed_bg_uv += mat2(-1.f, 0.f, 0.f, -1.f) * ori * camera_origin_scale.xy;
    transformed_bg_uv = bnb_scale_uv(transformed_bg_uv, camera_origin_scale.zw);

#ifdef BNB_VK_1
    var_uv.y = 1. - var_uv.y;
    transformed_bg_uv.y = 1. - transformed_bg_uv.y;
#endif

    var_red_mask = attrib_red_mask.xyz;
}
