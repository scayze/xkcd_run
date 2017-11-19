extends KinematicBody2D

var velocity = Vector2(0,0)
export var jump_height = 300
export var gravity = 13.00
var acceleration = 10

onready var sprite_run = get_node("run")
onready var sprite_jump = get_node("jump")
onready var sprite_eat = get_node("eat")
onready var shape = get_node("CollisionShape2D")

var state = "run"
#onready var anim = get_node("AnimationPlayer")

#TODO: get rid of this
var has_eaten = false

func damage():
	get_parent().restart()
	get_parent().anim.play_backwards("start")

func _ready():
	get_parent().player = self
	change_state("run")
	pass

func change_state(p_state):
	state = p_state
	if state == "run":
		sprite_run.frame = 0
		sprite_run.visible = true
		sprite_jump.visible = false
		sprite_eat.visible = false
	elif state == "jump":
		velocity.y = -jump_height
		sprite_jump.frame = 0
		sprite_run.visible = false
		sprite_jump.visible = true
		sprite_eat.visible = false
	elif state == "eat":
		sprite_eat.frame = 0
		sprite_run.visible = false
		sprite_jump.visible = false
		sprite_eat.visible = true

func _process(delta):
	if Input.is_action_just_pressed("jump") and is_on_floor():
		change_state("jump")
		#anim.play("jump")
	elif Input.is_action_just_pressed("eat") and is_on_floor():
		change_state("eat")
		
	if sprite_eat.frame == 5 and state == "eat" :
		has_eaten = true
	elif sprite_eat.frame == 0 and state == "eat" and has_eaten:
		has_eaten = false
		change_state("run")

func _physics_process(delta):
	velocity.y += gravity
	velocity = move_and_slide(velocity,Vector2(0,-1))
	
	if state == "jump" and is_on_floor():
		change_state("run")

#	if state == "jump" and sprite_jump >= 2:
#		if get_slide_count():
#			for i in range(get_slide_count()):
#				if get_slide_collision(i).collider.is_in_group("platform"): change_state("run")




