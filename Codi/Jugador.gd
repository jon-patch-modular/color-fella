class_name Player
extends CharacterBody2D

var alive : bool = true
const SPEED = 115.0
const JUMP_VELOCITY = -318.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var falldown = false
var jumped = false

@onready var player_animation: PlayerAnimation = $AnimatedSprite2D



func _physics_process(delta):
	
	#Fall down if on air
	if not is_on_floor():
		velocity.y += gravity * delta
		
	#Dead people aren't supposed to move
	if !alive: return #lmao
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() and alive:
		velocity.y = JUMP_VELOCITY

	#Get dat input
	var direction = Input.get_axis("move_left", "move_right")
	
	#Orient sprite TODO: idea - canviar per senyals i reorientar per script al propi AnimatedSprite
	if direction > 0 && alive:
		player_animation.flip_h = false
	elif direction < 0 && alive:
		player_animation.flip_h = true
	
	
	#Choose animations for floor
	if(is_on_floor()):
		
		jumped = false
		falldown = false
		
		if direction == 0:
			player_animation.play_safe("Idle")
		else:
			player_animation.play_safe("Run")
		
	#choose animations for air
	else:
		#animate falling
		if velocity.y >= 0 && !falldown:
			player_animation.play_safe("Jump Down")
			
			falldown = true
			jumped = false
			
		#animate jumping
		elif velocity.y < 0 && !jumped:
			player_animation.play_safe("Jump Up")
			
			jumped = true
			falldown = false
	
	#Process Physisc
	if direction && alive:
		velocity.x = direction * SPEED #delta és usat automàticament per Character2D
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	

	move_and_slide()

func _on_fucking_dead() -> void:
	alive = false
