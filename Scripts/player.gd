extends RigidBody2D

class_name Player

@export var speed = 200
var screen_size 
@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D
@onready var area_2d: Area2D = %Area2D
@export var rotationspeed: float

var can_walk: bool = true

#Variables for held objetct.
var carriedobject
var pickedup : bool = false
var carriableobject: Node2D

#Variables for dropping objects in grid with snap.
@onready var carry_position: Marker2D = %CarryPosition
const TILE_SIZE = Vector2(64,64)
var snap: bool = false

#Variables related to cooking food, checks if player can interact and which
#what interaction it will trigger.
var can_interact: bool = false
var interactible_station: Object
var in_area: bool
var plate_in_hand:bool

@onready var exit_timer: Timer = $Timer


func _ready() -> void:
	#screen_size = get_viewport_rect()
	pass


func _process(_delta: float) -> void:
#Function to carry food. First checks if there is a carriable object in range to 
#avoid null errors, checks if pickup is pressed, checks if the object is actually carriable
#as it may be conditioned to not be and lastly checks to see if the plate can pick up food,
# as it takes preference when picking up to the player.
#If all are true sets that object as being carried. If already carrying,
#drops object into snapped grid.
	
	if carriableobject != null and Input.is_action_just_pressed("pickup") and \
	carriableobject.carriable == true:
		pick_up()
		#Check if able to interact if in range and carrying object. If so, calls 
#the interact function on the working station that varies per type.
	if Input.is_action_just_pressed("interact") and interactible_station != null:
		interactible_station.interact()
		
	#if carriedobject != null:
		#print(carriedobject.global_type)
	#print(carriedobject)



func _physics_process(delta: float) -> void:
	#Control of movement:
	var local_velocity = Vector2.ZERO
	#check created to lock player out of movement if necessary for certain tasks.
	if can_walk:
		if Input.is_action_pressed("move_right"):
			local_velocity.x += 1
			animated_sprite_2d.set_animation("right")
		if Input.is_action_pressed("move_left"):
			local_velocity.x -= 1
			animated_sprite_2d.set_animation("left")
		if Input.is_action_pressed("move_down"):
			local_velocity.y += 1
			animated_sprite_2d.set_animation("front")
		if Input.is_action_pressed("move_up"):
			local_velocity.y -= 1
			animated_sprite_2d.set_animation("back")
			
		if local_velocity.length() > 0:
			local_velocity = local_velocity.normalized() * speed
			area_2d.rotation = lerp_angle(area_2d.rotation, atan2(local_velocity.x, -local_velocity.y), delta*50.0)
			#carry_position.rotation = lerp_angle(carry_position.rotation, atan2(local_velocity.x, -local_velocity.y), delta*50.0)
		position += local_velocity * delta
		#if carriableobject != null:
			#print(carriableobject.global_type)
			
			#Checks if object is held in hand, if so, keeps it in the hand of the player and
#aligns its rotation and makes it not collide with the player.
	if pickedup and carriedobject != null:
		carriedobject.global_position = carry_position.global_position
		#carriedobject.set_collision_layer_value(1,false)
		#carriedobject.freeze = true
		carriedobject.rotation = self.rotation


#Function made for releasing the object when player presses the release button,
#separated from pick function to be called externally when necessary.
func release() -> void:
	pickedup = false
#Sets the object to not be carried 
	carriableobject.carried = false
	carriedobject.carried = false
	carriedobject = null



func pick_up() -> void:
	
	if carriedobject != null and carriedobject.global_type == "plate" and !carriedobject.dish1_on_plate:
		release()
		return
	
	elif carriedobject != null and carriedobject.global_type == "plate" and carriedobject.can_pick_food:
		carriedobject.take_food()
		return
	#If the player is carrying an object, releases it. 
	if pickedup == true:
		#Snaps the object into the grid.
		release()

#If not carrying an object, picks it up.s
	elif !carriableobject.carried:
		pickedup = true #Sets object as carried in self.
		carriableobject.carried = true #Sets object as carried in the object.
		carriedobject = carriableobject #Sets which object is being carried.
		carriedobject.carriable = true #Allows the object to be carriable.

	if carriedobject != null and carriedobject.global_type == "plate" and Input.is_action_just_pressed("pickup") and carriedobject.can_pick_food:
		print(carriedobject.can_pick_food)
		



#func _on_area_2d_body_entered(body: Node2D) -> void:
##Sets the object to be carried 
	#if body.is_in_group("Interactible") and carriedobject == null:
		#carriableobject = body


#func _on_area_2d_body_exited(body: Node2D) -> void:
	#if body.is_in_group("Interactible"):
		#carriedobject = null
		#pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	#if area_2d.get_overlapping_areas():
	if area.is_in_group("WorkStation"):
#Sets the work station that can be used when the player 
#can interact with it and tells the workstation it can be used.
		can_interact = true
		interactible_station = area.get_parent()
		#print(interactible_station)

	if area.get_parent().is_in_group("Interactible") and carriedobject == null\
		 and area.get_parent().carriable:
#Sets the object that can be carried when the player can interact with it.
		carriableobject = area.get_parent()


func _on_area_2d_area_exited(area: Area2D) -> void:
#Removes the work station that can be carried when the player can no 
#longer interact with it.
		if area.is_in_group("WorkStation"):
			can_interact = false
			interactible_station = null

#Removes the object that can be carried when the player can no 
#longer interact with it.
		if area.get_parent().is_in_group("Interactible") and carriedobject == null:
			carriableobject = null
