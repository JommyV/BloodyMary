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


func interact() -> void:
	pass

func _ready() -> void:
	progress_bar.hide()


func _on_area_2d_area_entered(area: Area2D) -> void:
	#Determines if the player can access the workstation.
	if area.get_parent() is Player:
		interactible = true
		player = area.get_parent()
#Defines the object that will be cooked, excludes plates.
	if area.get_parent() is Carriable and !area.get_parent().is_in_group("Plate"):
		object = area.get_parent()


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent() is Player:
			interactible = false
			player = null
	if area.get_parent() is Carriable and !area.get_parent().is_in_group("Plate")\
	and !working: 
		object = null
