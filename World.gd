extends Node

onready var cam = get_node("Camera")
var score = 0
var highscore = 0
onready var l_score = get_node("Score")
onready var l_highscore = get_node("HighScore")
var scene_start = preload("res://Parts/Part.tscn")
var player
var time = 0

var parts_list = []
var parts = []

func spawn_tile():
	randomize()
	var rand_idx = rand_range(0,parts_list.size())
	var part = parts_list[rand_idx].instance()
	part.position = Vector2(parts[parts.size()-1].position.x + 1024,0)
	parts.append(part)
	add_child(part)
	print("spawned")

func _ready():
	set_process(true)
	var dir = Directory.new()
	if dir.open("res://Parts/") == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while (file_name != ""):
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				print("Found file: " + file_name)
				parts_list.append(load("res://Parts/" + file_name))
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	pass
	
	var part = scene_start.instance()
	parts.append(part)
	add_child(part)

func _process(delta):
	time += delta
	score = int(time)
	if highscore < score: score = highscore 
	cam.position = Vector2(player.position.x-150,1)
	if player.global_position.x > parts[parts.size()-1].global_position.x - 512:
		spawn_tile()
	pass
