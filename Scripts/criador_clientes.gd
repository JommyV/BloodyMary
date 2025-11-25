extends Node2D

@export var client_list: PackedScene
@onready var spawner_timer: Timer = %SpawnerTimer
@export var tables: Array[Node2D]
@export var sat_tables: Array[bool]
var i = 0




func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("spawn"):
		var client : Node2D = client_list.instantiate()
		add_child(client)
		client.spawn(global_position, tables[i].get_child(0).global_position,tables[i].global_position)
		#print(tables[0].get_child(0).global_position)
		i+=1
		if i == tables.size():
			i = 0
