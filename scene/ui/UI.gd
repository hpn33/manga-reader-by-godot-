extends CanvasLayer

onready var color_picker = $PopMenu/ColorPicker
onready var sort_panel = $PopMenu/SortPanel
onready var file_dialog = $PopMenu/FileDialog

onready var title_bar = $TitleBar
onready var info = $info



func open_options():
	color_picker.popup_centered()


func open_sort():
	sort_panel.popup_centered()


func open_file_dialog():
	file_dialog.popup_centered()

