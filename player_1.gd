extends Sprite2D

@export var up = "Up1"
@export var down = "Down1"

var max_speed = 100
var acceleration = 200
var friction = 300
var velocity = 0.0

func _ready():
	modulate = Color(3, 0.6, 3)

func _process(delta):
	var target = Input.get_axis(up, down) * max_speed
	var rate = acceleration if target != 0 else friction
	velocity = move_toward(velocity, target, rate * delta)
	position.y = clamp(position.y + velocity * delta, -25, 25)
	if abs(position.y) == 25:
		velocity = 0

func hit():
	scale.x = 2.0
	modulate = Color(6, 4, 6)
	var t = create_tween().set_parallel()
	t.tween_property(self, "scale:x", 1.0, 0.2)
	t.tween_property(self, "modulate", Color(3, 0.6, 3), 0.2)
