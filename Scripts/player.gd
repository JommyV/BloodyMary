extends RigidBody2D

class_name Player

@export var speed = 200
var screen_size 
@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D
@onready var area_2d: Area2D = %Area2D
@export var rotationspeed: float

var can_walk: bool = true

#Variables for held objetct.
var carried_object
@export var pickedup : bool = false
var carriable_object: Node2D

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
var can_serve: bool = false
@onready var exit_timer: Timer = $Timer

var served: bool = false
var client: Node2D




func _ready() -> void:
	pass


func _process(_delta: float) -> void:
#Function to carry food. First checks if there is a carriable object in range to 
#avoid null errors, checks if pickup is pressed, checks if the object is actually carriable
#as it may be conditioned to not be and lastly checks to see if the plate can pick up food,
# as it takes preference when picking up to the player.
#If all are true sets that object as being carried. If already carrying,
#drops object into snapped grid.
	if carriable_object != null and Input.is_action_just_pressed("pickup") and \
	carriable_object.carriable == true:
		pick_up()
		#Check if able to interact if in range and carrying object. If so, calls 
#the interact function on the working station that varies per type.
	if Input.is_action_just_pressed("interact") and interactible_station != null and can_interact:
		interactible_station.interact()
		animated_sprite_2d.stop()
		
	if Input.is_action_just_pressed("interact") and can_serve and carried_object and carried_object.global_type == "plate":
		#get_tree().call_group("Client", "start_eating")
		client.start_eating()
		carried_object.kill_food()
		release()
	#print(can_serve)
	if Input.is_action_just_pressed("night"):
		get_tree().change_scene_to_file("uid://bpbcg217lm1nl")
	if Input.is_action_just_pressed("restart"):
		get_tree().change_scene_to_file("res://Scenes/UI/main_menu.tscn")

func _physics_process(delta: float) -> void:
	#Control of movement:
	var local_velocity = Vector2.ZERO
	#check created to lock player out of movement if necessary for certain tasks.
	if can_walk:
		animated_sprite_2d.pause()
		if Input.is_action_pressed("move_right"):
			local_velocity.x += 1

		if Input.is_action_pressed("move_left"):
			local_velocity.x -= 1

		if Input.is_action_pressed("move_down"):
			local_velocity.y += 1

		if Input.is_action_pressed("move_up"):
			local_velocity.y -= 1

		if local_velocity != Vector2.ZERO:
			if local_velocity.y > 0 or local_velocity.y > 0 and local_velocity.x !=0:
				animated_sprite_2d.play("front")
			elif local_velocity.y < 0 or local_velocity.y < 0 and local_velocity.x !=0:
				animated_sprite_2d.play("back")
			elif local_velocity.x > 0:
				animated_sprite_2d.play("left")
				animated_sprite_2d.flip_h = false
			elif local_velocity.x < 0:
				animated_sprite_2d.play("right")
				animated_sprite_2d.flip_h = true
			
				
		
		if local_velocity.length() > 0:
			local_velocity = local_velocity.normalized() * speed
			area_2d.rotation = lerp_angle(area_2d.rotation, atan2(local_velocity.x, -local_velocity.y), delta*rotationspeed)
			#carry_position.rotation = lerp_angle(carry_position.rotation, atan2(local_velocity.x, -local_velocity.y), delta*50.0)
		position += local_velocity * delta
		#if carriable_object != null:
			#print(carriable_object.global_type)
			
			#Checks if object is held in hand, if so, keeps it in the hand of the player and
#aligns its rotation and makes it not collide with the player.
	if pickedup and carried_object != null:
		carried_object.global_position = carry_position.global_position
		#carried_object.set_collision_layer_value(1,false)
		#carried_object.freeze = true
		#carried_object.rotation = area_2d.rotation

#region Grabbing:
#Function made for releasing the object when player presses the release button,
#separated from pick function to be called externally when necessary.
func release() -> void:
	if !carried_object:
		return
	pickedup = false
#Sets the object to not be carried 
	carried_object.drop()
	carriable_object.carried = false
	carried_object.carried = false
	carried_object = null

func pick_up() -> void:
	if carried_object != null and carried_object.global_type == "plate" and !carried_object.ingredient1\
	and !carried_object.can_pick_food:
		#print(pickedup)
		release()
		#print(pickedup)
		return
	
	elif carried_object != null and carried_object.global_type == "plate" and carried_object.ingredient1\
	and carried_object.can_pick_food:
		carried_object.take_food()
		return
	#If the player is carrying an object, releases it. 
	if pickedup == true:
		#Snaps the object into the grid.
		release()
		return

#If not carrying an object, picks it up.s
	elif !carriable_object.carried:
		pickedup = true #Sets object as carried in self.
		carriable_object.carried = true #Sets object as carried in the object.
		carried_object = carriable_object #Sets which object is being carried.
		carried_object.carriable = true #Allows the object to be carriable.

	#if carried_object != null and carried_object.global_type == "plate" \
	#and Input.is_action_just_pressed("pickup") and carried_object.can_pick_food:
		##print(carried_object.can_pick_food)
		
#endregion

#region Area2D:
func _on_area_2d_area_entered(area: Area2D) -> void:
	#print(area)
	#if area_2d.get_overlapping_areas():
	if area.is_in_group("WorkStation"):
#Sets the work station that can be used when the player 
#can interact with it and tells the workstation it can be used.
		can_interact = true
		interactible_station = area.get_parent()
		#print(interactible_station)

	if area.get_parent().is_in_group("Interactible") and carried_object == null\
		 and area.get_parent().carriable:
#Sets the object that can be carried when the player can interact with it.
		carriable_object = area.get_parent()
		can_serve = false

	if area.is_in_group("Table") and carried_object!= null and carried_object.global_type == "plate" and carried_object.ingredient1 != null:
		client = area.get_parent()
		if carried_object.ingredient1.global_type == client.dish_to_order.global_type:
			can_serve = true



func _on_area_2d_area_exited(area: Area2D) -> void:
#Removes the work station that can be carried when the player can no 
#longer interact with it.
		if area.is_in_group("WorkStation"):
			can_interact = false
			interactible_station = null

#Removes the object that can be carried when the player can no 
#longer interact with it.
		if area.get_parent().is_in_group("Interactible") and carried_object == null:
			carriable_object = null
			
		if area.is_in_group("Table"):
			can_serve = false
#endregion
