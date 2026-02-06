extends "res://Scripts/work_stations.gd"

var bags_added = 0
@onready var area_2d: Area2D = %Area2D
@onready var sprite_2d: Sprite2D = $Sprite2D



func interact() -> void:
	if object == null:
		return 
	if object.global_type != "blood_bag" and object.global_type != "spaghetti" and object.global_type != "brain":
		return
	if working:
		return
	if object.cooked: 
		return
	if object.global_type == "blood_bag":
		bags_added += 1
		player.release()
		if bags_added < 3: 
			object.queue_free()
	elif object.global_type == "spaghetti" or object.global_type == "brain":
		player.release()
		prepare_food()
	if bags_added == 3:
		prepare_food();
		


func _process(_delta: float) -> void:
	progress_bar.value = timer.time_left*(100/timer.wait_time)
	#if object != null:
		#print(object.global_type + " on toaster")


func prepare_food() -> void:
	working = true
	timer.start()
	progress_bar.value = timer.time_left
	progress_bar.show()
	match object.global_type:
		"blood_bag":
			object.global_type = "blood_soup"
		"spaghetti":
			object.global_type = "cooked_spaghetti"
		"brain":
			object.global_type = "cooked_brain"
	object.carriable = false
	area_2d.monitorable = false
	object.hide()
	
	await timer.timeout

	sprite_2d.texture = preload("uid://b6435eejjwbjl")
	area_2d.monitorable = true
	progress_bar.hide()
	object.cook()
	working = false
	object.carriable = true
	object.cooked = true
	area_2d.monitorable = true
	bags_added = 0
	object.show()
