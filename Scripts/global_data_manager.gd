extends Node

class_name GlobalData

const SAVE_PATH := "user://save_data.res"

static var popularity: float

static var data := SaveData.new()
static var daily_clients: int
static var current_money: float
static var day: int = 1

func _ready() -> void:
	load_data()
	popularity = data.popularity
	client_manager.global_served_plates = data.global_served_plates
	daily_clients = DayManager.calculate_client_number()


static func save_data() -> void:
	data.money = current_money
	data.popularity = popularity
	data.served_plates = client_manager.served_plates
	data.day = day
	ResourceSaver.save(data, SAVE_PATH)



static func load_data() -> void:
	if ResourceLoader.exists(SAVE_PATH):
		data = ResourceLoader.load(SAVE_PATH)


static func calculate_stats() -> void:
	DayManager.calculate_client_number()
