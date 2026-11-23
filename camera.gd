extends Camera2D

var strength = 0.0

func shake(amount):
	strength = amount

func _process(delta):
	strength = move_toward(strength, 0, 4 * delta)
	offset = Vector2(randf_range(-1, 1), randf_range(-1, 1)) * strength
