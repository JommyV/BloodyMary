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
	match food:
		types.BREAD:
			global_type = "slice"

		types.BRAIN:
			global_type = "brain"

		types.BLOOD:
			global_type = "blood"

		types.EYEBALL:
			global_type = "eyeball"

		types.SPAGHETTI: 
			global_type = "spaghetti"

		types.PLATE: 
			global_type = "plate"

		_:
			global_type = "error"
	return global_type
