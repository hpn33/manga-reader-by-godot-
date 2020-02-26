extends VBoxContainer
class_name ActionList


onready var action_holder = preload("res://object/ColorPicker/Action/ActionHolder/ActionHolder.tscn")


func _ready() -> void:
	
	clear()


func clear():
	for i in get_child_count():
		remove_child(get_child(0))


func add() -> ActionHolder:
	var new :ActionHolder= action_holder.instance()
	
	add_child(new)
	
	return new


func active(_old_color, _new_color):
	add().active(owner, _old_color, _new_color)


func create(_new_color):
	add().create(owner, _new_color)


func delete(_old_color):
	add().delete(owner, _old_color)


func rewrite(_old_color, _new_color):
	add().rewrite(owner, _old_color, _new_color)



