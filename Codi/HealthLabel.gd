class_name HealthLabel
extends Label

@onready var health: Health = $".."

func _ready() -> void:
	if health != null:
		health.health_changed.connect(_on_health_update)
	
func _on_health_update(health: int, max_health: int):
	text = "health: " + str(health) + ", max: " + str(max_health)
