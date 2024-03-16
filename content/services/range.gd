extends Node

enum {idle,
	  character_selected}

var state: int = idle
var movement_points: int
var possible_moves: Array


func show(character):
	movement_points = character.movement_points
	
	for i in range(1, movement_points):
		for tile in get_tree().get_nodes_in_group('tiles'):
			if tile.coordinates == Vector2(character.coordinates.x + i, character.coordinates.y):
				if movement_points >= tile.movement_cost:
					movement_points = movement_points - tile.movement_cost
					possible_moves.append(tile)

				break
