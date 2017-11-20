extends Area2D
var scene_explosion = preload("res://Utils/Explosion.tscn")

var damaged = false
var player
onready var sprite = get_node("AnimatedSprite")

func _ready():
	player = get_parent().get_parent().player
	sprite.playing = true

func _physics_process(delta):
	#Body
	if Engine.is_editor_hint(): return
	for body in get_overlapping_bodies():
		if body.is_in_group("player") and damaged == false:
			damaged = true
			var explosion = scene_explosion.instance()
			explosion.position = position + Vector2(0,15)
			get_parent().add_child(explosion)
			queue_free()

func eat():
	get_tree().get_root().get_node("World").score += 250
	print("KFC")
	queue_free()