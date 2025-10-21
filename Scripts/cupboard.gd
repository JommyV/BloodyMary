extends "res://Scripts/work_stations.gd"


func interact() -> void:
	var item = plate.instantiate()
	add_child(item)
	item.setup("plate")
