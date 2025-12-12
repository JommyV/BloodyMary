extends "res://Scripts/work_stations.gd"

var bags_added = 0
@onready var area_2d: Area2D = %Area2D


func interact() -> void:
	if object == null:
		return 

	if object.global_type != "blood_bag":
		return

	if working:
		return

	if object.cooked: 
		return
		
	bags_added += 1
	player.release()
	if bags_added < 3: 
		object.queue_free()
		
	if bags_added == 3:
		working = true
		timer.start()
		progress_bar.value = timer.time_left
		progress_bar.show()
		object.global_type = "cooked_blood"
		object.carriable = false
		area_2d.monitorable = false
		object.hide()
		
		await timer.timeout
		
		area_2d.monitorable = true
		progress_bar.hide()
		object.cook()
		working = false
		object.carriable = true
		object.cooked = true
		bags_added = 0
		object.show()


func _process(_delta: float) -> void:
	progress_bar.value = timer.time_left*(100/timer.wait_time)
	#if object != null:
		#print(object.global_type + " on toaster")
