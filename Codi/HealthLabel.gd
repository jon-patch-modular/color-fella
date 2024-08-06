class_name HealthLabel
extends Label

@onready var health_mgr: Health = $".."

func _ready() -> void:
	if health_mgr != null:
		health_mgr.health_changed.connect(_on_health_update)
	
func _on_health_update(health: int, max_health: int):
	text = "health: " + str(health) + ", max: " + str(max_health)
