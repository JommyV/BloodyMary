extends Panel
signal cook_food


@onready var button: Button = %Button

var parent
var item_type: String


func _ready() -> void:
	parent = get_parent().get_parent().get_parent()
	
	if parent.global_type == "fridge":
		item_type = "eyeball"
		button.icon = preload("uid://f6ntaut3iq2x")
	if parent.global_type == "pantry":
		item_type = "slice"
		button.icon = preload("uid://ddogcrbdfu27y")


func _on_button_pressed() -> void:
	cook_food.emit(item_type)
