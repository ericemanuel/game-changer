extends Node

@onready var battle = $".."

enum {idle,
	  character_moved,
	  crystal_entered,
	  crystal_exited,
	  crystal_created,
	  crystal_broken}

var state: int = idle


func _ready():
	event.character_moved.connect(state_machine.bind(character_moved))
	event.crystal_entered.connect(state_machine.bind(crystal_entered))
	event.crystal_exited.connect (state_machine.bind(crystal_exited))
	event.crystal_created.connect(state_machine.bind(crystal_created))
	event.crystal_broken.connect (state_machine.bind(crystal_broken))


func state_machine(entity, caller):
	match state:
		idle:
			match caller:
				character_moved:
					show_range(entity)
					state = character_moved

				crystal_entered:
					reset()
					show_range(entity)
					state = crystal_entered

		character_moved:
			match caller:
				crystal_created:
					reset()
					state = idle

		crystal_entered:
			match caller:
				crystal_exited:
					reset()
					state = idle

	match caller:
		crystal_broken:
			reset()
			state = idle


func show_range(entity):
	for tile in battle.get_range(entity):
		event.tile_targeted.emit(tile)


func reset():
	for tile in get_tree().get_nodes_in_group('tiles'):
		event.tile_untargeted.emit(tile)
