extends Node

@onready var root: Node = $'../..'
@onready var highlight: Sprite2D = $"../../visuals/sprites/highlight"

enum {idle,
	  entered,
	  exited}

var state: int = idle


func _ready():
	event.tile_entered.connect(state_machine.bind(entered))
	event.tile_exited.connect (state_machine.bind(exited))


func state_machine(entity, caller):
	if entity == root:
		match state:
			idle:
				match caller:
					entered:
						highlight.visible = true
						state = entered

			entered:
				match caller:
					exited:
						highlight.visible = false
						state = idle
