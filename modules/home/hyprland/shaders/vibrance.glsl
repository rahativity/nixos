#version 300 es
precision highp float;
in vec2 v_texcoord;
out vec4 fragColor;
uniform sampler2D tex;

// Boost vibrance and contrast to compensate for washed-out SDR gamut and lifted blacks
const float VIBRANCE = 0.40;
const float CONTRAST = 1.10;

void main() {
    vec4 pixColor = texture(tex, v_texcoord);
    vec3 color = pixColor.rgb;

    // Contrast adjustment to deepen blacks
    color = (color - 0.5) * CONTRAST + 0.5;
    color = clamp(color, 0.0, 1.0);

    // Calculate luminance
    float luma = dot(color, vec3(0.299, 0.587, 0.114));

    // Vibrance adjustment (boosts undersaturated colors without blowing out saturated tones)
    vec3 max_color = vec3(max(color.r, max(color.g, color.b)));
    vec3 min_color = vec3(min(color.r, min(color.g, color.b)));
    float sat = max_color.r - min_color.r;
    color = mix(vec3(luma), color, 1.0 + VIBRANCE * (1.0 - sat));

    fragColor = vec4(clamp(color, 0.0, 1.0), pixColor.a);
}
