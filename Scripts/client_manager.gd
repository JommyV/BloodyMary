extends Node

class_name ClientManager

var daily_clients
var average_waiting_time
var global_served_plates = { "Blood Soup": 0, "Eyeball Toast": 0, "Brain Bolognese": 0}
var daily_served_plates = { "Blood Soup": 0, "Eyeball Toast": 0, "Brain Bolognese": 0}
var sat_clients
var free_tables
var max_tables: int = 4
var profit: float
var served_clients: int


func _ready() -> void: 
	free_tables = max_tables
	
