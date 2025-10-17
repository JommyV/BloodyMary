extends "res://Scripts/carriable_object.gd"

var ingredient1: Node2D
var ingredient2: Node2D


func prepare_food():
	match ingredient1.global_type and ingredient2.global_type:
		"eyeball", "toast":
				ingredient2.queue_free()
				ingredient1.global_type = "eyeball_on_toast"
	
	


func _on_area_2d_area_entered(area: Area2D) -> void:
	if ingredient1 == null and area.get_parent().is_in_group("Interactible"):
		ingredient1 = area.get_parent()
	else:
		ingredient2 = area.get_parent()

func _on_area_2d_area_exited(area: Area2D) -> void:
	pass # Replace with function body.
	

func _process(delta: float) -> void:
	if ingredient1 != null:
		ingredient1.global_position = ingredient1.global_position.lerp\
			(global_position,delta*100.0)
	print(ingredient1)
