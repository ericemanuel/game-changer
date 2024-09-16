extends Node

func _ready():
	hardware.node_selected.connect(select)
	hardware.node_alt_selected.connect(alt_select)
	hardware.node_entered.connect (enter)
	hardware.node_exited.connect  (exit)


func select(node):
	if node.is_in_group('tiles'):
		event.tile_selected.emit(node)
		select_character(node)
		select_crystal(node)

	elif node.is_in_group('characters'):
		event.character_selected.emit(node)
		select_tile(node)

	elif node.is_in_group('crystals'):
		event.crystal_selected.emit(node)
		select_tile(node)

func alt_select(node):
	if node.is_in_group('tiles'):
		event.tile_alt_selected.emit(node)

	if node.is_in_group('crystals'):
		event.crystal_alt_selected.emit(node)

func select_tile(node):
	for tile in get_tree().get_nodes_in_group('tiles'):
		if tile.coordinates == node.coordinates:
			event.tile_selected.emit(tile)
			break

func select_character(tile):
	for character in get_tree().get_nodes_in_group('characters'):
		if character.coordinates == tile.coordinates:
			event.character_selected.emit(character)
			break

func select_crystal(tile):
	for crystal in get_tree().get_nodes_in_group('crystals'):
		if crystal.coordinates == tile.coordinates:
			event.crystal_selected.emit(crystal)
			break


func enter(node):
	if node.is_in_group('tiles'):
		event.tile_entered.emit(node)
		enter_character(node)
		enter_crystal(node)

	elif node.is_in_group('characters'):
		event.character_entered.emit(node)
		enter_tile(node)

	elif node.is_in_group('crystals'):
		event.crystal_entered.emit(node)
		enter_tile(node)

func enter_tile(node):
	for tile in get_tree().get_nodes_in_group('tiles'):
		if tile.coordinates == node.coordinates:
			event.tile_entered.emit(tile)
			break

func enter_character(tile):
	for character in get_tree().get_nodes_in_group('characters'):
		if character.coordinates == tile.coordinates:
			event.character_entered.emit(character)
			break

func enter_crystal(tile):
	for crystal in get_tree().get_nodes_in_group('crystals'):
		if crystal.coordinates == tile.coordinates:
			event.crystal_entered.emit(crystal)
			break


func exit(node):
	if node.is_in_group('tiles'):
		event.tile_exited.emit(node)
		exit_character(node)
		exit_crystal(node)

	elif node.is_in_group('characters'):
		event.character_exited.emit(node)
		exit_tile(node)

	elif node.is_in_group('crystals'):
		event.crystal_exited.emit(node)
		exit_tile(node)

func exit_tile(node):
	for tile in get_tree().get_nodes_in_group('tiles'):
		if tile.coordinates == node.coordinates:
			event.tile_exited.emit(tile)
			break

func exit_character(tile):
	for character in get_tree().get_nodes_in_group('characters'):
		if character.coordinates == tile.coordinates:
			event.character_exited.emit(character)
			break

func exit_crystal(tile):
	for crystal in get_tree().get_nodes_in_group('crystals'):
		if crystal.coordinates == tile.coordinates:
			event.crystal_exited.emit(crystal)
			break
