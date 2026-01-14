extends Panel
signal cook_food


@onready var slot_2_button: Button = $slot2_button

var item_type 


func _ready() -> void:
	if get_parent().get_parent().get_parent().global_type == "fridge":
		item_type = "blood_bag"
		slot_2_button.icon = preload("uid://bm47tblkuvdnw")
	if get_parent().get_parent().get_parent().global_type == "pantry":
		item_type = "spaghetti"
		slot_2_button.icon = preload("uid://dub0ru24114re")


func _on_button_2_pressed() -> void:
	print(get_parent().get_parent().get_parent().name)
	print(item_type)
	cook_food.emit(item_type)
