extends Node2D


var item_type


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		$TextureRect.texture = preload("uid://f6ntaut3iq2x")
		item_type = "eyeball"
