extends Node
class_name DayManager

#@export var dish1: Resource
#@export var dish2: Resource
#@export var dish3: Resource
static var popularity_global = 1
static var menu: Array[Resource]


#func _ready() -> void:
	#popularity_global = global_data_manager.popularity


#static func select_daily_menu(dish_1:Resource, dish_2:Resource, dish_3:Resource) -> void:
	#var probabilty_1 = 0.50
	#var probabilty_2 = 0.25
	#var probabilty_3 = 0.25
	#dish_1.probabilty = probabilty_1
	#dish_2.probabilty = probabilty_2
	#dish_3.probabilty = probabilty_3


static func calculate_client_number() -> int:
# Calculates the amount of clients that will come to the restaurant depending on
#the level of popularity decided by the daily manager.
	match floorf(popularity_global):
		1.0:
			return 4
		2.0:
			return 15
		3.0:
			return 20
		4.0:
			return 30
		5.0:
			return 40
		_:
			return 40


static func create_menu(brain, soup, toast) -> Array:
	for i in range(calculate_client_number()):  
		var rng = RandomNumberGenerator.new()
		var my_array = [brain, soup, toast]
		var weights = PackedFloat32Array([0.4, 0.3, 0.3])
		menu.append(my_array[rng.rand_weighted(weights)])
		print(menu[i].dish_name)
	return menu
