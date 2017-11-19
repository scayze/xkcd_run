extends Area2D

func _physics_process(delta):
	if Engine.is_editor_hint(): return
	for overlap in get_overlapping_bodies():
		if overlap.is_in_group("player"):
			if has_method("effect"): effect()
			queue_free()
