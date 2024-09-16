extends Node

@onready var navigation = $".."

enum {idle,
	  character_selected,
	  character_moving,
	  crystal_created}

var state: int = idle
var Character: Node


func _ready():
	event.character_selected.connect(state_machine.bind(character_selected))
	event.character_moving.connect  (state_machine.bind(character_moving))
	event.crystal_created.connect(state_machine.bind(crystal_created))


func state_machine(entity, caller):
	match state:
		idle:
			match caller:
				character_selected:
					Character = entity
					show_range(Character)
					state = character_selected

		character_selected:
			reset()

			match caller:
				character_selected:
					if Character == entity:
						state = idle

					else:
						Character = entity
						show_range(Character)

	match caller:
		crystal_created:
			reset()
			state = idle


func show_range(character):
	for tile in navigation.get_range(character):
		event.tile_focused.emit(tile)


func reset():
	for tile in get_tree().get_nodes_in_group('tiles'):
		event.tile_unfocused.emit(tile)
