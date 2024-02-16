extends Node

signal modulate

func _ready():
	messenger.connect('entered', check_coordinates)
	messenger.connect('exited', check_coordinates)

func check_coordinates(node):
	if node.is_in_group('tiles'):
		for character in get_tree().get_nodes_in_group('characters'):
			if character.coordinates == node.coordinates:
				messenger.emit_signal('modulate', character)
				break

	elif node.is_in_group('characters'):
		for tile in get_tree().get_nodes_in_group('tiles'):
			if tile.coordinates == node.coordinates:
				messenger.emit_signal('modulate', tile)
				break

	messenger.emit_signal('modulate', node)
