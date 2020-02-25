extends Node


onready var camera = $Camera2D
onready var background = $background
onready var ui = $UI



func _ready() -> void:
	config.init()
#	config.rebuild()
	config.load()
	
	share.set_value('target_dir', 'choise image folder')
	share.set_value('background_color', config.get_data('active_color'))
	share.set_value('colors', config.get_data('colors'))
	share.set_value('recents', config.get_data('recents'))


func fix_background():
	background.fix_by_camera(camera)





