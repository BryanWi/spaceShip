shader_type spatial;

uniform sampler2D noise;
uniform float height_scale = 0.5;
uniform sampler2D normalmap;

varying vec2 text_position;

void vertex() {
	text_position = VERTEX.xz /4.0 + 1.0;
	float height = texture(noise, text_position).x;
	VERTEX.y += height * height_scale*1.0;
}
void fragment() {
	NORMAL_MAP = texture(normalmap,text_position).xyz;
}