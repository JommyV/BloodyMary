extends "res://Scripts/carriable_object.gd"

var ingredient1: Node2D
var ingredient2: Node2D
var ready_dish: bool = false


func prepare_food():
	if ingredient1.global_type == "toast" and ingredient2.global_type == "cut_eyebal":
		ingredient2.queue_free()
		ingredient1.global_type = "eyeball_on_toast"
		ingredient1.cook()
		ready_dish = true

	if ingredient1.global_type == "cut_eyeball" and ingredient2.global_type == "toast":
		ingredient2.queue_free()
		ingredient1.global_type = "eyeball_on_toast"
		ingredient1.cook()
		ready_dish = true



func _on_area_2d_area_entered(area: Area2D) -> void:
	if ingredient1 == null and area.get_parent().is_in_group("Interactible") \
		and area.get_parent().carried == false and !area.get_parent().is_in_group("Plate"):
		ingredient1 = area.get_parent()
		ingredient1.carriable = false
		#print("added")
	elif ingredient2 == null and area.get_parent().is_in_group("Interactible") \
		and area.get_parent().carried == false and !area.get_parent().is_in_group("Plate")\
		and !ready_dish:
		ingredient2 = area.get_parent()
		ingredient2.carriable = false
		#print(ingredient2.get_groups())
		#print("added")

func _on_area_2d_area_exited(_area: Area2D) -> void:
	pass # Replace with function body.
	

func _process(delta: float) -> void:
	if ingredient1 != null:
		ingredient1.global_position = ingredient1.global_position.lerp\
			(global_position,delta*100.0)
		ingredient1.rotation = self.rotation
		print(ingredient1.global_type)
	if ingredient2:
		ingredient2.global_position = ingredient2.global_position.lerp\
			(global_position,delta*100.0)
		ingredient1.rotation = self.rotation
		print(ingredient2.global_type)
	if Input.is_action_just_pressed("mix"):
		prepare_food()
