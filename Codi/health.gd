@icon("res://icon.svg")
class_name Health
extends Node

#__Events______
signal max_health_changed(amount:int)
signal health_changed(amount:int) 
signal ceased_to_be #fucking dead. Deceased. this is an EX-character.

#__Parameters which might or might not be properties______
@export var max_health: int = 20:
	get:
		return max_health
		
	set(value):
		#Has max health truly changed?
		if value != max_health:
			
			#Emut signal and apply value
			max_health_changed.emit(value - max_health)
			max_health = value
			
			#Make sure to keep health within bounds (upper boundary only :o )
			if health > max_health:
				health = max_health

@export var immortality_time: float = 1.5

#__Internal variables__
@onready var health: int = max_health: #@onready: definida quan max_health ja existeix
	get:
		return health
	set(value):
		#Do not decrease health during invincibility frames
		if value < health && immortal:
			return
		
		#Set health within correct boundaries and store value.
		var clamperino = clampi(value, 0, max_health)
		health = clamperino
		
		print(get_parent().name + "'s current health is " + str(clamperino))
		
		health_changed.emit(clamperino)
		
		#Ask for a refund for this norwegian blue (emit signal and output debug)
		if health == 0:
			print("This is an EX-" + get_parent().name) #DEBUG
			ceased_to_be.emit()

var immortal: bool = false

