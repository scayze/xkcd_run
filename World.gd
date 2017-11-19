extends Node

var score = 0
var highscore = 0
onready var anim = get_node("AnimationPlayer")
onready var l_score = get_node("Score")
onready var l_highscore = get_node("HighScore")
var scene_start = preload("res://Parts/Part.tscn")
var player
var speed = 250
var time = 0

var playing = false

var parts_list = []
var parts = []

func restart():
	playing = false
	var part = scene_start.instance()
	parts.append(part)
	add_child(part)
	spawn_tile()


func start():
	print("s")
	if playing: return
	time = 0
	score = 0
	speed = 250
	anim.play("start")
	playing = true

func spawn_tile():
	randomize()
	var rand_idx = rand_range(0,parts_list.size())
	var part = parts_list[rand_idx].instance()
	part.position = Vector2(1024,0)
	parts.append(part)
	add_child(part)
	print("spawned")

func _ready():
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
	
	restart()


func _process(delta):
	if(playing): 
		time += delta
		speed += delta
		score = int(time)
		l_score.text = str(score)
	if highscore < score: score = highscore 
	
	if Input.is_action_just_pressed("start"):
		start()
	
	var spawned = false
	for part in parts:
		if(playing): part.position.x -= delta * speed
		if part.position.x < -1024:
			part.queue_free()
			spawn_tile()
			spawned = true
	if spawned: parts.remove(0)