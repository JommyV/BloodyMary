extends CanvasLayer


@onready var slot_1: Panel = %Slot1
@onready var slot_2: Panel = %Slot2


func _ready() -> void:
	pass # Replace with function body.


func _on_button_pressed() -> void:
	self.hide()
