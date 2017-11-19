extends Area2D

onready var sprite = get_node("AnimatedSprite")
var damage_dealt = false

func _ready():
	sprite.frame = 0
	pass

func _process(delta):
	if sprite.frame == 3: queue_free()
	if sprite.frame < 8 and not damage_dealt:
		for body in get_overlapping_bodies():
			if body.is_in_group("player"):
				body.damage()
				damage_dealt = true
	pass