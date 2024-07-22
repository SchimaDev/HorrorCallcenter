shader_type canvas_item;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture;
uniform float bits_per_channel : hint_range(1.0, 8.0) = 4.0;
uniform float dither_strength : hint_range(0.0, 1.0) = 0.1;
uniform float bloom_threshold : hint_range(0.0, 1.0) = 0.5;
uniform float bloom_intensity : hint_range(0.0, 10.0) = 2.0;
uniform float pixelation : hint_range(1, 1000) = 10;
uniform float color_relaxation : hint_range(0.0, 1.0) = 0.5;
uniform vec3 relaxation_color = vec3(1.0, 1.0, 1.0);
uniform float threshold_r : hint_range(0.0, 1.0) = 0.5;
uniform float threshold_g : hint_range(0.0, 1.0) = 0.5;
uniform float threshold_b : hint_range(0.0, 1.0) = 0.5;
uniform vec3 threshold_color = vec3(1.0, 1.0, 1.0);

float noise(vec2 uv) {
    return fract(sin(dot(uv, vec2(12.9898, 78.233))) * 43758.5453);
}

void fragment() {
    vec2 pixel_uv = floor(UV * pixelation) / pixelation;
    vec4 col = texture(SCREEN_TEXTURE, pixel_uv);
    float max_val = pow(2.0, bits_per_channel) - 1.0;
    col.rgb = floor(col.rgb * max_val) / max_val;
    vec3 dither = vec3(
        noise(pixel_uv + TIME),
        noise(pixel_uv + TIME + vec2(1.0, 0.0)),
        noise(pixel_uv + TIME + vec2(0.0, 1.0))
    );
    col.rgb += dither * dither_strength;
    
    // Color relaxation
    col.rgb = mix(col.rgb, relaxation_color, color_relaxation);
    
    // Threshold
    if (col.r > threshold_r) {
        col.r = threshold_color.r;
    }
    if (col.g > threshold_g) {
        col.g = threshold_color.g;
    }
    if (col.b > threshold_b) {
        col.b = threshold_color.b;
    }
    
    // Bloom
    if (col.r > bloom_threshold || col.g > bloom_threshold || col.b > bloom_threshold) {
        col.rgb += (col.rgb - bloom_threshold) * bloom_intensity;
    }
    
    COLOR = col;
}