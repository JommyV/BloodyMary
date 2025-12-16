extends Node
class_name DayManager

#@export var dish1: Resource
#@export var dish2: Resource
#@export var dish3: Resource
#static var popularity = 1
static var menu: Array[Resource]



static func select_daily_menu(dish_1:Resource, dish_2:Resource, dish_3:Resource) -> void:
	var probabilty_1 = 0.50
	var probabilty_2 = 0.25
	var probabilty_3 = 0.25
	dish_1.probabilty = probabilty_1
	dish_2.probabilty = probabilty_2
	dish_3.probabilty = probabilty_3


static func calculate_client_number(popularity: int) -> int:
# Calculates the amount of clients that will come to the restaurant depending on
#the level of popularity decided by the daily manager.
	match popularity:
		1:
			return 10
		2:
			return 15
		3:
			return 20
		4:
			return 30
		5:
			return 40
		_:
			return 0


static func create_menu(_brain, soup, toast) -> Array:
	for i in range(calculate_client_number(1)):  
		var r = randi_range(1,12)
		var dish_in_menu
		match r:
			1,2,3,4,5,6:
				dish_in_menu = toast
			7,8,9:
				dish_in_menu = soup
			10,11,12:
				dish_in_menu = soup
			
		menu.append(dish_in_menu)
		print(menu[i].dish_name)
	return menu
