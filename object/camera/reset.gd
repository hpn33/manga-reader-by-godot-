extends Node

onready var zoom = $'../zoom'


func _input(event):
	if event.is_action_pressed('reset'):
		base_reset()
		owner.position.x = 0
	
	if event.is_action_pressed("full_reset"):
		base_reset()
		owner.position = Vector2()


func base_reset():
	zoom.zoom_target = Vector2.ONE
	owner.zoom = Vector2.ONE
