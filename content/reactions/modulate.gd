extends Node

@onready var root: Node = $'../../'

enum {idle,
	  entered,
	  exited,
	  focused,
	  unfocused,
	  character_moved}

var state: int = idle


func _ready():
	event.tile_entered.connect     (state_machine.bind(entered))
	event.tile_exited.connect      (state_machine.bind(exited))
	event.tile_focused.connect    (state_machine.bind(focused))
	event.tile_unfocused.connect    (state_machine.bind(unfocused))
	event.character_entered.connect(state_machine.bind(entered))
	event.character_exited.connect (state_machine.bind(exited))
	event.character_moved.connect  (state_machine.bind(character_moved))


func state_machine(object, caller):
	if object == root:
		match state:
			idle:
				match caller:
					entered:
						root.modulate = Color(1.2, 1.2, 1.2)
						state = entered

					focused:
						root.modulate = Color(1.2, 1.2, 1.2)
						state = focused

			entered:
				match caller:
					exited:
						root.modulate = Color(1,1,1)
						state = idle

			focused:
				match caller:
					unfocused:
						root.modulate = Color(1,1,1)
						state = idle
