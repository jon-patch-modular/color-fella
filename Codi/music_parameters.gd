extends AudioStreamPlayer


@export var speed_mode : SpeedMode = SpeedMode.boring
var speed_ratios : Dictionary = {
	SpeedMode.boring: 1.0, 
	SpeedMode.vapor: 0.7, 
	SpeedMode.night: 1.2, 
	SpeedMode.help: 2.5, 
	SpeedMode.snooze: 0.4
	}

var speed_scale : float:
	get: return speed_ratios[speed_mode]

enum SpeedMode {
	boring = 0, #Normal speed
	vapor = -1, #Slowed down
	night = 1, #Sped up
	help = 10, #Cocanium overdose
	snooze = -10 #Change the batteries!
}

func _ready() -> void:
	pitch_scale = speed_ratios[speed_mode]
