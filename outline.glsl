#version 120

uniform vec2 u_size;
uniform float u_radius;
uniform float u_border_size;
uniform float u_alpha;
uniform vec3 u_color_1, u_color_2, u_color_3, u_color_4;

void main(void) {
    vec2 tex = gl_TexCoord[0].st;
    vec3 color = mix(mix(u_color_1.rgb, u_color_2.rgb, tex.y), mix(u_color_3.rgb, u_color_4.rgb, tex.y), tex.x);

    vec2 position = (abs(gl_TexCoord[0].st - 0.5) + 0.5) * u_size;
    float distance = length(max(position - u_size + u_radius + u_border_size, 0.0)) - u_radius + 0.5;
    gl_FragColor = vec4(color.rgb, u_alpha * (smoothstep(0.0, 1.0, distance) - smoothstep(0.0, 1.0, distance - u_border_size)));
}