extends Area2D

func _ready():
	set_physics_process(true)

func effect():
	get_tree().get_root().get_node("World").score += 69
	get_node("AudioStreamPlayer").play()
	print("coin collected")

func _physics_process(delta):
	if Engine.is_editor_hint(): return
	if not monitoring: return
	for overlap in get_overlapping_bodies():
		if overlap.is_in_group("player"):
			effect()
			monitoring = false
			visible = false


