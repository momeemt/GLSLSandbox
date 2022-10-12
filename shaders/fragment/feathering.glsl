#version 330 core

uniform sampler2D frameTex;
uniform vec2 resolution;
in vec2 texCoord;
out vec4 fragColor;

vec4 blur (int kernel, float aspectRatio) {
  fragColor = vec4(0);
  vec2 lr = vec2(1, 0)/resolution;
  vec2 tb = vec2(0, 1)/resolution;
  int width = int(round(pow(kernel * kernel, aspectRatio)));
  int height = int(round(pow(kernel * kernel, 1.0-aspectRatio))); 
  for (float i = -width; i <= width; i++) {
    for (float j = -height; j <= height; j++) {
      fragColor += texture(frameTex, texCoord+lr*i+tb*j);
    }
  }
  return vec4(fragColor.xyz / fragColor.w, 1.0);
}

void main () {
  fragColor = blur(5, 1.0);
}
