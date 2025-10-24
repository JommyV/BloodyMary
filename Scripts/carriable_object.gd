extends RigidBody2D

class_name Carriable

@onready var carried : bool = false
@onready var sprite_2d: Sprite2D = %Sprite2D
#Variable that defines the type of food the object is and how it can interact.
var global_type: String

#Defines if object can be carried.
var carriable: bool = true
var cooked: bool = false

#Variable exclusive to the plate to determine if it can pick food. Is stated 
#in the global class so the player can always access it as it is part of the check
#it does when picking up things. If the plate can pickup foods, it takes priority
#over the player dropping the plate. 
var can_pick_food: bool = false

func setup(type:String) -> void:
#Function for the creation of the object by the creation work station.
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

 
func cook() -> void: 
#Centralized Function called externally when the food is prepared. 
#Will cook the food depending on its type. The check to see if the station can 
#cook certain food is made at that station.
	match global_type:
		"eyeball":
			global_type = "cut_eyeball"
			sprite_2d.texture = preload("res://Assets/Sprites/cuteyeball.png")

		"slice":
			global_type = "toast"
			sprite_2d.texture = preload("uid://xgbddpvesgmj")

		"eyeball_on_toast":
			global_type = "eyeball_on_toast"
			sprite_2d.texture = preload("res://Assets/Sprites/eyeballontoast.png")
