extends Area2D

func _physics_process(delta):
	if Engine.is_editor_hint(): return
	for body in get_overlapping_bodies():
		if body.is_in_group("player"):
			body.damage()