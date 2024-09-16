extends Node

@onready var root: Node = $'../..'
@onready var player: AnimationPlayer = $"../../visuals/animation"


func _ready():
	event.crystal_alt_selected.connect(destroy)
	event.entity_pushed.connect(is_crystal)


func is_crystal(entity):
	for crystal in get_tree().get_nodes_in_group('crystals'):
		if crystal == entity:
			destroy(crystal)
			break

func destroy(crystal):
	if crystal == root:
		player.play('break')


func _animation_finished(animation):
	if animation == 'break':
		event.crystal_broken.emit(root)
		player.play('drop')

	if animation == 'drop':
		root.queue_free()
		root = null
