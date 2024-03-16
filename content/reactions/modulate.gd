extends Node

@onready var root: Node = $'../../'


func _ready():
	events.tile_entered.connect     (modulate)
	events.character_entered.connect(modulate)
	events.tile_exited.connect      (unmodulate)
	events.character_exited.connect (unmodulate)


func modulate(node):
	if node == root:
		root.modulate = Color(1.2, 1.2, 1.2)

func unmodulate(node):
	if node == root:
		root.modulate = Color(1,1,1)
