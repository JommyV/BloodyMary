extends "res://Scripts/work_stations.gd"



func interact() -> void:
	if object !=null and object.global_type == "eyeball" and !working:
		working = true
		timer.start()
		progress_bar.value = timer.time_left
		object.carriable = false
		player.can_walk = false
		await timer.timeout
		object.global_type = "cut_eyeball"
		object.sprite_2d.texture = preload("res://Assets/Sprites/cuteyeball.png")
		player.release()
		player.can_walk = true
		working = false
		object.carriable = true


func _process(_delta: float) -> void:
	progress_bar.value = timer.time_left*(100/timer.wait_time)
