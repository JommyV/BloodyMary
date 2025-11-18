extends Node2D

@export var client_list: PackedScene
@onready var spawner_timer: Timer = %SpawnerTimer




func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("spawn"):
		var client : Node2D = client_list.instantiate()
		add_child(client)
		client.spawn(global_position)
