extends Area2D

onready var sprite = get_node("AnimatedSprite")
var deal_damage = true

func _ready():
	sprite.frame = 0
	sprite.playing = true
	pass

func _process(delta):
	if sprite.frame < 5 and deal_damage:
		for body in get_overlapping_bodies():
			if body.is_in_group("player"):
				body.damage()

func _on_AnimatedSprite_animation_finished():
	visible = false
