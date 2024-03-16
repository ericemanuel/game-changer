extends Node

@onready var root: Node = $'../../'
@onready var animation: AnimationPlayer = $"../../body/animation"

enum {idle,
	  selected,
	  character_moving,
	  character_moved,
	  bumped,
	  hold}

var state: int = idle


func _ready():
	events.tile_selected.connect     (state_machine.bind(selected))
	events.character_selected.connect(state_machine.bind(selected))
	states.character_moving.connect  (state_machine.bind(character_moving))
	feedbacks.character_moved.connect(state_machine.bind(character_moved))


func state_machine(node, caller):
	match caller:
		selected:
			if node == root:
				match state:
					idle:
						animation.queue('bump')
						state = bumped

					bumped:
						animation.play_backwards('bump')
						state = idle

			elif node.coordinates != root.coordinates:
				match state:
					bumped:
						animation.play_backwards('bump')
						state = idle

		character_moving:
			match state:
				bumped:
					animation.play_backwards('bump')
			state = hold

		character_moved:
			state = idle
