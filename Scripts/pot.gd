extends "res://Scripts/work_stations.gd"

var bags_added = 0


func interact() -> void:
	if object !=null and object.global_type == "blood_bag" and !working and player.pickedup and !object.cooked and bags_added <2:
		bags_added += 1
		player.release()
		object.queue_free()
		
		
	elif object !=null and object.global_type == "blood_bag" and !working and player.pickedup and !object.cooked and bags_added ==2:
		working = true
		timer.start()
		progress_bar.value = timer.time_left
		progress_bar.show()
		object.global_type = "cooked_blood"
		object.carriable = false
		player.release()
		
		await timer.timeout
		
		progress_bar.hide()
		object.cook()
		working = false
		object.carriable = true
		object.cooked = true


func _process(_delta: float) -> void:
	progress_bar.value = timer.time_left*(100/timer.wait_time)
	#if object != null:
		#print(object.global_type + " on toaster")
