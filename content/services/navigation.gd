extends Node

var astar: AStarGrid2D = AStarGrid2D.new()


func _ready():
	astar.region = Rect2i(1, 1, 6, 6)
	astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar.update()


func get_range(character) -> Array:
	reset()

	@warning_ignore("shadowed_global_identifier")
	var range: Array = []

	for tile in get_tree().get_nodes_in_group('tiles'):
		if tile.coordinates == character.coordinates:
			range.append(tile)

		if not astar.is_point_solid(tile.coordinates):
			var path: Array = astar.get_point_path(character.coordinates, tile.coordinates)
			var path_weight: float = -astar.get_point_weight_scale(character.coordinates)

			for point in path:
				path_weight += astar.get_point_weight_scale(point)

			if path_weight > 0 and path_weight <= character.movement_points:
				range.append(tile)

	return range


func get_point_path(character, tile) -> Array:
	reset()
	return astar.get_point_path(character.coordinates, tile.coordinates)


func reset():
	for tile in get_tree().get_nodes_in_group('tiles'):
		astar.set_point_solid(tile.coordinates, false)
		astar.set_point_weight_scale(tile.coordinates, tile.weight)

		if not tile.is_visible():
			astar.set_point_solid(tile.coordinates, true)

	for character in get_tree().get_nodes_in_group('characters'):
		astar.set_point_solid(character.coordinates, true)

	for crystal in get_tree().get_nodes_in_group('crystals'):
		astar.set_point_solid(crystal.coordinates, true)
