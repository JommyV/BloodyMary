extends "res://Scripts/carriable_object.gd"

var ingredient1: Node2D
var ingredient2: Node2D
var ready_dish: bool = false
var dish1_on_plate: bool = false
var dish2_on_plate: bool = false


func prepare_food():
	if ingredient1 and ingredient2:
		if ingredient1.global_type == "toast" and ingredient2.global_type == "cut_eyeball":
			ingredient2.queue_free()
			ingredient1.global_type = "eyeball_on_toast"
			ingredient1.prepare_food()
			ready_dish = true

		if ingredient1.global_type == "cut_eyeball" and ingredient2.global_type == "toast":
			ingredient2.queue_free()
			ingredient1.global_type = "eyeball_on_toast"
			ingredient1.prepare_food()
			ready_dish = true


func _on_area_2d_area_entered(area: Area2D) -> void:
	if ingredient1 == null and area.get_parent().is_in_group("Interactible") \
		and area.get_parent().carried == false and !area.get_parent().is_in_group("Plate")\
		 and area.get_parent().cooked:
		ingredient1 = area.get_parent()
		ingredient1.carriable = false
		can_pick_food = true
		print("cooked")

	elif ingredient2 == null and area.get_parent().is_in_group("Interactible") \
		and area.get_parent().carried == false and !area.get_parent().is_in_group("Plate")\
			and !ready_dish and area.get_parent().cooked:
		ingredient2 = area.get_parent()
		ingredient2.carriable = false
		can_pick_food = true
		#print(ingredient2.get_groups())
		print("cooked")


func _on_area_2d_area_exited(area: Area2D) -> void:
	if ingredient1 != null and area.get_parent().is_in_group("Interactible") and !dish1_on_plate\
	and !dish1_on_plate:
			ingredient1 = null
			can_pick_food = false
	if ingredient2 != null and area.get_parent().is_in_group("Interactible") \
		and area.get_parent().carried == false and !area.get_parent().is_in_group("Plate")\
		and !dish2_on_plate:
			ingredient2 = null
			can_pick_food = false


func _physics_process(_delta: float) -> void:
	#print(ingredient2)
	if dish1_on_plate:
		ingredient1.global_position = global_position
		ingredient1.rotation = self.rotation
		#print(ingredient1.global_type)
	if ingredient2 and dish2_on_plate:
		ingredient2.global_position = global_position
		ingredient1.rotation = self.rotation
		ingredient1.global_position = global_position
		ingredient1.rotation = self.rotation
		#print(ingredient2.global_type)
		
	if Input.is_action_just_pressed("mix"):
		prepare_food()
	if carried:
		_update_highlight_under()
	else:
		# Garantia: se deixar de estar a ser carregado por outra via,
		# o destaque também é removido.
		if _last_highlighted_cell.x < 999998:
			_clear_highlight()


	#if Input.is_action_just_pressed("pickup") and can_pick_food and !dish1_on_plate:
		#dish1_on_plate = true
		#can_pick_food = false
		#
	#elif Input.is_action_just_pressed("pickup") and can_pick_food and dish1_on_plate:
		#dish2_on_plate = true
		#can_pick_food = false


func take_food() -> void:
	#print(can_pick_food)
	if can_pick_food and !dish1_on_plate:
		dish1_on_plate = true
		can_pick_food = false
		ingredient1.collision_layer = 3
	elif can_pick_food and dish1_on_plate:
		dish2_on_plate = true
		can_pick_food = false
		ingredient2.collision_layer = 3
