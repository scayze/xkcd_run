extends Node

onready var drums = get_node("drums")
onready var melody = get_node("melody")
onready var rythm1 = get_node("rythm1")
onready var rythm2 = get_node("rythm2")

export var volume = -30
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func reset():
	melody.volume_db = -80
	rythm1.volume_db = -80
	rythm2.volume_db = -80

func set_level(level):
	if level == 1:
		rythm2.volume_db = volume
		rythm1.volume_db = volume
	elif level >= 2: melody.volume_db = volume
