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


func _process(_delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		interactible = true
		player = body
		object = body.carriedobject
		print(object)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
			interactible = false
			player = null


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		interactible = true
		player = area.get_parent()
	if area.get_parent() is Carriable:
		object = area.get_parent()


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent() is Player:
			interactible = false
			player = null
	if area.get_parent() is Carriable: 
		object = null
