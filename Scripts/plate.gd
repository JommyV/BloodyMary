extends "res://Scripts/carriable_object.gd"

var ingredient1: Node2D
var ingredient2: Node2D
var ready_dish: bool = false
var dish1_on_plate: bool = false
var dish2_on_plate: bool = false


func prepare_food():
	if ingredient1.global_type == "toast" and ingredient2.global_type == "cut_eyeball":
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
		and area.get_parent().carried == false and !area.get_parent().is_in_group("Plate") and area.get_parent().cooked:
		ingredient1 = area.get_parent()
		ingredient1.carriable = false
		can_pick_food = true
		#print("added")

	elif ingredient2 == null and area.get_parent().is_in_group("Interactible") \
		and area.get_parent().carried == false and !area.get_parent().is_in_group("Plate")\
			and !ready_dish and area.get_parent().cooked:
		ingredient2 = area.get_parent()
		ingredient2.carriable = false
		can_pick_food = true
		#print(ingredient2.get_groups())
		#print("added")

func _on_area_2d_area_exited(area: Area2D) -> void:
	if ingredient1 != null and area.get_parent().is_in_group("Interactible") and !dish1_on_plate:
			ingredient1 = null
			can_pick_food = false
	if ingredient2 != null and area.get_parent().is_in_group("Interactible") \
		and area.get_parent().carried == false and !area.get_parent().is_in_group("Plate"):
			ingredient2 = null
			can_pick_food = false
	

func _process(delta: float) -> void:
	if dish1_on_plate:
		ingredient1.global_position = ingredient1.global_position.lerp\
			(global_position,delta*100.0)
		ingredient1.rotation = self.rotation
		print(ingredient1.global_type)
	if ingredient2 and dish2_on_plate:
		ingredient2.global_position = ingredient2.global_position.lerp\
			(global_position,delta*100.0)
		ingredient1.rotation = self.rotation
		print(ingredient2.global_type)
	if Input.is_action_just_pressed("mix"):
		prepare_food()
	if Input.is_action_just_pressed("pickup") and can_pick_food and !dish1_on_plate:
		dish1_on_plate = true
		can_pick_food = false
		print(dish1_on_plate)
		print(can_pick_food)
	elif Input.is_action_just_pressed("pickup") and can_pick_food and dish1_on_plate:
		dish2_on_plate = true
		can_pick_food = false
