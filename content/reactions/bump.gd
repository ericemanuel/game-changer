extends Node

@onready var root: Node = $'../..'
@onready var animation: AnimationPlayer = $"../../visuals/animation"

enum {idle,
	  selected,
	  character_moving,
	  character_moved,
	  bumped,
	  hold}

var state: int = idle


func _ready():
	event.tile_selected.connect     (state_machine.bind(selected))
	event.character_selected.connect(state_machine.bind(selected))
	event.character_moving.connect  (state_machine.bind(character_moving))
	event.character_moved.connect   (state_machine.bind(character_moved))


func state_machine(object, caller):
	match caller:
		selected:
			if object == root:
				match state:
					idle:
						animation.queue('bump')
						state = bumped

					bumped:
						animation.play_backwards('bump')
						state = idle

			elif object.coordinates != root.coordinates:
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
