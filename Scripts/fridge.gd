extends "res://Scripts/work_stations.gd"


func interact() -> void:
	player.can_walk = false
	hud.show()


func create_food(type: String) -> void:
	player.can_walk = true
	hud.hide()
	var item = food.instantiate()
	add_child(item)
	if type == "blood_bag":
		item.setup("blood_bag", preload("res://Assets/Sprites/blood_bag.png"), preload("res://Assets/Sprites/blood_soup_dish.png"))
	if type == "eyeball":
		item.setup("eyeball", preload("res://Assets/Sprites/eyeball_new.png"), preload("res://Assets/Sprites/cut_eyeball_new.png"))
	if type == "brain":
		item.setup("brain", preload("uid://b5yri07n2cpwb"), preload("uid://bjpcr45vgpxur"))
