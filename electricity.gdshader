shader_type canvas_item;

//–– tweak to taste ––
uniform float speed     : hint_range(0.1,10.0) = 3.0;   // how fast it moves
uniform float amplitude : hint_range(0.0,1.0)  = 0.4;   // max vertical wiggle
uniform float thickness: hint_range(0.005,0.05) = 0.02; // bolt thickness

// cheap 1D hash
float hash1(float x) {
    return fract(sin(x*12.9898)*43758.5453);
}

void fragment() {
    // move along x over time
    float t = UV.x + TIME * speed;
    // generate a pseudo-random height at each x
    float y0 = 0.5 + (hash1(t) - 0.5) * amplitude;
    // draw a thin line around that y
    float bolt = step(abs(UV.y - y0), thickness);
    // output 0 or 1, alpha = 1
    COLOR = vec4(vec3(bolt), 1.0);
}