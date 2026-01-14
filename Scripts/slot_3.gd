extends Panel
signal cook_food

@onready var slot_3_button: Button = $slot3_button
var item_type 


func _ready() -> void:
	if get_parent().get_parent().get_parent().global_type == "fridge":
		item_type = "brain"
		slot_3_button.icon = preload("uid://b5yri07n2cpwb")
	if get_parent().get_parent().get_parent().global_type == "pantry":
		hide()

func _on_button_3_pressed() -> void:
	cook_food.emit(item_type)
	print("brains")
