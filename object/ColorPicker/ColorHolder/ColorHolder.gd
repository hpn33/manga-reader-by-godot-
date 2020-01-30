extends Control

onready var color_view = $hBox/Color
onready var label = $hBox/Label

func set_(color):
	set_title(color[0])
	set_color(color[1])


var title := 'title' setget set_title, get_title

func set_title(_title: String):
	title = _title
	label.text = _title

func get_title():
	return label.text


func set_color(color_code:String):
	color_view.color = Color('#' + color_code)

