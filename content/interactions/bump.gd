extends Node

var state: bool = false
@onready var animation = $"../../content/animation"

func bump():
	match state:
		false:
			animation.queue('bump')
			state = true

		true:
			animation.queue('bump_backwards')
			state = false
