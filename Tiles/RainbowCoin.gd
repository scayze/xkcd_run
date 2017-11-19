extends Area2D

func _ready():
	set_physics_process(true)

func effect():
	get_tree().get_root().get_node("World").score += 666
	get_tree().get_root().get_node("World").level_up()
	print("rainbow coin collected")

func _physics_process(delta):
	if Engine.is_editor_hint(): return
	for overlap in get_overlapping_bodies():
		if overlap.is_in_group("player"):
			effect()
			queue_free()