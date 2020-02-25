extends Control


onready var color_view = $hBox/CenterContainer/Color
onready var label = $hBox/Label


var color_panel


func set_(_color_panel, color):
	color_panel = _color_panel
	
	self.title = color[0]
	self.color_code = color[1]


var title setget set_title, get_title

func set_title(_title: String):
	label.text = _title

func get_title():
	return label.text


var color_code setget set_color_code, get_color_code

func set_color_code(_color_code:String):
	color_view.color = Color('#' + _color_code)

func get_color_code():
	return color_view.color.to_html()


var color setget , get_colour

func get_colour():
	return [self.title, self.color_code]




func _on_Delete_pressed() -> void:
	color_panel.delete_color([self.title, self.color_code])

func _on_ColorHolder_pressed():
	color_panel.active_color([self.title, self.color_code])
