#version 330

in vec2 fragTexCoord;
in vec4 fragColor;

out vec4 finalColor;

uniform vec2 resolution;
uniform float time;

void main() {
  // vec2 uv = (gl_FragCoord.xy * 2.0 - resolution.xy) / resolution.y;

  finalColor = vec4(0.0, 0.0, 0.0, 1.0);
}    
