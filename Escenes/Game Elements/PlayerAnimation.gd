class_name PlayerAnimation
extends AnimatedSprite2D

#----References----
@onready var health_mgr: Node2D = $"../Health"

#----Variables----
var hurting : bool = false
var dead_played : bool = false


#----Properties----
@onready var bang_framerate : float:
	# framerate = BPM * 6 frames per beat / 60 seconds per minute
	get: return MusicPlayer.tempo / 10 
	#idea: emetre senyal al canviar el tempo per definir aquesta variable i aplicar-la a la animació

#Play idle if not suffering
func play_safe(animation_name : StringName) -> void:
	if !health_mgr.dead && !hurting:
		play(animation_name)

func _on_health_changed(amount:int, max_amount:int, hurt:bool) -> void:
	if hurt && !dead_played: 
		play("Hurt")
		hurting = true
		
func _on_riperino():
	if !dead_played:
		play("Rip")
		dead_played = true

func _ready() -> void:
	
	#Connecta senyals
	health_mgr.health_changed.connect(_on_health_changed)
	health_mgr.ceased_to_be.connect(_on_riperino)
	
	animation_finished.connect(_on_animation_finished)
	
	#Ajusta animació al mateix tempo que indica el reproductor
	sprite_frames.set_animation_speed("Idle",bang_framerate)

func _process(delta:float) -> void:
	
	#process headbanging
	if animation == "Idle":
		
		#Escala animació amb la mateixa escala que el pitch de la música
		speed_scale = MusicPlayer.speed_scale
	else:
		speed_scale = 1


func _on_animation_finished() -> void:
	if animation == "Hurt":
		hurting = false

