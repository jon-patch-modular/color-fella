extends Health

#Connecta senyal per codi!!!
func _ready() -> void:
	ceased_to_be.connect(_on_ceased_to_be)

func _on_ceased_to_be() -> void:
	GayManager.player_death()


