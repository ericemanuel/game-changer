extends Node2D

@export var coordinates: Vector2

func _ready():
	position.x = 100 + (coordinates.x - coordinates.y) * 16
	position.y = 138 + (coordinates.x + coordinates.y - 2) * 8
