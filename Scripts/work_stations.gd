extends Node2D

class_name WorkStation

var interactible:bool = false
var food = preload("uid://ffwx4xuawmse")
var player: Object



func interact() -> void:
	pass
	
	
func _process(_delta: float) -> void:
	pass



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		interactible = true
		player = body


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
			interactible = false
			player = null
