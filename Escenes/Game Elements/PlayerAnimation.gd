extends AnimatedSprite2D

func _process(delta:float) -> void:
	if animation == "Idle":
		speed_scale = MusicPlayer.speed_scale
	else:
		speed_scale = 1
