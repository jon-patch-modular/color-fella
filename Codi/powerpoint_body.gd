extends CharacterBody2D
##A character body that moves on discrete increments like a Game&Watch character.
class_name PowerpointBody

#-----parameters-----
##How far does this fella have to move for its position to update?
@export var chonk_length : Vector2 = Vector2(5,5) 

@export var chonkize_x : bool = true ##False: move continuously. True: Chonkin' time
@export var chonkize_y : bool = true ##False: move continuously. True: Chonkin' time

#-----variables-----
@onready var true_position : Vector2
var initialized : bool = false

func _ready() -> void:
	true_position = position
	
	chonk_length.x = clamp(chonk_length.x, 0.1, 42069) #AVOID ZERO OR THE UNIVERSE CRASHES!
	chonk_length.y = clamp(chonk_length.y, 0.1, 42069) #AVOID ZERO OR THE UNIVERSE CRASHES
	
	initialized = true

##Call this function from _physics_process(delta) once you're done updating its position.
func chonk_move():
	if !initialized: return
	
	#Update X position
	if chonkize_x:
		position.x = roundi(true_position.x / chonk_length.x) * chonk_length.x
	else:
		position.x = true_position.x
	
	#Update Y position
	if chonkize_y:
		position.y = roundi(true_position.y / chonk_length.y) * chonk_length.y
	else:
		position.y = true_position.y
