extends Node


onready var camera = $Camera2D
onready var background = $background
onready var ui = $UI



func _ready() -> void:
	config.init()
	config.load()


func fix_background():
	background.fix_by_camera(camera)





