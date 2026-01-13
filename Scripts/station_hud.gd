extends CanvasLayer


@onready var slot_1: Panel = %Slot1
@onready var slot_2: Panel = %Slot2
@onready var slot_3: Panel = %Slot3

@onready var texture_rect: TextureRect = $TextureRect
var parent
@onready var button: Button = %Button
@onready var button_2: Button = $GridContainer/Slot2/Button2
@onready var button_3: Button = $GridContainer/Slot3/Button3

func _ready() -> void:
	if get_parent().global_type == "fridge":
		texture_rect.size = Vector2(214,624)
		texture_rect.position = Vector2(469,9)
		button.position = Vector2(474,14)
		button_2.position = Vector2(474,224)
		button_3.position = Vector2(474,427)

func _on_button_pressed() -> void:
	self.hide()
