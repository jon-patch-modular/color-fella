extends AnimatedSprite2D

#calculate framerate from beatrate
@onready var bang_framerate : float:
	# framerate = BPM * 6 frames per beat / 60 seconds per minute
	get: return MusicPlayer.tempo / 10 
	#idea: emetre enyal al canviar el tempo per definir aquesta variable i aplicar-la a la animació

func _ready() -> void:
	
	#Ajusta animació al mateix tempo que indica el reproductor
	sprite_frames.set_animation_speed("Idle",bang_framerate)

func _process(delta:float) -> void:
	if animation == "Idle":
		
		#Escala animació amb la mateixa escala que el pitch de la música
		speed_scale = MusicPlayer.speed_scale
	else:
		speed_scale = 1
