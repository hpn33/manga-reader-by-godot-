extends VBoxContainer
class_name ActionHolder


onready var label = $MarginContainer2/Label


var color_panel

var type := ''

var old_color := []
var new_color := []


func undo():
	
	if type == 'active':
		color_panel.active_color(old_color, false)
	
	elif type == 'create':
		color_panel.delete_color(new_color, false)
	
	elif type == 'delete':
		color_panel.create_color(old_color, false)
	
	elif type == 'update':
		color_panel.update_color(old_color, false)
	
	
	queue_free()



func action(_type, _color_panel, _old_color = [], _new_color = []):
	type = _type
	color_panel = _color_panel
	
	old_color = _old_color
	new_color = _new_color


func active(_color_panel, _old_color, _new_color):
	action('active', _color_panel, _old_color, _new_color)
	
#	text = "%s->%s\n%s->%s" % [old_color[0], new_color[0], old_color[1], new_color[1]]
#	label.text = "active %s" % [new_color[0]]
	label.text = "act: %s" % [new_color[0]]


func create(_color_panel, _new_color):
	action('create', _color_panel, [], _new_color)
	
#	text = "create\n%s = %s" % [new_color[0], new_color[1]]
#	label.text = "create %s" % [new_color[0]]
	label.text = "crt: %s" % [new_color[0]]


func delete(_color_panel, _old_color):
	action('delete', _color_panel, _old_color)
	
#	text = "delete\n%s = %s" % [old_color[0], old_color[1]]
#	label.text = "delete %s" % [old_color[0]]
	label.text = "del: %s" % [old_color[0]]


func rewrite(_color_panel, _old_color, _new_color):
	action('update', _color_panel, _old_color, _new_color)
	
#	text = "rewrite %s\n%s -> %s" % [old_color[0], old_color[0], new_color[1]]
#	label.text = "update %s" % [old_color[0]]
	label.text = "upd: %s" % [old_color[0]]

