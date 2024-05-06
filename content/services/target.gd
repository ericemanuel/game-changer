extends Node

@onready var battle = $".."

enum {idle,
	  entered,
	  exited}

var state: int = idle


func _ready():
	event.crystal_entered.connect(state_machine.bind(entered))
	event.crystal_exited.connect (state_machine.bind(exited))


func state_machine(crystal, caller):
	match state:
		idle:
			match caller:
				entered:
					show_range(crystal)
					state = entered

		entered:
			match caller:
				exited:
					reset()
					state = idle


func show_range(crystal):
	for tile in battle.get_range(crystal):
		event.tile_targeted.emit(tile)


func reset():
	for tile in get_tree().get_nodes_in_group('tiles'):
		event.tile_untargeted.emit(tile)
