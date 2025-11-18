extends RigidBody2D

@export var tables : Array[Node]
var intermediates: Array[Node]
var target_position_1
var target_position_2
@export var delay : int = 50
var arrived: bool = false

func _ready() -> void:
	intermediates = get_tree().get_nodes_in_group("Intermediate")
	tables = get_tree().get_nodes_in_group("Table")
		
	#print(tables)
	target_position_1 = intermediates[0].global_position - global_position
	#target_position_2 = tables[0].global_position - global_position
	


func spawn(spawn_pos:Vector2) -> void:
	global_position = spawn_pos
	#rotation = spawn_rot
	
	#var velocity := Vector2(randf_range (150.0, 250.0),0)

func _physics_process(_delta: float) -> void:
	
	target_position_2 = tables[0].global_position - global_position
	if position.distance_to(target_position_1)>1 and !arrived:
		move_and_collide(target_position_1 / delay)
	else: 
		arrived = true
	if arrived:
		@warning_ignore("integer_division")
		move_and_collide(target_position_2 / (delay/2))
	#print(tables[0].global_position - global_position)
	print(position.distance_to(target_position_1))
	print(linear_velocity)
	
