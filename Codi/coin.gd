extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer



func _on_body_entered(_body):
	GayManager.add_score(1)
	animation_player.play("lmao")
