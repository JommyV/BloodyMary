extends RigidBody2D

@onready var carried : bool = false
@onready var sprite_2d: Sprite2D = %Sprite2D
var globaltype: String

func setup(type:String) -> void:
	match type:
		"eyeball":
			sprite_2d.texture = preload("uid://dycl41yr58est")
			globaltype = "eyeball"
		"slice":
			sprite_2d.texture = preload("uid://ev6benlbdc5p")
			globaltype = "slice"

func _physics_process(_delta: float) -> void:
	pass
#
#
func cook() -> void: 
	match globaltype:
		"eyeball":
			globaltype = "cut_eyeball"
			sprite_2d.texture = preload("res://Assets/Sprites/cuteyeball.png")
