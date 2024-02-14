extends Node2D

var coordinates: Vector2

func _input_event(_viewport, _event, _shape_idx):
	if Input.is_action_pressed('left_click'):
		messenger.emit_signal('tile_selected', self)

func _mouse_entered():
	messenger.emit_signal('tile_entered', self)
func _mouse_exited():
	messenger.emit_signal('tile_exited', self)

func _ready():
	@warning_ignore("integer_division")
	coordinates = Vector2(int(name.substr(4))%6 +1,
						  int(name.substr(4))/6 +1)
