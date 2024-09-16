extends Node

@onready var root: Node = $'../..'
@onready var player: AnimationPlayer = $"../../visuals/animation"

enum {idle,
	  lock,
	  selected,
	  character_moving,
	  character_moved,
	  bumped,
	  hold}

var state: int = idle


func _ready():
	event.tile_selected.connect     (state_machine.bind(selected))
	event.character_selected.connect(state_machine.bind(selected))
	event.crystal_selected.connect  (state_machine.bind(selected))
	event.character_moving.connect  (state_machine.bind(character_moving))
	event.character_moved.connect   (state_machine.bind(character_moved))


func state_machine(entity, caller):
	match caller:
		selected:
			if entity == root:
				match state:
					idle:
						player.play('bump')
						state = bumped

					bumped:
						player.play_backwards('bump')
						state = idle

			elif entity.coordinates != root.coordinates:
				match state:
					bumped:
						player.play_backwards('bump')
						state = idle

		character_moving:
			match state:
				bumped:
					player.play_backwards('bump')
			state = hold

		character_moved:
			state = idle
