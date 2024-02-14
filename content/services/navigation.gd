extends Node

#@onready
#var board: Node = $"../../board/content"
#
#enum {idle,
	  #character_selected,
	  #tile_selected,
	  #character_moving
	#}
	#
#var current_state: int = idle
#var selected_character: Node
#
#
#func _ready():
	#messenger.connect('character_selected',
					  #machine_state
					  #.bind(character_selected))
#
	#messenger.connect('tile_selected',
					  #machine_state
					  #.bind(tile_selected))
	#
	#
#func machine_state(content, event):
	#match current_state:
#
		#idle:
			#match event:
				#character_selected:
					#selected_character = content
					#current_state = character_selected
#
		#character_selected:
			#match event:
				#tile_selected:
					#selected_character.coordinates = content.coordinates
					#selected_character.global_position = content.global_position
					#current_state = idle
