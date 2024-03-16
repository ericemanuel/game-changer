extends Node

const SPEED: float = 1

enum {idle,
	  character_moving}

var state: int = idle
var character: Node
var tile: Node
var movement_counter: int = 0


func start(_character, _tile):
	character = _character
	tile = _tile
	state = character_moving


func _process(_delta):
	match state:
		character_moving:
			move_character()


func move_character():
	if character.coordinates.x < tile.coordinates.x:
		if movement_counter < (8 / SPEED):
			character.position.x += 2 * SPEED
			character.position.y += 1 * SPEED
			movement_counter += 1
		else:
			character.coordinates.x += 1
			movement_counter = 0

	elif character.coordinates.x > tile.coordinates.x:
		if movement_counter < (8 / SPEED):
			character.position.x -= 2 * SPEED
			character.position.y -= 1 * SPEED
			movement_counter += 1
		else:
			character.coordinates.x -= 1
			movement_counter = 0

	elif character.coordinates.y < tile.coordinates.y:
		if movement_counter < (8 / SPEED):
			character.position.x -= 2 * SPEED
			character.position.y += 1 * SPEED
			movement_counter += 1
		else:
			character.coordinates.y += 1
			movement_counter = 0

	elif character.coordinates.y > tile.coordinates.y:
		if movement_counter < (8 / SPEED):
			character.position.x += 2 * SPEED
			character.position.y -= 1 * SPEED
			movement_counter += 1
		else:
			character.coordinates.y -= 1
			movement_counter = 0

	else:
		character.z_index = tile.z_index
		state = idle
		feedbacks.character_moved.emit(character)
