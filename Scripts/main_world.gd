extends Node

const COLUMNS = 7
const ROWS = 6

@onready var criador_clientes: Node2D = %CriadorClientes
@onready var connection: Marker2D = %Connection


func _ready() -> void:
	GlobalData.calculate_stats()
	print(connection.global_position)


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Client:
		print("AHahahahahahahah Ronaldinho Soccer")
		

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("night"):
		GlobalData.save_data()
		get_tree().change_scene_to_packed(preload("uid://bpbcg217lm1nl"))
		
