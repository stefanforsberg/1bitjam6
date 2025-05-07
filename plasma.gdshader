shader_type canvas_item;

uniform float scale  : hint_range(1,20)  = 6.0;
uniform float speed  : hint_range(0,10)  = 1.5;

void fragment()
{
    vec2 p = (UV - 0.5) * scale;

    float v  = sin(p.x + TIME*speed) + sin(p.y*1.3 + TIME*speed*1.1) + sin(p.x*0.7 + p.y*0.4 + TIME*speed*0.6) + sin(length(p)*2.0 + TIME*speed*0.9);
    v *= 0.25;

    float bw = step(0.0, v);

    COLOR = vec4(vec3(bw), 1.0);
}