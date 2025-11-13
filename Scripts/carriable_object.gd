extends Node2D

class_name Carriable

@onready var carried : bool = false
@onready var sprite_2d: Sprite2D = %Sprite2D
#Variable that defines the type of food the object is and how it can interact.
var global_type: String

#Defines if object can be carried.
var carriable: bool = true
var cooked: bool = false


@export var tilemap_path: NodePath
@export var highlight_tilemap_path: NodePath
@export var highlight_source_id: int = 1 # ID do tile de destaque no TileSet


#Variables for the placement system
var tilemap: TileMapLayer
var highlight_tm: TileMapLayer
var _last_highlighted_cell: Vector2i
var tilemap_data
var tile_location
var drop_location
@onready var marker_2d: Marker2D = %Marker2D
var _can_drop := true 

#Variable exclusive to the plate to determine if it can pick food. Is stated 
#in the global class so the player can always access it as it is part of the check
#it does when picking up things. If the plate can pickup foods, it takes priority
#over the player dropping the plate. 
var can_pick_food: bool = false


func _ready() -> void:
	tilemap = get_node("/root/MainWorld/TilesFloor")
	highlight_tm = get_node("/root/MainWorld/TileHighlight")
	_last_highlighted_cell = Vector2i(999999, 999999)


#func drop() -> void:
	#if not carried:
		#return
	#if not can_pick_food:
		#carried = false
		#var cell := GridSnapping.world_to_cell(tilemap, global_position)
		#if _is_cell_drop_allowed(cell):
			#global_position = GridSnapping.cell_to_world_center(tilemap, cell)
		#_clear_highlight()


func _clear_highlight() -> void:
	if highlight_tm and _last_highlighted_cell.x < 999998:
		highlight_tm.erase_cell(_last_highlighted_cell)
	_last_highlighted_cell = Vector2i(999999, 999999)


func _physics_process(_delta: float) -> void:
	# Sem alterar a forma como o player o move — apenas tratamos o highlight
	if carried:
		_update_highlight_under()
	else:
		# Garantia: se deixar de estar a ser carregado por outra via,
		# o destaque também é removido.
		if _last_highlighted_cell.x < 999998:
			_clear_highlight()


func _update_highlight_under() -> void:
		var cell : Vector2i = GridSnapping.world_to_cell(tilemap, global_position)
		#print(cell)
		#print(_last_highlighted_cell)
		if cell != _last_highlighted_cell:
			_clear_highlight()
		if _is_cell_drop_allowed(cell):
			# TileMapLayer.set_cell(coords, source_id)
			highlight_tm.set_cell(cell, 1,Vector2i(1,1))
		_last_highlighted_cell = cell


func _is_cell_drop_allowed(cell: Vector2i) -> bool:
	if not _cell_in_bounds(cell):
		return false
	# Poderá incluir verificação de tiles sólidos, colisões ou ocupação
	return _can_drop #um dicionário de células ocupadas por objetos


func _cell_in_bounds(cell: Vector2i) -> bool:
	var used := tilemap.get_used_rect() # Rect2i
	return used.has_point(cell)


func setup(type:String) -> void:
#Function for the creation of the object by the creation work station.
	match type:
		"eyeball":
			sprite_2d.texture = preload("uid://dycl41yr58est")
			global_type = "eyeball"
		"slice":
			sprite_2d.texture = preload("uid://ev6benlbdc5p")
			global_type = "slice"
		"plate":
			sprite_2d.texture = preload("uid://ds0sqyxkw86f6")
			global_type = "plate"

 
func cook() -> void: 
#Centralized Function called externally when the food is prepared. 
#Will cook the food depending on its type. The check to see if the station can 
#cook certain food is made at that station.
	match global_type:
		"eyeball":
			global_type = "cut_eyeball"
			sprite_2d.texture = preload("res://Assets/Sprites/cuteyeball.png")

		"slice":
			global_type = "toast"
			sprite_2d.texture = preload("uid://xgbddpvesgmj")

		"eyeball_on_toast":
			global_type = "eyeball_on_toast"
			sprite_2d.texture = preload("res://Assets/Sprites/eyeballontoast.png")
