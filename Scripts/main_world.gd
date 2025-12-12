extends Node

const COLUMNS = 7
const ROWS = 6

@onready var criador_clientes: Node2D = %CriadorClientes
@onready var connection: Marker2D = %Connection
#@onready var sub_viewport_container: SubViewportContainer = %SubViewportContainer


func _ready() -> void:
	print(connection.global_position)



func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Client:
		print("AHahahahahahahah Ronaldinho Soccer")
