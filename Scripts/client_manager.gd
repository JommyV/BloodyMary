extends Node

class_name ClientManager

var daily_clients

var average_waiting_time

var served_plates = { "Blood Soup": 76, "Eyeball Toast": 0, "Brain Bolognese": 0}

var sat_clients

var free_tables

var max_tables: int = 4


func _ready() -> void: 
	for plates in served_plates:
		print(served_plates[plates])
	free_tables = max_tables
	
