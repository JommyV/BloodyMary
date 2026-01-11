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



func _ready() -> void:
	hud = get_tree().get_first_node_in_group("HUD")
	intermediates = get_tree().get_nodes_in_group("Intermediate")
	tables = get_tree().get_nodes_in_group("Table")
	area_2d.hide()
	area_2d.monitoring = false
	order_sprite.hide()
	plate_area.hide()
	plate_area.monitoring = false
	#print("client is " + str(table_number))
	print(GlobalData.daily_clients)
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
		leave()
	if can_eat:
		texture_progress_bar.value = eat_time.time_left*33
		await get_tree().create_timer(3).timeout
		should_react = false
		should_leave = true

	if position.distance_to(target_position_1)>300:
		client_spawner.sat_tables[table_number] = false
		print("number of clients is" + str(GlobalData.daily_clients))
		GlobalData.daily_clients -= 1
		queue_free()
		return



func go_to_table() -> void:
	target_position_2 = table_position - global_position
	if position.distance_to(target_position_1)>1 and !arrived:
		move_and_collide(target_position_1 / delay)
	else: 
		arrived = true
	if arrived and global_position.distance_to(table_position)>1:
		@warning_ignore("integer_division")
		move_and_collide(target_position_2 / (delay/2))

	elif arrived:
		await get_tree().create_timer(4).timeout
		order_sprite.show()
		sat = true
		area_2d.show()
		area_2d.monitoring = true
		plate_area.show()
		plate_area.monitoring = true


func leave() -> void:
		@warning_ignore("integer_division") move_and_collide(global_position / (delay/2))
		if hud:
			hud.client_left = true
		if hud and hud.client_left == true: 
			hud.on_client_out()
			hud.client_left = false
			hud = null
		#print(table_number)



func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player and not ordered and arrived and sat:
		order_sprite.texture = order
		should_move = false
		area_2d.set_deferred("monitoring", false)
		area_2d.hide()
		plate_area.show()
		ordered = true
		player = area.get_parent()
		wait.start()


func _on_plate_area_area_entered(area: Area2D) -> void:
	#print("food is: " + area.get_parent().name)
	if area.get_parent() is Carriable and area.get_parent().global_type == dish_to_order.global_type:
		#print("food is: " + area.get_parent().global_type)
		plate = area
		should_react = true
		#player = area.get_parent()
		#order_sprite.hide()
		#print("yomama")
		#await get_tree().create_timer(5).timeout
		#should_leave = true
		#move_and_collide(global_position / (delay/2))


func _on_start_timer_timeout() -> void:
	should_move = true


func start_eating() -> void:
	if should_react:
		if wait.time_left > wait.wait_time/2:
			GlobalData.popularity +=0.15
			#print("full pop")
		else:
			GlobalData.popularity += 0.1
			#print("half pop")
		can_eat = true
		eat_time.start()
		wait.stop()


func select_dish() -> void:
	match dish_to_order.dish_name:
		"Blood Soup":
			order = preload("uid://dnod7t1s65e77")
		"Brain Bolognese":
			order = preload("uid://dub0ru24114re")
		"EyeBall Toast" :
			order = preload("uid://bfesx1lken8py")


func _on_wait_timeout() -> void:
	should_leave = true
