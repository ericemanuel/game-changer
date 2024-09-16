extends Node

@onready var root: Node = $'../..'

enum {idle,
	  entered,
	  exited,
	  focused,
	  unfocused,
	  targeted,
	  untargeted}

var state: int = idle


func _ready():
	event.tile_entered.connect       (state_machine.bind(entered))
	event.tile_exited.connect        (state_machine.bind(exited))
	event.tile_focused.connect       (state_machine.bind(focused))
	event.tile_unfocused.connect     (state_machine.bind(unfocused))
	event.tile_targeted.connect      (state_machine.bind(targeted))
	event.tile_untargeted.connect    (state_machine.bind(untargeted))

	event.character_entered.connect  (state_machine.bind(entered))
	event.character_exited.connect   (state_machine.bind(exited))
	event.character_focused.connect  (state_machine.bind(focused))
	event.character_unfocused.connect(state_machine.bind(unfocused))


func state_machine(entity, caller):
	if entity == root:
		match state:
			idle:
				match caller:
					entered:
						for character in get_tree().get_nodes_in_group('characters'):
							if character.coordinates == root.coordinates:
								root.modulate = Color(1.15, 1.15, 1.15)
								state = entered

					focused:
						root.modulate = Color(1.15, 1.15, 1.15)
						state = focused

					targeted:
						root.modulate = Color(3, 1, 1)
						state = targeted

			entered:
				match caller:
					exited:
						reset()
						state = idle

			focused:
				match caller:
					unfocused:
						reset()
						state = idle

			targeted:
				match caller:
					untargeted:
						reset()
						state = idle


func reset():
	root.modulate = Color(1,1,1)
