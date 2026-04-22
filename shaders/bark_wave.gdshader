shader_type canvas_item;
render_mode unshaded, blend_mix;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform vec2 rect_size_px = vec2(680.0, 680.0);
uniform float radius_px = 10.0;
uniform float ring_thickness_px = 26.0;
uniform float distortion_strength_px = 11.0;
uniform float alpha = 1.0;
uniform vec4 ring_tint : source_color = vec4(0.88, 0.96, 1.0, 0.32);

void fragment() {
	vec2 local_px = UV * rect_size_px;
	vec2 center_px = rect_size_px * 0.5;
	vec2 from_center = local_px - center_px;
	float distance_px = length(from_center);
	float distance_from_ring = abs(distance_px - radius_px);
	float ring = 1.0 - smoothstep(ring_thickness_px * 0.35, ring_thickness_px, distance_from_ring);
	float visible_ring = ring * alpha;

	vec2 direction = from_center / max(distance_px, 0.001);
	float ripple = ring;
	vec2 screen_offset = direction * ripple * distortion_strength_px * SCREEN_PIXEL_SIZE;

	vec4 base_color = texture(screen_texture, SCREEN_UV);
	vec4 warped_color = texture(screen_texture, SCREEN_UV - screen_offset);
	vec3 tinted_color = mix(warped_color.rgb, ring_tint.rgb, ring_tint.a * visible_ring);

	COLOR.rgb = mix(base_color.rgb, tinted_color, visible_ring);
	COLOR.a = visible_ring;
}
