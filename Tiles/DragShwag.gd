extends StaticBody2D

onready var flame  = get_node("Area2D")

func _physics_process(delta):
	#Flame
	for body in flame.get_overlapping_bodies():
		if body.is_in_group("player"):
			body.damage()