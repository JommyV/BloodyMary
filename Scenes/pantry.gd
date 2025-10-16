extends "res://Scripts/work_stations.gd"



func interact() -> void:
	var object = food.instantiate()
	add_child(object)
	object.setup("eyeball")
