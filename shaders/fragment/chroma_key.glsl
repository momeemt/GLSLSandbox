#version 330 core

uniform sampler2D frameTex;
uniform vec3 rgb;
uniform float range;
in vec2 texCoord;
out vec4 fragColor;

void main () {
  fragColor = texture(frameTex, texCoord);
  
  if (
    (rgb.r - range/2) < fragColor.r && fragColor.r < (rgb.r + range/2) &&
    (rgb.g - range/2) < fragColor.g && fragColor.g < (rgb.g + range/2) &&
    (rgb.b - range/2) < fragColor.b && fragColor.b < (rgb.b + range/2)
  ) {
    fragColor = vec4(0, 0, 0, 0);
  } else {
    fragColor = vec4(fragColor.xyz, 1.0);
  }
}
