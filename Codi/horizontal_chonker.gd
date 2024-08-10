class_name HorizontalChonker
extends PowerpointBody

#-----signals-----
##Emitted any time this chonker faceplants an obstacle
signal flipped(direction : int)

#-----parameters-----
##rate of change of internal continuous position, in pixels per second
@export var movement_speed : float = 30

##What direction is this MF moving towards? Decimal values reduce speed.
@export var direction : float = 1

##How fast should this fucker turn around?
@export var acceleration : float = 1


#-----properties-----
##Durection but with magnitude 1
var normalized_direction: int:
	get: 
		if direction >= 0: return 1
		else: return -1
		


#references------
@onready var ray_cast_2d_r: RayCast2D = $"RayCast2D R"
@onready var ray_cast_2d_l: RayCast2D = $"RayCast2D L"

#----variables----
@onready var previous_direction : int
@onready var target_direction : int = normalized_direction

func _ready() -> void:
	#initialize stuffs
	flipped.emit(normalized_direction)
	super()

func _physics_process(delta:float) -> void:
	#keep track of previous direction, compare to current
	if previous_direction == -normalized_direction:
		flipped.emit(normalized_direction)
	
	previous_direction = normalized_direction
	
	#flip on raycast hit only if facing that direction (with nullchecks)
	if ray_cast_2d_r == null: printerr(name + " is missing right raycast!")
	elif ray_cast_2d_r.is_colliding() && target_direction == 1:
		target_direction = -1
	
	if ray_cast_2d_l == null: printerr(name + " is missing left raycast!")
	elif ray_cast_2d_l.is_colliding() && direction == -1:
		target_direction = 1
	
	#Change direction gradually to turn around smoothly (if you can call this smooth lmao)
	direction += target_direction * acceleration * delta	
	direction = clampf(direction, -1, 1)
		
	
	#Move this son of a bitch
	true_position.x += movement_speed * direction * delta
	chonk_move()
