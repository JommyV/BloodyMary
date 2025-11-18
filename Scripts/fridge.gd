extends "res://Scripts/work_stations.gd"


func interact() -> void:
	var item = food.instantiate()
	add_child(item)
	item.setup(cookable_food.find_global_type(), cookable_food.texture)
