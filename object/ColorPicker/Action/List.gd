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


