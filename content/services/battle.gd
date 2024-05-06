extends Node

var astar: AStarGrid2D = AStarGrid2D.new()


func _ready():
	astar.region = Rect2i(0, 0, 8, 8)
	astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar.update()


func get_range(crystal):
	@warning_ignore("shadowed_global_identifier")
	var range: Array = []

	for tile in get_tree().get_nodes_in_group('tiles'):
		if tile.coordinates.y == crystal.coordinates.y and                 \
		   tile.coordinates.x >= crystal.coordinates.x - crystal.power and \
		   tile.coordinates.x <= crystal.coordinates.x + crystal.power or  \
		   tile.coordinates.x == crystal.coordinates.x and                 \
		   tile.coordinates.y >= crystal.coordinates.y - crystal.power and \
		   tile.coordinates.y <= crystal.coordinates.y + crystal.power:
			range.append(tile)

	return range


func get_point_path(character, tile) -> Array:
	return astar.get_point_path(character.coordinates, tile.coordinates)
