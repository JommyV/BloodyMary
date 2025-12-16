extends Node

class_name GlobalData

const SAVE_PATH := "user://save_data.res"

static var popularity

static var data := SaveData.new()


func _ready() -> void:
	load_data()
	popularity = data.popularity


static func save_data() -> void:
	ResourceSaver.save(data, SAVE_PATH)


static func load_data() -> void:
	if ResourceLoader.exists(SAVE_PATH):
		data = ResourceLoader.load(SAVE_PATH)
	
