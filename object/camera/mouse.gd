extends Node


onready var movement = $'../movement'

var pan_speed := 800

var mouse_captured := false



func _input(event):

	if event.is_action_pressed("view_click_mouse"):
		mouse_captured = true

	elif event.is_action_released("view_click_mouse"):
		mouse_captured = false


	if mouse_captured && event is InputEventMouseMotion:

		#like we're grabbing the map
		get_parent().position -= event.relative * get_parent().zoom
		movement.target = get_parent().position
		
		get_parent().position = get_parent().snap_to_limits()
		get_parent().moved()
	






