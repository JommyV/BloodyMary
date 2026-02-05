extends RigidBody2D
class_name Client

@export var tables : Array[Node]
var intermediates: Array[Node]
var target_position_1
var target_position_2
@export var delay : int = 50
var arrived: bool = false
var sat: bool = false
var should_move: bool = false
@onready var start_timer: Timer = %Start_timer
var table_position: Vector2
@onready var order_sprite: Sprite2D = %OrderSprite
var order
var ordered: bool = false
var should_leave: bool = false
@onready var area_2d: Area2D = %Area2D
@onready var plate_area: Area2D = %Plate_area
var can_eat: bool = false
var player
var plate
var should_react:bool = false
var table_number
var client_spawner
var dish_to_order
@onready var texture_progress_bar: TextureProgressBar = %TextureProgressBar
@onready var eat_time: Timer = %Eat_time
var hud
@onready var wait: Timer = %Wait
@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D
var animated:bool = false
var left_animated: bool = false
var get_out: bool = false


func _ready() -> void:
	hud = get_tree().get_first_node_in_group("HUD")
	intermediates = get_tree().get_nodes_in_group("Intermediate")
	tables = get_tree().get_nodes_in_group("Table")
	area_2d.hide()
	area_2d.monitoring = false
	order_sprite.hide()
	plate_area.hide()
	plate_area.monitoring = false
	select_dish()


func spawn(spawn_pos:Vector2, pos_1:Vector2, pos_2:Vector2) -> void:
	global_position = spawn_pos
	target_position_1 = pos_1 - global_position
	#target_position_2 = pos_2
	table_position = pos_2


func _physics_process(_delta: float) -> void:
	if should_move == true and sat == false:
		go_to_table()
	if should_leave:
		if !left_animated:
			animated_sprite_2d.play("leave")
			left_animated = true
			await animated_sprite_2d.animation_finished
			get_out = true
		
		if get_out:
			if table_number == 2 or table_number == 3:
				@warning_ignore("integer_division") move_and_collide(Vector2(0.5,2))
			else:
				@warning_ignore("integer_division") move_and_collide(global_position / (delay*3))
			animated_sprite_2d.play("walk_front")
	if can_eat:
		texture_progress_bar.value = eat_time.time_left*33
		order_sprite.hide()
		await get_tree().create_timer(3).timeout
		texture_progress_bar.hide()
		should_react = false
		should_leave = true
		can_eat = false
		

	if position.distance_to(target_position_1)>300:
		client_spawner.sat_tables[table_number] = false
		GlobalData.daily_clients -= 1
		queue_free()
		return
		
	#if linear_velocity != Vector2.ZERO:
			#if linear_velocity.y > 0 or linear_velocity.y > 0 and linear_velocity.x !=0:
				#animated_sprite_2d.play("walk_front")
			#elif linear_velocity.y < 0 or linear_velocity.y < 0 and linear_velocity.x !=0:
				#animated_sprite_2d.play("walk_back")
			#elif linear_velocity.x > 0:
				#
				#animated_sprite_2d.flip_h = false
			#elif linear_velocity.x < 0:
				#animated_sprite_2d.play("walk_right")
				#animated_sprite_2d.flip_h = true


func go_to_table() -> void:
	target_position_2 = table_position - global_position
	if position.distance_to(target_position_1)>1 and !arrived:
		move_and_collide(target_position_1 / delay)
		animated_sprite_2d.play("walk_back")
	else: 
		arrived = true
	if arrived and global_position.distance_to(table_position)>1:
		@warning_ignore("integer_division")
		move_and_collide(target_position_2 / (delay/2))
		animated_sprite_2d.play("walk_left")
		animated_sprite_2d.flip_h = true

	elif arrived:
		if !animated:
			animated_sprite_2d.play("arrive")
			animated = true
		await get_tree().create_timer(4).timeout
		order_sprite.show()
		sat = true
		area_2d.show()
		area_2d.monitoring = true
		plate_area.show()
		plate_area.monitoring = true
		wait.start()


func leave() -> void:
	order_sprite.hide()
	if hud:
		if hud.spin_queue == 0:
			hud.on_client_out()
			hud.spin_queue += 1
			hud = null
		else:
			hud.spin_queue += 1
			hud = null
	day_manager.clients_left -= 1
	print("there are clients left: " + str(day_manager.clients_left))


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player and not ordered and arrived and sat:
		order_sprite.texture = order
		if dish_to_order.global_type == "eyeball_on_toast":
			order_sprite.scale.x = 0.003
			order_sprite.scale.y = 0.003
		should_move = false
		area_2d.set_deferred("monitoring", false)
		area_2d.hide()
		plate_area.show()
		ordered = true
		player = area.get_parent()
		wait.start()


func _on_plate_area_area_entered(area: Area2D) -> void:
	if area.get_parent() is Carriable and area.get_parent().global_type == dish_to_order.global_type:
		plate = area
		should_react = true
		#player = area.get_parent()
		#order_sprite.hide()
		#await get_tree().create_timer(5).timeout
		#should_leave = true
		#move_and_collide(global_position / (delay/2))


func _on_start_timer_timeout() -> void:
	should_move = true


func start_eating() -> void:
	if should_react:
		if wait.time_left > wait.wait_time/2:
			GlobalData.popularity +=0.15
		else:
			GlobalData.popularity += 0.1
		can_eat = true
		match dish_to_order.global_type:
			"blood_soup":
				ClientManager.daily_served_plates["Blood Soup"] += 1 
				#ClientManager.global_served_plates["Blood Soup"] += 1 
				ClientManager.profit += 10
			"eyeball_on_toast":
				ClientManager.daily_served_plates["Eyeball Toast"] += 1 
				#ClientManager.global_served_plates["Eyeball Toast"] += 1 
				ClientManager.profit += 12
			"brain_bolognese":
				client_manager.daily_served_plates["Brain Bolognese"] += 1 
				#client_manager.global_served_plates["Brain Bolognese"] += 1
				client_manager.profit += 18
		client_manager.served_clients +=1
		day_manager.clients_left -= 1
	if hud:
		if hud.spin_queue == 0:
			hud.on_client_out()
			hud.spin_queue += 1
			hud = null
		else:
			hud.spin_queue += 1
			hud = null
		eat_time.start()
		wait.stop()


func select_dish() -> void:
	match dish_to_order.dish_name:
		"Blood Soup":
			order = preload("uid://dnod7t1s65e77")
		"Brain Bolognese":
			order = preload("uid://dub0ru24114re")
		"EyeBall Toast" :
			order = preload("uid://d28ighl5komlw")


func _on_wait_timeout() -> void:
	should_leave = true
	leave()
