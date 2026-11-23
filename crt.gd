extends CanvasLayer

func _ready():
	var shader = Shader.new()
	shader.code = """
shader_type canvas_item;
uniform sampler2D screen_tex : hint_screen_texture, filter_linear;

void fragment() {
	vec2 uv = SCREEN_UV;
	vec3 col;
	col.r = texture(screen_tex, uv + vec2(0.002, 0.0)).r;
	col.g = texture(screen_tex, uv).g;
	col.b = texture(screen_tex, uv - vec2(0.002, 0.0)).b;
	col *= 0.85 + 0.15 * sin(uv.y * 720.0 * 3.14159);
	col *= 1.0 - distance(uv, vec2(0.5)) * 0.8;
	COLOR = vec4(col, 1.0);
}
"""
	var mat = ShaderMaterial.new()
	mat.shader = shader
	var rect = ColorRect.new()
	rect.material = mat
	rect.set_anchors_preset(Control.PRESET_FULL_RECT)
	rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(rect)
