#version 330 core

uniform sampler2D frameTex;
in vec2 texCoord;
out vec4 fragColor;

void main () {
  vec2 uv = floor(texCoord * 100.0) / 100.0;
  fragColor = texture(frameTex, uv);
  fragColor = vec4(fragColor.xyz, 1.0);
}