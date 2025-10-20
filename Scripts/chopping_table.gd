extends "res://Scripts/work_stations.gd"


func interact() -> void:
	if player.carriedobject !=null:
		if player.carriedobject.global_type == "eyeball":
			player.carriedobject.global_type = "cut_eyeball"
			player.carriedobject.sprite_2d.texture = preload("res://Assets/Sprites/cuteyeball.png")
			player.release()
