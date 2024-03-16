extends Node2D

@export var coordinates: Vector2
@export var movement_points: int = 4


func _ready():
	position.x = 100 + (coordinates.x - coordinates.y) * 16
	position.y = 140 + (coordinates.x + coordinates.y - 2) * 8
