extends Node

var astar: AStarGrid2D = AStarGrid2D.new()


func _ready():
	astar.region = Rect2i(-1, -1, 10, 10)
	astar.update()
	reset()


func get_range(entity):
	@warning_ignore("shadowed_global_identifier")
	var range: Array = []

	for tile in get_tree().get_nodes_in_group('tiles'):
		if tile.coordinates.y == entity.coordinates.y and                \
		   tile.coordinates.x >= entity.coordinates.x - entity.reach and \
		   tile.coordinates.x <= entity.coordinates.x + entity.reach or  \
		   tile.coordinates.x == entity.coordinates.x and                \
		   tile.coordinates.y >= entity.coordinates.y - entity.reach and \
		   tile.coordinates.y <= entity.coordinates.y + entity.reach:
				range.append(tile)

	return range


func set_solid(coordinates, value):
	astar.set_point_solid(coordinates, value)

func is_solid(coordinates):
	return astar.is_point_solid(coordinates)


func reset():
	for tile in get_tree().get_nodes_in_group('tiles'):
		astar.set_point_solid(tile.coordinates, false)

	for entity in get_tree().get_nodes_in_group('entities'):
		astar.set_point_solid(entity.coordinates, true)
