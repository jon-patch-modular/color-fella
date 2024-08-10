extends Health
@onready var player_2d: Player = $".."

#Connecta senyal per codi!!!
func _ready() -> void:
	ceased_to_be.connect(_on_ceased_to_be)
	

func _on_ceased_to_be() -> void:
	
	GayManager.player_death()
	if player_2d != null:
		player_2d._on_fucking_dead()


