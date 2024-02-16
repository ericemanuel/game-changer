extends Node

var state: bool = false
@onready var root: Node = $'../../'
@onready var animation: AnimationPlayer = $'../../content/animation'

func _ready():
	messenger.connect('bump', bump)

func bump(coordinates):
	if root.coordinates == coordinates:
		match state:
			false:
				animation.queue("bump")
				state = true

			true:
				animation.play_backwards("bump")
				state = false

	else:
		match state:
			true:
				animation.play_backwards("bump")
				state = false
