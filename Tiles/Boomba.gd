extends Area2D

var scene_explosion = preload("res://Utils/Explosion.tscn")

var speed

func hit_back():
	if speed < 0: return
	speed = -350

func _physics_process(delta):
	if Engine.is_editor_hint(): return
	position.y += speed * delta
	for body in get_overlapping_bodies():
		if body.is_in_group("player") or body.is_in_group("platform"):
			spawn_explosion()
			queue_free()
	for area in get_overlapping_areas():
		if area.is_in_group("platform"):
			spawn_explosion()
			queue_free()

func spawn_explosion():
	var explosion = scene_explosion.instance()
	explosion.position = position + Vector2(0,43)
	get_parent().add_child(explosion)