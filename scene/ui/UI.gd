extends CanvasLayer

onready var color_picker = $ColorPicker
onready var file_dialog = $FileDialog

onready var title_bar = $TitleBar
onready var info = $info


#func _unhandled_input(event: InputEvent) -> void:
#	if event.is_action_pressed("ui_focus_next"):
#		open_options()


func _on_ColorPicker_color_changed(color: Color) -> void:
	owner.background.modulate = color


func open_options():
	color_picker.popup_centered()


func open_file_dialog():
	file_dialog.popup_centered()

