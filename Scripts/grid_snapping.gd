extends Node

class_name GridSnapping

static func world_to_cell(tilemap_layer: TileMapLayer, world_pos: Vector2) -> Vector2i:
#Converts global position to tilemap position
	return tilemap_layer.local_to_map(tilemap_layer.to_local(world_pos))

static func cell_to_world_center(tilemap_layer: TileMapLayer, cell: Vector2i) -> Vector2:
	# Gets center of cell in global position
	var local_pos := tilemap_layer.map_to_local(cell)
	#var half : Vector2 = tilemap_layer.tile_set.tile_size / 2
	return tilemap_layer.to_global(local_pos)
