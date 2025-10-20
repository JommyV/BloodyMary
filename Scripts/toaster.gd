extends "res://Scripts/work_stations.gd"


func interact() -> void:
	if player.carriedobject !=null:
		if player.carriedobject.global_type == "slice":
			player.carriedobject.global_type = "toast"
			player.carriedobject.sprite_2d.texture = preload("uid://xgbddpvesgmj")
			player.release()
