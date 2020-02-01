extends Node


onready var camera = $Camera2D
onready var background = $background
onready var ui = $UI



func _ready() -> void:
	config.init()
	config.load()
	
	share.set_value('path', '')
	share.set_value('colors', config.get_data('colors'))
	share.set_value('recents', config.get_data('recents'))


func fix_background():
	background.fix_by_camera(camera)





