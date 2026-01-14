extends "res://Scripts/work_stations.gd"


func interact() -> void:
	#station_hud.hide()
	var item = plate.instantiate()
	add_child(item)
	item.sprite_2d.scale.x = 0.005
	item.sprite_2d.scale.y = 0.005
	item.setup(cookable_food.find_global_type(), cookable_food.texture, cookable_food.cooked_texture)
