extends VBoxContainer
class_name ActionList


onready var action_holder = preload("res://object/ColorPicker/Action/ActionHolder/ActionHolder.tscn")


func _ready() -> void:
	
	clear()


func clear():
	for i in get_child_count():
		remove_child(get_child(0))


func add():
	var new :Label= action_holder.instance()
	
	add_child(new)
	
	return new


func active(_old_color, _new_color):
	var new = add()
	
	new.active(owner, _old_color, _new_color)




#func add_by_array(colors: Array):
#	for color in colors:
#		add(color)


#func update_item(title, color_code):
#	for i in get_child_count():
#		var child = get_child(i)
#		if title == child.title:
#			child.set_color(color_code)
#			break


#func _holder_pressed(color):
#	owner.set_current_color(color[0], color[1])
#
#
#
#func _delete_button(target):
#	for i in owner.colors.size():
#		var color = owner.colors[i]
#		if color[0] == target.title:
#			owner.colors.remove(i)
#			break
#
#	owner.save_colors()
	
#	re_add()


#func re_add(colors: Array = owner.colors):
#	clear()
#	add_by_array(colors)
