class_name HealthLabel
extends Label

#__references______
@onready var health_mgr: Health = $".."

#__vars______
var health:int 
var max_health : int
var immortal:bool

func _ready() -> void:
	if health_mgr != null:
		health_mgr.health_changed.connect(_on_health_update)
		health_mgr.invincibility_changed.connect(_on_immortal)
	
func _on_health_update(_health: int, _max_health: int, _hurt:bool):
	health = _health
	max_health = _max_health
	
func _on_immortal(lel: bool) -> void:
	immortal = lel
	

func _process(delta: float) -> void:
	text = "health: " + str(health) + ", max: " + str(max_health) +" \n"
	if immortal: text += "invincible"
