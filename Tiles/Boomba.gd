extends Area2D

var scene_explosion = preload("res://Utils/Explosion.tscn")

var speed = 5

func _physics_process(delta):
	if Engine.is_editor_hint(): return
	position.y += speed * delta
	for overlap in get_overlapping_bodies():
		if overlap.is_in_group("player") or overlap.is_in_group("platform"):
			var explosion = scene_explosion.instance()
			explosion.position = position
			get_parent().add_child(explosion)
			queue_free()
	for overlap in get_overlapping_areas():
		if overlap.is_in_group("player") or overlap.is_in_group("platform"):
			var explosion = scene_explosion.instance()
			explosion.position = position + Vector2(0,43)
			get_parent().add_child(explosion)
			queue_free()
