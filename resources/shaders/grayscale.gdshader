shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture;

void fragment() {
	vec4 original_color = texture(screen_texture, SCREEN_UV);
	float gray = dot(original_color.rgb, vec3(0.299, 0.587, 0.114)); //thanks for the formula reddit <3
	COLOR = vec4(vec3(gray), original_color.a);
}