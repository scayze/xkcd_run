extends StaticBody2D
tool

onready var sprite = get_node("Sprite")
onready var shape = get_node("CollisionShape2D")
onready var bomb_shape = get_node("Area2D/CollisionShape2D")

export var size = 32 setget set_platform_size
var player = null

func _ready():
	shape.shape = SegmentShape2D.new()
	set_platform_size(size)
	player = get_tree().get_root().get_node("World").player
	pass

func _physics_process(delta):
	if Engine.is_editor_hint(): return
	if player.position.y + player.get_node("CollisionShape2D").shape.extents.y > position.y: shape.disabled = true
	else: shape.disabled = false

func set_platform_size(p_size):
	size = p_size
	if not sprite: return
	sprite.region_rect = Rect2(0,0,size,4)
	shape.shape.a = Vector2((size*3.0/2.0),0)
	shape.shape.b = Vector2(-(size*3.0/2.0),0)
	bomb_shape.shape.a = shape.shape.a
	bomb_shape.shape.b = shape.shape.b
	#shape.shape.normal.y = (size/64)
	#shape.shape.extents.x = size * 3.0 / 2.0
