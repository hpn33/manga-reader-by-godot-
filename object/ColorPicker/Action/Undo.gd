extends Button

onready var list = $'../List'


func _on_Undo_pressed():
	var size = list.get_child_count()
	
	if size > 0:
		list.get_child(size-1).undo()

