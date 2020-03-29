extends Node


onready var camera = $Camera2D
onready var ui = $UI
onready var image_place = $ImagePlace

#   ُTODO= dfjksjfjj
# warning: sfd

"""

TODO
todo
todos

"""


func _ready() -> void:
	if not config.init() == OK:
		print('can\'t loaded global config file ')
		return
	
#	config.rebuild()
#	config.load()
	
	share.set_value('target_dir', 'choise image folder')
	share.set_value('colors', config.get_data('colors'))
	share.set_value('recents', config.get_data('recents'))
	

