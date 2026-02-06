extends "res://Scripts/work_stations.gd"



func interact() -> void:
	hud.show()
	player.can_walk = false
	


func create_food(type: String) -> void:
	player.can_walk = true
	hud.hide()
	var item = food.instantiate()
	add_child(item)
	
	if type == "slice":
		item.setup("slice", preload("uid://ddogcrbdfu27y"), preload("uid://dfvhsrhx0w0xi"))
	elif type == "spaghetti":
		item.setup("spaghetti", preload("uid://dub0ru24114re"),preload("uid://b4r3w65f0ycno"))
