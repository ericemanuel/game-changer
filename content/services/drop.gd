extends Node

@onready var root: Node = $'../..'
@onready var player: AnimationPlayer = $"../../visuals/animation"


func _ready():
	event.character_dropping.connect(drop)


func drop(character):
	if character == root:
		root.z_index -= 4
		player.play('drop')


func _animation_finished(animation):
	if animation == 'drop':
		#root.queue_free()
		pass
