@icon("res://Recursos/sprites/icons/icon_health.png")
class_name Health
extends Node2D

#__Events______
signal health_changed(health:int, max_health:int) 
signal ceased_to_be 


#__Parameters
@export var max_health: int = 20:
	get:
		return max_health
		
	set(value):
		#Has max health truly changed?
		if value != max_health:
			
			#Emut signal and apply value
			health_changed.emit(health, max_health)
			max_health = value
			
			#Make sure to keep health within bounds (upper boundary only :o )
			if health > max_health:
				health = max_health

@export var immortality_time: float = 1.5

#__Internal variables__
@onready var health: int = max_health: #@onready: definida quan max_health ja existeix
	get: return health
	
	set(value):
		#Do not decrease health during invincibility frames
		if value < health && immortal:
			return
		
		#Set health within correct boundaries and store value.
		var clamperino = clampi(value, 0, max_health)
		health = clamperino
		
		print(get_parent().name + "'s current health is " + str(clamperino))
		
		health_changed.emit(health, max_health)
		
		#Ask for a refund for this norwegian blue (emit signal and output debug)
		if health == 0:
			print("This is an EX-" + get_parent().name) #DEBUG
			ceased_to_be.emit()

func _ready() -> void:
	health_changed.emit(health, max_health) #initialize health stuffs
	
var immortal: bool = false

