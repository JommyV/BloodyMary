extends Node

const COLUMNS = 7
const ROWS = 6

@onready var criador_clientes: Node2D = %CriadorClientes
@onready var connection: Marker2D = %Connection


func _ready() -> void:
	GlobalData.calculate_stats()
	#print(connection.global_position)


func _process(_delta: float) -> void:
	if day_manager.clients_left == 0:
		GlobalData.save_data()
		await get_tree().create_timer(5).timeout
		get_tree().change_scene_to_file("res://Scenes/UI/end_menu.tscn")


func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("night"):
		GlobalData.save_data()
		get_tree().change_scene_to_packed(preload("uid://bpbcg217lm1nl"))
		
