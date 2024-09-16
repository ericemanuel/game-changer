extends Node

@onready var navigation = $".."
const SPEED: float = 1

enum {idle,
	  tile_selected,
	  character_selected,
	  character_moving,
	  character_moved}

var state: int = idle
var character: Node
var tile_: Node
var path: Array
var next: int = 1
var movement_counter: int = 0


func _ready():
	event.tile_selected.connect     (state_machine.bind(tile_selected))
	event.character_selected.connect(state_machine.bind(character_selected))


func state_machine(entity, caller):
	match state:
		idle:
			match caller:
				character_selected:
					character = entity
					state = character_selected

		character_selected:
			match caller:
				tile_selected:
					tile_ = entity
					if tile_ in navigation.get_range(character):
						if tile_.coordinates != character.coordinates:
							path = navigation.get_point_path(character, tile_)
							event.character_moving.emit(character)
							state = character_moving

					else:
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
		for tile in get_tree().get_nodes_in_group('tiles'):
			if tile.coordinates == point:
				character.z_index = tile.z_index + 2 #jogar esse controle para dentro do movimento
				break

		next += 1
		if next == path.size():
			next = 1

			state = idle
			event.character_moved.emit(character)
