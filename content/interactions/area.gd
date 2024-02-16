extends TextureButton

@onready var root: Node = $'../../'

func _button_down():
	if Input.is_action_pressed('left_click'):
		messenger.emit_signal('selected', root)

func _mouse_entered():
	messenger.emit_signal('entered', root)
func _mouse_exited():
	messenger.emit_signal('exited', root)
