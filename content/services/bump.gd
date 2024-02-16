extends Node

signal bump

func _ready():
	messenger.connect('selected', check_coordinates)

func check_coordinates(node):
	messenger.emit_signal('bump', node.coordinates)
