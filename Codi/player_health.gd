extends Health

@onready var player_2d = $".."


func _on_ceased_to_be():
	GayManager.player_death()
