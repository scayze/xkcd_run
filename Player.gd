extends KinematicBody2D

var velocity = Vector2(0,0)
export var jump_height = 300
export var gravity = 13.00
var acceleration = 10

onready var sprite = get_node("Sprite")
onready var shape = get_node("CollisionShape2D")
onready var anim = get_node("AnimationPlayer")

func _ready():
	get_parent().player = self
	velocity.x = 150
	pass

func _process(delta):
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_height
		#anim.play("jump")
	elif Input.is_action_just_pressed("eat"):
		pass#anim.play("eat")

func _physics_process(delta):
	
	velocity.x += acceleration *delta
	velocity.y += gravity
	
	velocity = move_and_slide(velocity,Vector2(0,-1))

