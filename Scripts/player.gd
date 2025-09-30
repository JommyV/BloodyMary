extends CharacterBody2D

@export var speed = 400
var screen_size 
@onready var sprite_2d: Sprite2D = %Sprite2D
@onready var carry_position: Marker2D = %CarryPosition


func _ready() -> void:
	#hide()
	screen_size = get_viewport_rect()
	SignalsController.object_carried_position.emit()
	


func _physics_process(delta: float) -> void:
	var local_velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		local_velocity.x += 1
	if Input.is_action_pressed("move_left"):
		local_velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		local_velocity.y += 1
	if Input.is_action_pressed("move_up"):
		local_velocity.y -= 1
	if local_velocity.length() > 0:
		local_velocity = local_velocity.normalized() * speed
		$AnimatedSprite2D.play()
		rotation = lerp_angle(rotation, atan2(local_velocity.x, -local_velocity.y), delta*50.0)
	else:
		$AnimatedSprite2D.stop()
	position += local_velocity * delta
	#position = position.clamp(Vector2.ZERO, screen_size)
	


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Interactibles"):
		print("WawaWiwi")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Interactible"):
		body.carry(carry_position.transform)
		print("WawaWiwi")
