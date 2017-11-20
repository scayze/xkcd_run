extends Node2D

onready var flame  = get_node("Area2D")

var player

func _ready():
	player = get_parent().get_parent().player

func _physics_process(delta):
	#Flame
	for body in flame.get_overlapping_bodies():
		if body.is_in_group("player"):
			player.damage()