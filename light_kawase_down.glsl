#version 120

uniform sampler2D image;
uniform float offset;
uniform vec2 resolution;

void main() {
    vec2 uv = gl_TexCoord[0].xy * 2.0;
    vec2 halfpixel = resolution * offset;

    vec3 sum = texture2D(image, uv).rgb * 4.0;

    vec2 offsets[4];
    offsets[0] = -halfpixel;
    offsets[1] = halfpixel;
    offsets[2] = vec2(halfpixel.x, -halfpixel.y);
    offsets[3] = vec2(-halfpixel.x, halfpixel.y);

    for (int i = 0; i < 4; i++) {
        sum += texture2D(image, uv + offsets[i]).rgb;
    }

    gl_FragColor = vec4(sum / 8.0, 1.0);
}

