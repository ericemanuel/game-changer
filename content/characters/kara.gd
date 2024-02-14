extends Node2D

@export var coordinates: Vector2

func _input_event(_viewport, _event, _shape_idx):
	if Input.is_action_pressed('left_click'):
		messenger.emit_signal('character_selected', self)

func _mouse_entered():
	messenger.emit_signal('character_entered', self)
func _mouse_exited():
	messenger.emit_signal('character_exited', self)

func _ready():
	position.x = 100 + (coordinates.x - coordinates.y) * 16
	position.y = 138 + (coordinates.x + coordinates.y - 2) * 8
