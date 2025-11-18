extends Resource
class_name food_type

var global_type: String  = "default"

@export var food: types

@export var texture: Texture2D

@export var cookable: bool

@export var cooked_texture: Texture2D


enum types {
	BREAD,
	BRAIN,
	BLOOD,
	EYEBALL,
	SPAGHETTI,
	PLATE,
}

func find_global_type() -> String:
	match types:
		0:
			global_type = "slice"
			return global_type
		1:
			global_type = "brain"
			return global_type
		2:
			global_type = "blood"
			return global_type
		3:
			global_type = "eyeball"
			return global_type
		4: 
			global_type = "spaghetti"
			return global_type
		5: 
			global_type = "plate"
			return global_type
		_:
			return "error"
