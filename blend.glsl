#version 120

uniform sampler2D textureIn;
uniform vec4 color;

void main() {
    vec4 tex_color = texture2D(textureIn, gl_TexCoord[0].st);

    gl_FragColor = tex_color * color;
}