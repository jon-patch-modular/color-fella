extends Node

@onready var current_tree : SceneTree = $".".get_tree()
@onready var level_restart_timer = $"Level Restart Timer"

var score = 0

func add_score(amt) -> void:
	score += amt
	print("got "+str(amt)+" € - total: " + str(score) + " €") #!DEBUG
	
#This will set the timer to restart the level
func player_death() -> void:
	level_restart_timer.start()


func _on_restart_timeout():
	current_tree.reload_current_scene()
