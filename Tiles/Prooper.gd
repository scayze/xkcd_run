extends Area2D

var scene_bomb = preload("res://Tiles/Boomba.tscn")
export var speed = 100
export var bomb_speed = 250
var has_dropped = false
var player

func _ready():
	player = get_parent().get_parent().player

func drop():
	print("boomba dropped")
	has_dropped = true
	var bomb = scene_bomb.instance()
	get_parent().add_child(bomb)
	bomb.position = position
	bomb.speed = bomb_speed

func _physics_process(delta):
	position.x -= speed*delta
	
	var bomb_dist = abs(position.y - player.position.y) - 30
	var bomb_fall_time = bomb_dist / bomb_speed
	var bomb_travel_length = bomb_fall_time * 250
	var distance = global_position.x - player.global_position.x
	if distance < bomb_travel_length and not has_dropped: drop()

	if Engine.is_editor_hint(): return
	for overlap in get_overlapping_bodies():
		if overlap.is_in_group("player") or overlap.is_in_group("platform"):
			queue_free()
