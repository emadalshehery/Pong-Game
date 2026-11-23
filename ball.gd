extends Sprite2D


var velocity = Vector2(20, 12)

var hit_sound = AudioStreamPlayer.new()
var score_sound = AudioStreamPlayer.new()

var score1 = 0
var score2 = 0

var trail = Line2D.new()

var label = Label.new()

@onready var cam = $"../Camera2D"
@onready var p1 = $"../Player1"
@onready var p2 = $"../Player2"

func _ready():
	hit_sound.stream = load("res://hit.wav")
	score_sound.stream = load("res://score.wav")
	add_child(hit_sound)
	add_child(score_sound)
	
	var g = Gradient.new()
	g.set_color(0, Color(3, 0.6, 3, 0))
	g.set_color(1, Color(4, 1, 4, 1))
	trail.gradient = g
	trail.width = 0.8
	get_parent().add_child.call_deferred(trail)
	
	modulate = Color(4, 1, 4)
	
	var layer = CanvasLayer.new()
	
	launch(1)
	add_child(layer)
	layer.add_child(label)
	label.position = Vector2(600, 20)
	label.add_theme_font_size_override("font_size", 48)
	update_label()

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://menu.tscn")
	
	trail.add_point(position)

	if trail.get_point_count() > 20:
		trail.remove_point(0)

	position += velocity * delta

	if velocity.length() < 120:
		velocity *= 1 + 0.15 * delta

	if position.y < -32 or position.y > 32:
		velocity.y = -velocity.y
		hit_sound.play()

	if velocity.x > 0 and hits(p1):
		velocity.x = -velocity.x
		cam.shake(0.4)
		p1.hit()
		hit_sound.play()

	if velocity.x < 0 and hits(p2):
		velocity.x = -velocity.x
		cam.shake(0.4)
		p2.hit()
		hit_sound.play()

	if position.x > 58:
		score2 += 1
		reset()

	elif position.x < -58:
		score1 += 1
		reset()

func hits(paddle):
	return abs(position.x - paddle.position.x) < 1 and abs(position.y - paddle.position.y) < 8

func reset():
	score_sound.play()
	trail.clear_points()
	launch(-sign(velocity.x))
	position = Vector2.ZERO
	velocity.x = -velocity.x
	update_label()
	cam.shake(1.2)

func update_label():
	label.text = str(score2) + " : " + str(score1)

func launch(dir):
	var angle = randf_range(-PI / 3, PI / 3)
	velocity = Vector2(dir, 0).rotated(angle) * 23
