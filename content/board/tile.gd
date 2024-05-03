extends Node2D

@onready var visuals: Node = $visuals

var coordinates: Vector2
@export var weight: int = 1


func _ready():
	@warning_ignore("integer_division")
	coordinates = Vector2(int(name.substr(4))%6 +1,
						  int(name.substr(4))/6 +1)
