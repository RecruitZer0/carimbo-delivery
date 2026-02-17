shader_type canvas_item;

uniform sampler2D bg_texture: repeat_enable, filter_linear;
uniform vec2 direction = vec2(1, 0);
uniform float speed = 0.1;

void fragment() {
	vec2 offset = direction * speed * TIME;
	vec2 tile_uv = vec2(640.0 / 256.0, 360.0 / 256.0);
	COLOR = texture(bg_texture, UV * tile_uv + offset);
}
