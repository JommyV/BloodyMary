extends "res://Scripts/work_stations.gd"


func interact() -> void:
	if object == null:
		return
	if object.global_type != "plate":
		return
	if object.dirty == true:
		player.release()
		object.queue_free()
