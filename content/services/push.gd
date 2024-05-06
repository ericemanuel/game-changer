extends Node

@onready var battle = $".."
const SPEED: float = 1

enum {idle,
	  character_moving}

var state: int = idle
var character: Node
var tile: Node
var path: Array
var next: int = 1
var movement_counter: int = 0


func _ready():
	event.crystal_selected.connect(find_character)


func find_character(crystal):
	for tile in battle.get_range(crystal):
		for character in get_tree().get_nodes_in_group('characters'):
			if character.coordinates == tile.coordinates:
				find_destination(crystal, character)


func find_destination(crystal, character):
	var destination_coordinates: Vector2 = Vector2(0,0)

	for i in range(1, crystal.power):
		if character.coordinates.x == crystal.coordinates.x:
			if character.coordinates.y > crystal.coordinates.y:
				destination_coordinates.y = crystal.power + crystal.coordinates.y + 1
			else:
				destination_coordinates.y = -crystal.power + crystal.coordinates.y - 1

			destination_coordinates.x = character.coordinates.x
			break

		else:
			if character.coordinates.x > crystal.coordinates.x:
				destination_coordinates.x = crystal.power + crystal.coordinates.x + 1
			else:
				destination_coordinates.x = -crystal.power + crystal.coordinates.x - 1

			destination_coordinates.y = character.coordinates.y
			break

	for tile in get_tree().get_nodes_in_group('tiles'):
		if tile.coordinates == destination_coordinates:
			assign_values(character, tile, battle.get_point_path(character, tile))
			state = character_moving


func assign_values(character_, tile_, path_):
	character = character_
	tile = tile_
	path = path_


func _physics_process(_delta):
	match state:
		character_moving:
			push_character()


func push_character():
	var point: Vector2 = path[next]

	if character.coordinates.x < point.x:
		if movement_counter < (8 / SPEED):
			character.position.x += 2 * SPEED
			character.position.y += 1 * SPEED
			movement_counter += 1
		else:
			character.coordinates.x += 1
			movement_counter = 0

	elif character.coordinates.x > point.x:
		if movement_counter < (8 / SPEED):
			character.position.x -= 2 * SPEED
			character.position.y -= 1 * SPEED
			movement_counter += 1
		else:
			character.coordinates.x -= 1
			movement_counter = 0

	elif character.coordinates.y < point.y:
		if movement_counter < (8 / SPEED):
			character.position.x -= 2 * SPEED
			character.position.y += 1 * SPEED
			movement_counter += 1
		else:
			character.coordinates.y += 1
			movement_counter = 0

	elif character.coordinates.y > point.y:
		if movement_counter < (8 / SPEED):
			character.position.x += 2 * SPEED
			character.position.y -= 1 * SPEED
			movement_counter += 1
		else:
			character.coordinates.y -= 1
			movement_counter = 0

	else:
		next += 1
		character.z_index = tile.z_index + 2

		if next == path.size():
			next = 1
			character.z_index = tile.z_index + 2

			state = idle
			event.character_moved.emit(character)
