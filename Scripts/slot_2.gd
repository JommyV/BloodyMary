extends Panel
signal cook_food

@onready var button_2: Button = $Button2

var item_type 


func _ready() -> void:
	if get_parent().get_parent().get_parent().global_type == "fridge":
		item_type = "blood_bag"
		button_2.icon = preload("uid://bm47tblkuvdnw")
	if get_parent().get_parent().get_parent().global_type == "pantry":
		item_type = "spaghetti"
		button_2.icon = preload("uid://dub0ru24114re")


func _on_button_2_pressed() -> void:
	print(get_parent().get_parent().get_parent().name)
	print(item_type)
	cook_food.emit(item_type)
