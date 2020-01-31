extends PopupPanel

signal color_changed(color)

onready var color_list :ColorList= $HBoxContainer/ColorList
onready var color_picker = $HBoxContainer/VBoxContainer/ColorPicker
onready var title = $HBoxContainer/VBoxContainer/HBoxContainer/Title


var colors := [] #setget , _get_colors


func _ready():
	config.connect("init", self, '_set_config_data')


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
	
	config.set_data('colors', colors)
	config.save()
	print(config.get_data('colors'))


func _set_config_data():
	colors = config.get_data('colors')
	color_list.re_add(colors)

