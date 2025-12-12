extends Node2D

#Seating System variables. 
@export var client_list: PackedScene
@onready var spawner_timer: Timer = %SpawnerTimer
#Table system, tables is the position so the client moves to it, sat_tables gives
#tells which tables are taken.
@export var tables: Array[Node2D]
@export var sat_tables: Array[bool] = [false,false,false,false]
var i = 0

#variables for managing the amount of clients that come to the restaurant daily.
var day_length: float
var sat_clients = 0
var daily_clients

@export var dish1: Resource
@export var dish2: Resource
@export var dish3: Resource


func _ready() -> void:
#Sets the daily clients that will come to the restaurant.
	daily_clients = DayManager.calculate_client_number(1)
	print(daily_clients)
	DayManager.create_menu(dish1, dish2,dish3)


func _process(_delta: float) -> void:
	#if Input.is_action_just_pressed("spawn"):
		#for b in range(sat_tables.size()): 
			#if sat_tables[b] == false:
				#print("manager is " + str(b))
				#var client : Node2D = client_list.instantiate()
				#client.table_number = b
				#client.client_spawner = self
				#add_child(client)
				#client.spawn(global_position, tables[b].get_child(0).global_position,tables[b].global_position)
				#print(tables[0].get_child(0).global_position)
				#sat_tables[b] = true
				#b=+1
				#if b == sat_tables.size():
					#b = 0
				#return
	pass



#func set_time_for_day(number_of_clients: float) -> float:
	#day_length = 60/number_of_clients
	#return day_length


func _on_spawner_timer_timeout() -> void:
	if sat_clients <= daily_clients:
		for b in range(sat_tables.size()): 
				if sat_tables[b] == false:
					print("manager is " + str(b))
					var client : Node2D = client_list.instantiate()
					client.table_number = b
					client.client_spawner = self
					client.dish_to_order = DayManager.menu[b]
					DayManager.menu.remove_at(b)
					print(DayManager.menu)
					add_child(client)
					client.spawn(global_position, tables[b].get_child(0).global_position,tables[b].global_position)
					#print(tables[0].get_child(0).global_position)
					sat_tables[b] = true
					b=+1
					if b == sat_tables.size():
						b = 0
					sat_clients += 1
					return
				


#func create_menu() -> Array:
	#pass
