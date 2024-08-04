class_name HurtReceiverArea
extends Area2D

#Emmagatzema node germà Health quan les escenes estiguin carregades
@onready var health : Health = $"../Health"

func _on_area_entered(hurt : HurtfulArea):
	
	#Nullchecks: 
	if hurt == null: return #check whether we collided with a HurtfulArea
	if health == null: printerr("Missing health component reference"); return #Check for missing health component, print appropiate error message
	
	#INSTAKILL BABY
	if hurt.instakill: 
		health.health = 0 
		return
	
	#Llegeix valor de dany del HurtfulArea i FES DOLOR
	var dmg = hurt.damage
	health.health -= dmg
	
	print("Ouch! " + get_parent().name + " received " + str(dmg) + " damage!")#!DEBUG
