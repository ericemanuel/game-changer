extends Node

@onready var movement_range: Node = $range
@onready var motion: Node = $motion

enum {idle,
	  tile_selected,
	  character_selected,
	  character_moving,
	  character_moved}

var state: int = idle
var character: Node
var tile: Node


func _ready():
	events.tile_selected.connect     (state_machine.bind(tile_selected))
	events.character_selected.connect(state_machine.bind(character_selected))
	feedbacks.character_moved.connect(state_machine.bind(character_moved))


func state_machine(node, caller):
	match state:
		idle:
			match caller:
				character_selected:
					character = node
					movement_range.show(character)
					state = character_selected

		character_selected:
			match caller:
				tile_selected:
					if node.coordinates != character.coordinates:
						tile = node
						motion.start(character, tile)
						state = character_moving
						states.character_moving.emit(character)

				character_selected:
					state = idle

		character_moving:
			match caller:
				character_moved:
					state = idle
