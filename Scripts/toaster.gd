extends "res://Scripts/work_stations.gd"


func interact() -> void:
	if object ==null: 
		return 
	if working:
		return
	if object.cooked:
		return
	if !player.pickedup:
		return
	if object.global_type == "slice":
		working = true
		timer.start()
		progress_bar.value = timer.time_left
		progress_bar.show()
		object.global_type = "toast"
		object.carriable = false
		object.hide()
		player.release()
		
		await timer.timeout
		
		progress_bar.hide()
		object.show()
		object.cook()
		working = false
		object.carriable = true
		object.cooked = true


func _process(_delta: float) -> void:
	progress_bar.value = timer.time_left*(100/timer.wait_time)
	#if object != null:
		#print(object.global_type + " on toaster")
