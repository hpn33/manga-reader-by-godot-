extends Node

onready var zoom = $'../zoom'
onready var movement = $'../movement'


func _unhandled_input(event):
	
	if event.is_action_pressed('reset'):
		zoom.reset()
		movement.reset_x()
	
	if event.is_action_pressed("full_reset"):
		zoom.reset()
		movement.reset()
	
