extends Node2D

class_name WorkStation

var interactible:bool = false
var food = preload("uid://ffwx4xuawmse")
var plate = preload("uid://dld2v8i8ucel2")
var player
var object
var working: bool = false
@onready var progress_bar: ProgressBar = %ProgressBar
@onready var timer: Timer = %Timer
@export var cookable_food: Resource
@export var station_hud: PackedScene
var hud
var global_type: String
@export var station_type: types

enum types {
	GENERAL,
	FRIDGE,
	PANTRY,
	CUPBOARD,
	TOASTER,
	CHOPPING_BOARD,
	POT
}

func interact() -> void:
	pass


func _ready() -> void:
#Hides elements at game start.
	progress_bar.hide()
	#station_hud.hide()
	match station_type:
		types.FRIDGE:
			global_type = "fridge"
		types.CUPBOARD:
			global_type = "cupboard"
		types.PANTRY:
			global_type = "pantry"
		types.POT:
			global_type = "pot"
		types.CHOPPING_BOARD:
			global_type = "chopping_board"
		types.TOASTER:
			global_type = "toaster"
	if global_type == "fridge" or global_type == "pantry":
		hud = station_hud.instantiate()
		add_child(hud)
		hud.slot_1.cook_food.connect(create_food.bind())
		hud.slot_2.cook_food.connect(create_food.bind())
		if global_type == "fridge":
			hud.slot_3.cook_food.connect(create_food.bind())
		hud.hide()


func _on_area_2d_area_entered(area: Area2D) -> void:
	#Determines if the player can access the workstation.
	if working:
		return
	
	if area.get_parent() is Player:
		interactible = true
		player = area.get_parent()
#Defines the object that will be cooked, excludes plates.
	if area.get_parent().is_in_group("Plate") and area.get_parent().dirty == false:
		return
	if area.get_parent() is Carriable:
		object = area.get_parent()


func _on_area_2d_area_exited(area: Area2D) -> void:
	if working: 
		return
	if area.get_parent() is Player:
			interactible = false
			player = null
	if area.get_parent() is Carriable and !area.get_parent().is_in_group("Plate")\
	and !working: 
		object = null

func create_food(_type: String) -> void:
	pass
