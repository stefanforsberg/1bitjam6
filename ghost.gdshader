shader_type canvas_item;
render_mode unshaded;

uniform float wave_speed    = 2.0;
uniform float wave_strength = 0.02;
uniform float wave_freq     = 10.0;

uniform float glitch_speed     = 5.0;
uniform float glitch_strength  = 0.1;
uniform int   glitch_slices    = 8;

uniform float threshold        = 0.5;

float rand(float x) {
    return fract(sin(x * 12.9898) * 43758.5453);
}

void fragment() {
    vec2 uv = UV;

    // 1) Wave distortion
    uv.x += sin(uv.y * wave_freq + TIME * wave_speed) * wave_strength;
    uv.y += cos(uv.x * wave_freq + TIME * wave_speed) * wave_strength;

    float seed    = floor(TIME * glitch_speed);
    float slice   = floor(uv.y * float(glitch_slices));
    float rnd0    = rand(slice + seed);
    float mask    = step(0.8, rnd0);
    uv.x += (rnd0 * 2.0 - 1.0) * glitch_strength * mask;

    vec4 tex = texture(TEXTURE, uv);

    float luma = dot(tex.rgb, vec3(0.2126, 0.7152, 0.0722));
    float bw   = step(threshold, luma);

    COLOR = vec4(vec3(bw), tex.a);
}
