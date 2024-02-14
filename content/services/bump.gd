extends Node

func _ready():
	messenger.connect('tile_selected', check_character)
	messenger.connect('character_selected', check_tile)

func check_character(tile):
	for character in get_tree().get_nodes_in_group('characters'):
		if character.coordinates == tile.coordinates:
			bump(character)
			break
	bump(tile)

func check_tile(character):
	for tile in get_tree().get_nodes_in_group('tiles'):
		if tile.coordinates == character.coordinates:
			bump(tile)
			break
	bump(character)

func bump(node):
	node.find_child('bump').bump()
