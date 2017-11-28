extends KinematicBody2D

var velocity = Vector2(0,0)
export var jump_height = 300
export var gravity = 130.00
var acceleration = 10

var time_till_jump = 0
var time_till_hit = 0
export var invincible_period = 0.33

onready var kick_area = get_node("kick/Area2D")
onready var eat_area = get_node("eat/Area2D")
onready var sprite_kick = get_node("kick")
onready var sprite_run = get_node("run")
onready var sprite_jump = get_node("jump")
onready var sprite_eat = get_node("eat")
onready var sound_jump = get_node("sound_jump")
onready var sound_eat = get_node("sound_eat")
onready var shape = get_node("shape")

var state = "run"

func damage():
	if time_till_hit < invincible_period: return
	time_till_hit = 0
	get_parent().cock_block()

func _ready():
	get_parent().player = self
	change_state("run")
	sprite_run.playing = true
	sprite_jump.playing = true
	sprite_eat.playing = true
	sprite_kick.playing = true
	pass

func change_state(p_state):
	state = p_state
	if state == "run":
		sprite_run.frame = 0
		sprite_run.visible = true
		sprite_jump.visible = false
		sprite_eat.visible = false
		sprite_kick.visible = false
	elif state == "jump":
		sound_jump.play()
		velocity.y = -15
		time_till_jump = 0
		sprite_jump.frame = 0
		sprite_run.visible = false
		sprite_jump.visible = true
		sprite_eat.visible = false
		sprite_kick.visible = false
	elif state == "eat":
		sound_eat.play()
		sprite_eat.frame = 0
		sprite_run.visible = false
		sprite_jump.visible = false
		sprite_eat.visible = true
		sprite_kick.visible = false
	elif state == "kick":
		sprite_kick.frame = 0
		sprite_run.visible = false
		sprite_jump.visible = false
		sprite_eat.visible = false
		sprite_kick.visible = true

func _process(delta):
	time_till_hit += delta
	time_till_jump += delta
	if Input.is_action_just_pressed("jump") and is_on_floor():
		change_state("jump")
	elif Input.is_action_just_pressed("eat") and is_on_floor() and state != "eat":
		change_state("eat")
	elif Input.is_action_just_pressed("flick") and state != "kick":
		change_state("kick")
	
	if Input.is_action_pressed("stomp"):
		velocity.y += 2200 * delta
	
	if Input.is_action_pressed("jump") :
		if time_till_jump < 0.15 and velocity.y < 0:
			velocity.y -= jump_height * delta * (0.16/(0.01+time_till_jump))
		else:
			time_till_jump = 1


func _physics_process(delta):
	
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity,Vector2(0,-1))
	
	
	if state == "jump" and is_on_floor():
		change_state("run")
	
	if (sprite_kick.frame == 3 or sprite_kick.frame == 4) and state == "kick":
		for area in kick_area.get_overlapping_areas():
			if area.is_in_group("bomb"):
				area.hit_back()
	if (sprite_eat.frame == 4 or sprite_eat.frame == 5) and state == "eat":
		for area in eat_area.get_overlapping_areas():
			if area.is_in_group("chicken"):
				area.eat()


func _on_kick_animation_finished():
	if state == "kick":
		change_state("run")

func _on_eat_animation_finished():
	if state == "eat":
		change_state("run")
