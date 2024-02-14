extends Node

func _ready():
	messenger.connect('tile_entered', check_character)
	messenger.connect('tile_exited', check_character)
	messenger.connect('character_entered', check_tile)
	messenger.connect('character_exited', check_tile)

func check_character(tile):
	for character in get_tree().get_nodes_in_group('characters'):
		if character.coordinates == tile.coordinates:
			modulate(character)
			break
	modulate(tile)

func check_tile(character):
	for tile in get_tree().get_nodes_in_group('tiles'):
		if tile.coordinates == character.coordinates:
			modulate(tile)
			break
	modulate(character)

func modulate(node):
	node.find_child('modulate').modulate()
