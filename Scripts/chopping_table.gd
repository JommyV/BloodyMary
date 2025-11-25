extends "res://Scripts/work_stations.gd"



func interact() -> void:
	if object !=null and object.global_type == "eyeball" and !working and player.pickedup and !object.cooked:
		working = true
		timer.start()
		progress_bar.value = timer.time_left
		progress_bar.show()
		object.global_type = "cut_eyeball"
		object.carriable = false
		player.can_walk = false
		
		await timer.timeout
		
		progress_bar.hide()
		object.cook()
		player.release()
		player.can_walk = true
		working = false
		object.carriable = true
		object.cooked = true


func _process(_delta: float) -> void:
	progress_bar.value = timer.time_left*(100/timer.wait_time)
