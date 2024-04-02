extends Node

func _ready():
	hardware.node_selected.connect(select)
	hardware.node_entered.connect (enter)
	hardware.node_exited.connect  (exit)


func select(node):
	if node.is_in_group('characters'):
		event.character_selected.emit(node)
		select_tile(node)

	elif node.is_in_group('tiles'):
		event.tile_selected.emit(node)
		select_character(node)

func select_tile(character):
	for tile in get_tree().get_nodes_in_group('tiles'):
		if tile.coordinates == character.coordinates:
			event.tile_selected.emit(tile)
			break

func select_character(tile):
	for character in get_tree().get_nodes_in_group('characters'):
		if character.coordinates == tile.coordinates:
			event.character_selected.emit(character)
			break


func enter(node):
	if node.is_in_group('characters'):
		event.character_entered.emit(node)
		enter_tile(node)

	elif node.is_in_group('tiles'):
		event.tile_entered.emit(node)
		enter_character(node)

func enter_tile(character):
	for tile in get_tree().get_nodes_in_group('tiles'):
		if tile.coordinates == character.coordinates:
			event.tile_entered.emit(tile)
			break

func enter_character(tile):
	for character in get_tree().get_nodes_in_group('characters'):
		if character.coordinates == tile.coordinates:
			event.character_entered.emit(character)
			break


func exit(node):
	if node.is_in_group('characters'):
		event.character_exited.emit(node)
		exit_tile(node)

	elif node.is_in_group('tiles'):
		event.tile_exited.emit(node)
		exit_character(node)

func exit_tile(character):
	for tile in get_tree().get_nodes_in_group('tiles'):
		if tile.coordinates == character.coordinates:
			event.tile_exited.emit(tile)
			break

func exit_character(tile):
	for character in get_tree().get_nodes_in_group('characters'):
		if character.coordinates == tile.coordinates:
			event.character_exited.emit(character)
			break
