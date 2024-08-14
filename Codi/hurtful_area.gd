@icon("res://Recursos/GFX/icons/icon_hurtful.png")
class_name HurtfulArea
extends Area2D

##Base damage inflicted on contact with hurt receivers
@export var damage : int = 1

##Whether damage should be inflicted once per collision or continuously during overlap
@export var continuous: bool = false

##Make this mofo ignore health and finish the job in one hit
@export var instakill : bool = false

