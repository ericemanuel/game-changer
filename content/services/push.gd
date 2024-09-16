extends Node

@onready var battle = $".."
const SPEED: float = .28

enum {idle,
	  crystal_pushing}

var state: int = idle
var Targets: Array
var Destinations: Array
var movement_counter: int = 0
var target_counter: int = 0
var pushed_entities: Array


func _ready():
	event.crystal_alt_selected.connect(find_targets)
	#event.entity_pushed.connect(is_crystal)


func is_crystal(entity):
	for crystal in get_tree().get_nodes_in_group('crystals'):
		if crystal == entity:
			find_targets(crystal)
			break


func find_targets(crystal):
	var targets: Array = []
	battle.reset() #rever essa linha

	for tile in battle.get_range(crystal):
		for entity in get_tree().get_nodes_in_group('entities'):
			if entity.coordinates == tile.coordinates and entity != crystal:
				targets.append(entity)

	arrange_targets(crystal, targets)


func arrange_targets(crystal, targets):
	var arrangement: Array = []

	for reach in range(crystal.reach, 0, -1):
		for target in targets:
			if abs(target.coordinates.x - crystal.coordinates.x) == reach or \
			   abs(target.coordinates.y - crystal.coordinates.y) == reach:
				arrangement.append(target)

	calculate_destinations(crystal, arrangement)


func calculate_destinations(crystal, targets):
	var destinations: Array = []
	var destination: Vector2 = Vector2()

	for target in targets:
		if target.coordinates.x == crystal.coordinates.x:
			destination.y = crystal.coordinates.y + crystal.reach                \
							* sign(target.coordinates.y - crystal.coordinates.y) \
							+ sign(target.coordinates.y - crystal.coordinates.y)
			destination.x = target.coordinates.x

		else:
			destination.x = crystal.coordinates.x + crystal.reach                \
							* sign(target.coordinates.x - crystal.coordinates.x) \
							+ sign(target.coordinates.x - crystal.coordinates.x)
			destination.y = target.coordinates.y

		for check in range(crystal.reach):
			if not battle.is_solid(destination):
				if not is_chasm(destination):
					battle.set_solid(destination, true)
				battle.set_solid(target.coordinates, false)
				break

			else:
				destination.x += sign(target.coordinates.x - destination.x)
				destination.y += sign(target.coordinates.y - destination.y)

		destinations.append(destination)

	if destinations.size() > 0:
		state = crystal_pushing
		set_values(targets, destinations)
	else:
		reset()


func set_values(targets, destinations):
	Targets = targets
	Destinations = destinations


func _physics_process(_delta):
	match state:
		crystal_pushing:
			push_targets()


func push_targets():
	if is_index_valid(Targets, target_counter):
		if Targets[target_counter] != null:
			var target: Node = Targets[target_counter]
			var destination: Vector2 = Destinations[target_counter]

			if target.coordinates.x < destination.x:
				if movement_counter < (8 / SPEED):
					target.position.x += 2 * SPEED
					target.position.y += 1 * SPEED
					movement_counter += 1
				else:
					target.coordinates.x += 1
					target.z_index += 2
					movement_counter = 0

			elif target.coordinates.x > destination.x:
				if movement_counter < (8 / SPEED):
					target.position.x -= 2 * SPEED
					target.position.y -= 1 * SPEED
					movement_counter += 1
				else:
					target.coordinates.x -= 1
					target.z_index -= 2
					movement_counter = 0

			elif target.coordinates.y < destination.y:
				if movement_counter < (8 / SPEED):
					target.position.x -= 2 * SPEED
					target.position.y += 1 * SPEED
					movement_counter += 1
				else:
					target.coordinates.y += 1
					target.z_index += 2
					movement_counter = 0

			elif target.coordinates.y > destination.y:
				if movement_counter < (8 / SPEED):
					target.position.x += 2 * SPEED
					target.position.y -= 1 * SPEED
					movement_counter += 1
				else:
					target.coordinates.y -= 1
					target.z_index -= 2
					movement_counter = 0

			else:
				target_counter += 1
				pushed_entities.append(target)
				event.entity_pushed.emit(target)

			if is_chasm(target.coordinates):
				event.entity_dropping.emit(target)
				target_counter += 1

			if target_counter >= Targets.size():
				reset()
				state = idle

				for entity in pushed_entities:
					is_crystal(entity)

	else:
		target_counter = 0


func is_index_valid(array, index) -> bool:
	return index >= 0 && index < array.size()


func is_chasm(coordinates) -> bool:
	for tile in get_tree().get_nodes_in_group('tiles'):
		if tile.coordinates == coordinates and tile.is_visible():
			return false
	return true


func reset():
	Targets.clear()
	Destinations.clear()
	target_counter = 0
	battle.reset()
