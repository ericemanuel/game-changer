extends Node

var astar: AStarGrid2D = AStarGrid2D.new()


func _ready():
	astar.region = Rect2i(-1, -1, 10, 10)
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


func get_point_path(character, destination):
	reset()

	return astar.get_point_path(character.coordinates, destination)


func reset():
	for tile in get_tree().get_nodes_in_group('tiles'):
		astar.set_point_solid(tile.coordinates, false)

	for character in get_tree().get_nodes_in_group('characters'):
		astar.set_point_solid(character.coordinates, true)
	for crystal in get_tree().get_nodes_in_group('crystals'):
		astar.set_point_solid(crystal.coordinates, true)
