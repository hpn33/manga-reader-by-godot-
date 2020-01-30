extends PopupPanel

signal color_changed(color)

onready var color_list :ColorList= $HBoxContainer/ColorList
onready var color_picker = $HBoxContainer/VBoxContainer/ColorPicker
onready var title = $HBoxContainer/VBoxContainer/HBoxContainer/Title


var colors = [
	['c1', '1a1a1a'],
	['c2','1a1abb'],
	['c3','cc1a1a']
]


#func _ready():
#	popup()


func _on_ColorPicker_color_changed(color: Color) -> void:
	emit_signal("color_changed", color)


func set_color(_color):
	title.text = _color[0]
	
	var color = Color('#' + _color[1]) 
	color_picker.color = color
	emit_signal("color_changed", color)



func _on_Edit_pressed() -> void:
	var done = false
	
	var tit = title.text
	var color = color_picker.color.to_html()
	
	for i in colors.size():
		if colors[i][0] == tit:
			colors[i][1] = color
			done = true
			# update color
			color_list.up_item(tit, color)
			break
	
	if not done:
		# set new color
		var new_color = [tit, color]
		colors.append(new_color)
		color_list.add(new_color)
		

