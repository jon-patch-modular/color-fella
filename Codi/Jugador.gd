class_name Player
extends CharacterBody2D

var alive : bool = true
const SPEED = 115.0
const JUMP_VELOCITY = -318.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var falldown = false
var jumped = false

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta):
	if not is_on_floor():
		# Add the gravity.
		velocity.y += gravity * delta
		

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() and alive:
		velocity.y = JUMP_VELOCITY

	#Get dat input
	var direction = Input.get_axis("move_left", "move_right")
	
	#Orient sprite TODO: idea - canviar per senyals i reorientar per script al propi AnimatedSprite
	if direction > 0 && alive:
		animated_sprite.flip_h = false
	elif direction < 0 && alive:
		animated_sprite.flip_h = true
	
	if !alive: return #lmao
	
	#Choose animations for floor
	if(is_on_floor()):
		
		jumped = false
		falldown = false
		
		if direction == 0:
			animated_sprite.play("Idle")
		else:
			animated_sprite.play("Run")
		
	#choose animations for air
	else:
		#animate falling
		if velocity.y >= 0 && !falldown:
			animated_sprite.play("Jump Down")
			
			falldown = true
			jumped = false
			
		#animate jumping
		elif velocity.y < 0 && !jumped:
			animated_sprite.play("Jump Up")
			
			jumped = true
			falldown = false
	
	#Process Physisc
	if direction && alive:
		velocity.x = direction * SPEED #delta és usat automàticament per Character2D
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	

	move_and_slide()

#detect death idk
func _on_rip() -> void:
	alive = false
	animated_sprite.play("Die Lmao")
