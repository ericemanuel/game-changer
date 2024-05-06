extends Node

@onready var navigation = $".."
const SPEED: float = 1

enum {idle,
	  tile_selected,
	  character_selected,
	  crystal_destroyed,
	  character_moving,
	  character_moved}

var state: int = idle
var character: Node
var tile: Node
var path: Array
var next: int = 1
var movement_counter: int = 0


func _ready():
	event.tile_selected.connect     (state_machine.bind(tile_selected))
	event.character_selected.connect(state_machine.bind(character_selected))
	event.crystal_destroyed.connect  (state_machine.bind(crystal_destroyed))


func state_machine(object, caller):
	match state:
		idle:
			match caller:
				character_selected:
					character = object
					state = character_selected

		character_selected:
			match caller:
				tile_selected:
					tile = object
					if tile in navigation.get_range(character):
						if tile.coordinates != character.coordinates:
							path = navigation.get_point_path(character, tile)
							event.character_moving.emit(character)
							state = character_moving

					else:
						event.idle.emit(null)
						state = idle

				character_selected:
					state = idle


func _physics_process(_delta):
	match state:
		character_moving:
			move_character()


func move_character():
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
