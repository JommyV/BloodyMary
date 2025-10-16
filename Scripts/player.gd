extends RigidBody2D

class_name Player

@export var speed = 200
var screen_size 
var pickedup : bool = false
@onready var sprite_2d: Sprite2D = %Sprite2D
@onready var carry_position: Marker2D = %CarryPosition
const TILE_SIZE = Vector2(24,24)
var carriedobject
var snap: bool = false
var can_interact: bool = false
var interactible_station: Object

func _ready() -> void:
	#hide()
	screen_size = get_viewport_rect()
	SignalsController.object_carried_position.emit()
	#for i in range(180):
		#var raycast = RayCast2D.new()
		#self.add_child(raycast)
		#raycast.owner = self


func _process(delta: float) -> void:
	if carriedobject != null and Input.is_action_pressed("pickup"):
		carriedobject.global_position = carriedobject.global_position.lerp\
			(carry_position.global_position,delta*100.0)
		carriedobject.set_collision_layer_value(1,false)
		#print(carriedobject.get_collision_layer_value(1))
		carriedobject.rotation = self.rotation
	elif carriedobject != null:
		carriedobject.global_position = carriedobject.global_position.snapped(TILE_SIZE/2)
		carriedobject.set_collision_layer_value(1,true)
	if Input.is_action_just_released("pickup") and carriedobject != null:
		carriedobject.apply_force(Vector2(100,100))

	if Input.is_action_just_pressed("interact") and interactible_station != null:
		interactible_station.interact()

	#if carriedobject != null:
		#pass

func _physics_process(delta: float) -> void:
	#Control of movement:
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
		#$AnimatedSprite2D.play()
		rotation = lerp_angle(rotation, atan2(local_velocity.x, -local_velocity.y), delta*50.0)
	#else:
		#$AnimatedSprite2D.stop()
	position += local_velocity * delta
	#position = position.clamp(Vector2.ZERO, screen_size)
	
	

	





func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Interactible"):
		carriedobject = body
	
	



func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Interactible"):
		carriedobject = null


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("WorkStation"):
		can_interact = true
		interactible_station = area.get_parent()
		print(interactible_station)


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("WorkStation"):
		can_interact = false
		interactible_station = null
