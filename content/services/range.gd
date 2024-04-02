extends Node

@onready var graph = $".."


enum {idle,
	  character_selected,
	  character_moving,
	  character_moved}

var state: int = idle


func _ready():
	event.character_selected.connect(state_machine.bind(character_selected))
	event.idle.connect              (state_machine.bind(idle))
	event.character_moving.connect  (state_machine.bind(character_moving))


func state_machine(character, caller):
	match state:
		idle:
			match caller:
				character_selected:
					show_range(character)
					state = character_selected

		character_selected:
			reset()
			state = idle


func show_range(character):
	for tile in graph.get_range(character):
		event.tile_focused.emit(tile)


func reset():
	for tile in get_tree().get_nodes_in_group('tiles'):
		event.tile_unfocused.emit(tile)
