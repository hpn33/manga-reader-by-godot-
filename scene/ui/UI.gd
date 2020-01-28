extends CanvasLayer

onready var popup = $Popup
onready var file_dialog = $FileDialog
onready var title_bar = $TitleBar
onready var info = $info
onready var background = $"../background"

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_focus_next"):
		open_options()



func _on_ColorPicker_color_changed(color: Color) -> void:
	background.modulate = color
	


func _on_FileDialog_popup_hide() -> void:
	popup.hide()


func open_options():
	popup.popup()
	file_dialog.popup()


func pop_file_dialog():
	file_dialog.popup_centered()

