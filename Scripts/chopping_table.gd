extends "res://Scripts/work_stations.gd"



func interact() -> void:
	if player.carriedobject != null:
		player.carriedobject.cook()
