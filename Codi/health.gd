@icon("res://Recursos/sprites/icons/icon_health.png")
class_name Health
extends Node2D

#__Events______
signal health_changed(health:int, max_health:int, hurt:bool) 
signal ceased_to_be
signal invincibility_changed(invincible:bool)

#__references______
var inv_timer : Timer

#__Parameters
@export var max_health: int = 20:
	get:
		return max_health
		
	set(value):
		#Has max health truly changed?
		if value != max_health:
			
			#Emut signal and apply value
			health_changed.emit(health, max_health, false)
			max_health = value
			
			#Make sure to keep health within bounds (upper boundary only :o )
			if health > max_health:
				health = max_health

@export var immortality_time: float = 1.5

#__Internal variables__
@onready var dead : bool:
	get:
		if health <= 0: return true
		else: return false

@onready var health: int = max_health: #@onready: definida quan max_health ja existeix
	get: return health
	
	set(value):
		var hurt: bool = false
		#Have we been hurt?
		if value < health:  
			#no you don't
			if immortal: return
			
			#OUCH
			else: 
				hurt = true
				immortal = true
		
		#Set health within correct boundaries and store value.
		var clamperino = clampi(value, 0, max_health)
		health = clamperino
		
		print(get_parent().name + "'s current health is " + str(clamperino))
		
		health_changed.emit(health, max_health, hurt)
		
		#Ask for a refund for this norwegian blue (emit signal and output debug)
		if health == 0:
			print("This is an EX-" + get_parent().name) #DEBUG
			ceased_to_be.emit()

var immortal: bool = false:
	get: return immortal
	set(lmao):
		immortal = lmao
		invincibility_changed.emit(true)
		if inv_timer != null: inv_timer.start(immortality_time)

#__callbacks______

func _ready() -> void:
	health_changed.emit(health, max_health) #initialize health stuffs
	
	inv_timer = init_timer() #create immortality timer	

#called when you're no longer immortal my dude lmao
func _on_timerino() -> void:
	immortal = false
	invincibility_changed.emit(false)

#__internal meth______
func init_timer() -> Timer:
	
	#hopefully instantiate and set up a child timer
	var timerino = Timer.new()
	timerino.one_shot = true
	
	#Connect the timer and its callback
	add_child(timerino)
	timerino.timeout.connect(_on_timerino)
	
	return timerino
