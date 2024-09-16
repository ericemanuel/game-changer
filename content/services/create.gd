extends Node

var crystal: Resource = load('res://content/crystals/crystal.tscn')
@onready var battle = $".."
@onready var crystals: Node = $"../../../crystals"

enum {idle,
	  character_moved,
	  tile_selected,
	  tile_alt_selected,
	  crystal_alt_selected
	 }

var state: int = idle
var Character: Node
var Tile: Node


func _ready():
	event.character_moved.connect     (state_machine.bind(character_moved))
	event.tile_selected.connect       (state_machine.bind(tile_selected))
	event.tile_alt_selected.connect   (state_machine.bind(tile_alt_selected))
	event.crystal_alt_selected.connect(state_machine.bind(crystal_alt_selected))


func state_machine(entity, caller):
	match caller:
		character_moved:
			Character = entity
			state = character_moved

		tile_selected:
			match state:
				character_moved:
					Tile = entity
					battle.reset()

					if Tile in battle.get_range(Character):
						if not battle.is_solid(Tile.coordinates):
							create_crystal(Tile)
							state = idle

		tile_alt_selected:
			Tile = entity
			create_crystal(Tile)

		crystal_alt_selected:
			state = idle


func create_crystal(tile):
	var instance: Node = crystal.instantiate()

	instance.coordinates = tile.coordinates
	crystals.add_child(instance)
	event.crystal_created.emit(instance)
