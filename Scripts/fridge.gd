extends "res://Scripts/work_stations.gd"


func interact() -> void:
	station_hud.show()


func create_food(type: String) -> void:
	station_hud.hide()
	var item = food.instantiate()
	add_child(item)
	if type == "blood_bag":
		item.setup("blood_bag", preload("res://Assets/Sprites/blood_bag.png"), preload("res://Assets/Sprites/blood_soup_dish.png"))
	elif type == "eyeball":
		item.setup("eyeball", preload("res://Assets/Sprites/eyeball_new.png"), preload("res://Assets/Sprites/cut_eyeball_new.png"))
