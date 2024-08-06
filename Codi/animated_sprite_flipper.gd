extends AnimatedSprite2D

func _ready() -> void:
	var parent = $".."
	if parent.has_signal("flipped"):
		parent.flipped.connect(_on_flipped)
		print("connected!!!!!!")
	

func _on_flipped(direction : int):
	if direction >= 0: flip_h = false
	else: flip_h = true
