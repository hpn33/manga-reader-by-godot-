extends PopupPanel

signal color_changed(color)

onready var color_picker :ColorPicker= $HBoxContainer/ColorPicker

onready var color_list :ColorList= $HBoxContainer/Colors/List
onready var color_title :LineEdit= $HBoxContainer/Colors/Edit/Title
onready var color_edit :Button= $HBoxContainer/Colors/Edit/Btn

onready var action_list :VBoxContainer= $HBoxContainer/Actions/List
onready var action_undo :Button= $HBoxContainer/Actions/Undo





var color_name := '' setget set_color_name, get_color_name

func set_color_name(value: String) -> void:
	color_title.text = value

func get_color_name():
	return color_title.text



var color_code := '' setget set_color_code, get_color_code

func set_color_code(value):
	color_picker.color = Color('#' + value) 

func get_color_code():
	return color_picker.color.to_html()


var colors := []


func _ready():
	share.add_hook('colors', self, '_colors_changed')



func set_color(_color):
	self.color_name = _color[0]
	self.color_code = _color[1]


func _on_Edit_pressed() -> void:
	var done = false
	
	var title = self.color_name
	var code = self.color_code
	
	for i in colors.size():
		if colors[i][0] == title:
			colors[i][1] = code
			done = true
			# update color
			color_list.update_item(title, code)
			break
	
	if not done:
		# set new color
		var new_color = [title, code]
		colors.append(new_color)
		color_list.add(new_color)

	config.set_data('colors', colors)
	config.save()


func _colors_changed(value):
	colors = value
	color_list.re_add(colors)


func active_color():
	pass

func delete_color(color_name: String):
	pass

#func update_color(color_name: String, new_color_code: String):
#	pass

func create_color(color_name: String, color_code: String):
	pass



func _on_ColorPicker_color_changed(color: Color) -> void:
	share.set_value('background_color', color.to_html())
