extends Node
class_name DayManager

#@export var dish1: Resource
#@export var dish2: Resource
#@export var dish3: Resource
static var popularity_global = 1
static var menu: Array[Resource]
static var clients_left: int

func _ready() -> void:
	clients_left = calculate_client_number()
	print("I have clients: " + str(clients_left))


static func calculate_client_number() -> int:
# Calculates the amount of clients that will come to the restaurant depending on
#the level of popularity decided by the daily manager.
	match floorf(popularity_global):
		1.0:
			return 10
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


static func create_menu(_brain, soup, toast) -> Array:
	for i in range(calculate_client_number()):  
		var rng = RandomNumberGenerator.new()
		var my_array = [soup, toast]
		var weights = PackedFloat32Array([0.5, 0.5])
		menu.append(my_array[rng.rand_weighted(weights)])
		#print(menu[i].dish_name)
	return menu
