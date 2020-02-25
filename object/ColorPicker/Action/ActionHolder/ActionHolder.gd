extends Label


var color_panel

var type := ''

var old_color := []
var new_color := []


func undo():
	
	if type == 'active':
		color_panel.set_current_color(old_color[0], old_color[1], false)
	
	
	queue_free()



func active(_color_panel, _old_color, _new_color):
	type = 'active'
	color_panel = _color_panel
	
	old_color = _old_color
	new_color = _new_color
	
	text = "%s->%s\n%s->%s" % [old_color[0], new_color[0], old_color[1], new_color[1]]

