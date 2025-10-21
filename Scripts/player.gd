extends RigidBody2D

class_name Player

@export var speed = 200
var screen_size 

var can_walk: bool = true

#Variables for held objetct.
var carriedobject
var pickedup : bool = false
var carriableobject: Node2D

#Variables for dropping objects in grid with snap.
@onready var carry_position: Marker2D = %CarryPosition
const TILE_SIZE = Vector2(24,24)
var snap: bool = false

#Variables related to cooking food, checks if player can interact and which
#what interaction it will trigger.
var can_interact: bool = false
var interactible_station: Object
var in_area: bool

@onready var exit_timer: Timer = $Timer


func _ready() -> void:
	#screen_size = get_viewport_rect()
	pass


func _process(delta: float) -> void:
#Function to carry food. Checks if there is an object in range, and if pickup is
#pressed. If both are true sets that object as being carried. If already carrying,
#drops object into snapped grid.
	if carriableobject != null and Input.is_action_just_pressed("pickup") and \
	carriableobject.carriable == true:
#Releases the 
		if pickedup == true:
			carriedobject.global_position = carriedobject.global_position.snapped(TILE_SIZE/2)
			carriedobject.set_collision_layer_value(1,true)
			carriedobject.carried = false
			carriedobject.carriable = true
			release()
		elif !carriableobject.carried:
			pickedup = true
			carriableobject.carried = true
			carriedobject = carriableobject
			carriedobject.carriable = true
			#print(carriedobject.global_type)
	#if carriableobject != null: 
		#print(carriableobject.global_type)


#Checks if object is held in hand, if so, keeps it in the hand of the player and
#aligns its rotation as well. 
	if pickedup and carriedobject != null:
		carriedobject.global_position = carriedobject.global_position.lerp\
			(carry_position.global_position,delta*100.0)
		carriedobject.set_collision_layer_value(1,false)
		carriedobject.rotation = self.rotation

#Check to be able to interact if in range and carrying object. If so, calls 
#the interact function on the working station that varies per type.
	if Input.is_action_just_pressed("interact") and interactible_station != null:
		interactible_station.interact()


func _physics_process(delta: float) -> void:
	#Control of movement:
	var local_velocity = Vector2.ZERO
	if can_walk:
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
			rotation = lerp_angle(rotation, atan2(local_velocity.x, -local_velocity.y), delta*50.0)
		position += local_velocity * delta


#Function made for releasing the object when player presses the release button,
#but more importantly so it can be called by the stations when necessary. 
func release() -> void:
	pickedup = false
#Importantly, sets the object to not be carried 
	carriableobject.carried = false
	carriedobject = null
	if !in_area:
		carriableobject = null


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Interactible") and carriedobject == null:
		carriableobject = body


#func _on_area_2d_body_exited(body: Node2D) -> void:
	#if body.is_in_group("Interactible"):
		#carriedobject = null
		#pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("WorkStation"):
		can_interact = true
		interactible_station = area.get_parent()
		#print(interactible_station)

	if area.get_parent().is_in_group("Interactible") and carriedobject == null\
	 and area.get_parent().carriable:
		carriableobject = area.get_parent()
		in_area = true


func _on_area_2d_area_exited(area: Area2D) -> void:
		if area.is_in_group("WorkStation"):
			can_interact = false
			interactible_station = null
		if area.get_parent().is_in_group("Interactible") and carriedobject == null:
			in_area = false
			carriableobject = null
