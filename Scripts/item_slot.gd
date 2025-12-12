extends Panel
class_name Slot
signal cook_food



var item_type = "eyeball"
@onready var button: Button = %Button

func _ready() -> void:
	pass


func _on_button_pressed() -> void:
	#print(get_parent().get_parent().get_parent().name)
	#print(item_type)
	cook_food.emit(item_type)
