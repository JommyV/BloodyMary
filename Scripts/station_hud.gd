extends CanvasLayer


@onready var slot_1: Panel = %Slot1
@onready var slot_2: Panel = %Slot2
@onready var slot_3: Panel = %Slot3

@onready var texture_rect: TextureRect = $TextureRect
var parent
@onready var button: Button = %Button
@onready var slot_2_button: Button = $VboxContainer/Slot2/slot2_button
@onready var slot_3_button: Button = $VboxContainer/Slot3/slot3_button

@onready var vbox_container: VBoxContainer = %VboxContainer

func _ready() -> void:
	if get_parent().global_type == "fridge":
		vbox_container.position = Vector2(476,18)
		texture_rect.size = Vector2(214,624)
		texture_rect.position = Vector2(469,9)
		button.position = Vector2(474,14)
		slot_2_button.position = Vector2(474,224)
		slot_3_button.position = Vector2(474,427)
	else:
		vbox_container.size = Vector2(200,411)

func _on_button_pressed() -> void:
	self.hide()
