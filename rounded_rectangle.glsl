#version 120

uniform vec2 size;
uniform vec4 radius;
uniform vec4 color;

float signedDistanceField(vec2 p, vec2 b, vec4 r) {
    r.xy = (p.x > 0.0) ? r.xy : r.zw;
    r.x = (p.y > 0.0) ? r.x : r.y;

    vec2 q = abs(p) - b + r.x;

    return min(max(q.x, q.y), 0.0) + length(max(q, 0.0)) - r.x;
}

void main() {
    vec2 rectHalf = size * 0.5;
    float smoothedAlpha = (1.0 - smoothstep(0.0, 1.0, signedDistanceField(rectHalf - (gl_TexCoord[0].st * size), rectHalf - 1.0, radius))) * color.a;
    gl_FragColor = vec4(color.rgb, smoothedAlpha);
}
