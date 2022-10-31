#version 330 core

uniform sampler2D frameTex;
in vec2 texCoord;
out vec4 fragColor;

vec4 grow(vec4 color, float amount) {
    return vec4(color.rgb + amount, color.a);
}

void main () {
  fragColor = texture(frameTex, texCoord);
  fragColor = vec4(fragColor.xyz, 1.0);
  fragColor = grow(fragColor, 0.3);
}
