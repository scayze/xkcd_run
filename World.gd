extends Node

var score = 0
onready var anim = get_node("AnimationPlayer")
onready var music = get_node("music")
onready var background = get_node("background")
onready var l_score = get_node("Score")
var scene_start = preload("res://Parts/Part.tscn")
var player
var speed = 300
var time = 0
var level = 0

var playing = false

var parts_list = []
var parts = []

func restart():
	playing = false
	speed = 0
	level = 0
	for p in parts:
		p.queue_free()
	parts.clear()
	var part = scene_start.instance()
	parts.append(part)
	add_child(part)
	music.reset()
	background.reset()
	spawn_tile()

func cock_block():
	level -= 1
	if level < 0:
		restart()
		anim.play_backwards("start")
	music.set_level(level)
	background.set_level(level)

func level_up():
	speed += 47
	level += 1
	if level > 2: level = 2
	background.set_level(level)
	music.set_level(level)

func start():
	if playing: return
	time = 0
	score = 0
	speed = 300
	print("starting game")
	anim.play("start")
	playing = true

func spawn_tile():
	randomize()
	var rand_idx = rand_range(0,parts_list.size())
	var part = parts_list[rand_idx].instance()
	part.position = Vector2(1024,0)
	parts.append(part)
	add_child(part)
	print("WorldPart spawned")

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
				if file_name != "Part.tscn": parts_list.append(load("res://Parts/" + file_name))
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	pass
	
	restart()


func _process(delta):
	if(playing): 
		time += delta
		if time > 1:
			time = 0 
			score += 10
		l_score.text = "Score: " + str(score)
	
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