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
@onready var station_hud: CanvasLayer = %StationHud


func interact() -> void:
	pass


func _ready() -> void:
#Hides elements at game start.
	progress_bar.hide()
	station_hud.hide()
#Adds the hud for picking food at stations 
	station_hud.slot_1.cook_food.connect(create_food.bind())
	station_hud.slot_2.cook_food.connect(create_food.bind())


func _on_area_2d_area_entered(area: Area2D) -> void:
	#Determines if the player can access the workstation.
	if working:
		return
	if area.get_parent() is Player:
		interactible = true
		player = area.get_parent()
#Defines the object that will be cooked, excludes plates.
	if area.get_parent() is Carriable and !area.get_parent().is_in_group("Plate"):
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
