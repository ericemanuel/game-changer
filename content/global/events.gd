extends Node

signal tile_selected
signal tile_entered
signal tile_exited

signal character_selected
signal character_entered
signal character_exited

signal movement_finished


func _ready():
	interactions.node_selected.connect(select)
	interactions.node_entered.connect (enter)
	interactions.node_exited.connect  (exit)


func select(node):
	if node.is_in_group('characters'):
		character_selected.emit(node)
		select_tile(node)

	elif node.is_in_group('tiles'):
		tile_selected.emit(node)
		select_character(node)

func select_tile(character):
	for tile in get_tree().get_nodes_in_group('tiles'):
		if tile.coordinates == character.coordinates:
			tile_selected.emit(tile)
			break

func select_character(tile):
	for character in get_tree().get_nodes_in_group('characters'):
		if character.coordinates == tile.coordinates:
			character_selected.emit(character)
			break


func enter(node):
	if node.is_in_group('characters'):
		character_entered.emit(node)
		enter_tile(node)

	elif node.is_in_group('tiles'):
		tile_entered.emit(node)
		enter_character(node)

func enter_tile(character):
	for tile in get_tree().get_nodes_in_group('tiles'):
		if tile.coordinates == character.coordinates:
			tile_entered.emit(tile)
			break

func enter_character(tile):
	for character in get_tree().get_nodes_in_group('characters'):
		if character.coordinates == tile.coordinates:
			character_entered.emit(character)
			break


func exit(node):
	if node.is_in_group('characters'):
		character_exited.emit(node)
		exit_tile(node)

	elif node.is_in_group('tiles'):
		tile_exited.emit(node)
		exit_character(node)

func exit_tile(character):
	for tile in get_tree().get_nodes_in_group('tiles'):
		if tile.coordinates == character.coordinates:
			tile_exited.emit(tile)
			break

func exit_character(tile):
	for character in get_tree().get_nodes_in_group('characters'):
		if character.coordinates == tile.coordinates:
			character_exited.emit(character)
			break
