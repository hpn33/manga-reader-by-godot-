extends Node


onready var camera = $Camera2D
onready var background = $background
onready var ui = $UI


func fix_background():
	background.fix_by_camera(camera)
