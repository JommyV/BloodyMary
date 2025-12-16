extends Node
class_name HUD

var ClientCount : int
var PointerAngle : float
@onready var ClientDisplay = $CanvasLayer/DebugInput/ClientDisplay
@onready var Plus1 = $CanvasLayer/DebugInput/P1
@onready var Plus5 = $CanvasLayer/DebugInput/P5
@onready var Minus1 = $CanvasLayer/DebugInput/M1
@onready var Minus5 = $CanvasLayer/DebugInput/M5
@onready var Pointer = $CanvasLayer/Clock/Pointer
@onready var ClientOut = $CanvasLayer/DebugInput/ClientOut
@onready var Reset = $CanvasLayer/DebugInput/Res
var client_left: bool = false
var number_of_clients: int

func _ready():
	ClientOut.disabled = true
	Reset.disabled = true
	PointerAngle = 360.0 / DayManager.calculate_client_number(GlobalData.popularity)
	number_of_clients = DayManager.calculate_client_number(GlobalData.popularity)
	print("angle is " + str(PointerAngle))
	print("popularity is " + str(DayManager.calculate_client_number(GlobalData.popularity)))

func _on_commit_client_pressed() -> void:
	Plus1.disabled = true
	Plus5.disabled = true
	Minus1.disabled = true
	Minus5.disabled = true
	Reset.disabled = false
	ClientOut.disabled = false
	

func _on_client_out_pressed() -> void:
	Pointer.rotation_degrees = Pointer.rotation_degrees + PointerAngle
	ClientCount-=1
	ClientDisplay.text = ("Client Amount: " + str(ClientCount))
	if ClientCount == 0:
		ClientOut.disabled = true

func _on_p_1_pressed() -> void:
	ClientCount += 1
	ClientDisplay.text = ("Client Amount: " + str(ClientCount))

func _on_p_5_pressed() -> void:
	ClientCount += 5
	ClientDisplay.text = ("Client Amount: " + str(ClientCount))

func _on_m_1_pressed() -> void:
	ClientCount -= 1
	ClientDisplay.text = ("Client Amount: " + str(ClientCount))

func _on_m_5_pressed() -> void:
	ClientCount -= 5
	ClientDisplay.text = ("Client Amount: " + str(ClientCount))

func _on_res_pressed() -> void:
	Plus1.disabled = false
	Plus5.disabled = false
	Minus1.disabled = false
	Minus5.disabled = false
	Reset.disabled = true
	ClientOut.disabled = true
	ClientCount = 0
	ClientDisplay.text = ("Client Amount: " + str(ClientCount))
	Pointer.rotation_degrees = 0.0


func on_client_out() -> void: 
	if client_left:
		Pointer.rotation_degrees = Pointer.rotation_degrees + PointerAngle
		print(number_of_clients)
