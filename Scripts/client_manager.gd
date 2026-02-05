extends Node

class_name ClientManager

static var daily_clients
static var average_waiting_time
static var global_served_plates = { "Blood Soup": 0, "Eyeball Toast": 0, "Brain Bolognese": 0}
static var daily_served_plates = { "Blood Soup": 0, "Eyeball Toast": 0, "Brain Bolognese": 0}
static var sat_clients
static var free_tables
static var max_tables: int = 4
static var profit: float
static var served_clients: int


func _ready() -> void: 
	free_tables = max_tables
	served_clients = 0
	
