extends TextureButton

@onready var root: Node = $'..'


func _button_down():
	if Input.is_action_pressed('left_click'):
		hardware.node_selected.emit(root)

	elif Input.is_action_pressed('right_click'):
		hardware.node_alt_selected.emit(root)

func _mouse_entered():
	hardware.node_entered.emit(root)

func _mouse_exited():
	hardware.node_exited.emit(root)
