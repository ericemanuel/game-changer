extends Node2D

var coordinates: Vector2
@export var movement_cost: int = 1


func _ready():
	@warning_ignore("integer_division")
	coordinates = Vector2(int(name.substr(4))%6 +1,
						  int(name.substr(4))/6 +1)
