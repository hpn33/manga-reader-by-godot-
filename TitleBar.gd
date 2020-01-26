extends Control

var following := false
var draging_start_position = Vector2()


func _on_TitleBar_gui_input(event: InputEvent) -> void:
	
	if event is InputEventMouseButton:
		if event.get_button_index() == 1:
			following = !following
			draging_start_position = get_local_mouse_position()
	

func _process(delta: float) -> void:
	if following:
		OS.window_position = OS.window_position + get_local_mouse_position() - draging_start_position
		


func _on_minimaiz_pressed() -> void:
	OS.window_minimized = true


func _on_quit_pressed() -> void:
	get_tree().quit()
	


func _on_Options_pressed() -> void:
	$'..'.open_options()


func _on_maximize_pressed() -> void:
	OS.window_maximized = !OS.window_maximized
	owner.fix_background()
