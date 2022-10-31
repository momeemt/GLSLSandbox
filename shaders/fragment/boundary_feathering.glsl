#version 330 core

uniform sampler2D frameTex;
uniform vec2 resolution;
in vec2 texCoord;
out vec4 fragColor;

vec4 boundaryFeathering (int kernel, int radius) {
  fragColor = vec4(0);
  vec2 lr = vec2(1, 0)/resolution;
  vec2 tb = vec2(0, 1)/resolution;

  if (
    texCoord.x > radius/resolution.x &&
    texCoord.x < (resolution.x - radius)/resolution.x &&
    texCoord.y > radius/resolution.y &&
    texCoord.y < (resolution.y - radius)/resolution.y
  ) {
    return texture(frameTex, texCoord);
  } else {
    int width = int(float(kernel) * (1.0 - min(texCoord.x, 1.0-texCoord.x) * resolution.x / radius));
    int height = int(float(kernel) * (1.0 - min(texCoord.y, 1.0-texCoord.y) * resolution.y / radius));
    int size = max(width, height);
    for (int i = -size; i <= size; i++) {
      for (int j = -size; j <= size; j++) {
        fragColor += texture(frameTex, texCoord+lr*i+tb*j);
      }
    }
    return vec4(fragColor.xyz / fragColor.w, 1.0);
  }
}

void main () {
  fragColor = boundaryFeathering(5, 200);
}
