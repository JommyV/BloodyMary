extends RigidBody2D

class_name Carriable

@onready var carried : bool = false
@onready var sprite_2d: Sprite2D = %Sprite2D
var global_type: String
var carriable: bool = true

func setup(type:String) -> void:
	match type:
		"eyeball":
			sprite_2d.texture = preload("uid://dycl41yr58est")
			global_type = "eyeball"
		"slice":
			sprite_2d.texture = preload("uid://ev6benlbdc5p")
			global_type = "slice"
		"plate":
			sprite_2d.texture = preload("uid://ds0sqyxkw86f6")
			sprite_2d.scale = Vector2(0.024,0.024)
			global_type = "plate"
	

func _physics_process(_delta: float) -> void:
	#print(carriable)
	pass

 
func cook() -> void: 
	match global_type:
		"eyeball":
			global_type = "cut_eyeball"
			sprite_2d.texture = preload("res://Assets/Sprites/cuteyeball.png")
		"eyeball_on_toast":
			global_type = "eyeball_on_toast"
			sprite_2d.texture = preload("res://Assets/Sprites/eyeballontoast.png")
