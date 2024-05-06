extends Node

@onready var root: Node = $'../..'
@onready var player: AnimationPlayer = $"../../visuals/animation"


func _ready():
	event.crystal_selected.connect(destroy)


func destroy(crystal):
	if crystal == root:
		player.play('break')


func _animation_finished(animation):
	if animation == 'break':
		event.crystal_broken.emit(root)
		player.play('drop')

	if animation == 'drop':
		root.queue_free()
