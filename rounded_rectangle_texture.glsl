#version 120

uniform sampler2D texture;
uniform vec2 size;
uniform float radius;
uniform float alpha;
uniform vec4 uvRect;

float dstfn(vec2 p, vec2 b, float r) {
    return length(max(abs(p) - b, 0.0)) - r;
}

void main() {
    vec2 tex = gl_TexCoord[0].st;
    vec4 smpl = texture2D(texture, tex);
    vec2 pixel = vec2((tex.x - uvRect.x) / (uvRect.z - uvRect.x), (tex.y - uvRect.y) / (uvRect.w - uvRect.y)) * size;
    vec2 centre = 0.5 * size;
    float sa = smoothstep(0.0, 1, dstfn(centre - pixel, centre - radius - 1, radius));
    vec4 c = mix(vec4(smpl.rgb, 1), vec4(smpl.rgb, 0), sa);
    gl_FragColor = vec4(smpl.rgb, smpl.a * c.a * alpha);
}