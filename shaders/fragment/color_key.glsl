#version 330 core

uniform sampler2D frameTex;
uniform vec3 rgb;
uniform float range;
in vec2 texCoord;
out vec4 fragColor;

vec3 rgb2hsv (vec3 c) {
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

void main () {
  fragColor = texture(frameTex, texCoord);
  // vec3 fragColorHsv = rgb2hsv(fragColor.rgb);
  // vec3 hsv = rgb2hsv(rgb);
  
  if (hsv.z - range/2 <= fragColorHsv.z && fragColorHsv.z <= hsv.z + range/2) {
    fragColor = vec4(0, 0, 0, 0);
  } else {
    fragColor = vec4(fragColor.xyz, 1.0);
  }
}
