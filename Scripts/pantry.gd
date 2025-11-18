extends "res://Scripts/work_stations.gd"



func interact() -> void:
	var item = food.instantiate()
	add_child(item)
	cookable_food.find_global_type()
	item.setup(cookable_food.global_type, cookable_food.texture)
