extends CharacterBody2D

const speed = 30

var dir = 1;
var flip_str = 0.2;

var res: float = 3
var true_position: Vector2

@onready var ray_cast_2d_right: RayCast2D = $"RayCast2D right"
@onready var ray_cast_2d_lfet: RayCast2D = $"RayCast2D lfet"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	true_position = position
	res = clamp(res, 0.1, 100)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var tdir = dir
	if ray_cast_2d_right.is_colliding():
		tdir = -1
	
	if ray_cast_2d_lfet.is_colliding():
		tdir = 1
	
	dir += tdir * delta
	dir = clamp(dir,-1, 1)
	
	animated_sprite_2d.flip_h = true if dir >= 0 else false
	
	true_position.x += speed * dir * delta
	position.x = roundi(true_position.x / res) * res
