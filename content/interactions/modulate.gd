extends Node

var state: bool = false
@onready var root: Node = $'../../'

func _ready():
	messenger.connect('modulate', modulate)

func modulate(node):
	if node == root:
		match state:
			false:
				root.modulate = Color(1.2, 1.2, 1.2)
				state = true

			true:
				root.modulate = Color(1,1,1)
				state = false
