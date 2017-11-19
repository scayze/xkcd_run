extends Area2D

func check():
	if Engine.is_editor_hint(): return
	for overlap in get_overlapping_bodies():
		if overlap.is_in_group("player"):
			if has_method("effect"): effect()
			queue_free()
