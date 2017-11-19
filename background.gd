extends Node

onready var rainbow = get_node("rainbow")
onready var black_white = get_node("white")
export var rot_speed = 1
var level = 0

func reset():
	level = 0
	black_white.visible = false
	rainbow.visible = false

func _process(delta):
	black_white.rotate(rot_speed*delta)
	rainbow.rotate(rot_speed*delta)

func up():
	level += 1
	if level == 1:
		black_white.visible = true
		rainbow.visible = false
	elif level >= 2:
		black_white.visible = false
		rainbow.visible = true