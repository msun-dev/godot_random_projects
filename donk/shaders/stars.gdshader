//Source: https://godotshaders.com/shader/pixelated-starfield-with-parallax-scrolling-effect/

shader_type canvas_item;

uniform vec2 dimensions = vec2(1024.0, 600.0); // Resolution of ColorRect in pixels

uniform float small_stars = 50.0; // Number of small stars. Rows for horizontally scrolling stars or columns for vertically scrolling stars.
uniform float small_stars_far_size : hint_range(0.1, 1.0, 0.1) = 0.5;
uniform float small_stars_near_size : hint_range(0.1, 1.0, 0.1) = 1.0;
uniform float large_stars = 8.0; // Number of large stars. Rows for horizontally scrolling stars or columns for vertically scrolling stars.
uniform float large_stars_far_size : hint_range(0.1, 1.0, 0.1) = 0.5;
uniform float large_stars_near_size : hint_range(0.1, 1.0, 0.1) = 1.0;

uniform vec4 far_stars_color : source_color = vec4(0.50, 0.0, 1.0, 1.0);
uniform vec4 near_stars_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);

uniform sampler2D small_stars_texture : source_color, filter_nearest_mipmap;
uniform sampler2D large_stars_texture : source_color, filter_nearest_mipmap;

uniform float base_scroll_speed : hint_range(0.0, 1.0, 0.01) = 0.05;
uniform float additional_scroll_speed : hint_range(0.01, 1.0, 0.01) = 0.05;

float greater_than(float x, float y) {
	return max(sign(x - y), 0.0);
}

void fragment() {
	float time = 10000.0 + TIME;

	float small_star_rn = fract(sin(floor(UV.y * small_stars)) * dimensions.y);
	float large_star_rn = fract(sin(floor(UV.y * large_stars)) * dimensions.y);
	vec2 small_star_uv = vec2(fract(UV.x + (base_scroll_speed + small_star_rn * additional_scroll_speed) * time) * small_stars * dimensions.x / dimensions.y, fract(UV.y * small_stars)) * 2.0 - 1.0;
	vec2 large_star_uv = vec2(fract(UV.x + (base_scroll_speed + large_star_rn * additional_scroll_speed) * time) * large_stars * dimensions.x / dimensions.y, fract(UV.y * large_stars)) * 2.0 - 1.0;

	vec4 star_color = mix(far_stars_color, near_stars_color, small_star_rn);
	float star_size = small_stars_far_size + (small_stars_near_size - small_stars_far_size) * small_star_rn;

	COLOR.rgb = mix(COLOR.rgb, star_color.rgb, max((star_size - length(small_star_uv)) / star_size, 0.0) * star_color.a);

	star_color = mix(far_stars_color, near_stars_color, large_star_rn);
	star_size = large_stars_far_size + (large_stars_near_size - large_stars_far_size) * large_star_rn;

	COLOR.rgb = mix(COLOR.rgb, star_color.rgb, 
								(max((star_size / 1.7 - length(large_star_uv)) / star_size, 0.0) + 
								 max((star_size - length(large_star_uv)) / star_size / 2.0, 0.0) * 
								(max(greater_than(star_size / 10.0, abs(large_star_uv.x)), greater_than(star_size / 10.0, abs(large_star_uv.y))))) * 
								 star_color.a);
}
