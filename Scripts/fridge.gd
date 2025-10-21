extends "res://Scripts/work_stations.gd"


func interact() -> void:
	var item = food.instantiate()
	add_child(item)
	item.setup("eyeball")
