extends Health

#@onready var player_2d = $".."
@onready var health_debug_label : Label = $"../debug_stats_labels/health_debug"
@onready var max_debug_label : Label = $"../debug_stats_labels/max_health_debug"



func _on_ceased_to_be() -> void:
	GayManager.player_death()

func _ready() -> void:
	_on_health_changed(health)
	_on_max_health_changed(max_health)

func _on_health_changed(amount) -> void:
	health_debug_label.text = "health: " + str(health)

func _on_max_health_changed(amount) -> void:
	max_debug_label.text = "max: " + str(max_health)
