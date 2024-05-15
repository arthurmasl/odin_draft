#version 330

in vec2 fragTexCoord;
in vec4 fragColor;

out vec4 finalColor;

uniform vec2 resolution;
uniform float time;

void main() {
    vec2 st = gl_FragCoord.xy / resolution;

    finalColor = vec4(st, abs(cos(time)), 1.0);
}
