extends Control

signal delete

onready var color_view = $hBox/CenterContainer/Color
onready var label = $hBox/Label

func set_(color_title: String, color_code:String):
	set_title(color_title)
	set_color(color_code)


var title setget set_title, get_title

func set_title(_title: String):
	label.text = _title

func get_title():
	return label.text


var color_code setget set_color, get_colour

func set_color(_color_code:String):
	color_view.color = Color('#' + _color_code)

func get_colour():
	return color_view.color.to_html()


func _on_Delete_pressed() -> void:
	emit_signal("delete")
