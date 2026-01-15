extends Control

@onready var profit_nb: Label = %profit_nb
@onready var expenses_nb: Label = %expenses_nb
@onready var tips_nb: Label = %tips_nb
@onready var clients_nb: Label = %clients_nb
@onready var dishes_nb: Label = %dishes_nb
var dishes_served

func _ready() -> void:
	profit_nb.text = str(client_manager.profit) + "$"
	clients_nb.text = str(DayManager.calculate_client_number())
	dishes_nb.text = str(client_manager.served_clients)
	print("popularity is: " + str(global_data_manager.popularity))


func _on_button_pressed() -> void:
	GlobalData.day += 1
	GlobalData.save_data()
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://Scenes/main_world.tscn")
