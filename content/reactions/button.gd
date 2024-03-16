extends TextureButton

@onready var root: Node = $'../../'


func _button_down():
	if Input.is_action_pressed('left_click'):
		interactions.node_selected.emit(root)


func _mouse_entered():
	interactions.node_entered.emit(root)

func _mouse_exited():
	interactions.node_exited.emit(root)
