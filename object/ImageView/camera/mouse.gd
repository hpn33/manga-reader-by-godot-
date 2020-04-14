extends Node


onready var movement = $'../movement'

var mouse_captured := false



func _unhandled_input(event):

	if event.is_action_pressed("view_click_mouse"):
		mouse_captured = true

	elif event.is_action_released("view_click_mouse"):
		mouse_captured = false


	if mouse_captured && event is InputEventMouseMotion:

		#like we're grabbing the view
		
		var pos = get_parent().position - event.relative * get_parent().zoom
		get_parent().set_pos(pos)
	






