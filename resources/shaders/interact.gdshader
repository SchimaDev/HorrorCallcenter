shader_type spatial;
uniform float strength;

void fragment() {
	ALBEDO = vec3(0.88, 1.0, 1.0);
	ALPHA = strength;
}
