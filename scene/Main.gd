extends Node


onready var camera = $'ImageView/Camera2D'
onready var ui = $UI
onready var image_view = $ImageView 

#   ُTODO = dfjksjfjj
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



func _on_Clear_pressed():
	image_view.clear()
