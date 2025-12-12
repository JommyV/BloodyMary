extends Panel


signal cook_food


var item_type = "blood_bag"
@onready var button: Button = %Button

func _ready() -> void:
	pass


func _on_button_2_pressed() -> void:
	print(get_parent().get_parent().get_parent().name)
	print(item_type)
	cook_food.emit(item_type)
