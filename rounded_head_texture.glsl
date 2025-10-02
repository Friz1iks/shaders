#version 120

uniform sampler2D texture;
uniform vec2 size;
uniform float radius;
uniform vec4 color;
uniform vec4 cutZone;

uniform vec2 texSize;

float signedDistanceField(vec2 p, vec2 b, float r) {
    return length(max(abs(p) - b, 0.0)) - r;
}

void main() {
    vec2 tex = gl_TexCoord[0].st;
    vec2 clippedTexCoord = vec2(
        mix(cutZone.x / texSize.x, cutZone.y / texSize.y, tex.x),
        mix(cutZone.z / texSize.x, cutZone.w / texSize.y, tex.y)
    );
    vec4 smpl = texture2D(texture, clippedTexCoord);
    vec2 pixel = tex * size;
    vec2 centre = 0.5 * size;
    float sa = smoothstep(0.0, 1, signedDistanceField(centre - pixel, centre - radius - 1, radius));
    vec4 c = mix(vec4(smpl.rgb, smpl.a), vec4(smpl.rgb, 0), sa);
    gl_FragColor = vec4(smpl.rgb, c.a) * color;
}
