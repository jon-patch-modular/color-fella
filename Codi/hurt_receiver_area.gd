@icon("res://Recursos/GFX/icons/icon_hurtable.png")
class_name HurtReceiverArea
extends Area2D

#__references______
@onready var health : Health = $"../Health"

#Connecta senyal
func _ready() -> void:
	if !area_entered.is_connected(_on_area_entered): area_entered.connect(_on_area_entered)
	
	#TODO: Continuous overlap
	

func _on_area_entered(hurt : HurtfulArea):
	#Checks
	if hurt == null: return 
	if hurt.continuous: return
	
	do_damage(hurt)

#TODO
func _on_area_stayed(hurt: HurtfulArea):
	#Checks
	if hurt == null: return
	if !hurt.continuous: return
	
	do_damage(hurt)
	
func do_damage(hurt: HurtfulArea) -> void:
	#Nullchecks: 
	
	if health == null: printerr(get_parent().name + ": Missing health component reference"); return 
	
	
	#INSTAKILL BABY
	if hurt.instakill: 
		health.health = 0 
		return
	
	#Llegeix valor de dany del HurtfulArea i FES DOLOR
	var dmg = hurt.damage
	health.health -= dmg
	
	print("Ouch! " + get_parent().name + " received " + str(dmg) + " damage!")#!DEBUG
