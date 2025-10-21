extends "res://Scripts/work_stations.gd"


func interact() -> void:
	if object !=null and object.global_type == "slice" and !working:
		working = true
		timer.start()
		progress_bar.value = timer.time_left
		object.carriable = false
		player.release()
		await timer.timeout
		object.global_type = "toast"
		object.sprite_2d.texture = preload("uid://xgbddpvesgmj")
		working = false
		await get_tree().create_timer(0.5).timeout
		object.carriable = true


func _process(_delta: float) -> void:
	progress_bar.value = timer.time_left*(100/timer.wait_time)
	if object != null:
		print(object.global_type + " on toaster")
	else:
		print("not here")
