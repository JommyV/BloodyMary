extends CharacterBody2D

@export var speed = 400
var screen_size 
var pickedup : bool = false
@onready var sprite_2d: Sprite2D = %Sprite2D
@onready var carry_position: Marker2D = %CarryPosition
@onready var raycast: RayCast2D = %RayCast2D
@onready var ray_cast_2d_3: RayCast2D = %RayCast2D3
@onready var ray_cast_2d_4: RayCast2D = %RayCast2D4
@onready var ray_cast_2d_5: RayCast2D = %RayCast2D5
@onready var ray_cast_2d_6: RayCast2D = %RayCast2D6
@onready var ray_cast_2d_7: RayCast2D = %RayCast2D7
@onready var raycasts = [raycast, ray_cast_2d_3,ray_cast_2d_4,ray_cast_2d_5, ray_cast_2d_6,ray_cast_2d_7]
const TILE_SIZE = Vector2(24,24)
var carriedobject
var snap: bool = false

func _ready() -> void:
	#hide()
	screen_size = get_viewport_rect()
	SignalsController.object_carried_position.emit()
	#for i in range(180):
		#var raycast = RayCast2D.new()
		#self.add_child(raycast)
		#raycast.owner = self


func _process(delta: float) -> void:
	#var objectheld = raycasts.get_collider()
	#for i in raycasts.size()-1: 
		#var objectheld = raycasts[i].get_collider()
		#if raycasts[i].is_colliding():
			#if objectheld.is_in_group("Interactible"):
				#if Input.is_action_pressed("pickup"):
					#pickedup = true
					##onhand = objectheld
					#objectheld.global_position = objectheld.global_position\
						#.lerp(carry_position.global_position,delta*200.0)
					#objectheld.global_rotation = carry_position.global_rotation
					#objectheld.collision_layer = 2
					##objectheld.linear_velocity = Vector2(0.1,3.0)s
					##else:
						##objectheld.global_position = global_position.snapped(TILE_SIZE)
	#for i in raycasts.size()-1: 
		#var objectheld = raycasts[i].get_collider()
		#if raycasts[i].is_colliding():
			#print("gotit")
	if carriedobject != null and Input.is_action_pressed("pickup"):
		carriedobject.global_position = carriedobject.global_position.lerp\
			(carry_position.global_position,delta*100.0)
	elif carriedobject != null:
		carriedobject.global_position = carriedobject.global_position.snapped(TILE_SIZE)
	

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
		$AnimatedSprite2D.play()
		rotation = lerp_angle(rotation, atan2(local_velocity.x, -local_velocity.y), delta*50.0)
	else:
		$AnimatedSprite2D.stop()
	position += local_velocity * delta
	#position = position.clamp(Vector2.ZERO, screen_size)
	

	


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Interactible"):
		print("WawaWiwi")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Interactible"):
		carriedobject = body
		print("wiwiwawa")
			#snap = false
