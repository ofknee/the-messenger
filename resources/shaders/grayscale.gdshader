shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture;

void fragment() {
	vec4 original_color = texture(screen_texture, SCREEN_UV);

	float grayscale = (
		original_color.r +
		original_color.g +
		original_color.b
	) / 3.0;

	COLOR = vec4(vec3(grayscale), original_color.a);
}