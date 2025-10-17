extends "res://Scripts/work_stations.gd"


func interact() -> void:
	var object = plate.instantiate()
	add_child(object)
	object.setup("plate")
