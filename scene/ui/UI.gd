extends CanvasLayer

onready var color_picker = $PopMenu/ColorPicker
onready var info_panel = $PopMenu/InfoPanel
onready var file_dialog = $PopMenu/FileDialog
onready var file_menu = $PopMenu/FileMenu

onready var title_bar = $TitleBar
onready var info = $info





func open_options():
	color_picker.popup_centered()


func open_info():
	info_panel.popup_centered()


func open_file_dialog():
	file_dialog.popup_centered()


func open_file_menu():
	file_menu.popup_centered()
