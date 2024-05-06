extends Node2D

@export var coordinates: Vector2
@export var movement_points: int = 3


func _ready():
	position.x = 100 + (coordinates.x - coordinates.y) * 16
	position.y = 140 + (coordinates.x + coordinates.y - 2) * 8

	for tile in get_tree().get_nodes_in_group('tiles'):
		if tile.coordinates == coordinates:
			z_index = tile.z_index + 2
