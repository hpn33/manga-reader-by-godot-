extends CanvasLayer

onready var color_picker = $PopMenu/ColorPicker
onready var file_dialog = $PopMenu/FileDialog

onready var title_bar = $TitleBar
onready var info = $info


func _on_ColorPicker_color_changed(color: Color) -> void:
	owner.background.modulate = color


func open_options():
	color_picker.popup_centered()


func open_file_dialog():
	file_dialog.popup_centered()

