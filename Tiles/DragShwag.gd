extends Area2D

var scene_explosion = preload("res://Utils/Explosion.tscn")
onready var flame  = get_node("Area2D")

func _physics_process(delta):
	#Flame
	for body in get_overlapping_bodies():
		if body.is_in_group("player"):
			body.change_state("jump")
			body.velocity.y = -1000
			spawn_explosion()
			queue_free()
	for body in flame.get_overlapping_bodies():
		if body.is_in_group("player"):
			body.damage()

func spawn_explosion():
	var explosion = scene_explosion.instance()
	explosion.position = position + Vector2(5,50)
	get_parent().add_child(explosion)