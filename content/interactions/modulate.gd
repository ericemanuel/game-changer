extends Node

var state: bool = false
@onready var animation = $"../../content/animation"

func modulate():
	match state:
		false:
			animation.queue('modulate')
			state = true

		true:
			animation.queue('modulate_backwards')
			state = false
