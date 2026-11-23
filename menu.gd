extends Control

func _ready():
	set_anchors_preset(PRESET_FULL_RECT)

	var bg = ColorRect.new()
	bg.color = Color(0.156, 0, 0.157)
	bg.set_anchors_preset(PRESET_FULL_RECT)
	add_child(bg)

	var center = CenterContainer.new()
	center.set_anchors_preset(PRESET_FULL_RECT)
	add_child(center)

	var box = VBoxContainer.new()
	box.add_theme_constant_override("separation", 30)
	center.add_child(box)

	var title = TextureRect.new()
	title.texture = load("res://TheGameTitle.png")
	title.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	title.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	title.custom_minimum_size = Vector2(600, 300)
	title.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	box.add_child(title)

	box.add_child(make_button("res://PongMainMenuButtons.png", play))
	box.add_child(make_button("res://QuitButton.png", get_tree().quit))

func make_button(path, action):
	var b = TextureButton.new()
	b.texture_normal = load(path)
	b.ignore_texture_size = true
	b.stretch_mode = TextureButton.STRETCH_KEEP_ASPECT_CENTERED
	b.custom_minimum_size = Vector2(280, 140)
	b.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	b.pressed.connect(action)
	b.mouse_entered.connect(func(): b.modulate = Color(1.4, 1.4, 1.4))
	b.mouse_exited.connect(func(): b.modulate = Color.WHITE)
	return b

func play():
	get_tree().change_scene_to_file("res://game.tscn")
