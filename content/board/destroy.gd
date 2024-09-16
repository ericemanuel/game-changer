extends Node

@onready var root: Node = $'../..'
@onready var player: AnimationPlayer = $"../../visuals/animation"


func _ready():
	event.crystal_broken.connect(destroy)


func destroy(crystal):
	if crystal.coordinates == root.coordinates:
		player.play('drop')


func _animation_finished(animation):
	if animation == 'drop':
		root.visible = false
