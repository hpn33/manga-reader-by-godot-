extends PopupPanel

#signal color_changed(color)

onready var color_picker :ColorPicker= $HBoxContainer/ColorPicker

onready var color_list :ColorList= $HBoxContainer/Colors/List
onready var color_title :LineEdit= $HBoxContainer/Colors/Edit/Title
onready var color_btn :Button= $HBoxContainer/Colors/Edit/Btn

onready var action_list :VBoxContainer= $HBoxContainer/Actions/List
onready var action_undo :Button= $HBoxContainer/Actions/Undo





var color_name := '' setget set_color_name, get_color_name

func set_color_name(value: String) -> void:
	color_title.text = value
#	color_btn.check_title()
	

func get_color_name():
	return color_title.text



var color_code := '' setget set_color_code, get_color_code

func set_color_code(value):
	color_picker.color = Color('#' + value) 

func get_color_code():
	return color_picker.color.to_html()


var colors := GMap.new()

var current_color_title := 'None'
var current_color_code := 'ccc'


func _ready():
	share.add_hook('colors', self, '_colors_changed')
	
	color_btn.disabled = true
	
	set_active_color()

func set_active_color():
	yield(owner, "ready")
	var active_color_name = config.get_data('active_color')
	
	
	var color := []
	
	
	if colors.can_find(active_color_name):
		color = [active_color_name, colors.get(active_color_name)]
	else:
		color = colors.first()
	
	
	active_color(color, false)


func set_color(_color):
	self.color_name = _color[0]
	self.color_code = _color[1]


func _on_Edit_pressed() -> void:
	var done = false
	
	var title = self.color_name
	var code = self.color_code
	
	for color in colors.to_iterator():
		if color[0] == title:
			color[1] = code
			done = true
			# update color
			update_color([title, code])
			break
	
	if not done:
		# set new color
		create_color([title, code])
	
	save_colors()



func _colors_changed(value):
	colors.from_iterator(value)
	color_list.re_add(colors)


func set_current_color(_color_title, _color_code, add_action):
	
	var old_color = [current_color_title, current_color_code]
	
	current_color_title = _color_title
	current_color_code = _color_code
	
	var new_color = [current_color_title, current_color_code]
	
	self.color_name = _color_title
	self.color_code = _color_code
	
	check_button_title()
	
	if add_action:
		action_list.active(old_color, new_color)
	
	config.set_data('active_color', current_color_title)
	config.save()
	
	set_background(_color_code)


func check_button_title():
	
	color_btn.disabled = (self.color_name == '')
	
	if self.color_name == current_color_title:
		color_btn.text = 'edit'
	else:
		color_btn.text = 'create'





func active_color(_color, add_action := true):
	set_current_color(_color[0], _color[1], add_action)


func create_color(_color, add_action := true):
	
	colors.append(_color[0], _color[1])
	
	
	if add_action:
		action_list.create(_color)
	
	set_current_color(_color[0], _color[1], add_action)
	
	save_colors()
	
	color_list.re_add()
	
	check_button_title()


func delete_color(_color, add_action := true):
	
	for color in colors.to_iterator():
		if color[0] == _color[0]:
			colors.remove(color[0])
			break
	
	if add_action:
		action_list.delete(_color)
	
	
	save_colors()
	
	color_list.re_add()
	
	color_title.text = ''
	check_button_title()


func update_color(_color, add_action := true):
	
	colors.set(_color[0], _color[1])
	
	
	if add_action:
		var old_color = [current_color_title, current_color_code]
		
		action_list.rewrite(old_color, _color)
	
	set_current_color(_color[0], _color[1], add_action)
	
	save_colors()
	
	color_list.re_add()
	
	check_button_title()






func save_colors():
	config.set_data('colors', colors.to_iterator())
	config.save()


func _on_ColorPicker_color_changed(color: Color) -> void:
	set_background(color.to_html())


func set_background(_color_code):
	VisualServer.set_default_clear_color(Color('#' + _color_code))

