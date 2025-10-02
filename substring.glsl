#version 120

uniform vec2 width;
uniform sampler2D texture;
uniform vec4 color;

void main() {
    float f = clamp(smoothstep(.5, 1, 1 - (gl_FragCoord.x - width.y) / width.x), 0, 1);
    vec2 pos = gl_TexCoord[0].xy;
    vec4 c = texture2D(texture, pos);
    if (c.a > 0) {
        c.a = c.a * f;
    }
    gl_FragColor = c * color;
}
