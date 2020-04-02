extends Control


var active = false


onready var select = $select

onready var camera = $"../../Camera2D"


func position_perhundred():
	return get_local_mouse_position().y / perhundred()


func perhundred():
	return rect_size.y /100.0


func _process(delta):
	
	if not active:
		return
	
	if Input.is_action_pressed("view_click_mouse"):
		
		select.rect_size.y = perhundred()
		select.rect_position.y = get_local_mouse_position().y
		
		
		camera.goto_persend(position_perhundred())


func _on_scroll_mouse_entered():
	active = true

func _on_scroll_mouse_exited():
	active = false
